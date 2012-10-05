From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [RFC: PATCH 5/5] can: sja1000_platform: add device tree bindings
Date: Fri, 05 Oct 2012 17:47:32 +0200
Message-ID: <506F0114.3010708@grandegger.com>
References: <1349447947-18451-1-git-send-email-mkl@pengutronix.de> <1349447947-18451-6-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:48489 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755332Ab2JEPrp (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 5 Oct 2012 11:47:45 -0400
In-Reply-To: <1349447947-18451-6-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, andreas@gaisler.com, kernel@pengutronix.de

Hi Marc,

On 10/05/2012 04:39 PM, Marc Kleine-Budde wrote:
> This patch add device tree bindings, the are ported from the

typo?

> sja1000_of_platform driver:
> 
>     Copyright (C) 2008-2009 Wolfgang Grandegger <wg@grandegger.com>
> 
> The use of "of_get_property()" has been converted to "of_property_read_u32()"
> to be endianess safe.
> 
> Cc: Wolfgang Grandegger <wg@grandegger.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/net/can/sja1000/sja1000_platform.c |   91 +++++++++++++++++++++++++---
>  1 file changed, 84 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/can/sja1000/sja1000_platform.c b/drivers/net/can/sja1000/sja1000_platform.c
> index 6260209..91f7404 100644
> --- a/drivers/net/can/sja1000/sja1000_platform.c
> +++ b/drivers/net/can/sja1000/sja1000_platform.c
> @@ -1,6 +1,7 @@
>  /*
>   * Copyright (C) 2005 Sascha Hauer, Pengutronix
> - * Copyright (C) 2007 Wolfgang Grandegger <wg@grandegger.com>
> + * Copyright (C) 2007-2009 Wolfgang Grandegger <wg@grandegger.com>
> + * Copyright (C) 2012 Marc Kleine-Budde <mkl@pengutronix.de>
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the version 2 of the GNU General Public License
> @@ -11,15 +12,28 @@
>   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>   * GNU General Public License for more details.
>   *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + * This is a generic driver for SJA1000 chips on the OpenFirmware
> + * platform bus found on embedded systems. You need a SJA1000 CAN node
> + * definition in your flattened device tree source (DTS) file similar
> + * to:
> + *
> + *   can@3,100 {
> + *           compatible = "nxp,sja1000";
> + *           reg = <3 0x100 0x80>;
> + *           interrupts = <2 0>;
> + *           interrupt-parent = <&mpic>;
> + *           nxp,external-clock-frequency = <16000000>;
> + *   };
> + *
> + * See "Documentation/devicetree/bindings/net/can/sja1000.txt" for
> + * further information.
>   */
>  
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/interrupt.h>
>  #include <linux/netdevice.h>
> +#include <linux/of.h>
>  #include <linux/delay.h>
>  #include <linux/pci.h>
>  #include <linux/platform_device.h>
> @@ -30,6 +44,8 @@
>  
>  #include "sja1000.h"
>  
> +#define SP_DEFAULT_CLOCK	(16000000 / 2)
> +
>  MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de>");
>  MODULE_DESCRIPTION("Socket-CAN driver for SJA1000 on the platform bus");
>  MODULE_LICENSE("GPL v2");
> @@ -72,6 +88,61 @@ static void __devinit sp_probe_pdata(struct sja1000_priv *priv, const struct sja
>  	priv->cdr = pdata->cdr;
>  }
>  
> +#ifdef CONFIG_OF

Do we still need that dependency?

Thanks for cleaning up! Unfortunately, I do not have a board with a
platform sja1000. Well, I have a phyCORE-PXA270, but I'm not sure if I
get it working with the mainline kernel quickly.

Wolfgang.
