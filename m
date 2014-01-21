From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [RFC] can fd: backward compatibility for CANFD8
Date: Tue, 21 Jan 2014 11:22:11 +0100
Message-ID: <52DE4A53.9080503@hartkopp.net>
References: <52D6CB48.9010206@hartkopp.net> <52D8DF40.7050405@peak-system.com> <52DABB28.4070608@hartkopp.net> <52DE32FD.5010300@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:13615 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754500AbaAUKWS (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 21 Jan 2014 05:22:18 -0500
In-Reply-To: <52DE32FD.5010300@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 21.01.2014 09:42, Stephane Grosjean wrote:
> Le 18/01/2014 18:34, Oliver Hartkopp a =C3=A9crit :

>> The stuff in linux/net/can/ takes care that only applications that k=
now (and
>> enable) CAN FD get CAN frames with a length > 8 byte.
>>
>> E.g. today a CAN FD frame with only 8 bytes (aka CANFD8) can be pass=
ed to
>> applications that are not CAN FD capable. In this case the size (MTU=
)
>> is reduced from CANFD_MTU to CAN_MTU, see:
>>
>> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commi=
t/net/can/raw.c?id=3De2d265d3b587f5f6f8febc0222aace93302ff0be
>>
>>
>> and
>>
>> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/=
net/can/raw.c#n753
>>
>>
>> This leads IMO to two questions:
>>
>> 1. Is it a good idea to provide CANFD8 frames to legacy applications=
?
>=20
> Well, at first, I didn't very agree with this idea ... But I'm not ab=
le to
> find an example against, so ...
> My first option was to define a new socket option, or using the "dev-=
>mtu"
> field value:
>=20
> If the application sets this option to "on" (or the MTU to 72) so it =
tells the
> CAN core that it is able to receive ANY CANFD frames.

Please distinguish application and configuration.

At configuration time CAN_CTRLMODE_FD can be set by 'root' which leads =
to
CAN_MTU or CANFD_MTU in dev->mtu when the interface is brought 'up'.

The application (e.g. at the CAN_RAW socket) can enable the socket opti=
on

	CAN_RAW_FD_FRAMES,      /* allow CAN FD frames (default:off) */

which means that it is able to cope with CAN frames *and* CAN FD frames=
=2E

A CAN controller which is CAN FD enabled is always able to receive 'leg=
acy'
CAN frames too.

> If the application doesn't set one or the other option, as all existi=
ng
> "legacy" CAN applications does not, well, the CAN core won't give it =
ANY
> incoming CANFD frame, that is, any CAN frame with "skb->len !=3D CAN_=
MTU" if
> "dev->mtu !=3D 72".

When CAN_RAW_FD_FRAMES sockopt is not set, the application does not see=
 CAN FD
frames (CAN_MTU =3D=3D 72).

But currently it might see CANFD8 frames, where the size which is read =
from
the socket is reduced from CANFD_MTU to CAN_MTU.


> Something like
>=20
>  static int canfd_rcv(struct sk_buff *skb, struct net_device *dev,
>                     struct packet_type *pt, struct net_device *orig_d=
ev)
>  {
>          struct canfd_frame *cfd =3D (struct canfd_frame *)skb->data;
>=20
>          if (unlikely(!net_eq(dev_net(dev), &init_net)))
>                  goto drop;
>=20
> +        if (dev->mtu !=3D CANFD_MTU)
> +               goto drop;
> +

IMO that's not relevant fo application, when we test for skb->len !=3D =
CANFD_MTU
some line later.

>          if (WARN_ONCE(dev->type !=3D ARPHRD_CAN ||
>                        skb->len !=3D CANFD_MTU ||
>                        cfd->len > CANFD_MAX_DLEN,
>                        "PF_CAN: dropped non conform CAN FD skbuf: "
>                        "dev type %d, len %d, datalen %d\n",
>                        dev->type, skb->len, cfd->len))
>                  goto drop;
>=20
>          can_receive(skb, dev);
>          return NET_RX_SUCCESS;
>=20
>  drop:
>          kfree_skb(skb);
>          return NET_RX_DROP;
>  }
>=20
> Why trying to be backward compatible at any price?

Today you can enable CAN FD on a per socket basis, depending on your ab=
ility
to cope with CAN FD.

>=20
>> 2. If yes, should the CAN FD controller driver be able to make legac=
y frames
>>     CANDF8 frames to support the higher data bitrate for legacy appl=
ications?
>=20
> Same as above, I have no real arguments against this.
>=20

I'm just not sure, if someone will ever need this ...

Regards,
Oliver

