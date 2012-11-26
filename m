From: Wolfgang Grandegger <wg@grandegger.com>
Subject: [RFC 6/6] c_can_pci: add support for PCH CAN on Intel EG20T PCH
Date: Mon, 26 Nov 2012 09:23:06 +0100
Message-ID: <1353918186-4234-7-git-send-email-wg@grandegger.com>
References: <1353918186-4234-1-git-send-email-wg@grandegger.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:33894 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754322Ab2KZIXi (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 26 Nov 2012 03:23:38 -0500
In-Reply-To: <1353918186-4234-1-git-send-email-wg@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: bhupesh.sharma@st.com, tomoya.rohm@gmail.com, Wolfgang Grandegger <wg@grandegger.com>

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 drivers/net/can/c_can/c_can_pci.c |   44 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/c_can/c_can_pci.c b/drivers/net/can/c_can/c_can_pci.c
index 320e371..9719656 100644
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
@@ -33,6 +37,8 @@ struct c_can_pci_data {
 	unsigned int freq;
 	/* PCI bar number */
 	int bar;
+	/* CAN reset callback */
+	void (*reset) (struct c_can_priv *priv);
 };
 
 /*
@@ -65,6 +71,27 @@ static void c_can_pci_write_reg_aligned_to_32bit(struct c_can_priv *priv,
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
+static void c_can_pci_reset_pch(struct c_can_priv *priv)
+{
+	u32 __iomem *addr = priv->base + PCH_PCI_SOFT_RESET;
+
+	/* write to sw reset register */
+	iowrite32(1, addr);
+	iowrite32(0, addr);
+}
+
 static int __devinit c_can_pci_probe(struct pci_dev *pdev,
 				     const struct pci_device_id *ent)
 {
@@ -86,7 +113,6 @@ static int __devinit c_can_pci_probe(struct pci_dev *pdev,
 		goto out_disable_device;
 	}
 
-
 	if (!pci_enable_msi(pdev)) {
 		dev_info(&pdev->dev, "MSI enabled\n");
 		pci_set_master(pdev);
@@ -147,11 +173,17 @@ static int __devinit c_can_pci_probe(struct pci_dev *pdev,
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
 
+	priv->reset = c_can_pci_data->reset;
+
 	ret = register_c_can_dev(dev);
 	if (ret) {
 		dev_err(&pdev->dev, "registering %s failed (err=%d)\n",
@@ -203,6 +235,14 @@ static struct c_can_pci_data c_can_sta2x11= {
 	.bar = 0,
 };
 
+static struct c_can_pci_data c_can_pch = {
+	.type = BOSCH_C_CAN,
+	.reg_align = C_CAN_REG_32,
+	.freq = 50000000, /* 50 MHz */
+	.reset = c_can_pci_reset_pch,
+	.bar = 1,
+};
+
 #define C_CAN_ID(_vend, _dev, _driverdata) {		\
 	PCI_DEVICE(_vend, _dev),			\
 	.driver_data = (unsigned long)&_driverdata,	\
@@ -210,6 +250,8 @@ static struct c_can_pci_data c_can_sta2x11= {
 static DEFINE_PCI_DEVICE_TABLE(c_can_pci_tbl) = {
 	C_CAN_ID(PCI_VENDOR_ID_STMICRO, PCI_DEVICE_ID_STMICRO_CAN,
 		 c_can_sta2x11),
+	C_CAN_ID(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PCH_CAN,
+		 c_can_pch),
 	{},
 };
 static struct pci_driver c_can_pci_driver = {
-- 
1.7.9.5

