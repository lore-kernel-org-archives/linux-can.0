From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v2 2/2] net: flexcan: add transceiver switch gpios support
Date: Thu, 28 Jun 2012 14:34:29 +0800
Message-ID: <20120628063426.GA22990@S2101-09.ap.freescale.net>
References: <1340853701-4488-1-git-send-email-shawn.guo@linaro.org>
 <1340853701-4488-3-git-send-email-shawn.guo@linaro.org>
 <4FEBF64F.1010804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:14883 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753171Ab2F1GeN (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 28 Jun 2012 02:34:13 -0400
Content-Disposition: inline
In-Reply-To: <4FEBF64F.1010804@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Hui Wang <jason77.wang@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Jun 28, 2012 at 02:14:39PM +0800, Hui Wang wrote:
> >diff --git a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
> >index 8ff324e..e0dbac7 100644
> >--- a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
> >+++ b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
> >@@ -15,6 +15,8 @@ Required properties:
> > Optional properties:
> > - clock-frequency : The oscillator frequency driving the flexcan device
> >+- phy-enable-gpios : Specify the gpio used to enable phy
> >+- phy-standby-gpios : Specify the gpio used to put phy into STANDBY mode
> > Example:
> Do we need to add new added entries in the example section as well.
> 
> E.g.
> 
> +        phy-enable-gpios = <&gpio1 4 0>; /* GPIO1_4, active high*/
> +        phy-standby-gpios = <&gpio1 2 1>; /* GPIO1_2, active low */
> 
I chose not to because after all these two are optional properties.

> >diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> >index 38c0690..1ce3f9e 100644
> >--- a/drivers/net/can/flexcan.c
> >+++ b/drivers/net/can/flexcan.c
> >@@ -26,6 +26,7 @@
> > #include <linux/can/platform/flexcan.h>
> > #include <linux/clk.h>
> > #include <linux/delay.h>
> >+#include <linux/gpio.h>
> It seems <linux/of_gpio.h> already unconditionally includes this header.

Documentation/SubmitChecklist

1: If you use a facility then #include the file that defines/declares
   that facility.  Don't depend on other header files pulling in ones
   that you use.

-- 
Regards,
Shawn

