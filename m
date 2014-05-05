From: Pavel Machek <pavel@denx.de>
Subject: Re: [PATCHv2] Fix CAN on socfpga, for net/master
Date: Mon, 5 May 2014 14:07:59 +0200
Message-ID: <20140505120759.GA16649@amd.pavel.ucw.cz>
References: <6bf951b6-51e7-4b90-b054-9ba5b6e93874@email.android.com>
 <20140427122510.GB12901@amd.pavel.ucw.cz>
 <1398716449.836.4.camel@dinh-ubuntu>
 <20140428211505.GA28242@amd.pavel.ucw.cz>
 <CAF03EBf9KXqB4W9GuDduhLwp_kwFjUEi3syU7fX3KpXfZEFxHg@mail.gmail.com>
 <CAF03EBd19PC5RAsLR6-dMPF2x3XRf9X4bFPgX2kRdCYWUQBYcA@mail.gmail.com>
 <20140430215359.GA15148@amd.pavel.ucw.cz>
 <CAF03EBewoV0pOOmNQBwPrKgm-zhaSbFcNd_UiEhFWyUrq91-Jg@mail.gmail.com>
 <20140502084851.GA5730@amd.pavel.ucw.cz>
 <53638F17.6000702@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:59963 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756486AbaEEMIB (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 5 May 2014 08:08:01 -0400
Content-Disposition: inline
In-Reply-To: <53638F17.6000702@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Thor Thayer <tthayer.linux@gmail.com>, Thor Thayer <tthayer@altera.com>, Dinh Nguyen <dinguyen@altera.com>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org, socketcan@hartkopp.net, wg@grandegger.com

Hi!

> On 05/02/2014 10:48 AM, Pavel Machek wrote:
> > Apparently, socfpga CAN needs 32-bit accesses and different raminit
> > sequence.
> 
> Please split into several patches:
> - add 32 bit accessor functions
>   and replace two 16 bit accesses by a single 32 bit access

Can do. 2/2.

> - if-DCAN-then-32bit access
>   please explain in the commit message why this is needed

That patch is below... but I guess I'll need help from Altera
here. Can you explain why it is needed?

> - add hwinit support for non ti devices

Can do. 1/2.

Thanks,
									Pavel

Tested-by: Thor Thayer <tthayer@altera.com>
Signed-off-by: Thor Thayer <tthayer@altera.com>
Signed-off-by: Pavel Machek <pavel@denx.de>

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index a2ca820..824ec21 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -48,6 +48,7 @@
 #define C_CAN_IFACE(reg, iface)	(C_CAN_IF1_##reg + (iface) * IF_ENUM_REG_LEN)
 
 /* control extension register D_CAN specific */
+#define CONTROL_MIL		BIT(17)
 #define CONTROL_EX_PDR		BIT(8)
 
 /* control register */
@@ -239,12 +240,20 @@ static inline void c_can_reset_ram(const struct c_can_priv *priv, bool enable)
 
 static void c_can_irq_control(struct c_can_priv *priv, bool enable)
 {
-	u32 ctrl = priv->read_reg(priv,	C_CAN_CTRL_REG) & ~CONTROL_IRQMSK;
+	u32 ctrl;
+
+	if (priv->type == BOSCH_D_CAN)
+		ctrl = priv->read_reg32(priv, C_CAN_CTRL_REG) & ~CONTROL_IRQMSK;
+	else
+		ctrl = priv->read_reg(priv, C_CAN_CTRL_REG) & ~CONTROL_IRQMSK;
 
 	if (enable)
 		ctrl |= CONTROL_IRQMSK;
 
-	priv->write_reg(priv, C_CAN_CTRL_REG, ctrl);
+	if (priv->type == BOSCH_D_CAN)
+		priv->write_reg32(priv, C_CAN_CTRL_REG, ctrl);
+	else
+		priv->write_reg(priv, C_CAN_CTRL_REG, ctrl);
 }
 
 static void c_can_obj_update(struct net_device *dev, int iface, u32 cmd, u32 obj)
@@ -510,16 +514,22 @@ static int c_can_set_bittiming(struct net_device *dev)
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
@@ -1240,7 +1250,7 @@ int c_can_power_up(struct net_device *dev)
 
 	/* Clear PDR and INIT bits */
 	val = priv->read_reg(priv, C_CAN_CTRL_EX_REG);
-	val &= ~CONTROL_EX_PDR;
+	val &= ~(CONTROL_EX_PDR | CONTROL_MIL);
 	priv->write_reg(priv, C_CAN_CTRL_EX_REG, val);
 	val = priv->read_reg(priv, C_CAN_CTRL_REG);
 	val &= ~CONTROL_INIT;
diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_can.h
index c56f1b1..10c3fd2 100644
--- a/drivers/net/can/c_can/c_can.h
+++ b/drivers/net/can/c_can/c_can.h
@@ -78,6 +78,7 @@ enum reg {
 	C_CAN_INTPND2_REG,
 	C_CAN_MSGVAL1_REG,
 	C_CAN_MSGVAL2_REG,
+	C_CAN_FUNCTION_REG,
 };
 
 static const u16 reg_map_c_can[] = {
@@ -129,6 +130,7 @@ static const u16 reg_map_d_can[] = {
 	[C_CAN_BRPEXT_REG]	= 0x0E,
 	[C_CAN_INT_REG]		= 0x10,
 	[C_CAN_TEST_REG]	= 0x14,
+	[C_CAN_FUNCTION_REG]	= 0x18,
 	[C_CAN_TXRQST1_REG]	= 0x88,
 	[C_CAN_TXRQST2_REG]	= 0x8A,
 	[C_CAN_NEWDAT1_REG]	= 0x9C,
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
