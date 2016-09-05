From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: c_can_pci set device pointer
Date: Mon, 5 Sep 2016 10:54:36 +0200
Message-ID: <9fa2d0f5-688b-9d00-9635-c8732ac2f678@pengutronix.de>
References: <CABhNV20Tv3LxJw=e_JhP-tGwpFz3qNeGo1dUV8HZW6wQUMf1ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="hPeLIELQ8AGlEN4jckG2gfcvdknP1HfDT"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:47103 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754563AbcIEIys (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 5 Sep 2016 04:54:48 -0400
In-Reply-To: <CABhNV20Tv3LxJw=e_JhP-tGwpFz3qNeGo1dUV8HZW6wQUMf1ww@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?Q?Einar_J=c3=b3n?= <tolvupostur@gmail.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hPeLIELQ8AGlEN4jckG2gfcvdknP1HfDT
Content-Type: multipart/mixed; boundary="qm1piJWfjlV5FwoooeONjRDpDX4Hp4VSt"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: =?UTF-8?Q?Einar_J=c3=b3n?= <tolvupostur@gmail.com>,
 linux-can@vger.kernel.org
Message-ID: <9fa2d0f5-688b-9d00-9635-c8732ac2f678@pengutronix.de>
Subject: Re: [PATCH] can: c_can_pci set device pointer
References: <CABhNV20Tv3LxJw=e_JhP-tGwpFz3qNeGo1dUV8HZW6wQUMf1ww@mail.gmail.com>
In-Reply-To: <CABhNV20Tv3LxJw=e_JhP-tGwpFz3qNeGo1dUV8HZW6wQUMf1ww@mail.gmail.com>

--qm1piJWfjlV5FwoooeONjRDpDX4Hp4VSt
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/12/2016 01:50 PM, Einar J=C3=B3n wrote:
> The priv->device pointer for c_can_pci is never set, but it is used
> without a null check in
> drivers/net/can/c_can/c_can.c:615:static int c_can_start(struct net_dev=
ice *dev)
> Setting it in c_can_pci_probe() like c_can_plat_probe() prevents
> c_can_pci.ko from crashing, with and without CONFIG_PM,
>=20
> This might also cause the pm_runtime_*() functions in c_can.c to
> actually be executed for c_can_pci devices - they are the only other
> place where priv->device is used, but they all contain a null check.

Can I add your Signed-off-by to the Code?

Marc

>=20
> ---
>  drivers/net/can/c_can/c_can_pci.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/net/can/c_can/c_can_pci.c
> b/drivers/net/can/c_can/c_can_pci.c
> index 7be393c..cf7c189 100644
> --- a/drivers/net/can/c_can/c_can_pci.c
> +++ b/drivers/net/can/c_can/c_can_pci.c
> @@ -161,6 +161,7 @@ static int c_can_pci_probe(struct pci_dev *pdev,
>=20
>      dev->irq =3D pdev->irq;
>      priv->base =3D addr;
> +    priv->device =3D &pdev->dev;
>=20
>      if (!c_can_pci_data->freq) {
>          dev_err(&pdev->dev, "no clock frequency defined\n");
>=20


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--qm1piJWfjlV5FwoooeONjRDpDX4Hp4VSt--

--hPeLIELQ8AGlEN4jckG2gfcvdknP1HfDT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJXzTLOAAoJED07qiWsqSVqqLgH/19zoXNbJlDFI1GIMQA4vAui
MCiUxmPdq9tKmXjhprfBp32L/EjUH6WghtMoCR9j6skdC2hGZDOQQcNG3xoCSWvH
GEraGQVylQzdwRJiWO1gNTz9UrgGQ9CHrKYb0GdnnRX5eQcOdJ6MFZDt8yHMOcPZ
1w3uuvkmDFEE1FOB+TRkLytxqwbJ5zrTcLel9ResfvvJS30iZkPNXkVbm4M8o+zP
qpDCH1Cu0kT5/b+YdiOvNCnJXAMjdDEhcGNDDR+nXiBIrANfBnfrZLkgEn9vY2tC
fXbTVLipRRQYDFlDvsLr/gfEBwpPJB+SCtThLfOVvR7F7gqJJg1sd02bNqUmMek=
=+c4h
-----END PGP SIGNATURE-----

--hPeLIELQ8AGlEN4jckG2gfcvdknP1HfDT--
