From: Thierry Bultel <thierry.bultel@wanadoo.fr>
Subject: Re: [Xenomai] RTDM driver for the Advantech 1680U CANbus Adapter
Date: Wed, 18 Jul 2012 14:39:52 +0200
Message-ID: <5006AE98.7030400@wanadoo.fr>
References: <4FED4948.8080906@basystemes.fr> <4FED4B42.6000808@wanadoo.fr> <4FEDF65A.50401@grandegger.com> <1012208988.15650.1341343674156.JavaMail.www@wwinf1m30> <4FF3562B.7020902@grandegger.com> <50042E37.8040205@wanadoo.fr> <500524A7.3070907@grandegger.com> <5006892D.1020401@wanadoo.fr> <50069BD3.5060905@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.basystemes.fr ([217.167.0.1]:54096 "EHLO
	mail.basystemes.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754327Ab2GRMiD (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 18 Jul 2012 08:38:03 -0400
In-Reply-To: <50069BD3.5060905@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Linux-CAN <linux-can@vger.kernel.org>

Wolfgang

- Fixed all the tabs (vim was my friend), all my indents were based on 4 chars display, thus the strange format and the 80 chars issue
- Added copyright
- Fixed missing, or unwanted empty lines
- Function prototypes fixed to linux code style
- '"' and '*' surrounded with 1 space left and right
- 'default' case fixed; treated as an error
- backslashes removed

checkpatch now only complains about the Signed-off-by stuff; I have also checked with a more recent checkpatch version (3.2.9)
than my 2.6.38.8, it has shown spurious whitespaces, and also one space between function name and parenthesis,
I have fixed those issues as well.

Cheers
Thierry


diff -pruN xenomai-2.6.0-orig/ksrc/drivers/can/sja1000/Kconfig xenomai-2.6.0/ksrc/drivers/can/sja1000/Kconfig
--- xenomai-2.6.0-orig/ksrc/drivers/can/sja1000/Kconfig	2011-10-18 20:17:18.000000000 +0200
+++ xenomai-2.6.0/ksrc/drivers/can/sja1000/Kconfig	2012-07-18 11:46:44.578890869 +0200
@@ -41,6 +41,15 @@ config XENO_DRIVERS_CAN_SJA1000_IXXAT_PC
 	the second channel working, Xenomai's shared interrupt support
 	must be enabled.
 
+config XENO_DRIVERS_CAN_SJA1000_ADV_PCI
+	depends on XENO_DRIVERS_CAN_SJA1000 && PCI
+	tristate "ADVANTECH PCI Card"
+	help
+
+	This driver is for the ADVANTECH PCI cards (1 or more channels)
+	It supports the 1680U and some other ones.
+
+
 config XENO_DRIVERS_CAN_SJA1000_PLX_PCI
 	depends on XENO_DRIVERS_CAN_SJA1000 && PCI
 	tristate "PLX90xx PCI-bridge based Cards"
diff -pruN xenomai-2.6.0-orig/ksrc/drivers/can/sja1000/Makefile xenomai-2.6.0/ksrc/drivers/can/sja1000/Makefile
--- xenomai-2.6.0-orig/ksrc/drivers/can/sja1000/Makefile	2011-10-18 20:17:18.000000000 +0200
+++ xenomai-2.6.0/ksrc/drivers/can/sja1000/Makefile	2012-07-16 14:00:38.682836737 +0200
@@ -9,6 +9,7 @@ obj-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_PE
 obj-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_PEAK_DNG) += xeno_can_peak_dng.o
 obj-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_PLX_PCI) += xeno_can_plx_pci.o
 obj-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_IXXAT_PCI) += xeno_can_ixxat_pci.o
+obj-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_ADV_PCI) += xeno_can_adv_pci.o
 obj-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_EMS_PCI) += xeno_can_ems_pci.o
 obj-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_ESD_PCI) += xeno_can_esd_pci.o
 obj-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_ISA) += xeno_can_isa.o
@@ -19,6 +20,7 @@ xeno_can_peak_pci-y := rtcan_peak_pci.o
 xeno_can_peak_dng-y := rtcan_peak_dng.o
 xeno_can_plx_pci-y := rtcan_plx_pci.o
 xeno_can_ixxat_pci-y := rtcan_ixxat_pci.o
+xeno_can_adv_pci-y := rtcan_adv_pci.o
 xeno_can_ems_pci-y := rtcan_ems_pci.o
 xeno_can_esd_pci-y := rtcan_esd_pci.o
 xeno_can_isa-y := rtcan_isa.o
