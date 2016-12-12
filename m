From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: ti hecc rx frames out of order
Date: Mon, 12 Dec 2016 19:46:10 +0100
Message-ID: <e49d562c-979e-ea1e-bdf1-3fc5b7a0926a@grandegger.com>
References: <1579A5A5423CC14B827884B535F8E951349421F6@SSCOXCHG2.spray.com>
 <08de827f-0d1b-4523-0ed9-f0979345de87@hartkopp.net>
 <1579A5A5423CC14B827884B535F8E95134942564@SSCOXCHG2.spray.com>
 <0b6dc834-db5b-a8e3-1461-f97c7c79ad44@hartkopp.net>
 <1579A5A5423CC14B827884B535F8E95134949AB3@SSCOXCHG2.spray.com>
 <83813a5e-b146-2763-1fb3-31d64fcebf4c@hartkopp.net>
 <1579A5A5423CC14B827884B535F8E95134949B2C@SSCOXCHG2.spray.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailproxy03.manitu.net ([217.11.48.151]:50790 "EHLO
        mailproxy03.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752436AbcLLSqP (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 12 Dec 2016 13:46:15 -0500
In-Reply-To: <1579A5A5423CC14B827884B535F8E95134949B2C@SSCOXCHG2.spray.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Grim, Dennis" <Dennis.Grim@teejet.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hello Dennis,

I had a closer look to the ti_hecc driver...

Am 12.12.2016 um 18:17 schrieb Grim, Dennis:
>>> I will gladly try your idea.  However, it appears to address an issue related to
>> SMP systems.  The TI AM3517 is single core.  Would you expect your idea to have
>> any impact for single core?
>>
>> No.
>>
>>> Also, the TI AM3517 HECC device driver uses NAPI.

At a first glance, access to HECC_CANMIM seems racy. It's modified in
the interrupt handler for TX and in ti_hecc_rx_poll() for RX. It may
happen, that the wrong RX mailbox is enabled... even if that's not yet
obvious too me. For a quick check, you could try the patch below:

diff --git a/drivers/net/can/ti_hecc.c b/drivers/net/can/ti_hecc.c
index 680d1ff..fc4b6c2 100644
--- a/drivers/net/can/ti_hecc.c
+++ b/drivers/net/can/ti_hecc.c
@@ -649,9 +649,11 @@ static int ti_hecc_rx_poll(struct napi_struct *napi, int quota)
 	if (hecc_read(priv, HECC_CANRMP) == 0) {
 		napi_complete(napi);
 		/* Re-enable RX mailbox interrupts */
+		spin_lock_irqsave(&priv->mbx_lock, flags);
 		mbx_mask = hecc_read(priv, HECC_CANMIM);
 		mbx_mask |= HECC_TX_MBOX_MASK;
 		hecc_write(priv, HECC_CANMIM, mbx_mask);
+		spin_unlock_irqrestore(&priv->mbx_lock, flags);
 	}
 
 	return num_pkts;
@@ -776,9 +778,9 @@ static irqreturn_t ti_hecc_interrupt(int irq, void *dev_id)
 			mbx_mask = BIT(mbxno);
 			if (!(mbx_mask & hecc_read(priv, HECC_CANTA)))
 				break;
+			spin_lock_irqsave(&priv->mbx_lock, flags);
 			hecc_clear_bit(priv, HECC_CANMIM, mbx_mask);
 			hecc_write(priv, HECC_CANTA, mbx_mask);
-			spin_lock_irqsave(&priv->mbx_lock, flags);
 			hecc_clear_bit(priv, HECC_CANME, mbx_mask);
 			spin_unlock_irqrestore(&priv->mbx_lock, flags);
 			stats->tx_bytes += hecc_read_mbx(priv, mbxno,



Wolfgang.

