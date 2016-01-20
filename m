From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH] can/peak_pci: fix FPGA potential frame loss issue
Date: Wed, 20 Jan 2016 12:15:32 +0100
Message-ID: <1453288532-15034-1-git-send-email-s.grosjean@peak-system.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:17141 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934160AbcATLQp (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 20 Jan 2016 06:16:45 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can Mailing List <linux-can@vger.kernel.org>
Cc: Stephane Grosjean <s.grosjean@peak-system.com>

This patch installs a workaround when the driver detects one of the
following PEAK-System CAN interfaces, running a firmware < v1.3.0:

PCAN-PCI Express 1/2/4 CAN; DeviceID 0x0003
PCAN-PCI/104 Express 1/2/4 CAN; DeviceID 0x0007
PCAN-miniPCIe 1/2 CAN; DeviceID 0x0008
PCAN-PCI Express OEM 1/2/4 CAN; DeviceID 0x0009
PCAN-ExpressCard 34 1 CAN; DeviceID 0x000A

This fixes potential loss of one tx frame in Linux SMP when some other
task does another Command Register write (e.g. Release Receive Buffer)
in between the triggering Tx Request and the next Sample Point.

This workaround is useless thus *NOT* installed when the firmware
has been upgraded to v1.3.0 or higher, nor if the CAN interface is equipped
with true SJA1000 controller(s).

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
---
 drivers/net/can/sja1000/peak_pci.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/sja1000/peak_pci.c b/drivers/net/can/sja1000/peak_pci.c
index 131026f..84f7d3a 100644
--- a/drivers/net/can/sja1000/peak_pci.c
+++ b/drivers/net/can/sja1000/peak_pci.c
@@ -30,6 +30,15 @@
 
 #include "sja1000.h"
 
+#define VERSION_REG1		0x40
+#define VERSION_REG2		0x44
+
+#define VERSION_REG2_MASK	0xfff0
+#define PCAN_PCI_FW(x, y, z)	((((u16 )(x) & 0xf) << 12) | \
+				 (((u16 )(y) & 0xf) << 8)  | \
+				 ((      (z) & 0xf) << 4))
+#define PCAN_PCI_FW_VER(v)	((v) & VERSION_REG2_MASK)
+
 MODULE_AUTHOR("Stephane Grosjean <s.grosjean@peak-system.com>");
 MODULE_DESCRIPTION("Socket-CAN driver for PEAK PCAN PCI family cards");
 MODULE_SUPPORTED_DEVICE("PEAK PCAN PCI/PCIe/PCIeC miniPCI CAN cards");
@@ -540,6 +549,19 @@ static void peak_pci_write_reg(const struct sja1000_priv *priv,
 	writeb(val, priv->reg_base + (port << 2));
 }
 
+/* This function adds a delay after each access to CMR to workaround potential
+ * loss of frame in SMP Linux for FPGA based boards not upgraded to FW >= 1.3.0.
+ */
+static void peak_pci_write_reg_1_2_x(const struct sja1000_priv *priv,
+				     int port, u8 val)
+{
+	peak_pci_write_reg(priv, port, val);
+
+	/* add a bigger delay */
+	if (port == SJA1000_CMR)
+		udelay(10);
+}
+
 static void peak_pci_post_irq(const struct sja1000_priv *priv)
 {
 	struct peak_pci_chan *chan = priv->priv;
@@ -559,6 +581,7 @@ static int peak_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	void __iomem *cfg_base, *reg_base;
 	u16 sub_sys_id, icr;
 	int i, err, channels;
+	u32 v1, v2 = 0;
 
 	err = pci_enable_device(pdev);
 	if (err)
@@ -612,6 +635,12 @@ static int peak_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* Leave parport mux mode */
 	writeb(0x04, cfg_base + PITA_MISC + 3);
 
+	v1 = readl(cfg_base + VERSION_REG1);
+	if (v1) {
+		/* FPGA card */
+		v2 = readl(cfg_base + VERSION_REG2);
+	}
+
 	icr = readw(cfg_base + PITA_ICR + 2);
 
 	for (i = 0; i < channels; i++) {
@@ -628,7 +657,10 @@ static int peak_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		priv->reg_base = reg_base + i * PEAK_PCI_CHAN_SIZE;
 
 		priv->read_reg = peak_pci_read_reg;
-		priv->write_reg = peak_pci_write_reg;
+		if (v1 && (PCAN_PCI_FW_VER(v2) < PCAN_PCI_FW(1, 3, 0)))
+			priv->write_reg = peak_pci_write_reg_1_2_x;
+		else
+			priv->write_reg = peak_pci_write_reg;
 		priv->post_irq = peak_pci_post_irq;
 
 		priv->can.clock.freq = PEAK_PCI_CAN_CLOCK;
-- 
1.9.1

