From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: pch_can: Data transmission stops after dropped packet
Date: Sun, 18 Nov 2012 23:22:57 +0100
Message-ID: <50A95FC1.3050907@grandegger.com>
References: <loom.20121114T160521-534@post.gmane.org> <50A4972A.9070707@hartkopp.net> <50A4EA87.9020206@grandegger.com> <loom.20121115T171319-854@post.gmane.org> <50A55C65.2020003@grandegger.com> <loom.20121115T222748-977@post.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040802080000000404010305"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:32806 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752528Ab2KRWXC (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 18 Nov 2012 17:23:02 -0500
In-Reply-To: <loom.20121115T222748-977@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michael Pellegrini <mikep86@gmail.com>
Cc: linux-can@vger.kernel.org

This is a multi-part message in MIME format.
--------------040802080000000404010305
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 11/15/2012 10:34 PM, Michael Pellegrini wrote:
> Wolfgang Grandegger <wg <at> grandegger.com> writes:
> 
>> I need to check first if this driver can be supported with little effort.
> 
> Thank you for your consideration.

For simple out-of-tree build I have now extracted the most recent
version of c_can and c_can_pci driver files, backported it to v3.2 and
added the PCH related code.

You should be able to build these drivers on your system as shown below:

  $ tar xf c-can-pci-v1.tar.bz2
  $ cd c-can-pci-v1
  $ CONFIG_CAN_C_CAN_PCI=m \
    make -C /usr/src/linux-headers-`uname -r` SUBDIRS=`pwd` modules

This requires that you have the kernel header, gcc and fiends installed
on your system.

Then you can load the modules as shown below, after unloading the
original C_CAN modules:

  $ sudo modprobe can_dev
  $ rmmod c_can
  $ rmmod c_can_pci
  $ sudo insmod c_can.ko
  $ sudo insmod c_can_pci.ko

Hope it works as expected. 

Below is the patch I used for this driver:

From 562bbd0840e710d45ee211a0f99e5a5288dff4ba Mon Sep 17 00:00:00 2001
From: Wolfgang Grandegger <wg@grandegger.com>
Date: Sun, 18 Nov 2012 23:14:04 +0100
Subject: [PATCH] c_can_pci: first hack to get out-of-tree C_CAN_PCI driver to
 work

---
 c_can.c     |    3 +++
 c_can.h     |    1 +
 c_can_pci.c |   45 ++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/c_can.c b/c_can.c
index e5180df..23fbcd3 100644
--- a/c_can.c
+++ b/c_can.c
@@ -1106,6 +1106,9 @@ static int c_can_open(struct net_device *dev)
 		goto exit_irq_fail;
 	}
 
+	if (priv->reset)
+		priv->reset(priv);
+
 	napi_enable(&priv->napi);
 
 	/* start the c_can controller */
diff --git a/c_can.h b/c_can.h
index e5ed41d..4bad1d4 100644
--- a/c_can.h
+++ b/c_can.h
@@ -161,6 +161,7 @@ struct c_can_priv {
 	int last_status;
 	u16 (*read_reg) (struct c_can_priv *priv, enum reg index);
 	void (*write_reg) (struct c_can_priv *priv, enum reg index, u16 val);
+	void (*reset) (struct c_can_priv *priv);
 	void __iomem *base;
 	const u16 *regs;
 	unsigned long irq_flags; /* for request_irq() */
diff --git a/c_can_pci.c b/c_can_pci.c
index f8bcd73..017d008 100644
--- a/c_can_pci.c
+++ b/c_can_pci.c
@@ -21,12 +21,17 @@
 #include "c_can.h"
 
 #ifndef PCI_DEVICE_ID_STMICRO_CAN
-#define PCI_DEVICE_ID_STMICRO_CAN 0xCC11
+#define PCI_DEVICE_ID_STMICRO_CAN	0xCC11
 #endif
+#ifndef PCI_DEVICE_ID_PCH_CAN
+#define PCI_DEVICE_ID_PCH_CAN	0x8818
+#endif
+#define PCH_PCI_SOFT_RESET	0x01fc
 
 enum c_can_pci_reg_align {
 	C_CAN_REG_ALIGN_16,
 	C_CAN_REG_ALIGN_32,
+	C_CAN_REG_32,
 };
 
 struct c_can_pci_data {
@@ -36,6 +41,8 @@ struct c_can_pci_data {
 	enum c_can_pci_reg_align reg_align;
 	/* Set the frequency */
 	unsigned int freq;
+	/* CAN reset callback */
+	void (*reset) (struct c_can_priv *priv);
 };
 
 /*
@@ -68,6 +75,27 @@ static void c_can_pci_write_reg_aligned_to_32bit(struct c_can_priv *priv,
 	writew(val, priv->base + 2 * priv->regs[index]);
 }
 
+static u16 c_can_pci_read_reg_32bit(struct c_can_priv *priv,
+				    enum reg index)
+{
+	return ioread32(priv->base + 4 * priv->regs[index]);
+}
+
+static void c_can_pci_write_reg_32bit(struct c_can_priv *priv,
+				      enum reg index, u16 val)
+{
+	iowrite32(val, priv->base + 4 * priv->regs[index]);
+}
+
+static void c_can_pci_reset_pch(struct c_can_priv *priv)
+{
+	u32 __iomem *addr = (u32 __iomem *)(priv->regs + PCH_PCI_SOFT_RESET);
+
+	/* write to sw reset register */
+	iowrite32(1, addr);
+	iowrite32(0, addr);
+}
+
 static int __devinit c_can_pci_probe(struct pci_dev *pdev,
 				     const struct pci_device_id *ent)
 {
@@ -147,11 +175,17 @@ static int __devinit c_can_pci_probe(struct pci_dev *pdev,
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
@@ -202,6 +236,13 @@ static struct c_can_pci_data c_can_sta2x11= {
 	.freq = 52000000, /* 52 Mhz */
 };
 
+static struct c_can_pci_data c_can_pch = {
+	.type = BOSCH_C_CAN,
+	.reg_align = C_CAN_REG_32,
+	.freq = 50000000, /* 50 MHz */
+	.reset = c_can_pci_reset_pch,
+};
+
 #define C_CAN_ID(_vend, _dev, _driverdata) {		\
 	PCI_DEVICE(_vend, _dev),			\
 	.driver_data = (unsigned long)&_driverdata,	\
@@ -209,6 +250,8 @@ static struct c_can_pci_data c_can_sta2x11= {
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

Wolfgang.

--------------040802080000000404010305
Content-Type: application/x-bzip;
 name="c-can-pci-v1.tar.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="c-can-pci-v1.tar.bz2"

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
--------------040802080000000404010305--
