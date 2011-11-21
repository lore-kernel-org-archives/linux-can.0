From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [RFC PATCH] plx_pci: add Advantech PCI-1680 & UNO-2052 support
Date: Mon, 21 Nov 2011 21:34:44 +0100
Message-ID: <4ECAB5E4.6010903@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:51539 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753430Ab1KUUfD (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 21 Nov 2011 15:35:03 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Frank Rysanek <rysanek@fccps.cz>, Pavel Cheblakov <P.B.Cheblakov@inp.nsk.su>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Wolfgang Grandegger <wg@grandegger.com>

Add Advantech PCI-1680 & UNO-2052 support for the SJA1000 plx_pci driver.

Signed-off-by: Frank Rysanek <rysanek@fccps.cz>

---

Hello Frank,

i found your patch to support the Advantech PCI-1680 & UNO-2052 cards here:

	http://www.fccps.cz/download/adv/frr/can-notes.html

Are you fine with posting the changes on the netdev mailing list to become
part of the mainline Linux kernel?

PLEASE REVIEW: You added an mdelay(100) in plx_pci_check_sja1000() ...

Are you sure this long delay is needed in plx_pci_check_sja1000() or should
we better add a shorter mdelay(10) at the end of plx_pci_reset_common() ??

Are you sure your setup is not working without the added mdelay(100) ?

Thanks for your patch,
Oliver

diff --git a/drivers/net/can/sja1000/Kconfig b/drivers/net/can/sja1000/Kconfig
index fe9e64d..70e416c 100644
--- a/drivers/net/can/sja1000/Kconfig
+++ b/drivers/net/can/sja1000/Kconfig
@@ -72,6 +72,7 @@ config CAN_PLX_PCI
 	   - esd CAN-PCIe/2000
 	   - Marathon CAN-bus-PCI card (http://www.marathon.ru/)
 	   - TEWS TECHNOLOGIES TPMC810 card (http://www.tews.com/)
+	   - Advantech PCI-1680 and UNO-2052 (http://www.advantech.com)
 
 config CAN_TSCAN1
 	tristate "TS-CAN1 PC104 boards"
diff --git a/drivers/net/can/sja1000/plx_pci.c b/drivers/net/can/sja1000/plx_pci.c
index c7f3d4e..6ea73ef 100644
--- a/drivers/net/can/sja1000/plx_pci.c
+++ b/drivers/net/can/sja1000/plx_pci.c
@@ -43,7 +43,8 @@ MODULE_SUPPORTED_DEVICE("Adlink PCI-7841/cPCI-7841, "
 			"TEWS TECHNOLOGIES TPMC810, "
 			"esd CAN-PCI/CPCI/PCI104/200, "
 			"esd CAN-PCI/PMC/266, "
-			"esd CAN-PCIe/2000")
+			"esd CAN-PCIe/2000, "
+			"Advantech PCI-1680 & UNO-2052");
 MODULE_LICENSE("GPL v2");
 
 #define PLX_PCI_MAX_CHAN 2
@@ -126,6 +127,10 @@ struct plx_pci_card {
 #define TEWS_PCI_VENDOR_ID		0x1498
 #define TEWS_PCI_DEVICE_ID_TMPC810	0x032A
 
+#define ADVANTECH_PCI_VENDOR_ID		0x13FE
+#define ADVANTECH_PCI1680_DEVICE_ID	0x1680
+#define ADVANTECH_UNO2052_DEVICE_ID	0x2052
+
 static void plx_pci_reset_common(struct pci_dev *pdev);
 static void plx_pci_reset_marathon(struct pci_dev *pdev);
 static void plx9056_pci_reset_common(struct pci_dev *pdev);
@@ -209,6 +214,22 @@ static struct plx_pci_card_info plx_pci_card_info_tews __devinitdata = {
 	/* based on PLX9030 */
 };
 
+static struct plx_pci_card_info plx_pci_card_info_pci1680 __devinitdata = {
+	"Advantech PCI-1680", 2,
+	PLX_PCI_CAN_CLOCK, PLX_PCI_OCR, PLX_PCI_CDR,
+	{0, 0x00, 0x00}, { {2, 0x00, 0x80}, {3, 0x00, 0x80} },
+	&plx_pci_reset_common
+	/* based on PLX PCI9030 */
+};
+
+static struct plx_pci_card_info plx_pci_card_info_uno2052 __devinitdata = {
+	"Advantech UNO-2052", 2,
+	PLX_PCI_CAN_CLOCK, PLX_PCI_OCR, PLX_PCI_CDR,
+	{0, 0x00, 0x00}, { {2, 0x00, 0x80}, {3, 0x00, 0x80} },
+	&plx_pci_reset_common
+	/* based on PLX PCI9052 */
+};
+
 static DEFINE_PCI_DEVICE_TABLE(plx_pci_tbl) = {
 	{
 		/* Adlink PCI-7841/cPCI-7841 */
@@ -280,6 +301,20 @@ static DEFINE_PCI_DEVICE_TABLE(plx_pci_tbl) = {
 		0, 0,
 		(kernel_ulong_t)&plx_pci_card_info_tews
 	},
+	{
+		/* Advantech PCI-1680 */
+		ADVANTECH_PCI_VENDOR_ID, ADVANTECH_PCI1680_DEVICE_ID,
+		ADVANTECH_PCI_VENDOR_ID, PCI_ANY_ID,
+		0, 0,
+		(kernel_ulong_t)&plx_pci_card_info_pci1680
+	},
+	{
+		/* Advantech UNO-2052 */
+		ADVANTECH_PCI_VENDOR_ID, ADVANTECH_UNO2052_DEVICE_ID,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		(kernel_ulong_t)&plx_pci_card_info_uno2052
+	},
 	{ 0,}
 };
 MODULE_DEVICE_TABLE(pci, plx_pci_tbl);
@@ -303,6 +338,9 @@ static inline int plx_pci_check_sja1000(const struct sja1000_priv *priv)
 {
 	int flag = 0;
 
+	/* settle the SJA1000 from PLX chip reset */
+	mdelay(100);
+
 	/*
 	 * Check registers after hardware reset (the Basic mode)
 	 * See states on p. 10 of the Datasheet.
