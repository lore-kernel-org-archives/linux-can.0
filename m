From: Thor Thayer <tthayer@opensource.altera.com>
Subject: Re: AW: AW: c_can driver sometimes sends first two bytes filled with
 zeros
Date: Thu, 19 May 2016 18:00:42 -0500
Message-ID: <573E459A.1000300@opensource.altera.com>
References: <0120733A154AE74CA608A286CE7FFD2621D9A343@rg-contact.RG.local>
 <573A0E08.4010008@opensource.altera.com>
 <0120733A154AE74CA608A286CE7FFD2621D9C80F@rg-contact.RG.local>
 <573C8BAA.5040200@opensource.altera.com>
 <0120733A154AE74CA608A286CE7FFD2621D9CB60@rg-contact.RG.local>
Reply-To: <tthayer@opensource.altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bn1on0083.outbound.protection.outlook.com ([157.56.110.83]:47552
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754103AbcESW5T (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 19 May 2016 18:57:19 -0400
In-Reply-To: <0120733A154AE74CA608A286CE7FFD2621D9CB60@rg-contact.RG.local>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Richard Andrysek <richard.andrysek@gomtec.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: wg@grandegger.com, mkl@pengutronix.de

Hi Richard,

On 05/19/2016 09:07 AM, Richard Andrysek wrote:
> Hi Thor,
>
> I am sending my test program and a makefile. The application accept up to 2 arguments:
> ## send 8 messages in 2ms cycle
> # test  8 2000
>
> ## default 16 messages in 2.6ms (the zip file data)
> # test
>
> In the zip file you can see my logging files (channel 1 and channel 2), on the channel 2 you can find failures
> in the "Failure_dump.txt".
>
Yes, I can see the zero bytes in your data.

Am I correct that both can0 and can1 are receiving the same data? If I'm 
understanding, can0 seems to be fine but can1 periodically shows 
corruption with the first 2 bytes set to 0?

Since the attached program uses a write, I'm confused about who is 
sending the data? Is that the PCAN USB you referred to in an earlier email?

Also, where is the 2.6ms that you refer to and is in the code? From the 
data, it seems like the spacing between frames is ~.120ms and ~1msec 
between 16 frame bursts.

> Initialization of can channels is done from the shell:
>
> # ip link set can0 up type can bitrate 1000000
> # ip link set can1 up type can bitrate 1000000
>
> The cpu load is max 5%.
>
> Question1:
> I've checked a driver it looks good. Except one line in the function :
>
> static netdev_tx_t c_can_start_xmit(struct sk_buff *skb,
> 				    struct net_device *dev)
> {
> 	struct can_frame *frame = (struct can_frame *)skb->data;
> 	struct c_can_priv *priv = netdev_priv(dev);
> 	u32 idx, obj;
>
> 	if (can_dropped_invalid_skb(dev, skb))
> 		return NETDEV_TX_OK;
> 	/*
> 	 * This is not a FIFO. C/D_CAN sends out the buffers
> 	 * prioritized. The lowest buffer number wins.
> 	 */
> 	idx = fls(atomic_read(&priv->tx_active));  /*!!!!! Why so !!!! */
> 	...
> 	...
> 	/* Update the active bits */
> 	atomic_add((1 << idx), &priv->tx_active);
>
> Are these atomic operations correct? atomic_add I understand, but shall not be atomic_read used like this:
>
>               Atomic block start
>               idx = fls(read(&priv->tx->active))
>               remove_idx_from(&priv->tx->active, idx)
>               Atomic block stop	
>
I'm not sure about this. I'm including the maintainers in the CC.

> Question2: What can make corrupted CAN messages on the channel 2?
>
Hmm. I've only worked with the first CAN so I can't speak for the 2nd 
can device.

> Ch.
>
> Richard
>
>
