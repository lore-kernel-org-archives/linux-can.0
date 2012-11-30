From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [RFC v2 4/7] c_can_pci: introduce board specific PCI bar
Date: Fri, 30 Nov 2012 09:45:49 +0100
Message-ID: <50B8723D.4080300@pengutronix.de>
References: <1354199987-10350-1-git-send-email-wg@grandegger.com> <1354199987-10350-5-git-send-email-wg@grandegger.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2D09B22BDBCC31B997CF24D6"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59662 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750736Ab2K3Ipx (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 30 Nov 2012 03:45:53 -0500
In-Reply-To: <1354199987-10350-5-git-send-email-wg@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org, bhupesh.sharma@st.com, tomoya.rohm@gmail.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2D09B22BDBCC31B997CF24D6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/29/2012 03:39 PM, Wolfgang Grandegger wrote:
> Also fix minor issue with pci_iomap specifying size 0 for
> mapping the full range.

If I understand the code correct, using pci_resource_len(pdev, 0) for
the max len (of BAR 0) instead of 0 isn't a bug, it's just more
complicated than it needs to be. If it really is a bug, I think a
separate patch will be good.

Marc

>=20
> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
> ---
>  drivers/net/can/c_can/c_can_pci.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/can/c_can/c_can_pci.c b/drivers/net/can/c_can/=
c_can_pci.c
> index 3d7830b..7b73f90 100644
> --- a/drivers/net/can/c_can/c_can_pci.c
> +++ b/drivers/net/can/c_can/c_can_pci.c
> @@ -31,6 +31,8 @@ struct c_can_pci_data {
>  	enum c_can_pci_reg_align reg_align;
>  	/* Set the frequency */
>  	unsigned int freq;
> +	/* PCI bar number */
> +	int bar;
>  };
> =20
>  /*
> @@ -87,7 +89,7 @@ static int __devinit c_can_pci_probe(struct pci_dev *=
pdev,
>  	pci_set_master(pdev);
>  	pci_enable_msi(pdev);
> =20
> -	addr =3D pci_iomap(pdev, 0, pci_resource_len(pdev, 0));
> +	addr =3D pci_iomap(pdev, c_can_pci_data->bar, 0);
>  	if (!addr) {
>  		dev_err(&pdev->dev,
>  			"device has no PCI memory resources, "
> @@ -195,6 +197,7 @@ static struct c_can_pci_data c_can_sta2x11=3D {
>  	.type =3D BOSCH_C_CAN,
>  	.reg_align =3D C_CAN_REG_ALIGN_32,
>  	.freq =3D 52000000, /* 52 Mhz */
> +	.bar =3D 0,
>  };
> =20
>  #define C_CAN_ID(_vend, _dev, _driverdata) {		\
>=20


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig2D09B22BDBCC31B997CF24D6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlC4cj0ACgkQjTAFq1RaXHNC3ACfSCSalECHSZlbsfcss9lEToro
iCYAn2KbKV2AMSd1bomTBd7UFkA+44IF
=iD99
-----END PGP SIGNATURE-----

--------------enig2D09B22BDBCC31B997CF24D6--
