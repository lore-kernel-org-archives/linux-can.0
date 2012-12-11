From: Wolfgang Grandegger <wg@grandegger.com>
Subject: [RFC v3 7/7] c_can_pci: add support for PCH CAN on Intel EG20T PCH
Date: Tue, 11 Dec 2012 22:18:54 +0100
Message-ID: <1355260735-18994-8-git-send-email-wg@grandegger.com>
References: <1355260735-18994-1-git-send-email-wg@grandegger.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:59255 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754582Ab2LKVTR (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 11 Dec 2012 16:19:17 -0500
In-Reply-To: <1355260735-18994-1-git-send-email-wg@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Alexander.Stein@systec-electronic.com, Christian.Bendele@gmx.net, Michael Pellegrini <mikep86@gmail.com>, bhupesh.sharma@st.com, Wolfgang Grandegger <wg@grandegger.com>

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 drivers/net/can/c_can/c_can_pci.c |   45 +++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/net/can/c_can/c_can_pci.c b/drivers/net/can/c_can/c_can_pci.c
index 98562c2..c078a05 100644
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
+	/* Callback for reset */
+	void (*init) (const struct c_can_priv *priv, bool enable);
 };
 
 /*
@@ -65,6 +71,29 @@ static void c_can_pci_write_reg_aligned_to_32bit(struct c_can_priv *priv,
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
@@ -147,11 +176,17 @@ static int c_can_pci_probe(struct pci_dev *pdev,
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
 
+	priv->init = c_can_pci_data->init;
+
 	ret = register_c_can_dev(dev);
 	if (ret) {
 		dev_err(&pdev->dev, "registering %s failed (err=%d)\n",
@@ -203,6 +238,14 @@ static struct c_can_pci_data c_can_sta2x11= {
 	.bar = 0,
 };
 
+static struct c_can_pci_data c_can_pch = {
+	.type = BOSCH_C_CAN,
+	.reg_align = C_CAN_REG_32,
+	.freq = 50000000, /* 50 MHz */
+	.init = c_can_pci_reset_pch,
+	.bar = 1,
+};
+
 #define C_CAN_ID(_vend, _dev, _driverdata) {		\
 	PCI_DEVICE(_vend, _dev),			\
 	.driver_data = (unsigned long)&_driverdata,	\
@@ -210,6 +253,8 @@ static struct c_can_pci_data c_can_sta2x11= {
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

