Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795683692;
	b=Pg15YUWQIRS++BeBMhn5loZqNrEkoMbGMhC0pthc6HUYoTe3p+1OcBfwTv57zzBpBXWa
	 m0uEe23ZlWIJP0jthqJyKxDjKpraPVkvMWhBv6l/lkVudiajoYlurr5yDrb2fn+wnXdDS
	 iL4Fm3jE0GlEV7ijlxH89I++48cUUQB1RtGmQxGuVZeJVh9e5mkur7S+nda+BCPX4ooX2
	 FPlDiNuMRJl5qBuyhkKCj7SMmHeflzVYvvkn4SKu4Co3OVddJtklYEYg3FmFy1MpG3Z9J
	 hYqTA3FN6M7Aws5J3Ff0Ot6UJ8J8SuIc6CnDu0miOfsW+WG6u5mXvRT2DlJeFyBBT3g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795683692;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=xpUgTuWwa2JQRXKOQrCbhZfubUyG/JhAMmbBcMNlyh8=;
	b=0Q4wt3qtzVqu2YDVolP16gwWrKHnsjV+yg3TYh2+Tb1THrF/AAWwnokWqBtD7jLz+CNV
	 zlxKZmUdR01+pdXKCQAnNuT9Eo9Ww30AG17AXN2qPQhQ+MeNRpEcDXsKOAbKc23+M0B3w
	 6KKj9IFZTY9Rk0UVrDelCJvKb+RtONz/LBn+BgD1qV6Qyc7YExcZF9Nq+iTCkp3oYpcpg
	 bQX5lXh6d/2/ZL+jNsSAV/8pbe8N7hy5Q+BiEBI3xZbjxjR1kH21eoNV1JtkGnb+3fM3C
	 mcVjJYmr1dz9Ptin6Rzg+gXbEj0mcWALlxQ0P643VY4PktBz16FH1o6QMByifXkjzuQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="foL/udii";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2911606A33E;
	Thu, 26 Nov 2026 09:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=foL/udii
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795683692;
	b=ddW+lQ0Z2CGoAXWfHoHxDNj4/iZzUcZegR/dNq0mc2BtGGWuHoFeesldSbm+yNxvMvl3
	 kwLR1Zns0lrDfIQB5dGx2QFvk+9B7+EKvHiyUVenGotKZmOJ/Ha5TG9jAScQxP51t16f/
	 c+sCC/d8WkOQGZqqYKlazUE8dDnUIdqmjicA8ZEuf5OVcWpdHRHMKYFbNde4789/kaHfR
	 /nJK+/l881WUW4ILle2DnQDS9olVajipbqLpNQf1+3DUFNRgQj6O2ylvWufwyURHR2a0g
	 8GLqs/Aa7wCMD+36xXKeH+fekJem8l0/KDO5yrti0YXcDB+X5BouTLV+pUqTNTxgeEA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795683692;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=xpUgTuWwa2JQRXKOQrCbhZfubUyG/JhAMmbBcMNlyh8=;
	b=au3fw/8x7tNusa6Iv4w99TJj8loGtglNRbUej8Bq10kCRpqPLm3t9GQmbtkeetztGaPF
	 5touLfF3fGs1YoXphLltQ0Awv6gO0/6027iSllSR1qEiR+Qdaah9Jdj49gGXmvbwTrtOA
	 AWu+Uq5KcnMz2rijV5t6BQvGG34AC64WW0lkUcVXeVnjk/tNejMTlSWpaaJPxve/8IHC8
	 lT5lnakLsZfwoRlWtjVMjxfdistZK6Qvnk3J/s6fWBPjhq6pRC7QPsamZyDI7LGFMsQhE
	 R+YSS4bqFAACL9nWaIjC88mmnyPDP1KiWBt058Jhy4JMsIwBJWmmc3NIFyEG1qsWpvA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 646551F000E1;
	Thu, 26 Nov 2026 09:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795683692;
	bh=xpUgTuWwa2JQRXKOQrCbhZfubUyG/JhAMmbBcMNlyh8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=foL/udiiOFcOJRHIf9TmNSf2uFZso+K6fpKPeW4WxkFI2PVRgLDPVs7FrOqWKrY5+
	 udbeKuDW+VooeKson8aezo65jGO7Y4iTFdHk3av4jrdeXqddoitzSamM8ZkJmH++cY
	 S2/VattKdYhtv8rSSrYDnD2msUjugE58iWIzePb0sB1/+gDTt1IY/WbRnGmftrWnnY
	 UdKQxVeugrdGaGuboCVlDdKTCW+3VrOkOeSV7hd/dOeF6I/c6D3zgX6NYCJE+y8Z/+
	 Kp3jur6sFGX1qAy39AiB/GD6iePy9zm/zezoND+WbUAKLx596eeRDlTSXvsIF799fQ
	 150ImVPIMNy1w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3E95B4D31E;
	Thu, 26 Nov 2026 09:01:20 +0000 (UTC)
