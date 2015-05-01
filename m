From: =?UTF-8?B?QW5kcmVhcyBHcsO2Z2Vy?= <andreas24groeger@gmail.com>
Subject: [PATCH] can: janz-ican3: add support for CAL/CANopen firmware
Date: Fri, 01 May 2015 20:31:56 +0200
Message-ID: <5543C69C.5060508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:34853 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751169AbbEAScA (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 1 May 2015 14:32:00 -0400
Received: by wgyo15 with SMTP id o15so97634898wgy.2
        for <linux-can@vger.kernel.org>; Fri, 01 May 2015 11:31:58 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: iws@ovro.caltech.edu

Hello all,

in our department we are using some older Janz ICAN3-modules in our dekstop pcs. There we have slightly different carrier boards than the janz-cmodio supported in the kernel sources, called CAN-PCI2 with two submodules. But the pci configuration regions are identical. So extending the supported pci devices to the corresponding device ids is sufficient to get the drivers working. Great.

I have two minor issues:
* The old ICAN3-modules with firmware 1.28 need more then 250ms for the restart after reset. I've increased the timeout to 500ms.
* The janz_ican3 module uses the raw can services of the Janz-firmware, this means firmware must be ICANOS/2. Our ICAN3-modules are equipped with CAL/CANopen-firmware, so I must use the appropriate commands for the layer management services.
My proposal: the driver detects the firmware after module reset and selects the commands matching the firmware. This affects the bus on/off-command (ican3_set_bus_state) and the configuration of the bittiming (ican3_set_bittiming). For better diagnostics the detected firmware string is presented as sysfs attribute (fwinfo). 

Currently my system works great. Are there any possibilities to get my changes into the linux kernel? Here are my changes based on a linux-3.19.6 vanilla kernel. Is this the right place for my request, is there any maintainer I can ask? I would be grateful for any help.

Kind regards
Andreas

---
 drivers/mfd/janz-cmodio.c    |    4 +
 drivers/net/can/janz-ican3.c |   97 +++++++++++++++++++++++++++++++++++--------
 2 files changed, 84 insertions(+), 17 deletions(-)

diff -uNr -X linux-3.19.me/Documentation/dontdiff linux-3.19.6/drivers/mfd/janz-cmodio.c linux-3.19.me/drivers/mfd/janz-cmodio.c
--- linux-3.19.6/drivers/mfd/janz-cmodio.c	2015-04-29 10:30:26.000000000 +0200
+++ linux-3.19.me/drivers/mfd/janz-cmodio.c	2015-04-30 19:24:44.729193534 +0200
@@ -267,6 +267,10 @@
 static const struct pci_device_id cmodio_pci_ids[] = {
 	{ PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9030, PCI_VENDOR_ID_JANZ, 0x0101 },
 	{ PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9050, PCI_VENDOR_ID_JANZ, 0x0100 },
+	{ PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9030, PCI_VENDOR_ID_JANZ, 0x0201 },
+	{ PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9030, PCI_VENDOR_ID_JANZ, 0x0202 },
+	{ PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9050, PCI_VENDOR_ID_JANZ, 0x0201 },
+	{ PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9050, PCI_VENDOR_ID_JANZ, 0x0202 },
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, cmodio_pci_ids);
diff -uNr -X linux-3.19.me/Documentation/dontdiff linux-3.19.6/drivers/net/can/janz-ican3.c linux-3.19.me/drivers/net/can/janz-ican3.c
--- linux-3.19.6/drivers/net/can/janz-ican3.c	2015-04-29 10:30:26.000000000 +0200
+++ linux-3.19.me/drivers/net/can/janz-ican3.c	2015-04-30 19:54:20.223146411 +0200
@@ -83,6 +83,7 @@
 #define MSG_COFFREQ		0x42
 #define MSG_CONREQ		0x43
 #define MSG_CCONFREQ		0x47
+#define MSG_LMTS		0xb4
 
 /*
  * Janz ICAN3 CAN Inquiry Message Types
@@ -215,6 +216,10 @@
 	struct completion buserror_comp;
 	struct can_berr_counter bec;
 
+	/* firmware type: 0=ICANOS, 1=CAN/CALopen */
+	unsigned int fwtype;
+	char fwinfo[0x20];
+
 	/* old and new style host interface */
 	unsigned int iftype;
 
@@ -270,6 +275,26 @@
 }
 
 /*
+ * This routine was stolen from drivers/net/can/sja1000/sja1000.c
+ *
+ * The bittiming register command for the ICAN3 just sets the bit timing
+ * registers on the SJA1000 chip directly
+ */
+static inline void ican3_calc_bittiming(struct ican3_dev *mod, u8 *btr0, u8 *btr1)
+{
+	struct can_bittiming *bt = &mod->can.bittiming;
+
+	if (!btr0 || !btr1)
+		return;
+
+	*btr0 = ((bt->brp - 1) & 0x3f) | (((bt->sjw - 1) & 0x3) << 6);
+	*btr1 = ((bt->prop_seg + bt->phase_seg1 - 1) & 0xf) |
+		(((bt->phase_seg2 - 1) & 0x7) << 4);
+	if (mod->can.ctrlmode & CAN_CTRLMODE_3_SAMPLES)
+		*btr1 |= 0x80;
+}
+
+/*
  * ICAN3 "old-style" host interface
  */
 
