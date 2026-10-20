Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792503055;
	b=lkwarpbsjelK/1EeeWUKYFdLMJHTK8nIDA0sDyqUs97LlMiUTYTmM8uGVl7WqBJSUR53
	 kLYB4Bo2nvNgbYmN9mlSnxLlP2jEb4HfPj86f8mBEDfg25HEgenAHIWCGluadXzMhliIK
	 VHyKiUiqEOqzIEAWEpSVfuu6gnFppCjlY7yLwog9L7vt7hk37k8bjAXRigtWrnT51CYKD
	 E3KRiR0U7/f225qVBh61UucAXzvyPgA/fHHn3Wo2XFXI3RGcRFlYM4cfPX4lOmjvSBBBa
	 EZQCFeR+lWlTJpYzJ00JaReC+psQiyNkgqsoDwmduCMdqReIBm+iioxN9RPokrDrovw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792503055;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=iZ5a4t7/z6qVfKpQUXiPBl/MQsyqoAdOBP59oCQm5TE=;
	b=MQf9AFfYZ/VU5to7JQdZopfyhsjecBptgQW38u99rO9YB1WoZGLIJb+cPArIr+kW1tb8
	 8VdVHo6fZ8eykgofCOr3qrx34paUqmBZfgC8oY0cu83Kl5B7yLcRrO86Fqsn3Z3KpuNKs
	 oH0s4c+OheRqvjKAq2/rdwKVHE8hAOsRHHutT454mgZsJU9u9QUj6qvrjfwSK4pomOaNk
	 VUVZqVGUBRjiIf8rPHe+jbyhg28wB8+PplGyDp/gfnyo73qiSeUBqoiVwT4ArDprZb/BT
	 /xieLJmEWiXj2B/r9m+ftvBAOn4M3UQoO6322aJM/zFnL4h8boPAI2bTsNGYNx0VG4g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a4QoDG3U;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA20606A33E;
	Tue, 20 Oct 2026 13:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a4QoDG3U
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792503054;
	b=sNbvZGLh52y95yLEvombeiNnRAnPAnpmldFsE/4U1JUVPX2M0t1QL4ud4iw7y6q+w+Fk
	 sBnUsusOzcyUPaAmz0fMjtUnN3PwWz9F2lAFvxRnbSBrl90Xv3RqRCLgj7M5BGU3wO82F
	 apEreRXIFwIdgI6UlhoBWCpkdpx4VIL6tKWz179Q+mscy/zcpiN+GAebPYkSnVArCtSlh
	 uka1BRLhrPKPA3LaRLdHtm5BP7jZlh62lUQE5AMabOZuQpkAJKK/0ZvRUEpl8/2am33aE
	 IafsF03pt646XoCgPU3DzIu3ggAFAxwPQ81ZgvZjbNVkYG9+t5c12tXMXc0F+MjVgpg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792503054;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=iZ5a4t7/z6qVfKpQUXiPBl/MQsyqoAdOBP59oCQm5TE=;
	b=CnlKxf4/+7dPHW/URvMPI7ptf/tLBw4sJDmjDSnDEcCRh6C+g4U1E3ZrgM+rO6Ss2qKV
	 KWDiYbEyBACltCRkefZc+IKerHomz/qgYca9m8E2IT0ewT1kofl8wH818/irFwWeyisbk
	 x9YthapPZfqni3E5fVhewrtP6jMUbOUCATtAyYTsMZJY+S2rpWWhBvUNEVMjV72V/Quih
	 aQmdROfQqxnbP/gw3FuyWruxLDcWkd6E0K7U7Fc4Mco/DMM70jgy05CmOzZ34ETGVPO9s
	 ylDvNcA/XMWoLm9qVg4JkybEphz1PvMlmonnLgVW+UcDa62F5FBmk4tgoTIk82b5XLw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 471561F000C9;
	Tue, 20 Oct 2026 13:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792503054;
	bh=iZ5a4t7/z6qVfKpQUXiPBl/MQsyqoAdOBP59oCQm5TE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=a4QoDG3UUME6i8yD0T5hemNAu+eOK44KcyWzJq7JpOFBp6UYOldzgshlQOAh7pipc
	 bz6pYHBL+cFieZo7DoxdMzeriosU229f9ZKKnanfnahIFPHFcekpdzb/oJetN+wlHh
	 z7WCkHQIyd0COysW0IzTmnZiZw+uuEu11LNK+uQWrMlLvKVZ5qlbcobLx3Hf12RJPs
	 H0qH0+a+lJrtd9cPhIcPR14tJGrs1JY05sTh+usYpjYXTWdBfbLdJ59pjbbMxX8VRt
	 VS6vlQ/L7/jIeeXDZ6MqYu7K9DHf/BTYmapEg/QIeTJreEqdaWR1eUXdXcTOAmzVpC
	 rluv43ctaoaBA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id AA1474318F;
	Tue, 20 Oct 2026 13:30:51 +0000 (UTC)
