From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH] can: peak_pci: prevent use after free at netdev removal
Date: Tue, 20 May 2014 11:38:56 +0200
Message-ID: <1400578736-15381-1-git-send-email-s.grosjean@peak-system.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp12.smtpout.orange.fr ([80.12.242.134]:48718 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750747AbaETJjN (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 20 May 2014 05:39:13 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can Mailing List <linux-can@vger.kernel.org>
Cc: Stephane Grosjean <s.grosjean@peak-system.com>, "Christopher R. Baker" <cbaker@rec.ri.cmu.edu>

As remarked by Christopher R. Baker in his post at

http://marc.info/?l=linux-can&m=139707295706465&w=2

there's a possibility for an use after free condition at device removal.

This simplified patch introduces an additional variable to prevent the issue.
Thanks for catching this.

Reported-by: Christopher R. Baker <cbaker@rec.ri.cmu.edu>
CC: Christopher R. Baker <cbaker@rec.ri.cmu.edu>
Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>

---
 drivers/net/can/sja1000/peak_pci.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/sja1000/peak_pci.c b/drivers/net/can/sja1000/peak_pci.c
index c540e3d..564933a 100644
--- a/drivers/net/can/sja1000/peak_pci.c
+++ b/drivers/net/can/sja1000/peak_pci.c
@@ -551,7 +551,7 @@ static int peak_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	struct sja1000_priv *priv;
 	struct peak_pci_chan *chan;
-	struct net_device *dev;
+	struct net_device *dev, *prev_dev;
 	void __iomem *cfg_base, *reg_base;
 	u16 sub_sys_id, icr;
 	int i, err, channels;
@@ -688,11 +688,13 @@ failure_remove_channels:
 	writew(0x0, cfg_base + PITA_ICR + 2);
 
 	chan = NULL;
-	for (dev = pci_get_drvdata(pdev); dev; dev = chan->prev_dev) {
-		unregister_sja1000dev(dev);
-		free_sja1000dev(dev);
+	for (dev = pci_get_drvdata(pdev); dev; dev = prev_dev) {
 		priv = netdev_priv(dev);
 		chan = priv->priv;
+		prev_dev = chan->prev_dev;
+
+		unregister_sja1000dev(dev);
+		free_sja1000dev(dev);
 	}
 
 	/* free any PCIeC resources too */
@@ -726,10 +728,12 @@ static void peak_pci_remove(struct pci_dev *pdev)
 
 	/* Loop over all registered devices */
 	while (1) {
+		struct net_device *prev_dev = chan->prev_dev;
+
 		dev_info(&pdev->dev, "removing device %s\n", dev->name);
 		unregister_sja1000dev(dev);
 		free_sja1000dev(dev);
-		dev = chan->prev_dev;
+		dev = prev_dev;
 
 		if (!dev) {
 			/* do that only for first channel */
-- 
1.9.1

