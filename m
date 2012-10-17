From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2] can: sja1000: plx_pci: add support for Connect Tech Inc's Canpro/104-Plus Opto CAN board
Date: Wed, 17 Oct 2012 12:09:53 +0200
Message-ID: <1350468593-10294-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35998 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755889Ab2JQKKB (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 17 Oct 2012 06:10:01 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Muhammad Ghias <mghias@connecttech.com>, Marc Kleine-Budde <mkl@pengutronix.de>

From: Muhammad Ghias <mghias@connecttech.com>

Patch adds support for CANpro/104-Plus Opto CAN board. Board uses PLX9030
bridge and two NXP SJA1000 CAN controllers. Patch is generated and tested with
kernel 3.6.1.

Signed-off-by: Muhammad Ghias <mghias@connecttech.com>
Acked-by: Wolfgang Grandegger <wg@grandegger.com>
[mkl: minor adjustments to commit message]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Hello,

I'm going to take this patch, please test.

regards, Marc

 drivers/net/can/sja1000/Kconfig   |    1 +
 drivers/net/can/sja1000/plx_pci.c |   19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/net/can/sja1000/Kconfig b/drivers/net/can/sja1000/Kconfig
index 03df9a8..559be87 100644
--- a/drivers/net/can/sja1000/Kconfig
+++ b/drivers/net/can/sja1000/Kconfig
@@ -93,6 +93,7 @@ config CAN_PLX_PCI
 	   - Marathon CAN-bus-PCI card (http://www.marathon.ru/)
 	   - TEWS TECHNOLOGIES TPMC810 card (http://www.tews.com/)
 	   - IXXAT Automation PC-I 04/PCI card (http://www.ixxat.com/)
+	   - Connect Tech Inc. CANpro/104-Plus Opto (CRG001) card (http://www.connecttech.com)
 
 config CAN_TSCAN1
 	tristate "TS-CAN1 PC104 boards"
diff --git a/drivers/net/can/sja1000/plx_pci.c b/drivers/net/can/sja1000/plx_pci.c
index 8bc9598..dc04407 100644
--- a/drivers/net/can/sja1000/plx_pci.c
+++ b/drivers/net/can/sja1000/plx_pci.c
@@ -44,6 +44,7 @@ MODULE_SUPPORTED_DEVICE("Adlink PCI-7841/cPCI-7841, "
 			"esd CAN-PCI/CPCI/PCI104/200, "
 			"esd CAN-PCI/PMC/266, "
 			"esd CAN-PCIe/2000, "
+			"Connect Tech Inc. CANpro/104-Plus Opto (CRG001), "
 			"IXXAT PC-I 04/PCI")
 MODULE_LICENSE("GPL v2");
 
@@ -131,6 +132,9 @@ struct plx_pci_card {
 #define TEWS_PCI_VENDOR_ID		0x1498
 #define TEWS_PCI_DEVICE_ID_TMPC810	0x032A
 
+#define CTI_PCI_VENDOR_ID		0x12c4
+#define CTI_PCI_DEVICE_ID_CRG001	0x0900
+
 static void plx_pci_reset_common(struct pci_dev *pdev);
 static void plx_pci_reset_marathon(struct pci_dev *pdev);
 static void plx9056_pci_reset_common(struct pci_dev *pdev);
@@ -222,6 +226,14 @@ static struct plx_pci_card_info plx_pci_card_info_tews __devinitdata = {
 	/* based on PLX9030 */
 };
 
+static struct plx_pci_card_info plx_pci_card_info_cti __devinitdata = {
+	"Connect Tech Inc. CANpro/104-Plus Opto (CRG001)", 2,
+	PLX_PCI_CAN_CLOCK, PLX_PCI_OCR, PLX_PCI_CDR,
+	{0, 0x00, 0x00}, { {2, 0x000, 0x80}, {2, 0x100, 0x80} },
+	&plx_pci_reset_common
+	/* based on PLX9030 */
+};
+
 static DEFINE_PCI_DEVICE_TABLE(plx_pci_tbl) = {
 	{
 		/* Adlink PCI-7841/cPCI-7841 */
@@ -300,6 +312,13 @@ static DEFINE_PCI_DEVICE_TABLE(plx_pci_tbl) = {
 		0, 0,
 		(kernel_ulong_t)&plx_pci_card_info_tews
 	},
+	{
+		/* Connect Tech Inc. CANpro/104-Plus Opto (CRG001) card */
+		PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9030,
+		CTI_PCI_VENDOR_ID, CTI_PCI_DEVICE_ID_CRG001,
+		0, 0,
+		(kernel_ulong_t)&plx_pci_card_info_cti
+	},
 	{ 0,}
 };
 MODULE_DEVICE_TABLE(pci, plx_pci_tbl);
-- 
1.7.10

