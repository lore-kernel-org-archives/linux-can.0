From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] can: hi311x: Work around TX complete interrupt erratum
Date: Thu, 10 May 2018 06:38:43 +0200
Message-ID: <20180510043843.GA14936@wunner.de>
References: <dc7901c96bed90724bb372f4d3eead82bd22ac37.1525869303.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <dc7901c96bed90724bb372f4d3eead82bd22ac37.1525869303.git.lukas@wunner.de>
Sender: netdev-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org
Cc: Mathias Duckeck <m.duckeck@kunbus.de>, Akshay Bhat <akshay.bhat@timesys.com>, Casey Fitzpatrick <casey.fitzpatrick@timesys.com>
List-Id: linux-can.vger.kernel.org

On Wed, May 09, 2018 at 02:43:43PM +0200, Lukas Wunner wrote:
> When sending packets as fast as possible using "cangen -g 0 -i -x", the
> HI-3110 occasionally latches the interrupt pin high on completion of a
> packet, but doesn't set the TXCPLT bit in the INTF register.  The INTF
> register contains 0x00 as if no interrupt has occurred.  Even waiting
> for a few milliseconds after the interrupt doesn't help.
> 
> Work around this apparent erratum by instead checking the TXMTY bit in
> the STATF register ("TX FIFO empty").  We know that we've queued up a
> packet for transmission if priv->tx_len is nonzero.  If the TX FIFO is
> empty, transmission of that packet must have completed.
> 
> Note that this is congruent with our handling of received packets, which
> likewise gleans from the STATF register whether a packet is waiting in
> the RX FIFO, instead of looking at the INTF register.

I should have mentioned, to verify the existence of the erratum and the
validity of the patch, you can apply the little debug patch below, then
run "cangen -g 0 -i -x".  You should see error messages in dmesg within
a few minutes.

-- >8 --
diff --git a/drivers/net/can/spi/hi311x.c b/drivers/net/can/spi/hi311x.c
index 53e320c..48b5c63 100644
--- a/drivers/net/can/spi/hi311x.c
+++ b/drivers/net/can/spi/hi311x.c
@@ -739,6 +739,9 @@ static irqreturn_t hi3110_can_ist(int irq, void *dev_id)
 		}
 
 		if (priv->tx_len && statf & HI3110_STAT_TXMTY) {
+			if (!(intf & HI3110_INT_TXCPLT))
+				dev_err(&spi->dev, "TX FIFO empty and TX was queued but TXCPLT not set\n");
+
 			net->stats.tx_packets++;
 			net->stats.tx_bytes += priv->tx_len - 1;
 			can_led_event(net, CAN_LED_EVENT_TX);
