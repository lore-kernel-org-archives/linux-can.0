From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH] can: peak_pci: add unused device id. in devices table
Date: Wed, 30 Sep 2015 12:42:35 +0200
Message-ID: <1443609755-29854-1-git-send-email-s.grosjean@peak-system.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp01.smtpout.orange.fr ([80.12.242.123]:39062 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754493AbbI3Kmy (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 30 Sep 2015 06:42:54 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can Mailing List <linux-can@vger.kernel.org>
Cc: Stephane Grosjean <s.grosjean@peak-system.com>

While new PEAK_PCIE_OEM_ID has been defined since 3.17, no corresponding
entry has been added in the peak_pci_tbl[] of the peak_pci CAN driver.

This patch enables now users of the PCAN-PCI Express OEM card to run the
peak_pci driver too.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
---
 drivers/net/can/sja1000/peak_pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/sja1000/peak_pci.c b/drivers/net/can/sja1000/peak_pci.c
index e5fac36..131026f 100644
--- a/drivers/net/can/sja1000/peak_pci.c
+++ b/drivers/net/can/sja1000/peak_pci.c
@@ -87,6 +87,7 @@ static const struct pci_device_id peak_pci_tbl[] = {
 	{PEAK_PCI_VENDOR_ID, PEAK_PC_104P_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
 	{PEAK_PCI_VENDOR_ID, PEAK_PCI_104E_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
 	{PEAK_PCI_VENDOR_ID, PEAK_CPCI_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
+	{PEAK_PCI_VENDOR_ID, PEAK_PCIE_OEM_ID, PCI_ANY_ID, PCI_ANY_ID,},
 #ifdef CONFIG_CAN_PEAK_PCIEC
 	{PEAK_PCI_VENDOR_ID, PEAK_PCIEC_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
 	{PEAK_PCI_VENDOR_ID, PEAK_PCIEC34_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
-- 
1.9.1

