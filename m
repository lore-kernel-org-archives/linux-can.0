From: Andreas Larsson <andreas@gaisler.com>
Subject: Re: [PATCH v8] can: grcan: Add device driver for GRCAN and GRHCAN
 cores
Date: Wed, 14 Nov 2012 08:50:33 +0100
Message-ID: <50A34D49.2070908@gaisler.com>
References: <509C47CB.8060701@pengutronix.de> <1352732256-12712-1-git-send-email-andreas@gaisler.com> <50A2B88A.3040609@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from vsp-authed02.binero.net ([195.74.38.226]:20244 "HELO
	vsp-authed-02-02.binero.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751918Ab2KNHul (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 14 Nov 2012 02:50:41 -0500
In-Reply-To: <50A2B88A.3040609@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, software@gaisler.com, Wolfgang Grandegger <wg@grandegger.com>, devicetree-discuss@lists.ozlabs.org

On 11/13/2012 10:15 PM, Marc Kleine-Budde wrote:

[...]

> On 11/12/2012 03:57 PM, Andreas Larsson wrote:
>> >+	bpr = 0; /* Note bpr and brp are different concepts */
>> >+	rsj = bt->sjw;
>> >+	ps1 = (bt->prop_seg + bt->phase_seg1) - 1; /* tseg1 - 1 */
>> >+	ps2 = bt->phase_seg2;
>> >+	scaler = (bt->brp - 1);
>> >+	timing |= (bpr << GRCAN_CONF_BPR_BIT) & GRCAN_CONF_BPR;
>> >+	timing |= (rsj << GRCAN_CONF_RSJ_BIT) & GRCAN_CONF_RSJ;
>> >+	timing |= (ps1 << GRCAN_CONF_PS1_BIT) & GRCAN_CONF_PS1;
>> >+	timing |= (ps2 << GRCAN_CONF_PS2_BIT) & GRCAN_CONF_PS2;
>> >+	timing |= (scaler << GRCAN_CONF_SCALER_BIT) & GRCAN_CONF_SCALER;
>> >+
>> >+	netdev_info(dev, "setting timing=0x%x\n", timing);
> what about moving the sanity check before putting together the "timing"
> variable and doing the netdev_info()?

The idea was for the user to have the full context of the problem when getting 
the error (e.g., when using the bitrate method to set the timing parameters, the 
calculated parameters are not otherwise known to the user). But I can do that 
with a separate netdev_dbg and move the sanity check as suggested.

>> >+	if (!(ps1 > ps2)) {
>> >+		netdev_err(dev, "PS1 > PS2 must hold: PS1=%d, PS2=%d\n",
>> >+			   ps1, ps2);
>> >+		return -EINVAL;
>> >+	}
>> >+	if (!(ps2 >= rsj)) {
>> >+		netdev_err(dev, "PS2 >= RSJ must hold: PS2=%d, RSJ=%d\n",
>> >+			   ps2, rsj);
>> >+		return -EINVAL;
>> >+	}
>> >+
>> >+	grcan_write_bits(&regs->conf, timing, GRCAN_CONF_TIMING);
>> >+	return 0;
>> >+}

[...]

>> >+static int grcan_poll(struct napi_struct *napi, int rx_budget)
>> >+{
>> >+	struct grcan_priv *priv = container_of(napi, struct grcan_priv, napi);
>> >+	struct net_device *dev = priv->dev;
>> >+	struct grcan_registers __iomem *regs = priv->regs;
>> >+	int rx_work_done;
>> >+	unsigned long flags;
>> >+
>> >+	/* Receive according to given budget */
>> >+	rx_work_done = grcan_receive(dev, rx_budget);
>> >+
>> >+	/* Catch up echo skb according to separate budget to get the benefits of
>> >+	 * napi for tx as well. The given rx_budget might not be appropriate for
>> >+	 * the tx side.
>> >+	 */
>> >+	grcan_transmit_catch_up(dev, GRCAN_TX_BUDGET);
>> >+
>> >+	spin_lock_irqsave(&priv->lock, flags);
>> >+
>> >+	if (grcan_poll_all_done(dev)) {
> Just make it:
> 	if (work_done < budget) {
> 		napi_complete();
> 		enable_interrupts();
> 	}
>
> If there are CAN frames pending, an interrupt will kick in and
> reschedule the NAPI.

Sure, I can do that for the first check (and add back checking tx_work_done as 
well). That misses to call napi_complete and start interrupts in the case in 
which handling of frames are complete work_done == budget though. But on the 
other hand, then grcan_poll will be triggered once again and then detect that 
nothing is to be done if that is still the case.

However, the problem with skipping the check after turning on interrupts is that 
more frames can have arrived and/or have been sent after calculating work_done 
and before turning on interrupts. For those frames, unless I have misunderstood 
something, interrupts will not be raised and they can get stuck until (if ever) 
later frames once again trigger rescheduling of napi.

>> >+		bool complete = true;
>> >+
>> >+		if (!priv->closing) {
>> >+			/* Enable tx and rx interrupts again */
>> >+			grcan_set_bits(&regs->imr, GRCAN_IRQ_TX | GRCAN_IRQ_RX);
>> >+
>> >+			/* If more work arrived between detecting completion and
>> >+			 * turning on interrupts, we need to keep napi running
>> >+			 */
>> >+			if (!grcan_poll_all_done(dev)) {
>> >+				complete = false;
>> >+				grcan_clear_bits(&regs->imr,
>> >+						 GRCAN_IRQ_TX | GRCAN_IRQ_RX);
>> >+			}
>> >+		}
>> >+		if (complete)
>> >+			napi_complete(napi);
>> >+	}
>> >+
>> >+	spin_unlock_irqrestore(&priv->lock, flags);
>> >+
>> >+	return rx_work_done;
>> >+}


Thanks for the feedback!

Cheers,
Andreas


