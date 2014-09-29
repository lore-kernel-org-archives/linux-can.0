From: David Jander <david@protonic.nl>
Subject: Re: [PATCH v4] can: flexcan: Re-write receive path to use MB queue
 instead of FIFO
Date: Mon, 29 Sep 2014 15:24:19 +0200
Message-ID: <20140929152419.46c3b185@archvile>
References: <1411048090-16837-1-git-send-email-david@protonic.nl>
	<54216E5F.2010804@pengutronix.de>
	<20140923155319.691b2241@archvile>
	<54253373.7000201@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:4557 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752243AbaI2NYR (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 29 Sep 2014 09:24:17 -0400
In-Reply-To: <54253373.7000201@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org


Dear Marc,

On Fri, 26 Sep 2014 11:35:47 +0200
Marc Kleine-Budde <mkl@pengutronix.de> wrote:

> On 09/23/2014 03:53 PM, David Jander wrote:
> 
> >> On 09/18/2014 03:48 PM, David Jander wrote:
> >>> The FlexCAN controller has a RX FIFO that is only 6 messages deep, and a
> >>> mailbox space capable of holding up to 63 messages.
> >>> This space was largely unused, limiting the permissible latency from
> >>> interrupt to NAPI to only 6 messages. This patch uses all available MBs
> >>> for message reception and frees the MBs in the IRQ handler to greatly
> >>> decrease the likelihood of receive overruns.
> >>>
> >>> Signed-off-by: David Jander <david@protonic.nl>
> >>
> >> I think we can improve the algorithm a bit.
> >>
> >> I see a problem when you receive 4 CAN frames:
> >>
> >> 0-1-2-3
> >>
> >> then the irq handler starts, 0 gets processed and is empty (E)
> >>
> >> E-1-2-3
> > 
> > No. It will not be empty. It will be marked inactive immediately in
> > flexcan_copy_one_rxmb().
> > 
> >> while in the interrupt handler another two frames come in:
> >>
> >> 4-1-2-3-5
> > 
> > That can't happen ;-)
> > 
> >> I suggest add a variable to the priv which indicates the next MB to read
> >> from. Further, don't clear the mailbox direclty after it's been read,
> >> wait until a certain amount of read mailboxes accumulate, .e.g. when the
> >> rx_next point to 32. I have a work-in-progress code which to abstract
> > 
> > More or less exactly what I do. Please read the comment to
> > flexcan_copy_rxmbs()
> 
> Yes you're right, I missed the:
> 
> > 	if (i >= 32) {
> > 		/* Re-enable all disabled MBs */
> 
> in the code.
> 
> [...]
> 
> >>> @@ -741,10 +743,16 @@ static int flexcan_read_frame(struct net_device
> >>> *dev) static int flexcan_poll(struct napi_struct *napi, int quota)
> >>>  {
> >>>  	struct net_device *dev = napi->dev;
> >>> -	const struct flexcan_priv *priv = netdev_priv(dev);
> >>> +	struct flexcan_priv *priv = netdev_priv(dev);
> >>>  	struct flexcan_regs __iomem *regs = priv->base;
> >>> -	u32 reg_iflag1, reg_esr;
> >>> +	u32 reg_esr;
> >>>  	int work_done = 0;
> >>> +	int n;
> >>> +	int ret;
> >>> +
> >>> +	/* disable RX IRQs */
> >>> +	flexcan_write((1 << FLEXCAN_TX_BUF_ID), &regs->imask1);
> >>> +	flexcan_write(0, &regs->imask2);
> >>
> >> Please use defines here. BTW: the RX IRQ has to disabled in the IRQ
> >> handler.
> > 
> > Ok, will use #defines.... but why should I disable interrupts in the IRQ
> > handler? I am copying all mailboxes in the IRQ, so no need to disable
> > interrupts there...
> > What I do here is avoid the IRQ from messing with my copy while pushing it
> > up NAPI.
> 
> As you don't access the hardware in the NAPI handler, why do you disable
> the interrupts? AFAIK there is no guarantee that the interrupt handler
> is not running on a different CPU when you enter the NAPI handler. You
> have to lock the shared resource rx_idx.
> 
> I suggest to turn cantxfg_copy[] into a cyclic buffer, with a head and a
> tail pointer. This way you can access them lockless.

Good idea. I just did this. Please see V5 of the patch that just hit the list.
I just noticed that I left over an unnecessary piece from a previous version:
A write barrier on reg_ctrl in flexcan_copy_one_rxmb() and corresponding read
barrier in flexcan_poll() :-(
It should not be necessary anymore, since the ring-buffer's head/tail barriers
should take care of synchronization. So please ignore the smp_wmb()/smp_rmb()
pair... it does no harm, but I will remove it in the next version *sigh*.

> > 
> >>>  
> >>>  	/*
> >>>  	 * The error bits are cleared on read,
> >>> @@ -755,12 +763,13 @@ static int flexcan_poll(struct napi_struct *napi,
> >>> int quota) /* handle state changes */
> >>>  	work_done += flexcan_poll_state(dev, reg_esr);
> >>>  
> >>> -	/* handle RX-FIFO */
> >>> -	reg_iflag1 = flexcan_read(&regs->iflag1);
> >>> -	while (reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_AVAILABLE &&
> >>> -	       work_done < quota) {
> >>> -		work_done += flexcan_read_frame(dev);
> >>> -		reg_iflag1 = flexcan_read(&regs->iflag1);
> >>> +	/* handle mailboxes */
> >>> +	for (n = 0; (n < ARRAY_SIZE(priv->cantxfg_copy)) &&
> >>> +			(work_done < quota); n++) {
> >>> +		ret = flexcan_read_frame(dev, n);
> >>> +		if (!ret)
> >>> +			break;
> >>> +		work_done += ret;
> >>>  	}
>[...]

Best regards,

-- 
David Jander
Protonic Holland.
