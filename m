From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] can: flexcan: add a regulator for transceiver
Date: Tue, 3 Jul 2012 22:18:31 +0800
Message-ID: <20120703141829.GG22705@S2101-09.ap.freescale.net>
References: <1341319571-27763-1-git-send-email-shawn.guo@linaro.org>
 <20120703130747.GD25995@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:61448 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751854Ab2GCORt (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 3 Jul 2012 10:17:49 -0400
Received: by gglu4 with SMTP id u4so5310079ggl.19
        for <linux-can@vger.kernel.org>; Tue, 03 Jul 2012 07:17:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120703130747.GD25995@sirena.org.uk>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org

On Tue, Jul 03, 2012 at 02:07:47PM +0100, Mark Brown wrote:
> On Tue, Jul 03, 2012 at 08:46:11PM +0800, Shawn Guo wrote:
> 
> > +	if (priv->reg_xcvr) {
> > +		if (on)
> > +			regulator_enable(priv->reg_xcvr);
> > +		else
> > +			regulator_disable(priv->reg_xcvr);
> > +	}
> 
> No, the regulator API will stub itself out if not enabled, and if the
> supply is fixed then a fixed voltage regulator will do the job.  We
> shouldn't be open coding this stuff in individual users.

Ah, yes.  But when you say "a fixed voltage regulator", you actually
meant dummy regulator, right?

So the patch will becomes the following.

Regards,
Shawn

---8<----

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 81d4741..c521aa4 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -36,6 +36,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/regulator/consumer.h>

 #define DRV_NAME                       "flexcan"

@@ -179,6 +180,7 @@ struct flexcan_priv {
        u32 reg_ctrl_default;

        struct clk *clk;
+       struct regulator *reg_xcvr;
        struct flexcan_platform_data *pdata;
 };

@@ -224,6 +226,11 @@ static inline void flexcan_write(u32 val, void __iomem *addr)
  */
 static void flexcan_transceiver_switch(const struct flexcan_priv *priv, int on)
 {
+       if (on)
+               regulator_enable(priv->reg_xcvr);
+       else
+               regulator_disable(priv->reg_xcvr);
+
        if (priv->pdata && priv->pdata->transceiver_switch)
                priv->pdata->transceiver_switch(on);
 }
@@ -997,6 +1004,7 @@ static int __devinit flexcan_probe(struct platform_device *pdev)
        priv->base = base;
        priv->dev = dev;
        priv->clk = clk;
+       priv->reg_xcvr = devm_regulator_get(&pdev->dev, "xcvr");
        priv->pdata = pdev->dev.platform_data;

        netif_napi_add(dev, &priv->napi, flexcan_poll, FLEXCAN_NAPI_WEIGHT);


