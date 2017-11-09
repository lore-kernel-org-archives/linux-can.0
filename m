From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH] can: peak: Add support for new PCIe/M2 CAN FD interfaces
Date: Thu,  9 Nov 2017 14:42:14 +0100
Message-ID: <20171109134214.29503-1-s.grosjean@peak-system.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp3-g21.free.fr ([212.27.42.3]:18668 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754264AbdKINmj (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 9 Nov 2017 08:42:39 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>, Stephane Grosjean <s.grosjean@peak-system.com>

This adds support for the following PEAK-System CAN FD interfaces:

PCAN-cPCIe FD         CAN FD Interface for cPCI Serial (2 or 4 channels)
PCAN-PCIe/104-Express CAN FD Interface for PCIe/104-Express (1, 2 or 4 ch.)
PCAN-miniPCIe FD      CAN FD Interface for PCIe Mini (1, 2 or 4 channels)
PCAN-PCIe FD OEM      CAN FD Interface for PCIe OEM version (1, 2 or 4 ch.)
PCAN-M.2              CAN FD Interface for M.2 (1 or 2 channels)

Like the PCAN-PCIe FD interface, all of these boards run the same IP Core
that is able to handle CAN FD (see also http://www.peak-system.com).

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
---
 drivers/net/can/peak_canfd/peak_pciefd_main.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/peak_canfd/peak_pciefd_main.c b/drivers/net/can/peak_canfd/peak_pciefd_main.c
index 51c2d182a33a..b4efd711f824 100644
--- a/drivers/net/can/peak_canfd/peak_pciefd_main.c
+++ b/drivers/net/can/peak_canfd/peak_pciefd_main.c
@@ -29,14 +29,19 @@
 #include "peak_canfd_user.h"
 
 MODULE_AUTHOR("Stephane Grosjean <s.grosjean@peak-system.com>");
-MODULE_DESCRIPTION("Socket-CAN driver for PEAK PCAN PCIe FD family cards");
-MODULE_SUPPORTED_DEVICE("PEAK PCAN PCIe FD CAN cards");
+MODULE_DESCRIPTION("Socket-CAN driver for PEAK PCAN PCIe/M.2 FD family cards");
+MODULE_SUPPORTED_DEVICE("PEAK PCAN PCIe/M.2 FD CAN cards");
 MODULE_LICENSE("GPL v2");
 
 #define PCIEFD_DRV_NAME		"peak_pciefd"
 
 #define PEAK_PCI_VENDOR_ID	0x001c	/* The PCI device and vendor IDs */
 #define PEAK_PCIEFD_ID		0x0013	/* for PCIe slot cards */
+#define PCAN_CPCIEFD_ID		0x0014	/* for Compact-PCI Serial slot cards */
+#define PCAN_PCIE104FD_ID	0x0017	/* for PCIe-104 Express slot cards */
+#define PCAN_MINIPCIEFD_ID      0x0018	/* for mini-PCIe slot cards */
+#define PCAN_PCIEFD_OEM_ID      0x0019	/* for PCIe slot OEM cards */
+#define PCAN_M2_ID		0x001a	/* for M2 slot cards */
 
 /* PEAK PCIe board access description */
 #define PCIEFD_BAR0_SIZE		(64 * 1024)
@@ -203,6 +208,11 @@ struct pciefd_board {
 /* supported device ids. */
 static const struct pci_device_id peak_pciefd_tbl[] = {
 	{PEAK_PCI_VENDOR_ID, PEAK_PCIEFD_ID, PCI_ANY_ID, PCI_ANY_ID,},
+	{PEAK_PCI_VENDOR_ID, PCAN_CPCIEFD_ID, PCI_ANY_ID, PCI_ANY_ID,},
+	{PEAK_PCI_VENDOR_ID, PCAN_PCIE104FD_ID, PCI_ANY_ID, PCI_ANY_ID,},
+	{PEAK_PCI_VENDOR_ID, PCAN_MINIPCIEFD_ID, PCI_ANY_ID, PCI_ANY_ID,},
+	{PEAK_PCI_VENDOR_ID, PCAN_PCIEFD_OEM_ID, PCI_ANY_ID, PCI_ANY_ID,},
+	{PEAK_PCI_VENDOR_ID, PCAN_M2_ID, PCI_ANY_ID, PCI_ANY_ID,},
 	{0,}
 };
 
-- 
2.14.1

