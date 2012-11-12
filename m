From: Andreas Larsson <andreas@gaisler.com>
Subject: Re: [PATCH v2] can: sja1000: Make sja1000_of_platform selectable
 and compilable on SPARC
Date: Mon, 12 Nov 2012 18:52:38 +0100
Message-ID: <50A13766.7040407@gaisler.com>
References: <506D9266.6010707@gaisler.com> <1349359150-18012-1-git-send-email-andreas@gaisler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from vsp-authed02.binero.net ([195.74.38.226]:34420 "HELO
	vsp-authed-02-02.binero.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753961Ab2KLRwt (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 12 Nov 2012 12:52:49 -0500
In-Reply-To: <1349359150-18012-1-git-send-email-andreas@gaisler.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: software@gaisler.com, linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>

On 10/04/2012 03:59 PM, Andreas Larsson wrote:
> Signed-off-by: Andreas Larsson <andreas@gaisler.com>

Hi!

As of v3.7-rc5, this patch now works properly (of_address_to_resource is now 
once again available for sparc). It would be nice to have it applied, unless the 
work on integrating sja1000_of_platform into sja1000_platform will be applied 
soon (and work for sparc). I'll be happy to test new versions on that initiative 
if that is the way you want to go.

It would be nice to get sja1000 to work on sparc soon in some way or another.

Cheers,
Andreas


> ---
>   drivers/net/can/sja1000/Kconfig               |    2 +-
>   drivers/net/can/sja1000/sja1000_of_platform.c |    6 ++++--
>   2 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/can/sja1000/Kconfig b/drivers/net/can/sja1000/Kconfig
> index 03df9a8..44abee4 100644
> --- a/drivers/net/can/sja1000/Kconfig
> +++ b/drivers/net/can/sja1000/Kconfig
> @@ -21,7 +21,7 @@ config CAN_SJA1000_PLATFORM
>
>   config CAN_SJA1000_OF_PLATFORM
>   	tristate "Generic OF Platform Bus based SJA1000 driver"
> -	depends on PPC_OF
> +	depends on OF
>   	---help---
>   	  This driver adds support for the SJA1000 chips connected to
>   	  the OpenFirmware "platform bus" found on embedded systems with
> diff --git a/drivers/net/can/sja1000/sja1000_of_platform.c b/drivers/net/can/sja1000/sja1000_of_platform.c
> index f2683eb..e45258d 100644
> --- a/drivers/net/can/sja1000/sja1000_of_platform.c
> +++ b/drivers/net/can/sja1000/sja1000_of_platform.c
> @@ -42,6 +42,8 @@
>   #include <linux/can/dev.h>
>
>   #include <linux/of_platform.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
>   #include <asm/prom.h>
>
>   #include "sja1000.h"
> @@ -59,13 +61,13 @@ MODULE_LICENSE("GPL v2");
>
>   static u8 sja1000_ofp_read_reg(const struct sja1000_priv *priv, int reg)
>   {
> -	return in_8(priv->reg_base + reg);
> +	return ioread8(priv->reg_base + reg);
>   }
>
>   static void sja1000_ofp_write_reg(const struct sja1000_priv *priv,
>   				  int reg, u8 val)
>   {
> -	out_8(priv->reg_base + reg, val);
> +	iowrite8(val, priv->reg_base + reg);
>   }
>
>   static int __devexit sja1000_ofp_remove(struct platform_device *ofdev)
>

