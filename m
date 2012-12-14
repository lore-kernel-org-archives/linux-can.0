From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: usb_8dev: USB Protocoll available?
Date: Fri, 14 Dec 2012 19:33:41 +0100
Message-ID: <50CB7105.4090301@pengutronix.de>
References: <20683.22879.172661.430971@elektron.ikp.physik.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9C6FF718BB255EDAF2BD5D17"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34029 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756683Ab2LNSdo (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 14 Dec 2012 13:33:44 -0500
In-Reply-To: <20683.22879.172661.430971@elektron.ikp.physik.tu-darmstadt.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9C6FF718BB255EDAF2BD5D17
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/14/2012 05:52 PM, Uwe Bonnes wrote:
> is there some document describing the protocoll used for the usb_8dev? =
I
> have STM32 hardware with USB and CAN connected and think about writing =
some
> firmware compatible with some existing adapter.
>=20
> Otherwise, are the github projects
>=20
> saeugetier / usb2can
>=20
> shackspace / usb2can
>=20
> for usb to can hardware related to this driver??

Have a look at the driver from Bernd Krumboeck on the list here [1].

Marc

[1] http://www.spinics.net/lists/linux-usb/msg76025.html
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig9C6FF718BB255EDAF2BD5D17
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlDLcQUACgkQjTAFq1RaXHOkDgCfWxTpUxfjNu8a5ZwFpHEYNEfE
u5AAnjfgmW41BIkdj/wRNHbWd+wrbF5o
=spmO
-----END PGP SIGNATURE-----

--------------enig9C6FF718BB255EDAF2BD5D17--
