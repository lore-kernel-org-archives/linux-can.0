From: Pavel Machek <pavel@denx.de>
Subject: Re: can problems on socfpga [was Re: [PATCH v2 4/6] ARM: socfpga:
 dts: add can0+1]
Date: Sat, 26 Apr 2014 11:36:46 +0200
Message-ID: <20140426093646.GE8730@amd.pavel.ucw.cz>
References: <1396422700-3962-1-git-send-email-s.trumtrar@pengutronix.de>
 <1396422700-3962-4-git-send-email-s.trumtrar@pengutronix.de>
 <20140404102815.GA9242@amd.pavel.ucw.cz>
 <20140425195319.GA3677@amd.pavel.ucw.cz>
 <1398457446.26387.0.camel@linux-builds1>
 <1398461518.3587.11.camel@dinh-ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:42105 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751682AbaDZJgs (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 26 Apr 2014 05:36:48 -0400
Content-Disposition: inline
In-Reply-To: <1398461518.3587.11.camel@dinh-ubuntu>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Thor Thayer <tthayer@altera.com>
Cc: Dinh Nguyen <dinguyen@altera.com>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org, socketcan@hartkopp.net, wg@grandegger.com, mkl@pengutronix.de, tthayer.linux@gmail.com

Hi!

> To get this working well, I had to install a few of the patches that
> Benedict Spranger submitted ([PATCH 05/16] c_can: use 32 bit access for
> D_CAN) on 9/9/2013.
> 
> I have the patches on our rocketboard branch
> (rocketboards.org/gitweb/?p=linux-socfpga-git;a=summary)
> 
> I planned to upstream these changes but there have been some major
> changes to CAN recently that may require some refactoring.

I ported those changes to 3.15-rc2 (but can't test them at the
moment).

Signed-off-by: Pavel Machek <pavel@denx.de>

Best regards,
								Pavel

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index a5c8dcf..3ad0bd4 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -48,6 +48,7 @@
 #define C_CAN_IFACE(reg, iface)	(C_CAN_IF1_##reg + (iface) * IF_ENUM_REG_LEN)
 
 /* control extension register D_CAN specific */
+#define CONTROL_MIL		BIT(17)
 #define CONTROL_EX_PDR		BIT(8)
 
 /* control register */
@@ -237,25 +238,25 @@ static inline int get_tx_echo_msg_obj(int txecho)
 	return (txecho & C_CAN_NEXT_MSG_OBJ_MASK) + C_CAN_MSG_OBJ_TX_FIRST;
 }
 
-static u32 c_can_read_reg32(struct c_can_priv *priv, enum reg index)
-{
-	u32 val = priv->read_reg(priv, index);
-	val |= ((u32) priv->read_reg(priv, index + 1)) << 16;
-	return val;
-}
-
 static void c_can_enable_all_interrupts(struct c_can_priv *priv,
 						int enable)
 {
-	unsigned int cntrl_save = priv->read_reg(priv,
-						C_CAN_CTRL_REG);
+	u32 cntrl_save;
+
+	if (priv->type == BOSCH_D_CAN)
+		cntrl_save = priv->read_reg32(priv, C_CAN_CTRL_REG);
+	else
+		cntrl_save = priv->read_reg(priv, C_CAN_CTRL_REG);
 
 	if (enable)
 		cntrl_save |= (CONTROL_SIE | CONTROL_EIE | CONTROL_IE);
 	else
 		cntrl_save &= ~(CONTROL_EIE | CONTROL_IE | CONTROL_SIE);
 
-	priv->write_reg(priv, C_CAN_CTRL_REG, cntrl_save);
+	if (priv->type == BOSCH_D_CAN)
+		priv->write_reg32(priv, C_CAN_CTRL_REG, cntrl_save);
+	else
+		priv->write_reg(priv, C_CAN_CTRL_REG, cntrl_save);
 }
 
 static inline int c_can_msg_obj_is_busy(struct c_can_priv *priv, int iface)
