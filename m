Received: from smtpfb2-g21.free.fr (smtpfb2-g21.free.fr [212.27.42.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC264FDE40;
	Wed, 16 Sep 2026 13:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789565601; cv=none; b=kBL14LGsAyEEziXgLo5q3l7R+JJ4HqN29eb97hP5NxnvRyXlua9CI98az18KxfYrlYagA2lqwaOdDTx21LB6mRlkVA6i+Eloh3nFmAQzwScDOI8xoupdSChB4qB5JERVz8kakRDDtCACmCUoNpfYSKlNccFe68XLTpYzawsKPbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789565601; c=relaxed/simple;
	bh=CjUQDMpJhTt2V1204ES+w9pvCjuyUSgWyEb3UrHmvZM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ea4FY+5PQc6PCQeQwX0/+llRNxwHZgLK9oiWdtMYaYClWTjn0pd/A0WpFDFK/Tk+2vmgTNgL6kKnVpwJvNduUlEwcOXNLw7NhOwItqYSNxTIs0AjMzlJvgiHDy/Tgug+fSMS66Q5KSRTQpKwEGt/wKEXeDHJm6S3c524tmn9bbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=vT/de3a+; arc=none smtp.client-ip=212.27.42.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="vT/de3a+"
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id D9CDA42818D;
	Wed, 16 Sep 2026 15:32:55 +0200 (CEST)
Received: from [127.0.1.1] (unknown [IPv6:2a02:8428:60a1:3e01:2ba7:4349:5c56:5541])
	(Authenticated sender: stephane.grosjean@free.fr)
	by smtp4-g21.free.fr (Postfix) with ESMTPSA id 3901519F5C3;
	Wed, 16 Sep 2026 15:32:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1789565568;
	bh=CjUQDMpJhTt2V1204ES+w9pvCjuyUSgWyEb3UrHmvZM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=vT/de3a+16OgcuKix5JXRd3rB/AAd07RPYnA7JPxsx5oPazND7RG+dW8bG2Ols6kT
	 prIz8A5MI8SUBU7LRYereZtRsHgles3A7u/v5rJVx0xYD3fYBB7zvJMjKlykS53zlc
	 R4PAHPenjiUiCzkSXaO6o1ODsDRRhG0p9nFR69sqdzHKZMStiwoV8CgpD2rp4X6+dd
	 68kUz/InOLjX4RAerVupyihei7vR/+pgVFPSpzS8QwwPsvN1kBbzQumcMJP2DtOR/n
	 62lWa98LQu2VAPVFy1HzJ42hXog1iMk7QSBawP+DenRYRQrgCIlqO3nxrc0OsOfda1
	 nx7QVrv/hOmGQ==
From: =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@free.fr>
Date: Wed, 16 Sep 2026 15:31:57 +0200
Subject: [PATCH v2 1/3] can: ixxat_usb: add driver skeleton for IXXAT
 USB-to-CAN adapters
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260916-ixxat_usb_can-v2-1-9b892e362d9e@peak-system.fr>
References: <20260916-ixxat_usb_can-v2-0-9b892e362d9e@peak-system.fr>
In-Reply-To: <20260916-ixxat_usb_can-v2-0-9b892e362d9e@peak-system.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-can@vger.kernel.org, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>
X-Mailer: b4 0.14.3

From: Stéphane Grosjean <s.grosjean@peak-system.fr>

Add the initial skeleton of the ixxat_usb driver: Kconfig, Makefile
and the USB core (probe/disconnect, CAN netdev ops, USB URB handling,
device command channel, ethtool/sysfs glue).

The core is written to be generic over the actual wire protocol used
by the different IXXAT USB-to-CAN adapter families (selected CAN
message format is exposed through ixxat_usb_adapter::cl1_msg_format),
but no device is supported yet: the usb_device_id table is
intentionally left empty. Support for the various adapter families is
added by the following commits in this series.

Signed-off-by: Stéphane Grosjean <s.grosjean@peak-system.fr>
---
 drivers/net/can/usb/Kconfig                    |    8 +
 drivers/net/can/usb/Makefile                   |    1 +
 drivers/net/can/usb/ixxat_usb/Makefile         |    3 +
 drivers/net/can/usb/ixxat_usb/ixxat_usb_core.c | 2468 ++++++++++++++++++++++++
 drivers/net/can/usb/ixxat_usb/ixxat_usb_core.h |  767 ++++++++
 5 files changed, 3247 insertions(+)

diff --git a/drivers/net/can/usb/Kconfig b/drivers/net/can/usb/Kconfig
index cf65a90816b9..6a144fb840a6 100644
--- a/drivers/net/can/usb/Kconfig
+++ b/drivers/net/can/usb/Kconfig
@@ -64,6 +64,14 @@ config CAN_GS_USB
 	  choose Y for built in support,
 	  M to compile as module (module will be named: gs_usb).
 
+config CAN_IXXAT_USB
+	tristate "IXXAT USB-to-CAN interfaces"
+	help
+	  This driver supports both legacy (VendorId=0x08d8) and
+	  current (VendorId=0x08db) IXXAT USB-to-CAN devices that
+	  interface the USB bus with the CAN bus for communication
+	  via CAN 2.0 and/or CAN FD.
+
 config CAN_KVASER_USB
 	tristate "Kvaser CAN/USB interface"
 	select NET_DEVLINK
diff --git a/drivers/net/can/usb/Makefile b/drivers/net/can/usb/Makefile
index fcafb1ac262e..45433c2a3330 100644
--- a/drivers/net/can/usb/Makefile
+++ b/drivers/net/can/usb/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_CAN_ESD_USB) += esd_usb.o
 obj-$(CONFIG_CAN_ETAS_ES58X) += etas_es58x/
 obj-$(CONFIG_CAN_F81604) += f81604.o
 obj-$(CONFIG_CAN_GS_USB) += gs_usb.o
+obj-$(CONFIG_CAN_IXXAT_USB) += ixxat_usb/
 obj-$(CONFIG_CAN_KVASER_USB) += kvaser_usb/
 obj-$(CONFIG_CAN_MCBA_USB) += mcba_usb.o
 obj-$(CONFIG_CAN_NCT6694) += nct6694_canfd.o
diff --git a/drivers/net/can/usb/ixxat_usb/Makefile b/drivers/net/can/usb/ixxat_usb/Makefile
new file mode 100644
index 000000000000..7d87d66d2b6f
--- /dev/null
+++ b/drivers/net/can/usb/ixxat_usb/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_CAN_IXXAT_USB) += ix_usb_can.o
+ix_usb_can-y = ixxat_usb_core.o
diff --git a/drivers/net/can/usb/ixxat_usb/ixxat_usb_core.c b/drivers/net/can/usb/ixxat_usb/ixxat_usb_core.c
new file mode 100644
index 000000000000..3602ff9cc2c1
--- /dev/null
+++ b/drivers/net/can/usb/ixxat_usb/ixxat_usb_core.c
@@ -0,0 +1,2468 @@
+// SPDX-License-Identifier: GPL-2.0
+/* CAN driver for IXXAT USB-to-CAN
+ *
+ * Copyright (C) 2018-2024 HMS Industrial Networks <socketcan@hms-networks.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published
+ * by the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/ethtool.h>
+#include <linux/unaligned.h>
+
+#include "ixxat_usb_core.h"
+
+MODULE_AUTHOR("HMS Technology Center GmbH <socketcan@hms-networks.com>");
+MODULE_DESCRIPTION("SocketCAN driver for HMS Ixxat USB-to-CAN V2, USB-to-CAN-FD family adapters");
+MODULE_LICENSE("GPL");
+
+/* minimum firmware version that supports V2 communication layer */
+#define IX_MIN_MAJORFWVERSION_SUPP_V2	0x01
+#define IX_MIN_MINORFWVERSION_SUPP_V2	0x07
+#define IX_MIN_BUILDFWVERSION_SUPP_V2	0x00
+
+#define IX_FW_VER(a, b, c)	(((a) << 16) + ((b) << 8) + (c))
+#define IX_FW_CL2		IX_FW_VER(IX_MIN_MAJORFWVERSION_SUPP_V2, \
+					  IX_MIN_MINORFWVERSION_SUPP_V2, \
+					  IX_MIN_MINORFWVERSION_SUPP_V2)
+
+/* multiply by 1.000.000.000 to get 1ns resolution */
+#define IX_TICK_FACTOR			1000000000ULL
+
+/* Number of echo skbs */
+#define IXXAT_USB_MAX_MSGS		32
+
+/* Number of attempts to send a USB command before deciding on failure */
+#define IXXAT_USB_MAX_COM_REQ		3
+
+/* Maximum wait time (in ms) for successful USB command transmission */
+#define IXXAT_USB_MSG_TIMEOUT		500
+
+/* Delay waiting for the continuation of a fragmented USB response */
+#define IXXAT_USB_MSG_CYCLE		20
+
+/* Power-up/down mode */
+#define IXXAT_USB_POWER_WAKEUP		0
+#define IXXAT_USB_POWER_SLEEP		1
+
+/* struct ixxat_driver_info IXXAT USB device static information
+ * @name:	commercial name
+ * @adapter:	IXXAT USB adapter family
+ * @is_legacy:	Legacy USB device
+ */
+struct ixxat_driver_info {
+	const char *name;
+	const struct ixxat_usb_adapter *adapter;
+	bool is_legacy;
+};
+
+/* Table of devices that work with this driver
+ *
+ * This table is intentionally left empty: no IXXAT USB adapter family is
+ * supported yet. Support for the various device families is added by
+ * subsequent commits, each of which populates this table with the relevant
+ * struct usb_device_id entries.
+ */
+static const struct usb_device_id ixxat_usb_table[] = {
+	{ } /* Terminating entry */
+};
+
+MODULE_DEVICE_TABLE(usb, ixxat_usb_table);
+
+/* ixxat_usb_dev_name - return the name of the IXXAT USB device
+ * @id: pointer to the USB device ID structure
+ *
+ * This function returns the name of the IXXAT USB device.
+ * It is used to identify the device in logs and user interfaces.
+ *
+ * Returns the name of the device as a string.
+ */
+static const char *ixxat_usb_dev_name(const struct usb_device_id *id)
+{
+	const struct ixxat_driver_info *drv_info =
+		(const struct ixxat_driver_info *)id->driver_info;
+
+	return drv_info->name;
+}
+
+/* ixxat_usb_is_legacy_usb2can - check if device is a legacy USB2CAN device
+ * @id: USB device id
+ *
+ * Returns true if the device is a legacy USB2CAN device.
+ */
+static bool ixxat_usb_is_legacy_usb2can(const struct usb_device_id *id)
+{
+	const struct ixxat_driver_info *drv_info =
+		(const struct ixxat_driver_info *)id->driver_info;
+
+	return drv_info->is_legacy;
+}
+
+/* ixxat_usb_has_cl2_firmware - check if device has CL2 firmware
+ * @id: USB device id
+ * @fwinfo: Firmware info of the device (may be NULL)
+ *
+ * Returns != 0 if the device has CL2 firmware, 0 otherwise.
+ */
+static int ixxat_usb_has_cl2_firmware(const struct usb_device_id *id,
+				      struct ixxat_fw_info2 *fwinfo)
+{
+	if (ixxat_usb_is_legacy_usb2can(id) && fwinfo) {
+		int major = le16_to_cpu(fwinfo->major_version);
+		int minor = le16_to_cpu(fwinfo->minor_version);
+		int build = le16_to_cpu(fwinfo->build_version);
+
+		return IX_FW_VER(major, minor, build) >= IX_FW_CL2;
+	}
+
+	return 0;
+}
+
+/* ixxat_usb_get_adapter - get the IXXAT USB adapter based on the USB device ID
+ * @id: pointer to the USB device ID structure
+ * @dev_fwinfo: pointer to the firmware info structure (optional)
+ *
+ * This function retrieves the appropriate IXXAT USB adapter
+ * based on the USB device ID and the firmware information.
+ *
+ * Returns a pointer to the IXXAT USB adapter structure.
+ */
+static const struct ixxat_usb_adapter *
+	ixxat_usb_get_adapter(const struct usb_device_id *id,
+			      struct ixxat_fw_info2 *dev_fwinfo)
+{
+	const struct ixxat_driver_info *drv_info =
+		(const struct ixxat_driver_info *)id->driver_info;
+
+	return drv_info->adapter;
+}
+
+/* ixxat_usb_firmware_update_needed - check if firmware update is needed
+ * @id: USB device id
+ * @fwinfo: Firmware info of the device
+ *
+ * Returns != 0 if firmware update is needed, 0 otherwise.
+ */
+static int ixxat_usb_firmware_update_needed(const struct usb_device_id *id,
+					    struct ixxat_fw_info2 *fwinfo)
+{
+	/* firmware update is needed for legacy devices with FW < v1.6.0.x */
+	if (ixxat_usb_is_legacy_usb2can(id) && fwinfo) {
+		int major = le16_to_cpu(fwinfo->major_version);
+		int minor = le16_to_cpu(fwinfo->minor_version);
+		int build = le16_to_cpu(fwinfo->build_version);
+
+		return IX_FW_VER(major, minor, build) < IX_FW_VER(1, 6, 0);
+	}
+
+	return 0;
+}
+
+/* ixxat_usb_firmware_update_recommended - check if firmware update is
+ *                                         recommended
+ * @id: USB device id
+ * @fwinfo: Firmware info of the device
+ *
+ * Returns != 0 if firmware update is recommended, 0 otherwise.
+ */
+static int ixxat_usb_firmware_update_recommended(const struct usb_device_id *id,
+						 struct ixxat_fw_info2 *fwinfo)
+{
+	/* firmware update is recommended for devices with cl1 firmware */
+	return (ixxat_usb_is_legacy_usb2can(id)) ?
+		!ixxat_usb_has_cl2_firmware(id, fwinfo) : 0;
+}
+
+/* ixxat_usb_check_firmware - check if a firmware update is necessary or
+ *                            recommended
+ * @intf: pointer to the USB interface
+ * @id: USB device id
+ * @fwinfo: Firmware info of the device
+ *
+ * Returns != 0 if firmware update is needed, 0 otherwise.
+ */
+static int ixxat_usb_check_firmware(struct usb_interface *intf,
+				    const struct usb_device_id *id,
+				    struct ixxat_usb_device_data *devdata)
+{
+	dev_info(&intf->dev, "Firmware version: %d.%d.%d.%d (type: %d)",
+		 le16_to_cpu(devdata->fw_info.major_version),
+		 le16_to_cpu(devdata->fw_info.minor_version),
+		 le16_to_cpu(devdata->fw_info.build_version),
+		 le16_to_cpu(devdata->fw_info.revision),
+		 le32_to_cpu(devdata->fw_info.firmware_type));
+
+	/* check if FW update is needeed */
+	if (ixxat_usb_firmware_update_needed(id, &devdata->fw_info)) {
+		dev_err(&intf->dev,
+			"Current firmware requires update to run\n");
+		return -ENODEV;
+	}
+
+	/* check if FW update is recommended */
+	if (ixxat_usb_firmware_update_recommended(id, &devdata->fw_info))
+		dev_warn(&intf->dev, "Firmware update recommended\n");
+
+	return 0;
+}
+
+/* ixxat_usb_get_tx_context - get a free URB context for transmission
+ * @dev: pointer to the IXXAT USB CAN device
+ *
+ * Returns a pointer to a free URB context or NULL if no context is available.
+ */
+static struct ixxat_tx_urb_context *
+	ixxat_usb_get_tx_context(struct ixxat_usb_candevice *dev)
+{
+	struct ixxat_tx_urb_context *context = NULL;
+	unsigned long flags;
+	int i;
+
+	spin_lock_irqsave(&dev->dev_lock, flags);
+
+	for (i = 0; i < IXXAT_USB_MAX_TX_URBS; i++) {
+		/* is urb allocated and free */
+		if (dev->tx_contexts[i].urb &&
+		    dev->tx_contexts[i].urb_index == IXXAT_USB_FREE_ENTRY) {
+			context = &dev->tx_contexts[i];
+			context->urb_index = i;
+			break;
+		}
+	}
+
+	spin_unlock_irqrestore(&dev->dev_lock, flags);
+
+	return context;
+}
+
+/* ixxat_usb_rel_tx_context - release a URB context
+ * @dev: pointer to the IXXAT USB CAN device
+ * @context: pointer to the URB context to release
+ *
+ * This function releases the URB context by setting its index to
+ * IXXAT_USB_FREE_ENTRY
+ */
+static void ixxat_usb_rel_tx_context(struct ixxat_usb_candevice *dev,
+				     struct ixxat_tx_urb_context *context)
+{
+	if (context) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&dev->dev_lock, flags);
+
+		context->urb_index = IXXAT_USB_FREE_ENTRY;
+
+		spin_unlock_irqrestore(&dev->dev_lock, flags);
+	}
+}
+
+/* ixxat_usb_msg_get_next_idx - get next free message index
+ * @dev: pointer to the IXXAT USB CAN device
+ *
+ * Returns the next free message index or IXXAT_USB_MAX_MSGS
+ * if no free index is available.
+ */
+static u32 ixxat_usb_msg_get_next_idx(struct ixxat_usb_candevice *dev)
+{
+	u32 msg_idx, msg_cnt;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dev->dev_lock, flags);
+
+	msg_idx = (dev->msg_lastindex + 1) % IXXAT_USB_MAX_MSGS;
+
+	for (msg_cnt = 0; msg_cnt < IXXAT_USB_MAX_MSGS; msg_cnt++) {
+		u64 msg_mask = 1ULL << msg_idx;
+
+		if (!(dev->msgs & msg_mask)) {
+			dev->msgs |= msg_mask;
+			dev->msg_lastindex = msg_idx;
+			break;
+		}
+
+		msg_idx = (msg_idx + 1) % IXXAT_USB_MAX_MSGS;
+	}
+
+	spin_unlock_irqrestore(&dev->dev_lock, flags);
+
+	return (msg_cnt < IXXAT_USB_MAX_MSGS) ? msg_idx : IXXAT_USB_MAX_MSGS;
+}
+
+/* ixxat_usb_msg_free_idx - free a message index
+ * @dev: pointer to the IXXAT USB CAN device
+ * @msg_idx: message index to free, if 0xFFFFFFFF all messages are freed
+ */
+static void ixxat_usb_msg_free_idx(struct ixxat_usb_candevice *dev, u32 msg_idx)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&dev->dev_lock, flags);
+
+	if (msg_idx == 0xFFFFFFFF) {
+		dev->msgs = 0;
+		dev->msg_lastindex = 0;
+
+	} else if (msg_idx < IXXAT_USB_MAX_MSGS) {
+		dev->msgs &= ~(1ULL << msg_idx);
+	}
+
+	spin_unlock_irqrestore(&dev->dev_lock, flags);
+}
+
+/* ixxat_usb_setup_cmd - setup a command request and response
+ * @req: pointer to the request structure to setup
+ * @res: pointer to the response structure to setup
+ */
+void ixxat_usb_setup_cmd(struct ixxat_usb_dal_req *req,
+			 struct ixxat_usb_dal_res *res)
+{
+	req->size = cpu_to_le32(sizeof(*req));
+	req->port = cpu_to_le16(IXXAT_USB_BRD_PORT);
+	req->socket = cpu_to_le16(IXXAT_USB_BRD_SOCKET);
+	req->code = cpu_to_le32(0);
+
+	res->res_size = cpu_to_le32(sizeof(*res));
+	res->ret_size = cpu_to_le32(0);
+	res->code = cpu_to_le32(0xffffffff);
+}
+
+/* ixxat_usb_send_cmd_internal - send a command to the IXXAT USB device
+ * @dev: pointer to the USB device
+ * @devdata: pointer to the IXXAT USB device data
+ * @port: port number to send the command to
+ * @cmd: pointer to the entire command buffer to send,
+ *       - starting with a struct ixxat_usb_dal_req object,
+ *       - ending with a struct ixxat_usb_dal_res object
+ * @cmd_size: size of the whole command (>= sizeof(struct ixxat_usb_dal_cmd))
+ * @res: pointer to the response structure
+ * @res_size: size of the response structure (>= sizeof(struct ixxat_usb_dal_res)
+ * @cmd_delay: delay in milliseconds to wait for a response
+ *
+ * This function sends a command to the IXXAT USB device and waits for the
+ * response. It retries the command up to IXXAT_USB_MAX_COM_REQ times if the
+ * command fails to be sent or the response is not received.
+ *
+ * This is an internal function that is called by ixxat_usb_send_cmd, which
+ * is the public interface for sending commands to the IXXAT USB device.
+ * The main reason for having this internal function is to allow sending commands
+ * from contexts that do not have access to the IXXAT USB CAN device structure,
+ * such as the USB probe function, where only the USB device and
+ * device data are available.
+ *
+ * Returns >= 0 on success, negative error code on failure.
+ */
+static int ixxat_usb_send_cmd_internal(struct usb_device *dev,
+				       struct ixxat_usb_device_data *devdata,
+				       const u16 port,
+				       struct ixxat_usb_dal_req *cmd,
+				       u16 cmd_size,
+				       struct ixxat_usb_dal_res *res,
+				       u16 res_size,
+				       const unsigned long cmd_delay)
+{
+	u8 *req_buf = (u8 *)devdata->cmdbuf;
+	u8 *res_buf = req_buf + cmd_size - sizeof(*res);
+	int i, ret, pos = 0, to;
+	unsigned long timeout;
+
+	ret = mutex_lock_interruptible(&devdata->cmd_channel_lock);
+	if (ret < 0) {
+		dev_err(&dev->dev, KBUILD_MODNAME
+			": Error %x: Mutex lock interrupted\n", ret);
+		return ret;
+	}
+
+	/* copy request to command buffer */
+	memcpy(req_buf, cmd, cmd_size);
+
+	/* Send the command */
+	to = IXXAT_USB_MSG_TIMEOUT;
+	for (i = 0; i < IXXAT_USB_MAX_COM_REQ; i++) {
+		ret = usb_control_msg(dev, usb_sndctrlpipe(dev, 0), 0xff,
+				      USB_TYPE_VENDOR | USB_DIR_OUT,
+				      port, 0, req_buf, cmd_size, to);
+		if (ret >= 0)
+			break;
+
+		/* Retry on timeout, log other errors */
+		if (ret == -ETIMEDOUT) {
+			/* timeout too short, loop again but wait longer */
+			to += IXXAT_USB_MSG_TIMEOUT;
+			continue;
+		}
+
+		/* All other errors are fatal ones */
+		dev_err(&dev->dev, KBUILD_MODNAME
+			": Error %d while sending TX request after %d tries\n",
+			ret, i);
+
+		break;
+	}
+
+	if (ret < 0)
+		goto fail;
+
+	/* clear response buffer */
+	memset(res_buf, 0, res_size);
+
+	/* Wait for the response */
+	to = IXXAT_USB_MSG_TIMEOUT;
+	timeout = jiffies + msecs_to_jiffies(cmd_delay);
+	for (; pos < res_size;) {
+		ret = usb_control_msg(dev, usb_rcvctrlpipe(dev, 0), 0xff,
+				      USB_TYPE_VENDOR | USB_DIR_IN,
+				      port, 0, res_buf + pos, res_size - pos,
+				      to);
+		switch (ret) {
+		case 0:
+			if (time_after(jiffies, timeout)) {
+				struct ixxat_usb_dal_req *dal_req = cmd;
+
+				dev_err(&dev->dev, KBUILD_MODNAME
+					": timeout waiting for cmd 0x%3x rsp\n",
+					le32_to_cpu(dal_req->code));
+				ret = -ETIMEDOUT;
+				break;
+			}
+			/* Relax before trying again */
+			usleep_range(1000, 2000);
+			continue;
+		case -ETIMEDOUT:
+			/* Didn't wait enough time to wait for the completion */
+			to += IXXAT_USB_MSG_TIMEOUT;
+			continue;
+		default:
+			/* Got something? */
+			if (ret > 0) {
+				pos += ret;
+
+				/* Got the entire response? */
+				continue;
+			}
+		}
+
+		/* fatal errors */
+		dev_err(&dev->dev, KBUILD_MODNAME
+			": Error %d while receiving response\n", ret);
+
+		goto fail;
+	}
+
+	/* copy response to user buffer */
+	memcpy(res, res_buf, res_size);
+
+	ret = le32_to_cpu(res->code);
+fail:
+	mutex_unlock(&devdata->cmd_channel_lock);
+
+	return ret;
+}
+
+/* ixxat_usb_send_cmd - send a command to the IXXAT USB device
+ * @dev: pointer to the USB device
+ * @port: port number to send the command to
+ * @cmd: pointer to the entire command buffer to send,
+ *       - starting with a struct ixxat_usb_dal_req object,
+ *       - ending with a struct ixxat_usb_dal_res object
+ * @cmd_size: size of the whole command (>= sizeof(struct ixxat_usb_dal_cmd))
+ * @res: pointer to the response structure
+ * @res_size: size of the response structure (>= sizeof(struct ixxat_usb_dal_res)
+ * @cmd_delay: delay in milliseconds to wait for a response
+ *
+ * This function sends a command to the IXXAT USB device and waits for the
+ * response, if it is still connected.
+ *
+ * Returns >= 0 on success, negative error code on failure.
+ * If the device is disconnected it returns -ENODEV.
+ */
+int ixxat_usb_send_cmd(struct ixxat_usb_candevice *pdev, const u16 port,
+		       struct ixxat_usb_dal_req *cmd, u16 cmd_size,
+		       struct ixxat_usb_dal_res *res, u16 res_size,
+		       const unsigned long cmd_delay)
+{
+	return (pdev->state & IXXAT_USB_STATE_CONNECTED) ?
+		ixxat_usb_send_cmd_internal(pdev->udev, pdev->shareddata, port,
+					    cmd, cmd_size, res, res_size,
+					    cmd_delay) : -ENODEV;
+}
+
+/* ixxat_usb_ts_set_cancaps - set timestamp multiplier/divider
+ * from controller timestamp clock settings
+ * @timeref: pointer to the time reference structure to set
+ * @ts_clock_divisor: timestamp clock divisor
+ * @ts_clock_freq: timestamp clock frequency
+ *
+ * This function calculates the tick multiplier and divider based on the
+ * timestamp clock divisor and frequency.
+ */
+static void ixxat_usb_ts_set_cancaps(struct ixxat_time_ref *timeref,
+				     u32 ts_clock_divisor,
+				     u32 ts_clock_freq)
+{
+	u64 tick_multiplier;
+
+	/* calculate tick multiplier and divider
+	 * divide by clock frequency -> resolution [1s]
+	 * multiply by IX_TICK_FACTOR -> resolution [1ns]
+	 */
+	timeref->tick_multiplier = (u64)ts_clock_divisor * IX_TICK_FACTOR;
+	timeref->tick_divider = ts_clock_freq;
+
+	/* remove not significant zero bits from multiplier and divider */
+	while (!(timeref->tick_multiplier & 0x1) &&
+	       !(timeref->tick_divider & 0x1)) {
+		timeref->tick_multiplier >>= 1;
+		timeref->tick_divider >>= 1;
+	}
+
+	/* Check if multiplier is divisible by divider without remainder:
+	 * if do_div() return value is not 0 then multiplier is not divisible by
+	 * divider: restore (modified) tick_multiplier to its backup value.
+	 */
+	tick_multiplier = timeref->tick_multiplier;
+	if (do_div(timeref->tick_multiplier, timeref->tick_divider))
+		timeref->tick_multiplier = tick_multiplier;
+	else
+		timeref->tick_divider = 1;
+}
+
+/* ixxat_usb_ts_set_start - set controller start timestamp
+ * @dev: pointer to the IXXAT USB CAN device
+ * @ts_dev_start: device start timestamp
+ *
+ * This function sets the controller start timestamp based on the provided
+ * timestamps and device start timestamp. It also updates the time reference
+ * structure in the shared data of the device.
+ */
+static void ixxat_usb_ts_set_start(struct ixxat_usb_candevice *dev,
+				   u32 ts_dev_start)
+{
+	struct ixxat_usb_device_data *devdata = dev->shareddata;
+
+	/* Be sure to synchronize the time only once per device */
+	spin_lock(&devdata->access_lock);
+
+	if (!devdata->timeref_valid) {
+		devdata->timeref_valid = true;
+		devdata->kt_host_start = 0;
+		devdata->ts_dev_start = ts_dev_start;
+	}
+
+	spin_unlock(&devdata->access_lock);
+}
+
+/* ixxat_usb_get_dev_caps - get device capabilities
+ * @dev: pointer to the USB device
+ * @devdata: pointer to the USB device private data area
+ * @dev_caps: pointer to the device capabilities structure to fill
+ *
+ * This function retrieves the device capabilities from the IXXAT USB device.
+ *
+ * Returns 0 on success, negative error code on failure.
+ */
+static int ixxat_usb_get_dev_caps(struct usb_device *dev,
+				  struct ixxat_usb_device_data *devdata,
+				  struct ixxat_dev_caps *dev_caps)
+{
+	struct ixxat_usb_caps_cmd cmd = { 0 };
+	const u32 req_size = sizeof(cmd.req);
+	const u32 rcv_size = sizeof(cmd) - req_size;
+
+	/* Cmd = [req..res] */
+	const u32 cmd_size = req_size + sizeof(cmd.res);
+	u16 num_ctrl;
+	int i, err;
+
+	ixxat_usb_setup_cmd(&cmd.req, &cmd.res);
+	cmd.req.code = cpu_to_le32(IXXAT_USB_BRD_CMD_GET_DEVCAPS);
+	cmd.res.res_size = cpu_to_le32(rcv_size);
+
+	err = ixxat_usb_send_cmd_internal(dev, devdata,
+					  le16_to_cpu(cmd.req.port),
+					  &cmd.req, cmd_size,
+					  &cmd.res, rcv_size,
+					  IXXAT_USB_CMD_TIMEOUT);
+	if (err)
+		return err;
+
+	dev_caps->bus_ctrl_count = cmd.caps.bus_ctrl_count;
+	num_ctrl = le16_to_cpu(cmd.caps.bus_ctrl_count);
+	if (num_ctrl > ARRAY_SIZE(dev_caps->bus_ctrl_types)) {
+		dev_err(&dev->dev, KBUILD_MODNAME
+			": invalid ctrlr count %u in rsp (> %zu)\n",
+			num_ctrl, ARRAY_SIZE(dev_caps->bus_ctrl_types));
+		return -EINVAL;
+	}
+
+	for (i = 0; i < num_ctrl; i++)
+		dev_caps->bus_ctrl_types[i] = cmd.caps.bus_ctrl_types[i];
+
+	return 0;
+}
+
+/* ixxat_usb_get_dev_info - get device information
+ * @dev: pointer to the USB device
+ * @devdata: pointer to the USB device private data area
+ *
+ * This function retrieves the device information from the IXXAT USB device.
+ *
+ * Returns 0 on success, negative error code on failure.
+ */
+static int ixxat_usb_get_dev_info(struct usb_device *dev,
+				  struct ixxat_usb_device_data *devdata)
+{
+	struct ixxat_usb_info_cmd cmd = { 0 };
+	const u32 req_size = sizeof(cmd.req);
+	const u32 rcv_size = sizeof(cmd) - req_size;
+
+	/* Cmd = [req..res] */
+	const u32 cmd_size = req_size + sizeof(cmd.res);
+	int err;
+
+	ixxat_usb_setup_cmd(&cmd.req, &cmd.res);
+	cmd.req.code = cpu_to_le32(IXXAT_USB_BRD_CMD_GET_DEVINFO);
+	cmd.res.res_size = cpu_to_le32(rcv_size);
+
+	err = ixxat_usb_send_cmd_internal(dev, devdata,
+					  le16_to_cpu(cmd.req.port),
+					  &cmd.req, cmd_size,
+					  &cmd.res, rcv_size,
+					  IXXAT_USB_CMD_TIMEOUT);
+	if (!err) {
+		struct ixxat_dev_info *dev_info = &devdata->dev_info;
+
+		memcpy(dev_info->device_id, &cmd.info.device_id,
+		       sizeof(cmd.info.device_id));
+		memcpy(dev_info->device_name, &cmd.info.device_name,
+		       sizeof(cmd.info.device_name));
+
+		dev_info->device_fpga_version = cmd.info.device_fpga_version;
+		dev_info->device_version = cmd.info.device_version;
+	}
+
+	return err;
+}
+
+/* ixxat_usb_get_fw_info - get firmware information (V1)
+ * @dev: pointer to the USB device
+ * @devdata: pointer to the USB device private data area
+ *
+ * This function retrieves the firmware information from the IXXAT USB device.
+ *
+ * Returns 0 on success, negative error code on failure.
+ */
+static int ixxat_usb_get_fw_info(struct usb_device *dev,
+				 struct ixxat_usb_device_data *devdata)
+{
+	struct ixxat_usb_fwinfo_cmd cmd = { 0 };
+	const u32 req_size = sizeof(cmd.req);
+	const u32 rcv_size = sizeof(cmd) - req_size;
+
+	/* Cmd = [req..res] */
+	const u32 cmd_size = req_size + sizeof(cmd.res);
+	int err;
+
+	ixxat_usb_setup_cmd(&cmd.req, &cmd.res);
+	cmd.req.code = cpu_to_le32(IXXAT_USB_BRD_CMD_GET_FWINFO);
+	cmd.res.res_size = cpu_to_le32(rcv_size);
+
+	err = ixxat_usb_send_cmd_internal(dev, devdata,
+					  le16_to_cpu(cmd.req.port),
+					  &cmd.req, cmd_size,
+					  &cmd.res, rcv_size,
+					  IXXAT_USB_CMD_TIMEOUT);
+	if (!err) {
+		struct ixxat_fw_info2 *fw_info = &devdata->fw_info;
+
+		fw_info->firmware_type = cmd.info.firmware_type;
+		fw_info->major_version = cmd.info.major_version;
+		fw_info->minor_version = cmd.info.minor_version;
+		fw_info->build_version = cmd.info.build_version;
+		fw_info->revision = 0;
+	}
+
+	return err;
+}
+
+/* ixxat_usb_get_fw_info2 - get firmware information (V2)
+ * @dev: pointer to the USB device
+ * @devdata: pointer to the USB device private data area
+ *
+ * This function retrieves the firmware information from the IXXAT USB device.
+ *
+ * Returns 0 on success, negative error code on failure.
+ */
+static int ixxat_usb_get_fw_info2(struct usb_device *dev,
+				  struct ixxat_usb_device_data *devdata)
+{
+	struct ixxat_usb_fwinfo2_cmd cmd = { 0 };
+	const u32 req_size = sizeof(cmd.req);
+	const u32 rcv_size = sizeof(cmd) - req_size;
+
+	/* Cmd = [req..res] */
+	const u32 cmd_size = req_size + sizeof(cmd.res);
+	int err;
+
+	ixxat_usb_setup_cmd(&cmd.req, &cmd.res);
+	cmd.req.code = cpu_to_le32(IXXAT_USB_BRD_CMD_GET_FWINFO2);
+	cmd.res.res_size = cpu_to_le32(rcv_size);
+
+	err = ixxat_usb_send_cmd_internal(dev, devdata,
+					  le16_to_cpu(cmd.req.port),
+					  &cmd.req, cmd_size,
+					  &cmd.res, rcv_size,
+					  IXXAT_USB_CMD_TIMEOUT);
+	if (!err) {
+		struct ixxat_fw_info2 *fw_info = &devdata->fw_info;
+
+		fw_info->firmware_type = cmd.info.firmware_type;
+		fw_info->major_version = cmd.info.major_version;
+		fw_info->minor_version = cmd.info.minor_version;
+		fw_info->build_version = cmd.info.build_version;
+		fw_info->revision = cmd.info.revision;
+	}
+
+	return err;
+}
+
+/* ixxat_usb_start_ctrl - start the controller
+ * @dev: pointer to the IXXAT USB CAN device
+ *
+ * This function sends a start command to the IXXAT USB CAN device
+ *
+ * Returns 0 on success, negative error code on failure.
+ */
+static int ixxat_usb_start_ctrl(struct ixxat_usb_candevice *dev)
+{
+	struct ixxat_usb_start_cmd cmd = { 0 };
+	const u16 port = dev->ctrl_index;
+	const u32 req_size = sizeof(cmd.req);
+	const u32 rcv_size = sizeof(cmd) - req_size;
+
+	/* Cmd = [req..res] */
+	const u32 cmd_size = req_size + sizeof(cmd.res);
+	u32 start_offset = 0;
+	int err;
+
+	ixxat_usb_setup_cmd(&cmd.req, &cmd.res);
+	cmd.req.code = cpu_to_le32(IXXAT_USB_CAN_CMD_START);
+	cmd.req.port = cpu_to_le16(port);
+	cmd.res.res_size = cpu_to_le32(rcv_size);
+	cmd.time = 0;
+
+	err = ixxat_usb_send_cmd(dev, port,
+				 &cmd.req, cmd_size,
+				 &cmd.res, rcv_size,
+				 IXXAT_USB_CMD_TIMEOUT);
+
+	if (!err)
+		start_offset = le32_to_cpu(cmd.time);
+
+	ixxat_usb_ts_set_start(dev, start_offset);
+
+	dev->time_ref.ts_overrun_ticks = 0;
+
+	return err;
+}
+
+/* ixxat_usb_stop_ctrl - stop the controller
+ * @dev: pointer to the IXXAT USB CAN device
+ *
+ * This function sends a stop command to the IXXAT USB CAN device.
+ *
+ * Returns 0 on success, negative error code on failure.
+ */
+static int ixxat_usb_stop_ctrl(struct ixxat_usb_candevice *dev)
+{
+	struct ixxat_usb_stop_cmd cmd = { 0 };
+	const u16 port = dev->ctrl_index;
+	const u32 rcv_size = sizeof(cmd.res);
+	const u32 cmd_size = sizeof(cmd);
+
+	ixxat_usb_setup_cmd(&cmd.req, &cmd.res);
+	cmd.req.size = cpu_to_le32(cmd_size - rcv_size);
+	cmd.req.code = cpu_to_le32(IXXAT_USB_CAN_CMD_STOP);
+	cmd.req.port = cpu_to_le16(port);
+	cmd.action = cpu_to_le32(IXXAT_USB_STOP_ACTION_CLEARALL);
+
+	return ixxat_usb_send_cmd(dev, port,
+				  &cmd.req, cmd_size,
+				  &cmd.res, rcv_size,
+				  IXXAT_USB_CMD_TIMEOUT);
+}
+
+/* ixxat_usb_power_ctrl - control the power mode of the device
+ * @dev: pointer to the USB device
+ * @devdata: pointer to the USB device private data area
+ * @mode: power mode to set (e.g. IXXAT_USB_POWER_WAKEUP)
+ *
+ * This function sends a command to the IXXAT USB device to control its power
+ * mode.
+ *
+ * Returns 0 on success, negative error code on failure.
+ */
+static int ixxat_usb_power_ctrl(struct usb_device *dev,
+				struct ixxat_usb_device_data *devdata, u8 mode)
+{
+	struct ixxat_usb_power_cmd cmd = { 0 };
+	const u32 rcv_size = sizeof(cmd.res);
+	const u32 req_size = sizeof(cmd) - rcv_size;
+	const u32 cmd_size = sizeof(cmd);
+
+	ixxat_usb_setup_cmd(&cmd.req, &cmd.res);
+	cmd.req.size = cpu_to_le32(req_size);
+	cmd.req.code = cpu_to_le32(IXXAT_USB_BRD_CMD_POWER);
+	cmd.mode = mode;
+
+	return ixxat_usb_send_cmd_internal(dev, devdata,
+					   le16_to_cpu(cmd.req.port),
+					   &cmd.req, cmd_size,
+					   &cmd.res, rcv_size,
+					   IXXAT_USB_POWER_CMD_TIMEOUT);
+}
+
+/* ixxat_usb_reset_ctrl - reset the controller
+ * @dev: pointer to the IXXAT USB CAN device
+ *
+ * This function sends a reset command to the IXXAT USB CAN device.
+ *
+ * Returns 0 on success, negative error code on failure.
+ */
+static int ixxat_usb_reset_ctrl(struct ixxat_usb_candevice *dev)
+{
+	struct ixxat_usb_dal_cmd cmd = { 0 };
+	const u16 port = dev->ctrl_index;
+	const u32 rcv_size = sizeof(cmd.res);
+	const u32 cmd_size = sizeof(cmd);
+
+	ixxat_usb_setup_cmd(&cmd.req, &cmd.res);
+	cmd.req.code = cpu_to_le32(IXXAT_USB_CAN_CMD_RESET);
+	cmd.req.port = cpu_to_le16(port);
+
+	return ixxat_usb_send_cmd(dev, port,
+				  &cmd.req, cmd_size,
+				  &cmd.res, rcv_size,
+				  IXXAT_USB_CMD_TIMEOUT);
+}
+
+/* ixxat_usb_free_usb_communication - free USB communication resources
+ * @dev: pointer to the IXXAT USB CAN device
+ *
+ * This function stops the network queue, kills all anchored URBs,
+ * frees the message index store, and releases all echo skbs.
+ * It also frees the TX URBs (and their buffers, via URB_FREE_BUFFER) so
+ * that a subsequent start does not leak the previous allocations.
+ */
+static void ixxat_usb_free_usb_communication(struct ixxat_usb_candevice *dev)
+{
+	struct net_device *netdev = dev->netdev;
+	u32 skb_idx, urb_idx;
+
+	netif_stop_queue(netdev);
+	usb_kill_anchored_urbs(&dev->rx_anchor);
+	usb_kill_anchored_urbs(&dev->tx_anchor);
+	atomic_set(&dev->active_tx_urbs, 0);
+
+	/* reset msg idx store */
+	ixxat_usb_msg_free_idx(dev, 0xFFFFFFFF);
+
+	for (skb_idx = 0; skb_idx < dev->can.echo_skb_max; skb_idx++)
+		can_free_echo_skb(netdev, skb_idx, NULL);
+
+	for (urb_idx = 0; urb_idx < IXXAT_USB_MAX_TX_URBS; urb_idx++) {
+		usb_free_urb(dev->tx_contexts[urb_idx].urb);
+		dev->tx_contexts[urb_idx].urb = NULL;
+		dev->tx_contexts[urb_idx].urb_index = IXXAT_USB_FREE_ENTRY;
+	}
+}
+
+/* ixxat_usb_restart - restart (stop/start) the controller
+ * @dev: pointer to the IXXAT USB CAN device
+ *
+ * This function restarts the controller by first stopping
+ * it and then starting it again.
+ *
+ * Returns 0 on success, negative error code on failure.
+ */
+static int ixxat_usb_restart(struct ixxat_usb_candevice *dev)
+{
+	struct net_device *netdev = dev->netdev;
+	int err = ixxat_usb_stop_ctrl(dev);
+
+	if (err) {
+		netdev_err(netdev,
+			   "restart: failure to stop controller err=%d\n", err);
+		goto fail;
+	}
+
+	err = ixxat_usb_start_ctrl(dev);
+	if (err) {
+		netdev_err(netdev,
+			   "restart: failure to start controller err=%d\n",
+			   err);
+		goto fail;
+	}
+
+	dev->can.state = CAN_STATE_ERROR_ACTIVE;
+	netif_wake_queue(netdev);
+
+fail:
+	return err;
+}
+
+/* ixxat_usb_set_mode - set the CAN mode of the device
+ * @netdev: pointer to the network device
+ * @mode: desired CAN mode (e.g. CAN_MODE_START)
+ *
+ * This function sets the CAN mode of the device. Currently, only CAN_MODE_START
+ * is supported, which restarts the controller.
+ *
+ * Returns 0 on success, negative error code on failure.
+ */
+static int ixxat_usb_set_mode(struct net_device *netdev, enum can_mode mode)
+{
+	int err;
+	struct ixxat_usb_candevice *dev = netdev_priv(netdev);
+
+	switch (mode) {
+	case CAN_MODE_START:
+		err = ixxat_usb_restart(dev);
+		break;
+	default:
+		err = -EOPNOTSUPP;
+		break;
+	}
+
+	return err;
+}
+
+/* ixxat_usb_get_berr_counter - get the bus error counter
+ * @netdev: pointer to the network device
+ * @bec: pointer to the bus error counter structure to fill
+ *
+ * This function retrieves the bus error counter from the IXXAT USB CAN device.
+ * It fills the provided can_berr_counter structure with the current bus error
+ * counters.
+ *
+ * Returns 0 on success, negative error code on failure.
+ */
+static int ixxat_usb_get_berr_counter(const struct net_device *netdev,
+				      struct can_berr_counter *bec)
+{
+	struct ixxat_usb_candevice *dev = netdev_priv(netdev);
+
+	*bec = dev->bec;
+	return 0;
+}
+
+/* ixxat_convert - convert IXXAT CAN message to canfd_frame
+ * @adapter: pointer to the IXXAT USB adapter
+ * @cf: pointer to the canfd_frame to fill
+ * @rx: pointer to the IXXAT CAN message to convert
+ * @datalen: data length of the CAN message
+ *
+ * This function converts an IXXAT CAN message to a canfd_frame structure.
+ * It fills the can_id, len, flags, and data fields of the canfd_frame.
+ */
+static void ixxat_convert(const struct ixxat_usb_adapter *adapter,
+			  struct canfd_frame *cf,
+			  struct ixxat_can_msg *rx,
+			  u8 datalen)
+{
+	const u32 ixx_flags = le32_to_cpu(rx->base.flags);
+	u8 flags = 0;
+
+	if (ixx_flags & IXXAT_USB_FDMSG_FLAGS_EDL) {
+		if (ixx_flags & IXXAT_USB_FDMSG_FLAGS_FDR)
+			flags |= CANFD_BRS;
+
+		if (ixx_flags & IXXAT_USB_FDMSG_FLAGS_ESI)
+			flags |= CANFD_ESI;
+	}
+
+	cf->can_id = le32_to_cpu(rx->base.msg_id);
+	cf->len = datalen;
+	cf->flags |= flags;
+
+	if (ixx_flags & IXXAT_USB_MSG_FLAGS_EXT)
+		cf->can_id |= CAN_EFF_FLAG;
+
+	if (ixx_flags & IXXAT_USB_MSG_FLAGS_RTR)
+		cf->can_id |= CAN_RTR_FLAG;
+	else if (adapter->cl1_msg_format)
+		memcpy(cf->data, rx->cl1.data, datalen);
+	else
+		memcpy(cf->data, rx->cl2.data, datalen);
+}
+
+/* ixxat_usb_set_skb_hwtimestamp - attach a hardware timestamp to a skb
+ * @timeref: pointer to the time reference structure
+ * @skb: pointer to the socket buffer containing the CAN message
+ * @ts_tick: timestamp tick value from the CAN message
+ *
+ * This function calculates the timestamp in nanoseconds from the tick value,
+ * sets it in the skb_shared_hwtstamps structure.
+ */
+static void ixxat_usb_set_skb_hwtimestamp(struct ixxat_time_ref *timeref,
+					  struct sk_buff *skb, __le32 ts_tick)
+{
+	struct skb_shared_hwtstamps *hwts = skb_hwtstamps(skb);
+	u64 ts_ns;
+
+	/* calculate tick offset */
+	u64 ticks = timeref->ts_overrun_ticks;
+
+	ticks |= le32_to_cpu(ts_tick);
+
+	/* convert tick to [1ns] resolution */
+	ts_ns = mul_u64_u64_div_u64(ticks, timeref->tick_multiplier,
+				    timeref->tick_divider);
+
+	hwts->hwtstamp = ns_to_ktime(ts_ns);
+}
+
+/* ixxat_usb_netif_rx - receive a CAN message and pass it to the network stack
+ * @timeref: pointer to the time reference structure
+ * @skb: pointer to the socket buffer containing the CAN message
+ * @ts_tick: timestamp tick value from the CAN message
+ *
+ * This function calculates the timestamp in nanoseconds from the tick value,
+ * sets it in the skb_shared_hwtstamps structure, and passes the skb to the
+ * network stack using netif_rx.
+ *
+ * Returns 0 on success.
+ */
+static int ixxat_usb_netif_rx(struct ixxat_time_ref *timeref,
+			      struct sk_buff *skb, __le32 ts_tick)
+{
+	ixxat_usb_set_skb_hwtimestamp(timeref, skb, ts_tick);
+
+	return netif_rx(skb);
+}
+
+/* ixxat_usb_handle_canmsg - handle a received CAN message
+ * @dev: pointer to the IXXAT USB CAN device
+ * @rx: pointer to the received IXXAT CAN message
+ *
+ * This function processes a received CAN message from the IXXAT USB device.
+ * It checks the message size, extracts the CAN ID, data length, and data,
+ * and passes the message to the network stack.
+ *
+ * Returns 0 on success, negative error code on failure.
+ */
+static int ixxat_usb_handle_canmsg(struct ixxat_usb_candevice *dev,
+				   struct ixxat_can_msg *rx)
+{
+	const u32 ixx_flags = le32_to_cpu(rx->base.flags);
+	const u8 dlc = FIELD_GET(IXXAT_USB_MSG_FLAGS_DLC_MASK, ixx_flags);
+	const u8 datalen = (ixx_flags & IXXAT_USB_FDMSG_FLAGS_EDL) ?
+				can_fd_dlc2len(dlc) : can_cc_dlc2len(dlc);
+	u8 min_size = sizeof(rx->base) + datalen;
+	struct net_device *netdev = dev->netdev;
+	struct sk_buff *skb;
+	struct canfd_frame *cf;
+
+	if (dev->adapter->cl1_msg_format)
+		min_size += sizeof(rx->cl1) - sizeof(rx->cl1.data);
+	else
+		min_size += sizeof(rx->cl2) - sizeof(rx->cl2.data);
+
+	if (rx->base.size < (min_size - 1)) {
+		netdev_err(netdev, "Error: CAN Invalid data message size\n");
+		return -EBADMSG;
+	}
+
+	if (ixx_flags & IXXAT_USB_MSG_FLAGS_OVR) {
+		netdev->stats.rx_over_errors++;
+		netdev->stats.rx_errors++;
+	}
+
+	if (ixx_flags & IXXAT_USB_FDMSG_FLAGS_EDL)
+		skb = alloc_canfd_skb(netdev, &cf);
+	else
+		skb = alloc_can_skb(netdev, (struct can_frame **)&cf);
+
+	if (unlikely(!skb))
+		return -ENOMEM;
+
+	ixxat_convert(dev->adapter, cf, rx, datalen);
+
+	netdev->stats.rx_packets++;
+	netdev->stats.rx_bytes += cf->len;
+
+	ixxat_usb_netif_rx(&dev->time_ref, skb, rx->base.time);
+
+	return 0;
+}
+
+/* ixxat_usb_handle_status - handle a received status message
+ * @dev: pointer to the IXXAT USB CAN device
+ * @rx: pointer to the received IXXAT CAN message
+ *
+ * This function processes a received status message from the IXXAT USB device.
+ *
+ * Returns 0 on success, negative error code on failure.
+ */
+static int ixxat_usb_handle_status(struct ixxat_usb_candevice *dev,
+				   struct ixxat_can_msg *rx)
+{
+	struct net_device *netdev = dev->netdev;
+	struct can_frame *can_frame;
+	struct sk_buff *skb;
+	enum can_state new_state = CAN_STATE_ERROR_ACTIVE;
+	u32 raw_status;
+	u8 min_size = sizeof(rx->base) + sizeof(raw_status);
+
+	if (dev->adapter->cl1_msg_format)
+		min_size += sizeof(rx->cl1) - sizeof(rx->cl1.data);
+	else
+		min_size += sizeof(rx->cl2) - sizeof(rx->cl2.data);
+
+	if (rx->base.size < (min_size - 1)) {
+		netdev_err(netdev, "Error: CAN Invalid status message size\n");
+		return -EBADMSG;
+	}
+
+	raw_status = (dev->adapter->cl1_msg_format) ?
+		get_unaligned_le32(rx->cl1.data) :
+		get_unaligned_le32(rx->cl2.data);
+
+	if (raw_status != IXXAT_USB_CAN_STATUS_OK) {
+		if (raw_status & IXXAT_USB_CAN_STATUS_BUSOFF) {
+			dev->can.can_stats.bus_off++;
+			new_state = CAN_STATE_BUS_OFF;
+			can_bus_off(netdev);
+		} else {
+			if (raw_status & IXXAT_USB_CAN_STATUS_ERRLIM) {
+				dev->can.can_stats.error_warning++;
+				new_state = CAN_STATE_ERROR_WARNING;
+			}
+
+			if (raw_status & IXXAT_USB_CAN_STATUS_ERR_PAS) {
+				dev->can.can_stats.error_passive++;
+				new_state = CAN_STATE_ERROR_PASSIVE;
+			}
+
+			if (raw_status & IXXAT_USB_CAN_STATUS_OVERRUN)
+				new_state = CAN_STATE_MAX;
+		}
+	}
+
+	if (new_state == CAN_STATE_ERROR_ACTIVE) {
+		dev->bec.txerr = 0;
+		dev->bec.rxerr = 0;
+	}
+
+	/* nothing changed since the last status message: avoid flooding
+	 * userspace with redundant error frames
+	 */
+	if (new_state != CAN_STATE_MAX) {
+		if (new_state == dev->can.state)
+			return 0;
+
+		dev->can.state = new_state;
+	}
+
+	skb = alloc_can_err_skb(netdev, &can_frame);
+	if (unlikely(!skb))
+		return -ENOMEM;
+
+	switch (new_state) {
+	case CAN_STATE_ERROR_ACTIVE:
+		can_frame->can_id |= CAN_ERR_CRTL;
+		can_frame->data[1] |= CAN_ERR_CRTL_ACTIVE;
+		break;
+	case CAN_STATE_ERROR_WARNING:
+		can_frame->can_id |= CAN_ERR_CRTL | CAN_ERR_CNT;
+		can_frame->data[1] = (dev->bec.txerr > dev->bec.rxerr) ?
+			CAN_ERR_CRTL_TX_WARNING :
+			CAN_ERR_CRTL_RX_WARNING;
+		can_frame->data[6] = dev->bec.txerr;
+		can_frame->data[7] = dev->bec.rxerr;
+		break;
+	case CAN_STATE_ERROR_PASSIVE:
+		can_frame->can_id |= CAN_ERR_CRTL | CAN_ERR_CNT;
+		can_frame->data[1] |= CAN_ERR_CRTL_RX_PASSIVE;
+		if (dev->bec.txerr > 127)
+			can_frame->data[1] |= CAN_ERR_CRTL_TX_PASSIVE;
+		can_frame->data[6] = dev->bec.txerr;
+		can_frame->data[7] = dev->bec.rxerr;
+		break;
+	case CAN_STATE_BUS_OFF:
+		can_frame->can_id |= CAN_ERR_BUSOFF;
+		break;
+	case CAN_STATE_MAX:
+		can_frame->can_id |= CAN_ERR_CRTL;
+		can_frame->data[1] |= CAN_ERR_CRTL_RX_OVERFLOW;
+		break;
+	default:
+		netdev_err(netdev, "Error: CAN Unhandled status %d\n",
+			   new_state);
+		break;
+	}
+
+	ixxat_usb_netif_rx(&dev->time_ref, skb, rx->base.time);
+
+	return 0;
+}
+
+/* ixxat_usb_handle_error - handle a received error message
+ * @dev: pointer to the IXXAT USB CAN device
+ * @rx: pointer to the received IXXAT CAN message
+ *
+ * This function processes a received error message from the IXXAT USB device.
+ * It extracts the error code and updates the bus error counters.
+ *
+ * Returns 0 on success, negative error code on failure.
+ */
+static int ixxat_usb_handle_error(struct ixxat_usb_candevice *dev,
+				  struct ixxat_can_msg *rx)
+{
+	struct net_device *netdev = dev->netdev;
+	struct can_frame *can_frame;
+	struct sk_buff *skb;
+	u8 raw_error;
+	u8 min_size = sizeof(rx->base) + IXXAT_USB_CAN_ERROR_LEN;
+
+	if (dev->adapter->cl1_msg_format)
+		min_size += sizeof(rx->cl1) - sizeof(rx->cl1.data);
+	else
+		min_size += sizeof(rx->cl2) - sizeof(rx->cl2.data);
+
+	if (rx->base.size < (min_size - 1)) {
+		netdev_err(netdev, "Error: CAN Invalid error message size\n");
+		return -EBADMSG;
+	}
+
+	if (dev->can.state == CAN_STATE_BUS_OFF)
+		return 0;
+
+	if (dev->adapter->cl1_msg_format) {
+		raw_error = rx->cl1.data[IXXAT_USB_CAN_ERROR_CODE];
+		dev->bec.rxerr = rx->cl1.data[IXXAT_USB_CAN_ERROR_COUNTER_RX];
+		dev->bec.txerr = rx->cl1.data[IXXAT_USB_CAN_ERROR_COUNTER_TX];
+	} else {
+		raw_error = rx->cl2.data[IXXAT_USB_CAN_ERROR_CODE];
+		dev->bec.rxerr = rx->cl2.data[IXXAT_USB_CAN_ERROR_COUNTER_RX];
+		dev->bec.txerr = rx->cl2.data[IXXAT_USB_CAN_ERROR_COUNTER_TX];
+	}
+
+	dev->can.can_stats.bus_error++;
+	if (raw_error == IXXAT_USB_CAN_ERROR_ACK)
+		netdev->stats.tx_errors++;
+	else
+		netdev->stats.rx_errors++;
+
+	skb = alloc_can_err_skb(netdev, &can_frame);
+	if (unlikely(!skb))
+		return -ENOMEM;
+
+	switch (raw_error) {
+	case IXXAT_USB_CAN_ERROR_ACK:
+		can_frame->can_id |= CAN_ERR_ACK;
+		break;
+	case IXXAT_USB_CAN_ERROR_BIT:
+		can_frame->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
+		can_frame->data[2] |= CAN_ERR_PROT_BIT;
+		break;
+	case IXXAT_USB_CAN_ERROR_CRC:
+		can_frame->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
+		can_frame->data[3] |= CAN_ERR_PROT_LOC_CRC_SEQ;
+		break;
+	case IXXAT_USB_CAN_ERROR_FORM:
+		can_frame->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
+		can_frame->data[2] |= CAN_ERR_PROT_FORM;
+		break;
+	case IXXAT_USB_CAN_ERROR_STUFF:
+		can_frame->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
+		can_frame->data[2] |= CAN_ERR_PROT_STUFF;
+		break;
+	default:
+		can_frame->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
+		can_frame->data[2] |= CAN_ERR_PROT_UNSPEC;
+		break;
+	}
+
+	ixxat_usb_netif_rx(&dev->time_ref, skb, rx->base.time);
+
+	return 0;
+}
+
+/* ixxat_usb_decode_buf - decode a received urb
+ * @urb: pointer to the USB request block containing the received data
+ *
+ * This function decodes the received urb and processes the CAN messages.
+ * It handles different message types such as CAN data, status, error, and time
+ * overrun.
+ *
+ * Returns 0 on success, negative error code on failure.
+ */
+static int ixxat_usb_decode_buf(struct urb *urb)
+{
+	struct ixxat_usb_candevice *dev = urb->context;
+	struct net_device *netdev = dev->netdev;
+	int err = 0;
+	u8 *data = urb->transfer_buffer;
+	u32 len = urb->actual_length, pos, size;
+	u64 time;
+
+	for (pos = 0; pos < len; pos += size) {
+		struct ixxat_can_msg can_msg;
+		u32 type;
+
+		/* Since struct ixxat_can_msg is packed and starts with a byte,
+		 * we have no choice but to copy the whole message into a local
+		 * variable to avoid bus violation.
+		 */
+		size = data[pos] + 1;
+		if (size > sizeof(can_msg) ||
+		    size < sizeof(struct ixxat_can_msg_base) ||
+		    (pos + size) > len) {
+			netdev_err(netdev, "Error: USB Invalid msg size %u\n",
+				   size);
+			return -EBADMSG;
+		}
+
+		/* size is now validated against the received buffer length */
+		memcpy(&can_msg, data + pos, size);
+		if (!can_msg.base.size) {
+			netdev_err(netdev, "Error: USB Unsupported msg size\n");
+			return -EOPNOTSUPP;
+		}
+
+		type = FIELD_GET(IXXAT_USB_MSG_FLAGS_TYPE_MASK,
+				 le32_to_cpu(can_msg.base.flags));
+
+		switch (type) {
+		case IXXAT_USB_CAN_DATA:
+			err = ixxat_usb_handle_canmsg(dev, &can_msg);
+			if (err)
+				return err;
+			break;
+
+		case IXXAT_USB_CAN_STATUS:
+			err = ixxat_usb_handle_status(dev, &can_msg);
+			if (err)
+				return err;
+			break;
+
+		case IXXAT_USB_CAN_ERROR:
+			err = ixxat_usb_handle_error(dev, &can_msg);
+			if (err)
+				return err;
+			break;
+
+		case IXXAT_USB_CAN_TIMEOVR:
+			time = le32_to_cpu(can_msg.base.msg_id);
+				dev->time_ref.ts_overrun_ticks += (time << 32);
+			break;
+		case IXXAT_USB_CAN_INFO:
+		case IXXAT_USB_CAN_WAKEUP:
+		case IXXAT_USB_CAN_TIMERST:
+			break;
+
+		default:
+			netdev_err(netdev,
+				   "CAN Unhandled rec 0x%02x/%d: ignored\n",
+				   type, type);
+			break;
+		}
+	}
+
+	return err;
+}
+
+/* ixxat_usb_encode_msg - encode a CAN message into USB format
+ * @dev: pointer to the IXXAT USB CAN device
+ * @skb: pointer to the socket buffer containing the CAN message
+ * @obuf: output buffer to fill with the encoded message
+ *
+ * This function encodes a CAN message from the socket buffer into
+ * the IXXAT USB CAN message format.
+ *
+ * Returns the size of the encoded message.
+ */
+static int ixxat_usb_encode_msg(struct ixxat_usb_candevice *dev,
+				struct sk_buff *skb, u8 *obuf)
+{
+	int size;
+	struct canfd_frame *cf = (struct canfd_frame *)skb->data;
+	struct ixxat_can_msg can_msg = { 0 };
+	struct ixxat_can_msg_base *msg_base = &can_msg.base;
+	u32 flags = 0, msg_id;
+
+	if (cf->can_id & CAN_EFF_FLAG) {
+		flags |= IXXAT_USB_MSG_FLAGS_EXT;
+		msg_id = cf->can_id & CAN_EFF_MASK;
+	} else {
+		msg_id = cf->can_id & CAN_SFF_MASK;
+	}
+
+	if (can_is_canfd_skb(skb)) {
+		flags |= IXXAT_USB_FDMSG_FLAGS_EDL;
+
+		if (cf->flags & CANFD_BRS)
+			flags |= IXXAT_USB_FDMSG_FLAGS_FDR;
+
+		if (cf->flags & CANFD_ESI)
+			flags |= IXXAT_USB_FDMSG_FLAGS_ESI;
+
+		flags |= FIELD_PREP(IXXAT_USB_MSG_FLAGS_DLC_MASK,
+				    can_fd_len2dlc(cf->len));
+	} else if (cf->can_id & CAN_RTR_FLAG) {
+		flags |= IXXAT_USB_MSG_FLAGS_RTR;
+	} else {
+		flags |= FIELD_PREP(IXXAT_USB_MSG_FLAGS_DLC_MASK, cf->len);
+	}
+
+	if (dev->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT)
+		flags |= IXXAT_USB_MSG_FLAGS_SINGLESHOT;
+
+	msg_base->size = sizeof(*msg_base) + cf->len - 1;
+
+	if (dev->adapter->cl1_msg_format) {
+		msg_base->size += sizeof(can_msg.cl1);
+		msg_base->size -= sizeof(can_msg.cl1.data);
+		memcpy(can_msg.cl1.data, cf->data, cf->len);
+	} else {
+		msg_base->size += sizeof(can_msg.cl2);
+		msg_base->size -= sizeof(can_msg.cl2.data);
+		memcpy(can_msg.cl2.data, cf->data, cf->len);
+	}
+
+	if (dev->loopback)
+		flags |= IXXAT_USB_MSG_FLAGS_SRR;
+
+	msg_base->flags = cpu_to_le32(flags);
+	msg_base->msg_id = cpu_to_le32(msg_id);
+
+	size = msg_base->size + 1;
+	memcpy(obuf, &can_msg, size);
+
+	return size;
+}
+
+/* ixxat_evaluate_usb_status - evaluate the status of a USB request block
+ * @netdev: pointer to the network device
+ * @urb: pointer to the USB request block
+ * @ep_msg: endpoint message type
+ *
+ * This function evaluates the status of a USB request block (urb).
+ *
+ * Returns 0 on success or a negative error code based on the status.
+ */
+static int ixxat_evaluate_usb_status(struct net_device *netdev,
+				     struct urb *urb, u8 ep_msg)
+{
+	/* 0: success, -1: error -> return, -2: error -> retry */
+	int err = 0;
+
+	if (!netif_device_present(netdev))
+		return -1;
+
+	switch (urb->status) {
+	case 0:
+		/* success */
+		break;
+	case -EPROTO:
+	case -EILSEQ:
+	case -ENOENT:
+	case -ECONNRESET:
+	case -ESHUTDOWN:
+		err = -1;
+		break;
+	default:
+		err = -2;
+		break;
+	}
+
+	return err;
+}
+
+/* ixxat_usb_read_bulk_callback - callback for USB bulk read URB
+ * @urb: pointer to the USB request block containing the received data
+ *
+ * This function is called when a USB bulk read URB completes.
+ */
+static void ixxat_usb_read_bulk_callback(struct urb *urb)
+{
+	struct ixxat_usb_candevice *dev = urb->context;
+	struct net_device *netdev;
+	int err;
+
+	if (WARN_ON_ONCE(!dev))
+		return;
+
+	netdev = dev->netdev;
+
+	err = ixxat_evaluate_usb_status(netdev, urb, dev->ep_msg_in);
+	switch (err) {
+	case 0:
+		if (urb->actual_length > 0 &&
+		    dev->state & IXXAT_USB_STATE_STARTED) {
+			err = ixxat_usb_decode_buf(urb);
+
+			/* Fix sashiko-bot v1 issue:
+			 * don't skip usb_submit_urb() in case of error in
+			 * ixxat_usb_decode_buf()
+			 */
+			if (err)
+				netdev_err(netdev,
+					   "Error %d while decoding buffer\n",
+					   err);
+		}
+		break;
+
+	case -1:
+		return;
+	}
+
+	/* resubmit_urb: */
+	usb_fill_bulk_urb(urb, dev->udev,
+			  usb_rcvbulkpipe(dev->udev, dev->ep_msg_in),
+			  urb->transfer_buffer, dev->adapter->buffer_size_rx,
+			  ixxat_usb_read_bulk_callback, dev);
+
+	usb_anchor_urb(urb, &dev->rx_anchor);
+	err = usb_submit_urb(urb, GFP_ATOMIC);
+	if (err) {
+		usb_unanchor_urb(urb);
+
+		if (err == -ENODEV)
+			netif_device_detach(netdev);
+		else
+			netdev_err(netdev,
+				   "Rx urb resubmit failure (err %d)\n", err);
+	}
+}
+
+/* ixxat_usb_write_bulk_callback - callback for USB bulk write URB
+ * @urb: pointer to the USB request block containing the sent data
+ *
+ * This function is called when a USB bulk write URB completes.
+ */
+static void ixxat_usb_write_bulk_callback(struct urb *urb)
+{
+	struct ixxat_tx_urb_context *context = urb->context;
+	struct ixxat_usb_candevice *dev;
+	struct net_device *netdev;
+	int echo_bytes;
+	u32 msg_idx;
+	int err;
+
+	if (WARN_ON_ONCE(!context))
+		return;
+
+	dev = context->dev;
+	netdev = dev->netdev;
+
+	/* Fix sashiko-bot v1 issue:
+	 * don't skip the cleanup block if a status error occurs
+	 */
+	err = ixxat_evaluate_usb_status(netdev, urb, dev->ep_msg_out);
+	if (err == -1)
+		goto lbl_rel;
+
+	if (err == 0)
+		/* prevent tx timeout */
+		netif_trans_update(netdev);
+
+	/* find correct msg_idx with the CAN Id and Len */
+	msg_idx = context->msg_index;
+
+	/* can_get_echo_skb() must always be called! */
+	echo_bytes = can_get_echo_skb(netdev, msg_idx, NULL);
+
+	/* do handle stats only in case of success */
+	if (!err) {
+		netdev->stats.tx_bytes += echo_bytes;
+		netdev->stats.tx_packets++;
+	}
+
+	ixxat_usb_msg_free_idx(dev, msg_idx);
+	context->msg_index = IXXAT_USB_MAX_MSGS;
+
+lbl_rel:
+	ixxat_usb_rel_tx_context(dev, context);
+	atomic_dec(&dev->active_tx_urbs);
+
+	/* A TX context has been released, wakeup TX queue next (if needed) */
+	if (!err)
+		netif_wake_queue(netdev);
+}
+
+/* ixxat_usb_start_xmit - start transmission of a CAN message
+ * @skb: pointer to the socket buffer containing the CAN message
+ * @netdev: pointer to the network device
+ *
+ * This function prepares a CAN message for transmission over USB.
+ *
+ * Returns NETDEV_TX_OK on success, NETDEV_TX_BUSY if the device
+ * is busy and the transmission should be retried later.
+ * Other error codes are the result of a call to usb_submit_urb()
+ * and indicate a failure in submitting the URB for transmission.
+ */
+static netdev_tx_t ixxat_usb_start_xmit(struct sk_buff *skb,
+					struct net_device *netdev)
+{
+	int err, size;
+	struct ixxat_usb_candevice *dev = netdev_priv(netdev);
+	struct ixxat_tx_urb_context *context;
+	struct net_device_stats *stats = &netdev->stats;
+	struct urb *urb;
+	u8 *obuf;
+	u32 msg_idx;
+
+	if (can_dev_dropped_skb(netdev, skb))
+		return NETDEV_TX_OK;
+
+	/* Find free URB.
+	 * Fix sashiko-bot v1 issue:
+	 * Pause the transmission queue when TX resources are empty, even though
+	 * this should never happen.
+	 */
+	context = ixxat_usb_get_tx_context(dev);
+	if (!context) {
+		netif_stop_queue(netdev);
+		return NETDEV_TX_BUSY;
+	}
+
+	/* get free msg number (ClientId) */
+	msg_idx = ixxat_usb_msg_get_next_idx(dev);
+	if (msg_idx >= IXXAT_USB_MAX_MSGS) {
+		ixxat_usb_rel_tx_context(dev, context);
+		netif_stop_queue(netdev);
+		return NETDEV_TX_BUSY;
+	}
+
+	/* prepare the Urb */
+	urb = context->urb;
+	obuf = urb->transfer_buffer;
+
+	/* store the msg_idx in the Urb */
+	context->msg_index = msg_idx;
+
+	/* encode the outgoing message */
+	size = ixxat_usb_encode_msg(dev, skb, obuf);
+
+	urb->transfer_buffer_length = size;
+	usb_anchor_urb(urb, &dev->tx_anchor);
+
+	can_put_echo_skb(skb, netdev, msg_idx, 0);
+
+	atomic_inc(&dev->active_tx_urbs);
+
+	err = usb_submit_urb(urb, GFP_ATOMIC);
+	if (err) {
+		/* submit failed. Should only free if it's exist */
+		can_free_echo_skb(netdev, msg_idx, NULL);
+		ixxat_usb_msg_free_idx(dev, msg_idx);
+		ixxat_usb_rel_tx_context(dev, context);
+
+		usb_unanchor_urb(urb);
+		atomic_dec(&dev->active_tx_urbs);
+
+		if (err == -ENODEV) {
+			netif_device_detach(netdev);
+		} else {
+			stats->tx_dropped++;
+			netdev_err(netdev, "Submitting tx-urb failed err %d\n",
+				   err);
+		}
+	} else {
+		/* update trans_start */
+		netif_trans_update(netdev);
+	}
+
+	/* Fix sashiko-bot v1 issue:
+	 * The ndo_start_xmit API expects a netdev_tx_t constant
+	 */
+	return NETDEV_TX_OK;
+}
+
+/* ixxat_usb_setup_rx_urbs - setup the receive URBs for the IXXAT USB device
+ * @dev: pointer to the IXXAT USB CAN device
+ *
+ * This function allocates and initializes the receive URBs for the IXXAT USB
+ * device. It sets up the URBs to receive CAN messages from the USB endpoint.
+ *
+ * Returns 0 on success (that is, if at least one rx urb has been successfully
+ * submitted), a negative error code otherwise.
+ */
+static int ixxat_usb_setup_rx_urbs(struct ixxat_usb_candevice *dev)
+{
+	int urb_idx, err = 0;
+	const struct ixxat_usb_adapter *adapter = dev->adapter;
+	struct net_device *netdev = dev->netdev;
+	struct usb_device *udev = dev->udev;
+
+	for (urb_idx = 0; urb_idx < IXXAT_USB_MAX_RX_URBS; urb_idx++) {
+		struct urb *urb = usb_alloc_urb(0, GFP_KERNEL);
+		u8 *buf;
+
+		if (!urb) {
+			err = -ENOMEM;
+			netdev_err(netdev, "Error %d: No memory for Rx URB\n",
+				   err);
+			break;
+		}
+
+		buf = kmalloc(adapter->buffer_size_rx, GFP_KERNEL);
+		if (!buf) {
+			usb_free_urb(urb);
+			err = -ENOMEM;
+			netdev_err(netdev,
+				   "Error %d: No memory for USB buffer\n", err);
+			break;
+		}
+
+		dev->rx_buf[urb_idx] = buf;
+
+		usb_fill_bulk_urb(urb, udev,
+				  usb_rcvbulkpipe(udev, dev->ep_msg_in), buf,
+				  adapter->buffer_size_rx,
+				  ixxat_usb_read_bulk_callback, dev);
+
+		/* ask last usb_free_urb() to also kfree() transfer_buffer */
+		urb->transfer_flags |= URB_FREE_BUFFER;
+		usb_anchor_urb(urb, &dev->rx_anchor);
+
+		err = usb_submit_urb(urb, GFP_KERNEL);
+		if (err) {
+			usb_unanchor_urb(urb);
+
+			dev->rx_buf[urb_idx] = NULL;
+
+			/* No need to kfree(buf) because of URB_FREE_BUFFER */
+			usb_free_urb(urb);
+
+			if (err == -ENODEV)
+				netif_device_detach(netdev);
+
+			break;
+		}
+
+		/* drop reference, USB core will take care of freeing it */
+		usb_free_urb(urb);
+	}
+
+	if (!urb_idx) {
+		netdev_err(netdev, "Couldn't setup any rx-URBs\n");
+	} else if (urb_idx < IXXAT_USB_MAX_RX_URBS) {
+		netdev_warn(netdev, "Rx performance may be slow\n");
+		err = 0;
+	}
+
+	return err;
+}
+
+/* ixxat_usb_setup_tx_urbs - setup the transmit URBs for the IXXAT USB device
+ * @dev: pointer to the IXXAT USB CAN device
+ *
+ * This function allocates and initializes the transmit URBs for the IXXAT USB
+ * device. It sets up the URBs to send CAN messages to the USB endpoint.
+ *
+ * Returns 0 on success (that is, if at least one tx urb has been successfully
+ * submitted), a negative error code otherwise.
+ */
+static int ixxat_usb_setup_tx_urbs(struct ixxat_usb_candevice *dev)
+{
+	int urb_idx, err = 0;
+	const struct ixxat_usb_adapter *adapter = dev->adapter;
+	struct net_device *netdev = dev->netdev;
+	struct usb_device *udev = dev->udev;
+
+	for (urb_idx = 0; urb_idx < IXXAT_USB_MAX_TX_URBS; urb_idx++) {
+		struct urb *urb = usb_alloc_urb(0, GFP_KERNEL);
+		struct ixxat_tx_urb_context *context;
+		u8 *buf;
+
+		if (!urb) {
+			err = -ENOMEM;
+			netdev_err(netdev, "Error %d: No memory for Tx URB\n",
+				   err);
+			break;
+		}
+
+		buf = kmalloc(adapter->buffer_size_tx, GFP_KERNEL);
+		if (!buf) {
+			usb_free_urb(urb);
+			err = -ENOMEM;
+			netdev_err(netdev,
+				   "Error %d: No memory for USB buffer\n", err);
+			break;
+		}
+
+		context = dev->tx_contexts + urb_idx;
+
+		context->dev = dev;
+		context->urb = urb;
+		context->urb_index = IXXAT_USB_FREE_ENTRY;
+		usb_fill_bulk_urb(urb, udev,
+				  usb_sndbulkpipe(udev, dev->ep_msg_out), buf,
+				  adapter->buffer_size_tx,
+				  ixxat_usb_write_bulk_callback, context);
+
+		urb->transfer_flags |= URB_FREE_BUFFER;
+	}
+
+	if (!urb_idx) {
+		netdev_err(netdev, "Couldn't setup any tx-URBs\n");
+	} else if (urb_idx < IXXAT_USB_MAX_TX_URBS) {
+		netdev_warn(netdev, "Tx performance may be slow\n");
+		err = 0;
+	}
+
+	return err;
+}
+
+/* sysfs attributes
+ * These attributes provide information about the IXXAT USB device,
+ * such as serial number, firmware version, hardware name, hardware version,
+ * and FPGA version. They are used to expose device information through sysfs.
+ */
+static ssize_t serial_show(struct device *pdev, struct device_attribute *attr,
+			   char *buf)
+{
+	struct net_device *netdev = to_net_dev(pdev);
+	struct ixxat_usb_candevice *dev = netdev_priv(netdev);
+	struct ixxat_usb_device_data *devdata = dev->shareddata;
+
+	return (devdata) ?
+		snprintf(buf, PAGE_SIZE, "%.*s\n",
+			 (int)sizeof(devdata->dev_info.device_id),
+			 devdata->dev_info.device_id) :
+		0;
+}
+static DEVICE_ATTR_RO(serial);
+
+static ssize_t firmware_version_show(struct device *pdev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct net_device *netdev = to_net_dev(pdev);
+	struct ixxat_usb_candevice *dev = netdev_priv(netdev);
+	struct ixxat_usb_device_data *devdata = dev->shareddata;
+
+	return (devdata) ?
+		snprintf(buf, PAGE_SIZE, "%d.%d.%d.%d\n",
+			 le16_to_cpu(devdata->fw_info.major_version),
+			 le16_to_cpu(devdata->fw_info.minor_version),
+			 le16_to_cpu(devdata->fw_info.build_version),
+			 le16_to_cpu(devdata->fw_info.revision)) :
+		0;
+}
+static DEVICE_ATTR_RO(firmware_version);
+
+static ssize_t hardware_show(struct device *pdev,
+			     struct device_attribute *attr,
+			     char *buf)
+{
+	struct net_device *netdev = to_net_dev(pdev);
+	struct ixxat_usb_candevice *dev = netdev_priv(netdev);
+	struct ixxat_usb_device_data *devdata = dev->shareddata;
+
+	return (devdata) ?
+		snprintf(buf, PAGE_SIZE, "%.*s\n",
+			 (int)sizeof(devdata->dev_info.device_name),
+			 devdata->dev_info.device_name) :
+		0;
+}
+static DEVICE_ATTR_RO(hardware);
+
+static ssize_t hardware_version_show(struct device *pdev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	struct net_device *netdev = to_net_dev(pdev);
+	struct ixxat_usb_candevice *dev = netdev_priv(netdev);
+	struct ixxat_usb_device_data *devdata = dev->shareddata;
+
+	return (devdata) ?
+		snprintf(buf, PAGE_SIZE, "0x%04X\n",
+			 devdata->dev_info.device_version) :
+		0;
+}
+static DEVICE_ATTR_RO(hardware_version);
+
+static ssize_t fpga_version_show(struct device *pdev,
+				 struct device_attribute *attr,
+				 char *buf)
+{
+	struct net_device *netdev = to_net_dev(pdev);
+	struct ixxat_usb_candevice *dev = netdev_priv(netdev);
+	struct ixxat_usb_device_data *devdata = dev->shareddata;
+
+	return (devdata) ?
+		snprintf(buf, PAGE_SIZE, "0x%08X\n",
+			 devdata->dev_info.device_fpga_version) :
+		0;
+}
+static DEVICE_ATTR_RO(fpga_version);
+
+static struct attribute *ixxat_pdev_attrs[] = {
+	&dev_attr_serial.attr,
+	&dev_attr_firmware_version.attr,
+	&dev_attr_hardware.attr,
+	&dev_attr_hardware_version.attr,
+	&dev_attr_fpga_version.attr,
+	NULL,
+};
+
+static const struct attribute_group ixxat_pdev_group = {
+	.name = NULL,
+	.attrs = ixxat_pdev_attrs,
+};
+
+/* ixxat_usb_disconnect - disconnect the IXXAT USB device
+ * @intf: pointer to the USB interface
+ *
+ * This function is called when the USB device is disconnected.
+ */
+static void ixxat_usb_disconnect(struct usb_interface *intf)
+{
+	struct ixxat_usb_candevice *dev = usb_get_intfdata(intf);
+	struct ixxat_usb_device_data *devdata;
+
+	if (!dev)
+		return;
+
+	devdata = dev->shareddata;
+
+	/* unregister the given device and all previous devices */
+	do {
+		struct ixxat_usb_candevice *prev_dev = dev->prev_dev;
+		struct net_device *netdev = dev->netdev;
+		char name[IFNAMSIZ];
+
+		dev->state &= ~IXXAT_USB_STATE_CONNECTED;
+
+		strscpy(name, netdev->name, IFNAMSIZ);
+
+		sysfs_remove_group(&dev->netdev->dev.kobj, &ixxat_pdev_group);
+
+		unregister_candev(netdev);
+
+		free_candev(netdev);
+		dev_info(&intf->dev, "%s removed\n", name);
+
+		dev = prev_dev;
+	} while (dev);
+
+	usb_set_intfdata(intf, dev);
+
+	/* free the shared data (this needs at least one dev in intfdata) */
+	kfree(devdata->cmdbuf);
+	kfree(devdata);
+}
+
+/* ixxat_usb_start - start the IXXAT USB CAN device
+ * @dev: pointer to the IXXAT USB CAN device
+ *
+ * This function initializes the IXXAT USB CAN device by setting up
+ * the receive and transmit URBs, resetting the controller,
+ * and starting the controller if necessary.
+ *
+ * Returns 0 on success, negative error code on failure.
+ */
+static int ixxat_usb_start(struct ixxat_usb_candevice *dev)
+{
+	int err;
+	int i;
+	const struct ixxat_usb_adapter *adapter = dev->adapter;
+
+	err = ixxat_usb_setup_rx_urbs(dev);
+	if (err)
+		return err;
+
+	err = ixxat_usb_setup_tx_urbs(dev);
+	if (err)
+		goto err_tx;
+
+	/* Try to reset the controller, in case it is already initialized
+	 * from a previous unclean shutdown
+	 */
+	ixxat_usb_reset_ctrl(dev);
+
+	if (adapter->init_ctrl) {
+		err = adapter->init_ctrl(dev);
+		if (err)
+			goto fail;
+	}
+
+	if (!(dev->state & IXXAT_USB_STATE_STARTED)) {
+		err = ixxat_usb_start_ctrl(dev);
+		if (err)
+			goto fail;
+	}
+
+	dev->bec.txerr = 0;
+	dev->bec.rxerr = 0;
+
+	dev->state |= IXXAT_USB_STATE_STARTED;
+	dev->can.state = CAN_STATE_ERROR_ACTIVE;
+
+	return 0;
+
+fail:
+	if (err == -ENODEV)
+		netif_device_detach(dev->netdev);
+
+	netdev_err(dev->netdev, "Error %d: Couldn't submit control\n", err);
+
+	for (i = 0; i < IXXAT_USB_MAX_TX_URBS; i++) {
+		usb_free_urb(dev->tx_contexts[i].urb);
+		dev->tx_contexts[i].urb = NULL;
+	}
+
+err_tx:
+	usb_kill_anchored_urbs(&dev->rx_anchor);
+
+	return err;
+}
+
+/* ixxat_usb_open - open the IXXAT USB CAN device
+ * @netdev: pointer to the network device
+ *
+ * This function is called when the network device is opened.
+ *
+ * Returns 0 on success, negative error code on failure.
+ */
+static int ixxat_usb_open(struct net_device *netdev)
+{
+	struct ixxat_usb_candevice *dev = netdev_priv(netdev);
+	int err;
+
+	/* common open */
+	err = open_candev(netdev);
+	if (err)
+		goto fail;
+
+	/* finally start device */
+	err = ixxat_usb_start(dev);
+	if (err) {
+		netdev_err(netdev, "Error %d: Couldn't start device.\n", err);
+		close_candev(netdev);
+		goto fail;
+	}
+
+	netif_start_queue(netdev);
+
+fail:
+	return err;
+}
+
+/* ixxat_usb_stop - stop the IXXAT USB CAN device
+ * @netdev: pointer to the network device
+ *
+ * This function stops the IXXAT USB CAN device by freeing the USB
+ * communication, stopping the controller, and closing the network device.
+ *
+ * Returns 0 on success, negative error code on failure.
+ */
+static int ixxat_usb_stop(struct net_device *netdev)
+{
+	int err = 0;
+	struct ixxat_usb_candevice *dev = netdev_priv(netdev);
+
+	ixxat_usb_free_usb_communication(dev);
+
+	if (dev->state & IXXAT_USB_STATE_STARTED) {
+		err = ixxat_usb_stop_ctrl(dev);
+		if (err && err != -ENODEV)
+			netdev_warn(netdev, "cannot stop device (err %d)\n",
+				    err);
+
+		dev->state &= ~IXXAT_USB_STATE_STARTED;
+	}
+
+	close_candev(netdev);
+	dev->can.state = CAN_STATE_STOPPED;
+
+	return err;
+}
+
+static const struct net_device_ops ixxat_usb_netdev_ops = {
+	.ndo_open = ixxat_usb_open,
+	.ndo_stop = ixxat_usb_stop,
+	.ndo_hwtstamp_get = can_hwtstamp_get,
+	.ndo_hwtstamp_set = can_hwtstamp_set,
+	.ndo_start_xmit = ixxat_usb_start_xmit,
+};
+
+/* ixxat_ethtool_op_get_ts_info - get timestamping info
+ * @dev: pointer to the network device
+ * @info: pointer to the structure to fill with timestamping information
+ *
+ * This function fills the provided structure with information about the
+ * timestamping capabilities of the IXXAT USB CAN device, including supported
+ * timestamping modes, supported transmit types and supported receive filters.
+ *
+ * Returns always 0.
+ */
+static int ixxat_ethtool_op_get_ts_info(struct net_device *dev,
+					struct kernel_ethtool_ts_info *info)
+{
+	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
+				SOF_TIMESTAMPING_RX_SOFTWARE |
+				SOF_TIMESTAMPING_RX_HARDWARE |
+				SOF_TIMESTAMPING_RAW_HARDWARE |
+				SOF_TIMESTAMPING_SOFTWARE;
+
+	info->phc_index = -1;
+	info->tx_types = BIT(HWTSTAMP_TX_OFF);
+	info->rx_filters = BIT(HWTSTAMP_FILTER_ALL);
+
+	return 0;
+}
+
+/* Use IXXAT specific implementation */
+static const struct ethtool_ops ixxat_ethtool_ops = {
+	.get_ts_info = ixxat_ethtool_op_get_ts_info,
+};
+
+/* ixxat_usb_create_ctrl - create a CAN controller for the IXXAT USB device
+ * @intf: pointer to the USB interface
+ * @adapter: pointer to the IXXAT USB adapter structure
+ * @ctrl_index: index of the controller to create
+ * @devdata: pointer to the IXXAT USB device data structure
+ *
+ * This function allocates and initializes a CAN controller for the IXXAT USB
+ * device.
+ *
+ * Returns 0 on success, negative error code on failure.
+ */
+static int ixxat_usb_create_ctrl(struct usb_interface *intf,
+				 const struct ixxat_usb_adapter *adapter,
+				 u16 ctrl_index,
+				 struct ixxat_usb_device_data *devdata)
+{
+	struct usb_device *udev = interface_to_usbdev(intf);
+	struct ixxat_usb_candevice *dev;
+	struct net_device *netdev;
+	u32 ts_clock_divisor, ts_clock_freq;
+	int i, err;
+
+	/* number of echo_skb */
+	netdev = alloc_candev(sizeof(*dev), IXXAT_USB_MAX_MSGS);
+	if (!netdev) {
+		dev_err(&intf->dev, "Cannot allocate candev\n");
+		return -ENOMEM;
+	}
+
+	dev = netdev_priv(netdev);
+
+	dev->shareddata = devdata;
+
+	dev->udev = udev;
+	dev->netdev = netdev;
+	dev->adapter = adapter;
+	dev->loopback = false;
+	dev->ctrl_index = ctrl_index;
+	dev->state = IXXAT_USB_STATE_CONNECTED;
+
+	spin_lock_init(&dev->dev_lock);
+
+	dev->adapter->get_ctrl_caps(dev, &devdata->caps);
+
+	i = ctrl_index + adapter->ep_offs;
+	dev->ep_msg_in = adapter->ep_msg_in[i];
+	dev->ep_msg_out = adapter->ep_msg_out[i];
+
+	dev->can.clock.freq = adapter->clock;
+	dev->can.bittiming_const = adapter->bt;
+	dev->can.fd.data_bittiming_const = adapter->btd;
+	dev->can.fd.tdc_const = adapter->tdc;
+	dev->can.ctrlmode_supported = adapter->modes;
+
+	dev->can.ctrlmode_supported &= ~(CAN_CTRLMODE_LISTENONLY |
+					 CAN_CTRLMODE_ONE_SHOT |
+					 CAN_CTRLMODE_FD |
+					 CAN_CTRLMODE_FD_NON_ISO);
+
+	if (devdata->caps.features & IXXAT_USB_CAN_FEATURE_LISTONLY)
+		dev->can.ctrlmode_supported |= CAN_CTRLMODE_LISTENONLY;
+
+	if (devdata->caps.features & IXXAT_USB_CAN_FEATURE_SSM)
+		dev->can.ctrlmode_supported |= CAN_CTRLMODE_ONE_SHOT;
+
+	if (devdata->caps.features & IXXAT_USB_CAN_FEATURE_ISOFD)
+		dev->can.ctrlmode_supported |= CAN_CTRLMODE_FD;
+
+	if (devdata->caps.features & IXXAT_USB_CAN_FEATURE_NONISOFD)
+		dev->can.ctrlmode_supported |= CAN_CTRLMODE_FD_NON_ISO;
+
+	/* map function */
+	dev->can.do_set_mode = ixxat_usb_set_mode;
+	dev->can.do_get_berr_counter = ixxat_usb_get_berr_counter;
+
+	/* configure communication */
+	init_usb_anchor(&dev->rx_anchor);
+	init_usb_anchor(&dev->tx_anchor);
+
+	atomic_set(&dev->active_tx_urbs, 0);
+
+	for (i = 0; i < IXXAT_USB_MAX_TX_URBS; i++)
+		dev->tx_contexts[i].urb_index = IXXAT_USB_FREE_ENTRY;
+
+	ixxat_usb_msg_free_idx(dev, 0xFFFFFFFF);
+
+	/* configure netdev */
+	netdev->flags |= IFF_ECHO;
+	netdev->netdev_ops = &ixxat_usb_netdev_ops;
+	netdev->ethtool_ops = &ixxat_ethtool_ops;
+	netdev->dev_id = ctrl_index;
+	netdev->dev_port = ctrl_index;
+
+	ts_clock_divisor = le32_to_cpu(devdata->caps.ts_clock_divisor);
+	ts_clock_freq  = le32_to_cpu(devdata->caps.ts_clock_freq);
+
+	ixxat_usb_ts_set_cancaps(&dev->time_ref, ts_clock_divisor,
+				 ts_clock_freq);
+
+	/* link this device into the existing list */
+	dev->prev_dev = usb_get_intfdata(intf);
+	usb_set_intfdata(intf, dev);
+
+	SET_NETDEV_DEV(netdev, &intf->dev);
+	err = register_candev(netdev);
+	if (err) {
+		dev_err(&intf->dev, "Error %d: Failed to register can device\n",
+			err);
+		goto free_candev;
+	}
+
+	netdev->addr_len = sizeof(devdata->dev_info.device_id);
+	dev_addr_mod(netdev, 0, devdata->dev_info.device_id,
+		     sizeof(devdata->dev_info.device_id));
+
+	err = sysfs_create_group(&netdev->dev.kobj, &ixxat_pdev_group);
+	if (err < 0) {
+		netdev_err(netdev, "Error: %d: sysfs group failed\n", err);
+		goto free_candev;
+	}
+
+	netdev_info(netdev, "%.*s: Connected channel %u (device %.*s)\n",
+		    (int)sizeof(devdata->dev_info.device_name),
+		    devdata->dev_info.device_name, ctrl_index,
+		    (int)sizeof(devdata->dev_info.device_id),
+		    devdata->dev_info.device_id);
+
+	return err;
+
+free_candev:
+	/* sashiko-bot v1: missing unregister_candev() */
+	unregister_candev(netdev);
+	usb_set_intfdata(intf, dev->prev_dev);
+	free_candev(netdev);
+
+	return err;
+}
+
+/* ixxat_usb_check_channel - check if the USB interface matches the known
+ * endpoints
+ * @adapter: pointer to the IXXAT USB adapter structure
+ * @host_intf: pointer to the USB host interface descriptor
+ *
+ * This function checks if the endpoints of the USB interface match the known
+ * endpoints for the IXXAT USB adapter. It returns NETDEV_TX_OK if all endpoints
+ * match, otherwise it returns an error code.
+ *
+ * Returns NETDEV_TX_OK on success, or an error code on failure.
+ */
+static int ixxat_usb_check_channel(const struct ixxat_usb_adapter *adapter,
+				   const struct usb_host_interface *host_intf)
+{
+	int match = 0;
+	u16 i;
+
+	for (i = 0; i < host_intf->desc.bNumEndpoints; i++) {
+		const u8 epaddr = host_intf->endpoint[i].desc.bEndpointAddress;
+		u8 j;
+
+		/* Check if USB endpoint address matches known USB endpoints */
+		match = 0;
+		for (j = 0; j < IXXAT_USB_MAX_CHANNEL; j++) {
+			u8 ep_msg_in = adapter->ep_msg_in[j];
+			u8 ep_msg_out = adapter->ep_msg_out[j];
+
+			if (epaddr == ep_msg_in || epaddr == ep_msg_out) {
+				match = 1;
+				break;
+			}
+		}
+
+		if (!match)
+			break;
+	}
+
+	return match ? NETDEV_TX_OK : -ENODEV;
+}
+
+/* ixxat_usb_probe - probe the IXXAT USB device
+ * @intf: pointer to the USB interface
+ * @id: pointer to the USB device ID structure
+ *
+ * This function is called when the USB device is connected.
+ * It initializes the IXXAT USB device, retrieves firmware information,
+ * checks the device capabilities, and creates the CAN controller devices.
+ *
+ * Returns 0 on success, negative error code on failure.
+ */
+static int ixxat_usb_probe(struct usb_interface *intf,
+			   const struct usb_device_id *id)
+{
+	struct usb_device *udev = interface_to_usbdev(intf);
+	const struct ixxat_usb_adapter *adapter;
+	struct ixxat_dev_caps dev_caps = {0};
+	u16 ctrlidx, ctrl_count;
+	int err = 0;
+	struct ixxat_usb_device_data *devdata = NULL;
+	union ixxat_usb_cmd *cmdbuf;
+
+	/* command buffer for USB communication */
+	cmdbuf = kmalloc_obj(*cmdbuf, GFP_KERNEL);
+	if (!cmdbuf) {
+		err = -ENOMEM;
+		goto lbl_err;
+	}
+
+	/* shared data per device */
+	devdata = kzalloc_obj(*devdata, GFP_KERNEL);
+	if (!devdata) {
+		err = -ENOMEM;
+		goto lbl_err;
+	}
+
+	/* init device struct */
+	spin_lock_init(&devdata->access_lock);
+	mutex_init(&devdata->cmd_channel_lock);
+	devdata->cmdbuf = cmdbuf;
+
+	dev_info(&intf->dev, "%s\n", ixxat_usb_dev_name(id));
+
+	/* Power-up the device */
+	err = ixxat_usb_power_ctrl(udev, devdata, IXXAT_USB_POWER_WAKEUP);
+	if (err != NETDEV_TX_OK) {
+		dev_err(&intf->dev,
+			"IXXAT_USB_POWER_WAKEUP failed (err %d)\n",
+			err);
+		goto lbl_err;
+	}
+
+	err = ixxat_usb_get_fw_info(udev, devdata);
+	if (err) {
+		dev_err(&intf->dev, "Failed to get FW info (err %d)\n", err);
+	} else {
+		u32 fw_type = le32_to_cpu(devdata->fw_info.firmware_type);
+
+		/* check FW type */
+		if (fw_type != IXXAT_USB_DEV_FWTYPE_BAL) {
+			dev_err(&intf->dev,
+				"Firmware type %u unknown; %u expected\n",
+				fw_type, IXXAT_USB_DEV_FWTYPE_BAL);
+			err = -EFAULT;
+		} else {
+			/* check if FW supports get_fw_info2 command and use it
+			 * to get additional info
+			 */
+			if (ixxat_usb_has_cl2_firmware(id, &devdata->fw_info)) {
+				err = ixxat_usb_get_fw_info2(udev, devdata);
+				if (err) {
+					dev_err(&intf->dev,
+						"Failed to get info2: err %d\n",
+						err);
+					goto lbl_err;
+				}
+			}
+
+			/* check FW version */
+			err = ixxat_usb_check_firmware(intf, id, devdata);
+			if (err)
+				goto lbl_err;
+		}
+	}
+
+	if (err) {
+		dev_warn(&intf->dev, "A firmware update may be required\n");
+		adapter = ixxat_usb_get_adapter(id, NULL);
+	} else {
+		adapter = ixxat_usb_get_adapter(id, &devdata->fw_info);
+	}
+
+	if (!adapter) {
+		dev_err(&intf->dev, KBUILD_MODNAME ": Unknown device id %d\n",
+			id->idProduct);
+		err = -ENODEV;
+		goto lbl_err;
+	}
+
+	err = ixxat_usb_check_channel(adapter, intf->altsetting);
+	if (err != NETDEV_TX_OK)
+		goto lbl_err;
+
+	err = ixxat_usb_get_dev_info(udev, devdata);
+	if (err) {
+		dev_err(&intf->dev,
+			"Failed to get device information (err %d)\n", err);
+		goto lbl_err;
+	}
+
+	err = ixxat_usb_get_dev_caps(udev, devdata, &dev_caps);
+	if (err) {
+		dev_err(&intf->dev,
+			"Failed to get device capabilities (err %d)\n", err);
+		goto lbl_err;
+	}
+
+	err = -ENODEV;
+
+	ctrl_count = le16_to_cpu(dev_caps.bus_ctrl_count);
+	for (ctrlidx = 0; ctrlidx < ctrl_count; ctrlidx++) {
+		u16 dev_bustype = le16_to_cpu(dev_caps.bus_ctrl_types[ctrlidx]);
+		u8 bustype = FIELD_GET(IXXAT_USB_BUSTYPE_MASK, dev_bustype);
+
+		if (bustype != IXXAT_USB_BUSTYPE_CAN)
+			continue;
+
+		err = ixxat_usb_create_ctrl(intf, adapter, ctrlidx, devdata);
+		if (err) {
+			/* Deregister already created devices */
+			ixxat_usb_disconnect(intf);
+
+			/* sashiko-bot v1:
+			 * if 1st device creation failed, then shared resources
+			 * must be released too.
+			 */
+			if (!ctrlidx)
+				goto lbl_err;
+
+			/* Otherwise, they have been released by
+			 * ixxat_usb_disconnect().
+			 */
+			return err;
+		}
+	}
+
+	return 0;
+
+lbl_err:
+	kfree(cmdbuf);
+	kfree(devdata);
+	return err;
+}
+
+static struct usb_driver ixxat_usb_driver = {
+	.name = KBUILD_MODNAME,
+	.probe = ixxat_usb_probe,
+	.disconnect = ixxat_usb_disconnect,
+	.id_table = ixxat_usb_table,
+};
+
+module_usb_driver(ixxat_usb_driver);
diff --git a/drivers/net/can/usb/ixxat_usb/ixxat_usb_core.h b/drivers/net/can/usb/ixxat_usb/ixxat_usb_core.h
new file mode 100644
index 000000000000..423a280d8c4c
--- /dev/null
+++ b/drivers/net/can/usb/ixxat_usb/ixxat_usb_core.h
@@ -0,0 +1,767 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* CAN driver base for IXXAT USB-to-CAN
+ *
+ * Copyright (C) 2018-2024 HMS Industrial Networks <socketcan@hms-networks.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published
+ * by the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ */
+
+#ifndef IXXAT_USB_CORE_H
+#define IXXAT_USB_CORE_H
+
+#include <linux/types.h>
+#include <linux/bitfield.h>
+#include <linux/spinlock_types.h>
+#include <linux/usb.h>
+#include <linux/can/dev.h>
+
+/* supported bus types */
+#define IXXAT_USB_BUSTYPE_CAN		1
+
+/* bus type: high-order byte */
+#define IXXAT_USB_BUSTYPE_BITS		8
+#define IXXAT_USB_BUSTYPE_MASK		GENMASK(IXXAT_USB_BUSTYPE_BITS + 7, 8)
+
+#define IXXAT_USB_STATE_CONNECTED	BIT(0)
+#define IXXAT_USB_STATE_STARTED		BIT(1)
+
+#define IXXAT_USB_FREE_ENTRY		0xFFFF
+
+#define IXXAT_USB_MAX_CHANNEL		5
+#define IXXAT_USB_MAX_TYPES		32
+#define IXXAT_USB_MAX_RX_URBS		4
+#define IXXAT_USB_MAX_TX_URBS		10
+
+#define IXXAT_USB_DEV_FWTYPE_BAL	3	/* BAL conform FW */
+
+#define IXXAT_USB_OPMODE_STANDARD	BIT(0)
+#define IXXAT_USB_OPMODE_EXTENDED	BIT(1)
+#define IXXAT_USB_OPMODE_ERRFRAME	BIT(2)
+#define IXXAT_USB_OPMODE_LISTONLY	BIT(3)
+
+#define IXXAT_USB_EXMODE_EXTDATA	BIT(0)
+#define IXXAT_USB_EXMODE_FASTDATA	BIT(1)
+#define IXXAT_USB_EXMODE_ISOFD		BIT(2)
+
+#define IXXAT_USB_BTMODE_NAT		BIT(0)
+#define IXXAT_USB_BTMODE_TSM		BIT(1)
+
+#define IXXAT_USB_STOP_ACTION_CLEARALL	3
+
+#define IXXAT_USB_CAN_FEATURE_LISTONLY	BIT(6)   /* listen only mode */
+#define IXXAT_USB_CAN_FEATURE_SSM	BIT(10)  /* single shot mode */
+#define IXXAT_USB_CAN_FEATURE_ISOFD	BIT(15)  /* i: ISO CAN FD */
+#define IXXAT_USB_CAN_FEATURE_NONISOFD	BIT(16)  /* i: non-ISO CAN FD */
+
+#define IXXAT_USB_CAN_DATA		0x00
+#define IXXAT_USB_CAN_INFO		0x01
+#define IXXAT_USB_CAN_ERROR		0x02
+#define IXXAT_USB_CAN_STATUS		0x03
+#define IXXAT_USB_CAN_WAKEUP		0x04
+#define IXXAT_USB_CAN_TIMEOVR		0x05
+#define IXXAT_USB_CAN_TIMERST		0x06
+
+#define IXXAT_USB_CAN_STATUS_OK		0
+#define IXXAT_USB_CAN_STATUS_OVERRUN	BIT(1)
+#define IXXAT_USB_CAN_STATUS_ERRLIM	BIT(2)
+#define IXXAT_USB_CAN_STATUS_BUSOFF	BIT(3)
+#define IXXAT_USB_CAN_STATUS_ERR_PAS	BIT(13)
+
+#define IXXAT_USB_CAN_ERROR_CODE	0
+#define IXXAT_USB_CAN_ERROR_COUNTER_RX	3
+#define IXXAT_USB_CAN_ERROR_COUNTER_TX	4
+#define IXXAT_USB_CAN_ERROR_LEN		5
+
+#define IXXAT_USB_CAN_ERROR_STUFF	1
+#define IXXAT_USB_CAN_ERROR_FORM	2
+#define IXXAT_USB_CAN_ERROR_ACK		3
+#define IXXAT_USB_CAN_ERROR_BIT		4
+#define IXXAT_USB_CAN_ERROR_CRC		6
+
+#define IXXAT_USB_MSG_FLAGS_TYPE_MASK	GENMASK(7, 0)
+#define IXXAT_USB_MSG_FLAGS_DLC_MASK	GENMASK(19, 16)
+#define IXXAT_USB_MSG_FLAGS_OVR		BIT(20)
+#define IXXAT_USB_MSG_FLAGS_SRR		BIT(21)
+#define IXXAT_USB_MSG_FLAGS_RTR		BIT(22)
+#define IXXAT_USB_MSG_FLAGS_EXT		BIT(23)
+
+#define IXXAT_USB_MSG_FLAGS_SINGLESHOT	BIT(8)
+
+#define IXXAT_USB_FDMSG_FLAGS_EDL	BIT(10)
+#define IXXAT_USB_FDMSG_FLAGS_FDR	BIT(11)
+#define IXXAT_USB_FDMSG_FLAGS_ESI	BIT(12)
+
+/* USB command timeout values  */
+/* for IXXAT_USB_BRD_CMD_POWER (wakeup/sleep) */
+#define IXXAT_USB_POWER_CMD_TIMEOUT	500
+
+/* for other commands */
+#define IXXAT_USB_CMD_TIMEOUT		100
+
+/* port/socket index to address board functionality */
+#define IXXAT_USB_BRD_PORT		0xffff
+#define IXXAT_USB_BRD_SOCKET		0xffff
+
+/* CAN related commands*/
+#define IXXAT_USB_CAN_CMD_START		0x326
+#define IXXAT_USB_CAN_CMD_STOP		0x327
+#define IXXAT_USB_CAN_CMD_RESET		0x328
+
+/* board related commands */
+#define IXXAT_USB_BRD_CMD_GET_FWINFO	0x400
+#define IXXAT_USB_BRD_CMD_GET_DEVCAPS	0x401
+#define IXXAT_USB_BRD_CMD_GET_DEVINFO	0x402
+#define IXXAT_USB_BRD_CMD_GET_FWINFO2	0x403
+#define IXXAT_USB_BRD_CMD_POWER		0x421
+
+/* struct ixxat_can_msg_base - IXXAT CAN message base (CL1/CL2)
+ * @size: Message size (this field excluded)
+ * @time: Message timestamp
+ * @msg_id: Message ID
+ * @flags: Message flags
+ *
+ * Contains the common fields of an IXXAT CAN message on both CL1 and CL2
+ * devices
+ */
+struct ixxat_can_msg_base {
+	u8 size;
+	__le32 time;
+	__le32 msg_id;
+	__le32 flags;
+} __packed;
+
+/* struct ixxat_can_msg_cl1 - IXXAT CAN message (CL1)
+ * @data: Message data (standard CAN frame)
+ *
+ * Contains the fields of an IXXAT CAN message on CL1 devices
+ */
+struct ixxat_can_msg_cl1 {
+	u8 data[CAN_MAX_DLEN];
+} __packed;
+
+/* struct ixxat_can_msg_cl2 - IXXAT CAN message (CL2)
+ * @client_id: Client ID
+ * @data: Message data (CAN FD frame)
+ *
+ * Contains the fields of an IXXAT CAN message on CL2 devices
+ */
+struct ixxat_can_msg_cl2 {
+	__le32 client_id;
+	u8 data[CANFD_MAX_DLEN];
+} __packed;
+
+/* struct ixxat_can_msg - IXXAT CAN message
+ * @base: Base message
+ * @cl1: Cl1 message
+ * @cl2: Cl2 message
+ *
+ * Contains an IXXAT CAN message
+ */
+struct ixxat_can_msg {
+	struct ixxat_can_msg_base base;
+	union {
+		struct ixxat_can_msg_cl1 cl1;
+		struct ixxat_can_msg_cl2 cl2;
+	};
+} __packed;
+
+/* struct ixxat_dev_caps - Device capabilities
+ * @bus_ctrl_count: Stores the bus controller counter
+ * @bus_ctrl_types: Stores the bus controller types
+ *
+ * Contains the device capabilities
+ */
+struct ixxat_dev_caps {
+	__le16 bus_ctrl_count;
+	__le16 bus_ctrl_types[IXXAT_USB_MAX_TYPES];
+} __packed;
+
+/* struct ixxat_canbtp Bittiming parameters (CL2)
+ * @mode: Operation mode
+ * @bps: Bits per second
+ * @ts1: First time segment
+ * @ts2: Second time segment
+ * @sjw: Synchronization jump width
+ * @tdo: Transmitter delay offset
+ *
+ * Bittiming parameters of a CL2 initialization request
+ */
+struct ixxat_canbtp {
+	__le32 mode;
+	__le32 bps;
+	__le16 ts1;
+	__le16 ts2;
+	__le16 sjw;
+	__le16 tdo;
+} __packed;
+
+/* struct ixxat_dev_info IXXAT USB device information
+ * @device_name: Name of the device
+ * @device_id: Device identification (unique device id)
+ * @device_version: Device version (0, 1, ...)
+ * @device_fpga_version: Version of FPGA design
+ *
+ * Contains device information of IXXAT USB devices
+ */
+struct ixxat_dev_info {
+	char device_name[16];
+	char device_id[16];
+	__le16 device_version;
+	__le32 device_fpga_version;
+} __packed;
+
+/* struct ixxat_fw_info IXXAT USB device firmware information
+ * @firmware_type: type of currently running firmware
+ * @major_version: major firmware version number
+ * @minor_version: minor firmware version number
+ * @build_version: build firmware version number
+ *
+ * Contains device information of IXXAT USB devices
+ */
+struct ixxat_fw_info {
+	__le32 firmware_type;
+	__le16 res;
+	__le16 major_version;
+	__le16 minor_version;
+	__le16 build_version;
+} __packed;
+
+/* struct ixxat_fw_info2 IXXAT USB device firmware information
+ * @firmware_type: type of currently running firmware
+ * @major_version: major firmware version number
+ * @minor_version: minor firmware version number
+ * @build_version: build firmware version number
+ * @revision     : revision number
+ *
+ * Contains device information of IXXAT USB devices
+ */
+struct ixxat_fw_info2 {
+	__le32 firmware_type;
+	__le16 res;
+	__le16 major_version;
+	__le16 minor_version;
+	__le16 build_version;
+	__le16 revision;
+} __packed;
+
+/* struct ixxat_cancaps CAN controller capabilities
+ * ctrltype;		Type of CAN controller (see IXXAT_USB_CAN_CTRL_ const)
+ * buscoupling;		Type of Bus coupling (see IXXAT_USB_CAN_BUSC_ const)
+ * features;		supported features (see IXXAT_USB_CAN_FEATURE_ constants)
+ * can_clock_freq:	clock frequency of the primary counter in Hz
+ * ts_clock_divisor:	divisor for the message time stamp counter
+ * cms_clock_divisor:	divisor for the cyclic message scheduler
+ * cms_max_ticks:	maximum tick count value of the cyclic message
+ *			scheduler
+ * dtx_clock_divisor:	divisor for the delayed message transmitter
+ * dtx_max_ticks:	maximum tick count value of the delayed
+ *			message transmitter
+ *
+ * Contains CAN controller capabilities information
+ */
+struct ixxat_cancaps {
+	__le16 ctrltype;
+	__le16 buscoupling;
+	__le32 features;
+	__le32 can_clock_freq;
+	__le32 ts_clock_divisor;
+	__le32 cms_clock_divisor;
+	__le32 cms_max_ticks;
+	__le32 dtx_clock_divisor;
+	__le32 dtx_max_ticks;
+} __packed;
+
+/* struct ixxat_cancaps2 CANFD controller capabilities
+ * ctrltype;		Type of CAN controller (see IXXAT_USB_CAN_CTRL_ const)
+ * buscoupling;		Type of Bus coupling (see IXXAT_USB_CAN_BUSC_ const)
+ * features;		supported features (see IXXAT_USB_CAN_FEATURE_ constants)
+ * can_clock_freq:	CAN clock frequency in Hz (16/2 MHz for SJA1000)
+ * sdr_range_min;	minimum bit timing values for standard bit rate
+ * sdr_range_max;	maximum bit timing values for standard bit rate
+ * fdr_range_min;	minimum bit timing values for fast data bit rate
+ * fdr_range_max;	maximum bit timing values for fast data bit rate
+ * ts_clock_freq;	clock frequency of the time stamp counter [Hz]
+ * ts_clock_divisor;	divisor for the message time stamp counter
+ * cms_clock_freq;	clock frequency of cyclic message scheduler [Hz]
+ * cms_clock_divisor;	divisor for the cyclic message scheduler
+ * cms_max_ticks;	maximum tick count value of the cyclic message
+ *			scheduler
+ * dtx_clock_freq;	clock frequency of the delayed message transmitter [Hz]
+ * dtx_clock_divisor;	divisor for the delayed message transmitter
+ * dtx_max_ticks;	maximum tick count value of the delayed
+ *			message transmitter
+ *
+ * Contains CANFD controller capabilities information
+ */
+struct ixxat_cancaps2 {
+	__le16 ctrltype;
+	__le16 buscoupling;
+	__le32 features;
+	__le32 can_clock_freq;
+	struct ixxat_canbtp sdr_range_min;
+	struct ixxat_canbtp sdr_range_max;
+	struct ixxat_canbtp fdr_range_min;
+	struct ixxat_canbtp fdr_range_max;
+	__le32 ts_clock_freq;
+	__le32 ts_clock_divisor;
+	__le32 cms_clock_freq;
+	__le32 cms_clock_divisor;
+	__le32 cms_max_ticks;
+	__le32 dtx_clock_freq;
+	__le32 dtx_clock_divisor;
+	__le32 dtx_max_ticks;
+} __packed;
+
+/* Device timestamps
+ *
+ * Every device maintains an internal clock used for message timestamps.
+ * The resolution of the clock is reported by the controller capabilities and
+ * denotes the resolution of one clock tick by the two values:
+ * ts_clock_freq/ts_clock_divisor
+ * The following timeline occurs during the operation of a controller:
+ *
+ *         t_start                                      t_stop
+ *     <------------>                               <------------>
+ *
+ *     A            B           D                   E            F          H
+ *     |            |           |                   |            |          |
+ *     v            v           v                   v            v          v
+ *  ---------------------------------~  ...  ~----------------------------------> t
+ *           ^                                            ^
+ *           |                                            |
+ *           C                                            G
+ *
+ * A: controller start command (request) is sent to the device
+ * B: controller start command (response) returns from device and returns device
+ *    time stamp of C
+ * C: assumed CAN controller start time stamp, it is assumed to be in the middle
+ *     between A and B (A + (t_start/2))
+ * D: controller start info message arrives over the message fifo, it contains
+ *    the device time stamp of C, too
+ * E: controller stop command (request) is sent to the device
+ * F: controller stop command (response) returns
+ * G: assumed CAN controller stop time stamp, it is assumed to be in the middle
+ *    between E and F (E + (t_stop/2))
+ * H: controller stop info message arrives over the message fifo, it contains
+ *    the device time stamp of G
+ *
+ * To correlate the start timestamp to the host clock we determine:
+ *
+ *     t_host_C = (t_host_B + t_host_A) / 2
+ *              = t_host_A + ((t_host_B - t_host_A) / 2)
+ *
+ * t_C_host then corresponds to the device clock tick at C (t_C_device).
+ * The current time stamp correlated to the host clock (t_current_host) can then
+ * be determined via
+ *
+ *     t_host_current = t_host_C + conv_to_nsec(t_dev_current - t_dev_C)
+ *
+ * struct ixxat_time_ref Time reference
+ * tick_multiplier:	used to convert ticks to ns
+ * tick_divider:	used to convert ticks to ns
+ * @ts_overrun_ticks:	number of timer overruns since start
+ *
+ * Contains time references of the device and the host
+ */
+struct ixxat_time_ref {
+	u64 tick_multiplier;
+	u64 tick_divider;
+	u64 ts_overrun_ticks;
+};
+
+/* struct ixxat_tx_urb_context URB content for transmission
+ * @dev: pointer to the IXXAT USB CAN device
+ * @urb: USB request block
+ * @urb_index: index of this URB (used to mark the context as occupied)
+ * @msg_index: index of message (client_id)
+ *
+ * Contains content for USB request block transmissions
+ */
+struct ixxat_tx_urb_context {
+	struct ixxat_usb_candevice *dev;
+	struct urb *urb;
+	u16  urb_index;
+	u16  msg_index;
+};
+
+/* struct ixxat_usb_candevice IXXAT USB CAN device
+ * @can: CAN common private data
+ * @adapter: USB network descriptor
+ * @udev: USB device
+ * @netdev: Net_device
+ * @active_tx_urbs: Active tx urbs
+ * @tx_anchor: Submitted tx USB anchor
+ * @tx_contexts: Buffer for tx contexts
+ * @rx_anchor: Submitted rx USB anchor
+ * @msgs: store to set the used message indexes
+ * @msg_lastindex: last index which was set
+ * @loopback:  global loopback
+ * @state: Device state
+ * @ctrl_index: Controller index
+ * @ep_msg_in: USB endpoint for incoming messages
+ * @ep_msg_out: USB endpoint for outgoing messages
+ * @prev_dev: Previous opened device
+ * @time_ref: Time reference
+ * @dev_info: Device information
+ * @bec: CAN error counter
+ *
+ * IXXAT USB based CAN device
+ */
+struct ixxat_usb_candevice {
+	struct can_priv can;
+	const struct ixxat_usb_adapter *adapter;
+	struct usb_device *udev;
+	struct net_device *netdev;
+
+	atomic_t active_tx_urbs;
+	struct usb_anchor tx_anchor;
+	struct ixxat_tx_urb_context tx_contexts[IXXAT_USB_MAX_TX_URBS];
+
+	struct usb_anchor rx_anchor;
+	void  *rx_buf[IXXAT_USB_MAX_RX_URBS];
+
+	u32 msgs;
+	u32 msg_lastindex;
+
+	bool loopback;
+	u32 state;
+	u16 ctrl_index;
+
+	u8 ep_msg_in;
+	u8 ep_msg_out;
+
+	/* This lock prevents a race condition between xmit and receive. */
+	spinlock_t dev_lock;
+
+	/* pointer to shared USB device data  */
+	struct ixxat_usb_device_data *shareddata;
+
+	/* used to link can devices together */
+	struct ixxat_usb_candevice *prev_dev;
+
+	struct ixxat_time_ref time_ref;
+
+	struct can_berr_counter bec;
+};
+
+/* struct ixxat_usb_dal_req IXXAT device request block
+ * @size: Request size
+ * @port: Request port
+ * @socket: Request socket
+ * @code: Request code
+ *
+ * IXXAT device request block
+ */
+struct ixxat_usb_dal_req {
+	__le32 size;
+	__le16 port;
+	__le16 socket;
+	__le32 code;
+} __packed;
+
+/* struct ixxat_usb_dal_res IXXAT device response block
+ * @res_size: Expected response size
+ * @ret_size: Actual response size
+ * @code: Return code
+ *
+ * IXXAT device response block
+ */
+struct ixxat_usb_dal_res {
+	__le32 res_size;
+	__le32 ret_size;
+	__le32 code;
+} __packed;
+
+/* struct ixxat_usb_dal_cmd IXXAT device command
+ * @req: Request block
+ * @req: Response block
+ *
+ * IXXAT device command
+ */
+struct ixxat_usb_dal_cmd {
+	struct ixxat_usb_dal_req req;
+	struct ixxat_usb_dal_res res;
+} __packed;
+
+/* struct ixxat_usb_caps_cmd Device capabilities command
+ * @req: Request block
+ * @res: Response block
+ * @caps: Device capabilities
+ *
+ * Can be sent to a device to request its capabilities
+ */
+struct ixxat_usb_caps_cmd {
+	struct ixxat_usb_dal_req req;
+	struct ixxat_usb_dal_res res;
+	struct ixxat_dev_caps caps;
+	__le16 rsvd;
+} __packed;
+
+/* struct ixxat_usb_init_cl1_cmd Initialization command (CL1)
+ * @req: Request block
+ * @mode: Operation mode
+ * @btr0: Bittiming register 0
+ * @btr1: Bittiming register 1
+ * @padding: 1 byte padding
+ * @res: Response block
+ *
+ * Can be sent to a CL1 device to initialize it
+ */
+struct ixxat_usb_init_cl1_cmd {
+	struct ixxat_usb_dal_req req;
+	u8 mode;
+	u8 btr0;
+	u8 btr1;
+	u8 padding;
+	struct ixxat_usb_dal_res res;
+} __packed;
+
+/* struct ixxat_usb_init_cl2_cmd Initialization command (CL2)
+ * @req: Request block
+ * @opmode: Operation mode
+ * @exmode: Extended mode
+ * @sdr: Standard bittiming parameters
+ * @fdr: Fast data bittiming parameters
+ * @_padding: 2 bytes padding
+ * @res: Response block
+ *
+ * Can be sent to a CL2 device to initialize it
+ */
+struct ixxat_usb_init_cl2_cmd {
+	struct ixxat_usb_dal_req req;
+	u8 opmode;
+	u8 exmode;
+	struct ixxat_canbtp sdr;
+	struct ixxat_canbtp fdr;
+	__le16 _padding;
+	struct ixxat_usb_dal_res res;
+} __packed;
+
+/* struct ixxat_usb_getcaps_cl1_cmd Controller read capabilities
+ * @req: Request block
+ * @res: Response block
+ * @caps: Controller capabilities
+ *
+ * Can be sent to a device to get the controller capabilities
+ */
+struct ixxat_usb_getcaps_cl1_cmd {
+	struct ixxat_usb_dal_req req;
+	struct ixxat_usb_dal_res res;
+	struct ixxat_cancaps caps;
+} __packed;
+
+/* struct ixxat_usb_getcaps_cl2_cmd Controller read capabilities
+ * @req: Request block
+ * @res: Response block
+ * @caps: Controller capabilities
+ *
+ * Can be sent to a device to get the controller capabilities
+ */
+struct ixxat_usb_getcaps_cl2_cmd {
+	struct ixxat_usb_dal_req req;
+	struct ixxat_usb_dal_res res;
+	struct ixxat_cancaps2 caps;
+} __packed;
+
+/* struct ixxat_usb_start_cmd Controller start command
+ * @req: Request block
+ * @res: Response block
+ * @time: Timestamp
+ *
+ * Can be sent to a device to start its controller
+ */
+struct ixxat_usb_start_cmd {
+	struct ixxat_usb_dal_req req;
+	struct ixxat_usb_dal_res res;
+	__le32 time;
+} __packed;
+
+/* struct ixxat_usb_stop_cmd Controller stop command
+ * @req: Request block
+ * @action: Stop action
+ * @res: Response block
+ *
+ * Can be sent to a device to start its controller
+ */
+struct ixxat_usb_stop_cmd {
+	struct ixxat_usb_dal_req req;
+	__le32 action;
+	struct ixxat_usb_dal_res res;
+} __packed;
+
+/* struct ixxat_usb_power_cmd Power command
+ * @req: Request block
+ * @mode: Power mode
+ * @_padding1: 1 byte padding
+ * @_padding2: 2 byte padding
+ * @res: Response block
+ *
+ * Can be sent to a device to set its power mode
+ */
+struct ixxat_usb_power_cmd {
+	struct ixxat_usb_dal_req req;
+	u8 mode;
+	u8 _padding1;
+	__le16 _padding2;
+	struct ixxat_usb_dal_res res;
+} __packed;
+
+/* struct ixxat_usb_info_cmd Device information command
+ * @req: Request block
+ * @res: Response block
+ * @info: Device information
+ *
+ * Can be sent to a device to request its device information
+ */
+struct ixxat_usb_info_cmd {
+	struct ixxat_usb_dal_req req;
+	struct ixxat_usb_dal_res res;
+	struct ixxat_dev_info info;
+	__le16 rsvd;
+} __packed;
+
+/* struct ixxat_usb_fwinfo_cmd Firmware information command
+ * @req: Request block
+ * @res: Response block
+ * @info: Firmware information
+ *
+ * Can be sent to a device to request its firmware information
+ */
+struct ixxat_usb_fwinfo_cmd {
+	struct ixxat_usb_dal_req req;
+	struct ixxat_usb_dal_res res;
+	struct ixxat_fw_info info;
+} __packed;
+
+/* struct ixxat_usb_fwinfo2_cmd Firmware information command
+ * @req: Request block
+ * @res: Response block
+ * @info: Firmware information
+ *
+ * Can be sent to a device to request its firmware information
+ */
+struct ixxat_usb_fwinfo2_cmd {
+	struct ixxat_usb_dal_req req;
+	struct ixxat_usb_dal_res res;
+	struct ixxat_fw_info2 info;
+} __packed;
+
+/* USB command buffer */
+union ixxat_usb_cmd {
+	struct ixxat_usb_caps_cmd caps;
+	struct ixxat_usb_info_cmd info;
+	struct ixxat_usb_fwinfo_cmd fwinfo;
+	struct ixxat_usb_fwinfo2_cmd fwinfo2;
+	struct ixxat_usb_start_cmd start;
+	struct ixxat_usb_stop_cmd stop;
+	struct ixxat_usb_power_cmd power;
+	struct ixxat_usb_dal_cmd dal;
+
+	struct ixxat_usb_init_cl1_cmd cl1;
+	struct ixxat_usb_getcaps_cl1_cmd caps_cl1;
+
+	struct ixxat_usb_init_cl2_cmd cl2;
+	struct ixxat_usb_getcaps_cl2_cmd caps_cl2;
+};
+
+/* struct ixxat_usb_device_data IXXAT USB device data
+ * @timeref_valid: Time reference valid
+ * @kt_host_start: Host start time
+ * @ts_dev_start: Device start time
+ */
+struct ixxat_usb_device_data {
+	/* used to lock write access to the device members */
+	spinlock_t access_lock;
+
+	/* lock access to command channel on endpoint 0 */
+	struct mutex cmd_channel_lock;
+
+	/* device and firmware info */
+	struct ixxat_dev_info dev_info;
+	struct ixxat_fw_info2 fw_info;
+
+	/* controller capabilities */
+	struct ixxat_cancaps2 caps;
+
+	/* time reference of first controller start */
+	bool    timeref_valid;
+	ktime_t kt_host_start;
+	u32     ts_dev_start;
+
+	/* USB commands buffer */
+	union ixxat_usb_cmd *cmdbuf;
+};
+
+/* struct ixxat_usb_adapter IXXAT USB device adapter
+ * @clock: Clock frequency
+ * @bt: Bittiming constants
+ * @btd: Data bittiming constants
+ * @tdc: Transmission Delay Compensation constants
+ * @modes: Supported modes
+ * @buffer_size_rx: Buffer size for receiving
+ * @buffer_size_tx: Buffer size for transfer
+ * @ep_msg_in: USB endpoint buffer for incoming messages
+ * @ep_msg_out: USB endpoint buffer for outgoing messages
+ * @ep_offs: Endpoint offset (device depended)
+ * @cl1_msg_format: Set if the device uses the CL1 CAN message wire format
+ *
+ * Device Adapter for IXXAT USB devices
+ */
+struct ixxat_usb_adapter {
+	const u32 modes;
+	const u32 clock;
+	const struct can_bittiming_const *bt;
+	const struct can_bittiming_const *btd;
+	const struct can_tdc_const *tdc;
+	const u16 buffer_size_rx;
+	const u16 buffer_size_tx;
+	const u8 ep_msg_in[IXXAT_USB_MAX_CHANNEL];
+	const u8 ep_msg_out[IXXAT_USB_MAX_CHANNEL];
+	const u8 ep_offs;
+	const bool cl1_msg_format;
+
+	int (*get_ctrl_caps)(struct ixxat_usb_candevice *dev,
+			     struct ixxat_cancaps2 *caps);
+	int (*init_ctrl)(struct ixxat_usb_candevice *dev);
+};
+
+/* ixxat_usb_setup_cmd() - Setup a device command
+ * @req: Request block
+ * @res: Response block
+ *
+ * This function sets the default values in the request and the response block
+ * of a device command
+ */
+void ixxat_usb_setup_cmd(struct ixxat_usb_dal_req *req,
+			 struct ixxat_usb_dal_res *res);
+
+/* ixxat_usb_send_cmd - send a command to the IXXAT USB device
+ * @dev: pointer to the USB device
+ * @port: port number to send the command to
+ * @cmd: pointer to the entire command buffer to send,
+ *       - starting with a struct ixxat_usb_dal_req object,
+ *       - ending with a struct ixxat_usb_dal_res object
+ * @cmd_size: size of the whole command (>= sizeof(struct ixxat_usb_dal_cmd))
+ * @res: pointer to the response structure
+ * @res_size: size of the response structure (>= sizeof(struct ixxat_usb_dal_res)
+ * @cmd_delay: delay in milliseconds to wait for a response
+ *
+ * This function sends a command to the IXXAT USB device and waits for the
+ * response, if it is still connected.
+ *
+ * Returns >= 0 on success, negative error code on failure.
+ * If the device is disconnected it returns -ENODEV.
+ */
+int ixxat_usb_send_cmd(struct ixxat_usb_candevice *pdev, const u16 port,
+		       struct ixxat_usb_dal_req *cmd, u16 cmd_size,
+		       struct ixxat_usb_dal_res *res, u16 res_size,
+		       const unsigned long cmd_delay);
+
+#endif /* IXXAT_USB_CORE_H */

-- 
2.53.0

