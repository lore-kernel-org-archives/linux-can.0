From: Pavel Machek <pavel@denx.de>
Subject: Re: can problems on socfpga [was Re: [PATCH v2 4/6] ARM: socfpga:
 dts: add can0+1]
Date: Sat, 26 Apr 2014 10:57:07 +0200
Message-ID: <20140426085707.GA8730@amd.pavel.ucw.cz>
References: <1396422700-3962-1-git-send-email-s.trumtrar@pengutronix.de>
 <1396422700-3962-4-git-send-email-s.trumtrar@pengutronix.de>
 <20140404102815.GA9242@amd.pavel.ucw.cz>
 <20140425195319.GA3677@amd.pavel.ucw.cz>
 <1398457446.26387.0.camel@linux-builds1>
 <1398461518.3587.11.camel@dinh-ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:40657 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290AbaDZI5I (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 26 Apr 2014 04:57:08 -0400
Content-Disposition: inline
In-Reply-To: <1398461518.3587.11.camel@dinh-ubuntu>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Thor Thayer <tthayer@altera.com>
Cc: Dinh Nguyen <dinguyen@altera.com>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org, socketcan@hartkopp.net, wg@grandegger.com, mkl@pengutronix.de, tthayer.linux@gmail.com

Hi!

> > > Actually, does it work for you? Here it produces warnings during boot
> > > 
> > > c_can_platform ffc00000.d_can: invalid resource
> > > c_can_platform ffc00000.d_can: control memory is not used for raminit
> > > c_can_platform ffc00000.d_can: c_can_platform device registered
> > > (regs=9085c000, irq=163)
> 
> Hi! Yes, these warnings are being addressed in a patch I submitted that
> is currently being reviewed.
> (http://article.gmane.org/gmane.linux.can/5620/match=tthayer)

That will still produce the 

c_can_platform ffc00000.d_can: invalid resource

message, no? Anyway, I did something along those lines,
too. (untested). I wonder if raminit_type is a good idea... I believe
it would be nicer to just use separate raminit function...

> To get this working well, I had to install a few of the patches that
> Benedict Spranger submitted ([PATCH 05/16] c_can: use 32 bit access for
> D_CAN) on 9/9/2013.

> I have the patches on our rocketboard branch
> (rocketboards.org/gitweb/?p=linux-socfpga-git;a=summary)

Thanks a lot for the pointers. I knew about these, but then forgot.

Best regards,
 									Pavel


[This is what I did for debugging.]

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 5f2c8a4..4bc48cc 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -454,7 +454,7 @@
 		dcan0: d_can@ffc00000 {
 			compatible = "bosch,d_can";
 			reg = <0xffc00000 0x1000>;
-			interrupts = <0 131 4>, <0 132 4>;
+			interrupts = <0 131 4>, <0 132 4>, <0 133 4>, <0 134 4>;
 			clocks = <&can0_clk>;
 			status = "disabled";
 		};
@@ -462,7 +462,7 @@
 		dcan1: d_can@ffc01000 {
 			compatible = "bosch,d_can";
 			reg = <0xffc01000 0x1000>;
-			interrupts = <0 135 4>, <0 136 4>;
+			interrupts = <0 135 4>, <0 136 4>, <0 137 4>, <0 138 4>;
 			clocks = <&can1_clk>;
 			status = "disabled";
 		};
diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index 806d927..6d9514d 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -80,6 +80,15 @@ static void c_can_hw_raminit_wait(const struct c_can_priv *priv, u32 mask,
 		udelay(1);
 }
 
+/* socfpga has CFR at offset 0x18, bit 0x08 is "request automatic ram init". Needed?
+   CCTRL.1 bit needs to be set for this.
+
+
+   CRR at offset 0x20 should contain revision information.
+
+   HWS contains information about # of objects
+*/
+
 static void c_can_hw_raminit(const struct c_can_priv *priv, bool enable)
 {
 	u32 mask = CAN_RAMINIT_ALL_MASK(priv->instance);
@@ -88,7 +97,8 @@ static void c_can_hw_raminit(const struct c_can_priv *priv, bool enable)
 	spin_lock(&raminit_lock);
 
 	ctrl = readl(priv->raminit_ctrlreg);
-	/* We clear the done and start bit first. The start bit is
+	/*
+	 * We clear the done and start bit first. The start bit is
 	 * looking at the 0 -> transition, but is not self clearing;
 	 * And we clear the init done bit as well.
 	 */
@@ -193,6 +203,8 @@ static int c_can_plat_probe(struct platform_device *pdev)
 		goto exit_iounmap;
 	}
 
+	printk("net device\n");
+
 	priv = netdev_priv(dev);
 	switch (id->driver_data) {
 	case BOSCH_C_CAN:
@@ -220,11 +232,26 @@ static int c_can_plat_probe(struct platform_device *pdev)
 		else
 			priv->instance = pdev->id;
 
+		printk("d_can: get resource\n");
 		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+		printk("d_can: ioremap_resource\n");
 		priv->raminit_ctrlreg = devm_ioremap_resource(&pdev->dev, res);
-		if (IS_ERR(priv->raminit_ctrlreg) || (int)priv->instance < 0)
+		if (IS_ERR(priv->raminit_ctrlreg) || (int)priv->instance < 0) {
+			u32 version;
 			dev_info(&pdev->dev, "control memory is not used for raminit\n");
-		else
+			
+#if 0
+			version = readl(addr + 0x20); /* CRR */
+			printk("Version, should be 11161128: %lx\n", version);
+			/* CFR */
+			writel(8, addr + 0x18);
+			if (!(readl(addr + 0x18) & 8))
+				printk("Not initializing?\n");
+
+			while (readl(addr + 0x18) & 8)
+				printk("Waiting for init...\n");
+#endif			
+		} else
 			priv->raminit = c_can_hw_raminit;
 		break;
 	default:
@@ -242,6 +269,8 @@ static int c_can_plat_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, dev);
 	SET_NETDEV_DEV(dev, &pdev->dev);
 
+	printk("..register\n");
+
 	ret = register_c_can_dev(dev);
 	if (ret) {
 		dev_err(&pdev->dev, "registering %s failed (err=%d)\n",


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
