From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [RFC PATCH v2 1/2] can: add tx/rx LED trigger support
Date: Tue, 24 Apr 2012 07:16:38 +0200
Message-ID: <4F963736.4040602@hartkopp.net>
References: <1335214966-20478-1-git-send-email-fabio.baltieri@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:36613 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889Ab2DXFQk (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 24 Apr 2012 01:16:40 -0400
In-Reply-To: <1335214966-20478-1-git-send-email-fabio.baltieri@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Fabio Baltieri <fabio.baltieri@gmail.com>
Cc: linux-can@vger.kernel.org

On 23.04.2012 23:02, Fabio Baltieri wrote:

> This patch implements the functions to add two LED triggers, named
> <ifname>-tx and <ifname>-rx, to a canbus device driver.


Hello Fabio,

to me it looks really good now. I understand everything of the idea at first
sight which is a good indicator for simple code ;-)

The only remark i currently have is ...

> 
> diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
> index bb709fd..74d6bfb 100644
> --- a/drivers/net/can/Kconfig
> +++ b/drivers/net/can/Kconfig
> @@ -54,6 +54,19 @@ config CAN_CALC_BITTIMING
>  	  arguments "tq", "prop_seg", "phase_seg1", "phase_seg2" and "sjw".
>  	  If unsure, say Y.
>  
> +config CAN_LEDS
> +	bool "Enable LED triggers for Netlink based drivers"
> +	depends on CAN


CAN_DEV and this entire Kconfig content itself depends on CAN (see at the top
of this Kconfig) so you can omit that line.

> +	depends on CAN_DEV
> +	depends on LEDS_CLASS
> +	select LEDS_TRIGGERS
> +	---help---
> +	  This option adds two LED triggers for packet receive and transmit
> +	  events on each supported CAN device.
> +
> +	  Say Y here if you are working on a system with led-class supported
> +	  LEDs and you want to use them as canbus activity indicators.
> +
>  config CAN_AT91
>  	tristate "Atmel AT91 onchip CAN controller"
>  	depends on CAN_DEV && (ARCH_AT91SAM9263 || ARCH_AT91SAM9X5)


Regards,
Oliver
