Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6454825C1;
	Fri, 11 Sep 2026 13:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789132175; cv=none; b=lCza7Yj6Xaf/rm8l59ZfA2NZmN2oH3JFAF6tuBfLWpS9vhIWJnTe3ncsfb4O3VyQP3itVN1BlklooOkWqYBX5LnGkpO1OltltEd+O4Qi/ZCe7oCoyzbCCtqsnRLLQDQ+zuyv8c1zWeaXpHAv+HIxTUC6G/yXUl/uRf/JrV93AHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789132175; c=relaxed/simple;
	bh=05VaFWmH1fvVu9ssYCkMXTeWwF9HLZII2itZOKyMR6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B8Od9fwXq0C9J9P1PPRcgF7Z7ENTuaKQgnJH1uPDF3iH0jn8WG7FldniuzZ6+ysweXZfK4z1BhU6x0IKrtqHH2/AxkKuKLgesxdVObqKk6yJeEwhvctP3tvypzLooNCpwOQendkFkAqrZcSdVse4Td7c2c1BjP3QEWjR3XCy99k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E33D01F000FF;
	Fri, 11 Sep 2026 13:09:31 +0000 (UTC)
Message-ID: <194f8bf1-2412-4d77-975d-c32fbdeb4874@linux-m68k.org>
Date: Fri, 11 Sep 2026 23:09:29 +1000
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 1/3] net: fec: do not use readl()/writel() for ColdFire
To: sashiko-reviews@lists.linux.dev
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Frank.Li@kernel.org,
 Vincent Mailhol <mailhol@kernel.org>, imx@lists.linux.dev,
 linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>,
 Marc Kleine-Budde <mkl@pengutronix.de>
References: <20260907134037.1855408-1-gerg@linux-m68k.org>
 <20260907134037.1855408-2-gerg@linux-m68k.org>
 <20260908134312.00C441F00A3A@smtp.kernel.org>
Content-Language: en-US
From: Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <20260908134312.00C441F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 8/9/26 23:43, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 6 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [Critical] Heap buffer overflow in TX bounce buffer due to unvalidated packet and fragment lengths.
> - [High] The hardware PPS interrupt handler accesses and modifies shared PTP state without acquiring the required lock, racing with configuration paths on other CPUs.
> - [High] Unbounded hardware polling loops can cause a hard lockup if the hardware enters an error state.
> - [High] Integer underflow in RX packet length calculation leads to out-of-bounds memory access.
> - [High] Out-of-bounds read and write in `fec_enet_clear_csum` due to missing `pskb_may_pull`.
> - [High] Missing dma_rmb() after reading descriptor status in RX paths.

Given these are pre-existing issues and not in any way related to what
this patch is doing I am not going to make any changes to it based on this.

Certainly a heads up for the drievr maintainers that there is some issues
worth looking into though.

Regards
Greg



