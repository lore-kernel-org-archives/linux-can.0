From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: [PATCH RFC] can fd: Add separate bittiming infrastructure
Date: Tue, 21 Jan 2014 09:42:37 +0100
Message-ID: <52DE32FD.5010300@peak-system.com>
References: <52D6CB48.9010206@hartkopp.net> <52D8DF40.7050405@peak-system.com>
 <52DABB28.4070608@hartkopp.net>
Reply-To: Stephane Grosjean <s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:40725 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801AbaAUImw (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 21 Jan 2014 03:42:52 -0500
In-Reply-To: <52DABB28.4070608@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Le 18/01/2014 18:34, Oliver Hartkopp a =C3=A9crit :
> Hi Stephane,
>
> On 17.01.2014 08:44, Stephane Grosjean wrote:
>
>>> +#define CAN_CTRLMODE_FD            0x20    /* CAN FD mode */
>> - What is exactly the goal of this new CAN_CTRLMODE_FD please? Did y=
ou define
>> it to allow user to enable the CANFD function into the hardware, for=
 example?
>> If yes, isn't it redundant with setting the MTU to 72 bytes?
>>
>> - Moreover, how a CANFD -able driver has to handle a CANFD frame rea=
d from the
>> CANFD controller, when its network device MTU *ISNOT* =3D=3D 72 ??? =
Should it
>> discard the CANFD frame?
> The stuff in linux/net/can/ takes care that only applications that kn=
ow (and
> enable) CAN FD get CAN frames with a length > 8 byte.
>
> E.g. today a CAN FD frame with only 8 bytes (aka CANFD8) can be passe=
d to
> applications that are not CAN FD capable. In this case the size (MTU)
> is reduced from CANFD_MTU to CAN_MTU, see:
>
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit=
/net/can/raw.c?id=3De2d265d3b587f5f6f8febc0222aace93302ff0be
>
> and
>
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/n=
et/can/raw.c#n753
>
> This leads IMO to two questions:
>
> 1. Is it a good idea to provide CANFD8 frames to legacy applications?

Well, at first, I didn't very agree with this idea ... But I'm not able=
=20
to find an example against, so ...
My first option was to define a new socket option, or using the=20
"dev->mtu" field value:

If the application sets this option to "on" (or the MTU to 72) so it=20
tells the CAN core that it is able to receive ANY CANFD frames.
If the application doesn't set one or the other option, as all existing=
=20
"legacy" CAN applications does not, well, the CAN core won't give it AN=
Y=20
incoming CANFD frame, that is, any CAN frame with "skb->len !=3D CAN_MT=
U"=20
if "dev->mtu !=3D 72". Something like

  static int canfd_rcv(struct sk_buff *skb, struct net_device *dev,
                     struct packet_type *pt, struct net_device *orig_de=
v)
  {
          struct canfd_frame *cfd =3D (struct canfd_frame *)skb->data;

          if (unlikely(!net_eq(dev_net(dev), &init_net)))
                  goto drop;

+        if (dev->mtu !=3D CANFD_MTU)
+               goto drop;
+
          if (WARN_ONCE(dev->type !=3D ARPHRD_CAN ||
                        skb->len !=3D CANFD_MTU ||
                        cfd->len > CANFD_MAX_DLEN,
                        "PF_CAN: dropped non conform CAN FD skbuf: "
                        "dev type %d, len %d, datalen %d\n",
                        dev->type, skb->len, cfd->len))
                  goto drop;

          can_receive(skb, dev);
          return NET_RX_SUCCESS;

  drop:
          kfree_skb(skb);
          return NET_RX_DROP;
  }

Why trying to be backward compatible at any price?

> 2. If yes, should the CAN FD controller driver be able to make legacy=
 frames
>     CANDF8 frames to support the higher data bitrate for legacy appli=
cations?

Same as above, I have no real arguments against this.

> Maybe even the first question has to be denied (and the adaption in c=
an/raw.c
> should be removed then) ?!?
> My idea behind CAN_CTRLMODE_FD is to enable/disable the CAN FD mode i=
n the
> CAN FD capable controller chip.
>
> Depending on this CAN_CTRLMODE_FD the CAN FD functionality is enabled=
 when
> this feature is supported(!) by the driver, see priv->ctrlmode_suppor=
ted:

Ok I agree with the usage of this new flag in "ctrmode_supported".

> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/net/can/dev.c#n669
>
> Depending on CAN_CTRLMODE_FD the MTU is then set to CAN_MTU or CANFD_=
MTU

So? Do you mean that the *CAN core* will set the MTU to CAN_MTU or=20
CANFD_MTU according to "priv->ctrlmode_supported & CAN_CTRLMODE_FD" ?
(Atm, the MTU is changed from user space only).

> (note that the interface has to be 'down' when configuring this featu=
re -
> that's just the same as with configuring the bitrate).
>
> When CAN_CTRLMODE_FD was set but the second bitrate was *not* set bef=
ore the
> interface is requested to be set to 'up' this leads to the same error=
 as if
> the (single and only) bitrate is missing today.

So, this means that the arbitration bitrate could not be the default=20
data bitrate, doesn't it?

> I hope this would be a reasonable solution and I was able to describe=
 it well.
>
> Comming back to question 2 from above, we would then need an addition=
al
> controlmode:
>
> #define CAN_CTRLMODE_TX_FD8 0x40    /* send legacy CAN frames in FD m=
ode */

=2E..
> But I'm not really sure if these two 'compatibility' tweaks for legac=
y
> applications to use CAN FD8 is a wanted/needed feature.
>
> Any thoughts?
>
>>>      /*
>>>     * CAN device statistics
>>> @@ -122,6 +123,9 @@ enum {
>>>        IFLA_CAN_RESTART_MS,
>>>        IFLA_CAN_RESTART,
>>>        IFLA_CAN_BERR_COUNTER,
>>> +    IFLA_CAN_DATA_BITTIMING,
>>> +    IFLA_CAN_DATA_BITTIMING_CONST,
>>> +    IFLA_CAN_DATA_CLOCK,
>>>        __IFLA_CAN_MAX
>>>    };
>> - by defining another clock for the data bitrate, do you suppose tha=
t some
>> hardwares could use different clocks for both arbitration and data b=
itrates?
> Yes. But this is probably not necessary. I just looked into the M_CAN
> specification. They have *one* CAN clock and two different baud rate
> prescalers. So I would tend to remove IFLA_CAN_DATA_CLOCK in the next=
 RFC
> until a real requirement emerges from some real hardware.

Ack

> Best regards,
> Oliver
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
PEAK-System Technik GmbH, Otto-Roehm-Strasse 69, D-64293 Darmstadt=20
Geschaeftsleitung: A.Gach/U.Wilhelm,St.Nr.:007/241/13586 FA Darmstadt=20
HRB-9183 Darmstadt, Ust.IdNr.:DE 202220078, WEE-Reg.-Nr.: DE39305391=20
Tel.+49 (0)6151-817320 / Fax:+49 (0)6151-817329, info@peak-system.com
