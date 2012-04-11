From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [RFC PATCH] can: add tx/rx led trigger support
Date: Wed, 11 Apr 2012 16:45:59 +0200
Message-ID: <4F859927.1040404@grandegger.com>
References: <1334093965-2692-1-git-send-email-fabio.baltieri@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:51211 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754502Ab2DKOqB (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 11 Apr 2012 10:46:01 -0400
In-Reply-To: <1334093965-2692-1-git-send-email-fabio.baltieri@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Fabio Baltieri <fabio.baltieri@gmail.com>
Cc: linux-can@vger.kernel.org

Hi Fabio,

On 04/10/2012 11:39 PM, Fabio Baltieri wrote:
> This patch adds two led triggers, named <ifname>-tx and <ifname>-rx to
> each registered canbus interface.
> 
> Triggers are called from can_send() and can_rcv() functions in af_can.h,
> and can be disabled with a Kconfig option.
> 
> The implementation lights up the LED when a packet is transmitted or
> received and turn it off after a configurable time using a timer.
> 
> This only supports can-dev based drivers, as it uses some support field
> in the can_priv structure.
> 
> Signed-off-by: Fabio Baltieri <fabio.baltieri@gmail.com>
> ---
> Hi all,
> 
> this is a try to add generic tx/rx LED triggers for canbus interfaces, somthing
> I think is very useful in embedded systems where canbus devices often have
> status leds associated with them, maybe on the bus connector itself, like

Please define "often"? So far only a few CAN devices need LED control by
software. Actually, I only remember the PEAK PCMCIA card.

> ethernet interfaces. I saw a couple of hardware implementation to drive status
> leds from tx/rx lines but these were not as effective as software ones.

Why? LEDs are ususally controlled by software only if the hardware does
not do it (properly?). But your LED support cannot be compared with the
LEDs on the CAN devices itself. It will allow to trigger user-defined
LEDs by RX or TX activity, right? ... which might be useful especially
for debugging, I assume.

> The implementation is similar to the MAC80211_LEDS one, and takes quite a lot
> of inspiration and some code from it.
> 
> In this case, however, tx and rx events are trapped from the af_can source file
> as there are no generic tx/rx functions in can/dev.c. This also required an
> additional counter to discard rx events for looped frames.

Well, controlling the LEDs from the protocol level seems wrong to me. If
at all, it should be handled by the CAN device interface.

> Also, as all the support data are in the can_priv structure, this only supports
> can-dev based drivers. All the others are ignored by checking the
> netdev->rtnl_link_ops->kind string. This actually excludes only vcan and slcan
> drivers.
> 
> The implementation should be quite unintrusive on existing code and can be disabled
> altogether with a config option.

I find it rather intrusive, especially when #ifdef's should be avoided.
Furthermore it introduces overhead in the RX and TX path and uses a lot
of space in the "struct can_priv".

> This has been tested tested on x86 and a powerpc with a custom USB-CAN
> interface (which I hope to publish as open-hardware soon BTW) and i2c-based
> leds.
> 
> Any thoughts? Do you think this can be merged?

LED interface might be useful, especially for debugging. Why not
enabling it just if "CONFIG_CAN_DEBUG_DEVICES=y". Also LEDs for error
states would make sense.

Some more comments inline...

>  include/linux/can/dev.h |    9 +++
>  net/can/Kconfig         |   10 +++
>  net/can/Makefile        |    2 +
>  net/can/af_can.c        |   14 ++++-
>  net/can/led.c           |  154 +++++++++++++++++++++++++++++++++++++++++++++++
>  net/can/led.h           |   29 +++++++++
>  6 files changed, 217 insertions(+), 1 deletions(-)
>  create mode 100644 net/can/led.c
>  create mode 100644 net/can/led.h
> 
> diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
> index 5d2efe7..76eb70c 100644
> --- a/include/linux/can/dev.h
> +++ b/include/linux/can/dev.h
> @@ -16,6 +16,8 @@
>  #include <linux/can.h>
>  #include <linux/can/netlink.h>
>  #include <linux/can/error.h>
> +#include <linux/timer.h>
> +#include <linux/leds.h>
>  
>  /*
>   * CAN mode
> @@ -52,6 +54,13 @@ struct can_priv {
>  
>  	unsigned int echo_skb_max;
>  	struct sk_buff **echo_skb;
> +
> +#ifdef CONFIG_CAN_LEDS
> +	struct timer_list tx_off_timer, rx_off_timer;
> +	struct led_trigger *tx_led, *rx_led;
> +	char tx_led_name[32], rx_led_name[32];
> +	atomic_t led_discard_count;
> +#endif

This requires a lot of space. Please add just *one* pointer here and
allocate the required space when needed.

>  };
>  
>  /*
> diff --git a/net/can/Kconfig b/net/can/Kconfig
> index 0320069..55894b7 100644
> --- a/net/can/Kconfig
> +++ b/net/can/Kconfig
> @@ -52,4 +52,14 @@ config CAN_GW
>  	  They can be modified with AND/OR/XOR/SET operations as configured
>  	  by the netlink configuration interface known e.g. from iptables.
>  
> +config CAN_LEDS
> +	bool "Enable LED triggers for Netlink based drivers"
> +	depends on CAN
> +	depends on CAN_DEV
> +	depends on LEDS_CLASS
> +	select LEDS_TRIGGERS
> +	---help---
> +	  This option enables two LED triggers for packet receive and transmit
> +	  events on each CAN device based on the can-dev framework.
> +
>  source "drivers/net/can/Kconfig"
> diff --git a/net/can/Makefile b/net/can/Makefile
> index cef49eb..fc6b286 100644
> --- a/net/can/Makefile
> +++ b/net/can/Makefile
> @@ -5,6 +5,8 @@
>  obj-$(CONFIG_CAN)	+= can.o
>  can-y			:= af_can.o proc.o
>  
> +can-$(CONFIG_CAN_LEDS)	+= led.o
> +
>  obj-$(CONFIG_CAN_RAW)	+= can-raw.o
>  can-raw-y		:= raw.o

In this file you only find things for CAN protocol support. LEDs should
be handled by drivers/net/can/dev.c.

Wolfgang.