> 
> commit b19b9a07ca8eff68179fb339b69d5c4690fdf442
> Author: Greg Ungerer <gerg@linux-m68k.org>
> net: fec: do not use readl()/writel() for ColdFire
> 
> This patch modifies the FEC driver to use local fec_readl() and fec_writel() 
> methods instead of direct hardware register accesses. This avoids incorrect
> byte swapping on big-endian architectures like ColdFire.
> 
>> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
>> --- a/drivers/net/ethernet/freescale/fec_main.c
>> +++ b/drivers/net/ethernet/freescale/fec_main.c
> [ ... ]
>> @@ -1923,7 +1924,7 @@ static int fec_enet_rx_queue(struct fec_enet_private *fep,
>>  			break;
>>  		pkt_received++;
>>  
>> -		writel(FEC_ENET_RXF_GET(queue), fep->hwp + FEC_IEVENT);
>> +		fec_writel(FEC_ENET_RXF_GET(queue), fep->hwp + FEC_IEVENT);
> 
> [Severity: High]
> This is a pre-existing issue, but is a memory barrier missing in the RX
> loop?
> 
> The loop checks the status to confirm ownership in the while condition, but
> without a dma_rmb() immediately after, couldn't speculative execution on
> architectures with weak memory ordering cause the subsequent read of
> cbd_datlen to happen before the DMA transfer is completely visible?
> 
>>  
>>  		/* Check for errors. */
>>  		status ^= BD_ENET_RX_LAST;
> 
> [ ... ]
> 
>> diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
>> --- a/drivers/net/ethernet/freescale/fec_ptp.c
>> +++ b/drivers/net/ethernet/freescale/fec_ptp.c
> [ ... ]
>> @@ -142,17 +142,17 @@ static int fec_ptp_enable_pps(struct fec_enet_private *fep, uint enable)
>>  	if (enable) {
>>  		/* clear capture or output compare interrupt status if have.
>>  		 */
>> -		writel(FEC_T_TF_MASK, fep->hwp + FEC_TCSR(fep->pps_channel));
>> +		fec_writel(FEC_T_TF_MASK, fep->hwp + FEC_TCSR(fep->pps_channel));
>>  
>>  		/* It is recommended to double check the TMODE field in the
>>  		 * TCSR register to be cleared before the first compare counter
>>  		 * is written into TCCR register. Just add a double check.
>>  		 */
>> -		val = readl(fep->hwp + FEC_TCSR(fep->pps_channel));
>> +		val = fec_readl(fep->hwp + FEC_TCSR(fep->pps_channel));
>>  		do {
>>  			val &= ~(FEC_T_TMODE_MASK);
>> -			writel(val, fep->hwp + FEC_TCSR(fep->pps_channel));
>> -			val = readl(fep->hwp + FEC_TCSR(fep->pps_channel));
>> +			fec_writel(val, fep->hwp + FEC_TCSR(fep->pps_channel));
>> +			val = fec_readl(fep->hwp + FEC_TCSR(fep->pps_channel));
>>  		} while (val & FEC_T_TMODE_MASK);
> 
> [Severity: High]
> This is a pre-existing issue, but is it safe to have an unbounded polling
> loop here while IRQs are disabled?
> 
> If the hardware transitions into a faulty state and perpetually returns a
> value with FEC_T_TMODE_MASK set, could this loop cause a hard lockup or
> kernel panic?
> 
>>  
>>  		/* Dummy read counter to update the counter */
> [ ... ]
>> @@ -194,31 +194,31 @@ static int fec_ptp_enable_pps(struct fec_enet_private *fep, uint enable)
>>  		 * is bigger than fep->cc.mask would be a error.
>>  		 */
>>  		val &= fep->cc.mask;
>> -		writel(val, fep->hwp + FEC_TCCR(fep->pps_channel));
>> +		fec_writel(val, fep->hwp + FEC_TCCR(fep->pps_channel));
>>  
>>  		/* Calculate the second the compare event timestamp */
>>  		fep->next_counter = (val + fep->reload_period) & fep->cc.mask;
> 
> [Severity: High]
> This is a pre-existing issue, but I noticed a potential data race between
> this configuration path and the interrupt handler.
> 
> Here, fep->next_counter is updated while holding fep->tmreg_lock. However,
> the interrupt handler fec_pps_interrupt() modifies fep->next_counter
> locklessly. Could this cause the PTP timer to miss events or corrupt the
> hardware state if this is triggered concurrently from userspace?
> 
>>  
>>  		/* * Enable compare event when overflow */
>> -		val = readl(fep->hwp + FEC_ATIME_CTRL);
> [ ... ]
>> @@ -701,15 +701,15 @@ static irqreturn_t fec_pps_interrupt(int irq, void *dev_id)
>>  	u8 channel = fep->pps_channel;
>>  	struct ptp_clock_event event;
>>  
>> -	val = readl(fep->hwp + FEC_TCSR(channel));
>> +	val = fec_readl(fep->hwp + FEC_TCSR(channel));
>>  	if (val & FEC_T_TF_MASK) {
>>  		/* Write the next next compare(not the next according the spec)
>>  		 * value to the register
>>  		 */
>> -		writel(fep->next_counter, fep->hwp + FEC_TCCR(channel));
>> +		fec_writel(fep->next_counter, fep->hwp + FEC_TCCR(channel));
>>  		do {
>> -			writel(val, fep->hwp + FEC_TCSR(channel));
>> -		} while (readl(fep->hwp + FEC_TCSR(channel)) & FEC_T_TF_MASK);
>> +			fec_writel(val, fep->hwp + FEC_TCSR(channel));
>> +		} while (fec_readl(fep->hwp + FEC_TCSR(channel)) & FEC_T_TF_MASK);
> 
> [Severity: High]
> This is a pre-existing issue, but similar to the loop in
> fec_ptp_enable_pps(), does this unbounded loop risk a hard lockup?
> 
> Since this runs in hardirq context, a faulty hardware state that fails to
> clear FEC_T_TF_MASK would keep the CPU spinning indefinitely.
> 
> [ ... ]
> 
> I also noticed a few other pre-existing issues in this driver that fall
> outside the immediate diff context of this patch:
> 
> [Severity: Critical]
> This is a pre-existing issue, but does fec_enet_txq_submit_frag_skb()
> overflow the TX bounce buffer?
> 
> index = fec_enet_get_bd_index(bdp, &txq->bd);
> if (((unsigned long) bufaddr) & fep->tx_align ||
>     fep->quirks & FEC_QUIRK_SWAP_FRAME) {
>     memcpy(txq->tx_bounce[index], bufaddr, frag_len);
>     bufaddr = txq->tx_bounce[index];
> 
> Since fragments can be up to PAGE_SIZE (4KB or 64KB), but the tx_bounce
> buffers are statically sized to 2048 bytes, couldn't a large unaligned
> packet or jumbo frame cause an out-of-bounds heap write?
> 
> [Severity: High]
> This is a pre-existing issue, but I have a question about the packet length
> calculation in fec_enet_rx_queue_xdp() and fec_enet_rx_queue():
> 
> pkt_len = fec16_to_cpu(bdp->cbd_datlen);
> ...
> pkt_len -= sub_len;
> xdp_prepare_buff(&xdp, page_address(page), data_start, pkt_len, false);
> 
> If a corrupted or maliciously crafted DMA descriptor reports a pkt_len less
> than sub_len, pkt_len will underflow. Won't this pass a very large length
> to xdp_prepare_buff() (or skb_put() in fec_build_skb()), potentially
> allowing a BPF program to read/write out of bounds or causing an
> skb_over_panic()?
> 
> [Severity: High]
> This is a pre-existing issue, but I noticed a potential out-of-bounds
> access on non-linear SKBs in fec_enet_clear_csum():
> 
> static bool is_ipv4_pkt(struct sk_buff *skb)
> {
>     return skb->protocol == htons(ETH_P_IP) && ip_hdr(skb)->version == 4;
> }
> 
> If an AF_PACKET socket transmits a packet where the IP header is in a
> non-linear fragment, wouldn't ip_hdr(skb)->version and the subsequent
> ip_hdr(skb)->check = 0 assignment read and write past the linear buffer
> into unallocated memory, since pskb_may_pull() hasn't been called?
> 

