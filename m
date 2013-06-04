From: "Max S." <max@schneidersoft.net>
Subject: Re: Usb to can driver
Date: Tue, 04 Jun 2013 13:18:18 +0000
Message-ID: <1370351898.3785.16.camel@blackbox>
References: <1366737302.3325.36.camel@blackbox>
	 <51770161.2030005@pengutronix.de> <1366818490.5965.35.camel@blackbox>
	 <51780336.5060800@pengutronix.de> <1366839193.7226.8.camel@blackbox>
	 <5194C5B2.7060004@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-7Br6vOUjTkrxT6lidaJK"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.schneidersoft.net ([173.45.248.65]:60636 "EHLO
	mail.schneidersoft.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317Ab3FDNSm (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 4 Jun 2013 09:18:42 -0400
In-Reply-To: <5194C5B2.7060004@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can <linux-can@vger.kernel.org>


--=-7Br6vOUjTkrxT6lidaJK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hello all,

I've 'rebranded' the entire driver to Geschwister Schneider
Technologie-, Entwicklungs- und Vertriebs UG. using gs_ for structs,
enums and function names.

Regarding the dma on the stack errors, where do you see these messages? I have modified the code (see patch attached), and they should no longer appear.

I have sent an email to the openmoko people, and will update the product/vender code when i get a response.

There are still some things I'd like to work out:
In the driver i do netdev->flags |= IFF_ECHO; to tell the netdev subsystem i will be handling message delivery tracking.
via can_free_echo_skb, can_get_echo_skb, can_put_echo_skb...

I read in the 8devices driver:
dev->can.ctrlmode_supported = ...
				CAN_CTRLMODE_LOOPBACK |
				...

An in documentation/networking/can.txt:
To reflect the correct* traffic on the node the loopback of the sent data has to be performed right after a successful transmission.

what is the difference between IFF_ECHO and CAN_CTRLMODE_LOOPBACK? loopback is default behavior...
How should my driver/device behave differently when loopback is not enabled?

Currently when the CAN controller fails to send a can frame, for example when there is no other node to ack it, my firmware will produce an error frame and queue it for the host.
Since the can controller will immediately retry transmission, if the error condition persists this means error frames will continually be sent to the host.
Is this acceptable behavior? I think it would be better to find a way to throttle repetitive error frames.

I have done some testing with higher can speeds and run into the following kernel panic (netconsole extract):

[ 1784.427960] gs_usb 4-1:1.0: can_put_echo_skb: BUG! echo_skb is
occupied!
[ 1784.493869] gs_usb 4-1:1.0: can_put_echo_skb: BUG! echo_skb is
occupied!
[ 1784.745668] ------------[ cut here ]------------
[ 1784.745701] kernel BUG
at /build/buildd-linux_3.2.35-2-amd64-v9djlH/linux-3.2.35/drivers/net/can/dev.c:283!
[ 1784.745719] invalid opcode: 0000 [#1] SMP 
[ 1784.745740] CPU 2 
[ 1784.745750] Modules linked in: can_raw can gs_usb(O) netconsole
configfs can_dev ppdev lp rfcomm bnep bluetooth crc16 cpufreq_stats
cpufreq_userspace cpufreq_powersave cpufreq_conservative fuse nfsd nfs
nfs_acl auth_rpcgss fscache lockd sunrpc usbhid hid pcan(O) loop arc4
rt2800usb rt2x00usb rt2800lib rt2x00lib mac80211 cfg80211 rfkill
crc_ccitt evdev psmouse snd_hda_intel coretemp serio_raw snd_hda_codec
i2c_i801 snd_hwdep pcspkr i2c_core snd_pcm snd_page_alloc snd_seq
snd_seq_device snd_timer parport_pc iTCO_wdt parport iTCO_vendor_support
snd uhci_hcd video acpi_cpufreq mperf ehci_hcd usbcore e1000e soundcore
button usb_common processor thermal_sys ext2 mbcache sd_mod crc_t10dif
ahci libahci libata scsi_mod
[ 1784.746265] 
[ 1784.746276] Pid: 7786, comm: cansequence Tainted: G           O
3.2.0-4-amd64 #1 Debian 3.2.35-2                  /DN2800MT
[ 1784.746297] RIP: 0010:[<ffffffffa03d9552>]  [<ffffffffa03d9552>]
can_put_echo_skb+0x16/0x106 [can_dev]
[ 1784.746319] RSP: 0018:ffff880117265b38  EFLAGS: 00010246
[ 1784.746327] RAX: ffff880117126938 RBX: ffff88012946e8c0 RCX:
ffff88012a8da090
[ 1784.746336] RDX: 000000000000000a RSI: ffff880117126000 RDI:
ffff88012946e8c0
[ 1784.746344] RBP: ffff880117126000 R08: ffff88012a8da090 R09:
0000000000000018
[ 1784.746352] R10: 000000000000ffff R11: 0000000000000246 R12:
ffff880037c102a0
[ 1784.746361] R13: ffff88012946e8c0 R14: ffff880117126870 R15:
ffff880117126000
[ 1784.746370] FS:  00007fcfbc52c700(0000) GS:ffff88012fd00000(0000)
knlGS:0000000000000000
[ 1784.746379] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[ 1784.746387] CR2: 00007fc450074e38 CR3: 0000000129e6f000 CR4:
00000000000006e0
[ 1784.746396] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[ 1784.746404] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7:
0000000000000400
[ 1784.746414] Process cansequence (pid: 7786, threadinfo
ffff880117264000, task ffff880120f54140)
[ 1784.746428] Stack:
[ 1784.746438]  ffff880117126000 ffff88012742b680 ffff880037c102a0
ffff88012946e8c0
[ 1784.746475]  ffff880117126870 ffffffffa03f102a ffff88012908dbc0
00000000000f41ff
[ 1784.746504]  0000000001000000 ffff88012946e8c0 0000000000000010
ffff880117126000
[ 1784.746527] Call Trace:
[ 1784.746546]  [<ffffffffa03f102a>] ? gs_can_start_xmit+0x19a/0x299
[gs_usb]
[ 1784.746569]  [<ffffffff8128f2ff>] ? dev_hard_start_xmit+0x3cd/0x513
[ 1784.746589]  [<ffffffff812a597f>] ? sch_direct_xmit+0x61/0x135
[ 1784.746607]  [<ffffffff812a5b4d>] ? __qdisc_run+0xfa/0x112
[ 1784.746625]  [<ffffffff8128f763>] ? dev_queue_xmit+0x31e/0x45b
[ 1784.746644]  [<ffffffff810363d8>] ? should_resched+0x5/0x23
[ 1784.746665]  [<ffffffffa03f6435>] ? can_send+0xe9/0x134 [can]
[ 1784.746685]  [<ffffffff8127bca1>] ? sock_tx_timestamp+0x29/0x35
[ 1784.746705]  [<ffffffffa04053a2>] ? raw_sendmsg+0xf3/0x130 [can_raw]
[ 1784.746726]  [<ffffffff8127f7a4>] ? sock_update_classid+0x2c/0x42
[ 1784.746746]  [<ffffffff8127d0e2>] ? sock_aio_write+0x121/0x135
[ 1784.746769]  [<ffffffff810f95d4>] ? do_sync_write+0xb4/0xec
[ 1784.746790]  [<ffffffff8100d6ec>] ? __switch_to+0x181/0x258
[ 1784.746809]  [<ffffffff81039817>] ? finish_task_switch+0x88/0xb9
[ 1784.746832]  [<ffffffff81163995>] ? security_file_permission
+0x16/0x2d
[ 1784.746852]  [<ffffffff810f9ccc>] ? vfs_write+0xa9/0xe9
[ 1784.746872]  [<ffffffff810f9ea2>] ? sys_write+0x45/0x6b
[ 1784.746895]  [<ffffffff81352012>] ? system_call_fastpath+0x16/0x1b
[ 1784.746910] Code: e0 48 8b 83 10 08 00 00 48 c7 04 e8 00 00 00 00 41
5b 5b 5d c3 41 56 41 55 41 54 55 48 89 f5 53 3b 96 08 08 00 00 48 89 fb
72 02 <0f> 0b f6 86 b2 01 00 00 04 0f 84 c8 00 00 00 8a 47 7d 83 e0 07 
[ 1784.747301] RIP  [<ffffffffa03d9552>] can_put_echo_skb+0x16/0x106
[can_dev]
[ 1784.747324]  RSP <ffff880117265b38>
[ 1784.747345] ---[ end trace 811113d28006e99a ]---
[ 1784.747357] Kernel panic - not syncing: Fatal exception in interrupt
[ 1784.747368] Pid: 7786, comm: cansequence Tainted: G      D    O
3.2.0-4-amd64 #1 Debian 3.2.35-2
[ 1784.747377] Call Trace:
[ 1784.747390]  [<ffffffff813467bc>] ? panic+0x95/0x1a5
[ 1784.747403]  [<ffffffff8134de86>] ? oops_end+0xa9/0xb6
[ 1784.747416]  [<ffffffff8100e965>] ? do_invalid_op+0x87/0x91
[ 1784.747431]  [<ffffffffa03d9552>] ? can_put_echo_skb+0x16/0x106
[can_dev]
[ 1784.747444]  [<ffffffff81037e96>] ? set_next_entity+0x32/0x55
[ 1784.747456]  [<ffffffff8100d025>] ? paravirt_write_msr+0xb/0xe
[ 1784.747468]  [<ffffffff8100d6ec>] ? __switch_to+0x181/0x258
[ 1784.747480]  [<ffffffff810397dd>] ? finish_task_switch+0x4e/0xb9
[ 1784.747493]  [<ffffffff81353feb>] ? invalid_op+0x1b/0x20
[ 1784.747507]  [<ffffffffa03d9552>] ? can_put_echo_skb+0x16/0x106
[can_dev]
[ 1784.747561]  [<ffffffffa01800b0>] ? usb_anchor_urb+0x25/0x65
[usbcore]
[ 1784.747577]  [<ffffffffa03f102a>] ? gs_can_start_xmit+0x19a/0x299
[gs_usb]
[ 1784.747592]  [<ffffffff8128f2ff>] ? dev_hard_start_xmit+0x3cd/0x513
[ 1784.747606]  [<ffffffff812a597f>] ? sch_direct_xmit+0x61/0x135
[ 1784.747617]  [<ffffffff812a5b4d>] ? __qdisc_run+0xfa/0x112
[ 1784.747629]  [<ffffffff8128f763>] ? dev_queue_xmit+0x31e/0x45b
[ 1784.747641]  [<ffffffff810363d8>] ? should_resched+0x5/0x23
[ 1784.747655]  [<ffffffffa03f6435>] ? can_send+0xe9/0x134 [can]
[ 1784.747669]  [<ffffffff8127bca1>] ? sock_tx_timestamp+0x29/0x35
[ 1784.747682]  [<ffffffffa04053a2>] ? raw_sendmsg+0xf3/0x130 [can_raw]
[ 1784.747695]  [<ffffffff8127f7a4>] ? sock_update_classid+0x2c/0x42
[ 1784.747707]  [<ffffffff8127d0e2>] ? sock_aio_write+0x121/0x135
[ 1784.747721]  [<ffffffff810f95d4>] ? do_sync_write+0xb4/0xec
[ 1784.747734]  [<ffffffff8100d6ec>] ? __switch_to+0x181/0x258
[ 1784.747746]  [<ffffffff81039817>] ? finish_task_switch+0x88/0xb9
[ 1784.747763]  [<ffffffff81163995>] ? security_file_permission
+0x16/0x2d
[ 1784.747775]  [<ffffffff810f9ccc>] ? vfs_write+0xa9/0xe9
[ 1784.747786]  [<ffffffff810f9ea2>] ? sys_write+0x45/0x6b
[ 1784.747799]  [<ffffffff81352012>] ? system_call_fastpath+0x16/0x1b
[42043.689364] BUG: scheduling while atomic: swapper/0/0/0x10000100
[42043.690985] Stack:
[42043.691116] Call Trace:
[42043.691211] Code: d2 65 48 8b 04 25 c8 c6 00 00 48 89 d1 48 2d c8 1f
00 00 0f 01 c8 0f ae f0 e8 c2 fc ff ff 85 c0 75 0b 31 c0 48 89 c1 fb 0f
01 c9 <eb> 05 e8 98 fc ff ff 65 8b 3c 25 08 dc 00 00 e8 9b fd ff ff 65

The first two lines tell me I'm not using can_put_echo_skb correctly.
I can only imagine there is a kind of race condition in the
gs_*_tx_context group of functions, but i don't know how to solve it.
The fact that the driver works fine at lower CAN speeds again makes me
want to think race condition.

What do you think?

Regards,
Max Schneider.

--=-7Br6vOUjTkrxT6lidaJK
Content-Disposition: attachment; filename="GS_USB.patch"
Content-Type: text/x-patch; name="GS_USB.patch"; charset="UTF-8"
Content-Transfer-Encoding: 8bit

From 304b5af4c34d38d061437ff4b02823803e83afe4 Mon Sep 17 00:00:00 2001
From: Maximilian Schneider <max@schneidersoft.net>
Date: Tue, 4 Jun 2013 13:07:47 +0000
Subject: [PATCH 1/1] Geschwister Schneider USB2CAN driver source.


Signed-off-by: Maximilian Schneider <max@schneidersoft.net>
---
 drivers/net/can/usb/Kconfig  |    6 +
 drivers/net/can/usb/Makefile |    1 +
 drivers/net/can/usb/gs_usb.c | 1042 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 1049 insertions(+)
 create mode 100644 drivers/net/can/usb/gs_usb.c

diff --git a/drivers/net/can/usb/Kconfig b/drivers/net/can/usb/Kconfig
index fc96a3d..b830014 100644
--- a/drivers/net/can/usb/Kconfig
+++ b/drivers/net/can/usb/Kconfig
@@ -54,4 +54,10 @@ config CAN_8DEV_USB
 	  This driver supports the USB2CAN interface
 	  from 8 devices (http://www.8devices.com).
 
+config CAN_GS_USB
+	tristate "Geschwister Schneider USB2CAN interface"
+	---help---
+	  This driver supports the USB2CAN interface
+	  from Geschwister Schneider (http://schneidersoft.net)
+
 endmenu
diff --git a/drivers/net/can/usb/Makefile b/drivers/net/can/usb/Makefile
index becef46..c21a521 100644
--- a/drivers/net/can/usb/Makefile
+++ b/drivers/net/can/usb/Makefile
@@ -7,5 +7,6 @@ obj-$(CONFIG_CAN_ESD_USB2) += esd_usb2.o
 obj-$(CONFIG_CAN_KVASER_USB) += kvaser_usb.o
 obj-$(CONFIG_CAN_PEAK_USB) += peak_usb/
 obj-$(CONFIG_CAN_8DEV_USB) += usb_8dev.o
+obj-$(CONFIG_CAN_GS_USB) += gs_usb.o
 
 ccflags-$(CONFIG_CAN_DEBUG_DEVICES) := -DDEBUG
diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
new file mode 100644
index 0000000..f25648c
--- /dev/null
+++ b/drivers/net/can/usb/gs_usb.c
@@ -0,0 +1,1042 @@
+/*
+ * CAN driver for Geschwister Schneider USB/CAN devices.
+ *
+ * Copyright (C) 2013 Geschwister Schneider Technologie-,
+ * Entwicklungs- und Vertriebs UG (Haftungsbeschränkt).
+ *
+ * Many thanks to all socketcan devs
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
+#include <linux/init.h>
+#include <linux/signal.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/usb.h>
+
+#include <linux/can.h>
+#include <linux/can/dev.h>
+#include <linux/can/error.h>
+
+/* Device specific constants */
+#define USB_GSUSB_1_VENDOR_ID      0xbeef
+#define USB_GSUSB_1_PRODUCT_ID     0x1234
+
+#define GSUSB_ENDPOINT_IN          1
+#define GSUSB_ENDPOINT_OUT         2
+
+enum {
+	GS_USB_BREQ_HOST_FORMAT = 0,
+	GS_USB_BREQ_BITTIMING,
+	GS_USB_BREQ_MODE,
+	GS_USB_BREQ_BERR,
+	GS_USB_BREQ_BT_CONST,
+	GS_USB_BREQ_DEVICE_CONFIG
+};
+
+#define GS_DCONF_IFACEMASK          0x7
+
+
+enum {
+	GS_CAN_MODE_RESET = 0,
+	GS_CAN_MODE_START
+};
+
+#define GS_USB_NORMAL               0
+#define GS_USB_LISTENONLY           1
+#define GS_USB_LOOPBACK             2
+
+#define GS_USB_ONE_SHOT             4
+#define GS_USB_TRIPLE_SAMPLE        8
+
+enum {
+	GS_CAN_STATE_ERROR_ACTIVE = 0,
+	GS_CAN_STATE_ERROR_WARNING,
+	GS_CAN_STATE_ERROR_PASSIVE,
+	GS_CAN_STATE_BUS_OFF,
+	GS_CAN_STATE_STOPPED,
+	GS_CAN_STATE_SLEEPING
+};
+
+/* data types passed between host and device */
+struct __packed gs_host_config {
+	u32 byte_order;
+};
+
+struct __packed gs_device_config {
+	u32 feature;
+};
+
+struct __packed gs_device_mode {
+	u32 mode;
+	u32 flags;
+};
+
+struct __packed gs_device_state {
+	u32 state;
+	u32 rxerr;
+	u32 txerr;
+};
+
+struct __packed gs_device_bittiming {
+	u32 prop_seg;
+	u32 phase_seg1;
+	u32 phase_seg2;
+	u32 sjw;
+	u32 brp;
+};
+
+struct __packed gs_device_bt_const {
+	u32 fclk_can;
+	u32 tseg1_min;
+	u32 tseg1_max;
+	u32 tseg2_min;
+	u32 tseg2_max;
+	u32 sjw_max;
+	u32 brp_min;
+	u32 brp_max;
+	u32 brp_inc;
+};
+
+struct __packed gs_host_frame {
+	u32  channel;
+	u32 echo_id;
+
+	u32 can_id;
+	u32 can_dlc;
+	u8 data[8];
+};
+
+/* special address description flags for the CAN_ID */
+#define GS_EFF_FLAG 0x80000000U /* EFF/SFF is set in the MSB */
+#define GS_RTR_FLAG 0x40000000U /* remote transmission request */
+#define GS_ERR_FLAG 0x20000000U /* error frame */
+
+/* valid bits in CAN ID for frame formats */
+#define GS_SFF_MASK 0x000007FFU /* standard frame format (SFF) */
+#define GS_EFF_MASK 0x1FFFFFFFU /* extended frame format (EFF) */
+#define GS_ERR_MASK 0x1FFFFFFFU /* omit EFF, RTR, ERR flags */
+
+/* FIXME: this macro is only a placeholder for a better function */
+#define CONVERT_FLAGS(x) x
+
+#define MAX_TX_URBS 10
+#define MAX_RX_URBS 10
+
+#define MAX_INTF 2
+
+struct gs_tx_context {
+	struct gs_can *dev;
+	unsigned int echo_id;
+};
+
+struct gs_can {
+	struct can_priv can; /* must be the first member */
+
+	struct gs_usb *parent;
+
+	struct net_device *netdev;
+	struct usb_device *udev;
+	struct usb_interface *iface;
+
+	struct can_bittiming_const bt_const;
+	unsigned int channel;	/* channel number */
+
+	struct gs_tx_context tx_context[MAX_TX_URBS];
+
+	struct usb_anchor tx_submitted;
+	atomic_t active_tx_urbs;
+};
+
+/* usb interface struct */
+struct gs_usb {
+	struct gs_can *canch[MAX_INTF];
+
+	struct usb_anchor rx_submitted;
+
+	atomic_t active_channels;
+};
+
+/* 'allocate' a tx context.
+ * returns a valid tx context or NULL if there is no space.
+ */
+static struct gs_tx_context *gs_alloc_tx_context(struct gs_can *dev)
+{
+	int i = 0;
+	for (; i < MAX_TX_URBS; i++)
+		if (dev->tx_context[i].echo_id == MAX_TX_URBS) {
+			dev->tx_context[i].echo_id = i;
+			return &dev->tx_context[i];
+		}
+	return NULL;
+}
+
+/* releases a tx context
+ */
+static void gs_free_tx_context(struct gs_tx_context *txc)
+{
+	txc->echo_id = MAX_TX_URBS;
+}
+
+/* Get a tx context by id.
+ */
+static struct gs_tx_context *gs_get_tx_context(
+	struct gs_can *dev,
+	unsigned int id)
+{
+	if (id < MAX_TX_URBS)
+		if (dev->tx_context[id].echo_id == id)
+			return &dev->tx_context[id];
+
+	return NULL;
+}
+
+/* Get a tx contexts id.
+ */
+static unsigned int gs_tx_context_id(struct gs_tx_context *txc)
+{
+	return txc->echo_id;
+}
+
+#define BUFFER_SIZE sizeof(struct gs_host_frame)
+
+/**************************** USB CALLBACKS **************************/
+static void gs_usb_recieve_bulk_callback(struct urb *urb)
+{
+	struct gs_usb *usbcan = urb->context;
+	struct gs_can *dev;
+	struct net_device *netdev;
+	int rc;
+	struct net_device_stats *stats;
+	struct sk_buff *skb;
+	struct can_frame *cf;
+	struct gs_host_frame *hf = urb->transfer_buffer;
+	struct gs_tx_context *txc;
+
+	BUG_ON(!usbcan);
+
+	switch (urb->status) {
+	case 0: /* success */
+		break;
+	case -ENOENT:
+	case -ESHUTDOWN:
+		return;
+	default:
+		/* printk(KERN_INFO "Rx URB aborted (%d)\n", urb->status); */
+		/* do not resubmit aborted urbs. eg: when device goes down */
+		return;
+	}
+
+	/* device reports out of range channel id */
+	if (hf->channel >= MAX_INTF)
+		/* printk(KERN_INFO "%d] strange channel #\n", hf->channel); */
+		goto resubmit_urb;
+
+	/* device reports bad channel id */
+	dev = usbcan->canch[hf->channel];
+
+	BUG_ON(!dev);
+
+	netdev = dev->netdev;
+	BUG_ON(!netdev);
+
+	if (!netif_device_present(netdev))
+		return;
+
+	stats = &dev->netdev->stats;
+
+	if (hf->echo_id == -1) { /* normal */
+		skb = alloc_can_skb(dev->netdev, &cf);
+		if (skb == NULL)
+			return;
+
+		cf->can_id = CONVERT_FLAGS(hf->can_id);
+		/* is it necessary to use get_can_dlc? */
+		cf->can_dlc = get_can_dlc(hf->can_dlc);
+		memcpy(cf->data, hf->data, 8);
+
+		netif_rx(skb);
+
+		stats->rx_packets++;
+		stats->rx_bytes += cf->can_dlc;
+	} else {		/* echo_id = hf->echo_id */
+		txc = gs_get_tx_context(dev, hf->echo_id);
+
+		/* bad devices send bad echo_ids. */
+		if (!txc) {
+			netdev_info(netdev, "bad echo %d\n", hf->echo_id);
+			goto resubmit_urb;
+		}
+
+		can_get_echo_skb(netdev, gs_tx_context_id(txc));
+
+		gs_free_tx_context(txc);
+
+		stats->tx_packets++;
+		/* FIXME: stats->tx_bytes += cf->can_dlc; */
+
+		netif_wake_queue(netdev);
+	}
+
+
+resubmit_urb:
+	/* do i really need to refill? the urb should still be valid:
+	usb_fill_bulk_urb(urb,
+	dev->udev,
+	usb_rcvbulkpipe(dev->udev,GSUSB_ENDPOINT_IN(
+		dev->iface->altsetting[0].desc.bInterfaceNumber)),
+	urb->transfer_buffer,
+	BUFFER_SIZE, gs_usb_recieve_bulk_callback,
+	dev);
+	*/
+	rc = usb_submit_urb(urb, GFP_ATOMIC);
+
+	/* USB failure take down all interfaces */
+	if (rc == -ENODEV) {
+		for (rc = 0; rc < MAX_INTF; rc++) {
+			if (usbcan->canch[rc])
+				netif_device_detach(usbcan->canch[rc]->netdev);
+		}
+	}
+}
+
+static void gs_usb_xmit_callback(struct urb *urb)
+{
+	struct gs_tx_context *txc = urb->context;
+	struct gs_can *dev;
+	struct net_device *netdev;
+
+	BUG_ON(!txc);
+
+	dev = txc->dev;
+	BUG_ON(!dev);
+
+	netdev = dev->netdev;
+	BUG_ON(!netdev);
+
+	if (urb->status) {
+		dev_info(netdev->dev.parent, "%d] xmit err %d\n",
+			dev->channel, txc->echo_id);
+	}
+
+	usb_free_coherent(urb->dev,
+		urb->transfer_buffer_length,
+		urb->transfer_buffer,
+		urb->transfer_dma);
+
+	atomic_dec(&dev->active_tx_urbs);
+
+	if (!netif_device_present(netdev))
+		return;
+
+	/* The urb never made it to the device. Drop this packet. */
+	if (urb->status) {
+		dev_info(netdev->dev.parent, "Tx URB aborted (%d)\n",
+			urb->status);
+		can_free_echo_skb(netdev, gs_tx_context_id(txc));
+		gs_free_tx_context(txc);
+		netdev->stats.tx_dropped++;
+	}
+
+	if (netif_queue_stopped(netdev))
+		netif_wake_queue(netdev);
+}
+
+static int gs_usb_set_bittiming(struct net_device *netdev)
+{
+	struct gs_can *dev = netdev_priv(netdev);
+	struct can_bittiming *bt = &dev->can.bittiming;
+	struct usb_interface *intf = dev->iface;
+	int rc;
+	struct gs_device_bittiming *dbt;
+
+	dbt = kmalloc(sizeof(*dbt), GFP_KERNEL);
+	if (!dbt)
+		return -ENOMEM;
+
+	dbt->prop_seg = bt->prop_seg;
+	dbt->phase_seg1 = bt->phase_seg1;
+	dbt->phase_seg2 = bt->phase_seg2;
+	dbt->sjw = bt->sjw;
+	dbt->brp = bt->brp;
+
+	rc = usb_control_msg(interface_to_usbdev(intf),
+			usb_sndctrlpipe(interface_to_usbdev(intf), 0),
+			GS_USB_BREQ_BITTIMING,
+			USB_DIR_OUT|USB_TYPE_VENDOR|USB_RECIP_INTERFACE,
+			dev->channel,
+			0,
+			dbt,
+			sizeof(*dbt),
+			1000);
+	if (rc < 0)
+		dev_warn(netdev->dev.parent, "Couldn't set bittimings %d", rc);
+
+	kfree(dbt);
+
+	return rc;
+}
+
+static int gs_usb_set_mode(struct net_device *netdev, enum can_mode mode)
+{
+	struct gs_can *dev = netdev_priv(netdev);
+	struct usb_interface *intf = dev->iface;
+	int rc = -EOPNOTSUPP;
+	struct gs_device_mode *dm;
+
+	dev_warn(netdev->dev.parent, "CAN mode %d\n", mode);
+
+	dm = kmalloc(sizeof(*dm), GFP_KERNEL);
+	if (!dm)
+		return -ENOMEM;
+
+	switch (mode) {
+	case CAN_MODE_START:
+		dm->mode = GS_CAN_MODE_RESET;
+
+		rc = usb_control_msg(interface_to_usbdev(intf),
+				usb_sndctrlpipe(interface_to_usbdev(intf), 0),
+				GS_USB_BREQ_MODE,
+				USB_DIR_OUT|USB_TYPE_VENDOR|USB_RECIP_INTERFACE,
+				dev->channel,
+				0,
+				dm,
+				sizeof(*dm),
+				1000);
+
+		if (rc < 0) {
+			dev_warn(netdev->dev.parent, "Couldn't start device %d",
+				rc);
+			break;
+		}
+
+		netif_wake_queue(netdev);
+		break;
+	case CAN_MODE_STOP:
+	case CAN_MODE_SLEEP:
+	default:
+		break;
+	}
+
+	kfree(dm);
+	return rc;
+}
+
+static int gs_usb_get_state(const struct net_device *netdev,
+enum can_state *state)
+{
+
+	struct gs_can *dev = netdev_priv(netdev);
+	struct usb_interface *intf = dev->iface;
+	int rc;
+	struct gs_device_state *dstate;
+
+	dev_warn(netdev->dev.parent, "CAN state");
+
+	dstate = kmalloc(sizeof(*dstate), GFP_KERNEL);
+	if (!dstate)
+		return -ENOMEM;
+
+	rc = usb_control_msg(interface_to_usbdev(intf),
+			usb_rcvctrlpipe(interface_to_usbdev(intf), 0),
+			GS_USB_BREQ_BERR,
+			USB_DIR_IN|USB_TYPE_VENDOR|USB_RECIP_INTERFACE,
+			dev->channel,
+			0,
+			dstate,
+			sizeof(*dstate),
+			1000);
+
+	if (rc < 0) {
+		dev_warn(netdev->dev.parent, "Couldn't get state %d", rc);
+		kfree(dstate);
+		return rc;
+	}
+
+	netdev_info(netdev, "state: %d\n", dstate->state);
+
+	switch (dstate->state) {
+	/* RX/TX error count < 96 */
+	case GS_CAN_STATE_ERROR_ACTIVE:
+		*state = CAN_STATE_ERROR_ACTIVE;
+		break;
+	/* RX/TX error count < 128 */
+	case GS_CAN_STATE_ERROR_WARNING:
+		*state = CAN_STATE_ERROR_WARNING;
+		break;
+	/* RX/TX error count < 256 */
+	case GS_CAN_STATE_ERROR_PASSIVE:
+		*state = CAN_STATE_ERROR_PASSIVE;
+		break;
+	/* RX/TX error count >= 256 */
+	case GS_CAN_STATE_BUS_OFF:
+		*state = CAN_STATE_BUS_OFF;
+		break;
+	/* Device is stopped */
+	case GS_CAN_STATE_STOPPED:
+		*state = CAN_STATE_STOPPED;
+		break;
+	/* Device is sleeping */
+	case GS_CAN_STATE_SLEEPING:
+		*state = CAN_STATE_SLEEPING;
+		break;
+	default:
+		kfree(dstate);
+		return -ENOTSUPP;
+	}
+
+	kfree(dstate);
+	return 0;
+}
+
+static int gs_usb_get_berr_counter(const struct net_device *netdev,
+struct can_berr_counter *bec)
+{
+	struct gs_can *dev = netdev_priv(netdev);
+	struct usb_interface *intf = dev->iface;
+	int rc;
+	struct gs_device_state *dstate;
+
+	dstate = kmalloc(sizeof(*dstate), GFP_KERNEL);
+	if (!dstate)
+		return -ENOMEM;
+
+	rc = usb_control_msg(interface_to_usbdev(intf),
+			usb_rcvctrlpipe(interface_to_usbdev(intf), 0),
+			GS_USB_BREQ_BERR,
+			USB_DIR_IN|USB_TYPE_VENDOR|USB_RECIP_INTERFACE,
+			dev->channel,
+			0,
+			dstate,
+			sizeof(*dstate),
+			1000);
+	if (rc < 0) {
+		dev_warn(netdev->dev.parent, "Couldn't get error counters %d",
+			rc);
+		kfree(dstate);
+		return rc;
+	}
+
+	dev_info(netdev->dev.parent, "txerr: %d rxerr: %d\n",
+		dstate->txerr, dstate->rxerr);
+
+	bec->txerr = dstate->txerr;
+	bec->rxerr = dstate->rxerr;
+
+	kfree(dstate);
+	return 0;
+}
+
+static netdev_tx_t gs_can_start_xmit(struct sk_buff *skb,
+struct net_device *netdev)
+{
+	struct gs_can *dev = netdev_priv(netdev);
+	struct net_device_stats *stats = &dev->netdev->stats;
+	struct urb *urb;
+	struct gs_host_frame *hf;
+	struct can_frame *cf;
+	int rc;
+	struct gs_tx_context *txc;
+
+	if (can_dropped_invalid_skb(netdev, skb))
+		return NETDEV_TX_OK;
+
+	/* find an empty context to keep track of transmission */
+	txc = gs_alloc_tx_context(dev);
+	if (!txc) {
+		/* dev_kfree_skb(skb); */
+		return NETDEV_TX_BUSY;
+	}
+
+	/* create a URB, and a buffer for it */
+	urb = usb_alloc_urb(0, GFP_ATOMIC);
+	if (!urb) {
+		gs_free_tx_context(txc);
+		dev_err(netdev->dev.parent, "No memory left for URBs\n");
+		goto nomem;
+	}
+
+	hf = usb_alloc_coherent(dev->udev, sizeof(*hf), GFP_ATOMIC,
+		&urb->transfer_dma);
+	if (!hf) {
+		gs_free_tx_context(txc);
+		dev_err(netdev->dev.parent, "No memory left for USB buffer\n");
+		usb_free_urb(urb);
+		goto nomem;
+	}
+
+	cf = (struct can_frame *)skb->data;
+
+	hf->echo_id = gs_tx_context_id(txc);
+	hf->channel = dev->channel;
+
+	hf->can_id = CONVERT_FLAGS(cf->can_id);
+	hf->can_dlc = cf->can_dlc;
+	memcpy(hf->data, cf->data, 8);
+
+	usb_fill_bulk_urb(urb, dev->udev,
+			usb_sndbulkpipe(dev->udev, GSUSB_ENDPOINT_OUT),
+			hf,
+			sizeof(*hf),
+			gs_usb_xmit_callback,
+			txc);
+
+	urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
+	usb_anchor_urb(urb, &dev->tx_submitted);
+
+	can_put_echo_skb(skb, netdev, gs_tx_context_id(txc));
+
+	atomic_inc(&dev->active_tx_urbs);
+
+/*	printk(KERN_INFO "%d] xmit new %d\n",hf->channel,hf->echo_id); */
+
+	rc = usb_submit_urb(urb, GFP_ATOMIC);
+	if (unlikely(rc)) {			/* usb send failed */
+		dev_err(netdev->dev.parent, "usb_submit failed %d\n", rc);
+
+		can_free_echo_skb(netdev, gs_tx_context_id(txc));
+		gs_free_tx_context(txc);
+
+		usb_unanchor_urb(urb);
+		usb_free_coherent(dev->udev,
+			sizeof(*hf),
+			hf,
+			urb->transfer_dma);
+
+		dev_kfree_skb(skb);
+
+		atomic_dec(&dev->active_tx_urbs);
+
+		if (rc == -ENODEV) {
+			netif_device_detach(netdev);
+		} else {
+			dev_warn(netdev->dev.parent, "Failed tx_urb %d\n", rc);
+
+			stats->tx_dropped++;
+		}
+	} else {
+		netdev->trans_start = jiffies;
+
+		/* Slow down tx path */
+		if (atomic_read(&dev->active_tx_urbs) >= MAX_TX_URBS)
+			netif_stop_queue(netdev);
+	}
+
+	/* let usb core take care of this urb */
+	usb_free_urb(urb);
+
+	return NETDEV_TX_OK;
+
+nomem:
+	dev_kfree_skb(skb);
+	stats->tx_dropped++;
+	return NETDEV_TX_OK;
+}
+
+static int gs_can_open(struct net_device *netdev)
+{
+	struct gs_can *dev = netdev_priv(netdev);
+	struct gs_usb *parent = dev->parent;
+	int rc, i;
+	struct gs_device_mode *dm;
+	u32 ctrlmode;
+
+	/* common open */
+	rc = open_candev(netdev);
+	if (rc)
+		return rc;
+
+	if (atomic_add_return(1, &parent->active_channels) == 1) {
+		for (i = 0; i < MAX_RX_URBS; i++) {
+			struct urb *urb = NULL;
+			u8 *buf = NULL;
+
+			/* alloc rx urb */
+			urb = usb_alloc_urb(0, GFP_KERNEL);
+			if (!urb) {
+				dev_err(netdev->dev.parent,
+					"No memory left for URBs\n");
+				return -ENOMEM;
+			}
+
+			/* alloc rx buffer */
+			/* FIXME: free this memory */
+			buf = usb_alloc_coherent(dev->udev,
+				BUFFER_SIZE,
+				GFP_KERNEL,
+				&urb->transfer_dma);
+			if (!buf) {
+				dev_err(netdev->dev.parent,
+					"No memory left for USB buffer\n");
+				usb_free_urb(urb);
+				return -ENOMEM;
+			}
+
+
+			/* fill, anchor, and submit rx urb */
+			usb_fill_bulk_urb(urb,
+					dev->udev,
+					usb_rcvbulkpipe(dev->udev,
+						GSUSB_ENDPOINT_IN),
+					buf,
+					BUFFER_SIZE,
+					gs_usb_recieve_bulk_callback,
+					parent
+					);
+			urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
+
+			usb_anchor_urb(urb, &parent->rx_submitted);
+
+			rc = usb_submit_urb(urb, GFP_KERNEL);
+			if (rc) {
+				if (rc == -ENODEV)
+					netif_device_detach(dev->netdev);
+
+				/* FIXME: free rx buffer/urb maybe? */
+				usb_unanchor_urb(urb);
+				break;
+			}
+
+			/* Drop reference,
+			 * USB core will take care of freeing it
+			 */
+			usb_free_urb(urb);
+		}
+	}
+
+	dm = kmalloc(sizeof(*dm), GFP_KERNEL);
+	if (!dm)
+		return -ENOMEM;
+
+	/* flags */
+	ctrlmode = dev->can.ctrlmode;
+	if (ctrlmode & CAN_CTRLMODE_LOOPBACK)
+		dm->flags |= GS_USB_LOOPBACK;
+
+	if (ctrlmode & CAN_CTRLMODE_LISTENONLY)
+		dm->flags |= GS_USB_LISTENONLY;
+
+	if (ctrlmode & CAN_CTRLMODE_ONE_SHOT)
+		dm->flags |= GS_USB_ONE_SHOT;
+
+	if (ctrlmode & CAN_CTRLMODE_3_SAMPLES)
+		dm->flags |= GS_USB_TRIPLE_SAMPLE;
+
+
+	/* finally start device */
+	dm->mode = GS_CAN_MODE_START;
+	rc = usb_control_msg(interface_to_usbdev(dev->iface),
+			usb_sndctrlpipe(interface_to_usbdev(dev->iface), 0),
+			GS_USB_BREQ_MODE,
+			USB_DIR_OUT|USB_TYPE_VENDOR|USB_RECIP_INTERFACE,
+			dev->channel,
+			0,
+			dm,
+			sizeof(*dm),
+			1000);
+
+	kfree(dm);
+
+	if (rc < 0)
+		dev_warn(netdev->dev.parent, "Couldn't start device %d", rc);
+
+	netif_start_queue(netdev);
+
+	netdev_info(netdev, "CAN open\n");
+	return 0;
+}
+
+/* think: ip link set canx down */
+static int gs_can_close(struct net_device *netdev)
+{
+	struct gs_can *dev = netdev_priv(netdev);
+	struct gs_usb *parent = dev->parent;
+
+	netif_stop_queue(netdev);
+
+	/* Stop polling */
+	if (atomic_dec_and_test(&parent->active_channels)) {
+		usb_kill_anchored_urbs(&parent->rx_submitted);
+		/* FIXME: Set CAN controller to reset mode */
+	}
+
+	close_candev(netdev);
+
+	netdev_info(netdev, "CAN close\n");
+	return 0;
+}
+
+/******************************** USB ********************************/
+
+static const struct net_device_ops gs_usb_netdev_ops = {
+	.ndo_open = gs_can_open,
+	.ndo_stop = gs_can_close,
+	.ndo_start_xmit = gs_can_start_xmit,
+};
+
+static int gs_make_candev(struct gs_can **out, unsigned int channel,
+struct usb_interface *intf)
+{
+	struct gs_can *dev;
+	struct net_device *netdev;
+	int rc;
+	struct gs_device_bt_const *bt_const;
+
+	bt_const = kmalloc(sizeof(*bt_const), GFP_KERNEL);
+	if (!bt_const)
+		return -ENOMEM;
+
+	/* fetch bit timing constants */
+	rc = usb_control_msg(interface_to_usbdev(intf),
+			usb_rcvctrlpipe(interface_to_usbdev(intf), 0),
+			GS_USB_BREQ_BT_CONST,
+			USB_DIR_IN|USB_TYPE_VENDOR|USB_RECIP_INTERFACE,
+			channel,
+			0,
+			bt_const,
+			sizeof(*bt_const),
+			1000);
+
+	if (rc < 0) {
+		dev_err(&intf->dev,
+			"Couldn't get bit timing const for channel %d\n",
+			rc);
+		kfree(bt_const);
+		return rc;
+	}
+
+	dev_info(&intf->dev, "fclock: %d\n", bt_const->fclk_can);
+
+	/* create netdev */
+	netdev = alloc_candev(sizeof(struct gs_can), MAX_TX_URBS);
+	if (!netdev) {
+		dev_err(&intf->dev, "Couldn't alloc candev\n");
+		kfree(bt_const);
+		return -ENOMEM;
+	}
+
+	dev = netdev_priv(netdev);
+
+	netdev->netdev_ops = &gs_usb_netdev_ops;
+
+	netdev->flags |= IFF_ECHO; /* we support full roundtrip echo */
+
+	/* dev settup */
+	strcpy(dev->bt_const.name, "gs_usb");
+	dev->bt_const.tseg1_min = bt_const->tseg1_min;
+	dev->bt_const.tseg1_max = bt_const->tseg1_max;
+	dev->bt_const.tseg2_min = bt_const->tseg2_min;
+	dev->bt_const.tseg2_max = bt_const->tseg2_max;
+	dev->bt_const.sjw_max = bt_const->sjw_max;
+	dev->bt_const.brp_min = bt_const->brp_min;
+	dev->bt_const.brp_max = bt_const->brp_max;
+	dev->bt_const.brp_inc = bt_const->brp_inc;
+
+	dev->udev = interface_to_usbdev(intf);
+	dev->iface = intf;
+	dev->netdev = netdev;
+	dev->channel = channel;
+
+	init_usb_anchor(&dev->tx_submitted);
+	atomic_set(&dev->active_tx_urbs, 0);
+	for (rc = 0; rc < MAX_TX_URBS; rc++) {
+		dev->tx_context[rc].dev = dev;
+		dev->tx_context[rc].echo_id = MAX_TX_URBS;
+	}
+
+	/* can settup */
+	dev->can.state = CAN_STATE_STOPPED;
+	dev->can.clock.freq = bt_const->fclk_can;
+	dev->can.bittiming_const = &dev->bt_const;
+	dev->can.do_set_bittiming = gs_usb_set_bittiming;
+	dev->can.do_set_mode = gs_usb_set_mode;
+	dev->can.do_get_state = gs_usb_get_state;
+	dev->can.do_get_berr_counter = gs_usb_get_berr_counter;
+	dev->can.ctrlmode_supported = CAN_CTRLMODE_3_SAMPLES |
+					CAN_CTRLMODE_LOOPBACK |
+					CAN_CTRLMODE_LISTENONLY |
+					CAN_CTRLMODE_ONE_SHOT;
+
+	kfree(bt_const);
+
+	SET_NETDEV_DEV(netdev, &intf->dev);
+
+	rc = register_candev(dev->netdev);
+	if (rc) {
+		free_candev(dev->netdev);
+		dev_err(&intf->dev, "Couldn't register candev\n");
+		return rc;
+	}
+
+	*out = dev;
+	return 0;
+}
+
+static void gs_destroy_candev(struct gs_can *dev)
+{
+	unregister_candev(dev->netdev);
+	free_candev(dev->netdev);
+}
+
+static int gs_usb_probe(struct usb_interface *intf,
+const struct usb_device_id *id)
+{
+	struct gs_usb *dev;
+	int rc = -ENOMEM;
+	unsigned int icount, i;
+	struct gs_host_config *hconf;
+	struct gs_device_config *dconf;
+
+	hconf = kmalloc(sizeof(*hconf), GFP_KERNEL);
+	if (!hconf)
+		return -ENOMEM;
+
+	hconf->byte_order = 0x0000beef;
+
+
+	/* send host config */
+	rc = usb_control_msg(interface_to_usbdev(intf),
+			usb_sndctrlpipe(interface_to_usbdev(intf), 0),
+			GS_USB_BREQ_HOST_FORMAT,
+			USB_DIR_OUT|USB_TYPE_VENDOR|USB_RECIP_INTERFACE,
+			1,
+			intf->altsetting[0].desc.bInterfaceNumber,
+			hconf,
+			sizeof(*hconf),
+			1000);
+
+	kfree(hconf);
+
+	if (rc < 0) {
+		dev_err(&intf->dev, "Couldn't send data format: %d\n",
+			rc);
+		return rc;
+	}
+
+
+	dconf = kmalloc(sizeof(*dconf), GFP_KERNEL);
+	if (!dconf)
+		return -ENOMEM;
+
+	/* read device config */
+	rc = usb_control_msg(interface_to_usbdev(intf),
+			usb_rcvctrlpipe(interface_to_usbdev(intf), 0),
+			GS_USB_BREQ_DEVICE_CONFIG,
+			USB_DIR_IN|USB_TYPE_VENDOR|USB_RECIP_INTERFACE,
+			1,
+			intf->altsetting[0].desc.bInterfaceNumber,
+			dconf,
+			sizeof(*dconf),
+			1000);
+	if (rc < 0) {
+		dev_err(&intf->dev, "Couldn't recieve device config: %d\n",
+			rc);
+		return rc;
+	}
+
+	icount = (dconf->feature&GS_DCONF_IFACEMASK)+1;
+
+	kfree(dconf);
+
+	dev_info(&intf->dev, "Configuring for %d interfaces\n", icount);
+
+	if (icount > MAX_INTF) {
+		dev_err(&intf->dev,
+			"Driver cannot handle more that %d Can interfaces\n",
+			MAX_INTF);
+		return -EINVAL;
+	}
+
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	init_usb_anchor(&dev->rx_submitted);
+
+	atomic_set(&dev->active_channels, 0);
+
+	usb_set_intfdata(intf, dev);
+
+	for (i = 0; i < icount; i++) {
+		rc = gs_make_candev(&dev->canch[i], i, intf);
+		if (rc) {
+			icount = i;
+			for (i = 0; i < icount; i++) {
+				gs_destroy_candev(dev->canch[i]);
+				dev->canch[icount] = NULL;
+			}
+			return rc;
+		}
+		dev->canch[i]->parent = dev;
+	}
+
+	dev_info(&intf->dev, "Probe\n");
+	return 0;
+}
+
+static void gs_usb_disconnect(struct usb_interface *intf)
+{
+	unsigned i;
+	struct gs_usb *dev = usb_get_intfdata(intf);
+	usb_set_intfdata(intf, NULL);
+
+	if (!dev) {
+		dev_info(&intf->dev, "Disconnect (nodata)\n");
+		return;
+	}
+
+	for (i = 0; i < MAX_INTF; i++) {
+		struct gs_can *can = dev->canch[i];
+
+		if (!can)
+			continue;
+
+		unregister_netdev(can->netdev);
+		free_candev(can->netdev);
+
+		usb_kill_anchored_urbs(&can->tx_submitted);
+	}
+
+	usb_kill_anchored_urbs(&dev->rx_submitted);
+
+	dev_info(&intf->dev, "Disconnect\n");
+}
+
+MODULE_DEVICE_TABLE(usb, gs_usb_table);
+static struct usb_device_id gs_usb_table[] = {
+	{USB_DEVICE(USB_GSUSB_1_VENDOR_ID, USB_GSUSB_1_PRODUCT_ID)},
+	{} /* Terminating entry */
+};
+
+static struct usb_driver gs_usb_driver = {
+	.name       = "gs_usb",
+	.probe      = gs_usb_probe,
+	.disconnect = gs_usb_disconnect,
+	.id_table   = gs_usb_table,
+	/* FIXME: suspend, resume, etc... */
+};
+
+static int __init gs_usb_init(void)
+{
+	return usb_register(&gs_usb_driver);
+}
+
+static void __exit gs_usb_exit(void)
+{
+	usb_deregister(&gs_usb_driver);
+}
+
+module_init(gs_usb_init);
+module_exit(gs_usb_exit);
+
+MODULE_AUTHOR("Maximilian Schneider <mws@schneidersoft.net>");
+MODULE_DESCRIPTION(
+"Socket CAN device driver for Geschwister Schneider Technologie-, "
+"Entwicklungs- und Vertriebs UG. USB2.0 to CAN interfaces.");
+MODULE_LICENSE("GPL v2");
+
-- 
1.7.10.4


--=-7Br6vOUjTkrxT6lidaJK--

