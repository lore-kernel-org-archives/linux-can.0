From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH 1/3 v2] can/usb: PEAK-System Technik USB adapters driver
 core
Date: Wed, 18 Jan 2012 14:27:18 +0100
Message-ID: <4F16C8B6.4060401@grandegger.com>
References: <1326468404-19330-1-git-send-email-s.grosjean@peak-system.com> <1326468404-19330-2-git-send-email-s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:59743 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754365Ab2ARN1U (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 18 Jan 2012 08:27:20 -0500
In-Reply-To: <1326468404-19330-2-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can Mailing List <linux-can@vger.kernel.org>

On 01/13/2012 04:26 PM, Stephane Grosjean wrote:
> This patch adds the core of the peak_usb driver which handles PEAK-System
> Technik PCAN USB adapters. It defines the parts which are common to the
> PCAN-USB adapters: can network interfaces management, network-to/from-usb
> data path interface, timestamps management...
> 
> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
> Tested-by: Stephane Grosjean <s.grosjean@peak-system.com>

It's unusual to add "Tested-by" if there is already your
"Signed-off-by". We assume that you have tested the patches.

> ---
>  drivers/net/can/usb/Kconfig                  |    6 +
>  drivers/net/can/usb/Makefile                 |    1 +
>  drivers/net/can/usb/peak_usb/Makefile        |    2 +
>  drivers/net/can/usb/peak_usb/pcan_usb_core.c |  874 ++++++++++++++++++++++++++
>  drivers/net/can/usb/peak_usb/pcan_usb_core.h |  138 ++++
>  5 files changed, 1021 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/net/can/usb/peak_usb/Makefile
>  create mode 100644 drivers/net/can/usb/peak_usb/pcan_usb_core.c
>  create mode 100644 drivers/net/can/usb/peak_usb/pcan_usb_core.h
> 
> diff --git a/drivers/net/can/usb/Kconfig b/drivers/net/can/usb/Kconfig
> index 0452549..69e3cb6 100644
> --- a/drivers/net/can/usb/Kconfig
> +++ b/drivers/net/can/usb/Kconfig
> @@ -13,4 +13,10 @@ config CAN_ESD_USB2
>            This driver supports the CAN-USB/2 interface
>            from esd electronic system design gmbh (http://www.esd.eu).
>  
> +config CAN_PEAK_USB
> +        tristate "PEAK PCAN-USB/USB Pro interfaces"
> +        ---help---
> +          This driver supports the PCAN-USB and PCAN-USB Pro adapters
> +	  from PEAK-System Technik (http://www.peak-system.com).

Please use tabs for the lines above.

> +
>  endmenu
> diff --git a/drivers/net/can/usb/Makefile b/drivers/net/can/usb/Makefile
> index fce3cf1..da6d1d3 100644
> --- a/drivers/net/can/usb/Makefile
> +++ b/drivers/net/can/usb/Makefile
> @@ -4,5 +4,6 @@
>  
>  obj-$(CONFIG_CAN_EMS_USB) += ems_usb.o
>  obj-$(CONFIG_CAN_ESD_USB2) += esd_usb2.o
> +obj-$(CONFIG_CAN_PEAK_USB) += peak_usb/
>  
>  ccflags-$(CONFIG_CAN_DEBUG_DEVICES) := -DDEBUG
> diff --git a/drivers/net/can/usb/peak_usb/Makefile b/drivers/net/can/usb/peak_usb/Makefile
> new file mode 100644
> index 0000000..1aefbc8
> --- /dev/null
> +++ b/drivers/net/can/usb/peak_usb/Makefile
> @@ -0,0 +1,2 @@
> +obj-$(CONFIG_CAN_PEAK_USB) += peak_usb.o
> +peak_usb-y = pcan_usb_core.o pcan_usb.o pcan_usb_pro.o
> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> new file mode 100644
> index 0000000..c5cd088
> --- /dev/null
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> @@ -0,0 +1,874 @@
> +/*
> + * CAN driver for PEAK System USB adapters
> + * Derived from the PCAN project file driver/src/pcan_usb_core.c
> + *
> + * Copyright (C) 2003-2010 PEAK System-Technik GmbH
> + * Copyright (C) 2010-2012 Stephane Grosjean <s.grosjean@peak-system.com>
> + *
> + * Many thanks to Klaus Hitschler <klaus.hitschler@gmx.de>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published
> + * by the Free Software Foundation; version 2 of the License.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + */
> +#include <linux/init.h>
> +#include <linux/signal.h>
> +#include <linux/slab.h>
> +#include <linux/module.h>
> +#include <linux/netdevice.h>
> +#include <linux/usb.h>
> +#include <linux/stringify.h>

Is it needed any longer?

...

> +static netdev_tx_t peak_usb_ndo_start_xmit(struct sk_buff *skb,
> +					   struct net_device *netdev)
> +{
> +	struct peak_usb_device *dev = netdev_priv(netdev);
> +	struct peak_tx_urb_context *context = NULL;
> +	struct net_device_stats *stats = &netdev->stats;
> +	struct can_frame *cf = (struct can_frame *)skb->data;
> +	struct urb *urb;
> +	u8 *obuf;
> +	int i, err;
> +	size_t size = dev->adapter->tx_buffer_size;
> +
> +	if (can_dropped_invalid_skb(netdev, skb))
> +		return NETDEV_TX_OK;
> +
> +	if (!dev->adapter->dev_encode_msg)
> +		return NETDEV_TX_OK;

dev_kfree_skb(skb); missing?

...

> +static void __exit peak_usb_exit(void)
> +{
> +	int err;
> +
> +	/* last chance do send some synchronous commands here */
> +	err = driver_for_each_device(&peak_usb_driver.drvwrap.driver, NULL,
> +				     NULL, peak_usb_do_device_exit);
> +
> +	/* only because of __must_check attribute */
> +	if (err)
> +		err = 0;

This is wired. Why not adding a reasonable error message.

Wolfgang.
