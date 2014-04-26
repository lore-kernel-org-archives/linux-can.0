From: Pavel Machek <pavel@denx.de>
Subject: Re: can problems on socfpga [was Re: [PATCH v2 4/6] ARM: socfpga:
 dts: add can0+1]
Date: Sat, 26 Apr 2014 11:16:58 +0200
Message-ID: <20140426091658.GB8730@amd.pavel.ucw.cz>
References: <1396422700-3962-1-git-send-email-s.trumtrar@pengutronix.de>
 <1396422700-3962-4-git-send-email-s.trumtrar@pengutronix.de>
 <20140404102815.GA9242@amd.pavel.ucw.cz>
 <20140425195319.GA3677@amd.pavel.ucw.cz>
 <1398457446.26387.0.camel@linux-builds1>
 <1398461518.3587.11.camel@dinh-ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:41310 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751547AbaDZJRA (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 26 Apr 2014 05:17:00 -0400
Content-Disposition: inline
In-Reply-To: <1398461518.3587.11.camel@dinh-ubuntu>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Thor Thayer <tthayer@altera.com>
Cc: Dinh Nguyen <dinguyen@altera.com>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org, socketcan@hartkopp.net, wg@grandegger.com, mkl@pengutronix.de, tthayer.linux@gmail.com

Hi!

> Hi! Yes, these warnings are being addressed in a patch I submitted that
> is currently being reviewed.
> (http://article.gmane.org/gmane.linux.can/5620/match=tthayer)

What about this patch, instead? It should provide same functionality,
but does not do hard-to-understand operations with 0s and ~0s, it more
obviously does not affect the TI version, and it still manages to add
less lines of code. (But I was not yet able to test it.)

Thanks,
								Pavel

---

    Add support to standard D_CAN RAM Init, as opposed to TI.
    
    Partly based on patch by Thor Thayer <tthayer@altera.com>
    
    Signed-off-by: Pavel Machek <pavel@denx.de>

diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_can.h
index faa8404..d436734 100644
--- a/drivers/net/can/c_can/c_can.h
+++ b/drivers/net/can/c_can/c_can.h
@@ -88,6 +88,7 @@ enum reg {
 	C_CAN_INTPND2_REG,
 	C_CAN_MSGVAL1_REG,
 	C_CAN_MSGVAL2_REG,
+	C_CAN_FUNCTION_REG,
 };
 
 static const u16 reg_map_c_can[] = {
@@ -139,6 +140,7 @@ static const u16 reg_map_d_can[] = {
 	[C_CAN_BRPEXT_REG]	= 0x0E,
 	[C_CAN_INT_REG]		= 0x10,
 	[C_CAN_TEST_REG]	= 0x14,
+	[C_CAN_FUNCTION_REG]	= 0x18,
 	[C_CAN_TXRQST1_REG]	= 0x88,
 	[C_CAN_TXRQST2_REG]	= 0x8A,
 	[C_CAN_NEWDAT1_REG]	= 0x9C,
diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index 806d927..fba168f 100644
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
@@ -80,7 +81,7 @@ static void c_can_hw_raminit_wait(const struct c_can_priv *priv, u32 mask,
 		udelay(1);
 }
 
-static void c_can_hw_raminit(const struct c_can_priv *priv, bool enable)
+static void c_can_hw_raminit_ti(const struct c_can_priv *priv, bool enable)
 {
 	u32 mask = CAN_RAMINIT_ALL_MASK(priv->instance);
 	u32 ctrl;
@@ -88,7 +89,8 @@ static void c_can_hw_raminit(const struct c_can_priv *priv, bool enable)
 	spin_lock(&raminit_lock);
 
 	ctrl = readl(priv->raminit_ctrlreg);
-	/* We clear the done and start bit first. The start bit is
+	/*
+	 * We clear the done and start bit first. The start bit is
 	 * looking at the 0 -> transition, but is not self clearing;
 	 * And we clear the init done bit as well.
 	 */
@@ -108,6 +110,26 @@ static void c_can_hw_raminit(const struct c_can_priv *priv, bool enable)
 	spin_unlock(&raminit_lock);
 }
 
+static void c_can_hw_raminit(const struct c_can_priv *priv, bool enable)
+{
+	u32 ctrl;
+
+	spin_lock(&raminit_lock);
+
+	ctrl = readl(priv->raminit_ctrlreg);
+	ctrl &= ~DCAN_RAM_INIT_BIT;
+	writel(ctrl, priv->raminit_ctrlreg);
+	c_can_hw_raminit_wait(priv, ctrl, 0);
+
+	if (enable) {
+		/* Set start bit. */
+		ctrl |= DCAN_RAM_INIT_BIT;
+		writel(ctrl, priv->raminit_ctrlreg);
+		c_can_hw_raminit_wait(priv, ctrl, 0);
+	}
+	spin_unlock(&raminit_lock);
+}
+
 static struct platform_device_id c_can_id_table[] = {
 	[BOSCH_C_CAN_PLATFORM] = {
 		.name = KBUILD_MODNAME,
@@ -221,11 +243,22 @@ static int c_can_plat_probe(struct platform_device *pdev)
 			priv->instance = pdev->id;
 
 		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+		/*
+		 * Not all D_CAN module have a separate register for the D_CAN
+		 * RAM initialization. Use default RAM init bit in D_CAN module
+		 * if not specified in DT.
+		 */
+		if (!res) {
+			priv->raminit = c_can_hw_raminit;
+			priv->raminit_ctrlreg = addr + priv->regs[C_CAN_FUNCTION_REG];
+			break;
+		}
+
 		priv->raminit_ctrlreg = devm_ioremap_resource(&pdev->dev, res);
 		if (IS_ERR(priv->raminit_ctrlreg) || (int)priv->instance < 0)
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
