From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2] can: sja1000: plx_pci: add support for ASEM CAN raw
 device
Date: Mon, 6 Aug 2018 15:49:39 +0200
Message-ID: <ac6e38c7-f794-6efd-4942-9b2a3fa7a0d0@pengutronix.de>
References: <a6b6906d-6f53-9bf2-d87e-49ae3f208f00@pengutronix.de>
 <1533561432-27034-1-git-send-email-f.suligoi@asem.it>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="ILlMUtyQfZwct1lZDwRhuhNdjoCBF65p8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1533561432-27034-1-git-send-email-f.suligoi@asem.it>
Sender: netdev-owner@vger.kernel.org
To: Flavio Suligoi <f.suligoi@asem.it>, Wolfgang Grandegger <wg@grandegger.com>
Cc: "David S . Miller" <davem@davemloft.net>, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ILlMUtyQfZwct1lZDwRhuhNdjoCBF65p8
Content-Type: multipart/mixed; boundary="Um7qHmiKcd8JKtIapibt6be65uwvg3Bxj";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Flavio Suligoi <f.suligoi@asem.it>,
 Wolfgang Grandegger <wg@grandegger.com>
Cc: "David S . Miller" <davem@davemloft.net>, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <ac6e38c7-f794-6efd-4942-9b2a3fa7a0d0@pengutronix.de>
Subject: Re: [PATCH v2] can: sja1000: plx_pci: add support for ASEM CAN raw
 device
References: <a6b6906d-6f53-9bf2-d87e-49ae3f208f00@pengutronix.de>
 <1533561432-27034-1-git-send-email-f.suligoi@asem.it>
In-Reply-To: <1533561432-27034-1-git-send-email-f.suligoi@asem.it>

