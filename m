From: Jimmy Assarsson <jimmyassarsson@gmail.com>
Subject: [PATCH v3 2/2] can: kvaser_usb: Expose EAN and serial number via sysfs
Date: Fri, 16 Feb 2018 14:21:25 +0100
Message-ID: <20180216132125.13232-2-jimmyassarsson@gmail.com>
References: <20180216132125.13232-1-jimmyassarsson@gmail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:42685 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030766AbeBPNV7 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 16 Feb 2018 08:21:59 -0500
Received: by mail-lf0-f66.google.com with SMTP id t204so1366097lff.9
        for <linux-can@vger.kernel.org>; Fri, 16 Feb 2018 05:21:58 -0800 (PST)
In-Reply-To: <20180216132125.13232-1-jimmyassarsson@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>

The EAN (article number) combined with serial number form a unique
identifier for any Kvaser device. This makes it possible to map netdevice
with physical Kvaser device.

Example output for USBcan Light 2xHS:
$ cat /sys/class/net/can0/ean
7330130007147
$ cat /sys/class/net/can0/serial
10659

Tested with the following Kvaser devices:
Leaf Light HS, Leaf Light HS v2, USBcan Light 2xHS, USBcan II,
Memorator Professional HS/HS and Memorator HS/HS.

Signed-off-by: Jimmy Assarsson <jimmyassarsson@gmail.com>
---
Changes in v3:
  - Add sysfs documentation.

Changes in v2:
  - Use u64 for ean, instead of u32 ean[2].
  - Use the existing sysfs_groups[0], from the net_device.

 .../ABI/testing/sysfs-class-net_kvaser_usb         | 15 +++++++++
 drivers/net/can/usb/kvaser_usb.c                   | 38 ++++++++++++++++++++++
 2 files changed, 53 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-net_kvaser_usb

diff --git a/Documentation/ABI/testing/sysfs-class-net_kvaser_usb b/Documentation/ABI/testing/sysfs-class-net_kvaser_usb
new file mode 100644
index 000000000000..922a8cc41e60
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-net_kvaser_usb
@@ -0,0 +1,15 @@
+What:		/sys/class/net/<ifname>/ean
+Date:		February 2018
+Contact:	Jimmy Assarsson <jimmyassarsson@gmail.com>
+KernelVersion:	4.16
+Description:
+		Read-only value representing the article number (EAN) for the
+		Kvaser CAN product.
+
+What:		/sys/class/net/<ifname>/serial
+Date:		February 2018
+Contact:	Jimmy Assarsson <jimmyassarsson@gmail.com>
+KernelVersion:	4.16
+Description:
+		Read-only value representing the serial number for the Kvaser
+		CAN product.
diff --git a/drivers/net/can/usb/kvaser_usb.c b/drivers/net/can/usb/kvaser_usb.c
index 3c17bb3b1588..d3d19a7ff16f 100644
--- a/drivers/net/can/usb/kvaser_usb.c
+++ b/drivers/net/can/usb/kvaser_usb.c
@@ -457,6 +457,8 @@ struct kvaser_usb {
 	 * also used as a sentinel for marking free tx contexts.
 	 */
 	u32 fw_version;
+	u32 serial;
+	u64 ean;
 	unsigned int nchannels;
 	unsigned int max_tx_urbs;
 	enum kvaser_usb_family family;
@@ -692,6 +694,10 @@ static int kvaser_usb_get_card_info(struct kvaser_usb *dev)
 	     dev->nchannels > MAX_USBCAN_NET_DEVICES))
 		return -EINVAL;
 
+	dev->serial = le32_to_cpu(msg.u.cardinfo.serial_number);
+	dev->ean = (u64)(le32_to_cpu(msg.u.cardinfo.ean[1])) << 32 |
+		   le32_to_cpu(msg.u.cardinfo.ean[0]);
+
 	return 0;
 }
 
@@ -1802,6 +1808,37 @@ static const struct can_bittiming_const kvaser_usb_bittiming_const = {
 	.brp_inc = KVASER_USB_BRP_INC,
 };
 
+static ssize_t serial_show(struct device *dev,
+			   struct device_attribute *attr, char *buf)
+{
+	struct kvaser_usb_net_priv *priv = netdev_priv(to_net_dev(dev));
+	struct kvaser_usb *kvaser_dev = priv->dev;
+
+	return sprintf(buf, "%u\n", kvaser_dev->serial);
+}
+
+static ssize_t ean_show(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	struct kvaser_usb_net_priv *priv = netdev_priv(to_net_dev(dev));
+	struct kvaser_usb *kvaser_dev = priv->dev;
+
+	return sprintf(buf, "%llx\n", kvaser_dev->ean);
+}
+
+static DEVICE_ATTR_RO(serial);
+static DEVICE_ATTR_RO(ean);
+
+static struct attribute *kvaser_usb_dev_attrs[] = {
+	&dev_attr_serial.attr,
+	&dev_attr_ean.attr,
+	NULL,
+};
+
+static const struct attribute_group kvaser_usb_dev_group = {
+	.attrs = kvaser_usb_dev_attrs,
+};
+
 static int kvaser_usb_set_bittiming(struct net_device *netdev)
 {
 	struct kvaser_usb_net_priv *priv = netdev_priv(netdev);
@@ -1931,6 +1968,7 @@ static int kvaser_usb_init_one(struct usb_interface *intf,
 	netdev->flags |= IFF_ECHO;
 
 	netdev->netdev_ops = &kvaser_usb_netdev_ops;
+	netdev->sysfs_groups[0] = &kvaser_usb_dev_group;
 
 	SET_NETDEV_DEV(netdev, &intf->dev);
 	netdev->dev_id = channel;
-- 
2.16.1

