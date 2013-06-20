From: Michael Pellegrini <mikep86@gmail.com>
Subject: Re: [RFC v3 1/7] =?utf-8?b?cGNoX2Nhbjo=?= add spinlocks to protect tx objects
Date: Thu, 20 Jun 2013 14:29:00 +0000 (UTC)
Message-ID: <loom.20130620T162701-674@post.gmane.org>
References: <1355260735-18994-1-git-send-email-wg@grandegger.com> <1355260735-18994-2-git-send-email-wg@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:50343 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756403Ab3FTO3T (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 20 Jun 2013 10:29:19 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1UpfrQ-0003qU-Ld
	for linux-can@vger.kernel.org; Thu, 20 Jun 2013 16:29:16 +0200
Received: from 96.45.208.254 ([96.45.208.254])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 20 Jun 2013 16:29:16 +0200
Received: from mikep86 by 96.45.208.254 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 20 Jun 2013 16:29:16 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Wolfgang Grandegger <wg <at> grandegger.com> writes:

> 
> Signed-off-by: Wolfgang Grandegger <wg <at> grandegger.com>
> ---
>  drivers/net/can/pch_can.c |   11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/net/can/pch_can.c b/drivers/net/can/pch_can.c
> index 7d17485..af61961 100644
> --- a/drivers/net/can/pch_can.c
> +++ b/drivers/net/can/pch_can.c
>  <at>  <at>  -182,6 +182,7  <at>  <at>  struct pch_can_priv {
>  	struct napi_struct napi;
>  	int tx_obj;	/* Point next Tx Obj index */
>  	int use_msi;
> +	spinlock_t lock;	/* to protect tx objects */
>  };
> 
>  static const struct can_bittiming_const pch_can_bittiming_const = {
>  <at>  <at>  -722,8 +723,11  <at>  <at>  static void 
pch_can_tx_complete(struct net_device *ndev, u32 int_stat)
>  {
>  	struct pch_can_priv *priv = netdev_priv(ndev);
>  	struct net_device_stats *stats = &(priv->ndev->stats);
> +	unsigned long flags;
>  	u32 dlc;
> 
> +	spin_lock_irqsave(&priv->lock, flags);
> +
>  	can_get_echo_skb(ndev, int_stat - PCH_RX_OBJ_END - 1);
>  	iowrite32(PCH_CMASK_RX_TX_GET | PCH_CMASK_CLRINTPND,
>  		  &priv->regs->ifregs[1].cmask);
>  <at>  <at>  -734,6 +738,8  <at>  <at>  static void 
pch_can_tx_complete(struct net_device *ndev, u32 int_stat)
>  	stats->tx_packets++;
>  	if (int_stat == PCH_TX_OBJ_END)
>  		netif_wake_queue(ndev);
> +
> +	spin_unlock_irqrestore(&priv->lock, flags);
>  }
> 
>  static int pch_can_poll(struct napi_struct *napi, int quota)
>  <at>  <at>  -894,6 +900,7  <at>  <at>  static netdev_tx_t pch_xmit(struct 
sk_buff *skb, struct net_device *ndev)
>  {
>  	struct pch_can_priv *priv = netdev_priv(ndev);
>  	struct can_frame *cf = (struct can_frame *)skb->data;
> +	unsigned long flags;
>  	int tx_obj_no;
>  	int i;
>  	u32 id2;
>  <at>  <at>  -901,6 +908,8  <at>  <at>  static netdev_tx_t pch_xmit(struct 
sk_buff *skb, struct net_device *ndev)
>  	if (can_dropped_invalid_skb(ndev, skb))
>  		return NETDEV_TX_OK;
> 
> +	spin_lock_irqsave(&priv->lock, flags);
> +
>  	tx_obj_no = priv->tx_obj;
>  	if (priv->tx_obj == PCH_TX_OBJ_END) {
>  		if (ioread32(&priv->regs->treq2) & PCH_TREQ2_TX_MASK)
>  <at>  <at>  -911,6 +920,8  <at>  <at>  static netdev_tx_t pch_xmit(struct 
sk_buff *skb, struct net_device *ndev)
>  		priv->tx_obj++;
>  	}
> 
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +
>  	/* Setting the CMASK register. */
>  	pch_can_bit_set(&priv->regs->ifregs[1].cmask, PCH_CMASK_ALL);
> 

I believe I have found a bug in this changelist.  When applying these 
changes to the standard pch_can driver which ships with Ubuntu 12.04 (kernel 
version 3.2.0-24.39), the race condition is still present and data 
transmission ceases after a short period of time.

I applied the following modification and the data transmission problem went 
away:

diff -c c-can-pci-v7/pch_can.c c-can-pci-v7-mrp/pch_can.c
*** c-can-pci-v7/pch_can.c	2012-11-25 05:09:13.000000000 -0500
--- c-can-pci-v7-mrp/pch_can.c	2012-11-26 11:29:11.350012074 -0500
***************
*** 921,928 ****
  		priv->tx_obj++;
  	}
  
- 	spin_unlock_irqrestore(&priv->lock, flags);
- 
  	/* Setting the CMASK register. */
  	pch_can_bit_set(&priv->regs->ifregs[1].cmask, PCH_CMASK_ALL);
  
--- 921,926 ----
***************
*** 957,962 ****
--- 955,962 ----
  
  	pch_can_rw_msg_obj(&priv->regs->ifregs[1].creq, tx_obj_no);
  
+ 	spin_unlock_irqrestore(&priv->lock, flags);
+ 
  	return NETDEV_TX_OK;
  }

This modification was suggested by Wolfgang during testing many months back 
(I found it in my archive of test code); I think it got lost during the 
shuffle between versions.

- Mike