From: =?utf-8?q?St=C3=A9phane_Grosjean_via_B4_Relay?= <devnull+s.grosjean.peak-system.fr@kernel.org>
Date: Thu, 26 Nov 2026 10:01:05 +0100
Subject: [PATCH v9 04/14] can: peak_usb: harden channel handling in
 PCAN-USB FD
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261126-canfd_check_channel_idx-v9-4-abe0099b4585@peak-system.fr>
References: <20261126-canfd_check_channel_idx-v9-0-abe0099b4585@peak-system.fr>
In-Reply-To: <20261126-canfd_check_channel_idx-v9-0-abe0099b4585@peak-system.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Wolfgang Grandegger <wg@grandegger.com>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>, 
 Dan Carpenter <error27@gmail.com>, Lukas Magel <lukas.magel@posteo.net>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tristan Madani <tristmd@gmail.com>, 
 Joas Antonio dos Santos <joasantonio108@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795683678; l=9883;
 i=s.grosjean@peak-system.fr; s=20261020; h=from:subject:message-id;
 bh=YiMGcwSXuKBW3xE6AlLXVQtLwZBC176IqC1uIO4QO5c=;
 b=Xprk1ugD/BAk/y5CfL+r+Vr+LrjYSh+U0tU/Dp1ujBSJLBRKXOzcJ+4KjzVradGmoCG81TT76
 9Dgvng7Sje6DCUi6MsY/291V7iyZ5fzmHnBXWZonD5eZTPEW2r1Q6wW
X-Developer-Key: i=s.grosjean@peak-system.fr; a=ed25519;
 pk=bP7QV2zvvAKAfConZlUOGKGEcXL64SNUpVUm++Ai+/c=
X-Endpoint-Received: by B4 Relay for s.grosjean@peak-system.fr/20261020
 with auth_id=1250
X-Original-From: =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>
Reply-To: s.grosjean@peak-system.fr
Content-Transfer-Encoding: 8bit

From: Stéphane Grosjean <s.grosjean@peak-system.fr>

Records received from PCAN-USB FD family devices carry a CAN channel
number used to index the adapter CAN device table usb_if->dev[].

The decoders only checked this number against the size of the table
(2 entries). On single-channel adapters (PCAN-USB FD, PCAN-Chip USB),
dev[1] is never set, so a record for channel 1 led to a NULL pointer
dereference in URB completion context. On two-channel adapters, a
channel slot is also NULL until that channel has been initialized,
while the RX URBs of channel 0 may already be running.

Check the channel number against the number of controllers of the
adapter and reject records for a channel whose slot is empty. Such a
record makes the decoder stop processing the rest of the URB.

When probing a channel fails after its slot has been filled, the channel
is freed but its slot kept pointing to it. Clear the slot in
pcan_usb_fd_free() and, before freeing the channel, stop RX on this
channel and on the sibling channels already created, since the whole
interface is then released anyway. Slots are published with
smp_store_release() and read with READ_ONCE().

Finally, peak_usb_disconnect() now stops RX on all channels before
unregistering any of them: it clears CONNECTED, which makes
peak_usb_ndo_open() fail, then poisons the RX anchors. This matters
when it is called from the probe error path, where the USB core has
not disabled the interface.

CONNECTED is cleared under RTNL, to serialize with peak_usb_ndo_open():
otherwise, an ndo_open() that has already passed the CONNECTED test
may have anchored an RX URB without having submitted it yet, which
makes usb_poison_anchored_urbs() busy-wait until it is submitted.

Fixes: 0a25e1f4f185 ("can: peak_usb: add support for PEAK new CANFD USB adapters")
Signed-off-by: Stéphane Grosjean <s.grosjean@peak-system.fr>
---
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 39 ++++++++++++++++-
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c   | 62 +++++++++++++++++++++-------
 2 files changed, 84 insertions(+), 17 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index a1b17e1e6fea..f5c39b43b0fa 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
+#include <linux/rtnetlink.h>
 #include <linux/signal.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
@@ -574,6 +575,9 @@ static int peak_usb_ndo_open(struct net_device *netdev)
 	struct peak_usb_device *dev = netdev_priv(netdev);
 	int err;
 
