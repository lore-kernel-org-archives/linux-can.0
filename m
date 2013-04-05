From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [RFC PATCH] can: sja1000: use common prefix for all sja1000 defines
Date: Fri, 05 Apr 2013 10:00:47 +0200
Message-ID: <515E84AF.303@pengutronix.de>
References: <1364974929-14702-1-git-send-email-mkl@pengutronix.de> <515C8834.7040006@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2NOVELEADASXWJPUMWUVK"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47761 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753832Ab3DEJVJ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 5 Apr 2013 05:21:09 -0400
In-Reply-To: <515C8834.7040006@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2NOVELEADASXWJPUMWUVK
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 04/03/2013 09:51 PM, Oliver Hartkopp wrote:
> Hello Marc,
>=20
> On 03.04.2013 09:42, Marc Kleine-Budde wrote:
>=20
>=20
>> -	priv->write_reg(priv, REG_CDR, CDR_PELICAN);
>> +	priv->write_reg(priv, SJA1000_REG_CDR, CDR_PELICAN);
>=20
>=20
> What about CDR_PELICAN here?

It's from a different file, IIRC.

>=20
>=20
>> +	priv->write_reg(priv, SJA1000_REG_OCR, priv->ocr | OCR_MODE_NORMAL);=

>=20
>=20
> and OCR_MODE_NORMAL here?

same here.

>=20
> All the defines from include/linux/can/platform/sja1000.h are not unifi=
ed too.
>=20
> What about this patch?
>=20
> I used SJA_ as prefix for all relevant defines - even for SJA1000_ defi=
nes:

I like SJA1000_ more then SJA_, but I don't insist on that... :)

>  drivers/net/can/sja1000/ems_pci.c             |   12 -
>  drivers/net/can/sja1000/ems_pcmcia.c          |   12 -
>  drivers/net/can/sja1000/kvaser_pci.c          |   12 -
>  drivers/net/can/sja1000/peak_pci.c            |   10 -
>  drivers/net/can/sja1000/peak_pcmcia.c         |   20 +-
>  drivers/net/can/sja1000/plx_pci.c             |   37 ++---
>  drivers/net/can/sja1000/sja1000.c             |  187 +++++++++++++----=
---------
>  drivers/net/can/sja1000/sja1000.h             |  146 ++++++++++-------=
---
>  drivers/net/can/sja1000/sja1000_isa.c         |   28 +--
>  drivers/net/can/sja1000/sja1000_of_platform.c |   22 +--
>  drivers/net/can/sja1000/tscan1.c              |   16 +-
>  include/linux/can/platform/sja1000.h          |   40 ++---
>  12 files changed, 272 insertions(+), 270 deletions(-)

=2E..you are changing platform/sja1000h and sja100/sja1000.h. In your
commit message (which is not yet written) you should mention that. But
you are changing some defines in some drivers, which should go into a
separate patches, as this is already quite large. There are some changes
I don't like.

Should we bring these defines (that you prefixed with SJA_) to the
infrastructure sja1000.h? I'm not sure....

