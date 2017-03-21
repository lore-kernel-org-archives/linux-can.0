From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 2/3] can: m_can: Enable M_CAN IP version dependent
 initialization
Date: Tue, 21 Mar 2017 15:33:52 +0100
Message-ID: <373beaf7-5c07-0b07-e261-f2b74d1ee088@pengutronix.de>
References: <1489154417-19669-1-git-send-email-mario.huettel@de.bosch.com>
 <1489154417-19669-4-git-send-email-mario.huettel@de.bosch.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="jwWEVWkl3uo9UCEkGClfOIA2NvuNox1Aa"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:35091 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933081AbdCUOeF (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 21 Mar 2017 10:34:05 -0400
In-Reply-To: <1489154417-19669-4-git-send-email-mario.huettel@de.bosch.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mario Huettel <mario.huettel@de.bosch.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jwWEVWkl3uo9UCEkGClfOIA2NvuNox1Aa
Content-Type: multipart/mixed; boundary="Sos5udx41gDPTHaU3Fr3BfN4nAFOvARik";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Mario Huettel <mario.huettel@de.bosch.com>, linux-can@vger.kernel.org
Message-ID: <373beaf7-5c07-0b07-e261-f2b74d1ee088@pengutronix.de>
Subject: Re: [PATCH 2/3] can: m_can: Enable M_CAN IP version dependent
 initialization
References: <1489154417-19669-1-git-send-email-mario.huettel@de.bosch.com>
 <1489154417-19669-4-git-send-email-mario.huettel@de.bosch.com>
In-Reply-To: <1489154417-19669-4-git-send-email-mario.huettel@de.bosch.com>

--Sos5udx41gDPTHaU3Fr3BfN4nAFOvARik
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/10/2017 03:00 PM, Mario Huettel wrote:
> This patch adapts the initialization of the M_CAN. So it can be used wi=
th
> all versions >=3D 3.0.x.
>=20
> Changes:
> * Implemented new enum that represents the supported core versions.
> * Added version element to m_can_priv structure to hold M_CAN version.
> * Renamed bittiming structs for version 3.0.x
> * Added new bittiming structs for version >=3D 3.1.x
> * Function alloc_m_can_dev takes 2 new arguments. The TX FIFO size and =
the
>   base address of the module.
> * Versions >=3D 3.1.x use multiple echo_skb buffers. This depends on th=
e
>   TX FIFO size configured in the device tree. Because this info is need=
ed
>   by alloc_m_can_dev, parts of the M_RAM configuration are moved before=

>   the call of alloc_m_can_dev. This also changes the parameters of the
>   m_can_of_parse_mram function.

Please move the code, that adds support for TX_FIFO into a seperate patch=
=2E

> * Chip configuaration for CAN_CTRLMODE_LOOPBACK is changed: Enabled
>   CCCR_MON bit. In combination with TEST_LBCK it activates the internal=

>   loopback mode. Leaving CCCR_MON '0' results in external loopback mode=
=2E

> * Clocks are temporarily enabled by platform_propbe function in order t=
o
>   allow read access to the Core Release register and the Control Regist=
er.
>   Registers are used to detect M_CAN version and optional Non-ISO Featu=
re.

> Initialization of M_CAN for version >=3D 3.1.x:
> * TX FIFO of M_CAN is used to transmit frames. The driver does not need=
 to
>   stop the tx queue after each frame sent.
> * Initialization of TX Event FIFO is added.
> * NON-ISO is fixed for all M_CAN versions < 3.2.x. Version 3.2.x _can_ =
have
>   the NISO (Non-ISO) bit which can switch the mode of the M_CAN to Non-=
ISO
>   mode. This bit does not have to be writeable. Therefore it is checked=
=2E
>   If it is writable Non-ISO support is added to the controllers support=
ed
>   CAN modes.
>=20
> New Functions:
> * Function to read TXE (Transmit Event) FIFO. Will be used later.
> * Function to check, if TXE FIFO is full.
> * Function to check the Core Release version. The read value determines=
 the
>   behaviour of the driver.
> * Function to check if the NISO bit for version >=3D 3.2.x is implement=
ed.
>=20
> Signed-off-by: Mario Huettel <mario.huettel@de.bosch.com>

> ---
>  drivers/net/can/m_can/m_can.c | 418 ++++++++++++++++++++++++++++++++++=
--------
>  1 file changed, 342 insertions(+), 76 deletions(-)
>=20
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_ca=
n.c
> index f2656a3..1538944 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -107,6 +107,21 @@ enum m_can_mram_cfg {
>  	MRAM_CFG_NUM,
>  };
> =20
> +enum m_can_versions {
> +	M_CAN_UNKNOWN_VERSION =3D 0,
> +	M_CAN_V30X,
> +	M_CAN_V31X,
> +	M_CAN_V32X
> +};

Please use a common naming scheme here:

enum m_can_version {
	M_CAN_VERSION_UNKNOWN,
	M_CAN_VERSION_30X,
	M_CAN_VERSION_31X,
	...,
};

It's probably easier for the rest of the code to remove the
M_CAN_VERSION_UNKNOWN from that enum and handle unknown versions differen=
t.

> +
> +/* Core Release Register (CREL) */
> +#define CREL_REL_SHIFT		28
> +#define CREL_REL_MASK		(0xF << CREL_REL_SHIFT)
> +#define CREL_STEP_SHIFT		24
> +#define CREL_STEP_MASK		(0xF << CREL_STEP_SHIFT)
> +#define CREL_SUBSTEP_SHIFT	20
> +#define CREL_SUBSTEP_MASK	(0xF << CREL_SUBSTEP_SHIFT)
> +
>  /* Data Bit Timing & Prescaler Register (DBTP) */
>  #define DBTP_TDC		BIT(23)
>  #define DBTP_DBRP_SHIFT		16
> @@ -342,6 +357,7 @@ struct m_can_priv {
>  	struct clk *cclk;
>  	void __iomem *base;
>  	u32 irqstatus;
> +	enum m_can_versions version;
> =20
>  	/* message ram configuration */
>  	void __iomem *mram_base;
> @@ -373,6 +389,22 @@ static inline void m_can_fifo_write(const struct m=
_can_priv *priv,
>  	       fpi * TXB_ELEMENT_SIZE + offset);
>  }
> =20
> +static inline u32 m_can_txe_fifo_read(const struct m_can_priv *priv,
> +				      u32 fgi,
> +				      u32 offset) {

int or unsigned int instead of u32, please put the fgi and the offset
into one line.

Please put the '{' into a new line.

> +	return readl(priv->mram_base + priv->mcfg[MRAM_TXE].off +
> +			fgi * TXE_ELEMENT_SIZE + offset);
> +}
> +
> +/* Check if TX fifo is full
> + * returns 0 if free
> + * returns 1 if occupied

just return true/false

> + */
> +static inline int m_can_tx_fifo_full(const struct m_can_priv *priv)

bool

> +{
> +		return !!(m_can_read(priv, M_CAN_TXFQS) & TXFQS_TFQF);
                       ^^ can be removed if it's returning a bool
> +}
> +
>  static inline void m_can_config_endisable(const struct m_can_priv *pri=
v,
>  					  bool enable)
>  {
> @@ -833,7 +865,7 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)=

>  	return IRQ_HANDLED;
>  }
> =20
> -static const struct can_bittiming_const m_can_bittiming_const =3D {
> +static const struct can_bittiming_const m_can_30X_bittiming_const =3D =
{

Please move the version to the end of the variable, e.g.:
m_can_bittiming_cost_30X

>  	.name =3D KBUILD_MODNAME,
>  	.tseg1_min =3D 2,		/* Time segment 1 =3D prop_seg + phase_seg1 */
>  	.tseg1_max =3D 64,
> @@ -845,7 +877,7 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)=

>  	.brp_inc =3D 1,
>  };
> =20
> -static const struct can_bittiming_const m_can_data_bittiming_const =3D=
 {
> +static const struct can_bittiming_const m_can_30X_data_bittiming_const=
 =3D {
>  	.name =3D KBUILD_MODNAME,
>  	.tseg1_min =3D 2,		/* Time segment 1 =3D prop_seg + phase_seg1 */
>  	.tseg1_max =3D 16,
> @@ -857,6 +889,30 @@ static irqreturn_t m_can_isr(int irq, void *dev_id=
)
>  	.brp_inc =3D 1,
>  };
> =20
> +static const struct can_bittiming_const m_can_31X_bittiming_const =3D =
{
> +	.name =3D KBUILD_MODNAME,
> +	.tseg1_min =3D 2,		/* Time segment 1 =3D prop_seg + phase_seg1 */
> +	.tseg1_max =3D 256,
> +	.tseg2_min =3D 1,		/* Time segment 2 =3D phase_seg2 */
> +	.tseg2_max =3D 128,
> +	.sjw_max =3D 128,
> +	.brp_min =3D 1,
> +	.brp_max =3D 512,
> +	.brp_inc =3D 1,
> +};
> +
> +static const struct can_bittiming_const m_can_31X_data_bittiming_const=
 =3D {
> +	.name =3D KBUILD_MODNAME,
> +	.tseg1_min =3D 1,		/* Time segment 1 =3D prop_seg + phase_seg1 */
> +	.tseg1_max =3D 32,
> +	.tseg2_min =3D 1,		/* Time segment 2 =3D phase_seg2 */
> +	.tseg2_max =3D 16,
> +	.sjw_max =3D 16,
> +	.brp_min =3D 1,
> +	.brp_max =3D 32,
> +	.brp_inc =3D 1,
> +};
> +
>  static int m_can_set_bittiming(struct net_device *dev)
>  {
>  	struct m_can_priv *priv =3D netdev_priv(dev);
> @@ -892,6 +948,7 @@ static int m_can_set_bittiming(struct net_device *d=
ev)
>   * - configure rx fifo
>   * - accept non-matching frame into fifo 0
>   * - configure tx buffer
> + *		- >=3D v3.1.x: TX FIFO is used
>   * - configure mode
>   * - setup bittiming
>   */
> @@ -908,15 +965,32 @@ static void m_can_chip_config(struct net_device *=
dev)
>  	/* Accept Non-matching Frames Into FIFO 0 */
>  	m_can_write(priv, M_CAN_GFC, 0x0);
> =20
> -	/* only support one Tx Buffer currently */
> -	m_can_write(priv, M_CAN_TXBC, (1 << TXBC_NDTB_SHIFT) |
> -		    priv->mcfg[MRAM_TXB].off);

Use a switch statement here:

> +	if (priv->version =3D=3D M_CAN_V30X) {
> +		/* only support one Tx Buffer currently */
> +		m_can_write(priv, M_CAN_TXBC, (1 << TXBC_NDTB_SHIFT) |
> +				priv->mcfg[MRAM_TXB].off);
> +	} else if (priv->version =3D=3D M_CAN_V31X ||
> +		   priv->version =3D=3D M_CAN_V32X) {
> +		/* TX FIFO is used for newer IP Core versions */
> +		m_can_write(priv, M_CAN_TXBC,
> +			    (priv->mcfg[MRAM_TXB].num << TXBC_TFQS_SHIFT) |
> +			    (priv->mcfg[MRAM_TXB].off));
> +	}
> =20
>  	/* support 64 bytes payload */
>  	m_can_write(priv, M_CAN_TXESC, TXESC_TBDS_64BYTES);
> =20
> -	m_can_write(priv, M_CAN_TXEFC, (1 << TXEFC_EFS_SHIFT) |
> -		    priv->mcfg[MRAM_TXE].off);
> +	/* TX Event FIFO */
> +	if (priv->version =3D=3D M_CAN_V30X) {

use switch()

> +		m_can_write(priv, M_CAN_TXEFC, (1 << TXEFC_EFS_SHIFT) |
> +				priv->mcfg[MRAM_TXE].off);
> +	} else if (priv->version =3D=3D M_CAN_V31X || priv->version =3D=3D M_=
CAN_V32X) {
> +		/* Full TX Event FIFO is used */
> +		m_can_write(priv, M_CAN_TXEFC,
> +			    ((priv->mcfg[MRAM_TXE].num << TXEFC_EFS_SHIFT)
> +			     & TXEFC_EFS_MASK) |
> +			    priv->mcfg[MRAM_TXE].off);
> +	}
> =20
>  	/* rx fifo configuration, blocking mode, fifo size 1 */
>  	m_can_write(priv, M_CAN_RXF0C,
> @@ -928,22 +1002,50 @@ static void m_can_chip_config(struct net_device =
*dev)
>  		     priv->mcfg[MRAM_RXF1].off);
> =20
>  	cccr =3D m_can_read(priv, M_CAN_CCCR);
> -	cccr &=3D ~(CCCR_TEST | CCCR_MON | (CCCR_CMR_MASK << CCCR_CMR_SHIFT) =
|
> -		(CCCR_CME_MASK << CCCR_CME_SHIFT));
>  	test =3D m_can_read(priv, M_CAN_TEST);
>  	test &=3D ~TEST_LBCK;
> +	if (priv->version =3D=3D M_CAN_V30X) {

switch()

> =20
> -	if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
> -		cccr |=3D CCCR_MON;
> +		cccr &=3D ~(CCCR_TEST | CCCR_MON |
> +			(CCCR_CMR_MASK << CCCR_CMR_SHIFT) |
> +			(CCCR_CME_MASK << CCCR_CME_SHIFT));
> +
> +		if (priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK) {
> +			cccr |=3D CCCR_TEST;
> +			cccr |=3D CCCR_MON;
> +			test |=3D TEST_LBCK;
> +		}
> +
> +		if (priv->can.ctrlmode & CAN_CTRLMODE_FD)
> +			cccr |=3D CCCR_CME_CANFD_BRS << CCCR_CME_SHIFT;
> +
> +		m_can_write(priv, M_CAN_CCCR, cccr);
> +		m_can_write(priv, M_CAN_TEST, test);
> +
> +	} else {
> +	/* Version 3.1.X or 3.2.X */
> +		cccr &=3D ~(CCCR_TEST | CCCR_MON | CCCR_BRSE | CCCR_FDOE);
> +
> +		/* Only 3.2.X has NISO Bit implemented */
> +		if (priv->can.ctrlmode & CAN_CTRLMODE_FD_NON_ISO)
> +			cccr |=3D CCCR_NISO;
> +
> +		if (priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK) {
> +			cccr |=3D CCCR_TEST;
> +			cccr |=3D CCCR_MON;
> +			test |=3D TEST_LBCK;
> +		}
> +
> +		if (priv->can.ctrlmode & CAN_CTRLMODE_FD)
> +			cccr |=3D (CCCR_BRSE | CCCR_FDOE);
> =20
> -	if (priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK) {
> -		cccr |=3D CCCR_TEST;
> -		test |=3D TEST_LBCK;
>  	}
> =20
> -	if (priv->can.ctrlmode & CAN_CTRLMODE_FD)
> -		cccr |=3D CCCR_CME_CANFD_BRS << CCCR_CME_SHIFT;
> +	/* Enable Monitoring (all versions) */
> +	if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
> +		cccr |=3D CCCR_MON;
> =20
> +	/* Write config */
>  	m_can_write(priv, M_CAN_CCCR, cccr);
>  	m_can_write(priv, M_CAN_TEST, test);
> =20
> @@ -957,6 +1059,8 @@ static void m_can_chip_config(struct net_device *d=
ev)
>  	/* route all interrupts to INT0 */
>  	m_can_write(priv, M_CAN_ILS, ILS_ALL_INT0);
> =20
> +	/* Only 3.2.X has NISO Bit implemented */
> +	if (priv->can.ctrlmode & CAN_CTRLMODE_FD_NON_ISO)

This if () looks bogogus.

>  	/* set bittiming params */
>  	m_can_set_bittiming(dev);
> =20
> @@ -994,33 +1098,160 @@ static void free_m_can_dev(struct net_device *d=
ev)
>  	free_candev(dev);
>  }
> =20
> -static struct net_device *alloc_m_can_dev(void)
> +static int m_can_check_core_release(void * __iomem m_can_base)

If you integrate this into the caller, you can get rid of the need for
"M_CAN_UNKNOWN_VERSION".

> +{
> +	u32 crel_reg =3D 0;
> +	u8 rel =3D 0;
> +	u8 step =3D 0;

no need init init all these as 0.

> +	int res =3D 0;
enum
> +	struct m_can_priv temp_priv;
> +
> +	temp_priv.base =3D m_can_base;

Although this is quite hacky, this looks a bit better:

struct m_can_priv priv =3D {
	.base =3D m_can_base,
};

> +
> +	/* Read Core Release Version and split into version number
> +	 * Example: Version 3.2.1 =3D> rel =3D 3; step =3D 2; substep =3D 1;
> +	 */
> +	crel_reg =3D m_can_read((const struct m_can_priv *)&temp_priv,
> +			      M_CAN_CREL);

cast not needed

> +	rel =3D (u8)((crel_reg & CREL_REL_MASK) >> CREL_REL_SHIFT);
> +	step =3D (u8)((crel_reg & CREL_STEP_MASK) >> CREL_STEP_SHIFT);

cast not needed

> +
> +	if (rel =3D=3D 3) {

if (rel !=3D 3)
	return;

> +		switch (step) {
> +		case 0:
> +			/* Version 3.0.x */
> +			res =3D M_CAN_V30X;
> +			break;
> +		case 1:
> +			/* Version 3.1.x */
> +			res =3D M_CAN_V31X;
> +			break;
> +		case 2:
> +			/* Version 3.2.x */
> +			res =3D M_CAN_V32X;
> +			break;
> +		default:
> +			/* Unknown version */
> +			res =3D M_CAN_UNKNOWN_VERSION;

maybe print a dev_err() with the complete core release here?

> +			break;
> +		}
> +	} else {
> +		res =3D M_CAN_UNKNOWN_VERSION;
> +	}
> +

and a dev_dbg() with the found core release here?

> +	return res;
> +}
> +
> +/* Selectable Non ISO support only in version 3.2.x
> + * This function checks if the bit is writable.
> + */

Even if you have a v3.2.x you have to check if Non ISO is supported by
the core?

> +static int m_can_check_niso_support(const struct m_can_priv *priv)

static bool m_can_niso_supported()

> +{
> +	u32 cccr_reg;
> +	int timeout =3D 10;
> +	int niso_support =3D 0;
> +
> +	m_can_config_endisable(priv, true);
> +	cccr_reg =3D m_can_read(priv, M_CAN_CCCR);
> +	cccr_reg |=3D CCCR_NISO;
> +	m_can_write(priv, M_CAN_CCCR, cccr_reg);
> +
> +	while ((m_can_read(priv, M_CAN_CCCR) & (CCCR_NISO)) =3D=3D 0) {
> +		if (timeout =3D=3D 0) {
> +			/* NISO Flag could not be set NONISO not supported */
> +			/* Clear NISO to prevent errors */
> +			cccr_reg &=3D ~(CCCR_NISO);
> +			m_can_write(priv, M_CAN_CCCR, cccr_reg);
> +			niso_support =3D 0;
> +			goto return_niso;
> +		}
> +		timeout--;
> +		udelay(1);

make use of readl_poll_timeout(), see:

http://lxr.free-electrons.com/source/include/linux/iopoll.h

> +	}
> +	/* NISO Flag is set*/
> +	niso_support =3D 1;
> +	/* Clear NISO */
> +	cccr_reg &=3D ~(CCCR_NISO);
> +	m_can_write(priv, M_CAN_CCCR, cccr_reg);
> +
> +return_niso:
> +	m_can_config_endisable(priv, false);

> +	return niso_support;
> +}
> +
> +static struct net_device *alloc_m_can_dev(void __iomem *addr, u32 tx_f=
ifo_size)

hmm, what about integrating this into the probe function, I find the
separation arbitrary.

>  {
>  	struct net_device *dev;
>  	struct m_can_priv *priv;
> +	int m_can_version =3D M_CAN_UNKNOWN_VERSION;
enum
> +	int niso_bit_supported =3D 0;
> +	unsigned int loopback_buffer_count;
> +
> +	m_can_version =3D m_can_check_core_release(addr);


> +	/* return if unsupported version */
> +	if (m_can_version =3D=3D M_CAN_UNKNOWN_VERSION) {
> +		dev =3D NULL;
> +		goto return_dev;
> +	}
> =20
> -	dev =3D alloc_candev(sizeof(*priv), 1);
> -	if (!dev)
> -		return NULL;
> +	/* If version < 3.1.x, then only one loopback buffer is used */
> +	loopback_buffer_count =3D ((m_can_version =3D=3D M_CAN_V30X)

it's not a loopback_buffer it's a tx_buffer

> +				? 1U
> +				: (unsigned int)tx_fifo_size);
                                  ^^^^^^^^^^^^^^
the cast should not be needed here

please use if (m_can_version =3D=3D M_CAN_V30X), or a switch() here

> =20
> +	dev =3D alloc_candev(sizeof(*priv), loopback_buffer_count);
> +	if (!dev) {
> +		dev =3D NULL;
> +		goto return_dev;
> +	}
>  	priv =3D netdev_priv(dev);
>  	netif_napi_add(dev, &priv->napi, m_can_poll, M_CAN_NAPI_WEIGHT);
> =20
> +	/* Shared properties of all M_CAN versions */
> +	priv->version =3D m_can_version;
>  	priv->dev =3D dev;
> -	priv->can.bittiming_const =3D &m_can_bittiming_const;
> -	priv->can.data_bittiming_const =3D &m_can_data_bittiming_const;
> +	priv->base =3D addr;
>  	priv->can.do_set_mode =3D m_can_set_mode;
>  	priv->can.do_get_berr_counter =3D m_can_get_berr_counter;
> =20
> -	/* CAN_CTRLMODE_FD_NON_ISO is fixed with M_CAN IP v3.0.1 */
> -	can_set_static_ctrlmode(dev, CAN_CTRLMODE_FD_NON_ISO);
> =20
> -	/* CAN_CTRLMODE_FD_NON_ISO can not be changed with M_CAN IP v3.0.1 */=

> -	priv->can.ctrlmode_supported =3D CAN_CTRLMODE_LOOPBACK |
> -					CAN_CTRLMODE_LISTENONLY |
> -					CAN_CTRLMODE_BERR_REPORTING |
> -					CAN_CTRLMODE_FD;
> =20
> +	/* Set properties depending on M_CAN version */
> +	switch (priv->version) {
> +	case M_CAN_V30X:
> +		priv->can.bittiming_const =3D &m_can_30X_bittiming_const;
> +		priv->can.data_bittiming_const =3D
> +				&m_can_30X_data_bittiming_const;
> +		/* CAN_CTRLMODE_FD_NON_ISO is fixed with M_CAN IP v3.0.x */
                                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Is it fixed with 3.0 or 3.1?

> +		can_set_static_ctrlmode(dev, CAN_CTRLMODE_FD_NON_ISO);
> +		break;
> +	case M_CAN_V31X:
> +		/* CAN_CTRLMODE_FD_NON_ISO is fixed with M_CAN IP v3.1.x */
                                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +		can_set_static_ctrlmode(dev, CAN_CTRLMODE_FD_NON_ISO);
> +		priv->can.bittiming_const =3D &m_can_31X_bittiming_const;
> +		priv->can.data_bittiming_const =3D
> +				&m_can_31X_data_bittiming_const;

please reorder these assignments and calls to have the same order as in
case M_CAN_V30X.

> +		break;
> +	case M_CAN_V32X:
> +		priv->can.bittiming_const =3D &m_can_31X_bittiming_const;
> +		priv->can.data_bittiming_const =3D
> +				&m_can_31X_data_bittiming_const;
> +		niso_bit_supported =3D m_can_check_niso_support(priv);

why not directly set priv->can.ctrlmode_supported here?
		if (m_can_niso_suppored(priv))
			priv->can.ctrlmode_supported |=3D
				CAN_CTRLMODE_FD_NON_ISO;

> +		break;
> +	default:
> +		/* This does not happen */
> +		break;
> +	}
> +
> +	/* Set M_CAN supported operations */
> +	priv->can.ctrlmode_supported =3D CAN_CTRLMODE_LOOPBACK |
> +			CAN_CTRLMODE_LISTENONLY |
> +			CAN_CTRLMODE_BERR_REPORTING |
> +			CAN_CTRLMODE_FD |
> +			(niso_bit_supported =3D=3D 1
> +			 ? CAN_CTRLMODE_FD_NON_ISO
> +			 : 0);

Move this to the beginning, without the niso_bit_supported.

> +return_dev:
>  	return dev;
>  }
> =20
> @@ -1167,58 +1398,39 @@ static int register_m_can_dev(struct net_device=
 *dev)
>  	return register_candev(dev);
>  }
> =20
> -static int m_can_of_parse_mram(struct platform_device *pdev,
> -			       struct m_can_priv *priv)
> +static void m_can_of_parse_mram(void __iomem *m_ram_base,
> +				const u32 *mram_config_vals,
> +				struct m_can_priv *priv)

please use priv as first pointer, assign the m_ram_base outside and pass
mram_config_vals as 2nd parameter.

>  {
> -	struct device_node *np =3D pdev->dev.of_node;
> -	struct resource *res;
> -	void __iomem *addr;
> -	u32 out_val[MRAM_CFG_LEN];
> -	int i, start, end, ret;
> -
> -	/* message ram could be shared */
> -	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "message_r=
am");
> -	if (!res)
> -		return -ENODEV;
> +	int i, start, end;
> =20
> -	addr =3D devm_ioremap(&pdev->dev, res->start, resource_size(res));
> -	if (!addr)
> -		return -ENOMEM;
> -
> -	/* get message ram configuration */
> -	ret =3D of_property_read_u32_array(np, "bosch,mram-cfg",
> -					 out_val, sizeof(out_val) / 4);
ARRAY_SIZE instead of "sizeof(out_val) / 4"
> -	if (ret) {
> -		dev_err(&pdev->dev, "can not get message ram configuration\n");
> -		return -ENODEV;
> -	}
> -
> -	priv->mram_base =3D addr;
> -	priv->mcfg[MRAM_SIDF].off =3D out_val[0];
> -	priv->mcfg[MRAM_SIDF].num =3D out_val[1];
> +	priv->mram_base =3D m_ram_base;
> +	priv->mcfg[MRAM_SIDF].off =3D mram_config_vals[0];
> +	priv->mcfg[MRAM_SIDF].num =3D mram_config_vals[1];
>  	priv->mcfg[MRAM_XIDF].off =3D priv->mcfg[MRAM_SIDF].off +
>  			priv->mcfg[MRAM_SIDF].num * SIDF_ELEMENT_SIZE;
> -	priv->mcfg[MRAM_XIDF].num =3D out_val[2];
> +	priv->mcfg[MRAM_XIDF].num =3D mram_config_vals[2];
>  	priv->mcfg[MRAM_RXF0].off =3D priv->mcfg[MRAM_XIDF].off +
>  			priv->mcfg[MRAM_XIDF].num * XIDF_ELEMENT_SIZE;
> -	priv->mcfg[MRAM_RXF0].num =3D out_val[3] &
> +	priv->mcfg[MRAM_RXF0].num =3D mram_config_vals[3] &
>  			(RXFC_FS_MASK >> RXFC_FS_SHIFT);
>  	priv->mcfg[MRAM_RXF1].off =3D priv->mcfg[MRAM_RXF0].off +
>  			priv->mcfg[MRAM_RXF0].num * RXF0_ELEMENT_SIZE;
> -	priv->mcfg[MRAM_RXF1].num =3D out_val[4] &
> +	priv->mcfg[MRAM_RXF1].num =3D mram_config_vals[4] &
>  			(RXFC_FS_MASK >> RXFC_FS_SHIFT);
>  	priv->mcfg[MRAM_RXB].off =3D priv->mcfg[MRAM_RXF1].off +
>  			priv->mcfg[MRAM_RXF1].num * RXF1_ELEMENT_SIZE;
> -	priv->mcfg[MRAM_RXB].num =3D out_val[5];
> +	priv->mcfg[MRAM_RXB].num =3D mram_config_vals[5];
>  	priv->mcfg[MRAM_TXE].off =3D priv->mcfg[MRAM_RXB].off +
>  			priv->mcfg[MRAM_RXB].num * RXB_ELEMENT_SIZE;
> -	priv->mcfg[MRAM_TXE].num =3D out_val[6];
> +	priv->mcfg[MRAM_TXE].num =3D mram_config_vals[6];
>  	priv->mcfg[MRAM_TXB].off =3D priv->mcfg[MRAM_TXE].off +
>  			priv->mcfg[MRAM_TXE].num * TXE_ELEMENT_SIZE;
> -	priv->mcfg[MRAM_TXB].num =3D out_val[7] &
> +	priv->mcfg[MRAM_TXB].num =3D mram_config_vals[7] &
>  			(TXBC_NDTB_MASK >> TXBC_NDTB_SHIFT);
> =20
> -	dev_dbg(&pdev->dev, "mram_base %p sidf 0x%x %d xidf 0x%x %d rxf0 0x%x=
 %d rxf1 0x%x %d rxb 0x%x %d txe 0x%x %d txb 0x%x %d\n",
> +	dev_dbg(priv->device,
> +		"mram_base %p sidf 0x%x %d xidf 0x%x %d rxf0 0x%x %d rxf1 0x%x %d rx=
b 0x%x %d txe 0x%x %d txb 0x%x %d\n",
>  		priv->mram_base,
>  		priv->mcfg[MRAM_SIDF].off, priv->mcfg[MRAM_SIDF].num,
>  		priv->mcfg[MRAM_XIDF].off, priv->mcfg[MRAM_XIDF].num,
> @@ -1237,7 +1449,6 @@ static int m_can_of_parse_mram(struct platform_de=
vice *pdev,
>  	for (i =3D start; i < end; i +=3D 4)
>  		writel(0x0, priv->mram_base + i);
> =20
> -	return 0;
>  }
> =20
>  static int m_can_plat_probe(struct platform_device *pdev)
> @@ -1246,38 +1457,85 @@ static int m_can_plat_probe(struct platform_dev=
ice *pdev)
>  	struct m_can_priv *priv;
>  	struct resource *res;
>  	void __iomem *addr;
> +	void __iomem *mram_addr;
>  	struct clk *hclk, *cclk;
>  	int irq, ret;
> +	struct device_node *np;
> +	u32 mram_config_vals[MRAM_CFG_LEN];
> +	u32 tx_fifo_size;
> +
> +	np =3D pdev->dev.of_node;
> =20
>  	hclk =3D devm_clk_get(&pdev->dev, "hclk");
>  	cclk =3D devm_clk_get(&pdev->dev, "cclk");
> +
>  	if (IS_ERR(hclk) || IS_ERR(cclk)) {
>  		dev_err(&pdev->dev, "no clock found\n");
> -		return -ENODEV;
> +		ret =3D -ENODEV;
> +		goto failed_ret;
>  	}
> =20
> +	/* Enable clocks. Necessary to read Core Release in order to determin=
e
> +	 * M_CAN version
> +	 */
> +	ret =3D clk_prepare_enable(hclk);
> +	if (ret)
> +		goto disable_hclk_ret;
> +
> +	ret =3D clk_prepare_enable(cclk);
> +	if (ret)
> +		goto disable_cclk_ret;
> +
>  	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "m_can");
>  	addr =3D devm_ioremap_resource(&pdev->dev, res);
>  	irq =3D platform_get_irq_byname(pdev, "int0");
> -	if (IS_ERR(addr) || irq < 0)
> -		return -EINVAL;
> =20
> -	/* allocate the m_can device */
> -	dev =3D alloc_m_can_dev();
> -	if (!dev)
> -		return -ENOMEM;
> +	if (IS_ERR(addr) || irq < 0) {
> +		ret =3D -EINVAL;
> +		goto disable_cclk_ret;
> +	}
> +
> +	/* message ram could be shared */
> +	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "message_r=
am");
> +	if (!res) {
> +		ret =3D -ENODEV;
> +		goto disable_cclk_ret;
> +	}
> +
> +	mram_addr =3D devm_ioremap(&pdev->dev, res->start, resource_size(res)=
);
> +	if (!mram_addr) {
> +		ret =3D -ENOMEM;
> +		goto disable_cclk_ret;
> +	}
> =20
> +	/* get message ram configuration */
> +	ret =3D of_property_read_u32_array(np, "bosch,mram-cfg",
> +					 mram_config_vals,
> +					 sizeof(mram_config_vals) / 4);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Could not get Message RAM configuration.");
> +		goto disable_cclk_ret;
> +	}
> +
> +	/* Get TX FIFO size
> +	 * Defines the total amount of echo buffers for loopback
> +	 */
> +	tx_fifo_size =3D mram_config_vals[7];
> +
> +	/* allocate the m_can device */
> +	dev =3D alloc_m_can_dev(addr, tx_fifo_size);
> +	if (!dev) {
> +		ret =3D -ENOMEM;
> +		goto disable_cclk_ret;
> +	}
>  	priv =3D netdev_priv(dev);
>  	dev->irq =3D irq;
> -	priv->base =3D addr;
>  	priv->device =3D &pdev->dev;
>  	priv->hclk =3D hclk;
>  	priv->cclk =3D cclk;
>  	priv->can.clock.freq =3D clk_get_rate(cclk);
> =20
> -	ret =3D m_can_of_parse_mram(pdev, priv);
> -	if (ret)
> -		goto failed_free_dev;
> +	m_can_of_parse_mram(mram_addr, mram_config_vals, priv);
> =20
>  	platform_set_drvdata(pdev, dev);
>  	SET_NETDEV_DEV(dev, &pdev->dev);
> @@ -1294,10 +1552,18 @@ static int m_can_plat_probe(struct platform_dev=
ice *pdev)
>  	dev_info(&pdev->dev, "%s device registered (regs=3D%p, irq=3D%d)\n",
>  		 KBUILD_MODNAME, priv->base, dev->irq);
> =20
> -	return 0;
> +	/* Probe finished
> +	 * Stop clocks. They will be reactivated once the M_CAN device is ope=
ned
> +	 */
> +	goto disable_cclk_ret;
> =20
>  failed_free_dev:
>  	free_m_can_dev(dev);
> +disable_cclk_ret:
> +	clk_disable_unprepare(cclk);
> +disable_hclk_ret:
> +	clk_disable_unprepare(hclk);
> +failed_ret:
>  	return ret;
>  }
> =20
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--Sos5udx41gDPTHaU3Fr3BfN4nAFOvARik--

--jwWEVWkl3uo9UCEkGClfOIA2NvuNox1Aa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAljROdAACgkQHv7KIOw4
HPaLygf/eWg+eTfdL68vYUV03M/GV4eJJqMBC35fp1HlYp95PDDCEpyVdGHpFeV+
BkBMop7OwnoIxuR52qfFQY8pmeCtTuR5bojNWJoF3ct4Zna9u2+Z4h2i5QlFDcwY
ijViaMUZ/5+7MDi8035MCjo9X3GgSZwoeMELhuFLIqLyw6k0960tvXYZy3h8y2X8
t/kSTGTTVe/d+yNN9t6V4rBVX7OqJL4/7ldwVPPEgkQRm+pGZPsjXyWa0XWy/FK3
Yjuw9FwZhhNRmyWjTdZCiEN3Eg/RMjtynvBZYD6EKvDoeDQObNwoLrF0E1HCOnG7
GjDlecRDXT5bxC+vqHaCDnEn/1AyMg==
=dUvm
-----END PGP SIGNATURE-----

--jwWEVWkl3uo9UCEkGClfOIA2NvuNox1Aa--