@@ -286,9 +287,8 @@ static inline void c_can_object_get(struct net_device *dev,
 	 * register and message RAM must be complete in 6 CAN-CLK
 	 * period.
 	 */
-	priv->write_reg(priv, C_CAN_IFACE(COMMSK_REG, iface),
-			IFX_WRITE_LOW_16BIT(mask));
-	priv->write_reg(priv, C_CAN_IFACE(COMREQ_REG, iface),
+	priv->write_reg32(priv, C_CAN_IFACE(COMREQ_REG, iface),
+			(IFX_WRITE_LOW_16BIT(mask) << 16) |
 			IFX_WRITE_LOW_16BIT(objno));
 
 	if (c_can_msg_obj_is_busy(priv, iface))
@@ -306,9 +306,8 @@ static inline void c_can_object_put(struct net_device *dev,
 	 * register and message RAM must be complete in 6 CAN-CLK
 	 * period.
 	 */
-	priv->write_reg(priv, C_CAN_IFACE(COMMSK_REG, iface),
-			(IF_COMM_WR | IFX_WRITE_LOW_16BIT(mask)));
-	priv->write_reg(priv, C_CAN_IFACE(COMREQ_REG, iface),
+	priv->write_reg32(priv, C_CAN_IFACE(COMREQ_REG, iface),
+			((IF_COMM_WR | IFX_WRITE_LOW_16BIT(mask)) << 16) |
 			IFX_WRITE_LOW_16BIT(objno));
 
 	if (c_can_msg_obj_is_busy(priv, iface))
@@ -334,10 +333,8 @@ static void c_can_write_msg_object(struct net_device *dev,
 
 	flags |= IF_ARB_MSGVAL;
 
-	priv->write_reg(priv, C_CAN_IFACE(ARB1_REG, iface),
-				IFX_WRITE_LOW_16BIT(id));
-	priv->write_reg(priv, C_CAN_IFACE(ARB2_REG, iface), flags |
-				IFX_WRITE_HIGH_16BIT(id));
+	priv->write_reg32(priv, C_CAN_IFACE(ARB1_REG, iface),
+				id | (flags << 16));
 
 	for (i = 0; i < frame->can_dlc; i += 2) {
 		priv->write_reg(priv, C_CAN_IFACE(DATA1_REG, iface) + i / 2,
@@ -442,25 +439,24 @@ static void c_can_setup_receive_object(struct net_device *dev, int iface,
 {
 	struct c_can_priv *priv = netdev_priv(dev);
 
-	priv->write_reg(priv, C_CAN_IFACE(MASK1_REG, iface),
-			IFX_WRITE_LOW_16BIT(mask));
-
 	/* According to C_CAN documentation, the reserved bit
 	 * in IFx_MASK2 register is fixed 1
 	 */
-	priv->write_reg(priv, C_CAN_IFACE(MASK2_REG, iface),
-			IFX_WRITE_HIGH_16BIT(mask) | BIT(13));
+	priv->write_reg32(priv, C_CAN_IFACE(MASK1_REG, iface),
+			((IFX_WRITE_HIGH_16BIT(mask) | BIT(13)) << 16) |
+			IFX_WRITE_LOW_16BIT(mask));
 
-	priv->write_reg(priv, C_CAN_IFACE(ARB1_REG, iface),
+	id |= IF_ARB_MSGVAL;
+
+	priv->write_reg32(priv, C_CAN_IFACE(ARB1_REG, iface),
+			((IF_ARB_MSGVAL | IFX_WRITE_HIGH_16BIT(id)) << 16) |
 			IFX_WRITE_LOW_16BIT(id));
-	priv->write_reg(priv, C_CAN_IFACE(ARB2_REG, iface),
-			(IF_ARB_MSGVAL | IFX_WRITE_HIGH_16BIT(id)));
+	priv->write_reg32(priv, C_CAN_IFACE(MSGCTRL_REG, iface), mcont);
 
-	priv->write_reg(priv, C_CAN_IFACE(MSGCTRL_REG, iface), mcont);
 	c_can_object_put(dev, iface, objno, IF_COMM_ALL & ~IF_COMM_TXRQST);
 
 	netdev_dbg(dev, "obj no:%d, msgval:0x%08x\n", objno,
-			c_can_read_reg32(priv, C_CAN_MSGVAL1_REG));
+			priv->read_reg32(priv, C_CAN_MSGVAL1_REG));
 }
 
 static void c_can_inval_msg_object(struct net_device *dev, int iface, int objno)
@@ -474,12 +470,12 @@ static void c_can_inval_msg_object(struct net_device *dev, int iface, int objno)
 	c_can_object_put(dev, iface, objno, IF_COMM_ARB | IF_COMM_CONTROL);
 
 	netdev_dbg(dev, "obj no:%d, msgval:0x%08x\n", objno,
-			c_can_read_reg32(priv, C_CAN_MSGVAL1_REG));
+			priv->read_reg32(priv, C_CAN_MSGVAL1_REG));
 }
 
 static inline int c_can_is_next_tx_obj_busy(struct c_can_priv *priv, int objno)
 {
-	int val = c_can_read_reg32(priv, C_CAN_TXRQST1_REG);
+	int val = priv->read_reg32(priv, C_CAN_TXRQST1_REG);
 
 	/*
 	 * as transmission request register's bit n-1 corresponds to
@@ -561,16 +557,22 @@ static int c_can_set_bittiming(struct net_device *dev)
 	netdev_info(dev,
 		"setting BTR=%04x BRPE=%04x\n", reg_btr, reg_brpe);
 
-	ctrl_save = priv->read_reg(priv, C_CAN_CTRL_REG);
+	if (priv->type == BOSCH_D_CAN)
+		ctrl_save = priv->read_reg32(priv, C_CAN_CTRL_REG);
+	else
+		ctrl_save = priv->read_reg(priv, C_CAN_CTRL_REG);
 	ctrl_save &= ~CONTROL_INIT;
-	priv->write_reg(priv, C_CAN_CTRL_REG, CONTROL_CCE | CONTROL_INIT);
+	priv->write_reg(priv, C_CAN_CTRL_REG, CONTROL_CCE | CONTROL_INIT); /* FIXME: want to do write32? */
 	res = c_can_wait_for_ctrl_init(dev, priv, CONTROL_INIT);
 	if (res)
 		return res;
 
 	priv->write_reg(priv, C_CAN_BTR_REG, reg_btr);
 	priv->write_reg(priv, C_CAN_BRPEXT_REG, reg_brpe);
-	priv->write_reg(priv, C_CAN_CTRL_REG, ctrl_save);
+	if (priv->type == BOSCH_D_CAN)
+		priv->write_reg32(priv, C_CAN_CTRL_REG, ctrl_save);
+	else
+		priv->write_reg(priv, C_CAN_CTRL_REG, ctrl_save);
 
 	return c_can_wait_for_ctrl_init(dev, priv, 0);
 }
@@ -743,7 +745,7 @@ static void c_can_do_tx(struct net_device *dev)
 
 	for (; (priv->tx_next - priv->tx_echo) > 0; priv->tx_echo++) {
 		obj = get_tx_echo_msg_obj(priv->tx_echo);
-		val = c_can_read_reg32(priv, C_CAN_TXRQST1_REG);
+		val = priv->read_reg32(priv, C_CAN_TXRQST1_REG);
 
 		if (val & (1 << (obj - 1)))
 			break;
@@ -1292,7 +1294,7 @@ int c_can_power_up(struct net_device *dev)
 
 	/* Clear PDR and INIT bits */
 	val = priv->read_reg(priv, C_CAN_CTRL_EX_REG);
-	val &= ~CONTROL_EX_PDR;
+	val &= ~(CONTROL_EX_PDR | CONTROL_MIL);
 	priv->write_reg(priv, C_CAN_CTRL_EX_REG, val);
 	val = priv->read_reg(priv, C_CAN_CTRL_REG);
 	val &= ~CONTROL_INIT;
diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_can.h
index d436734..21e0795 100644
--- a/drivers/net/can/c_can/c_can.h
+++ b/drivers/net/can/c_can/c_can.h
@@ -203,6 +203,8 @@ struct c_can_priv {
 	unsigned int instance;
 	void (*raminit) (const struct c_can_priv *priv, bool enable);
 	u32 dlc[C_CAN_MSG_OBJ_TX_NUM];
+	u32 (*read_reg32) (struct c_can_priv *priv, enum reg index);
+	void (*write_reg32) (struct c_can_priv *priv, enum reg index, u32 val);
 };
 
 struct net_device *alloc_c_can_dev(void);
diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index fba168f..ff844da 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -110,6 +110,34 @@ static void c_can_hw_raminit_ti(const struct c_can_priv *priv, bool enable)
 	spin_unlock(&raminit_lock);
 }
 
+static u32 c_can_plat_read_reg32(struct c_can_priv *priv, enum reg index)
+{
+	u32 val;
+
+	val = priv->read_reg(priv, index);
+	val |= ((u32) priv->read_reg(priv, index + 1)) << 16;
+
+	return val;
+}
+
+static void c_can_plat_write_reg32(struct c_can_priv *priv, enum reg index,
+		u32 val)
+{
+	priv->write_reg(priv, index + 1, val>>16);
+	priv->write_reg(priv, index, val);
+}
+
+static u32 d_can_plat_read_reg32(struct c_can_priv *priv, enum reg index)
+{
+	return readl(priv->base + priv->regs[index]);
+}
+
+static void d_can_plat_write_reg32(struct c_can_priv *priv, enum reg index,
+		u32 val)
+{
+	writel(val, priv->base + priv->regs[index]);
+}
+
 static void c_can_hw_raminit(const struct c_can_priv *priv, bool enable)
 {
 	u32 ctrl;
@@ -223,11 +251,15 @@ static int c_can_plat_probe(struct platform_device *pdev)
 		case IORESOURCE_MEM_32BIT:
 			priv->read_reg = c_can_plat_read_reg_aligned_to_32bit;
 			priv->write_reg = c_can_plat_write_reg_aligned_to_32bit;
+			priv->read_reg32 = c_can_plat_read_reg32;
+			priv->write_reg32 = c_can_plat_write_reg32;
 			break;
 		case IORESOURCE_MEM_16BIT:
 		default:
 			priv->read_reg = c_can_plat_read_reg_aligned_to_16bit;
 			priv->write_reg = c_can_plat_write_reg_aligned_to_16bit;
+			priv->read_reg32 = c_can_plat_read_reg32;
+			priv->write_reg32 = c_can_plat_write_reg32;
 			break;
 		}
 		break;
@@ -236,6 +268,8 @@ static int c_can_plat_probe(struct platform_device *pdev)
 		priv->can.ctrlmode_supported |= CAN_CTRLMODE_3_SAMPLES;
 		priv->read_reg = c_can_plat_read_reg_aligned_to_16bit;
 		priv->write_reg = c_can_plat_write_reg_aligned_to_16bit;
+		priv->read_reg32 = d_can_plat_read_reg32;
+		priv->write_reg32 = d_can_plat_write_reg32;
 
 		if (pdev->dev.of_node)
 			priv->instance = of_alias_get_id(pdev->dev.of_node, "d_can");


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