> index 3c18d7d..ba51a71 100644
> --- a/drivers/net/can/sja1000/plx_pci.c
> +++ b/drivers/net/can/sja1000/plx_pci.c
> @@ -89,7 +89,7 @@ struct plx_pci_card {
>   * Setting the OCR register to 0xDA is a good idea.
>   * This means normal output mode, push-pull and the correct polarity.
>   */
> -#define PLX_PCI_OCR	(OCR_TX0_PUSHPULL | OCR_TX1_PUSHPULL)
> +#define PLX_PCI_OCR	(SJA_OCR_TX0_PUSHPULL | SJA_OCR_TX1_PUSHPULL)
> =20
>  /*
>   * In the CDR register, you should set CBP to 1.
> @@ -97,21 +97,21 @@ struct plx_pci_card {
>   * (meaning direct oscillator output) because the second SJA1000 chip
>   * is driven by the first one CLKOUT output.
>   */
> -#define PLX_PCI_CDR			(CDR_CBP | CDR_CLKOUT_MASK)
> +#define PLX_PCI_CDR			(SJA_CDR_CBP | SJA_CDR_CLKOUT_MASK)
> =20
>  /* SJA1000 Control Register in the BasicCAN Mode */
> -#define REG_CR				0x00
> +#define SJA_REG_CR				0x00
^^^^^^^^^^^^^^^^^^^^^
> =20
>  /* States of some SJA1000 registers after hardware reset in the BasicC=
AN mode*/
> -#define REG_CR_BASICCAN_INITIAL		0x21
> -#define REG_CR_BASICCAN_INITIAL_MASK	0xa1
> -#define REG_SR_BASICCAN_INITIAL		0x0c
> -#define REG_IR_BASICCAN_INITIAL		0xe0
> +#define SJA_REG_CR_BASICCAN_INITIAL		0x21
> +#define SJA_REG_CR_BASICCAN_INITIAL_MASK	0xa1
> +#define SJA_REG_SR_BASICCAN_INITIAL		0x0c
> +#define SJA_REG_IR_BASICCAN_INITIAL		0xe0

dito

>  /* States of some SJA1000 registers after hardware reset in the PeliCA=
N mode*/
> -#define REG_MOD_PELICAN_INITIAL		0x01
> -#define REG_SR_PELICAN_INITIAL		0x3c
> -#define REG_IR_PELICAN_INITIAL		0x00
> +#define SJA_REG_MOD_PELICAN_INITIAL		0x01
> +#define SJA_REG_SR_PELICAN_INITIAL		0x3c
> +#define SJA_REG_IR_PELICAN_INITIAL		0x00

dito


You change some other defines, too:

> --- a/drivers/net/can/sja1000/sja1000_of_platform.c
> +++ b/drivers/net/can/sja1000/sja1000_of_platform.c
> @@ -54,10 +54,10 @@ MODULE_AUTHOR("Wolfgang Grandegger <wg@grandegger.c=
om>");
>  MODULE_DESCRIPTION("Socket-CAN driver for SJA1000 on the OF platform b=
us");
>  MODULE_LICENSE("GPL v2");
> =20
> -#define SJA1000_OFP_CAN_CLOCK  (16000000 / 2)
> +#define SJA_OFP_CAN_CLOCK  (16000000 / 2)
> =20
> -#define SJA1000_OFP_OCR        OCR_TX0_PULLDOWN
> -#define SJA1000_OFP_CDR        (CDR_CBP | CDR_CLK_OFF)
> +#define SJA_OFP_OCR        SJA_OCR_TX0_PULLDOWN
> +#define SJA_OFP_CDR        (SJA_CDR_CBP | SJA_CDR_CLK_OFF)

=2E..which you should not change, as they are reflect the name of the
driver and are only used here.

=46rom my point of view, we should not use the same prefix in a driver an=
d
inside the infrastructure (both sja1000.h). Either move these defines to
the infrastructure or use a different prefix.

> --- a/drivers/net/can/sja1000/tscan1.c
> +++ b/drivers/net/can/sja1000/tscan1.c
> @@ -65,10 +65,10 @@ MODULE_LICENSE("GPL");
>  #define TSCAN1_PLD_SIZE 8
> =20
>  /* SJA1000 register space size */
> -#define TSCAN1_SJA1000_SIZE 32
> +#define TSCAN1_SJA_SIZE 32
> =20
>  /* SJA1000 crystal frequency (16MHz) */
> -#define TSCAN1_SJA1000_XTAL 16000000
> +#define TSCAN1_SJA_XTAL 16000000

No need to change that IMHO, at least unrelated to "use the common name
SJA_ namespace" change this patch is all about.

> --- a/drivers/net/can/sja1000/sja1000_isa.c
> +++ b/drivers/net/can/sja1000/sja1000_isa.c
> @@ -37,8 +37,8 @@ MODULE_DESCRIPTION("Socket-CAN driver for SJA1000 on =
the ISA bus");
>  MODULE_LICENSE("GPL v2");
> =20
>  #define CLK_DEFAULT	16000000	/* 16 MHz */
> -#define CDR_DEFAULT	(CDR_CBP | CDR_CLK_OFF)
> -#define OCR_DEFAULT	OCR_TX0_PUSHPULL
> +#define SJA_CDR_DEFAULT	(SJA_CDR_CBP | SJA_CDR_CLK_OFF)
> +#define SJA_OCR_DEFAULT	SJA_OCR_TX0_PUSHPULL

=46rom my point of view, better use a prefix unique to this driver.

> =20
>  static unsigned long port[MAXDEV];
>  static unsigned long mem[MAXDEV];
> @@ -66,14 +66,14 @@ MODULE_PARM_DESC(clk, "External oscillator clock fr=
equency "
> =20
>  module_param_array(cdr, byte, NULL, S_IRUGO);
>  MODULE_PARM_DESC(cdr, "Clock divider register "
> -		 "(default=3D0x48 [CDR_CBP | CDR_CLK_OFF])");
> +		 "(default=3D0x48 [SJA_CDR_CBP | SJA_CDR_CLK_OFF])");
> =20
>  module_param_array(ocr, byte, NULL, S_IRUGO);
>  MODULE_PARM_DESC(ocr, "Output control register "
> -		 "(default=3D0x18 [OCR_TX0_PUSHPULL])");
> +		 "(default=3D0x18 [SJA_OCR_TX0_PUSHPULL])");
> =20
> -#define SJA1000_IOSIZE          0x20
> -#define SJA1000_IOSIZE_INDIRECT 0x02
> +#define SJA_IOSIZE          0x20
> +#define SJA_IOSIZE_INDIRECT 0x02

dito

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2NOVELEADASXWJPUMWUVK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlFehLMACgkQjTAFq1RaXHMwLQCdHgFnmEL3rAZCJ5XVt6iPd6Jt
68AAn3mGKqTbYInILU51nVty/8xvdhh+
=w62M
-----END PGP SIGNATURE-----

------enig2NOVELEADASXWJPUMWUVK--
