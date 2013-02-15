From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Fwd: can-utils at http://gitorious.org/+linux-can-developers/linux-can/can-utils
Date: Fri, 15 Feb 2013 11:44:00 +0100
Message-ID: <511E1170.6040409@pengutronix.de>
References: <7073D121A5DFE9448648C0E083BEA9C96C7AA63220@vsrv6.tele-radio.ad>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2QHKREKAKOHMASQMERDXW"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57156 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935716Ab3BOKoI (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 15 Feb 2013 05:44:08 -0500
In-Reply-To: <7073D121A5DFE9448648C0E083BEA9C96C7AA63220@vsrv6.tele-radio.ad>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: H.Engblom@tele-radio.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2QHKREKAKOHMASQMERDXW
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hey H=E5kan,

let's wait for Oliver to say something to the length. As far as I know
the canutils already support can-fd, which can send up to 64 bytes. I
don't know the standard for sure, but maybe they got rid of the RTR in
canfd.

Regarding the mailinglist, it's linux-can@vger.kernel.org (Cc'ed), but
that only accepts text (i.e. non HTML) emails.

regards, Marc

-------- Original Message --------
Subject: 	can-utils at
http://gitorious.org/+linux-can-developers/linux-can/can-utils
Date: 	Fri, 15 Feb 2013 11:07:29 +0100
From: 	H=E5kan Engblom <H.Engblom@tele-radio.com>
To: 	socketcan@hartkopp.net <socketcan@hartkopp.net>, wg@grandegger.com
<wg@grandegger.com>, mkl@pengutronix.de <mkl@pengutronix.de>,
urs@isnogud.escape.de <urs@isnogud.escape.de>



Hi,



Don=92t know if it is OK to write to you directly, but I could not find
any mailing-list or anything else.



Anyway, I think I found a small bug in cansend, when sedning Remote
Frames. The syntax is (an example):



$ cansend can0 181#R



But according to the standard, the dlc field should be set to how much
data that is expected in the expected tpdo. So I did the change in the
attached patch, and the syntax now is



$ cansend can0 181#R8



to indicate that 8 bytes of process data is expected.



If you agree with the fix it would be nice to have it merged. The patch
is done with commit id 50775159276d896d8b3102b6dbc658a91a2a1d53 as base,
but I=92ve checked in the latest lib.c in the master branch, and the code=

looks the same there.



Br H=E5kan Engblom, Software designer, Tele-Radio AB



diff -ur a/lib.c b/lib.c

--- a/lib.c     2013-02-15 11:01:27.308944607 +0100

+++ b/lib.c     2013-02-15 11:04:25.104942729 +0100

@@ -141,6 +141,9 @@

        if((cs[idx] =3D=3D 'R') || (cs[idx] =3D=3D 'r')){ /* RTR frame */=


                cf->can_id |=3D CAN_RTR_FLAG;

+               if ((tmp =3D asc2nibble(cs[++idx])) > 0x08) /* 8 is max d=
lc */

+                       return 1;

+               cf->can_dlc =3D tmp;

                return 0;

        }


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |




------enig2QHKREKAKOHMASQMERDXW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlEeEXQACgkQjTAFq1RaXHN65ACeIKmPMdz2arMaRPOXCXDmoSRj
1s8An2yk8t2HCOcnD6jIfwwcCaEAkNck
=5lV4
-----END PGP SIGNATURE-----

------enig2QHKREKAKOHMASQMERDXW--
