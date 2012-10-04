From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 2/3] can: peak_pcmcia: fix error return code
Date: Thu,  4 Oct 2012 19:53:38 +0200
Message-ID: <1349373219-30387-3-git-send-email-mkl@pengutronix.de>
References: <1349373219-30387-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34485 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750710Ab2JDRxq (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 4 Oct 2012 13:53:46 -0400
In-Reply-To: <1349373219-30387-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: davem@davemloft.net
Cc: linux-can@vger.kernel.org, nnnnetdev@vger.kernel.org, Peter Senna Tschudin <peter.senna@gmail.com>, Marc Kleine-Budde <mkl@pengutronix.de>

From: Peter Senna Tschudin <peter.senna@gmail.com>

Convert a nonnegative error return code to a negative one, as returned
elsewhere in the function.

A simplified version of the semantic match that finds this problem is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
(
if@p1 (\(ret < 0\|ret != 0\))
 { ... return ret; }
|
ret@p1 = 0
)
... when != ret = e1
    when != &ret
*if(...)
{
  ... when != ret = e2
      when forall
 return ret;
}
// </smpl>

Signed-off-by: Peter Senna Tschudin <peter.senna@gmail.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/sja1000/peak_pcmcia.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/sja1000/peak_pcmcia.c b/drivers/net/can/sja1000/peak_pcmcia.c
index ec6bd9d..272a85f 100644
--- a/drivers/net/can/sja1000/peak_pcmcia.c
+++ b/drivers/net/can/sja1000/peak_pcmcia.c
@@ -686,8 +686,10 @@ static int __devinit pcan_probe(struct pcmcia_device *pdev)
 
 	/* detect available channels */
 	pcan_add_channels(card);
-	if (!card->chan_count)
+	if (!card->chan_count) {
+		err = -ENOMEM;
 		goto probe_err_4;
+	}
 
 	/* init the timer which controls the leds */
 	init_timer(&card->led_timer);
-- 
1.7.10

