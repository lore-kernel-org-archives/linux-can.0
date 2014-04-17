From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2] c_can: Add support for eg20t (pch_can)
Date: Thu, 17 Apr 2014 22:47:55 +0200
Message-ID: <53503DFB.1080203@pengutronix.de>
References: <"<533DB663.3030408@hartkopp.net>"> <1396853523-14941-1-git-send-email-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Wd5cfXdM1XoFbWaJV8NxaI2OG1s1qdkRp"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44366 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751045AbaDQUsB (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 17 Apr 2014 16:48:01 -0400
In-Reply-To: <1396853523-14941-1-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>, Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Wd5cfXdM1XoFbWaJV8NxaI2OG1s1qdkRp
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 04/07/2014 08:52 AM, Alexander Stein wrote:
> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
[..]

> +static void c_can_pci_reset_pch(const struct c_can_priv *priv, bool en=
able)
> +{
> +	if (enable) {
> +		u32 __iomem *addr =3D priv->base + PCH_PCI_SOFT_RESET;
> +
> +		/* write to sw reset register */
> +		iowrite32(1, addr);

Do we need to wait for something here?

> +		iowrite32(0, addr);
> +	}
> +}

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--Wd5cfXdM1XoFbWaJV8NxaI2OG1s1qdkRp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlNQPfsACgkQjTAFq1RaXHNzXgCglgK6ErpbEfZ9SqOgp5oX6043
OFwAnRb7e60Q799An9VAflFE1qc63Ags
=idZM
-----END PGP SIGNATURE-----

--Wd5cfXdM1XoFbWaJV8NxaI2OG1s1qdkRp--