--Um7qHmiKcd8JKtIapibt6be65uwvg3Bxj
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 08/06/2018 03:17 PM, Flavio Suligoi wrote:
> This patch adds support for ASEM opto-isolated dual channels
> CAN raw device (http://www.asem.it)
>=20
> Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
> ---
>=20
> v2: - renamed ASEM_... constants to reduce space size;
>     - remove "else" in "plx_pci_reset_asem_dual_can_raw" function to av=
oid=20
>       strings breaking
>=20
>  drivers/net/can/sja1000/Kconfig   |  1 +
>  drivers/net/can/sja1000/plx_pci.c | 67 +++++++++++++++++++++++++++++++=
+++++++-
>  2 files changed, 67 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/can/sja1000/Kconfig b/drivers/net/can/sja1000/=
Kconfig
> index 1e65cb6..f6dc899 100644
> --- a/drivers/net/can/sja1000/Kconfig
> +++ b/drivers/net/can/sja1000/Kconfig
> @@ -88,6 +88,7 @@ config CAN_PLX_PCI
>  	   - TEWS TECHNOLOGIES TPMC810 card (http://www.tews.com/)
>  	   - IXXAT Automation PC-I 04/PCI card (http://www.ixxat.com/)
>  	   - Connect Tech Inc. CANpro/104-Plus Opto (CRG001) card (http://www=
=2Econnecttech.com)
> +	   - ASEM CAN raw - 2 isolated CAN channels (www.asem.it)
> =20
>  config CAN_TSCAN1
>  	tristate "TS-CAN1 PC104 boards"
> diff --git a/drivers/net/can/sja1000/plx_pci.c b/drivers/net/can/sja100=
0/plx_pci.c
> index f8ff25c..d8dfa06 100644
> --- a/drivers/net/can/sja1000/plx_pci.c
> +++ b/drivers/net/can/sja1000/plx_pci.c
> @@ -46,7 +46,8 @@ MODULE_SUPPORTED_DEVICE("Adlink PCI-7841/cPCI-7841, "=

>  			"esd CAN-PCIe/2000, "
>  			"Connect Tech Inc. CANpro/104-Plus Opto (CRG001), "
>  			"IXXAT PC-I 04/PCI, "
> -			"ELCUS CAN-200-PCI")
> +			"ELCUS CAN-200-PCI, "
> +			"ASEM DUAL CAN-RAW")
>  MODULE_LICENSE("GPL v2");
> =20
>  #define PLX_PCI_MAX_CHAN 2
> @@ -70,7 +71,9 @@ struct plx_pci_card {
>  					 */
> =20
>  #define PLX_LINT1_EN	0x1		/* Local interrupt 1 enable */
> +#define PLX_LINT1_POL	(1 << 1)	/* Local interrupt 1 polarity */
>  #define PLX_LINT2_EN	(1 << 3)	/* Local interrupt 2 enable */
> +#define PLX_LINT2_POL	(1 << 4)	/* Local interrupt 1 polarity */
                                                                  ^^^
2?

>  #define PLX_PCI_INT_EN	(1 << 6)	/* PCI Interrupt Enable */
>  #define PLX_PCI_RESET	(1 << 30)	/* PCI Adapter Software Reset */
> =20
> @@ -92,6 +95,9 @@ struct plx_pci_card {
>   */
>  #define PLX_PCI_OCR	(OCR_TX0_PUSHPULL | OCR_TX1_PUSHPULL)
> =20
> +/* OCR setting for ASEM Dual CAN raw */
> +#define ASEM_PCI_OCR	0xfe
> +
>  /*
>   * In the CDR register, you should set CBP to 1.
>   * You will probably also want to set the clock divider value to 7
> @@ -145,10 +151,20 @@ struct plx_pci_card {
>  #define MOXA_PCI_VENDOR_ID		0x1393
>  #define MOXA_PCI_DEVICE_ID		0x0100
> =20
> +#define ASEM_RAW_CAN_VENDOR_ID		0x10b5
> +#define ASEM_RAW_CAN_DEVICE_ID		0x9030
> +#define ASEM_RAW_CAN_SUB_VENDOR_ID	0x3000
> +#define ASEM_RAW_CAN_SUB_DEVICE_ID	0x1001
> +#define ASEM_RAW_CAN_SUB_DEVICE_ID_BIS	0x1002
> +#define ASEM_RAW_CAN_RST_REGISTER	0x54
> +#define ASEM_RAW_CAN_RST_MASK_CAN1	0x20
> +#define ASEM_RAW_CAN_RST_MASK_CAN2	0x04
> +
>  static void plx_pci_reset_common(struct pci_dev *pdev);
>  static void plx9056_pci_reset_common(struct pci_dev *pdev);
>  static void plx_pci_reset_marathon_pci(struct pci_dev *pdev);
>  static void plx_pci_reset_marathon_pcie(struct pci_dev *pdev);
> +static void plx_pci_reset_asem_dual_can_raw(struct pci_dev *pdev);
> =20
>  struct plx_pci_channel_map {
>  	u32 bar;
> @@ -269,6 +285,14 @@ static struct plx_pci_card_info plx_pci_card_info_=
moxa =3D {
>  	 /* based on PLX9052 */
>  };
> =20
> +static struct plx_pci_card_info plx_pci_card_info_asem_dual_can =3D {
> +	"ASEM Dual CAN raw PCI", 2,
> +	PLX_PCI_CAN_CLOCK, ASEM_PCI_OCR, PLX_PCI_CDR,
> +	{0, 0x00, 0x00}, { {2, 0x00, 0x00}, {4, 0x00, 0x00} },
> +	&plx_pci_reset_asem_dual_can_raw
> +	/* based on PLX9030 */
> +};
> +
>  static const struct pci_device_id plx_pci_tbl[] =3D {
>  	{
>  		/* Adlink PCI-7841/cPCI-7841 */
> @@ -375,6 +399,20 @@ static const struct pci_device_id plx_pci_tbl[] =3D=
 {
>  		0, 0,
>  		(kernel_ulong_t)&plx_pci_card_info_moxa
>  	},
> +	{
> +		/* ASEM Dual CAN raw */
> +		ASEM_RAW_CAN_VENDOR_ID, ASEM_RAW_CAN_DEVICE_ID,
> +		ASEM_RAW_CAN_SUB_VENDOR_ID, ASEM_RAW_CAN_SUB_DEVICE_ID,
> +		0, 0,
> +		(kernel_ulong_t)&plx_pci_card_info_asem_dual_can
> +	},
> +	{
> +		/* ASEM Dual CAN raw -new model */
> +		ASEM_RAW_CAN_VENDOR_ID, ASEM_RAW_CAN_DEVICE_ID,
> +		ASEM_RAW_CAN_SUB_VENDOR_ID, ASEM_RAW_CAN_SUB_DEVICE_ID_BIS,
> +		0, 0,
> +		(kernel_ulong_t)&plx_pci_card_info_asem_dual_can
> +	},
>  	{ 0,}
>  };
>  MODULE_DEVICE_TABLE(pci, plx_pci_tbl);
> @@ -524,6 +562,33 @@ static void plx_pci_reset_marathon_pcie(struct pci=
_dev *pdev)
>  	}
>  }
> =20
> +/* Special reset function for ASEM Dual CAN raw card */
> +static void plx_pci_reset_asem_dual_can_raw(struct pci_dev *pdev)
> +{
> +	void __iomem *bar0_addr;
> +	static const int reset_bar;
> +	u8 tmpval;
> +
> +	plx_pci_reset_common(pdev);
> +
> +	bar0_addr =3D pci_iomap(pdev, reset_bar, 0);
> +	if (!bar0_addr) {
> +		dev_err(&pdev->dev, "Failed to remap reset "
> +		"space %d (BAR%d)\n", 0, reset_bar);

Please put the string into just one line.

> +		return;
> +	}
> +
> +	/* reset the two SJA1000 chips */
> +	tmpval =3D ioread8(bar0_addr + ASEM_RAW_CAN_RST_REGISTER);
> +	tmpval &=3D ~(ASEM_RAW_CAN_RST_MASK_CAN1 | ASEM_RAW_CAN_RST_MASK_CAN2=
);
> +	iowrite8(tmpval, bar0_addr + ASEM_RAW_CAN_RST_REGISTER);
> +	usleep_range(300, 400);
> +	tmpval |=3D ASEM_RAW_CAN_RST_MASK_CAN1 | ASEM_RAW_CAN_RST_MASK_CAN2;
> +	iowrite8(tmpval, bar0_addr + ASEM_RAW_CAN_RST_REGISTER);
> +	usleep_range(300, 400);
> +	pci_iounmap(pdev, bar0_addr);
> +}
> +
>  static void plx_pci_del_card(struct pci_dev *pdev)
>  {
>  	struct plx_pci_card *card =3D pci_get_drvdata(pdev);
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--Um7qHmiKcd8JKtIapibt6be65uwvg3Bxj--

--ILlMUtyQfZwct1lZDwRhuhNdjoCBF65p8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAltoUfMACgkQk9IU1zQo
ZfF4hgf/VAOU2hmf1w6eysSqQ32ufDCHkzuPC40j3FTMJIrmd7zLexjHIKs2VNQN
68XcwdMwNZmC4nRfTjGNUJJP10cKZmyKAIIy5lfnwjops3kkXNGwiZUaOj+hhJga
ds+RBiQJgT3oQnD2PSKf4/sANTS0XiP52/wTIsfdlu3hzLEF9rOAEt6hFfg8Y2pz
zmng8C9ZV3swJZfF16/e7nmLc9vWnOMtNh5EBKJftb1R+8PVOOm3o4pBG7Jf3GKd
tat/GfwvoJsnLVgqa1dR2ngcBm5IzK+Cp5hATsUWOuUEQgJMVe81wcLuSYmLULaa
+pAMGc0aE3+dLy66BKxjnqW6CZEWEg==
=Qho0
-----END PGP SIGNATURE-----

--ILlMUtyQfZwct1lZDwRhuhNdjoCBF65p8--
