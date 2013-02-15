From: =?iso-8859-1?Q?H=E5kan_Engblom?= <H.Engblom@tele-radio.com>
Subject: SV: Fwd: can-utils at
 http://gitorious.org/+linux-can-developers/linux-can/can-utils
Date: Fri, 15 Feb 2013 17:49:18 +0100
Message-ID: <7073D121A5DFE9448648C0E083BEA9C96C7AA632B2@vsrv6.tele-radio.ad>
References: <7073D121A5DFE9448648C0E083BEA9C96C7AA63220@vsrv6.tele-radio.ad>
 <511E1170.6040409@pengutronix.de> <511E5EA3.70804@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.tele-radio.com ([195.10.211.16]:62102 "EHLO mail.smtp.se"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1750967Ab3BORBk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 15 Feb 2013 12:01:40 -0500
In-Reply-To: <511E5EA3.70804@hartkopp.net>
Content-Language: sv-SE
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi,

Yes, the RTR is not recommended, you're right.

In any case it would be nice to have it there as I have a slave that di=
scards remote frames unless the DLC is the same as in the requested dat=
a.=20

To take away the error-check would be fine for me. Is something like th=
is what you mean, just making sure I did not missunderstand you:

	if((cs[idx] =3D=3D 'R') || (cs[idx] =3D=3D 'r')){ /* RTR frame */
		cf->can_id |=3D CAN_RTR_FLAG;
		cf->can_dlc =3D 0;
		if(cs[++idx] && (tmp =3D asc2nibble(cs[idx])) <=3D 0x08) /* 8 is max =
dlc */
			cf->can_dlc =3D tmp;
		return 0;
	}


This would be perfictly fine with me, I've also done a quick test of th=
is, and it seems to work. And it does not give any fault when node addi=
tional length argument is given.

Br H=E5kan Engblom

-----Ursprungligt meddelande-----
=46r=E5n: Oliver Hartkopp [mailto:socketcan@hartkopp.net]=20
Skickat: den 15 februari 2013 17:13
Till: Marc Kleine-Budde; H=E5kan Engblom
Kopia: linux-can@vger.kernel.org
=C4mne: Re: Fwd: can-utils at http://gitorious.org/+linux-can-developer=
s/linux-can/can-utils

Hello Hakan,

On 15.02.2013 11:44, Marc Kleine-Budde wrote:

> let's wait for Oliver to say something to the length. As far as I kno=
w=20
> the canutils already support can-fd, which can send up to 64 bytes. I=
=20
> don't know the standard for sure, but maybe they got rid of the RTR i=
n=20
> canfd.


Yes. CAN FD does not support RTR.


> Anyway, I think I found a small bug in cansend, when sedning Remote=20
> Frames. The syntax is (an example):
>=20
>=20
>=20
> $ cansend can0 181#R
>=20
>=20
>=20
> But according to the standard, the dlc field should be set to how muc=
h=20
> data that is expected in the expected tpdo. So I did the change in th=
e=20
> attached patch, and the syntax now is
>=20
>=20
>=20
> $ cansend can0 181#R8
>=20
>=20
>=20
> to indicate that 8 bytes of process data is expected.
>=20


In general RTR are declared to be bad by several CAN related papers.

The CAN Spec states for RTR frames:

	There is no DATA FIELD, independent of the values of the DATA LENGTH
	CODE which may be signed any value within the admissible range 0...8.
	The value is the DATA LENGTH CODE of the corresponding DATA FRAME.

Which probably contains the problem WHY it is declared to be bad, as yo=
u would need a DLC check in the CAN controller for RTR frames, etc.

Btw. you are right, that RTR frames can contain a DLC value: 0 .. 8 - a=
s CAN FD is not supported anyway.

Looking into the CAN drivers in linux/drivers/net/can it looks like tha=
t no data is copied from the registers in the case of a received RTR fr=
ame. But it also looks like that the can_dlc is set from the controller=
 registers value in a correct way. I need to doublecheck, if really all=
 drivers handle the can_dlc correctly in the case of RTR frames.

E.g. the CC770 handles the RTR frames with some local intelligence, and=
 does not even provide the CAN ID ... and the can_dlc is set to zero in=
 any case:

http://lxr.linux.no/#linux+v3.7.8/drivers/net/can/cc770/cc770.c#L477

In general you idea is ok to support the can_dlc values in CAN 2.0B fra=
mes:

$ cansend can0 181#R8

BUT if we add this can_dlc option for RTR frames, it should be *optiona=
l* to be able to ...

- indicate that the can_dlc was not valid
- be backwards compatible to older log files

The RTR stuff in conjunction with can_dlc is not always consistent.

Would this *optional* can_dlc value approach be fine to you?

> @@ -141,6 +141,9 @@
>         if((cs[idx] =3D=3D 'R') || (cs[idx] =3D=3D 'r')){ /* RTR fram=
e */
>                 cf->can_id |=3D CAN_RTR_FLAG;
> +               if ((tmp =3D asc2nibble(cs[++idx])) > 0x08) /* 8 is m=
ax dlc */
> +                       return 1;


This error condition exit would be too hard for an optional value then.

> +               cf->can_dlc =3D tmp;
>                 return 0;
>         }



Regards,
Oliver

