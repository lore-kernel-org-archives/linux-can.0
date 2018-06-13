From: Mark Jonas <mark.jonas@de.bosch.com>
Subject: [PATCH v2 3/5] char: implement companion-char driver
Date: Wed, 13 Jun 2018 16:37:19 +0200
Message-ID: <1528900641-18677-4-git-send-email-mark.jonas@de.bosch.com>
References: <1528224240-30786-1-git-send-email-mark.jonas@de.bosch.com>
 <1528900641-18677-1-git-send-email-mark.jonas@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1528900641-18677-1-git-send-email-mark.jonas@de.bosch.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, hs@denx.de, yi.zhu5@cn.bosch.com, petar.petrovic2@de.bosch.com, stephan.baetge@de.bosch.com, andy.shevchenko@gmail.com, socketcan@hartkopp.net, o.rempel@pengutronix.de, Mark Jonas <mark.jonas@de.bosch.com>
List-Id: linux-can.vger.kernel.org

From: Zhu Yi <yi.zhu5@cn.bosch.com>

The upper level companion-char driver provides character device
interface to userspace for communicate IO messages with the
companion processor.

Signed-off-by: Zhu Yi <yi.zhu5@cn.bosch.com>
Signed-off-by: Mark Jonas <mark.jonas@de.bosch.com>
---
 drivers/char/Kconfig     |   7 +
 drivers/char/Makefile    |   3 +
 drivers/char/companion.c | 360 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 370 insertions(+)
 create mode 100644 drivers/char/companion.c

diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index c28dca0..e878d56 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -588,5 +588,12 @@ config TILE_SROM
 
 source "drivers/char/xillybus/Kconfig"
 
+config COMPANION_CHAR
+	tristate "Character device for companion communication (Bosch)"
+	depends on COMPANION_SPI
+	help
+	  The character device allows the userspace to exchange IO messages
+	  with the Bosch companion processor via the companion SPI driver.
+
 endmenu
 
diff --git a/drivers/char/Makefile b/drivers/char/Makefile
index 7dc3abe..0dae572 100644
--- a/drivers/char/Makefile
+++ b/drivers/char/Makefile
@@ -60,3 +60,6 @@ js-rtc-y = rtc.o
 obj-$(CONFIG_TILE_SROM)		+= tile-srom.o
 obj-$(CONFIG_XILLYBUS)		+= xillybus/
 obj-$(CONFIG_POWERNV_OP_PANEL)	+= powernv-op-panel.o