@@ -751,12 +776,37 @@
 static int ican3_set_bus_state(struct ican3_dev *mod, bool on)
 {
 	struct ican3_msg msg;
+	u8 btr0, btr1;
 
 	memset(&msg, 0, sizeof(msg));
-	msg.spec = on ? MSG_CONREQ : MSG_COFFREQ;
-	msg.len = cpu_to_le16(0);
 
-	return ican3_send_msg(mod, &msg);
+	/* raw CAN firmware */
+	if (mod->fwtype == 0) {
+		msg.spec = on ? MSG_CONREQ : MSG_COFFREQ;
+		msg.len = cpu_to_le16(0);
+
+		return ican3_send_msg(mod, &msg);
+	}
+
+	/* CAL firmware */
+	if (mod->fwtype == 1) {
+		msg.spec = MSG_LMTS;
+		if (on) {
+			ican3_calc_bittiming(mod, &btr0, &btr1);
+			msg.len = cpu_to_le16(4);
+			msg.data[0] = 0;
+			msg.data[1] = 0;
+			msg.data[2] = btr0;
+			msg.data[3] = btr1;
+		} else {
+			msg.len = cpu_to_le16(2);
+			msg.data[0] = 1;
+			msg.data[1] = 0;
+		}
+
+		return ican3_send_msg(mod, &msg);
+	}
+	return -ENOTSUPP;
 }
 
 static int ican3_set_termination(struct ican3_dev *mod, bool on)
@@ -1401,7 +1451,7 @@
 			return 0;
 
 		msleep(10);
-	} while (time_before(jiffies, start + HZ / 4));
+	} while (time_before(jiffies, start + HZ / 2));
 
 	netdev_err(mod->ndev, "failed to reset CAN module\n");
 	return -ETIMEDOUT;
@@ -1426,6 +1476,15 @@
 		return ret;
 	}
 
+	/* detect firmware */
+	memcpy_fromio(mod->fwinfo, mod->dpm + 0x60, sizeof(mod->fwinfo) - 1);
+	if (strncmp(mod->fwinfo, "JANZ-ICAN3", 10)) {
+		netdev_err(mod->ndev, "ICAN3 not detected (found %s)\n", mod->fwinfo);
+		return -ENODEV;
+	}
+	if (strstr(mod->fwinfo, "CAL/CANopen"))
+		mod->fwtype = 1;
+
 	/* re-enable interrupts so we can send messages */
 	iowrite8(1 << mod->num, &mod->ctrl->int_enable);
 
@@ -1614,24 +1673,17 @@
 	.brp_inc = 1,
 };
 
-/*
- * This routine was stolen from drivers/net/can/sja1000/sja1000.c
- *
- * The bittiming register command for the ICAN3 just sets the bit timing
- * registers on the SJA1000 chip directly
- */
 static int ican3_set_bittiming(struct net_device *ndev)
 {
 	struct ican3_dev *mod = netdev_priv(ndev);
-	struct can_bittiming *bt = &mod->can.bittiming;
 	struct ican3_msg msg;
 	u8 btr0, btr1;
 
-	btr0 = ((bt->brp - 1) & 0x3f) | (((bt->sjw - 1) & 0x3) << 6);
-	btr1 = ((bt->prop_seg + bt->phase_seg1 - 1) & 0xf) |
-		(((bt->phase_seg2 - 1) & 0x7) << 4);
-	if (mod->can.ctrlmode & CAN_CTRLMODE_3_SAMPLES)
-		btr1 |= 0x80;
+	/* with CAL firmware bittiming is set in ican3_set_bus_state  */
+	if (mod->fwtype == 1)
+		return 0;
+
+	ican3_calc_bittiming(mod, &btr0, &btr1);
 
 	memset(&msg, 0, sizeof(msg));
 	msg.spec = MSG_CBTRREQ;
@@ -1731,11 +1783,22 @@
 	return count;
 }
 
+static ssize_t ican3_sysfs_show_fwinfo(struct device *dev,
+				       struct device_attribute *attr,
+				       char *buf)
+{
+	struct ican3_dev *mod = netdev_priv(to_net_dev(dev));
+
+	return scnprintf(buf, PAGE_SIZE, "%s\n", mod->fwinfo);
+}
+
 static DEVICE_ATTR(termination, S_IWUSR | S_IRUGO, ican3_sysfs_show_term,
 						   ican3_sysfs_set_term);
+static DEVICE_ATTR(fwinfo, S_IRUSR | S_IRUGO, ican3_sysfs_show_fwinfo, NULL);
 
 static struct attribute *ican3_sysfs_attrs[] = {
 	&dev_attr_termination.attr,
+	&dev_attr_fwinfo.attr,
 	NULL,
 };
 
@@ -1867,7 +1930,7 @@
 		goto out_free_irq;
 	}
 
-	dev_info(dev, "module %d: registered CAN device\n", pdata->modno);
+	netdev_info(mod->ndev, "module %d: registered CAN device\n", pdata->modno);
 	return 0;
 
 out_free_irq:
