From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH] usb2can: Add support for USB2CAN interface from 8 devices
Date: Mon, 03 Dec 2012 08:26:04 +0100
Message-ID: <50BC540C.4040800@grandegger.com>
References: <50BB1E8E.10809@universalnet.at> <50BB592B.4030604@grandegger.com> <50BBF5CA.500@universalnet.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:54892 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751014Ab2LCH0T (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 3 Dec 2012 02:26:19 -0500
In-Reply-To: <50BBF5CA.500@universalnet.at>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "krumboeck@universalnet.at" <krumboeck@universalnet.at>
Cc: linux-can@vger.kernel.org, info@gerhard-bertelsmann.de, gediminas@8devices.com

On 12/03/2012 01:43 AM, krumboeck@universalnet.at wrote:
> Am 2012-12-02 14:35, schrieb Wolfgang Grandegger:
>> Hi Bernd,
>>
>> nice to see this driver being pushed mainline. As Oliver already poi=
nted
>> out, there are a few general naming and coding style issues:
>>
>> - The preferred multi line comment styles is:
>>
>>    /*
>>     * A Comment
>>     */
>=20
> The Script checkpatch.pl didn't like this comment style. I'll change =
it
> again.

I'm confused. Could you please show the comment and the checkpatch.pl
message. I hope it does not argue against:

http://lxr.linux.no/#linux+v3.6.8/Documentation/CodingStyle#L446

>>
>> - The patch does not yet apply to David Millers "net-next" GIT tree.
>>    There are problems with Kconfig and Makefile.
>=20
> I assume this is the right command and repository url:
> git clone
> "http://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git"
>=20
>>
>> Could you please show the output of "candump -e any,0:0,#FFFFFFFF" w=
hen
>> the device goes 1) error passive and 2) bus-off. You could provoke
>> these states by 1) sending without connection to the bus or 2)
>> short-circuiting CAN high and low.
>=20
> bek@debian:~/software/socketcan/trunk/can-utils$ ./candump -e
> any,0:0,#FFFFFFFF
>   can0  20000088  [8] 00 00 04 00 00 00 00 01   ERRORFRAME
>         protocol-violation{{bit-stuffing-error}{}}
>         bus-error
>         error-counter-tx-rx{{0}{1}}
>   can0  2000008C  [8] 00 04 00 00 00 00 00 63   ERRORFRAME
>         controller-problem{rx-error-warning}
>         protocol-violation{{}{}}
>         bus-error
>         error-counter-tx-rx{{0}{99}}
>   can0  2000008C  [8] 00 10 00 00 00 00 00 7F   ERRORFRAME
>         controller-problem{rx-error-passive}
>         protocol-violation{{}{}}
>         bus-error
>         error-counter-tx-rx{{0}{127}}

The last two messages just seem to be "controller-problem". You should
drop the "bus-error" and "protocol-violation" bits then.

>   can0  500  [4] 00 01 02 03
>   can0  500  [4] 00 01 02 03
>   can0  500  [4] 00 01 02 03
>   can0  500  [4] 00 01 02 03
>   can0  500  [4] 00 01 02 03
>   can0  500  [4] 00 01 02 03
>   can0  500  [4] 00 01 02 03

These messages should up after reconnecting the cable?

> In my tests I was not able to provoke "bus-off".


Even by short-circuiting CAN high and low while sending messages out to
the bus? This should always work.

> One of the tests from Gerd provoked "bus-off":
>   can0  12345678  [8] 55 55 55 55 33 33 33 33
>   can0  20000088  [8] 00 00 90 00 00 00 10 00   ERRORFRAME

BUSERROR, PROT, PROT_BIT1, PROT_TX

>   can0  2000008C  [8] 00 08 00 00 00 00 68 00   ERRORFRAME

BUSERROR, PROT, CTRL, TX_WARNING

>   can0  2000008C  [8] 00 20 00 00 00 00 88 00   ERRORFRAME

BUSERROR, PROT, CTRL, TX_PASSIVE

>   can0  20000040  [8] 00 00 00 00 00 00 F8 00   ERRORFRAME

BUS-OFF

>> Another question: is it possible to switch off bus-error reporting?
>=20
> No. At least I didn't found anything in the firmware.
>=20
>=20
>>> +
>>> +/* Send data to device */
>>> +static netdev_tx_t usb2can_start_xmit(struct sk_buff *skb,
>>> +                      struct net_device *netdev)
>>> +{
>>> +    struct usb2can *dev =3D netdev_priv(netdev);
>>> +    struct net_device_stats *stats =3D &netdev->stats;
>>> +    struct can_frame *cf =3D (struct can_frame *)skb->data;
>>
>> Is the cast needed?
>=20
> Yes.
>=20
>>
>> The driver does collect similar statistics and therefore I do not se=
e a
>> need for these sysfs files... apart from printing the firmware versi=
on
>> when the device is probed. BTW: what is "show_hardware" good for?
>>
>=20
> I don't exactly know, but I assume it is the hardware revision.

OK, I think it shou=F6d be fine if it's printed when the device is prob=
ed.

Wolfgang.

