From: =?UTF-8?B?0J7Qu9C10LMg0JzQvtGA0L7Qtw==?= <oleg.moroz@mcc.vniiem.ru>
Subject: plx_pci.c patch
Date: Mon, 23 Dec 2013 23:10:22 +0400
Message-ID: <52B88A9E.6000008@mcc.vniiem.ru>
References: <52B8878E.5090505@mcc.vniiem.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090301070005030106070401"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mcc.vniiem.ru ([78.107.120.166]:53839 "EHLO mx.svc.vniiem.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752804Ab3LWTMM (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 23 Dec 2013 14:12:12 -0500
Received: from localhost (localhost [127.0.0.1])
	by mx.svc.vniiem.ru (Postfix) with ESMTP id D314C8102F
	for <linux-can@vger.kernel.org>; Mon, 23 Dec 2013 23:12:32 +0400 (MSK)
Received: from mx.svc.vniiem.ru ([127.0.0.1])
	by localhost (mx.svc.vniiem.ru [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cOBpKpofOO7L for <linux-can@vger.kernel.org>;
	Mon, 23 Dec 2013 23:12:26 +0400 (MSK)
Received: from [192.168.2.106] (ip-253-094-064-178.pools.atnet.ru [178.64.94.253])
	by mx.svc.vniiem.ru (Postfix) with ESMTPSA id 7BEC18102D
	for <linux-can@vger.kernel.org>; Mon, 23 Dec 2013 23:12:25 +0400 (MSK)
In-Reply-To: <52B8878E.5090505@mcc.vniiem.ru>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

This is a multi-part message in MIME format.
--------------090301070005030106070401
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Hello. I've added the ELCUS CAN-200-PCI card support into 
sja1000_plx_pci driver. Could you please review my changes and commit it 
to the  Linux kernel repository?


--------------090301070005030106070401
Content-Type: text/x-patch;
 name="plx_pci.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="plx_pci.c.patch"

--- linux-source-3.11/drivers/net/can/sja1000/plx_pci.c.orig	2013-12-19 17:58:06.591790117 +0400
+++ linux-source-3.11/drivers/net/can/sja1000/plx_pci.c	2013-12-19 18:00:34.099862435 +0400
@@ -45,7 +45,8 @@ MODULE_SUPPORTED_DEVICE("Adlink PCI-7841
 			"esd CAN-PCI/PMC/266, "
 			"esd CAN-PCIe/2000, "
 			"Connect Tech Inc. CANpro/104-Plus Opto (CRG001), "
-			"IXXAT PC-I 04/PCI")
+			"IXXAT PC-I 04/PCI, "
+			"ELCUS CAN-200-PCI")
 MODULE_LICENSE("GPL v2");
 
 #define PLX_PCI_MAX_CHAN 2
@@ -123,6 +124,12 @@ struct plx_pci_card {
 #define ESD_PCI_SUB_SYS_ID_PCIE2000	0x0200
 #define ESD_PCI_SUB_SYS_ID_PCI104200	0x0501
 
+#define CAN200PCI_DEVICE_ID		0x9030
+#define CAN200PCI_VENDOR_ID		0x10b5
+#define CAN200PCI_SUB_DEVICE_ID		0x0301
+#define CAN200PCI_SUB_VENDOR_ID		0xe1c5
+
+
 #define IXXAT_PCI_VENDOR_ID		0x10b5
 #define IXXAT_PCI_DEVICE_ID		0x9050
 #define IXXAT_PCI_SUB_SYS_ID		0x2540
@@ -234,6 +241,14 @@ static struct plx_pci_card_info plx_pci_
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
@@ -319,6 +334,13 @@ static DEFINE_PCI_DEVICE_TABLE(plx_pci_t
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
@@ -440,13 +462,14 @@ static void plx_pci_reset_marathon(struc
 	}
 }
 
+
+
 static void plx_pci_del_card(struct pci_dev *pdev)
 {
 	struct plx_pci_card *card = pci_get_drvdata(pdev);
 	struct net_device *dev;
 	struct sja1000_priv *priv;
 	int i = 0;
-
 	for (i = 0; i < PLX_PCI_MAX_CHAN; i++) {
 		dev = card->net_dev[i];
 		if (!dev)


--------------090301070005030106070401--