+	if (!test_bit(PCAN_USB_STATE_CONNECTED, &dev->state))
+		return -ENODEV;
+
 	/* common open */
 	err = open_candev(netdev);
 	if (err)
@@ -904,6 +908,29 @@ int pcan_get_ts_info(struct net_device *dev, struct kernel_ethtool_ts_info *info
 	return 0;
 }
 
+/*
+ * stop RX on dev and on all its previous siblings: clearing CONNECTED makes
+ * peak_usb_ndo_open() fail, then poisoning the RX anchors waits for running
+ * completion handlers and makes any later submission on them fail.
+ *
+ * peak_usb_ndo_open() runs under RTNL: clearing CONNECTED under RTNL ensures
+ * that no ndo_open() is in progress (so no RX URB is anchored but not yet
+ * submitted, which usb_poison_anchored_urbs() would busy-wait on) and that
+ * any later one fails.
+ */
+static void peak_usb_stop_rx(struct peak_usb_device *dev)
+{
+	struct peak_usb_device *d;
+
+	rtnl_lock();
+	for (d = dev; d; d = d->prev_siblings)
+		clear_bit(PCAN_USB_STATE_CONNECTED, &d->state);
+	rtnl_unlock();
+
+	for (d = dev; d; d = d->prev_siblings)
+		usb_poison_anchored_urbs(&d->rx_submitted);
+}
+
 /*
  * create one device which is attached to CAN controller #ctrl_idx of the
  * usb adapter.
@@ -1014,6 +1041,13 @@ static int peak_usb_create_dev(const struct peak_usb_adapter *peak_usb_adapter,
 	return 0;
 
 adap_dev_free:
+	/* the whole interface is released when probing a channel fails:
+	 * stop RX on this channel, which may already be open, and on the
+	 * channels already created, since their RX URBs may carry records
+	 * for this one.
+	 */
+	peak_usb_stop_rx(dev);
+
 	if (dev->adapter->dev_free)
 		dev->adapter->dev_free(dev);
 
@@ -1038,13 +1072,14 @@ static void peak_usb_disconnect(struct usb_interface *intf)
 	struct peak_usb_device *dev;
 	struct peak_usb_device *dev_prev_siblings;
 
