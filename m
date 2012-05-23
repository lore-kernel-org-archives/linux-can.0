From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [RESEND PATCH v3 4/5] can: c_can: Move overlay structure to array
 with offset as index
Date: Wed, 23 May 2012 11:56:43 +0200
Message-ID: <4FBCB45B.7060002@pengutronix.de>
References: <1337765788-1169-1-git-send-email-anilkumar@ti.com> <1337765788-1169-5-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9E1B6C2942E46C115264A361"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53823 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757395Ab2EWJ46 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 23 May 2012 05:56:58 -0400
In-Reply-To: <1337765788-1169-5-git-send-email-anilkumar@ti.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: AnilKumar Ch <anilkumar@ti.com>
Cc: wg@grandegger.com, linux-can@vger.kernel.org, anantgole@ti.com, nsekhar@ti.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9E1B6C2942E46C115264A361
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 05/23/2012 11:36 AM, AnilKumar Ch wrote:
> c_can uses overlay structure for accessing c_can module registers.
> With this kind of implementation it is difficult to add one more ip
> which is similar to c_can in functionality but different register
> offsets.
>=20
> This patch changes the overlay structure implementation to an array
> with register offset as index. This way we can overcome the above
> limitation.
>=20
> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>

Small nitpick inside. I'll compile test it this evening.

regards, Marc
> ---
> Link to previous submission
> 	http://marc.info/?l=3Dlinux-can&m=3D133690316727299&w=3D2
>=20
>  drivers/net/can/c_can/c_can.c          |  120 ++++++++++++++++--------=
-------
>  drivers/net/can/c_can/c_can.h          |  118 +++++++++++++++++++++---=
-------
>  drivers/net/can/c_can/c_can_platform.c |   23 +++---
>  3 files changed, 154 insertions(+), 107 deletions(-)
>=20
> diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_ca=
n.c
> index 8dc84d6..21b5d5e 100644
> --- a/drivers/net/can/c_can/c_can.c
> +++ b/drivers/net/can/c_can/c_can.c
> @@ -41,6 +41,10 @@
> =20
>  #include "c_can.h"
> =20
> +/* Number of interface registers */
> +#define IF_ENUM_REG_LEN 11
                          ^
For consistency please use the C_CAN prefix you used in all defines.
Please use a tab instead of space.

> +#define C_CAN_IFACE(reg, iface)	(C_CAN_IF1_##reg + iface * IF_ENUM_REG=
_LEN)

Better put iface in "()".