From: =?utf-8?q?St=C3=A9phane_Grosjean_via_B4_Relay?= <devnull+s.grosjean.peak-system.fr@kernel.org>
Date: Tue, 20 Oct 2026 15:30:45 +0200
Subject: [PATCH v5 06/10] can: peak_usb: harden channel handling in
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
Message-Id: <20261020-canfd_check_channel_idx-v5-6-a62b35b867f0@peak-system.fr>
References: <20261020-canfd_check_channel_idx-v5-0-a62b35b867f0@peak-system.fr>
In-Reply-To: <20261020-canfd_check_channel_idx-v5-0-a62b35b867f0@peak-system.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Dan Carpenter <error27@gmail.com>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>, 
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792503050; l=9022;
 i=s.grosjean@peak-system.fr; s=20261020; h=from:subject:message-id;
 bh=hxMAg2zjylNdq/y8YWH3p+YyrFMLMRnjsYt+c7nDS8w=;
 b=FOsD+sENQFY4VwMCCWpYZ8c7+om/L6CR5lfAX7JGFDJ/CnZ1N4WXlLb3+ONGWuoX/Xjst7Nof
 Xa/HJCiXiQ+D2SNYpfQ1fcLvYa4QreZx6xiowduDn03g1LdxvCg77fG
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

When probing a channel fails after its slot has been filled, the
channel is freed but its slot kept pointing to it. Clear the slot in
pcan_usb_fd_free() and, before freeing the channel, stop RX on the
sibling channels already created, since the whole interface is then
released anyway. Slots are published with smp_store_release() and
read with READ_ONCE().

Finally, peak_usb_disconnect() now stops RX on all channels before
unregistering any of them: it clears CONNECTED, which makes
peak_usb_ndo_open() fail, then poisons the RX anchors. This matters
when it is called from the probe error path, where the USB core has
not disabled the interface.

Fixes: a6921dd524fe ("can: peak_usb: add range checking in decode operations")
Signed-off-by: Stéphane Grosjean <s.grosjean@peak-system.fr>
---
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 30 +++++++++++++-
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c   | 62 +++++++++++++++++++++-------
 2 files changed, 75 insertions(+), 17 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index a1b17e1e6fea..4c08656e7768 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -574,6 +574,9 @@ static int peak_usb_ndo_open(struct net_device *netdev)
 	struct peak_usb_device *dev = netdev_priv(netdev);
 	int err;
 
+	if (!test_bit(PCAN_USB_STATE_CONNECTED, &dev->state))
+		return -ENODEV;
+
 	/* common open */
 	err = open_candev(netdev);
 	if (err)
@@ -904,6 +907,22 @@ int pcan_get_ts_info(struct net_device *dev, struct kernel_ethtool_ts_info *info
 	return 0;
 }
 
+/*
+ * stop RX on dev and on all its previous siblings: clearing CONNECTED makes
+ * peak_usb_ndo_open() fail, then poisoning the RX anchors waits for running
+ * completion handlers and makes any later submission on them fail.
+ */
+static void peak_usb_stop_rx(struct peak_usb_device *dev)
+{
+	struct peak_usb_device *d;
+
+	for (d = dev; d; d = d->prev_siblings)
+		clear_bit(PCAN_USB_STATE_CONNECTED, &d->state);
+
+	for (d = dev; d; d = d->prev_siblings)
+		usb_poison_anchored_urbs(&d->rx_submitted);
+}
+
 /*
  * create one device which is attached to CAN controller #ctrl_idx of the
  * usb adapter.
@@ -1014,6 +1033,12 @@ static int peak_usb_create_dev(const struct peak_usb_adapter *peak_usb_adapter,
 	return 0;
 
 adap_dev_free:
+	/* the whole interface is released when probing a channel fails:
+	 * stop RX on the channels already created, since their RX URBs may
+	 * carry records for this one.
+	 */
+	peak_usb_stop_rx(dev->prev_siblings);
+
 	if (dev->adapter->dev_free)
 		dev->adapter->dev_free(dev);
 
@@ -1038,13 +1063,14 @@ static void peak_usb_disconnect(struct usb_interface *intf)
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
index 15d275d6a127..eee5b5eaa247 100644
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
@@ -981,6 +1006,9 @@ static int pcan_usb_fd_init(struct peak_usb_device *dev)
 		if (!pdev->usb_if)
 			goto err_out;
 
+		/* needed by the decoders to check channel numbers */
+		pdev->usb_if->adapter = dev->adapter;
+
 		/* allocate command buffer once for all for the interface */
 		pdev->cmd_buffer_addr = kzalloc(PCAN_UFD_CMD_BUFFER_SIZE,
 						GFP_KERNEL);
@@ -1054,7 +1082,8 @@ static int pcan_usb_fd_init(struct peak_usb_device *dev)
 		fw_info = &pdev->usb_if->fw_info;
 	}
 
-	pdev->usb_if->dev[dev->ctrl_idx] = dev;
+	/* publish dev to the decoders, after the ctrlmode copies above */
+	smp_store_release(&pdev->usb_if->dev[dev->ctrl_idx], dev);
 	dev->can_channel_id =
 		le32_to_cpu(pdev->usb_if->fw_info.dev_id[dev->ctrl_idx]);
 
@@ -1124,14 +1153,17 @@ static void pcan_usb_fd_exit(struct peak_usb_device *dev)
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


