From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: [PATCH v2] c_can: Add support for eg20t (pch_can)
Date: Mon,  7 Apr 2014 08:52:03 +0200
Message-ID: <1396853523-14941-1-git-send-email-alexander.stein@systec-electronic.com>
References: <"<533DB663.3030408@hartkopp.net>">
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:50915 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750863AbaDGGxa (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 7 Apr 2014 02:53:30 -0400
In-Reply-To: <"<533DB663.3030408@hartkopp.net>">
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>, Thomas Gleixner <tglx@linutronix.de>, Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
This is the correct version of this patch I use.
It has no spinlock which is not needed, AFAICT.

 drivers/net/can/c_can/c_can_pci.c | 50 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/c_can/c_can_pci.c b/drivers/net/can/c_can/c_can_pci.c
index bce0be5..128788c 100644
--- a/drivers/net/can/c_can/c_can_pci.c
+++ b/drivers/net/can/c_can/c_can_pci.c
@@ -19,9 +19,13 @@
 
 #include "c_can.h"
 
+#define PCI_DEVICE_ID_PCH_CAN	0x8818
+#define PCH_PCI_SOFT_RESET	0x01fc
+
 enum c_can_pci_reg_align {
 	C_CAN_REG_ALIGN_16,
 	C_CAN_REG_ALIGN_32,
+	C_CAN_REG_32,
 };
 
 struct c_can_pci_data {
@@ -31,6 +35,10 @@ struct c_can_pci_data {
 	enum c_can_pci_reg_align reg_align;
 	/* Set the frequency */
 	unsigned int freq;
+	/* PCI bar number */
+	int bar;
+	/* Callback for reset */
+	void (*init)(const struct c_can_priv *priv, bool enable);
 };
 
 /*
@@ -63,6 +71,29 @@ static void c_can_pci_write_reg_aligned_to_32bit(struct c_can_priv *priv,
 	writew(val, priv->base + 2 * priv->regs[index]);
 }
 
+static u16 c_can_pci_read_reg_32bit(struct c_can_priv *priv,
+				    enum reg index)
+{
+	return (u16)ioread32(priv->base + 2 * priv->regs[index]);
+}
+
+static void c_can_pci_write_reg_32bit(struct c_can_priv *priv,
+				      enum reg index, u16 val)
+{
+	iowrite32((u32)val, priv->base + 2 * priv->regs[index]);
+}
+
+static void c_can_pci_reset_pch(const struct c_can_priv *priv, bool enable)
+{
+	if (enable) {
+		u32 __iomem *addr = priv->base + PCH_PCI_SOFT_RESET;
+
+		/* write to sw reset register */
+		iowrite32(1, addr);
+		iowrite32(0, addr);
+	}
+}
+
 static int c_can_pci_probe(struct pci_dev *pdev,
 			   const struct pci_device_id *ent)
 {
@@ -87,7 +118,7 @@ static int c_can_pci_probe(struct pci_dev *pdev,
 	pci_set_master(pdev);
 	pci_enable_msi(pdev);
 
-	addr = pci_iomap(pdev, 0, pci_resource_len(pdev, 0));
+	addr = pci_iomap(pdev, c_can_pci_data->bar, pci_resource_len(pdev, 0));
 	if (!addr) {
 		dev_err(&pdev->dev,
 			"device has no PCI memory resources, "
@@ -142,11 +173,17 @@ static int c_can_pci_probe(struct pci_dev *pdev,
 		priv->read_reg = c_can_pci_read_reg_aligned_to_16bit;
 		priv->write_reg = c_can_pci_write_reg_aligned_to_16bit;
 		break;
+	case C_CAN_REG_32:
+		priv->read_reg = c_can_pci_read_reg_32bit;
+		priv->write_reg = c_can_pci_write_reg_32bit;
+		break;
 	default:
 		ret = -EINVAL;
 		goto out_free_c_can;
 	}
 
+	priv->raminit = c_can_pci_data->init;
+
 	ret = register_c_can_dev(dev);
 	if (ret) {
 		dev_err(&pdev->dev, "registering %s failed (err=%d)\n",
@@ -193,6 +230,15 @@ static struct c_can_pci_data c_can_sta2x11= {
 	.type = BOSCH_C_CAN,
 	.reg_align = C_CAN_REG_ALIGN_32,
 	.freq = 52000000, /* 52 Mhz */
+	.bar = 0,
+};
+
+static struct c_can_pci_data c_can_pch = {
+	.type = BOSCH_C_CAN,
+	.reg_align = C_CAN_REG_32,
+	.freq = 50000000, /* 50 MHz */
+	.init = c_can_pci_reset_pch,
+	.bar = 1,
 };
 
 #define C_CAN_ID(_vend, _dev, _driverdata) {		\
@@ -202,6 +248,8 @@ static struct c_can_pci_data c_can_sta2x11= {
 static DEFINE_PCI_DEVICE_TABLE(c_can_pci_tbl) = {
 	C_CAN_ID(PCI_VENDOR_ID_STMICRO, PCI_DEVICE_ID_STMICRO_CAN,
 		 c_can_sta2x11),
+	C_CAN_ID(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PCH_CAN,
+		 c_can_pch),
 	{},
 };
 static struct pci_driver c_can_pci_driver = {
-- 
1.8.3.2

