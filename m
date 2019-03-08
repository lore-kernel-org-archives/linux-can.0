From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v7 1/4] can: m_can: Create a m_can platform framework
Date: Fri, 8 Mar 2019 11:10:25 +0100
Message-ID: <5065d6ba-f195-a695-77b1-b837cac1a199@grandegger.com>
References: <20190305155220.14037-1-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190305155220.14037-1-dmurphy@ti.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>, mkl@pengutronix.de, davem@davemloft.net
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Hallo Dan,

Am 05.03.19 um 16:52 schrieb Dan Murphy:
> Create a m_can platform framework that peripherial
> devices can register to and use common code and register sets.
> The peripherial devices may provide read/write and configuration
> support of the IP.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
> 
> 
> v7 - Fixed remaining new checkpatch issues, removed CSR setting, fixed tx hard
> start function to return tx_busy, and renamed device callbacks - https://lore.kernel.org/patchwork/patch/1047220/
> 
> v6 - Squashed platform patch to this patch for bissectablity, fixed coding style
> issues, updated Kconfig help, placed mcan reg offsets back into c file, renamed
> priv->skb to priv->tx_skb and cleared perp interrupts at ISR start -
> Patch 1 comments - https://lore.kernel.org/patchwork/patch/1042446/
> Patch 2 comments - https://lore.kernel.org/patchwork/patch/1042442/
> 
>  drivers/net/can/m_can/Kconfig          |  13 +-
>  drivers/net/can/m_can/Makefile         |   1 +
>  drivers/net/can/m_can/m_can.c          | 700 +++++++++++++------------
>  drivers/net/can/m_can/m_can.h          | 110 ++++
>  drivers/net/can/m_can/m_can_platform.c | 202 +++++++
>  5 files changed, 682 insertions(+), 344 deletions(-)
>  create mode 100644 drivers/net/can/m_can/m_can.h
>  create mode 100644 drivers/net/can/m_can/m_can_platform.c
> 
> diff --git a/drivers/net/can/m_can/Kconfig b/drivers/net/can/m_can/Kconfig
> index 04f20dd39007..f7119fd72df4 100644
> --- a/drivers/net/can/m_can/Kconfig
> +++ b/drivers/net/can/m_can/Kconfig
> @@ -1,5 +1,14 @@
>  config CAN_M_CAN
> +	tristate "Bosch M_CAN support"
> +	---help---
> +	  Say Y here if you want support for Bosch M_CAN controller framework.
> +	  This is common support for devices that embed the Bosch M_CAN IP.
> +
> +config CAN_M_CAN_PLATFORM
> +	tristate "Bosch M_CAN support for io-mapped devices"
>  	depends on HAS_IOMEM
> -	tristate "Bosch M_CAN devices"
> +	depends on CAN_M_CAN
>  	---help---
> -	  Say Y here if you want to support for Bosch M_CAN controller.
> +	  Say Y here if you want support for IO Mapped Bosch M_CAN controller.
> +	  This support is for devices that have the Bosch M_CAN controller
> +	  IP embedded into the device and the IP is IO Mapped to the processor.
> diff --git a/drivers/net/can/m_can/Makefile b/drivers/net/can/m_can/Makefile
> index 8bbd7f24f5be..057bbcdb3c74 100644
> --- a/drivers/net/can/m_can/Makefile
> +++ b/drivers/net/can/m_can/Makefile
> @@ -3,3 +3,4 @@
>  #
>  
>  obj-$(CONFIG_CAN_M_CAN) += m_can.o
> +obj-$(CONFIG_CAN_M_CAN_PLATFORM) += m_can_platform.o
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index 9b449400376b..a60278d94126 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c

... snip...

> +static netdev_tx_t m_can_start_xmit(struct sk_buff *skb,
> +				    struct net_device *dev)
> +{
> +	struct m_can_priv *priv = netdev_priv(dev);
> +
> +	if (can_dropped_invalid_skb(dev, skb))
> +		return NETDEV_TX_OK;
> +
> +	if (priv->is_peripherial) {
> +		if (priv->tx_skb) {
> +			netdev_err(dev, "hard_xmit called while tx busy\n");
> +			return NETDEV_TX_BUSY;
> +		}

The problem with that approach is, that the upper layer will try to
resubmit the current "skb" but not the previous "tx_skb". And the
previous "tx_skb" has not been freed yet. I would just drop and free the
skb and return NETDEV_TX_OK in m_can_tx_handler() for peripheral devices
(like can_dropped_invalid_skb() does).

> +
> +		priv->tx_skb = skb;
> +		netif_stop_queue(priv->net);
> +		queue_work(priv->tx_wq, &priv->tx_work);
> +	} else {
> +		priv->tx_skb = skb;
> +		return m_can_tx_handler(priv);
>  	}
>  
>  	return NETDEV_TX_OK;
>  }

Wolfgang.