> +
>  /* control register */
>  #define CONTROL_TEST		BIT(7)
>  #define CONTROL_CCE		BIT(6)
> @@ -209,10 +213,10 @@ static inline int get_tx_echo_msg_obj(const struc=
t c_can_priv *priv)
>  			C_CAN_MSG_OBJ_TX_FIRST;
>  }
> =20
> -static u32 c_can_read_reg32(struct c_can_priv *priv, void *reg)
> +static u32 c_can_read_reg32(struct c_can_priv *priv, enum reg index)
>  {
> -	u32 val =3D priv->read_reg(priv, reg);
> -	val |=3D ((u32) priv->read_reg(priv, reg + 2)) << 16;
> +	u32 val =3D priv->read_reg(priv, index);
> +	val |=3D ((u32) priv->read_reg(priv, index + 1)) << 16;
>  	return val;
>  }
> =20
> @@ -220,14 +224,14 @@ static void c_can_enable_all_interrupts(struct c_=
can_priv *priv,
>  						int enable)
>  {
>  	unsigned int cntrl_save =3D priv->read_reg(priv,
> -						&priv->regs->control);
> +						C_CAN_CTRL_REG);
> =20
>  	if (enable)
>  		cntrl_save |=3D (CONTROL_SIE | CONTROL_EIE | CONTROL_IE);
>  	else
>  		cntrl_save &=3D ~(CONTROL_EIE | CONTROL_IE | CONTROL_SIE);
> =20
> -	priv->write_reg(priv, &priv->regs->control, cntrl_save);
> +	priv->write_reg(priv, C_CAN_CTRL_REG, cntrl_save);
>  }
> =20
>  static inline int c_can_msg_obj_is_busy(struct c_can_priv *priv, int i=
face)
> @@ -235,7 +239,7 @@ static inline int c_can_msg_obj_is_busy(struct c_ca=
n_priv *priv, int iface)
>  	int count =3D MIN_TIMEOUT_VALUE;
> =20
>  	while (count && priv->read_reg(priv,
> -				&priv->regs->ifregs[iface].com_req) &
> +				C_CAN_IFACE(COMREQ_REG, iface)) &
>  				IF_COMR_BUSY) {
>  		count--;
>  		udelay(1);
> @@ -258,9 +262,9 @@ static inline void c_can_object_get(struct net_devi=
ce *dev,
>  	 * register and message RAM must be complete in 6 CAN-CLK
>  	 * period.
>  	 */
> -	priv->write_reg(priv, &priv->regs->ifregs[iface].com_mask,
> +	priv->write_reg(priv, C_CAN_IFACE(COMMSK_REG, iface),
>  			IFX_WRITE_LOW_16BIT(mask));
> -	priv->write_reg(priv, &priv->regs->ifregs[iface].com_req,
> +	priv->write_reg(priv, C_CAN_IFACE(COMREQ_REG, iface),
>  			IFX_WRITE_LOW_16BIT(objno));
> =20
>  	if (c_can_msg_obj_is_busy(priv, iface))
> @@ -278,9 +282,9 @@ static inline void c_can_object_put(struct net_devi=
ce *dev,
>  	 * register and message RAM must be complete in 6 CAN-CLK
>  	 * period.
>  	 */
> -	priv->write_reg(priv, &priv->regs->ifregs[iface].com_mask,
> +	priv->write_reg(priv, C_CAN_IFACE(COMMSK_REG, iface),
>  			(IF_COMM_WR | IFX_WRITE_LOW_16BIT(mask)));
> -	priv->write_reg(priv, &priv->regs->ifregs[iface].com_req,
> +	priv->write_reg(priv, C_CAN_IFACE(COMREQ_REG, iface),
>  			IFX_WRITE_LOW_16BIT(objno));
> =20
>  	if (c_can_msg_obj_is_busy(priv, iface))
> @@ -306,18 +310,18 @@ static void c_can_write_msg_object(struct net_dev=
ice *dev,
> =20
>  	flags |=3D IF_ARB_MSGVAL;
> =20
> -	priv->write_reg(priv, &priv->regs->ifregs[iface].arb1,
> +	priv->write_reg(priv, C_CAN_IFACE(ARB1_REG, iface),
>  				IFX_WRITE_LOW_16BIT(id));
> -	priv->write_reg(priv, &priv->regs->ifregs[iface].arb2, flags |
> +	priv->write_reg(priv, C_CAN_IFACE(ARB2_REG, iface), flags |
>  				IFX_WRITE_HIGH_16BIT(id));
> =20
>  	for (i =3D 0; i < frame->can_dlc; i +=3D 2) {
> -		priv->write_reg(priv, &priv->regs->ifregs[iface].data[i / 2],
> +		priv->write_reg(priv, C_CAN_IFACE(DATA1_REG, iface) + i / 2,
>  				frame->data[i] | (frame->data[i + 1] << 8));
>  	}
> =20
>  	/* enable interrupt for this message object */
> -	priv->write_reg(priv, &priv->regs->ifregs[iface].msg_cntrl,
> +	priv->write_reg(priv, C_CAN_IFACE(MSGCTRL_REG, iface),
>  			IF_MCONT_TXIE | IF_MCONT_TXRQST | IF_MCONT_EOB |
>  			frame->can_dlc);
>  	c_can_object_put(dev, iface, objno, IF_COMM_ALL);
> @@ -329,7 +333,7 @@ static inline void c_can_mark_rx_msg_obj(struct net=
_device *dev,
>  {
>  	struct c_can_priv *priv =3D netdev_priv(dev);
> =20
> -	priv->write_reg(priv, &priv->regs->ifregs[iface].msg_cntrl,
> +	priv->write_reg(priv, C_CAN_IFACE(MSGCTRL_REG, iface),
>  			ctrl_mask & ~(IF_MCONT_MSGLST | IF_MCONT_INTPND));
>  	c_can_object_put(dev, iface, obj, IF_COMM_CONTROL);
> =20
> @@ -343,7 +347,7 @@ static inline void c_can_activate_all_lower_rx_msg_=
obj(struct net_device *dev,
>  	struct c_can_priv *priv =3D netdev_priv(dev);
> =20
>  	for (i =3D C_CAN_MSG_OBJ_RX_FIRST; i <=3D C_CAN_MSG_RX_LOW_LAST; i++)=
 {
> -		priv->write_reg(priv, &priv->regs->ifregs[iface].msg_cntrl,
> +		priv->write_reg(priv, C_CAN_IFACE(MSGCTRL_REG, iface),
>  				ctrl_mask & ~(IF_MCONT_MSGLST |
>  					IF_MCONT_INTPND | IF_MCONT_NEWDAT));
>  		c_can_object_put(dev, iface, i, IF_COMM_CONTROL);
> @@ -356,7 +360,7 @@ static inline void c_can_activate_rx_msg_obj(struct=
 net_device *dev,
>  {
>  	struct c_can_priv *priv =3D netdev_priv(dev);
> =20
> -	priv->write_reg(priv, &priv->regs->ifregs[iface].msg_cntrl,
> +	priv->write_reg(priv, C_CAN_IFACE(MSGCTRL_REG, iface),
>  			ctrl_mask & ~(IF_MCONT_MSGLST |
>  				IF_MCONT_INTPND | IF_MCONT_NEWDAT));
>  	c_can_object_put(dev, iface, obj, IF_COMM_CONTROL);
> @@ -374,7 +378,7 @@ static void c_can_handle_lost_msg_obj(struct net_de=
vice *dev,
> =20
>  	c_can_object_get(dev, iface, objno, IF_COMM_ALL & ~IF_COMM_TXRQST);
> =20
> -	priv->write_reg(priv, &priv->regs->ifregs[iface].msg_cntrl,
> +	priv->write_reg(priv, C_CAN_IFACE(MSGCTRL_REG, iface),
>  			IF_MCONT_CLR_MSGLST);
> =20
>  	c_can_object_put(dev, 0, objno, IF_COMM_CONTROL);
> @@ -410,8 +414,8 @@ static int c_can_read_msg_object(struct net_device =
*dev, int iface, int ctrl)
> =20
>  	frame->can_dlc =3D get_can_dlc(ctrl & 0x0F);
> =20
> -	flags =3D	priv->read_reg(priv, &priv->regs->ifregs[iface].arb2);
> -	val =3D priv->read_reg(priv, &priv->regs->ifregs[iface].arb1) |
> +	flags =3D	priv->read_reg(priv, C_CAN_IFACE(ARB2_REG, iface));
> +	val =3D priv->read_reg(priv, C_CAN_IFACE(ARB1_REG, iface)) |
>  		(flags << 16);
> =20
>  	if (flags & IF_ARB_MSGXTD)
> @@ -424,7 +428,7 @@ static int c_can_read_msg_object(struct net_device =
*dev, int iface, int ctrl)
>  	else {
>  		for (i =3D 0; i < frame->can_dlc; i +=3D 2) {
>  			data =3D priv->read_reg(priv,
> -				&priv->regs->ifregs[iface].data[i / 2]);
> +				C_CAN_IFACE(DATA1_REG, iface) + i / 2);
>  			frame->data[i] =3D data;
>  			frame->data[i + 1] =3D data >> 8;
>  		}
> @@ -444,40 +448,40 @@ static void c_can_setup_receive_object(struct net=
_device *dev, int iface,
>  {
>  	struct c_can_priv *priv =3D netdev_priv(dev);
> =20
> -	priv->write_reg(priv, &priv->regs->ifregs[iface].mask1,
> +	priv->write_reg(priv, C_CAN_IFACE(MASK1_REG, iface),
>  			IFX_WRITE_LOW_16BIT(mask));
> -	priv->write_reg(priv, &priv->regs->ifregs[iface].mask2,
> +	priv->write_reg(priv, C_CAN_IFACE(MASK2_REG, iface),
>  			IFX_WRITE_HIGH_16BIT(mask));
> =20
> -	priv->write_reg(priv, &priv->regs->ifregs[iface].arb1,
> +	priv->write_reg(priv, C_CAN_IFACE(ARB1_REG, iface),
>  			IFX_WRITE_LOW_16BIT(id));
> -	priv->write_reg(priv, &priv->regs->ifregs[iface].arb2,
> +	priv->write_reg(priv, C_CAN_IFACE(ARB2_REG, iface),
>  			(IF_ARB_MSGVAL | IFX_WRITE_HIGH_16BIT(id)));
> =20
> -	priv->write_reg(priv, &priv->regs->ifregs[iface].msg_cntrl, mcont);
> +	priv->write_reg(priv, C_CAN_IFACE(MSGCTRL_REG, iface), mcont);
>  	c_can_object_put(dev, iface, objno, IF_COMM_ALL & ~IF_COMM_TXRQST);
> =20
>  	netdev_dbg(dev, "obj no:%d, msgval:0x%08x\n", objno,
> -			c_can_read_reg32(priv, &priv->regs->msgval1));
> +			c_can_read_reg32(priv, C_CAN_MSGVAL1_REG));
>  }
> =20
>  static void c_can_inval_msg_object(struct net_device *dev, int iface, =
int objno)
>  {
>  	struct c_can_priv *priv =3D netdev_priv(dev);
> =20
> -	priv->write_reg(priv, &priv->regs->ifregs[iface].arb1, 0);
> -	priv->write_reg(priv, &priv->regs->ifregs[iface].arb2, 0);
> -	priv->write_reg(priv, &priv->regs->ifregs[iface].msg_cntrl, 0);
> +	priv->write_reg(priv, C_CAN_IFACE(ARB1_REG, iface), 0);
> +	priv->write_reg(priv, C_CAN_IFACE(ARB2_REG, iface), 0);
> +	priv->write_reg(priv, C_CAN_IFACE(MSGCTRL_REG, iface), 0);
> =20
>  	c_can_object_put(dev, iface, objno, IF_COMM_ARB | IF_COMM_CONTROL);
> =20
>  	netdev_dbg(dev, "obj no:%d, msgval:0x%08x\n", objno,
> -			c_can_read_reg32(priv, &priv->regs->msgval1));
> +			c_can_read_reg32(priv, C_CAN_MSGVAL1_REG));
>  }
> =20
>  static inline int c_can_is_next_tx_obj_busy(struct c_can_priv *priv, i=
nt objno)
>  {
> -	int val =3D c_can_read_reg32(priv, &priv->regs->txrqst1);
> +	int val =3D c_can_read_reg32(priv, C_CAN_TXRQST1_REG);
> =20
>  	/*
>  	 * as transmission request register's bit n-1 corresponds to
> @@ -540,12 +544,12 @@ static int c_can_set_bittiming(struct net_device =
*dev)
>  	netdev_info(dev,
>  		"setting BTR=3D%04x BRPE=3D%04x\n", reg_btr, reg_brpe);
> =20
> -	ctrl_save =3D priv->read_reg(priv, &priv->regs->control);
> -	priv->write_reg(priv, &priv->regs->control,
> +	ctrl_save =3D priv->read_reg(priv, C_CAN_CTRL_REG);
> +	priv->write_reg(priv, C_CAN_CTRL_REG,
>  			ctrl_save | CONTROL_CCE | CONTROL_INIT);
> -	priv->write_reg(priv, &priv->regs->btr, reg_btr);
> -	priv->write_reg(priv, &priv->regs->brp_ext, reg_brpe);
> -	priv->write_reg(priv, &priv->regs->control, ctrl_save);
> +	priv->write_reg(priv, C_CAN_BTR_REG, reg_btr);
> +	priv->write_reg(priv, C_CAN_BRPEXT_REG, reg_brpe);
> +	priv->write_reg(priv, C_CAN_CTRL_REG, ctrl_save);
> =20
>  	return 0;
>  }
> @@ -587,36 +591,36 @@ static void c_can_chip_config(struct net_device *=
dev)
>  	struct c_can_priv *priv =3D netdev_priv(dev);
> =20
>  	/* enable automatic retransmission */
> -	priv->write_reg(priv, &priv->regs->control,
> +	priv->write_reg(priv, C_CAN_CTRL_REG,
>  			CONTROL_ENABLE_AR);
> =20
>  	if (priv->can.ctrlmode & (CAN_CTRLMODE_LISTENONLY &
>  					CAN_CTRLMODE_LOOPBACK)) {
>  		/* loopback + silent mode : useful for hot self-test */
> -		priv->write_reg(priv, &priv->regs->control, CONTROL_EIE |
> +		priv->write_reg(priv, C_CAN_CTRL_REG, CONTROL_EIE |
>  				CONTROL_SIE | CONTROL_IE | CONTROL_TEST);
> -		priv->write_reg(priv, &priv->regs->test,
> +		priv->write_reg(priv, C_CAN_TEST_REG,
>  				TEST_LBACK | TEST_SILENT);
>  	} else if (priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK) {
>  		/* loopback mode : useful for self-test function */
> -		priv->write_reg(priv, &priv->regs->control, CONTROL_EIE |
> +		priv->write_reg(priv, C_CAN_CTRL_REG, CONTROL_EIE |
>  				CONTROL_SIE | CONTROL_IE | CONTROL_TEST);
> -		priv->write_reg(priv, &priv->regs->test, TEST_LBACK);
> +		priv->write_reg(priv, C_CAN_TEST_REG, TEST_LBACK);
>  	} else if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY) {
>  		/* silent mode : bus-monitoring mode */
> -		priv->write_reg(priv, &priv->regs->control, CONTROL_EIE |
> +		priv->write_reg(priv, C_CAN_CTRL_REG, CONTROL_EIE |
>  				CONTROL_SIE | CONTROL_IE | CONTROL_TEST);
> -		priv->write_reg(priv, &priv->regs->test, TEST_SILENT);
> +		priv->write_reg(priv, C_CAN_TEST_REG, TEST_SILENT);
>  	} else
>  		/* normal mode*/
> -		priv->write_reg(priv, &priv->regs->control,
> +		priv->write_reg(priv, C_CAN_CTRL_REG,
>  				CONTROL_EIE | CONTROL_SIE | CONTROL_IE);
> =20
>  	/* configure message objects */
>  	c_can_configure_msg_objects(dev);
> =20
>  	/* set a `lec` value so that we can check for updates later */
> -	priv->write_reg(priv, &priv->regs->status, LEC_UNUSED);
> +	priv->write_reg(priv, C_CAN_STS_REG, LEC_UNUSED);
> =20
>  	/* set bittiming params */
>  	c_can_set_bittiming(dev);
> @@ -669,7 +673,7 @@ static int c_can_get_berr_counter(const struct net_=
device *dev,
>  	unsigned int reg_err_counter;
>  	struct c_can_priv *priv =3D netdev_priv(dev);
> =20
> -	reg_err_counter =3D priv->read_reg(priv, &priv->regs->err_cnt);
> +	reg_err_counter =3D priv->read_reg(priv, C_CAN_ERR_CNT_REG);
>  	bec->rxerr =3D (reg_err_counter & ERR_CNT_REC_MASK) >>
>  				ERR_CNT_REC_SHIFT;
>  	bec->txerr =3D reg_err_counter & ERR_CNT_TEC_MASK;
> @@ -697,12 +701,12 @@ static void c_can_do_tx(struct net_device *dev)
> =20
>  	for (/* nix */; (priv->tx_next - priv->tx_echo) > 0; priv->tx_echo++)=
 {
>  		msg_obj_no =3D get_tx_echo_msg_obj(priv);
> -		val =3D c_can_read_reg32(priv, &priv->regs->txrqst1);
> +		val =3D c_can_read_reg32(priv, C_CAN_TXRQST1_REG);
>  		if (!(val & (1 << (msg_obj_no - 1)))) {
>  			can_get_echo_skb(dev,
>  					msg_obj_no - C_CAN_MSG_OBJ_TX_FIRST);
>  			stats->tx_bytes +=3D priv->read_reg(priv,
> -					&priv->regs->ifregs[0].msg_cntrl)
> +					C_CAN_IFACE(MSGCTRL_REG, 0))
>  					& IF_MCONT_DLC_MASK;
>  			stats->tx_packets++;
>  			c_can_inval_msg_object(dev, 0, msg_obj_no);
> @@ -744,11 +748,11 @@ static int c_can_do_rx_poll(struct net_device *de=
v, int quota)
>  	u32 num_rx_pkts =3D 0;
>  	unsigned int msg_obj, msg_ctrl_save;
>  	struct c_can_priv *priv =3D netdev_priv(dev);
> -	u32 val =3D c_can_read_reg32(priv, &priv->regs->intpnd1);
> +	u32 val =3D c_can_read_reg32(priv, C_CAN_INTPND1_REG);
> =20
>  	for (msg_obj =3D C_CAN_MSG_OBJ_RX_FIRST;
>  			msg_obj <=3D C_CAN_MSG_OBJ_RX_LAST && quota > 0;
> -			val =3D c_can_read_reg32(priv, &priv->regs->intpnd1),
> +			val =3D c_can_read_reg32(priv, C_CAN_INTPND1_REG),
>  			msg_obj++) {
>  		/*
>  		 * as interrupt pending register's bit n-1 corresponds to
> @@ -758,7 +762,7 @@ static int c_can_do_rx_poll(struct net_device *dev,=
 int quota)
>  			c_can_object_get(dev, 0, msg_obj, IF_COMM_ALL &
>  					~IF_COMM_TXRQST);
>  			msg_ctrl_save =3D priv->read_reg(priv,
> -					&priv->regs->ifregs[0].msg_cntrl);
> +					C_CAN_IFACE(MSGCTRL_REG, 0));
> =20
>  			if (msg_ctrl_save & IF_MCONT_EOB)
>  				return num_rx_pkts;
> @@ -819,7 +823,7 @@ static int c_can_handle_state_change(struct net_dev=
ice *dev,
>  		return 0;
> =20
>  	c_can_get_berr_counter(dev, &bec);
> -	reg_err_counter =3D priv->read_reg(priv, &priv->regs->err_cnt);
> +	reg_err_counter =3D priv->read_reg(priv, C_CAN_ERR_CNT_REG);
>  	rx_err_passive =3D (reg_err_counter & ERR_CNT_RP_MASK) >>
>  				ERR_CNT_RP_SHIFT;
> =20
> @@ -935,7 +939,7 @@ static int c_can_handle_bus_err(struct net_device *=
dev,
>  	}
> =20
>  	/* set a `lec` value so that we can check for updates later */
> -	priv->write_reg(priv, &priv->regs->status, LEC_UNUSED);
> +	priv->write_reg(priv, C_CAN_STS_REG, LEC_UNUSED);
> =20
>  	netif_receive_skb(skb);
>  	stats->rx_packets++;
> @@ -959,15 +963,15 @@ static int c_can_poll(struct napi_struct *napi, i=
nt quota)
>  	/* status events have the highest priority */
>  	if (irqstatus =3D=3D STATUS_INTERRUPT) {
>  		priv->current_status =3D priv->read_reg(priv,
> -					&priv->regs->status);
> +					C_CAN_STS_REG);
> =20
>  		/* handle Tx/Rx events */
>  		if (priv->current_status & STATUS_TXOK)
> -			priv->write_reg(priv, &priv->regs->status,
> +			priv->write_reg(priv, C_CAN_STS_REG,
>  					priv->current_status & ~STATUS_TXOK);
> =20
>  		if (priv->current_status & STATUS_RXOK)
> -			priv->write_reg(priv, &priv->regs->status,
> +			priv->write_reg(priv, C_CAN_STS_REG,
>  					priv->current_status & ~STATUS_RXOK);
> =20
>  		/* handle state changes */
> @@ -1033,7 +1037,7 @@ static irqreturn_t c_can_isr(int irq, void *dev_i=
d)
>  	struct net_device *dev =3D (struct net_device *)dev_id;
>  	struct c_can_priv *priv =3D netdev_priv(dev);
> =20
> -	priv->irqstatus =3D priv->read_reg(priv, &priv->regs->interrupt);
> +	priv->irqstatus =3D priv->read_reg(priv, C_CAN_INT_REG);
>  	if (!priv->irqstatus)
>  		return IRQ_NONE;
> =20
> diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_ca=
n.h
> index 5f32d34..d1e141e 100644
> --- a/drivers/net/can/c_can/c_can.h
> +++ b/drivers/net/can/c_can/c_can.h
> @@ -22,43 +22,84 @@
>  #ifndef C_CAN_H
>  #define C_CAN_H
> =20
> -/* c_can IF registers */
> -struct c_can_if_regs {
> -	u16 com_req;
> -	u16 com_mask;
> -	u16 mask1;
> -	u16 mask2;
> -	u16 arb1;
> -	u16 arb2;
> -	u16 msg_cntrl;
> -	u16 data[4];
> -	u16 _reserved[13];
> +enum reg {
> +	C_CAN_CTRL_REG =3D 0,
> +	C_CAN_STS_REG,
> +	C_CAN_ERR_CNT_REG,
> +	C_CAN_BTR_REG,
> +	C_CAN_INT_REG,
> +	C_CAN_TEST_REG,
> +	C_CAN_BRPEXT_REG,
> +	C_CAN_IF1_COMREQ_REG,
> +	C_CAN_IF1_COMMSK_REG,
> +	C_CAN_IF1_MASK1_REG,
> +	C_CAN_IF1_MASK2_REG,
> +	C_CAN_IF1_ARB1_REG,
> +	C_CAN_IF1_ARB2_REG,
> +	C_CAN_IF1_MSGCTRL_REG,
> +	C_CAN_IF1_DATA1_REG,
> +	C_CAN_IF1_DATA2_REG,
> +	C_CAN_IF1_DATA3_REG,
> +	C_CAN_IF1_DATA4_REG,
> +	C_CAN_IF2_COMREQ_REG,
> +	C_CAN_IF2_COMMSK_REG,
> +	C_CAN_IF2_MASK1_REG,
> +	C_CAN_IF2_MASK2_REG,
> +	C_CAN_IF2_ARB1_REG,
> +	C_CAN_IF2_ARB2_REG,
> +	C_CAN_IF2_MSGCTRL_REG,
> +	C_CAN_IF2_DATA1_REG,
> +	C_CAN_IF2_DATA2_REG,
> +	C_CAN_IF2_DATA3_REG,
> +	C_CAN_IF2_DATA4_REG,
> +	C_CAN_TXRQST1_REG,
> +	C_CAN_TXRQST2_REG,
> +	C_CAN_NEWDAT1_REG,
> +	C_CAN_NEWDAT2_REG,
> +	C_CAN_INTPND1_REG,
> +	C_CAN_INTPND2_REG,
> +	C_CAN_MSGVAL1_REG,
> +	C_CAN_MSGVAL2_REG,
>  };
> =20
> -/* c_can hardware registers */
> -struct c_can_regs {
> -	u16 control;
> -	u16 status;
> -	u16 err_cnt;
> -	u16 btr;
> -	u16 interrupt;
> -	u16 test;
> -	u16 brp_ext;
> -	u16 _reserved1;
> -	struct c_can_if_regs ifregs[2]; /* [0] =3D IF1 and [1] =3D IF2 */
> -	u16 _reserved2[8];
> -	u16 txrqst1;
> -	u16 txrqst2;
> -	u16 _reserved3[6];
> -	u16 newdat1;
> -	u16 newdat2;
> -	u16 _reserved4[6];
> -	u16 intpnd1;
> -	u16 intpnd2;
> -	u16 _reserved5[6];
> -	u16 msgval1;
> -	u16 msgval2;
> -	u16 _reserved6[6];
> +static const u16 reg_map_c_can[] =3D {
> +	[C_CAN_CTRL_REG]	=3D 0x00,
> +	[C_CAN_STS_REG]		=3D 0x02,
> +	[C_CAN_ERR_CNT_REG]	=3D 0x04,
> +	[C_CAN_BTR_REG]		=3D 0x06,
> +	[C_CAN_INT_REG]		=3D 0x08,
> +	[C_CAN_TEST_REG]	=3D 0x0A,
> +	[C_CAN_BRPEXT_REG]	=3D 0x0C,
> +	[C_CAN_IF1_COMREQ_REG]	=3D 0x10,
> +	[C_CAN_IF1_COMMSK_REG]	=3D 0x12,
> +	[C_CAN_IF1_MASK1_REG]	=3D 0x14,
> +	[C_CAN_IF1_MASK2_REG]	=3D 0x16,
> +	[C_CAN_IF1_ARB1_REG]	=3D 0x18,
> +	[C_CAN_IF1_ARB2_REG]	=3D 0x1A,
> +	[C_CAN_IF1_MSGCTRL_REG]	=3D 0x1C,
> +	[C_CAN_IF1_DATA1_REG]	=3D 0x1E,
> +	[C_CAN_IF1_DATA2_REG]	=3D 0x20,
> +	[C_CAN_IF1_DATA3_REG]	=3D 0x22,
> +	[C_CAN_IF1_DATA4_REG]	=3D 0x24,
> +	[C_CAN_IF2_COMREQ_REG]	=3D 0x40,
> +	[C_CAN_IF2_COMMSK_REG]	=3D 0x42,
> +	[C_CAN_IF2_MASK1_REG]	=3D 0x44,
> +	[C_CAN_IF2_MASK2_REG]	=3D 0x46,
> +	[C_CAN_IF2_ARB1_REG]	=3D 0x48,
> +	[C_CAN_IF2_ARB2_REG]	=3D 0x4A,
> +	[C_CAN_IF2_MSGCTRL_REG]	=3D 0x4C,
> +	[C_CAN_IF2_DATA1_REG]	=3D 0x4E,
> +	[C_CAN_IF2_DATA2_REG]	=3D 0x50,
> +	[C_CAN_IF2_DATA3_REG]	=3D 0x52,
> +	[C_CAN_IF2_DATA4_REG]	=3D 0x54,
> +	[C_CAN_TXRQST1_REG]	=3D 0x80,
> +	[C_CAN_TXRQST2_REG]	=3D 0x82,
> +	[C_CAN_NEWDAT1_REG]	=3D 0x90,
> +	[C_CAN_NEWDAT2_REG]	=3D 0x92,
> +	[C_CAN_INTPND1_REG]	=3D 0xA0,
> +	[C_CAN_INTPND2_REG]	=3D 0xA2,
> +	[C_CAN_MSGVAL1_REG]	=3D 0xB0,
> +	[C_CAN_MSGVAL2_REG]	=3D 0xB2,
>  };
> =20
>  /* c_can private data structure */
> @@ -69,9 +110,10 @@ struct c_can_priv {
>  	int tx_object;
>  	int current_status;
>  	int last_status;
> -	u16 (*read_reg) (struct c_can_priv *priv, void *reg);
> -	void (*write_reg) (struct c_can_priv *priv, void *reg, u16 val);
> -	struct c_can_regs __iomem *regs;
> +	u16 (*read_reg) (struct c_can_priv *priv, enum reg index);
> +	void (*write_reg) (struct c_can_priv *priv, enum reg index, u16 val);=

> +	void __iomem *base;
> +	const u16 *regs;
>  	unsigned long irq_flags; /* for request_irq() */
>  	unsigned int tx_next;
>  	unsigned int tx_echo;
> diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c=
_can/c_can_platform.c
> index 5e1a5ff..a6e9b93 100644
> --- a/drivers/net/can/c_can/c_can_platform.c
> +++ b/drivers/net/can/c_can/c_can_platform.c
> @@ -42,27 +42,27 @@
>   * Handle the same by providing a common read/write interface.
>   */
>  static u16 c_can_plat_read_reg_aligned_to_16bit(struct c_can_priv *pri=
v,
> -						void *reg)
> +						enum reg index)
>  {
> -	return readw(reg);
> +	return readw(priv->base + priv->regs[index]);
>  }
> =20
>  static void c_can_plat_write_reg_aligned_to_16bit(struct c_can_priv *p=
riv,
> -						void *reg, u16 val)
> +						enum reg index, u16 val)
>  {
> -	writew(val, reg);
> +	writew(val, priv->base + priv->regs[index]);
>  }
> =20
>  static u16 c_can_plat_read_reg_aligned_to_32bit(struct c_can_priv *pri=
v,
> -						void *reg)
> +						enum reg index)
>  {
> -	return readw(reg + (long)reg - (long)priv->regs);
> +	return readw(priv->base + 2 * priv->regs[index]);
>  }
> =20
>  static void c_can_plat_write_reg_aligned_to_32bit(struct c_can_priv *p=
riv,
> -						void *reg, u16 val)
> +						enum reg index, u16 val)
>  {
> -	writew(val, reg + (long)reg - (long)priv->regs);
> +	writew(val, priv->base + 2 * priv->regs[index]);
>  }
> =20
>  static int __devinit c_can_plat_probe(struct platform_device *pdev)
> @@ -115,9 +115,10 @@ static int __devinit c_can_plat_probe(struct platf=
orm_device *pdev)
>  	}
> =20
>  	priv =3D netdev_priv(dev);
> +	priv->regs =3D reg_map_c_can;
> =20
>  	dev->irq =3D irq;
> -	priv->regs =3D addr;
> +	priv->base =3D addr;
>  #ifdef CONFIG_HAVE_CLK
>  	priv->can.clock.freq =3D clk_get_rate(clk);
>  	priv->priv =3D clk;
> @@ -146,7 +147,7 @@ static int __devinit c_can_plat_probe(struct platfo=
rm_device *pdev)
>  	}
> =20
>  	dev_info(&pdev->dev, "%s device registered (regs=3D%p, irq=3D%d)\n",
> -		 KBUILD_MODNAME, priv->regs, dev->irq);
> +		 KBUILD_MODNAME, priv->base, dev->irq);
>  	return 0;
> =20
>  exit_free_device:
> @@ -176,7 +177,7 @@ static int __devexit c_can_plat_remove(struct platf=
orm_device *pdev)
>  	platform_set_drvdata(pdev, NULL);
> =20
>  	free_c_can_dev(dev);
> -	iounmap(priv->regs);
> +	iounmap(priv->base);
> =20
>  	mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	release_mem_region(mem->start, resource_size(mem));


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig9E1B6C2942E46C115264A361
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+8tGIACgkQjTAFq1RaXHMrZACffcyGvULSNMnbHqIHyfIytrt8
Ju0AmgJSQ9mffSPFkkH7I5xH7MBDekWm
=fXDN
-----END PGP SIGNATURE-----

--------------enig9E1B6C2942E46C115264A361--
