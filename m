From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5/9] can: peak/pci: fix potential bug when probe() fails
Date: Fri,  1 Dec 2017 15:17:35 +0100
Message-ID: <20171201141739.5816-6-mkl@pengutronix.de>
References: <20171201141739.5816-1-mkl@pengutronix.de>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20171201141739.5816-1-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Stephane Grosjean <s.grosjean@peak-system.com>, linux-stable <stable@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: Stephane Grosjean <s.grosjean@peak-system.com>

PCI/PCIe drivers for PEAK-System CAN/CAN-FD interfaces do some access to the
PCI config during probing. In case one of these accesses fails, a POSITIVE
PCIBIOS_xxx error code is returned back. This POSITIVE error code MUST be
converted into a NEGATIVE errno for the probe() function to indicate it
failed. Using the pcibios_err_to_errno() function, we make sure that the
return code will always be negative.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
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
2.15.0
