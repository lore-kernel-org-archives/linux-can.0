From: Alexander GQ Gerasiov <gq@cs.msu.su>
Subject: [PATCH] can: sja1000: plx_pci: Add support for Marathon CAN-bus-PCIe card
Date: Wed,  6 Apr 2016 14:51:10 +0300
Message-ID: <1459943470-11524-1-git-send-email-gq@cs.msu.su>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.lvk.cs.msu.su ([158.250.17.1]:55699 "EHLO
	mail.lvk.cs.msu.su" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932312AbcDFL4x (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 6 Apr 2016 07:56:53 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Nikita Edward Baruzdin <nebaruzdin@lvk.cs.msu.su>

From: Nikita Edward Baruzdin <nebaruzdin@lvk.cs.msu.su>

http://can.marathon.ru/page/devices/can-bus-pcie

Signed-off-by: Nikita Edward Baruzdin <nebaruzdin@lvk.cs.msu.su>
---
 drivers/net/can/sja1000/plx_pci.c | 58 +++++++++++++++++++++++++++++++++++----
 1 file changed, 52 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/sja1000/plx_pci.c b/drivers/net/can/sja1000/plx_pci.c
index 8836a74..e93cb5e 100644
--- a/drivers/net/can/sja1000/plx_pci.c
+++ b/drivers/net/can/sja1000/plx_pci.c
@@ -39,6 +39,7 @@ MODULE_DESCRIPTION("Socket-CAN driver for PLX90xx PCI-bridge cards with "
 MODULE_SUPPORTED_DEVICE("Adlink PCI-7841/cPCI-7841, "
 			"Adlink PCI-7841/cPCI-7841 SE, "
 			"Marathon CAN-bus-PCI, "
+			"Marathon CAN-bus-PCIe, "
 			"TEWS TECHNOLOGIES TPMC810, "
 			"esd CAN-PCI/CPCI/PCI104/200, "
 			"esd CAN-PCI/PMC/266, "
@@ -133,6 +134,7 @@ struct plx_pci_card {
 #define IXXAT_PCI_SUB_SYS_ID		0x2540
 
 #define MARATHON_PCI_DEVICE_ID		0x2715
+#define MARATHON_PCIE_DEVICE_ID		0x3432
 
 #define TEWS_PCI_VENDOR_ID		0x1498
 #define TEWS_PCI_DEVICE_ID_TMPC810	0x032A
@@ -141,8 +143,9 @@ struct plx_pci_card {
 #define CTI_PCI_DEVICE_ID_CRG001	0x0900
 
 static void plx_pci_reset_common(struct pci_dev *pdev);
-static void plx_pci_reset_marathon(struct pci_dev *pdev);
 static void plx9056_pci_reset_common(struct pci_dev *pdev);
+static void plx_pci_reset_marathon_pci(struct pci_dev *pdev);
+static void plx_pci_reset_marathon_pcie(struct pci_dev *pdev);
 
 struct plx_pci_channel_map {
 	u32 bar;
@@ -215,11 +218,19 @@ static struct plx_pci_card_info plx_pci_card_info_ixxat = {
 	/* based on PLX9050 */
 };
 
-static struct plx_pci_card_info plx_pci_card_info_marathon = {
+static struct plx_pci_card_info plx_pci_card_info_marathon_pci = {
 	"Marathon CAN-bus-PCI", 2,
 	PLX_PCI_CAN_CLOCK, PLX_PCI_OCR, PLX_PCI_CDR,
 	{0, 0x00, 0x00}, { {2, 0x00, 0x00}, {4, 0x00, 0x00} },
-	&plx_pci_reset_marathon
+	&plx_pci_reset_marathon_pci
+	/* based on PLX9052 */
+};
+
+static struct plx_pci_card_info plx_pci_card_info_marathon_pcie = {
+	"Marathon CAN-bus-PCIe", 2,
+	PLX_PCI_CAN_CLOCK, PLX_PCI_OCR, PLX_PCI_CDR,
+	{0, 0x00, 0x00}, { {2, 0x00, 0x00}, {3, 0x80, 0x00} },
+	&plx_pci_reset_marathon_pcie
 	/* based on PLX9052 */
 };
 
@@ -316,7 +327,14 @@ static const struct pci_device_id plx_pci_tbl[] = {
 		PCI_VENDOR_ID_PLX, MARATHON_PCI_DEVICE_ID,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
-		(kernel_ulong_t)&plx_pci_card_info_marathon
+		(kernel_ulong_t)&plx_pci_card_info_marathon_pci
+	},
+	{
+		/* Marathon CAN-bus-PCIe card */
+		PCI_VENDOR_ID_PLX, MARATHON_PCIE_DEVICE_ID,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		(kernel_ulong_t)&plx_pci_card_info_marathon_pcie
 	},
 	{
 		/* TEWS TECHNOLOGIES TPMC810 card */
@@ -437,8 +455,8 @@ static void plx9056_pci_reset_common(struct pci_dev *pdev)
 	iowrite32(cntrl, card->conf_addr + PLX9056_CNTRL);
 };
 
-/* Special reset function for Marathon card */
-static void plx_pci_reset_marathon(struct pci_dev *pdev)
+/* Special reset function for Marathon CAN-bus-PCI card */
+static void plx_pci_reset_marathon_pci(struct pci_dev *pdev)
 {
 	void __iomem *reset_addr;
 	int i;
@@ -460,6 +478,34 @@ static void plx_pci_reset_marathon(struct pci_dev *pdev)
 	}
 }
 
+/* Special reset function for Marathon CAN-bus-PCIe card */
+static void plx_pci_reset_marathon_pcie(struct pci_dev *pdev)
+{
+	void __iomem *addr;
+	void __iomem *reset_addr;
+	int i;
+
+	plx_pci_reset_common(pdev);
+
+	for (i = 0; i < 2; i++) {
+		struct plx_pci_channel_map *chan_map =
+			&plx_pci_card_info_marathon_pcie.chan_map_tbl[i];
+		addr = pci_iomap(pdev, chan_map->bar, chan_map->size);
+		if (!addr) {
+			dev_err(&pdev->dev, "Failed to remap reset "
+				"space %d (BAR%d)\n", i, chan_map->bar);
+		} else {
+			/* reset the SJA1000 chip */
+			#define MARATHON_PCIE_RESET_OFFSET 32
+			reset_addr = addr + chan_map->offset +
+			             MARATHON_PCIE_RESET_OFFSET;
+			iowrite8(0x1, reset_addr);
+			udelay(100);
+			pci_iounmap(pdev, addr);
+		}
+	}
+}
+
 static void plx_pci_del_card(struct pci_dev *pdev)
 {
 	struct plx_pci_card *card = pci_get_drvdata(pdev);
-- 
2.1.4

