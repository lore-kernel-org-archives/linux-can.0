From: Andreas Larsson <andreas@gaisler.com>
Subject: Re: [PATCH v8] can: grcan: Add device driver for GRCAN and GRHCAN
 cores
Date: Wed, 14 Nov 2012 12:02:51 +0100
Message-ID: <50A37A5B.8060808@gaisler.com>
References: <509C47CB.8060701@pengutronix.de> <1352732256-12712-1-git-send-email-andreas@gaisler.com> <50A2B88A.3040609@pengutronix.de> <50A34D49.2070908@gaisler.com> <50A359A1.30700@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from vsp-authed02.binero.net ([195.74.38.226]:39563 "HELO
	vsp-authed-03-02.binero.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752241Ab2KNLC6 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 14 Nov 2012 06:02:58 -0500
In-Reply-To: <50A359A1.30700@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, software@gaisler.com, Wolfgang Grandegger <wg@grandegger.com>, devicetree-discuss@lists.ozlabs.org

On 2012-11-14 09:43, Marc Kleine-Budde wrote:
> Handle incoming events (rx or tx-complete) until:
> a) number of handled events == budget
> or
> b) no more events pending.
>
> 	while (work_done < budget && interrupts_pending()) {
> 		work_done += handle_rx(budget - work_done);
> 		work_done += handle_tx(budget - work_done);
> 	}

That could starve handle_tx completely though under high rx pressure, but I can 
prevent that by making sure that half of the budget is held back in the first 
call to handle_rx.

> Then, if you have handled less events then budget:
> 1) call napi_complete()
> then
> 2) enable interrupts.
>
> 	if (work_done < budget) {
> 		napi_complete();
> 		enable_interrupts();
> 	}
>
> Then, return number of handled events:
>
> 	return work_done;

Any additional remarks on the following implementation of the poll function?

static int grcan_poll(struct napi_struct *napi, int budget)
{
	struct grcan_priv *priv = container_of(napi, struct grcan_priv, napi);
	struct net_device *dev = priv->dev;
	struct grcan_registers __iomem *regs = priv->regs;
	unsigned long flags;
	int work_done = 0;
	int reserved = budget / 2;

	while (work_done < budget) {
		int old_work_done = work_done;

		/* Prevent grcan_transmit_catch_up from starving by reserving
		 * part of the budget in the first iteration when calling
		 * grcan_receive.
		 */
		work_done += grcan_receive(dev, budget - reserved - work_done);
		reserved = 0;

		/* Catch up echo skb according to same budget, as
		 * grcan_transmit_catch_up can trigger echo frames being
		 * received.
		 */
		work_done += grcan_transmit_catch_up(dev, budget - work_done);

		/* Break out if nothing was done */
		if (work_done == old_work_done)
			break;
	}

	if (work_done < budget) {
		napi_complete(napi);

		/* Guarantee no interference with a running reset that otherwise
		 * could turn off interrupts.
		 */
		spin_lock_irqsave(&priv->lock, flags);

		/* Enable tx and rx interrupts again. No need to check
		 * priv->closing as napi_disable in grcan_close is waiting for
		 * scheduled napi calls to finish.
		 */
		grcan_set_bits(&regs->imr, GRCAN_IRQ_TX | GRCAN_IRQ_RX);

		spin_unlock_irqrestore(&priv->lock, flags);
	}

	return work_done;
}


Cheers,
Andreas

