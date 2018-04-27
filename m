From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH 3/3] can: xilinx: fix xcan_start_xmit()'s return type
Date: Fri, 27 Apr 2018 09:49:41 +0200
Message-ID: <79ea4ab6-a12a-21ad-b586-6a1dad176c0a@xilinx.com>
References: <20180426211339.30821-1-luc.vanoostenryck@gmail.com>
 <20180426211339.30821-4-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180426211339.30821-4-luc.vanoostenryck@gmail.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>, Michal Simek <michal.simek@xilinx.com>, "open list:CAN NETWORK DRIVERS" <linux-can@vger.kernel.org>, "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, "moderated list:ARM/Allwinner sunXi SoC support" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-can.vger.kernel.org

On 26.4.2018 23:13, Luc Van Oostenryck wrote:
> The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
> which is a typedef for an enum type, but the implementation in this
> driver returns an 'int'.
> 
> Fix this by returning 'netdev_tx_t' in this driver too.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  drivers/net/can/xilinx_can.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
> index 89aec07c2..a19648606 100644
> --- a/drivers/net/can/xilinx_can.c
> +++ b/drivers/net/can/xilinx_can.c
> @@ -386,7 +386,7 @@ static int xcan_do_set_mode(struct net_device *ndev, enum can_mode mode)
>   *
>   * Return: 0 on success and failure value on error
>   */
> -static int xcan_start_xmit(struct sk_buff *skb, struct net_device *ndev)
> +static netdev_tx_t xcan_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>  {
>  	struct xcan_priv *priv = netdev_priv(ndev);
>  	struct net_device_stats *stats = &ndev->stats;
> 

It was applied already but there should be also kernel-doc update too to
use enum values instead of 0.

M