+
+obj-$(CONFIG_COMPANION_CHAR)	+= companion-char.o
+companion-char-objs := companion.o
diff --git a/drivers/char/companion.c b/drivers/char/companion.c
new file mode 100644
index 0000000..2e26f01
--- /dev/null
+++ b/drivers/char/companion.c
@@ -0,0 +1,360 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Companion upper level character device
+ *
+ * Copyright (C) 2015-2018 Bosch Sicherheitssysteme GmbH
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/cdev.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/poll.h>
+#include <linux/companion.h>
+
+#define DRIVER_NAME "companion-char"
+
+static struct class *companion_char_class;
+static dev_t         devt;
+
+/**
+ * struct companion_char_minor - companion-char minor structure
+ * @dev:       address of the associated device
+ * @writelock: mutex to protect write
+ * @readlock:  mutex to protect read
+ * @writewait: wait queue head of write
+ * @readwait:  wait queue head of read
+ */
+struct companion_char_minor {
+	struct device    *dev;
+	struct mutex      writelock;
+	struct mutex      readlock;
+	wait_queue_head_t writewait;
+	wait_queue_head_t readwait;
+};
+
+/**
+ * struct companion_char_priv - companion-char private data structure
+ * @cdev:   char device
+ * @parent: address of the associated parent device
+ * @minors: address of the companion-char minor
+ */
+struct companion_char_priv {
+	struct cdev                  cdev;
+	struct device               *parent;
+	struct companion_char_minor *minors;
+};
+
+/**
+ * companion_char_read() - read callback
+ * @filp:   address of the associated virtual file
+ * @buf:    address of the user space buffer to receive
+ * @count:  number of bytes to read
+ * @offset: address of the read offset
+ */
+static ssize_t companion_char_read(struct file *filp,
+				   char __user *buf,
+				   size_t       count,
+				   loff_t      *offset)
+{
+	unsigned int                 number = MINOR(file_inode(filp)->i_rdev);
+	struct companion_char_priv  *priv   = filp->private_data;
+	struct companion_char_minor *minor  = &priv->minors[number];
+	int                          err;
+
+	if (count != COMPANION_PACKET_SIZE)
+		return -EMSGSIZE;
+
+	if (mutex_lock_interruptible(&minor->readlock))
+		return -ERESTARTSYS;
+
+	while (companion_io_rxq_is_empty(priv->parent)) {
+		mutex_unlock(&minor->readlock);
+		if (filp->f_flags & O_NONBLOCK)
+			return -EAGAIN;
+		if (wait_event_interruptible(minor->readwait,
+				!companion_io_rxq_is_empty(priv->parent)))
+			return -ERESTARTSYS;
+		if (mutex_lock_interruptible(&minor->readlock))
+			return -ERESTARTSYS;
+	}
+
+	err = companion_do_io_rx(priv->parent, buf, count);
+	mutex_unlock(&minor->readlock);
+	return err;
+}
+
+/**
+ * companion_char_write() - write callback
+ * @filp:   address of the associated virtual file
+ * @buf:    address of the user space buffer to transfer
+ * @count:  number of bytes to write
+ * @offset: address of the write offset
+ */
+static ssize_t companion_char_write(struct file       *filp,
+				    const char __user *buf,
+				    size_t             count,
+				    loff_t            *offset)
+{
+	unsigned int                 number = MINOR(file_inode(filp)->i_rdev);
+	struct companion_char_priv  *priv   = filp->private_data;
+	struct companion_char_minor *minor  = &priv->minors[number];
+	int                          err;
+
+	if (count != COMPANION_PACKET_SIZE)
+		return -EMSGSIZE;
+
+	if (mutex_lock_interruptible(&minor->writelock))
+		return -ERESTARTSYS;
+
+	while (companion_io_txq_is_full(priv->parent)) {
+		mutex_unlock(&minor->writelock);
+		if (filp->f_flags & O_NONBLOCK)
+			return -EAGAIN;
+		if (wait_event_interruptible(minor->writewait,
+				!companion_io_txq_is_full(priv->parent)))
+			return -ERESTARTSYS;
+		if (mutex_lock_interruptible(&minor->writelock))
+			return -ERESTARTSYS;
+	}
+
+	err = companion_do_io_tx(priv->parent, buf, count);
+	mutex_unlock(&minor->writelock);
+	return err;
+}
+
+/**
+ * companion_char_poll() - poll callback
+ * @filp: address of the associated virtual file
+ * @wait: address of the associated poll table
+ */
+static unsigned int companion_char_poll(struct file *filp, poll_table *wait)
+{
+	unsigned int                 number = MINOR(file_inode(filp)->i_rdev);
+	struct companion_char_priv  *priv   = filp->private_data;
+	struct companion_char_minor *minor  = &priv->minors[number];
+	unsigned int                 mask   = 0;
+
+	poll_wait(filp, &minor->writewait, wait);
+	poll_wait(filp, &minor->readwait,  wait);
+
+	mutex_lock(&minor->writelock);
+	if (!companion_io_txq_is_full(priv->parent))
+		mask |= POLLOUT | POLLWRNORM;
+	mutex_unlock(&minor->writelock);
+
+	mutex_lock(&minor->readlock);
+	if (!companion_io_rxq_is_empty(priv->parent))
+		mask |= POLLIN | POLLRDNORM;
+	mutex_unlock(&minor->readlock);
+
+	return mask;
+}
+
+/**
+ * companion_char_open() - open callback
+ * @inode: address of the associated inode
+ * @filp:  address of the associated virtual file
+ */
+static int companion_char_open(struct inode *inode, struct file *filp)
+{
+	struct companion_char_priv *priv = container_of(
+						inode->i_cdev,
+						struct companion_char_priv,
+						cdev);
+
+	filp->private_data = priv;
+	nonseekable_open(inode, filp);
+	return 0;
+}
+
+/**
+ * companion_char_release() - release callback
+ * @inode: address of the associated inode
+ * @filp:  address of the associated virtual file
+ */
+static int companion_char_release(struct inode *inode, struct file *filp)
+{
+	filp->private_data = NULL;
+	return 0;
+}
+
+static const struct file_operations companion_char_ops = {
+	.owner   = THIS_MODULE,
+	.llseek  = no_llseek,
+	.read    = companion_char_read,
+	.write   = companion_char_write,
+	.poll    = companion_char_poll,
+	.open    = companion_char_open,
+	.release = companion_char_release,
+};
+
+/**
+ * companion_char_on_tx_done() - tx done callback
+ * @data: address of user supplied callback data
+ */
+static void companion_char_on_tx_done(void *data)
+{
+	struct companion_char_priv  *priv = data;
+	struct companion_char_minor *minor = &priv->minors[0];
+
+	wake_up_interruptible(&minor->writewait);
+}
+
+/**
+ * companion_char_on_rx_done() - rx done callback
+ * @data: address of user supplied callback data
+ */
+static void companion_char_on_rx_done(void *data)
+{
+	struct companion_char_priv  *priv  = data;
+	struct companion_char_minor *minor = &priv->minors[0];
+
+	wake_up_interruptible(&minor->readwait);
+}
+
+static struct companion_io_ops companion_char_io_ops = {
+	.on_tx_done = companion_char_on_tx_done,
+	.on_rx_done = companion_char_on_rx_done,
+};
+
+/**
+ * companion_char_probe() - probe callback
+ * @pdev: address of the platform device
+ */
+static int companion_char_probe(struct platform_device *pdev)
+{
+	struct companion_char_priv  *priv;
+	struct companion_char_minor *minors;
+	int                          err;
+
+	if (!pdev->dev.parent) {
+		dev_err(&pdev->dev, "no parent device found\n");
+		return -ENODEV;
+	}
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+	priv->parent = pdev->dev.parent;
+
+	minors = devm_kzalloc(&pdev->dev, sizeof(*minors), GFP_KERNEL);
+	if (!minors)
+		return -ENOMEM;
+
+	minors->dev = device_create(companion_char_class,
+				    &pdev->dev,
+				    MKDEV(MAJOR(devt), 0),
+				    priv,
+				    "companion%d",
+				    0);
+	if (IS_ERR_OR_NULL(minors->dev))
+		return PTR_ERR_OR_ZERO(minors->dev);
+	priv->minors = minors;
+
+	mutex_init(&minors->writelock);
+	mutex_init(&minors->readlock);
+	init_waitqueue_head(&minors->writewait);
+	init_waitqueue_head(&minors->readwait);
+
+	cdev_init(&priv->cdev, &companion_char_ops);
+	err = cdev_add(&priv->cdev, MKDEV(MAJOR(devt), 0), 1);
+	if (err) {
+		dev_err(&pdev->dev, "cdev_add() failed: %d\n", err);
+		goto on_error;
+	}
+
+	dev_set_drvdata(&pdev->dev, priv);
+
+	err = companion_io_ops_register(priv->parent,
+					&companion_char_io_ops,
+					priv);
+	if (err) {
+		dev_err(&pdev->dev, "companion_io_ops_register() failed: %d\n",
+			err);
+		goto on_error;
+	}
+	return 0;
+
+on_error:
+	device_destroy(companion_char_class, MKDEV(MAJOR(devt), 0));
+	cdev_del(&priv->cdev);
+	return err;
+}
+
+/**
+ * companion_char_remove() - remove callback
+ * @pdev: address of the platform device
+ */
+static int companion_char_remove(struct platform_device *pdev)
+{
+	struct companion_char_priv *priv = dev_get_drvdata(&pdev->dev);
+
+	companion_io_ops_unregister(priv->parent);
+	device_destroy(companion_char_class, MKDEV(MAJOR(devt), 0));
+	cdev_del(&priv->cdev);
+	return 0;
+}
+
+static const struct of_device_id companion_char_of_match[] = {
+	{ .compatible = "bosch,companion-char", .data = NULL, },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, companion_char_of_match);
+
+static struct platform_driver companion_char_driver = {
+	.driver = {
+		.name           = DRIVER_NAME,
+		.of_match_table = of_match_ptr(companion_char_of_match),
+	},
+	.probe  = companion_char_probe,
+	.remove = companion_char_remove,
+};
+
+/**
+ * companion_char_init() - module init
+ */
+static int __init companion_char_init(void)
+{
+	int err;
+
+	companion_char_class = class_create(THIS_MODULE, DRIVER_NAME);
+	if (IS_ERR_OR_NULL(companion_char_class))
+		return PTR_ERR_OR_ZERO(companion_char_class);
+
+	err = alloc_chrdev_region(&devt, 0, 1, DRIVER_NAME);
+	if (err) {
+		class_destroy(companion_char_class);
+		return err;
+	}
+
+	err = platform_driver_register(&companion_char_driver);
+	if (err) {
+		class_destroy(companion_char_class);
+		unregister_chrdev_region(devt, 1);
+	}
+
+	return err;
+}
+
+/**
+ * companion_char_exit() - module exit
+ */
+static void __exit companion_char_exit(void)
+{
+	platform_driver_unregister(&companion_char_driver);
+	class_destroy(companion_char_class);
+	unregister_chrdev_region(devt, 1);
+}
+
+module_init(companion_char_init);
+module_exit(companion_char_exit);
+
+MODULE_AUTHOR("Zhu Yi <yi.zhu5@cn.bosch.com>");
+MODULE_DESCRIPTION("Companion upper level character device");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4
