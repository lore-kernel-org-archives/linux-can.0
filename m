From: David Jander <david@protonic.nl>
Subject: Re: RFC: [PATCH v2] can: flexcan: Implement errata ERR005829
Date: Tue, 16 Sep 2014 14:28:46 +0200
Message-ID: <20140916142846.2ae8335c@archvile>
References: <1409755642-28233-1-git-send-email-david@protonic.nl>
	<54081940.6060402@pengutronix.de>
	<20140904104440.5766d764@archvile>
	<5418238B.6010600@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:16219 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752927AbaIPM2W (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 16 Sep 2014 08:28:22 -0400
In-Reply-To: <5418238B.6010600@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

On Tue, 16 Sep 2014 13:48:27 +0200
Marc Kleine-Budde <mkl@pengutronix.de> wrote:

> On 09/04/2014 10:44 AM, David Jander wrote:
> >> Looks good. Can you please prepare a more detailed commit message.
> > 
> > Ok, I will briefly describe the workaround. I first thought that
> > mentioning the errata number would be sufficient, since it is freely
> > available documentation from Freescale.
> > 
> > Just in case you want to paste it into your version of the patch, here it
> > goes:
> > 
> > ERR005829: FlexCAN: FlexCAN does not transmit a message that is enabled to
> > be transmitted in a specific moment during the arbitration process.
> > 
> > Workaround: The workaround consists of two extra steps after setting up a
> > message for transmission:
> > 
> > Step 8:  Reserve the first valid mailbox as an inactive mailbox
> > (CODE=0b1000). If RX FIFO is disabled, this mailbox must be message buffer
> > 0. Otherwise, the first valid mailbox can be found using the "RX FIFO
> > filters" table in the FlexCAN chapter of the chip reference manual.
> > 
> > Step 9: Write twice INACTIVE code (0b1000) into the first valid mailbox.
> 
> Thanks, added the description to the patch.
> 
> > 
> >>>  drivers/net/can/flexcan.c | 10 +++++++++-
> >>>  1 file changed, 9 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> >>> index 0bcbb96..d9d0ecb 100644
> >>> --- a/drivers/net/can/flexcan.c
> >>> +++ b/drivers/net/can/flexcan.c
> >>> @@ -125,7 +125,9 @@
> >>>  	 FLEXCAN_ESR_BOFF_INT | FLEXCAN_ESR_ERR_INT)
> >>>  
> >>>  /* FLEXCAN interrupt flag register (IFLAG) bits */
> >>> -#define FLEXCAN_TX_BUF_ID		8
> >>> +/* Errata ERR005829 step7: Reserve first valid MB */
> >>> +#define FLEXCAN_FIRST_VALID_MB		8
> >>> +#define FLEXCAN_TX_BUF_ID		9
> >>>  #define FLEXCAN_IFLAG_BUF(x)		BIT(x)
> >>>  #define FLEXCAN_IFLAG_RX_FIFO_OVERFLOW	BIT(7)
> >>>  #define FLEXCAN_IFLAG_RX_FIFO_WARN	BIT(6)
> >>> @@ -428,6 +430,12 @@ static int flexcan_start_xmit(struct sk_buff *skb,
> >>> struct net_device *dev) flexcan_write(can_id,
> >>> &regs->cantxfg[FLEXCAN_TX_BUF_ID].can_id); flexcan_write(ctrl,
> >>> &regs->cantxfg[FLEXCAN_TX_BUF_ID].can_ctrl); 
> >>
> >> However, I don't want to write unconditionally two times here, so I've
> >> added a runtime decision with a quirk for this. I'll send an updated
> >> patch.
> > 
> > Please note that if the silicon bug didn't exist, none of the two writes
> > would be necessary.
> > Once you create a quirk for this, how are we supposed to know which
> > versions need this quirk, and which don't? Can we trust the existence of
> > erratas for the different i.MX Soc's, and should we just go and check them
> > all?
> 
> I had a patch with the quirk, but I removed it, as you suggested, just
> in case.

I did not directly suggest to NOT use a quirk, I only had some concerns. In
the meantime I have checked a few of the SoCs for erratas, and found this
errata only for i.MX6 and Vybrid VF6xx, which makes me suspect this problem is
unique to IP version 10 (if the IP version table at the beginning of the
source-code is to be trusted).

OTOH, if you decided to leave the unconditional writes in there, I am fine
with that. I don't think they do much harm.

Is it time to revisit my other patch(es) yet? If so, from where should I pull
the base?

Best regards,

-- 
David Jander
Protonic Holland.
