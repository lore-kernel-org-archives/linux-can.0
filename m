From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH] can: xilinx: fix xcan_start_xmit()'s return type
Date: Wed, 25 Apr 2018 09:10:37 +0200
Message-ID: <e55172a7-5003-e534-87ce-672291940114@xilinx.com>
References: <20180424131614.3357-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180424131614.3357-1-luc.vanoostenryck@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, linux-kernel@vger.kernel.org
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Michal Simek <michal.simek@xilinx.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-can.vger.kernel.org

On 24.4.2018 15:16, Luc Van Oostenryck wrote:
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

Can you please also align kernel-doc format above?
I see that the whole function is already returning proper enum values.

Thanks,
Michal
