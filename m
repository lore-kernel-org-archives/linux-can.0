From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [RFC] CAN FD support part 1 - uncommented source
Date: Thu, 03 May 2012 13:34:00 +0200
Message-ID: <4FA26D28.80307@grandegger.com>
References: <4FA2689D.5030905@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:34524 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751694Ab2ECLeD (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 3 May 2012 07:34:03 -0400
In-Reply-To: <4FA2689D.5030905@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 05/03/2012 01:14 PM, Oliver Hartkopp wrote:
> 
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
> index f03d7a4..1b7e843 100644
> --- a/drivers/net/can/dev.c
> +++ b/drivers/net/can/dev.c
> @@ -454,7 +454,7 @@ EXPORT_SYMBOL_GPL(can_bus_off);
>  static void can_setup(struct net_device *dev)
>  {
>  	dev->type = ARPHRD_CAN;
> -	dev->mtu = sizeof(struct can_frame);
> +	dev->mtu = CAN_MTU;
>  	dev->hard_header_len = 0;
>  	dev->addr_len = 0;
>  	dev->tx_queue_len = 10;
> diff --git a/drivers/net/can/vcan.c b/drivers/net/can/vcan.c
> index ea2d942..bddbafb 100644
> --- a/drivers/net/can/vcan.c
> +++ b/drivers/net/can/vcan.c
> @@ -74,9 +74,8 @@ static void vcan_rx(struct sk_buff *skb, struct net_device *dev)
>  	struct net_device_stats *stats = &dev->stats;
>  
>  	stats->rx_packets++;
> -	stats->rx_bytes += cf->can_dlc;
> +	stats->rx_bytes += can_dlc2len(cf->can_dlc);

Hm, I think "cf->can_dlc" should contain the *real* length. That would
simplify things a lot. The conversion is done when the corresponding DLC
registers are read or written.

Wolfgang.
