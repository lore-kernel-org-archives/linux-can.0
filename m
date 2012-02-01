From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH] peak_pci: Fix the way channels are linked together
Date: Wed,  1 Feb 2012 11:05:48 +0100
Message-ID: <1328090748-17459-1-git-send-email-s.grosjean@peak-system.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-4d.bbox.fr ([194.158.122.134]:61753 "EHLO mail-4d.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755273Ab2BAKFQ (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 1 Feb 2012 05:05:16 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>, Stephane Grosjean <s.grosjean@peak-system.com>

Change the way channels objects are linked together by peak_pci_probe()
avoiding any kernel oops when driver is removed. Side effect is that
the list is now browsed from last to first channel.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
---
 drivers/net/can/sja1000/peak_pci.c |   23 +++++++++--------------
 1 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/net/can/sja1000/peak_pci.c b/drivers/net/can/sja1000/peak_pci.c
index 2c7f503..2147959 100644
--- a/drivers/net/can/sja1000/peak_pci.c
+++ b/drivers/net/can/sja1000/peak_pci.c
@@ -39,9 +39,9 @@ MODULE_LICENSE("GPL v2");
 #define DRV_NAME  "peak_pci"
 
 struct peak_pci_chan {
-	void __iomem *cfg_base;	     /* Common for all channels */
-	struct net_device *next_dev; /* Chain of network devices */
-	u16 icr_mask;		     /* Interrupt mask for fast ack */
+	void __iomem *cfg_base;		/* Common for all channels */
+	struct net_device *prev_dev;	/* Chain of network devices */
+	u16 icr_mask;			/* Interrupt mask for fast ack */
 };
 
 #define PEAK_PCI_CAN_CLOCK	(16000000 / 2)
@@ -98,7 +98,7 @@ static int __devinit peak_pci_probe(struct pci_dev *pdev,
 {
 	struct sja1000_priv *priv;
 	struct peak_pci_chan *chan;
-	struct net_device *dev, *dev0 = NULL;
+	struct net_device *dev;
 	void __iomem *cfg_base, *reg_base;
 	u16 sub_sys_id, icr;
 	int i, err, channels;
@@ -196,18 +196,14 @@ static int __devinit peak_pci_probe(struct pci_dev *pdev,
 		}
 
 		/* Create chain of SJA1000 devices */
-		if (i == 0)
-			dev0 = dev;
-		else
-			chan->next_dev = dev;
+		chan->prev_dev = pci_get_drvdata(pdev);
+		pci_set_drvdata(pdev, dev);
 
 		dev_info(&pdev->dev,
 			 "%s at reg_base=0x%p cfg_base=0x%p irq=%d\n",
 			 dev->name, priv->reg_base, chan->cfg_base, dev->irq);
 	}
 
-	pci_set_drvdata(pdev, dev0);
-
 	/* Enable interrupts */
 	writew(icr, cfg_base + PITA_ICR + 2);
 
@@ -217,12 +213,11 @@ failure_remove_channels:
 	/* Disable interrupts */
 	writew(0x0, cfg_base + PITA_ICR + 2);
 
-	for (dev = dev0; dev; dev = chan->next_dev) {
+	for (dev = pci_get_drvdata(pdev); dev; dev = chan->prev_dev) {
 		unregister_sja1000dev(dev);
 		free_sja1000dev(dev);
 		priv = netdev_priv(dev);
 		chan = priv->priv;
-		dev = chan->next_dev;
 	}
 
 	pci_iounmap(pdev, reg_base);
@@ -241,7 +236,7 @@ failure_disable_pci:
 
 static void __devexit peak_pci_remove(struct pci_dev *pdev)
 {
-	struct net_device *dev = pci_get_drvdata(pdev); /* First device */
+	struct net_device *dev = pci_get_drvdata(pdev); /* Last device */
 	struct sja1000_priv *priv = netdev_priv(dev);
 	struct peak_pci_chan *chan = priv->priv;
 	void __iomem *cfg_base = chan->cfg_base;
@@ -255,7 +250,7 @@ static void __devexit peak_pci_remove(struct pci_dev *pdev)
 		dev_info(&pdev->dev, "removing device %s\n", dev->name);
 		unregister_sja1000dev(dev);
 		free_sja1000dev(dev);
-		dev = chan->next_dev;
+		dev = chan->prev_dev;
 		if (!dev)
 			break;
 		priv = netdev_priv(dev);
-- 
1.7.5.4

