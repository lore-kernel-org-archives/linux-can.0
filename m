From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH iproute2 v2 0/3] CAN Filter/Classifier
Date: Fri, 27 Jul 2012 15:58:54 +0200
Message-ID: <50129E9E.8010806@pengutronix.de>
References: <1343383363-6174-1-git-send-email-mkl@pengutronix.de> <50129E17.7030602@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE8048BF7733DF8C561F2E8AD"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43047 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752362Ab2G0N7E (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 27 Jul 2012 09:59:04 -0400
In-Reply-To: <50129E17.7030602@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, lartc@vger.kernel.org, pisa@cmp.felk.cvut.cz, sojkam1@fel.cvut.cz, lisovy@gmail.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE8048BF7733DF8C561F2E8AD
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 07/27/2012 03:56 PM, Oliver Hartkopp wrote:
> On 27.07.2012 12:02, Marc Kleine-Budde wrote:
>=20
>> I'm reposting Rostislav's iproute2 patches, as Stephen requested,
>> during the v3.6 merge window with the corresponding kernel patches
>> already applied.
>=20
>=20
> Hallo Marc,
>=20
> thanks for tracking these iproute2 patches.
>=20
> Btw. i think these patches address the original implementation from Ros=
tislav
> using the CAN classifier. The review lead to a completely new implement=
ation
> using ematch. Therefore this patch series is outdated AFAICS.
>=20
> @Rostislav: Am i correct here?

Has someone started working on this, or already new patches?

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigE8048BF7733DF8C561F2E8AD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlASnqIACgkQjTAFq1RaXHPlqQCfQlUEQOvXAM6uGqidHL6CO59y
1E8An3QrU3ECUfie2xXMfiVPsGnsFVPv
=4Tzx
-----END PGP SIGNATURE-----

--------------enigE8048BF7733DF8C561F2E8AD--
