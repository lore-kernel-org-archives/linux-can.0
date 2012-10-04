From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 2/3] can: peak_pcmcia: fix error return code
Date: Thu,  4 Oct 2012 19:57:21 +0200
Message-ID: <1349373442-11128-3-git-send-email-mkl@pengutronix.de>
References: <1349373442-11128-1-git-send-email-mkl@pengutronix.de>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1349373442-11128-1-git-send-email-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: davem@davemloft.net
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, Peter Senna Tschudin <peter.senna@gmail.com>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

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
