From: Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH 1/2] net: can: sja1000: Replace mdelay with usleep_range in peak_pci_probe
Date: Wed, 11 Apr 2018 09:42:58 +0800
Message-ID: <1523410978-1834-1-git-send-email-baijiaju1990@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: wg@grandegger.com, mkl@pengutronix.de
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
List-Id: linux-can.vger.kernel.org

peak_pci_probe() is never called in atomic context.

peak_pci_probe() is set as ".probe" in struct pci_driver.

Despite never getting called from atomic context, peak_pci_probe()
calls mdelay() to busily wait.
This is not necessary and can be replaced with usleep_range() to
avoid busy waiting.

This is found by a static analysis tool named DCNS written by myself.
And I also manually check it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/net/can/sja1000/peak_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/sja1000/peak_pci.c b/drivers/net/can/sja1000/peak_pci.c
index 131026f..48cf821 100644
--- a/drivers/net/can/sja1000/peak_pci.c
+++ b/drivers/net/can/sja1000/peak_pci.c
@@ -608,7 +608,7 @@ static int peak_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	writeb(0x00, cfg_base + PITA_GPIOICR);
 	/* Toggle reset */
 	writeb(0x05, cfg_base + PITA_MISC + 3);
-	mdelay(5);
+	usleep_range(5000, 6000);
 	/* Leave parport mux mode */
 	writeb(0x04, cfg_base + PITA_MISC + 3);
 
-- 
1.9.1
