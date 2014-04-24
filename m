From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: fix return value from can_get_bittiming()
Date: Thu, 24 Apr 2014 22:30:59 +0200
Message-ID: <53597483.6080409@pengutronix.de>
References: <1398283855-14725-1-git-send-email-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="LWHjaOC4oF5Mgh4TaaLjOHEQE8671mFgo"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38547 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385AbaDXUbF (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 24 Apr 2014 16:31:05 -0400
In-Reply-To: <1398283855-14725-1-git-send-email-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LWHjaOC4oF5Mgh4TaaLjOHEQE8671mFgo
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 04/23/2014 10:10 PM, Oliver Hartkopp wrote:
> When trying to set a data bitrate on non CAN FD devices the 'ip' tool
> answers with:
>=20
> 	RTNETLINK answers: Unknown error 524
>=20
> Rename '-ENOTSUPP' to '-EOPNOTSUPP' so that 'ip' answers correctly:
>=20
>        RTNETLINK answers: Operation not supported
>=20
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

Applied to can/master.

Tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--LWHjaOC4oF5Mgh4TaaLjOHEQE8671mFgo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlNZdIMACgkQjTAFq1RaXHOOeQCfY254W8n58ayS6Hi12y5XJGfK
dOIAnRiZhjM291HMq8xjgMAXaHAXktZB
=rd7V
-----END PGP SIGNATURE-----

--LWHjaOC4oF5Mgh4TaaLjOHEQE8671mFgo--
