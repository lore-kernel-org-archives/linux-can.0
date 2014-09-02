From: David Jander <david@protonic.nl>
Subject: Re: [PATCH 1/3] can: flexcan.c: Correctly initialize mailboxes
Date: Tue, 2 Sep 2014 13:32:55 +0200
Message-ID: <20140902133255.42a73441@archvile>
References: <1409133487-23367-1-git-send-email-david@protonic.nl>
	<1409133487-23367-2-git-send-email-david@protonic.nl>
	<54059ADC.60309@pengutronix.de>
	<20140902123725.01808f36@archvile>
	<5405A31E.1060403@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:5260 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752599AbaIBLcn (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 2 Sep 2014 07:32:43 -0400
In-Reply-To: <5405A31E.1060403@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: wg@grandegger.com, linux-can@vger.kernel.org

On Tue, 02 Sep 2014 12:59:42 +0200
Marc Kleine-Budde <mkl@pengutronix.de> wrote:

> On 09/02/2014 12:37 PM, David Jander wrote:
> > On Tue, 02 Sep 2014 12:24:28 +0200
> > Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> > 
> >> On 08/27/2014 11:58 AM, David Jander wrote:
> >>> Apparently mailboxes may contain random data at startup, causing some of
> >>> them being prepared for message reception. This causes overruns being
> >>> missed or even confusing the IRQ check for trasmitted messages,
> >>> increasing the transmit counter instead of the error counter.
> >>>
> >>> Signed-off-by: David Jander <david@protonic.nl>
> >>
> >> Before patch
> >>
> >> 0d1862e can: flexcan: fix flexcan_chip_start() on imx6
> >>
> >> there was a loop clearing the whole cantxfg register space. But this
> >> turned out to be bogus, as message buffers 1...7 are reserved by the
> >> FIFO engine and we're not allowed to tough them. This lead to some kind
> >> of abort on imx6.
> >>
> >> You may need this patch once you don't make use of the FIFO engine any
> >> more.
> > 
> > You will need this patch in either case, but indeed, if you use the FIFO,
> > you should skip the MB's that are shadowed by the FIFO.
> 
> ACK
> 
> > If you don't clear the rest of the MB's they may still contain random data
> > and the problem remains.
> > IMHO 0d1862e is wrong, since buffers are not in reset default values.
> > There is no indication of that in the reference manual, and I have
> > observed that they are indeed not cleared after reset.
> 
> Yes, 0d1862e was not complete, the initialisation was fixes with:
> 
> d5a7b40 can: flexcan: flexcan_chip_start: fix regression,
>                        mark one MB for TX and abort pending TX
> 
> Which sets FLEXCAN_MCR_MAXMB to 8, which is the only mailbox used for tx
> and the code of the tx mailbox is set to 0x4 == tx, inactive.

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 3f21142..f028c5d 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -62,7 +62,7 @@
 #define FLEXCAN_MCR_BCC			BIT(16)
 #define FLEXCAN_MCR_LPRIO_EN		BIT(13)
 #define FLEXCAN_MCR_AEN			BIT(12)
-#define FLEXCAN_MCR_MAXMB(x)		((x) & 0xf)
+#define FLEXCAN_MCR_MAXMB(x)		((x) & 0x1f)
 #define FLEXCAN_MCR_IDAM_A		(0 << 8)
 #define FLEXCAN_MCR_IDAM_B		(1 << 8)
 #define FLEXCAN_MCR_IDAM_C		(2 << 8)
@@ -735,9 +735,11 @@ static int flexcan_chip_start(struct net_device *dev)
 	 *
 	 */
 	reg_mcr = flexcan_read(&regs->mcr);
+	reg_mcr &= ~FLEXCAN_MCR_MAXMB(0xff);
 	reg_mcr |= FLEXCAN_MCR_FRZ | FLEXCAN_MCR_FEN | FLEXCAN_MCR_HALT |
 		FLEXCAN_MCR_SUPV | FLEXCAN_MCR_WRN_EN |
-		FLEXCAN_MCR_IDAM_C | FLEXCAN_MCR_SRX_DIS;
+		FLEXCAN_MCR_IDAM_C | FLEXCAN_MCR_SRX_DIS |
+		FLEXCAN_MCR_MAXMB(FLEXCAN_TX_BUF_ID);
 	netdev_dbg(dev, "%s: writing mcr=0x%08x", __func__, reg_mcr);
 	flexcan_write(reg_mcr, &regs->mcr);
 
Eh! This looks wrong! The MAXMB field is 7 bits wide according to the
reference manual (bits 0-6)... but the reset default value is supposed to be
0x0f, so the mask is still enough to clear the reset default.
What I don't understand is why the CAN controller is still able to put
messages into MB's after the FIFO is full. At least that is what I observed.

Best regards,

-- 
David Jander
Protonic Holland.
