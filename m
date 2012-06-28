From: Hui Wang <jason77.wang@gmail.com>
Subject: Re: [PATCH v2 2/2] net: flexcan: add transceiver switch gpios support
Date: Thu, 28 Jun 2012 14:14:39 +0800
Message-ID: <4FEBF64F.1010804@gmail.com>
References: <1340853701-4488-1-git-send-email-shawn.guo@linaro.org> <1340853701-4488-3-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:59848 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932303Ab2F1GO5 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 28 Jun 2012 02:14:57 -0400
In-Reply-To: <1340853701-4488-3-git-send-email-shawn.guo@linaro.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Hui Wang <jason77.wang@gmail.com>, "David S. Miller" <davem@davemloft.net>, linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Shawn Guo wrote:
> The flexcan driver has function pointer transceiver_switch defined in
> flexcan_platform_data for platform codes to hook up their transceiver
> switch implementation.  However this does not cope with device tree
> probe.
>
> It's been observed that platforms mostly use gpios to control the
> switch of flexcan transceiver, like enable and standby.  The patch
> adds transceiver switch gpios support into flexcan driver, so that
> platforms booting from device tree can just define properties
> phy-enable-gpios and phy-standby-gpios to have flexcan driver control
> the gpios.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  .../devicetree/bindings/net/can/fsl-flexcan.txt    |    2 +
>  drivers/net/can/flexcan.c                          |   62 ++++++++++++++++++++
>  2 files changed, 64 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
> index 8ff324e..e0dbac7 100644
> --- a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
> +++ b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
> @@ -15,6 +15,8 @@ Required properties:
>  Optional properties:
>  
>  - clock-frequency : The oscillator frequency driving the flexcan device
> +- phy-enable-gpios : Specify the gpio used to enable phy
> +- phy-standby-gpios : Specify the gpio used to put phy into STANDBY mode
>  
>  Example:
>  
>   
Do we need to add new added entries in the example section as well.

E.g.

+        phy-enable-gpios = <&gpio1 4 0>; /* GPIO1_4, active high*/
+        phy-standby-gpios = <&gpio1 2 1>; /* GPIO1_2, active low */

> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index 38c0690..1ce3f9e 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -26,6 +26,7 @@
>  #include <linux/can/platform/flexcan.h>
>  #include <linux/clk.h>
>  #include <linux/delay.h>
> +#include <linux/gpio.h>
>   
It seems <linux/of_gpio.h> already unconditionally includes this header.
>  #include <linux/if_arp.h>
>  #include <linux/if_ether.h>
>  #include <linux/interrupt.h>
> @@ -34,6 +35,7 @@
>  #include <linux/list.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_gpio.h>
>  #include <linux/platform_device.h>
>  #include <linux/pinctrl/consumer.h>
>  
>   

Other looks fine to me.

Regards,
Hui.
