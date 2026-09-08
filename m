Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DFA4EE84F;
	Tue,  8 Sep 2026 13:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788875004; cv=none; b=VIah7KKjqdg5rUU/odmxroyqB+4AjIrsPsrRwEd7upKrgjIcuwi/49qbW5gQUx54YF6S16+yRNBzbFR2PEj3RDJpIiZdrOJkNJSLv1joA2JEI5HPQvWdPlvK+Ual6TPW4+S4XdKKCnNolloeV+KabO/rliGjObhpnq6wbH2HJKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788875004; c=relaxed/simple;
	bh=HVoILK3aFrXiG88QXdlva1ZGm1SO8CtEAsvexl/ANZo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RQRQnmtUGuO1XnQsVZw84Wl57vyotzT3cPJzybiWsG1Afl/72uM5yTNfmcNhQ551f62Qijn5fir+E/X8h2F5IpgsflGvcduKLAvOkuqE20mW3qE9KjiXahGC6F1UAfpCrMRagaVftLj1PAj9gskS7FjPvY76J/TJrGkwSCw3ikE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bVy4Rbhy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVy4Rbhy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C441F00A3A;
	Tue,  8 Sep 2026 13:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788874992;
	bh=+wFIXwUSa8KmSrAi4FCyIaQBUh49w4tLhZkM/Z26SJY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bVy4RbhysJccUwQ/gufmopA+qJzW8/j3JqP82gL82aXpaOBiJQff6jRHh7+NS/EDM
	 pDqEU0Ylb1cIKhVOnxfNt0pGFDSVmbx1nM6MRVE4QPNpXXUkamJaqRKdwq4VYnDNuX
	 AWBB2P4+yFU/+vNEacCOfyGqtT8jinNC9NJz7XT+h0//XZmdu3W6Eo2bGr/h6wIhf7
	 k5PO9C/zSi7RwzzHS/0s+PdkuxM77xdCBcNf6H2knlGHGqpdNHn6lPgARUFU4LYFd0
	 nC1z3GuBYw1iE7J7qU9kDtriptdgA4bI2zOlragcTP2l6hSqDuFj9P/byfmPzlBwwH
	 mSFH723eFzW7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv3 1/3] net: fec: do not use readl()/writel() for
 ColdFire
Reply-To: sashiko-reviews@lists.linux.dev
To: "Greg Ungerer" <gerg@linux-m68k.org>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, Frank.Li@kernel.org, "Vincent
 Mailhol" <mailhol@kernel.org>, imx@lists.linux.dev, linux-can@vger.kernel.org, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Marc Kleine-Budde" <mkl@pengutronix.de>
In-Reply-To: <20260907134037.1855408-2-gerg@linux-m68k.org>
References: <20260907134037.1855408-1-gerg@linux-m68k.org>
 <20260907134037.1855408-2-gerg@linux-m68k.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 13:43:11 +0000
Message-Id: <20260908134312.00C441F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Heap buffer overflow in TX bounce buffer due to unvalidated pa=
cket and fragment lengths.
- [High] The hardware PPS interrupt handler accesses and modifies shared PT=
P state without acquiring the required lock, racing with configuration path=
s on other CPUs.
- [High] Unbounded hardware polling loops can cause a hard lockup if the ha=
rdware enters an error state.
- [High] Integer underflow in RX packet length calculation leads to out-of-=
bounds memory access.
- [High] Out-of-bounds read and write in `fec_enet_clear_csum` due to missi=
ng `pskb_may_pull`.
- [High] Missing dma_rmb() after reading descriptor status in RX paths.
--

commit b19b9a07ca8eff68179fb339b69d5c4690fdf442
Author: Greg Ungerer <gerg@linux-m68k.org>
net: fec: do not use readl()/writel() for ColdFire

This patch modifies the FEC driver to use local fec_readl() and fec_writel(=
)=20
methods instead of direct hardware register accesses. This avoids incorrect
byte swapping on big-endian architectures like ColdFire.

> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethe=
rnet/freescale/fec_main.c
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
[ ... ]
> @@ -1923,7 +1924,7 @@ static int fec_enet_rx_queue(struct fec_enet_privat=
e *fep,
>  			break;
>  		pkt_received++;
> =20
> -		writel(FEC_ENET_RXF_GET(queue), fep->hwp + FEC_IEVENT);
> +		fec_writel(FEC_ENET_RXF_GET(queue), fep->hwp + FEC_IEVENT);

[Severity: High]
This is a pre-existing issue, but is a memory barrier missing in the RX
loop?

The loop checks the status to confirm ownership in the while condition, but
without a dma_rmb() immediately after, couldn't speculative execution on
architectures with weak memory ordering cause the subsequent read of
cbd_datlen to happen before the DMA transfer is completely visible?

> =20
>  		/* Check for errors. */
>  		status ^=3D BD_ENET_RX_LAST;

[ ... ]

> diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ether=
net/freescale/fec_ptp.c
> --- a/drivers/net/ethernet/freescale/fec_ptp.c
> +++ b/drivers/net/ethernet/freescale/fec_ptp.c
[ ... ]
> @@ -142,17 +142,17 @@ static int fec_ptp_enable_pps(struct fec_enet_priva=
te *fep, uint enable)
>  	if (enable) {
>  		/* clear capture or output compare interrupt status if have.
>  		 */
> -		writel(FEC_T_TF_MASK, fep->hwp + FEC_TCSR(fep->pps_channel));
> +		fec_writel(FEC_T_TF_MASK, fep->hwp + FEC_TCSR(fep->pps_channel));
> =20
>  		/* It is recommended to double check the TMODE field in the
>  		 * TCSR register to be cleared before the first compare counter
>  		 * is written into TCCR register. Just add a double check.
>  		 */
> -		val =3D readl(fep->hwp + FEC_TCSR(fep->pps_channel));
> +		val =3D fec_readl(fep->hwp + FEC_TCSR(fep->pps_channel));
>  		do {
>  			val &=3D ~(FEC_T_TMODE_MASK);
> -			writel(val, fep->hwp + FEC_TCSR(fep->pps_channel));
> -			val =3D readl(fep->hwp + FEC_TCSR(fep->pps_channel));
> +			fec_writel(val, fep->hwp + FEC_TCSR(fep->pps_channel));
> +			val =3D fec_readl(fep->hwp + FEC_TCSR(fep->pps_channel));
>  		} while (val & FEC_T_TMODE_MASK);

[Severity: High]
This is a pre-existing issue, but is it safe to have an unbounded polling
loop here while IRQs are disabled?

If the hardware transitions into a faulty state and perpetually returns a
value with FEC_T_TMODE_MASK set, could this loop cause a hard lockup or
kernel panic?

> =20
>  		/* Dummy read counter to update the counter */
[ ... ]
> @@ -194,31 +194,31 @@ static int fec_ptp_enable_pps(struct fec_enet_priva=
te *fep, uint enable)
>  		 * is bigger than fep->cc.mask would be a error.
>  		 */
>  		val &=3D fep->cc.mask;
> -		writel(val, fep->hwp + FEC_TCCR(fep->pps_channel));
> +		fec_writel(val, fep->hwp + FEC_TCCR(fep->pps_channel));
> =20
>  		/* Calculate the second the compare event timestamp */
>  		fep->next_counter =3D (val + fep->reload_period) & fep->cc.mask;

[Severity: High]
This is a pre-existing issue, but I noticed a potential data race between
this configuration path and the interrupt handler.

Here, fep->next_counter is updated while holding fep->tmreg_lock. However,
the interrupt handler fec_pps_interrupt() modifies fep->next_counter
locklessly. Could this cause the PTP timer to miss events or corrupt the
hardware state if this is triggered concurrently from userspace?

> =20
>  		/* * Enable compare event when overflow */
> -		val =3D readl(fep->hwp + FEC_ATIME_CTRL);
[ ... ]
> @@ -701,15 +701,15 @@ static irqreturn_t fec_pps_interrupt(int irq, void =
*dev_id)
>  	u8 channel =3D fep->pps_channel;
>  	struct ptp_clock_event event;
> =20
> -	val =3D readl(fep->hwp + FEC_TCSR(channel));
> +	val =3D fec_readl(fep->hwp + FEC_TCSR(channel));
>  	if (val & FEC_T_TF_MASK) {
>  		/* Write the next next compare(not the next according the spec)
>  		 * value to the register
>  		 */
> -		writel(fep->next_counter, fep->hwp + FEC_TCCR(channel));
> +		fec_writel(fep->next_counter, fep->hwp + FEC_TCCR(channel));
>  		do {
> -			writel(val, fep->hwp + FEC_TCSR(channel));
> -		} while (readl(fep->hwp + FEC_TCSR(channel)) & FEC_T_TF_MASK);
> +			fec_writel(val, fep->hwp + FEC_TCSR(channel));
> +		} while (fec_readl(fep->hwp + FEC_TCSR(channel)) & FEC_T_TF_MASK);

[Severity: High]
This is a pre-existing issue, but similar to the loop in
fec_ptp_enable_pps(), does this unbounded loop risk a hard lockup?

Since this runs in hardirq context, a faulty hardware state that fails to
clear FEC_T_TF_MASK would keep the CPU spinning indefinitely.

[ ... ]

I also noticed a few other pre-existing issues in this driver that fall
outside the immediate diff context of this patch:

[Severity: Critical]
This is a pre-existing issue, but does fec_enet_txq_submit_frag_skb()
overflow the TX bounce buffer?

index =3D fec_enet_get_bd_index(bdp, &txq->bd);
if (((unsigned long) bufaddr) & fep->tx_align ||
    fep->quirks & FEC_QUIRK_SWAP_FRAME) {
    memcpy(txq->tx_bounce[index], bufaddr, frag_len);
    bufaddr =3D txq->tx_bounce[index];

Since fragments can be up to PAGE_SIZE (4KB or 64KB), but the tx_bounce
buffers are statically sized to 2048 bytes, couldn't a large unaligned
packet or jumbo frame cause an out-of-bounds heap write?

[Severity: High]
This is a pre-existing issue, but I have a question about the packet length
calculation in fec_enet_rx_queue_xdp() and fec_enet_rx_queue():

pkt_len =3D fec16_to_cpu(bdp->cbd_datlen);
...
pkt_len -=3D sub_len;
xdp_prepare_buff(&xdp, page_address(page), data_start, pkt_len, false);

If a corrupted or maliciously crafted DMA descriptor reports a pkt_len less
than sub_len, pkt_len will underflow. Won't this pass a very large length
to xdp_prepare_buff() (or skb_put() in fec_build_skb()), potentially
allowing a BPF program to read/write out of bounds or causing an
skb_over_panic()?

[Severity: High]
This is a pre-existing issue, but I noticed a potential out-of-bounds
access on non-linear SKBs in fec_enet_clear_csum():

static bool is_ipv4_pkt(struct sk_buff *skb)
{
    return skb->protocol =3D=3D htons(ETH_P_IP) && ip_hdr(skb)->version =3D=
=3D 4;
}

If an AF_PACKET socket transmits a packet where the IP header is in a
non-linear fragment, wouldn't ip_hdr(skb)->version and the subsequent
ip_hdr(skb)->check =3D 0 assignment read and write past the linear buffer
into unallocated memory, since pskb_may_pull() hasn't been called?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907134037.1855=
408-2-gerg@linux-m68k.org?part=3D1
