From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH V2 1/1] can: sja1000: f81601: add Fintek F81601 support
Date: Mon, 22 Jul 2019 11:45:24 +0200
Message-ID: <cdd3a9dd-ae1d-1874-d51b-a88ba5500588@pengutronix.de>
References: <1563776521-28317-1-git-send-email-hpeter+linux_kernel@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="SQ1hHwJqs3kmaI9kCNm0ke1xmkiBVsj8i"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1563776521-28317-1-git-send-email-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>, wg@grandegger.com, peter_hong@fintek.com.tw
Cc: davem@davemloft.net, f.suligoi@asem.it, linux-kernel@vger.kernel.org, linux-can@vger.kernel.org, netdev@vger.kernel.org, "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SQ1hHwJqs3kmaI9kCNm0ke1xmkiBVsj8i
Content-Type: multipart/mixed; boundary="DFwssp55hssuGeQuD7seBDiCZ2gvxuav9";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>, wg@grandegger.com,
 peter_hong@fintek.com.tw
Cc: davem@davemloft.net, f.suligoi@asem.it, linux-kernel@vger.kernel.org,
 linux-can@vger.kernel.org, netdev@vger.kernel.org,
 "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Message-ID: <cdd3a9dd-ae1d-1874-d51b-a88ba5500588@pengutronix.de>
Subject: Re: [PATCH V2 1/1] can: sja1000: f81601: add Fintek F81601 support
References: <1563776521-28317-1-git-send-email-hpeter+linux_kernel@gmail.com>
In-Reply-To: <1563776521-28317-1-git-send-email-hpeter+linux_kernel@gmail.com>

--DFwssp55hssuGeQuD7seBDiCZ2gvxuav9
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 7/22/19 8:22 AM, Ji-Ze Hong (Peter Hong) wrote:
> This patch add support for Fintek PCIE to 2 CAN controller support
>=20
> Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
> ---
> Changelog:
> v2:
> 	1: Fix comment on the spinlock with write access.
> 	2: Use ARRAY_SIZE instead of F81601_PCI_MAX_CHAN.
> 	3: Check the strap pin outside the loop.
> 	4: Fix the cleanup issue in f81601_pci_add_card().
> 	5: Remove unused "channels" in struct f81601_pci_card.
>=20
>  drivers/net/can/sja1000/Kconfig  |   8 ++
>  drivers/net/can/sja1000/Makefile |   1 +
>  drivers/net/can/sja1000/f81601.c | 215 +++++++++++++++++++++++++++++++=
++++++++
>  3 files changed, 224 insertions(+)
>  create mode 100644 drivers/net/can/sja1000/f81601.c

> diff --git a/drivers/net/can/sja1000/f81601.c b/drivers/net/can/sja1000=
/f81601.c
> new file mode 100644
> index 000000000000..3c378de8764d
> --- /dev/null
> +++ b/drivers/net/can/sja1000/f81601.c

[...]

> +static void f81601_pci_del_card(struct pci_dev *pdev)
> +{
> +	struct f81601_pci_card *card =3D pci_get_drvdata(pdev);
> +	struct net_device *dev;
> +	int i =3D 0;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(card->net_dev); i++) {
> +		dev =3D card->net_dev[i];
> +		if (!dev)
> +			continue;
> +
> +		dev_info(&pdev->dev, "%s: Removing %s\n", __func__, dev->name);
> +
> +		unregister_sja1000dev(dev);
> +		free_sja1000dev(dev);
> +	}
> +
> +	pcim_iounmap(pdev, card->addr);

Why do you need iounmap()?

> +}

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--DFwssp55hssuGeQuD7seBDiCZ2gvxuav9--

--SQ1hHwJqs3kmaI9kCNm0ke1xmkiBVsj8i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl01hbQACgkQWsYho5Hk
nSCHaAgAmONUlMqvO6vrt/ghYTMHy9dSuFoPjVxzUAeNCH5kmSkxy/N0jilGB1Fi
WrF8lvpCKR2XAHbxYm7cPXWEEU4JolyvBYJfHfS6roPwXiSoohcBymLXjElcxHA7
VGC6WliaRJJFG0b7w3VBIhyWObI6pLoQAtoxL7nxKD0Qh6Ftntok9y6klqCrl7a+
3xwOOESWPPJUkwBDqQW8QimSIfJpv8mJpjZWOOYHjNgJ4bSa38JuGxWOE+GdtCcg
xW8bZciDv/ZHOT2w2L7gyXhwKMejhh8ruiZ9Vujlqu1nO0amgons0mHCVsT693zu
l2/O6apd8Rt9+BGxWaWVavA912I4jg==
=2/Oh
-----END PGP SIGNATURE-----

--SQ1hHwJqs3kmaI9kCNm0ke1xmkiBVsj8i--
