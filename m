From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v5 2/2] can: sja1000: fix return value of interrupt handler
Date: Sun, 24 Nov 2013 23:38:06 +0100
Message-ID: <c5cb898e-a4c9-4f0c-9a6b-24f5ae939451@email.android.com>
References: <1385329501-28021-1-git-send-email-mkl@pengutronix.de> <1385329501-28021-3-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:61799 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751165Ab3KXWiM (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 24 Nov 2013 17:38:12 -0500
In-Reply-To: <1385329501-28021-3-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc: kernel@pengutronix.de, kurt.van.dijck@eia.be

Hi Marc,

the reason why Kurt asked to split my patch was because of i added a change in pre_irq () to return a value. splitting up the patch as you did here IMO makes no sense. That is why I sent a new patch some days ago only addressing the fix without the 'return value enhancement'.

Best regards,
Oliver



Marc Kleine-Budde <mkl@pengutronix.de> schrieb:
>From: Oliver Hartkopp <socketcan@hartkopp.net>
>
>The irq processing counter 'n' is moved to the end of the while
>statement to
>return correct IRQ_[NONE|HANDLED] values at error conditions.
>
>Reported-by: Wolfgang Grandegger <wg@grandegger.com>
>Acked-by: Wolfgang Grandegger <wg@grandegger.com>
>Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>---
> drivers/net/can/sja1000/sja1000.c | 7 ++++---
> 1 file changed, 4 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/net/can/sja1000/sja1000.c
>b/drivers/net/can/sja1000/sja1000.c
>index 253845f..f17c301 100644
>--- a/drivers/net/can/sja1000/sja1000.c
>+++ b/drivers/net/can/sja1000/sja1000.c
>@@ -503,11 +503,11 @@ irqreturn_t sja1000_interrupt(int irq, void
>*dev_id)
> 
> 	while ((isrc = priv->read_reg(priv, SJA1000_IR)) &&
> 	       (n < SJA1000_MAX_IRQ)) {
>-		n++;
>+
> 		status = priv->read_reg(priv, SJA1000_SR);
> 		/* check for absent controller due to hw unplug */
> 		if (status == 0xFF && sja1000_is_absent(priv))
>-			return IRQ_NONE;
>+			goto out;
> 
> 		if (isrc & IRQ_WUI)
> 			netdev_warn(dev, "wakeup interrupt\n");
>@@ -535,7 +535,7 @@ irqreturn_t sja1000_interrupt(int irq, void
>*dev_id)
> 				status = priv->read_reg(priv, SJA1000_SR);
> 				/* check for absent controller */
> 				if (status == 0xFF && sja1000_is_absent(priv))
>-					return IRQ_NONE;
>+					goto out;
> 			}
> 		}
> 		if (isrc & (IRQ_DOI | IRQ_EI | IRQ_BEI | IRQ_EPI | IRQ_ALI)) {
>@@ -543,6 +543,7 @@ irqreturn_t sja1000_interrupt(int irq, void
>*dev_id)
> 			if (sja1000_err(dev, isrc, status))
> 				break;
> 		}
>+		n++;
> 	}
> out:
> 	if (priv->post_irq)

-- 
Diese Nachricht wurde von meinem Android-Mobiltelefon mit K-9 Mail gesendet.
