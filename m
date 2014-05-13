From: Pavel Machek <pavel@denx.de>
Subject: [PATCHv3] C_CAN: hwinit support for non-TI devices
Date: Tue, 13 May 2014 15:09:14 +0200
Message-ID: <20140513130914.GA9806@amd.pavel.ucw.cz>
References: <1398716449.836.4.camel@dinh-ubuntu>
 <20140428211505.GA28242@amd.pavel.ucw.cz>
 <CAF03EBf9KXqB4W9GuDduhLwp_kwFjUEi3syU7fX3KpXfZEFxHg@mail.gmail.com>
 <CAF03EBd19PC5RAsLR6-dMPF2x3XRf9X4bFPgX2kRdCYWUQBYcA@mail.gmail.com>
 <20140430215359.GA15148@amd.pavel.ucw.cz>
 <CAF03EBewoV0pOOmNQBwPrKgm-zhaSbFcNd_UiEhFWyUrq91-Jg@mail.gmail.com>
 <20140502084851.GA5730@amd.pavel.ucw.cz>
 <20140505120801.GA16461@amd.pavel.ucw.cz>
 <20140506135702.GA9879@amd.pavel.ucw.cz>
 <5370ED11.4000002@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:52422 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753943AbaEMNJQ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 13 May 2014 09:09:16 -0400
Content-Disposition: inline
In-Reply-To: <5370ED11.4000002@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Thor Thayer <tthayer.linux@gmail.com>, Thor Thayer <tthayer@altera.com>, Dinh Nguyen <dinguyen@altera.com>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org, socketcan@hartkopp.net, wg@grandegger.com

Non-TI chips (including socfpga) needs different raminit
sequence. Implement it.

const's in the hwinit prototype forced me to add const to more
prototypes. This makes changes bigger but the result is cleaner.

Unfortunately, testing-c_can does not boot on sockit, but previous
version of patch was tested by me and Thor Thayer.

Tested-by: Thor Thayer <tthayer@altera.com>
Signed-off-by: Thor Thayer <tthayer@altera.com>
Signed-off-by: Pavel Machek <pavel@denx.de>

diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_can.h
index ce0e642..99ad1aa 100644
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
@@ -176,8 +178,10 @@ struct c_can_priv {
 	atomic_t tx_active;
 	unsigned long tx_dir;
 	int last_status;
-	u16 (*read_reg) (struct c_can_priv *priv, enum reg index);
-	void (*write_reg) (struct c_can_priv *priv, enum reg index, u16 val);
+	u16 (*read_reg) (const struct c_can_priv *priv, enum reg index);
+	void (*write_reg) (const struct c_can_priv *priv, enum reg index, u16 val);
+	u32 (*read_reg32) (const struct c_can_priv *priv, enum reg index);
+	void (*write_reg32) (const struct c_can_priv *priv, enum reg index, u32 val);
 	void __iomem *base;
 	const u16 *regs;
 	void *priv;		/* for board-specific data */
@@ -188,8 +192,6 @@ struct c_can_priv {
 	u32 comm_rcv_high;
 	u32 rxmasked;
 	u32 dlc[C_CAN_MSG_OBJ_TX_NUM];
-	u32 (*read_reg32) (struct c_can_priv *priv, enum reg index);
-	void (*write_reg32) (struct c_can_priv *priv, enum reg index, u32 val);
 };
 
 struct net_device *alloc_c_can_dev(void);
diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index 002bf9b..b27dd8f 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -40,6 +40,7 @@
 #define CAN_RAMINIT_START_MASK(i)	(0x001 << (i))
 #define CAN_RAMINIT_DONE_MASK(i)	(0x100 << (i))
 #define CAN_RAMINIT_ALL_MASK(i)		(0x101 << (i))
+#define DCAN_RAM_INIT_BIT	(1 << 3)
 static DEFINE_SPINLOCK(raminit_lock);
 /*
  * 16-bit c_can registers can be arranged differently in the memory
@@ -47,31 +48,31 @@ static DEFINE_SPINLOCK(raminit_lock);
  * registers can be aligned to a 16-bit boundary or 32-bit boundary etc.
  * Handle the same by providing a common read/write interface.
  */
-static u16 c_can_plat_read_reg_aligned_to_16bit(struct c_can_priv *priv,
+static u16 c_can_plat_read_reg_aligned_to_16bit(const struct c_can_priv *priv,
 						enum reg index)
 {
 	return readw(priv->base + priv->regs[index]);
 }
 
-static void c_can_plat_write_reg_aligned_to_16bit(struct c_can_priv *priv,
+static void c_can_plat_write_reg_aligned_to_16bit(const struct c_can_priv *priv,
 						enum reg index, u16 val)
 {
 	writew(val, priv->base + priv->regs[index]);
 }
 
-static u16 c_can_plat_read_reg_aligned_to_32bit(struct c_can_priv *priv,
+static u16 c_can_plat_read_reg_aligned_to_32bit(const struct c_can_priv *priv,
 						enum reg index)
 {
 	return readw(priv->base + 2 * priv->regs[index]);
 }
 
-static void c_can_plat_write_reg_aligned_to_32bit(struct c_can_priv *priv,
+static void c_can_plat_write_reg_aligned_to_32bit(const struct c_can_priv *priv,
 						enum reg index, u16 val)
 {
 	writew(val, priv->base + 2 * priv->regs[index]);
 }
 
-static void c_can_hw_raminit_wait(const struct c_can_priv *priv, u32 mask,
+static void c_can_hw_raminit_wait_ti(const struct c_can_priv *priv, u32 mask,
 				  u32 val)
 {
 	/* We look only at the bits of our instance. */
@@ -80,7 +81,7 @@ static void c_can_hw_raminit_wait(const struct c_can_priv *priv, u32 mask,
 		udelay(1);
 }
 
-static void c_can_hw_raminit(const struct c_can_priv *priv, bool enable)
+static void c_can_hw_raminit_ti(const struct c_can_priv *priv, bool enable)
 {
 	u32 mask = CAN_RAMINIT_ALL_MASK(priv->instance);
 	u32 ctrl;
@@ -96,19 +97,19 @@ static void c_can_hw_raminit(const struct c_can_priv *priv, bool enable)
 	ctrl |= CAN_RAMINIT_DONE_MASK(priv->instance);
 	writel(ctrl, priv->raminit_ctrlreg);
 	ctrl &= ~CAN_RAMINIT_DONE_MASK(priv->instance);
-	c_can_hw_raminit_wait(priv, ctrl, mask);
+	c_can_hw_raminit_wait_ti(priv, ctrl, mask);
 
 	if (enable) {
 		/* Set start bit and wait for the done bit. */
 		ctrl |= CAN_RAMINIT_START_MASK(priv->instance);
 		writel(ctrl, priv->raminit_ctrlreg);
 		ctrl |= CAN_RAMINIT_DONE_MASK(priv->instance);
-		c_can_hw_raminit_wait(priv, ctrl, mask);
+		c_can_hw_raminit_wait_ti(priv, ctrl, mask);
 	}
 	spin_unlock(&raminit_lock);
 }
 
-static u32 c_can_plat_read_reg32(struct c_can_priv *priv, enum reg index)
+static u32 c_can_plat_read_reg32(const struct c_can_priv *priv, enum reg index)
 {
 	u32 val;
 
@@ -118,24 +119,46 @@ static u32 c_can_plat_read_reg32(struct c_can_priv *priv, enum reg index)
 	return val;
 }
 
-static void c_can_plat_write_reg32(struct c_can_priv *priv, enum reg index,
+static void c_can_plat_write_reg32(const struct c_can_priv *priv, enum reg index,
 		u32 val)
 {
 	priv->write_reg(priv, index + 1, val>>16);
 	priv->write_reg(priv, index, val);
 }
 
-static u32 d_can_plat_read_reg32(struct c_can_priv *priv, enum reg index)
+static u32 d_can_plat_read_reg32(const struct c_can_priv *priv, enum reg index)
 {
 	return readl(priv->base + priv->regs[index]);
 }
 
-static void d_can_plat_write_reg32(struct c_can_priv *priv, enum reg index,
+static void d_can_plat_write_reg32(const struct c_can_priv *priv, enum reg index,
 		u32 val)
 {
 	writel(val, priv->base + priv->regs[index]);
 }
 
+static void c_can_hw_raminit_wait(const struct c_can_priv *priv, u32 mask)
+{
+	while (priv->read_reg32(priv, C_CAN_FUNCTION_REG) & mask)
+		udelay(1);
+}
+
+static void c_can_hw_raminit(const struct c_can_priv *priv, bool enable)
+{
+	u32 ctrl;
+
+	ctrl = priv->read_reg32(priv, C_CAN_FUNCTION_REG);
+	ctrl &= ~DCAN_RAM_INIT_BIT;
+	priv->write_reg32(priv, C_CAN_FUNCTION_REG, ctrl);
+	c_can_hw_raminit_wait(priv, ctrl);
+
+	if (enable) {
+		ctrl |= DCAN_RAM_INIT_BIT;
+		priv->write_reg32(priv, C_CAN_FUNCTION_REG, ctrl);
+		c_can_hw_raminit_wait(priv, ctrl);
+	}
+}
+
 static struct platform_device_id c_can_id_table[] = {
 	[BOSCH_C_CAN_PLATFORM] = {
 		.name = KBUILD_MODNAME,
@@ -255,11 +278,20 @@ static int c_can_plat_probe(struct platform_device *pdev)
 			priv->instance = pdev->id;
 
 		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+		/* Not all D_CAN modules have a separate register for the D_CAN
+		 * RAM initialization. Use default RAM init bit in D_CAN module
+		 * if not specified in DT.
+		 */
+		if (!res) {
+			priv->raminit = c_can_hw_raminit;
+			break;
+		}
+
 		priv->raminit_ctrlreg = devm_ioremap_resource(&pdev->dev, res);
 		if (IS_ERR(priv->raminit_ctrlreg) || priv->instance < 0)
 			dev_info(&pdev->dev, "control memory is not used for raminit\n");
 		else
-			priv->raminit = c_can_hw_raminit;
+			priv->raminit = c_can_hw_raminit_ti;
 		break;
 	default:
 		ret = -EINVAL;

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
