From: Andreas Larsson <andreas@gaisler.com>
Subject: Re: [PATCH v3] can: grcan: Add device driver for GRCAN and GRHCAN
 cores
Date: Tue, 30 Oct 2012 17:24:48 +0100
Message-ID: <508FFF50.8050900@gaisler.com>
References: <5087EDBF.2040108@gaisler.com> <1351588017-14357-1-git-send-email-andreas@gaisler.com> <508FA6D3.9000809@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from vsp-authed02.binero.net ([195.74.38.226]:22463 "HELO
	vsp-authed-03-02.binero.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S933902Ab2J3QY6 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 30 Oct 2012 12:24:58 -0400
In-Reply-To: <508FA6D3.9000809@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, devicetree-discuss@lists.ozlabs.org, software@gaisler.com

On 10/30/2012 11:07 AM, Wolfgang Grandegger wrote:
>> +	/* AHB bus error interrupts (not CAN bus errors) - shut down the
>> +	 * device.
>> +	 */
>> +	if (sources & (GRCAN_IRQ_TXAHBERR | GRCAN_IRQ_RXAHBERR)) {
>> +		if (sources & GRCAN_IRQ_TXAHBERR) {
>> +			netdev_err(dev, "got AHB bus error on tx\n");
>> +			stats->tx_errors++;
>> +		} else {
>> +			netdev_err(dev, "got AHB bus error on rx\n");
>> +			stats->rx_errors++;
>> +		}
>> +		netdev_err(dev, "halting device\n");
>> +
>> +		/* Prevent anything to be enabled again and halt device */
>> +		SPIN_LOCK(&priv->lock);
>> +		priv->closing = true;
>> +		netif_stop_queue(dev);
>> +		grcan_stop(dev);
>> +		SPIN_UNLOCK(&priv->lock);
>
> Hm, does that really happen? How can the user/app realized the problem
> and recover?

My understanding of it is that if you get amba bus errors something is seriously 
wrong and nothing can be done at driver level to recover. Shutting down the 
device is to prevent the driver from spamming console messages. I used to have a 
sysfs indication of such errors. Now dmesg is the way to find out about the 
problem. The user can always bring the interface down and up again and try again 
after such an error.


> Furthermore, why is a spin_clock enough here? THe interrupt may run a
> thread.

It should be enough because the function is only called
directly from the interrupt handler, right? Or did I miss something?


>> +	priv->can.ctrlmode_supported  =
>> +		CAN_CTRLMODE_LISTENONLY | CAN_CTRLMODE_ONE_SHOT;
>
> What about triple-sampling?

That is not supported by the hardware.


> I curious how the device behaves on bus errors and state changes. Could
> you please show the output of "candump -e any,0:0,#FFFFFFFF" while
> sending a CAN message with no other node on the bus (not connected) and
> with going bus off (by short-circuiting CAN high and low).


Here is the output (with long sequences of similar error frames
where only one counter is increasing cut out) from the the upcoming v4. let me 
know if you see any problems with this.

   can0  20000006  [8] 00 00 00 00 00 00 10 00   ERRORFRAME
         lost-arbitration{at bit 0}
         controller-problem{}
         error-counter-tx-rx{{16}{0}}
   can0  20000004  [8] 00 20 00 00 00 00 88 00   ERRORFRAME
         controller-problem{tx-error-passive}
         error-counter-tx-rx{{136}{0}}
   can0  20000006  [8] 00 20 00 00 00 00 90 00   ERRORFRAME
         lost-arbitration{at bit 0}
         controller-problem{tx-error-passive}
         error-counter-tx-rx{{144}{0}}
   [...]
   can0  20000006  [8] 00 20 00 00 00 00 F0 00   ERRORFRAME
         lost-arbitration{at bit 0}
         controller-problem{tx-error-passive}
         error-counter-tx-rx{{240}{0}}
   can0  20000006  [8] 00 20 00 00 00 00 F8 00   ERRORFRAME
         lost-arbitration{at bit 0}
         controller-problem{tx-error-passive}
         error-counter-tx-rx{{248}{0}}
   can0  20000042  [8] 00 00 00 00 00 00 80 00   ERRORFRAME
         lost-arbitration{at bit 0}
         bus-off
         error-counter-tx-rx{{128}{0}}
   can0  20000006  [8] 00 00 00 00 00 00 18 00   ERRORFRAME
         lost-arbitration{at bit 0}
         controller-problem{}
         error-counter-tx-rx{{24}{0}}
   can0  20000004  [8] 00 10 00 00 00 00 4F 80   ERRORFRAME
         controller-problem{rx-error-passive}
         error-counter-tx-rx{{79}{128}}
   [...]
   can0  20000006  [8] 00 10 00 00 00 00 77 80   ERRORFRAME
         lost-arbitration{at bit 0}
         controller-problem{rx-error-passive}
         error-counter-tx-rx{{119}{128}}
   can0  20000006  [8] 00 30 00 00 00 00 7F 80   ERRORFRAME
         lost-arbitration{at bit 0}
         controller-problem{rx-error-passive,tx-error-passive}
         error-counter-tx-rx{{127}{128}}
   can0  20000006  [8] 00 30 00 00 00 00 87 80   ERRORFRAME
         lost-arbitration{at bit 0}
         controller-problem{rx-error-passive,tx-error-passive}
         error-counter-tx-rx{{135}{128}}
   [...]
   can0  20000006  [8] 00 30 00 00 00 00 F7 80   ERRORFRAME
         lost-arbitration{at bit 0}
         controller-problem{rx-error-passive,tx-error-passive}
         error-counter-tx-rx{{247}{128}}
   can0  20000006  [8] 00 30 00 00 00 00 FF 80   ERRORFRAME
         lost-arbitration{at bit 0}
         controller-problem{rx-error-passive,tx-error-passive}
         error-counter-tx-rx{{255}{128}}
   can0  20000042  [8] 00 00 00 00 00 00 80 00   ERRORFRAME
         lost-arbitration{at bit 0}
         bus-off
         error-counter-tx-rx{{128}{0}}
   can0  20000006  [8] 00 00 00 00 00 00 18 00   ERRORFRAME
         lost-arbitration{at bit 0}
         controller-problem{}
         error-counter-tx-rx{{24}{0}}
   can0  20000004  [8] 00 10 00 00 00 00 4F 80   ERRORFRAME
         controller-problem{rx-error-passive}
         error-counter-tx-rx{{79}{128}}
   can0  20000006  [8] 00 10 00 00 00 00 57 80   ERRORFRAME
         lost-arbitration{at bit 0}
         controller-problem{rx-error-passive}
         error-counter-tx-rx{{87}{128}}
   [...]



Thanks a lot for all the feedback!

I'll send in v4 tomorrow.

Cheers,
Andreas

