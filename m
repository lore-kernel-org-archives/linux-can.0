From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH: 3.11] usb_8dev: Fix memory leak in usb_8dev_start_xmit
Date: Mon, 24 Mar 2014 15:34:14 +0100
Message-ID: <53304266.2060200@pengutronix.de>
References: <CAMEA=P1AaDL94S8kaep-F012WAseimAyB7ME11Qzd0UMbp-BGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="4BxXFMgP27k7aG9M8lretMcCKXEeH2dpx"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50902 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752923AbaCXOeW (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 24 Mar 2014 10:34:22 -0400
In-Reply-To: <CAMEA=P1AaDL94S8kaep-F012WAseimAyB7ME11Qzd0UMbp-BGg@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Bjorn Van Tilt <bjorn.vantilt@gmail.com>, krumboeck@universalnet.at, wg@grandegger.com, linux-can@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4BxXFMgP27k7aG9M8lretMcCKXEeH2dpx
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 03/24/2014 03:13 PM, Bjorn Van Tilt wrote:
> Fixed a memory leak when an error occurred in the transmit function.
> In the error handling the urb wasn't freed before returning. There was
> also a call to the usb_unanchor_urb() function but the urb wasn't
> anchored.
>=20
> Signed-off-by: Bjorn Van Tilt <bjorn.vantilt@gmail.com>

Applied to the can tree.

Tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--4BxXFMgP27k7aG9M8lretMcCKXEeH2dpx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlMwQmYACgkQjTAFq1RaXHPalwCdHKXhTEQdgpj9Wt3mzFxrmESf
9BQAnRoWQ9w4Syma/bm99ViKmN/E2vGc
=KnL4
-----END PGP SIGNATURE-----

--4BxXFMgP27k7aG9M8lretMcCKXEeH2dpx--