-	/* unregister as many netdev devices as siblings */
+	/* stop RX on all channels before unregistering and freeing them */
+	peak_usb_stop_rx(usb_get_intfdata(intf));
+
 	for (dev = usb_get_intfdata(intf); dev; dev = dev_prev_siblings) {
 		struct net_device *netdev = dev->netdev;
 		char name[IFNAMSIZ];
 
 		dev_prev_siblings = dev->prev_siblings;
-		clear_bit(PCAN_USB_STATE_CONNECTED, &dev->state);
 		strscpy(name, netdev->name, IFNAMSIZ);
 
 		unregister_candev(netdev);
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
index 729d294f71e5..43c16e743c15 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
@@ -60,6 +60,7 @@ struct __packed pcan_ufd_fw_info {
 
 /* handle device specific info used by the netdevices */
 struct pcan_usb_fd_if {
+	const struct peak_usb_adapter *adapter;
 	struct peak_usb_device	*dev[PCAN_USB_MAX_CHANNEL];
 	struct pcan_ufd_fw_info	fw_info;
 	struct peak_time_ref	time_ref;
@@ -536,10 +537,16 @@ static int pcan_usb_fd_decode_canmsg(struct pcan_usb_fd_if *usb_if,
 	struct sk_buff *skb;
 	const u16 rx_msg_flags = le16_to_cpu(rm->flags);
 
-	if (pucan_msg_get_channel(rm) >= ARRAY_SIZE(usb_if->dev))
-		return -ENOMEM;
+	/* Reject invalid channel numbers reported by the firmware */
+	if (pucan_msg_get_channel(rm) >= usb_if->adapter->ctrl_count)
+		return -EINVAL;
+
+	dev = READ_ONCE(usb_if->dev[pucan_msg_get_channel(rm)]);
+
+	/* reject records for a channel that is not (or no longer) set up */
+	if (!dev)
+		return -EINVAL;
 
-	dev = usb_if->dev[pucan_msg_get_channel(rm)];
 	netdev = dev->netdev;
 
 	if (rx_msg_flags & PUCAN_MSG_EXT_DATA_LEN) {
@@ -605,10 +612,16 @@ static int pcan_usb_fd_decode_status(struct pcan_usb_fd_if *usb_if,
 	struct can_frame *cf;
 	struct sk_buff *skb;
 
-	if (pucan_stmsg_get_channel(sm) >= ARRAY_SIZE(usb_if->dev))
-		return -ENOMEM;
+	/* Reject invalid channel numbers reported by the firmware */
+	if (pucan_stmsg_get_channel(sm) >= usb_if->adapter->ctrl_count)
+		return -EINVAL;
+
+	dev = READ_ONCE(usb_if->dev[pucan_stmsg_get_channel(sm)]);
+
+	/* reject records for a channel that is not (or no longer) set up */
+	if (!dev)
+		return -EINVAL;
 
-	dev = usb_if->dev[pucan_stmsg_get_channel(sm)];
 	pdev = container_of(dev, struct pcan_usb_fd_device, dev);
 	netdev = dev->netdev;
 
@@ -662,10 +675,16 @@ static int pcan_usb_fd_decode_error(struct pcan_usb_fd_if *usb_if,
 	struct pcan_usb_fd_device *pdev;
 	struct peak_usb_device *dev;
 
-	if (pucan_ermsg_get_channel(er) >= ARRAY_SIZE(usb_if->dev))
+	/* Reject invalid channel numbers reported by the firmware */
+	if (pucan_ermsg_get_channel(er) >= usb_if->adapter->ctrl_count)
+		return -EINVAL;
+
+	dev = READ_ONCE(usb_if->dev[pucan_ermsg_get_channel(er)]);
+
+	/* reject records for a channel that is not (or no longer) set up */
+	if (!dev)
 		return -EINVAL;
 
-	dev = usb_if->dev[pucan_ermsg_get_channel(er)];
 	pdev = container_of(dev, struct pcan_usb_fd_device, dev);
 
 	/* keep a trace of tx and rx error counters for later use */
@@ -685,10 +704,16 @@ static int pcan_usb_fd_decode_overrun(struct pcan_usb_fd_if *usb_if,
 	struct can_frame *cf;
 	struct sk_buff *skb;
 
-	if (pufd_omsg_get_channel(ov) >= ARRAY_SIZE(usb_if->dev))
+	/* Reject invalid channel numbers reported by the firmware */
+	if (pufd_omsg_get_channel(ov) >= usb_if->adapter->ctrl_count)
+		return -EINVAL;
+
+	dev = READ_ONCE(usb_if->dev[pufd_omsg_get_channel(ov)]);
+
+	/* reject records for a channel that is not (or no longer) set up */
+	if (!dev)
 		return -EINVAL;
 
-	dev = usb_if->dev[pufd_omsg_get_channel(ov)];
 	netdev = dev->netdev;
 
 	/* allocate an skb to store the error frame */
@@ -986,6 +1011,9 @@ static int pcan_usb_fd_init(struct peak_usb_device *dev)
 		if (!pdev->usb_if)
 			goto err_out;
 
+		/* needed by the decoders to check channel numbers */
+		pdev->usb_if->adapter = dev->adapter;
+
 		/* allocate command buffer once for all for the interface */
 		pdev->cmd_buffer_addr = kzalloc(PCAN_UFD_CMD_BUFFER_SIZE,
 						GFP_KERNEL);
@@ -1059,7 +1087,8 @@ static int pcan_usb_fd_init(struct peak_usb_device *dev)
 		fw_info = &pdev->usb_if->fw_info;
 	}
 
-	pdev->usb_if->dev[dev->ctrl_idx] = dev;
+	/* publish dev to the decoders, after the ctrlmode copies above */
+	smp_store_release(&pdev->usb_if->dev[dev->ctrl_idx], dev);
 	dev->can_channel_id =
 		le32_to_cpu(pdev->usb_if->fw_info.dev_id[dev->ctrl_idx]);
 
@@ -1129,14 +1158,17 @@ static void pcan_usb_fd_exit(struct peak_usb_device *dev)
 	}
 }
 
-/* called when the USB adapter is unplugged */
+/* called when the USB adapter is unplugged, or when probing a sibling fails */
 static void pcan_usb_fd_free(struct peak_usb_device *dev)
 {
+	struct pcan_usb_fd_device *pdev =
+		container_of(dev, struct pcan_usb_fd_device, dev);
+
+	/* clear this channel's slot: dev is going to be freed */
+	WRITE_ONCE(pdev->usb_if->dev[dev->ctrl_idx], NULL);
+
 	/* last device: can free shared objects now */
 	if (!dev->prev_siblings && !dev->next_siblings) {
-		struct pcan_usb_fd_device *pdev =
-			container_of(dev, struct pcan_usb_fd_device, dev);
-
 		/* free commands buffer */
 		kfree(pdev->cmd_buffer_addr);
 

-- 
2.53.0


