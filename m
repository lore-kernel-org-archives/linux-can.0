From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH can] peak_pci: add PCI ID definition pcie card variant
Date: Tue, 16 Sep 2014 10:05:41 +0200
Message-ID: <5417EF55.9050805@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:60515 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752026AbaIPIFt (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 16 Sep 2014 04:05:49 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Stephane Grosjean <s.grosjean@peak-system.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Add PCI ID definition for the single channel PCAN ExpressCard 34 adapter.
Due to the subsystem id evaluation the correct number of channels (here 1)
is created at initialization time. Tested including the LED functionality.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
CC: Stephane Grosjean <s.grosjean@peak-system.com>

---

Hi Marc,

as this is 'just a PCI ID definition' this patch should go into Daves
net-tree for 3.17-rc upstream. The USB guys do it the same as there is no
risk of breaking other peoples work at that stage.

Tnx,
Oliver



diff --git a/drivers/net/can/sja1000/peak_pci.c b/drivers/net/can/sja1000/peak_pci.c
index 7a85590..e5fac36 100644
--- a/drivers/net/can/sja1000/peak_pci.c
+++ b/drivers/net/can/sja1000/peak_pci.c
@@ -70,6 +70,8 @@ struct peak_pci_chan {
 #define PEAK_PC_104P_DEVICE_ID	0x0006	/* PCAN-PC/104+ cards */
 #define PEAK_PCI_104E_DEVICE_ID	0x0007	/* PCAN-PCI/104 Express cards */
 #define PEAK_MPCIE_DEVICE_ID	0x0008	/* The miniPCIe slot cards */
+#define PEAK_PCIE_OEM_ID	0x0009	/* PCAN-PCI Express OEM */
+#define PEAK_PCIEC34_DEVICE_ID	0x000A	/* PCAN-PCI Express 34 (one channel) */
 
 #define PEAK_PCI_CHAN_MAX	4
 
@@ -87,6 +89,7 @@ static const struct pci_device_id peak_pci_tbl[] = {
 	{PEAK_PCI_VENDOR_ID, PEAK_CPCI_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
 #ifdef CONFIG_CAN_PEAK_PCIEC
 	{PEAK_PCI_VENDOR_ID, PEAK_PCIEC_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
+	{PEAK_PCI_VENDOR_ID, PEAK_PCIEC34_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
 #endif
 	{0,}
 };
@@ -653,7 +656,8 @@ static int peak_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		 * This must be done *before* register_sja1000dev() but
 		 * *after* devices linkage
 		 */
-		if (pdev->device == PEAK_PCIEC_DEVICE_ID) {
+		if (pdev->device == PEAK_PCIEC_DEVICE_ID ||
+		    pdev->device == PEAK_PCIEC34_DEVICE_ID) {
 			err = peak_pciec_probe(pdev, dev);
 			if (err) {
 				dev_err(&pdev->dev,



