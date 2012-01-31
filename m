From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 05/12] can: plx_pci: add support for IXXAT PCI cards
Date: Tue, 31 Jan 2012 22:46:43 +0100
Message-ID: <1328046410-21392-6-git-send-email-mkl@pengutronix.de>
References: <1328046410-21392-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44844 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755341Ab2AaVq7 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 31 Jan 2012 16:46:59 -0500
In-Reply-To: <1328046410-21392-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: James Kime <kime@ixxat.de>, Marc Kleine-Budde <mkl@pengutronix.de>

From: James Kime <kime@ixxat.de>

This patch adds support for IXXAT passive CAN controllers

Signed-off-by: James Kime <kime@ixxat.de>
Acked-by: Wolfgang Grandegger <wg@grandegger.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/sja1000/Kconfig   |    1 +
 drivers/net/can/sja1000/plx_pci.c |   22 +++++++++++++++++++++-
 2 files changed, 22 insertions(+), 1 deletions(-)

diff --git a/drivers/net/can/sja1000/Kconfig b/drivers/net/can/sja1000/Kconfig
index 36e9d59..b21523d 100644
--- a/drivers/net/can/sja1000/Kconfig
+++ b/drivers/net/can/sja1000/Kconfig
@@ -71,6 +71,7 @@ config CAN_PLX_PCI
 	   - esd CAN-PCIe/2000
 	   - Marathon CAN-bus-PCI card (http://www.marathon.ru/)
 	   - TEWS TECHNOLOGIES TPMC810 card (http://www.tews.com/)
+	   - IXXAT Automation PC-I 04/PCI card (http://www.ixxat.com/)
 
 config CAN_TSCAN1
 	tristate "TS-CAN1 PC104 boards"
diff --git a/drivers/net/can/sja1000/plx_pci.c b/drivers/net/can/sja1000/plx_pci.c
index c7f3d4e..a227586 100644
--- a/drivers/net/can/sja1000/plx_pci.c
+++ b/drivers/net/can/sja1000/plx_pci.c
@@ -43,7 +43,8 @@ MODULE_SUPPORTED_DEVICE("Adlink PCI-7841/cPCI-7841, "
 			"TEWS TECHNOLOGIES TPMC810, "
 			"esd CAN-PCI/CPCI/PCI104/200, "
 			"esd CAN-PCI/PMC/266, "
-			"esd CAN-PCIe/2000")
+			"esd CAN-PCIe/2000, "
+			"IXXAT PC-I 04/PCI")
 MODULE_LICENSE("GPL v2");
 
 #define PLX_PCI_MAX_CHAN 2
@@ -121,6 +122,10 @@ struct plx_pci_card {
 #define ESD_PCI_SUB_SYS_ID_PCIE2000	0x0200
 #define ESD_PCI_SUB_SYS_ID_PCI104200	0x0501
 
+#define IXXAT_PCI_VENDOR_ID		0x10b5
+#define IXXAT_PCI_DEVICE_ID		0x9050
+#define IXXAT_PCI_SUB_SYS_ID		0x2540
+
 #define MARATHON_PCI_DEVICE_ID		0x2715
 
 #define TEWS_PCI_VENDOR_ID		0x1498
@@ -193,6 +198,14 @@ static struct plx_pci_card_info plx_pci_card_info_esd2000 __devinitdata = {
 	/* based on PEX8311 */
 };
 
+static struct plx_pci_card_info plx_pci_card_info_ixxat __devinitdata = {
+	"IXXAT PC-I 04/PCI", 2,
+	PLX_PCI_CAN_CLOCK, PLX_PCI_OCR, PLX_PCI_CDR,
+	{0, 0x00, 0x00}, { {2, 0x00, 0x80}, {2, 0x200, 0x80} },
+	&plx_pci_reset_common
+	/* based on PLX9050 */
+};
+
 static struct plx_pci_card_info plx_pci_card_info_marathon __devinitdata = {
 	"Marathon CAN-bus-PCI", 2,
 	PLX_PCI_CAN_CLOCK, PLX_PCI_OCR, PLX_PCI_CDR,
@@ -267,6 +280,13 @@ static DEFINE_PCI_DEVICE_TABLE(plx_pci_tbl) = {
 		(kernel_ulong_t)&plx_pci_card_info_esd2000
 	},
 	{
+		/* IXXAT PC-I 04/PCI card */
+		IXXAT_PCI_VENDOR_ID, IXXAT_PCI_DEVICE_ID,
+		PCI_ANY_ID, IXXAT_PCI_SUB_SYS_ID,
+		0, 0,
+		(kernel_ulong_t)&plx_pci_card_info_ixxat
+	},
+	{
 		/* Marathon CAN-bus-PCI card */
 		PCI_VENDOR_ID_PLX, MARATHON_PCI_DEVICE_ID,
 		PCI_ANY_ID, PCI_ANY_ID,
-- 
1.7.4.1

