From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH] can: peak/pci: fix potential bug when probe() fails
Date: Thu, 23 Nov 2017 15:44:35 +0100
Message-ID: <20171123144435.12282-1-s.grosjean@peak-system.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp4-g21.free.fr ([212.27.42.4]:48506 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751934AbdKWOqj (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 23 Nov 2017 09:46:39 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>, Stephane Grosjean <s.grosjean@peak-system.com>

PCI/PCIe drivers for PEAK-System CAN/CAN-FD interfaces do some access to the
PCI config during probing. In case one of these accesses fails, a POSITIVE
PCIBIOS_xxx error code is returned back. This POSITIVE error code MUST be
converted into a NEGATIVE errno for the probe() function to indicate it
failed. Using the pcibios_err_to_errno() function, we make sure that the
return code will always be negative.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
---
 drivers/net/can/peak_canfd/peak_pciefd_main.c | 5 ++++-
 drivers/net/can/sja1000/peak_pci.c            | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/peak_canfd/peak_pciefd_main.c b/drivers/net/can/peak_canfd/peak_pciefd_main.c
index b4efd711f824..788c3464a3b0 100644
--- a/drivers/net/can/peak_canfd/peak_pciefd_main.c
+++ b/drivers/net/can/peak_canfd/peak_pciefd_main.c
@@ -825,7 +825,10 @@ static int peak_pciefd_probe(struct pci_dev *pdev,
 err_disable_pci:
 	pci_disable_device(pdev);
 
-	return err;
+	/* pci_xxx_config_word() return positive PCIBIOS_xxx error codes while
+	 * the probe() function must return a negative errno in case of failure
+	 * (err is unchanged if negative) */
+	return pcibios_err_to_errno(err);
 }
 
 /* free the board structure object, as well as its resources: */
diff --git a/drivers/net/can/sja1000/peak_pci.c b/drivers/net/can/sja1000/peak_pci.c
index 131026fbc2d7..5adc95c922ee 100644
--- a/drivers/net/can/sja1000/peak_pci.c
+++ b/drivers/net/can/sja1000/peak_pci.c
@@ -717,7 +717,10 @@ static int peak_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 failure_disable_pci:
 	pci_disable_device(pdev);
 
-	return err;
+	/* pci_xxx_config_word() return positive PCIBIOS_xxx error codes while
+	 * the probe() function must return a negative errno in case of failure
+	 * (err is unchanged if negative) */
+	return pcibios_err_to_errno(err);
 }
 
 static void peak_pci_remove(struct pci_dev *pdev)
-- 
2.14.1

