From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: SV: Fwd: can-utils at http://gitorious.org/+linux-can-developers/linux-can/can-utils
Date: Fri, 15 Feb 2013 18:20:14 +0100
Message-ID: <511E6E4E.4040502@hartkopp.net>
References: <7073D121A5DFE9448648C0E083BEA9C96C7AA63220@vsrv6.tele-radio.ad> <511E1170.6040409@pengutronix.de> <511E5EA3.70804@hartkopp.net> <7073D121A5DFE9448648C0E083BEA9C96C7AA632B2@vsrv6.tele-radio.ad>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:21588 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753521Ab3BORUR (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 15 Feb 2013 12:20:17 -0500
In-Reply-To: <7073D121A5DFE9448648C0E083BEA9C96C7AA632B2@vsrv6.tele-radio.ad>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?ISO-8859-1?Q?H=E5kan_Engblom?= <H.Engblom@tele-radio.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 15.02.2013 17:49, H=E5kan Engblom wrote:

> Yes, the RTR is not recommended, you're right.
>=20
> In any case it would be nice to have it there as I have a slave that =
discards remote frames unless the DLC is the same as in the requested d=
ata.=20
>=20
> To take away the error-check would be fine for me. Is something like =
this what you mean, just making sure I did not missunderstand you:


Yes this is what i also thought of.

>=20
> 	if((cs[idx] =3D=3D 'R') || (cs[idx] =3D=3D 'r')){ /* RTR frame */
> 		cf->can_id |=3D CAN_RTR_FLAG;
> 		cf->can_dlc =3D 0;


This is superfluous, as the struct can_frame is always initialized to z=
ero.
=20

> 		if(cs[++idx] && (tmp =3D asc2nibble(cs[idx])) <=3D 0x08) /* 8 is ma=
x dlc */
> 			cf->can_dlc =3D tmp;


The latest can-utils use struct canfd_frames =3D> 'can_dlc' moved to 'l=
en'

> 		return 0;
> 	}
>=20
>=20
> This would be perfictly fine with me, I've also done a quick test of =
this, and it seems to work. And it does not give any fault when node ad=
ditional length argument is given.


Yep.

I wonder if it makes sense to the length 'len' too, before accessing
cs[++idx] ... but when cs[++idx] is zero your code is correct too.


Here's my suggestion:

If it's ok for you, i can add your Signed-off-by ...

diff --git a/lib.c b/lib.c
index 4857e80..c2baa77 100644
--- a/lib.c
+++ b/lib.c
@@ -169,6 +169,11 @@ int parse_canframe(char *cs, struct canfd_frame *c=
f) {
=20
 	if((cs[idx] =3D=3D 'R') || (cs[idx] =3D=3D 'r')){ /* RTR frame */
 		cf->can_id |=3D CAN_RTR_FLAG;
+
+		/* check for optional DLC value for CAN 2.0B frames */
+		if(cs[++idx] && (tmp =3D asc2nibble(cs[idx])) <=3D CAN_MAX_DLC)
+			cf->len =3D tmp;
+
 		return ret;
 	}
=20
@@ -236,7 +241,11 @@ void sprint_canframe(char *buf , struct canfd_fram=
e *cf, int sep, int maxdlen) {
=20
 	/* standard CAN frames may have RTR enabled. There are no ERR frames =
with RTR */
 	if (maxdlen =3D=3D CAN_MAX_DLEN && cf->can_id & CAN_RTR_FLAG) {
-		sprintf(buf+offset, "R");
+		if (cf->len <=3D CAN_MAX_DLC)
+			sprintf(buf+offset, "R%d", cf->len);
+		else
+			sprintf(buf+offset, "R");
+
 		return;
 	}
=20


Regards,
Oliver
