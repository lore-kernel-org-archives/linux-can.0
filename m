From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 0/4] CAN sk_buff and can-gw enhancements
Date: Wed, 23 Jan 2013 10:20:24 +0100
Message-ID: <50FFAB58.1030301@pengutronix.de>
References: <50F83848.4090006@hartkopp.net> <50FF07A1.1070909@pengutronix.de> <50FF0EC6.70106@pengutronix.de> <50FFA9D8.40005@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2RSTFDTBVWKKJLBUKRBAP"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33277 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754146Ab3AWJU0 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 23 Jan 2013 04:20:26 -0500
In-Reply-To: <50FFA9D8.40005@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2RSTFDTBVWKKJLBUKRBAP
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 01/23/2013 10:14 AM, Oliver Hartkopp wrote:
> On 22.01.2013 23:12, Marc Kleine-Budde wrote:
>=20
>=20
>>
>> BTW: try to use git send-email to send your patches, it's easier than =
to
>> use thunderbird and git am works better.
>>
>=20
>=20
> I was in hurry that day and tried to get my IMAP mail account working w=
ith
> git. After 2h of failures i copy/pasted the four output files of
>=20
> 	git format-patch --cover-letter
>=20
> by hand into thunderbird.
>=20
> Sigh :-(
>=20
> Will need to spend some more time for that ...

Have a look at the bottom of the git-sendemail manpage, add this to your
~/.gitconfig

           [sendemail]
                   smtpencryption =3D tls
                   smtpserver =3D smtp.gmail.com
                   smtpuser =3D yourname@gmail.com
                   smtpserverport =3D 587

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2RSTFDTBVWKKJLBUKRBAP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlD/q1gACgkQjTAFq1RaXHPTrgCfYwT91F0ZNYyCjSxKv5KL7jJa
tQwAn12W6kICItwDqHSh8SuLUXjQPW/Z
=/GuC
-----END PGP SIGNATURE-----

------enig2RSTFDTBVWKKJLBUKRBAP--
