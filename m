From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: Losing CAN messages with socket-CAN
Date: Wed, 24 Apr 2013 12:59:41 +0200
Message-ID: <5177BB1D.7070405@grandegger.com>
References: <20130424091101.3CC0EEB62F6D@bmail02.one.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:46470 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932244Ab3DXK7o (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 24 Apr 2013 06:59:44 -0400
In-Reply-To: <20130424091101.3CC0EEB62F6D@bmail02.one.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "j.p.lammertink" <j.p.lammertink@kubicas.com>
Cc: linux-can@vger.kernel.org

Hi Jeroen,

On 04/24/2013 11:11 AM, j.p.lammertink wrote:
> Hi Wolfgang,
> 
> I think I have a patch for the "Loosing CAN messages problem"
> See at the bottom Appendix 7 Sugested patch.
> I realize that this patch has a performance penalty, but I didn't dare
> to make more rigorous changes.
> I've put the patch on top of Patch 1, of the patches that you sugested (see
> text below)
> 
> I'm interested in all feedback.

Well, we want to get rid of the pch_can driver sooner than later.
Therefore I would appreciate if you could test and improve the c_can
driver instead.

Wolfgang.

...
> --------------------------------------------------------------------------
> Appendix 7 Suggested patch
> 
> diff --git a/drivers/net/can/pch_can.c b/drivers/net/can/pch_can.c
> index 44b9a7a..81d599f 100644
> --- a/drivers/net/can/pch_can.c
> +++ b/drivers/net/can/pch_can.c
> @@ -912,7 +912,6 @@ static netdev_tx_t pch_xmit(struct sk_buff *skb, struct net_device *ndev)
>  
>  	tx_obj_no = priv->tx_obj;
>  	if (priv->tx_obj == PCH_TX_OBJ_END) {
> -		if (ioread32(&priv->regs->treq2) & PCH_TREQ2_TX_MASK)

This means that there are pending TX messages. If there are none, there
is no need to stop the queue. I'm puzzled!

>  			netif_stop_queue(ndev);
>  
>  		priv->tx_obj = PCH_TX_OBJ_START;
> 

Hm, is this code protected by spin_lock_irqsave/spin_unlock_irqrestore?

Wolfgang.
