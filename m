From: "Christopher R. Baker" <cbaker@rec.ri.cmu.edu>
Subject: [PATCH] peak_pci: fix use after free in netdev teardown
Date: Wed, 09 Apr 2014 15:45:20 -0400
Message-ID: <1397072720.22713.19.camel@acrs-z800-1>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-3Z/+GsOUoUw8Hjv3gw3I"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.rec.ri.cmu.edu ([128.2.197.155]:35872 "EHLO
	mail.rec.ri.cmu.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933811AbaDITqE (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 9 Apr 2014 15:46:04 -0400
Received: from [128.2.196.81] (acrs-z800-1.rec.ri.cmu.edu [128.2.196.81])
	(authenticated bits=0)
	by mail.rec.ri.cmu.edu (8.13.1/8.13.1) with ESMTP id s39Jjx3G031972
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <linux-can@vger.kernel.org>; Wed, 9 Apr 2014 15:46:03 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org


--=-3Z/+GsOUoUw8Hjv3gw3I
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi All,

In the course of tracking down (and eventually backporting) a fix to one
of my systems that is still running a 3.2 kernel, I noticed what I
believe to be a pair of use-after-free bugs in peak_pci.c pertaining to
the linked list of netdevs that is maintained for multi-port cards.
These bugs persist in 3.14, so I thought I should send along a patch for
review.

Basically, the "prev_dev" pointer that is used for this list lives in
memory that is allocated by alloc_sja1000dev(), but it is referenced
after the call to free_sja1000dev() when walking the list during
teardown, both in the failure case of peak_pci_probe and in
peak_pci_remove.  Unless I'm missing something, these are toes waiting
to be stubbed...

Caveats:
 - This is a growing blob of copy-pasta that should probably be
refactored to a common location.  For example, peak_pci_remove could be
restructured to incrementally check and free allocated resources,
allowing the "failure_remove_channels" label to delegate the cleanup to
peak_pci_remove.  I didn't want to bite off too much this time, though,
so I left that alone.
 - I don't have an expresscard adapter to check the placement of the
pciec_remove stanzas.  By inspection, unregister_sja1000dev does not
appear to have a path back to the pciec stuff, but I may have missed
something.

-ChrisR

Signed-of-by: Christopher R. Baker <cbaker@rec.ri.cmu.edu>



--=-3Z/+GsOUoUw8Hjv3gw3I
Content-Disposition: attachment; filename="peak_pci_cleanup_use_after_free.diff"
Content-Type: text/x-patch; name="peak_pci_cleanup_use_after_free.diff"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

diff --git a/drivers/net/can/sja1000/peak_pci.c b/drivers/net/can/sja1000/peak_pci.c
index 065ca49..4ff33df 100644
--- a/drivers/net/can/sja1000/peak_pci.c
+++ b/drivers/net/can/sja1000/peak_pci.c
@@ -686,17 +686,28 @@ failure_remove_channels:
 	/* Disable interrupts */
 	writew(0x0, cfg_base + PITA_ICR + 2);
 
-	chan = NULL;
-	for (dev = pci_get_drvdata(pdev); dev; dev = chan->prev_dev) {
-		unregister_sja1000dev(dev);
-		free_sja1000dev(dev);
+	/* Dealloc netdevs: notably replicated near-verbatim in peak_pci_remove */
+	dev = pci_get_drvdata(pdev);
+	while(dev)
+	{
+		/* priv and chan look into memory that is allocated by alloc_sja1000dev,
+		   so be careful to cache prev_dev before free_sja1000dev */
+		struct net_device *prev_dev;
 		priv = netdev_priv(dev);
 		chan = priv->priv;
+		prev_dev = chan->prev_dev;
+
+		/* free PCIeC resources for the first card, if present, and before free_sja1000dev. */
+		if (!prev_dev && chan->pciec_card)
+			peak_pciec_remove(chan->pciec_card);
+
+		unregister_sja1000dev(dev);
+		free_sja1000dev(dev);
+
+		dev = prev_dev;
 	}
+	pci_set_drvdata(pdev,NULL);
 
-	/* free any PCIeC resources too */
-	if (chan && chan->pciec_card)
-		peak_pciec_remove(chan->pciec_card);
 
 	pci_iounmap(pdev, reg_base);
 
@@ -717,28 +728,35 @@ static void peak_pci_remove(struct pci_dev *pdev)
 	struct net_device *dev = pci_get_drvdata(pdev); /* Last device */
 	struct sja1000_priv *priv = netdev_priv(dev);
 	struct peak_pci_chan *chan = priv->priv;
+
 	void __iomem *cfg_base = chan->cfg_base;
 	void __iomem *reg_base = priv->reg_base;
 
 	/* Disable interrupts */
 	writew(0x0, cfg_base + PITA_ICR + 2);
 
-	/* Loop over all registered devices */
-	while (1) {
-		dev_info(&pdev->dev, "removing device %s\n", dev->name);
+	/* Dealloc netdevs: notably replicated from above */
+	while(dev)
+	{
+		/* priv and chan look into memory that is allocated by alloc_sja1000dev,
+		   so be careful to cache prev_dev before free_sja1000dev */
+		struct net_device *prev_dev;
+		priv = netdev_priv(dev);
+		chan = priv->priv;
+		prev_dev = chan->prev_dev;
+		dev_info(&pdev->dev, "removing device '%s' at %p (prev_dev = %p, chan->pciec_card = %p)\n",
+						dev->name, dev, prev_dev,chan->pciec_card);
+
+		/* free PCIeC resources for the first card, if present, and before free_sja1000dev. */
+		if (!prev_dev && chan->pciec_card)
+			peak_pciec_remove(chan->pciec_card);
+
 		unregister_sja1000dev(dev);
 		free_sja1000dev(dev);
-		dev = chan->prev_dev;
 
-		if (!dev) {
-			/* do that only for first channel */
-			if (chan->pciec_card)
-				peak_pciec_remove(chan->pciec_card);
-			break;
-		}
-		priv = netdev_priv(dev);
-		chan = priv->priv;
+		dev = prev_dev;
 	}
+	pci_set_drvdata(pdev,NULL);
 
 	pci_iounmap(pdev, reg_base);
 	pci_iounmap(pdev, cfg_base);

--=-3Z/+GsOUoUw8Hjv3gw3I--

