From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [PATCH RFC] can: add Virtual CAN Tunnel driver (vxcan)
Date: Tue, 25 Apr 2017 07:35:47 +0200
Message-ID: <1817567.PFpAbEA6ZR@ws-stein>
References: <20170424201238.3587-1-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:35590 "EHLO
        webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S980244AbdDYFfy (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 25 Apr 2017 01:35:54 -0400
In-Reply-To: <20170424201238.3587-1-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

On Monday 24 April 2017 22:12:37, Oliver Hartkopp wrote:
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> --- /dev/null
> +++ b/drivers/net/can/vxcan.c
> @@ -0,0 +1,313 @@
> [...]
> +static netdev_tx_t vxcan_xmit(struct sk_buff *skb, struct net_device *dev)
> +{
> +	struct vxcan_priv *priv = netdev_priv(dev);
> +	struct net_device *peer;
> +	struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
> +	struct net_device_stats *stats = &dev->stats;
> +
> +	if (can_dropped_invalid_skb(dev, skb))
> +		return NETDEV_TX_OK;
> +
> +	rcu_read_lock();
> +	peer = rcu_dereference(priv->peer);
> +	if (unlikely(!peer)) {
> +		kfree_skb(skb);
> +		dev->stats.tx_dropped++;
> +		goto out_unlock;
> +	}
> +
> +	skb = can_create_echo_skb(skb);
> +	if (!skb)
> +		return NETDEV_TX_OK;
> +
> +	stats->tx_packets++;
> +	stats->tx_bytes += cfd->len;
> +
> +	/* reset CAN GW hop counter */
> +	skb->csum_start = 0;
> +
> +	stats = &peer->stats;
> +
> +	stats->rx_packets++;
> +	stats->rx_bytes += cfd->len;
> +
> +	skb->pkt_type  = PACKET_BROADCAST;
> +	skb->dev       = peer;
> +	skb->ip_summed = CHECKSUM_UNNECESSARY;
> +
> +	netif_rx_ni(skb);
     ^^^^^^^^^^
Wouldn't this result in the known out-of-order problem on SMP systems?

Best regards,
Alexander

