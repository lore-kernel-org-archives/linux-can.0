From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [RFC v2 5/7] c_can_pci: enable PCI bus master only for MSI
Date: Fri, 30 Nov 2012 09:54:07 +0100
Message-ID: <50B8742F.1020509@pengutronix.de>
References: <1354199987-10350-1-git-send-email-wg@grandegger.com> <1354199987-10350-6-git-send-email-wg@grandegger.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4F557AD05093206F81560EBB"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40005 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751357Ab2K3IyL (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 30 Nov 2012 03:54:11 -0500
In-Reply-To: <1354199987-10350-6-git-send-email-wg@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org, bhupesh.sharma@st.com, tomoya.rohm@gmail.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4F557AD05093206F81560EBB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/29/2012 03:39 PM, Wolfgang Grandegger wrote:
> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
> ---
>  drivers/net/can/c_can/c_can_pci.c |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/can/c_can/c_can_pci.c b/drivers/net/can/c_can/=
c_can_pci.c
> index 7b73f90..320e371 100644
> --- a/drivers/net/can/c_can/c_can_pci.c
> +++ b/drivers/net/can/c_can/c_can_pci.c
> @@ -86,8 +86,11 @@ static int __devinit c_can_pci_probe(struct pci_dev =
*pdev,
>  		goto out_disable_device;
>  	}
> =20
> -	pci_set_master(pdev);
> -	pci_enable_msi(pdev);
> +
> +	if (!pci_enable_msi(pdev)) {

Can you please use an intermediate variable "ret".

ret =3D pci_enable_msi(pdev);
if (!ret)  {
}

> +		dev_info(&pdev->dev, "MSI enabled\n");
> +		pci_set_master(pdev);
> +	}
> =20
>  	addr =3D pci_iomap(pdev, c_can_pci_data->bar, 0);
>  	if (!addr) {
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig4F557AD05093206F81560EBB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlC4dC8ACgkQjTAFq1RaXHMdfwCeInulOA2BEqgufnL5IICFyzDL
UlUAnj+3RRIJZ/+eiKt/h/1L/PbUjT9G
=gebU
-----END PGP SIGNATURE-----

--------------enig4F557AD05093206F81560EBB--
