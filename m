From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [RESEND] [PATCH] net: CAN: at91_can.c: decrease likelyhood of RX overruns
Date: Thu, 02 Oct 2014 14:41:25 +0200
Message-ID: <1547907.ZK2VXCpURP@ws-stein>
References: <1403775686-19352-1-git-send-email-david@protonic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:59506 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751972AbaJBMkk (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 2 Oct 2014 08:40:40 -0400
In-Reply-To: <1403775686-19352-1-git-send-email-david@protonic.nl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Jander <david@protonic.nl>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>, Oliver Hartkopp <socketcan@hartkopp.net>, "Hans J. Koch" <hjk@hansjkoch.de>

Hello David,

finally I got the chance to test your patch. I originally expected to test it on a AT91SAM9263, but I did it now on a AT91SAM9X35. The tests were done on a v3.17-rc7 kernel + a DT patch.
If I only run my CAN burst test without any other load on the ARM everything works fine, on the unpatched kernel, with your patch and also with rx-fifo branch of https://gitorious.org/linux-can/linux-can-next.
When running an iperf (client on PC) in parallel, the situation is as follows:
unpatched kernel:
  driver hangs after ~15s. No messages are received again while the kernel is still running.
your patch:
  37346 of 500000 msg lost
rx-fifo:
  36806 of 500000 msg lost

The CAN burst test:
This is done by 2 external embedded boards starting to sent CAN frames once they receive a start CAN frame from the ARM board. Each one sents frames at 1MBit/s including their own individual CAN ID with 4 data bytes containing a counter.
Every 200ms each device starts sending a burst of 250 frames. Using two devices ensures that there is no space bewteen messages. They are sent as fast as possible.
All received frames are evaluated on ARM for message losts and reorderings.

I can't say which implementation is actually better, read as how much is improved. But as the driver doesn't lockup at least one of those should be added.
A problem on AT91SAM9X5 for the performance is it only has 8 mailboxes, compared to 16 on 9263.

Best regards,
Alexander

On Thursday 26 June 2014 11:41:26, David Jander wrote:
> Use an RX kfifo to empty receive message boxes as soon as possible in
> the interrupt handler to avoid RX overruns if napi polls are late due to
> latency.
> 
> Signed-off-by: David Jander <david@protonic.nl>
> ---
>  drivers/net/can/at91_can.c | 100 ++++++++++++++++++++++++++++++++-------------
>  1 file changed, 71 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
> index 6ee1acd..1c53a44 100644
> --- a/drivers/net/can/at91_can.c
> +++ b/drivers/net/can/at91_can.c
> @@ -24,6 +24,7 @@
>  #include <linux/if_arp.h>
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
> +#include <linux/kfifo.h>
>  #include <linux/module.h>
>  #include <linux/netdevice.h>
>  #include <linux/of.h>
> @@ -153,6 +154,16 @@ struct at91_priv {
>  	struct at91_can_data *pdata;
>  
>  	canid_t mb0_id;
> +
> +/*
> + * The AT91 SoC CAN controller (specially the one in some newer SoCs)
> + * has very little message boxes. On a busy high-speed network, latency
> + * may be too high for napi to catch up before RX overrun occurs.
> + * Therefor we declare a big enough kfifo and fill it directly from
> + * interrupt.
> + */
> +#define RX_KFIFO_SIZE 512
> +	DECLARE_KFIFO_PTR(rx_fifo, struct sk_buff *);
>  };
>  
>  static const struct at91_devtype_data at91_at91sam9263_data = {
> @@ -449,6 +460,26 @@ static void at91_chip_stop(struct net_device *dev, enum can_state state)
>  	priv->can.state = state;
>  }
>  
> +static int at91_rx_fifo_in(struct net_device *dev, struct sk_buff *skb)
> +{
> +	struct at91_priv *priv = netdev_priv(dev);
> +	unsigned int len = kfifo_put(&priv->rx_fifo, skb);
> +
> +	if (len == sizeof(skb))
> +		return 0;
> +	return -ENOMEM;
> +}
> +
> +static int at91_rx_fifo_out(struct net_device *dev, struct sk_buff **skb)
> +{
> +	struct at91_priv *priv = netdev_priv(dev);
> +	unsigned int len = kfifo_get(&priv->rx_fifo, skb);
> +
> +	if (len == sizeof(skb))
> +		return 0;
> +	return -ENOENT;
> +}
> +
>  /*
>   * theory of operation:
>   *
> @@ -578,7 +609,7 @@ static void at91_rx_overflow_err(struct net_device *dev)
>  
>  	cf->can_id |= CAN_ERR_CRTL;
>  	cf->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
> -	netif_receive_skb(skb);
> +	at91_rx_fifo_in(dev, skb);
>  
>  	stats->rx_packets++;
>  	stats->rx_bytes += cf->can_dlc;
> @@ -643,7 +674,7 @@ static void at91_read_msg(struct net_device *dev, unsigned int mb)
>  	}
>  
>  	at91_read_mb(dev, mb, cf);
> -	netif_receive_skb(skb);
> +	at91_rx_fifo_in(dev, skb);
>  
>  	stats->rx_packets++;
>  	stats->rx_bytes += cf->can_dlc;
> @@ -700,7 +731,7 @@ static void at91_read_msg(struct net_device *dev, unsigned int mb)
>   * quota.
>   *
>   */
> -static int at91_poll_rx(struct net_device *dev, int quota)
> +static int at91_poll_rx(struct net_device *dev)
>  {
>  	struct at91_priv *priv = netdev_priv(dev);
>  	u32 reg_sr = at91_read(priv, AT91_SR);
> @@ -708,14 +739,9 @@ static int at91_poll_rx(struct net_device *dev, int quota)
>  	unsigned int mb;
>  	int received = 0;
>  
> -	if (priv->rx_next > get_mb_rx_low_last(priv) &&
> -	    reg_sr & get_mb_rx_low_mask(priv))
> -		netdev_info(dev,
> -			"order of incoming frames cannot be guaranteed\n");
> -
>   again:
>  	for (mb = find_next_bit(addr, get_mb_tx_first(priv), priv->rx_next);
> -	     mb < get_mb_tx_first(priv) && quota > 0;
> +	     mb < get_mb_tx_first(priv);
>  	     reg_sr = at91_read(priv, AT91_SR),
>  	     mb = find_next_bit(addr, get_mb_tx_first(priv), ++priv->rx_next)) {
>  		at91_read_msg(dev, mb);
> @@ -729,12 +755,11 @@ static int at91_poll_rx(struct net_device *dev, int quota)
>  			at91_activate_rx_mb(priv, mb);
>  
>  		received++;
> -		quota--;
>  	}
>  
>  	/* upper group completed, look again in lower */
>  	if (priv->rx_next > get_mb_rx_low_last(priv) &&
> -	    quota > 0 && mb > get_mb_rx_last(priv)) {
> +	    mb > get_mb_rx_last(priv)) {
>  		priv->rx_next = get_mb_rx_first(priv);
>  		goto again;
>  	}
> @@ -790,20 +815,17 @@ static void at91_poll_err_frame(struct net_device *dev,
>  	}
>  }
>  
> -static int at91_poll_err(struct net_device *dev, int quota, u32 reg_sr)
> +static int at91_poll_err(struct net_device *dev, u32 reg_sr)
>  {
>  	struct sk_buff *skb;
>  	struct can_frame *cf;
>  
> -	if (quota == 0)
> -		return 0;
> -
>  	skb = alloc_can_err_skb(dev, &cf);
>  	if (unlikely(!skb))
>  		return 0;
>  
>  	at91_poll_err_frame(dev, cf, reg_sr);
> -	netif_receive_skb(skb);
> +	at91_rx_fifo_in(dev, skb);
>  
>  	dev->stats.rx_packets++;
>  	dev->stats.rx_bytes += cf->can_dlc;
> @@ -811,15 +833,14 @@ static int at91_poll_err(struct net_device *dev, int quota, u32 reg_sr)
>  	return 1;
>  }
>  
> -static int at91_poll(struct napi_struct *napi, int quota)
> +static void at91_poll(struct net_device *dev)
>  {
> -	struct net_device *dev = napi->dev;
>  	const struct at91_priv *priv = netdev_priv(dev);
>  	u32 reg_sr = at91_read(priv, AT91_SR);
> -	int work_done = 0;
> +	u32 reg_ier;
>  
>  	if (reg_sr & get_irq_mb_rx(priv))
> -		work_done += at91_poll_rx(dev, quota - work_done);
> +		at91_poll_rx(dev);
>  
>  	/*
>  	 * The error bits are clear on read,
> @@ -827,17 +848,30 @@ static int at91_poll(struct napi_struct *napi, int quota)
>  	 */
>  	reg_sr |= priv->reg_sr;
>  	if (reg_sr & AT91_IRQ_ERR_FRAME)
> -		work_done += at91_poll_err(dev, quota - work_done, reg_sr);
> +		at91_poll_err(dev, reg_sr);
>  
> -	if (work_done < quota) {
> -		/* enable IRQs for frame errors and all mailboxes >= rx_next */
> -		u32 reg_ier = AT91_IRQ_ERR_FRAME;
> -		reg_ier |= get_irq_mb_rx(priv) & ~AT91_MB_MASK(priv->rx_next);
> +	/* enable IRQs for frame errors and all mailboxes >= rx_next */
> +	reg_ier = AT91_IRQ_ERR_FRAME;
> +	reg_ier |= get_irq_mb_rx(priv) & ~AT91_MB_MASK(priv->rx_next);
> +	at91_write(priv, AT91_IER, reg_ier);
> +}
>  
> -		napi_complete(napi);
> -		at91_write(priv, AT91_IER, reg_ier);
> +static int at91_napi_poll(struct napi_struct *napi, int quota)
> +{
> +	struct net_device *dev = napi->dev;
> +	const struct at91_priv *priv = netdev_priv(dev);
> +	int work_done = 0;
> +	struct sk_buff *skb = NULL;
> +
> +	while(!(kfifo_is_empty(&priv->rx_fifo)) && (work_done < quota)) {
> +		at91_rx_fifo_out(dev, &skb);
> +		netif_receive_skb(skb);
> +		work_done ++;
>  	}
>  
> +	if(work_done < quota)
> +		napi_complete(napi);
> +
>  	return work_done;
>  }
>  
> @@ -1096,7 +1130,7 @@ static irqreturn_t at91_irq(int irq, void *dev_id)
>  
>  	handled = IRQ_HANDLED;
>  
> -	/* Receive or error interrupt? -> napi */
> +	/* Receive or error interrupt? -> put in rx_fifo and call napi */
>  	if (reg_sr & (get_irq_mb_rx(priv) | AT91_IRQ_ERR_FRAME)) {
>  		/*
>  		 * The error bits are clear on read,
> @@ -1105,6 +1139,7 @@ static irqreturn_t at91_irq(int irq, void *dev_id)
>  		priv->reg_sr = reg_sr;
>  		at91_write(priv, AT91_IDR,
>  			   get_irq_mb_rx(priv) | AT91_IRQ_ERR_FRAME);
> +		at91_poll(dev);
>  		napi_schedule(&priv->napi);
>  	}
>  
> @@ -1356,7 +1391,14 @@ static int at91_can_probe(struct platform_device *pdev)
>  	priv->pdata = dev_get_platdata(&pdev->dev);
>  	priv->mb0_id = 0x7ff;
>  
> -	netif_napi_add(dev, &priv->napi, at91_poll, get_mb_rx_num(priv));
> +	err = kfifo_alloc(&priv->rx_fifo, RX_KFIFO_SIZE, GFP_KERNEL);
> +	if (err) {
> +		dev_err(&pdev->dev, "allocating RX fifo failed\n");
> +		goto exit_iounmap;
> +	}
> +
> +	netif_napi_add(dev, &priv->napi, at91_napi_poll,
> +			RX_KFIFO_SIZE > 64 ? 64 : RX_KFIFO_SIZE);
>  
>  	if (at91_is_sam9263(priv))
>  		dev->sysfs_groups[0] = &at91_sysfs_attr_group;
> 

-- 
Dipl.-Inf. Alexander Stein

SYS TEC electronic GmbH
Am Windrad 2
08468 Heinsdorfergrund
Tel.: 03765 38600-1156
Fax: 03765 38600-4100
Email: alexander.stein@systec-electronic.com
Website: www.systec-electronic.com
 
Managing Director: Dipl.-Phys. Siegmar Schmidt
Commercial registry: Amtsgericht Chemnitz, HRB 28082