@@ -35,6 +37,7 @@ obj-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_PE
 obj-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_PEAK_DNG) += xeno_can_peak_dng.o 
 obj-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_PLX_PCI) += xeno_can_plx_pci.o
 obj-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_IXXAT_PCI) += xeno_can_ixxat_pci.o
+obj-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_ADV_PCI) += xeno_can_adv_pci.o
 obj-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_EMS_PCI) += xeno_can_ems_pci.o
 obj-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_ESD_PCI) += xeno_can_esd_pci.o
 obj-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_ISA) += xeno_can_isa.o 
@@ -47,6 +50,7 @@ xeno_can_peak_pci-objs := rtcan_peak_pci
 xeno_can_peak_dng-objs := rtcan_peak_dng.o
 xeno_can_plx_pci-objs := rtcan_plx_pci.o
 xeno_can_ixxat_pci-objs := rtcan_ixxat_pci.o
+xeno_can_adv_pci-objs := rtcan_adv_pci.o
 xeno_can_ems_pci-objs := rtcan_ems_pci.o
 xeno_can_esd_pci-objs := rtcan_esd_pci.o
 xeno_can_isa-objs := rtcan_isa.o
@@ -73,6 +77,9 @@ xeno_can_plx_pci.o: $(xeno_can_plx_pci-o
 xeno_can_ixxat_pci.o: $(xeno_can_ixxat_pci-objs)
 	$(LD) -r -o $@ $(xeno_can_ixxat_pci-objs)
 
+xeno_can_adv_pci.o: $(xeno_can_adv_pci-objs)
+	$(LD) -r -o $@ $(xeno_can_adv_pci-objs)
+
 xeno_can_ems_pci.o: $(xeno_can_ems_pci-objs)
 	$(LD) -r -o $@ $(xeno_can_ems_pci-objs)
 
diff -pruN xenomai-2.6.0-orig/ksrc/drivers/can/sja1000/rtcan_adv_pci.c xenomai-2.6.0/ksrc/drivers/can/sja1000/rtcan_adv_pci.c
--- xenomai-2.6.0-orig/ksrc/drivers/can/sja1000/rtcan_adv_pci.c	1970-01-01 01:00:00.000000000 +0100
+++ xenomai-2.6.0/ksrc/drivers/can/sja1000/rtcan_adv_pci.c	2012-07-18 14:21:46.831088314 +0200
@@ -0,0 +1,347 @@
+/*
+ * Copyright (C) 2006 Wolfgang Grandegger <wg@grandegger.com>
+ *
+ * Copyright (C) 2012 Thierry Bultel <thierry.bultel@basystemes.fr>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software Foundation,
+ * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+
+#include <linux/module.h>
+#include <linux/ioport.h>
+#include <linux/delay.h>
+#include <linux/pci.h>
+#include <linux/io.h>
+
+#include <rtdm/rtdm_driver.h>
+
+#define ADV_PCI_BASE_SIZE	0x80
+
+/* CAN device profile */
+#include <rtdm/rtcan.h>
+#include <rtcan_dev.h>
+#include <rtcan_raw.h>
+#include <rtcan_internal.h>
+#include <rtcan_sja1000.h>
+#include <rtcan_sja1000_regs.h>
+
+#define RTCAN_DEV_NAME "rtcan%d"
+#define RTCAN_DRV_NAME "ADV-PCI-CAN"
+
+static char *adv_pci_board_name = "ADV-PCI";
+
+MODULE_AUTHOR("Thierry Bultel <thierry.bultel@basystemes.fr>");
+MODULE_DESCRIPTION("RTCAN board driver for Advantech PCI cards");
+MODULE_SUPPORTED_DEVICE("ADV-PCI card CAN controller");
+MODULE_LICENSE("GPL");
+
+struct rtcan_adv_pci {
+	struct pci_dev *pci_dev;
+	struct rtcan_device *slave_dev;
+	void __iomem *conf_addr;
+	void __iomem *base_addr;
+};
+
+/*
+ * According to the datasheet,
+ * internal clock is 1/2 of the external oscillator frequency
+ * which is 16 MHz
+ */
+#define ADV_PCI_CAN_CLOCK (16000000 / 2)
+
+/*
+ * Output control register
+  Depends on the board configuration
+ */
+
+#define ADV_PCI_OCR (SJA_OCR_MODE_NORMAL	|\
+		     SJA_OCR_TX0_PUSHPULL	|\
+		     SJA_OCR_TX1_PUSHPULL	|\
+		     SJA_OCR_TX1_INVERT)
+
+/*
+ * In the CDR register, you should set CBP to 1.
+ */
+#define ADV_PCI_CDR (SJA_CDR_CBP | SJA_CDR_CAN_MODE)
+
+#define ADV_PCI_VENDOR_ID 0x13fe
+
+#define CHANNEL_SINGLE 0 /* this is a single channel device */
+#define CHANNEL_MASTER 1 /* multi channel device, this device is master */
+#define CHANNEL_SLAVE  2 /* multi channel device, this is slave */
+
+#define ADV_PCI_DEVICE(device_id)\
+	{ ADV_PCI_VENDOR_ID, device_id, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 }
+
+static DEFINE_PCI_DEVICE_TABLE(adv_pci_tbl) = {
+	ADV_PCI_DEVICE(0x1680),
+	ADV_PCI_DEVICE(0x3680),
+	ADV_PCI_DEVICE(0x2052),
+	ADV_PCI_DEVICE(0x1681),
+	ADV_PCI_DEVICE(0xc001),
+	ADV_PCI_DEVICE(0xc002),
+	ADV_PCI_DEVICE(0xc004),
+	ADV_PCI_DEVICE(0xc101),
+	ADV_PCI_DEVICE(0xc102),
+	ADV_PCI_DEVICE(0xc104),
+	/* required last entry */
+	{ }
+};
+
+MODULE_DEVICE_TABLE(pci, adv_pci_tbl);
+
+static u8 rtcan_adv_pci_read_reg(struct rtcan_device *dev, int port)
+{
+	struct rtcan_adv_pci *board = (struct rtcan_adv_pci *)dev->board_priv;
+	return ioread8(board->base_addr + port);
+}
+
+static void rtcan_adv_pci_write_reg(struct rtcan_device *dev, int port, u8 data)
+{
+	struct rtcan_adv_pci *board = (struct rtcan_adv_pci *)dev->board_priv;
+
+	iowrite8(data, board->base_addr + port);
+}
+
+static void rtcan_adv_pci_del_chan(struct pci_dev *pdev,
+				   struct rtcan_device *dev)
+{
+	struct rtcan_adv_pci *board;
+
+	if (!dev)
+		return;
+
+	board = (struct rtcan_adv_pci *)dev->board_priv;
+
+	rtcan_sja1000_unregister(dev);
+
+	pci_iounmap(pdev, board->base_addr);
+
+	rtcan_dev_free(dev);
+}
+
+
+static int rtcan_adv_pci_add_chan(struct pci_dev *pdev,
+				  int channel,
+				  unsigned int bar,
+				  unsigned int offset,
+				  struct rtcan_device **master_dev)
+{
+	struct rtcan_device *dev;
+	struct rtcan_sja1000 *chip;
+	struct rtcan_adv_pci *board;
+	void __iomem *base_addr;
+	int ret;
+
+	dev = rtcan_dev_alloc(sizeof(struct rtcan_sja1000),
+			      sizeof(struct rtcan_adv_pci));
+	if (dev == NULL)
+		return -ENOMEM;
+
+	chip  = (struct rtcan_sja1000 *)dev->priv;
+	board = (struct rtcan_adv_pci *)dev->board_priv;
+
+	base_addr = pci_iomap(pdev, bar, ADV_PCI_BASE_SIZE) + offset;
+
+	board->pci_dev = pdev;
+	board->conf_addr = NULL;
+	board->base_addr = base_addr;
+
+	if (channel == CHANNEL_SLAVE) {
+		struct rtcan_adv_pci *master_board =
+			(struct rtcan_adv_pci *)(*master_dev)->board_priv;
+		master_board->slave_dev = dev;
+	}
+
+	dev->board_name = adv_pci_board_name;
+
+	chip->read_reg  = rtcan_adv_pci_read_reg;
+	chip->write_reg = rtcan_adv_pci_write_reg;
+
+	/* Clock frequency in Hz */
+	dev->can_sys_clock = ADV_PCI_CAN_CLOCK;
+
+	/* Output control register */
+	chip->ocr = ADV_PCI_OCR;
+
+	/* Clock divider register */
+	chip->cdr = ADV_PCI_CDR;
+
+	strncpy(dev->name, RTCAN_DEV_NAME, IFNAMSIZ);
+
+	/* Make sure SJA1000 is in reset mode */
+	chip->write_reg(dev, SJA_MOD, SJA_MOD_RM);
+	/* Set PeliCAN mode */
+	chip->write_reg(dev, SJA_CDR, SJA_CDR_CAN_MODE);
+
+	/* check if mode is set */
+	ret = chip->read_reg(dev, SJA_CDR);
+	if (ret != SJA_CDR_CAN_MODE)
+		return -EIO;
+
+	/* Register and setup interrupt handling */
+	chip->irq_flags = RTDM_IRQTYPE_SHARED;
+	chip->irq_num = pdev->irq;
+
+	RTCAN_DBG("%s: base_addr=%p conf_addr=%p irq=%d ocr=%#x cdr=%#x\n",
+		   RTCAN_DRV_NAME, board->base_addr, board->conf_addr,
+		   chip->irq_num, chip->ocr, chip->cdr);
+
+	/* Register SJA1000 device */
+	ret = rtcan_sja1000_register(dev);
+	if (ret) {
+		printk(KERN_ERR "ERROR %d while trying to register SJA1000 device!\n",
+		       ret);
+		goto failure;
+	}
+
+	if (channel != CHANNEL_SLAVE)
+		*master_dev = dev;
+
+	return 0;
+
+failure:
+	rtcan_dev_free(dev);
+
+	return ret;
+}
+
+static int __devinit adv_pci_init_one(struct pci_dev *pdev,
+				      const struct pci_device_id *ent)
+{
+	int ret, channel;
+	unsigned int nb_ports = 0;
+	unsigned int bar = 0;
+	unsigned int bar_flag = 0;
+	unsigned int offset = 0;
+	unsigned int ix;
+
+	struct rtcan_device *master_dev = NULL;
+
+	dev_info(&pdev->dev, "RTCAN Registering card");
+
+	ret = pci_enable_device(pdev);
+	if (ret)
+		goto failure;
+
+	dev_info(&pdev->dev, "RTCAN Detected Advantech PCI card at slot #%i\n",
+			 PCI_SLOT(pdev->devfn));
+
+	ret = pci_request_regions(pdev, RTCAN_DRV_NAME);
+	if (ret)
+		goto failure;
+
+	switch (pdev->device) {
+	case 0xc001:
+	case 0xc002:
+	case 0xc004:
+	case 0xc101:
+	case 0xc102:
+	case 0xc104:
+		nb_ports = pdev->device & 0x7;
+		offset = 0x100;
+		bar = 0;
+		break;
+	case 0x1680:
+	case 0x2052:
+		nb_ports = 2;
+		bar = 2;
+		bar_flag = 1;
+		break;
+	case 0x1681:
+		nb_ports = 1;
+		bar = 2;
+		bar_flag = 1;
+		break;
+	default:
+		goto failure_iounmap;
+		break;
+	}
+
+	if (nb_ports > 1)
+		channel = CHANNEL_MASTER;
+	else
+		channel = CHANNEL_SINGLE;
+
+	RTCAN_DBG("%s: Initializing device %04x:%04x:%04x\n",
+		   RTCAN_DRV_NAME,
+		   pdev->vendor,
+		   pdev->device,
+		   pdev->subsystem_device);
+
+	ret = rtcan_adv_pci_add_chan(pdev, channel, bar, offset, &master_dev);
+	if (ret)
+		goto failure_iounmap;
+
+	/* register slave channel, if any	*/
+
+	for (ix = 1; ix < nb_ports; ix++) {
+		ret = rtcan_adv_pci_add_chan(pdev,
+					     CHANNEL_SLAVE,
+					     bar + (bar_flag ? ix : 0),
+					     offset * ix,
+					     &master_dev);
+		if (ret)
+			goto failure_iounmap;
+	}
+
+	pci_set_drvdata(pdev, master_dev);
+
+	return 0;
+
+failure_iounmap:
+
+	if (master_dev)
+		rtcan_adv_pci_del_chan(pdev, master_dev);
+
+	pci_release_regions(pdev);
+
+failure:
+	return ret;
+}
+
+static void __devexit adv_pci_remove_one(struct pci_dev *pdev)
+{
+	struct rtcan_device *dev = pci_get_drvdata(pdev);
+	struct rtcan_adv_pci *board = (struct rtcan_adv_pci *)dev->board_priv;
+
+	if (board->slave_dev)
+		rtcan_adv_pci_del_chan(pdev, board->slave_dev);
+
+	rtcan_adv_pci_del_chan(pdev, dev);
+
+	pci_release_regions(pdev);
+	pci_disable_device(pdev);
+	pci_set_drvdata(pdev, NULL);
+}
+
+static struct pci_driver rtcan_adv_pci_driver = {
+	.name = RTCAN_DRV_NAME,
+	.id_table = adv_pci_tbl,
+	.probe = adv_pci_init_one,
+	.remove = __devexit_p(adv_pci_remove_one),
+};
+
+static int __init rtcan_adv_pci_init(void)
+{
+	return pci_register_driver(&rtcan_adv_pci_driver);
+}
+
+static void __exit rtcan_adv_pci_exit(void)
+{
+	pci_unregister_driver(&rtcan_adv_pci_driver);
+}
+
+module_init(rtcan_adv_pci_init);
+module_exit(rtcan_adv_pci_exit);


