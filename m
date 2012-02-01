From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 00/12] CAN updates for net-next, please review
Date: Wed, 01 Feb 2012 10:47:36 +0100
Message-ID: <4F290A38.8080807@pengutronix.de>
References: <1328046410-21392-1-git-send-email-mkl@pengutronix.de> <4F290933.9060202@grandegger.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB70C725208C2A818FC2B11C4"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44043 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754380Ab2BAJrk (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 1 Feb 2012 04:47:40 -0500
In-Reply-To: <4F290933.9060202@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB70C725208C2A818FC2B11C4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hey,

On 02/01/2012 10:43 AM, Wolfgang Grandegger wrote:
>> I collected all pending patches from the mailinglist in order to push =
to
>> davem. Are there some patches missing, which are rerady to go upstream=
?
>=20
> The patch "[PATCH 04/12] can: replace the dev_dbg/info/err/... with the=

> new netdev_xxx macros" does have issues. Did you already apply it to
> linux-can-next? Shoud I send a v2 or a followup patch? I have also

No, it's still in my repo. Please send a v2.

> another fix for the ti_hecc driver, which I will send in a few minutes.=


Go ahead. I'll have to setup a compile time test script anyway.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigB70C725208C2A818FC2B11C4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk8pCjsACgkQjTAFq1RaXHOiTQCeO9fm+Py0iVoVGq7Hpj+gGu9Q
6kMAoIIqmCOHhY2+DxP92FuOljLnk4Fc
=v8ic
-----END PGP SIGNATURE-----

--------------enigB70C725208C2A818FC2B11C4--
