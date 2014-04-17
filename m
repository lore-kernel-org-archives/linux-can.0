From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2] c_can: Add support for eg20t (pch_can)
Date: Thu, 17 Apr 2014 22:23:07 +0200
Message-ID: <5350382B.6050803@pengutronix.de>
References: <"<533DB663.3030408@hartkopp.net>"> <1396853523-14941-1-git-send-email-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="qkWpn7dCah5xThOogJMJc8f8WX5G4ttlu"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40116 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752034AbaDQUXK (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 17 Apr 2014 16:23:10 -0400
In-Reply-To: <1396853523-14941-1-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>, Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qkWpn7dCah5xThOogJMJc8f8WX5G4ttlu
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 04/07/2014 08:52 AM, Alexander Stein wrote:
> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>

Applied to can-next/master

> ---
> This is the correct version of this patch I use.
> It has no spinlock which is not needed, AFAICT.
>=20
>  drivers/net/can/c_can/c_can_pci.c | 50 +++++++++++++++++++++++++++++++=
+++++++-
>  1 file changed, 49 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/can/c_can/c_can_pci.c b/drivers/net/can/c_can/=
c_can_pci.c
> index bce0be5..128788c 100644
> --- a/drivers/net/can/c_can/c_can_pci.c
> +++ b/drivers/net/can/c_can/c_can_pci.c

[...]

> @@ -87,7 +118,7 @@ static int c_can_pci_probe(struct pci_dev *pdev,
>  	pci_set_master(pdev);
>  	pci_enable_msi(pdev);
> =20
> -	addr =3D pci_iomap(pdev, 0, pci_resource_len(pdev, 0));
> +	addr =3D pci_iomap(pdev, c_can_pci_data->bar, pci_resource_len(pdev, =
0));

	addr =3D pci_iomap(pdev, c_can_pci_data->bar,
			 pci_resource_len(pdev, c_can_pci_data->bar));

With this fix applied.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--qkWpn7dCah5xThOogJMJc8f8WX5G4ttlu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlNQOCsACgkQjTAFq1RaXHNCSACeM7AEqbQC0YuoarUVtiXxeEsv
8tcAn2vpjT8ZHp1igEE+pFCksScu0nyK
=wSLh
-----END PGP SIGNATURE-----

--qkWpn7dCah5xThOogJMJc8f8WX5G4ttlu--
