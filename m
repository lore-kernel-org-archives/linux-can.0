From: Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH 2/2] net: can: sja1000: Replace mdelay with usleep_range in pcan_add_channels
Date: Wed, 11 Apr 2018 09:43:26 +0800
Message-ID: <1523411006-1905-1-git-send-email-baijiaju1990@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: wg@grandegger.com, mkl@pengutronix.de
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
List-Id: linux-can.vger.kernel.org

pcan_add_channels() is never called in atomic context.

pcan_add_channels() is only called by pcan_probe(), which is only set as 
".probe" in struct pcmcia_driver.

Despite never getting called from atomic context, pcan_add_channels()
calls mdelay() to busily wait.
This is not necessary and can be replaced with usleep_range() to
avoid busy waiting.

This is found by a static analysis tool named DCNS written by myself.
And I also manually check it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/net/can/sja1000/peak_pcmcia.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/sja1000/peak_pcmcia.c b/drivers/net/can/sja1000/peak_pcmcia.c
index dd56133..1a1fbf3 100644
--- a/drivers/net/can/sja1000/peak_pcmcia.c
+++ b/drivers/net/can/sja1000/peak_pcmcia.c
@@ -530,7 +530,7 @@ static int pcan_add_channels(struct pcan_pccard *card)
 	pcan_write_reg(card, PCC_CCR, ccr);
 
 	/* wait 2ms before unresetting channels */
-	mdelay(2);
+	usleep_range(2000, 3000);
 
 	ccr &= ~PCC_CCR_RST_ALL;
 	pcan_write_reg(card, PCC_CCR, ccr);
-- 
1.9.1
