From: OIeg Moroz <oleg.moroz@mcc.vniiem.ru>
Subject: [PATCH v2] can: sja1000: add support for Elcus CAN200PCI
Date: Sat, 04 Jan 2014 13:53:14 +0400
Message-ID: <5352298.Hh5htuev4I@debian-toshiba>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mcc.vniiem.ru ([78.107.120.166]:46599 "EHLO mx.svc.vniiem.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751217AbaADJxW (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Sat, 4 Jan 2014 04:53:22 -0500
Received: from localhost (localhost [127.0.0.1])
	by mx.svc.vniiem.ru (Postfix) with ESMTP id 9EF338105E
	for <linux-can@vger.kernel.org>; Sat,  4 Jan 2014 13:53:42 +0400 (MSK)
Received: from mx.svc.vniiem.ru ([127.0.0.1])
	by localhost (mx.svc.vniiem.ru [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T6Hycq5Z1tfH for <linux-can@vger.kernel.org>;
	Sat,  4 Jan 2014 13:53:42 +0400 (MSK)
Received: from debian-toshiba.localnet (ip-081-085-064-178.pools.atnet.ru [178.64.85.81])
	by mx.svc.vniiem.ru (Postfix) with ESMTPSA id E61BA80F67
	for <linux-can@vger.kernel.org>; Sat,  4 Jan 2014 13:53:40 +0400 (MSK)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

This patch adds support for Elcus CAN200PCI card.

Signed-off-by: Oleg Moroz <oleg.moroz@mcc.vniiem.ru>

---

Updates in v2: 
- fixed the issue with non-UNIX line ending.

diff --git a/drivers/net/can/sja1000/plx_pci.c b/drivers/net/can/sja1000/plx_pci.c
index f9b4f81..aa301ec 100644
--- a/drivers/net/can/sja1000/plx_pci.c
+++ b/drivers/net/can/sja1000/plx_pci.c
@@ -45,7 +45,8 @@ MODULE_SUPPORTED_DEVICE("Adlink PCI-7841/cPCI-7841, "
 			"esd CAN-PCI/PMC/266, "
 			"esd CAN-PCIe/2000, "
 			"Connect Tech Inc. CANpro/104-Plus Opto (CRG001), "
-			"IXXAT PC-I 04/PCI")
+			"IXXAT PC-I 04/PCI, "
+			"ELCUS CAN-200-PCI")
 MODULE_LICENSE("GPL v2");
 
 #define PLX_PCI_MAX_CHAN 2
@@ -123,6 +124,11 @@ struct plx_pci_card {
 #define ESD_PCI_SUB_SYS_ID_PCIE2000	0x0200
 #define ESD_PCI_SUB_SYS_ID_PCI104200	0x0501
 
+#define CAN200PCI_DEVICE_ID		0x9030
+#define CAN200PCI_VENDOR_ID		0x10b5
+#define CAN200PCI_SUB_DEVICE_ID		0x0301
+#define CAN200PCI_SUB_VENDOR_ID		0xe1c5
+
 #define IXXAT_PCI_VENDOR_ID		0x10b5
 #define IXXAT_PCI_DEVICE_ID		0x9050
 #define IXXAT_PCI_SUB_SYS_ID		0x2540
@@ -234,6 +240,14 @@ static struct plx_pci_card_info plx_pci_card_info_cti = {
 	/* based on PLX9030 */
 };
 
+static struct plx_pci_card_info plx_pci_card_info_elcus = {
+	"Eclus CAN-200-PCI", 2,
+	PLX_PCI_CAN_CLOCK, PLX_PCI_OCR, PLX_PCI_CDR,
+	{1, 0x00, 0x00}, { {2, 0x00, 0x80}, {3, 0x00, 0x80} },
+	&plx_pci_reset_common
+	/* based on PLX9030 */
+};
+
 static DEFINE_PCI_DEVICE_TABLE(plx_pci_tbl) = {
 	{
 		/* Adlink PCI-7841/cPCI-7841 */
@@ -319,6 +333,13 @@ static DEFINE_PCI_DEVICE_TABLE(plx_pci_tbl) = {
 		0, 0,
 		(kernel_ulong_t)&plx_pci_card_info_cti
 	},
+	{
+		/* Elcus CAN-200-PCI */
+		CAN200PCI_VENDOR_ID, CAN200PCI_DEVICE_ID,
+		CAN200PCI_SUB_VENDOR_ID, CAN200PCI_SUB_DEVICE_ID,
+		0, 0,
+		(kernel_ulong_t)&plx_pci_card_info_elcus
+	},
 	{ 0,}
 };
 MODULE_DEVICE_TABLE(pci, plx_pci_tbl);

