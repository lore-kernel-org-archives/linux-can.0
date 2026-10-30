Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793357108;
	b=Py6OR7EzWtu90O+3p0ebhyPsGIJWiKNw4NK07MaZKSiTHX9MgKFBvRBDDwntUxFL8rMv
	 yxl+/ezkzI3SztkuAHUlBDzQFVvxEdfjCNRnzYcp24O/d418q7+RXQK6488xt5bHaSH8X
	 4WPg2w1Ple3PkGltCObQ2qMcLhC1opsQVQEPsz1h0Yk01cDe2oYSU+hpKfi3fbijAIpTE
	 5AcX7FeVScoU2DAZJKOnndX25Uf9XWA3htPDIRulEzKDHuAHz854fVaJDPM63e/9NyEaI
	 QI37X6EKv3qtoAFBdGv+C/z7jfqGg+1yqLbObFUsZTsToIn3D7c+CDoByrwGrWKhiug==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793357108;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=qQFN62AxMgygxcK5bfENYBZz1dodOwj5QivR2pD8S9M=;
	b=gXHMMxK1yFM2mC/7UF53RsPbr+qzET49nOuJvj7IJXv2TWv4FRe9QyPE9pFfY24MnSiD
	 3cOLyF6MDD1iKBmaLeZEoYn4XyF5d+XPjb6dPtaqM4bpPv1LS5ZRPoLlcRqEasE5WTkTc
	 tlDuDxdTAXd/yFtTfqss/Flzebzx6IHihZwjGNuOz6Fl5Zl548x0ULUjkLj7UesjehsId
	 qbmL0IQSaX3lX0o7AIE8jQqLc2biPEMAfFpT4CjRVRMwbkgjHsfUeMppmX7wx4+qUg2iN
	 qQligHdVhF9ID2VubyG4uAfJNqfTVidzAwtSyNfkie3wGcrY1fXDRPPd+KFONKZ5fIw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cfmq7pwE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F72460A2616;
	Fri, 30 Oct 2026 10:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cfmq7pwE
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793357108;
	b=sJOi083DLfQwGrA8TFRik7R69xwvXMbknoOzVJS/6NIEXMGsCnI373OmkmC8z9GfbQnA
	 c6VDTiNS4Bx4xM1+AQ56b+eypl5jfq18V6cQ2aa9TzYybsLux0XD/dhy7bUa6dU1UmLzN
	 4+Hi1MMBAZS5Ce1D3z7Ts78evuu9rkC0PHs1pMej2wo8ZWgp+T3sz5Ph/g3k6No5lHGm0
	 VcZvIyIxxSpsK2EWmX+fAxPp06nNgwPw36iuS5uOc9Rck257+WeKi0Nh/+pSn6mbokE8v
	 2l9w5WQ83D6icaEk5W8NpqwCFgXaL75GCykH68mbzo3UQlt7xVcKI6/h7F6tS8y9Vmw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793357108;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=qQFN62AxMgygxcK5bfENYBZz1dodOwj5QivR2pD8S9M=;
	b=G9RNKzQ3XF4AiJsbG+dOz/vPS8RQ/KH0Mex0ix57rUdVImYUTvYUq23NKR06jTa2wFil
	 JQzPYDHDIMr0h1I5Onc2E6wD38KXTOafZ+BxTWW0IHvyk7FAYkLKKlCkf6ldVi3U8hvia
	 IP25buk8T21+f382wQtevGMxBmJcXYEd+6xMqxGnl0aGu01lcLkzYgfyRuaVd8w8sfnsE
	 ni7GLuU2mXj5O7LnctqXDqLNxumTgLDzkQuTGC1tQMMbHyMSQ2H74Cu6swuwzxvD3xw3+
	 7XXZSG41lZRG25ls+MID2UgKrP6kG6PSghLxcf7le+UmZbAZ6Sx80rWvH92WghiaQWA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B8A031F00A1F;
	Fri, 30 Oct 2026 10:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793357108;
	bh=qQFN62AxMgygxcK5bfENYBZz1dodOwj5QivR2pD8S9M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Cfmq7pwE74QQCX5fuIrSZKh/yqE9BP5wICYHgQGzklvCs3+9yPbfELw3GmkwxOkeO
	 BjJLDqd0qs+MDSQ85iXacH7xyri8Vcqf43bAXIu2qi12KgKrgzrplHcljaJL2h/E38
	 m15jMsF0mQj6GmqMdxCAB9k4HvY2E1Q2vMwgZQy9G7cvjX7hY69pSGFSLexu4jngqV
	 72465EzbpCNdPte3QrYI98qsQocSGuH9oOfLNBAgIZiz+jcRnuxrubnphLszlqJGN0
	 ysS4tL6fxHrmAHSLM97x9i1oUb8hq1Jh8ZsQ2Q+ReRd7+OP4OHYZX/qCk4DMoibROP
	 jrYilP/lnnVmg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id AFEC143756;
	Fri, 30 Oct 2026 10:45:04 +0000 (UTC)
From: =?utf-8?q?St=C3=A9phane_Grosjean_via_B4_Relay?= <devnull+s.grosjean.peak-system.fr@kernel.org>
Date: Fri, 30 Oct 2026 11:44:58 +0100
Subject: [PATCH v7 09/13] can: peak_usb: register the netdevs only once all
 channels are set up
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
Message-Id: <20261030-canfd_check_channel_idx-v7-9-fc4a3faf3acf@peak-system.fr>
References: <20261030-canfd_check_channel_idx-v7-0-fc4a3faf3acf@peak-system.fr>
In-Reply-To: <20261030-canfd_check_channel_idx-v7-0-fc4a3faf3acf@peak-system.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Wolfgang Grandegger <wg@grandegger.com>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>, 
 Dan Carpenter <error27@gmail.com>, Lukas Magel <lukas.magel@posteo.net>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tristan Madani <tristmd@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793357103; l=8091;
 i=s.grosjean@peak-system.fr; s=20261020; h=from:subject:message-id;
 bh=UodEPxuN6vR7kjGesicdCwnHgYwHNW/ZiS52oKVwhSo=;
 b=9KRWOcdgZ4+RF9QppfDzxovH0Yn8mnj3KxZxH5zlVbLXnvA9VCmDhzE8E59FOmRmBRvMMQROG
 9j5004DemXRDzqPgjwFGW2O4ZfpmKCpFbX2gQWuMgxwLF72Fsji4aWv
X-Developer-Key: i=s.grosjean@peak-system.fr; a=ed25519;
 pk=bP7QV2zvvAKAfConZlUOGKGEcXL64SNUpVUm++Ai+/c=
X-Endpoint-Received: by B4 Relay for s.grosjean@peak-system.fr/20261020
 with auth_id=1250
X-Original-From: =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>
Reply-To: s.grosjean@peak-system.fr
Content-Transfer-Encoding: 8bit

From: Stéphane Grosjean <s.grosjean@peak-system.fr>

peak_usb_create_dev() registers the netdev of a channel before calling
dev_init(), dev_set_bus() and dev_get_can_channel_id(). Userspace can
therefore open or configure the netdev while the channel is still being
initialized, outside of rtnl_lock():

- peak_usb_ndo_open() may run before dev_init() has set up the adapter
  private data, e.g. pdev->usb_if, which is then dereferenced while
  still NULL by pcan_usb_pro_start() or pcan_usb_fd_start();
- the commands sent by the open or bittiming callbacks may race with
  the ones sent by dev_init() on the same command buffer;
- dev_set_bus(dev, 0) may switch the controller off right after
  peak_usb_ndo_open() has started it.

On multi-channel adapters, the same applies to the channels already
created while a sibling is being initialized, since they share the
interface resources: on PCAN-USB FD, the command buffer and the
firmware info used by the sibling init, and the ctrlmode copied from
the first channel.

Moreover, if dev_init() or dev_set_bus() fails, the adapter private
data is released before unregister_candev(), which closes the netdev
if it has been opened in the meantime, and then accesses the released
data (interface object and, on PCAN-USB FD, command buffer).

Register the netdevs in peak_usb_probe(), only once all the channels of
the interface have been initialized, and only unregister (and report as
removed) the registered ones in peak_usb_disconnect(). Since no netdev
is registered while the channels are being created, there is no RX to
stop anymore when creating a channel fails. If registering a netdev
fails, peak_usb_disconnect() still stops RX on the channels already
registered, which may have been opened in the meantime. Since the
channel id is now read before the netdev is registered, PCAN-USB reports
a failure to read it with dev_err() instead of netdev_err().

Fixes: bb4785551f64 ("can: usb: PEAK-System Technik USB adapters driver core")
Assisted-by: LLM
Signed-off-by: Stéphane Grosjean <s.grosjean@peak-system.fr>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c      |  7 ++-
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 68 +++++++++++++++++-----------
 drivers/net/can/usb/peak_usb/pcan_usb_core.h |  1 +
 3 files changed, 47 insertions(+), 29 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 4c93aa060fea..777df7fd3e89 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -390,9 +390,12 @@ static int pcan_usb_get_can_channel_id(struct peak_usb_device *dev, u32 *can_ch_
 	int err;
 
 	err = pcan_usb_wait_rsp(dev, PCAN_USB_CMD_DEVID, PCAN_USB_GET, args);
+	/* explicit use of dev_xxx() instead of netdev_xxx() here: this is
+	 * also called during probe, before the netdev is registered.
+	 */
 	if (err)
-		netdev_err(dev->netdev, "getting can channel id failure: %d\n", err);
-
+		dev_err(dev->netdev->dev.parent,
+			"getting can channel id failure: %d\n", err);
 	else
 		*can_ch_id = args[0];
 
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index f5c39b43b0fa..e5198ec5c760 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -1006,15 +1006,6 @@ static int peak_usb_create_dev(const struct peak_usb_adapter *peak_usb_adapter,
 	SET_NETDEV_DEV(netdev, &intf->dev);
 	netdev->dev_id = ctrl_idx;
 
-	err = register_candev(netdev);
-	if (err) {
-		dev_err(&intf->dev, "couldn't register CAN device: %d\n", err);
-		goto lbl_restore_intf_data;
-	}
-
-	if (dev->prev_siblings)
-		(dev->prev_siblings)->next_siblings = dev;
-
 	/* keep hw revision into the netdevice */
 	tmp16 = le16_to_cpu(usb_dev->descriptor.bcdDevice);
 	dev->device_rev = tmp16 >> 8;
@@ -1022,7 +1013,7 @@ static int peak_usb_create_dev(const struct peak_usb_adapter *peak_usb_adapter,
 	if (dev->adapter->dev_init) {
 		err = dev->adapter->dev_init(dev);
 		if (err)
-			goto lbl_unregister_candev;
+			goto lbl_restore_intf_data;
 	}
 
 	/* set bus off */
@@ -1035,25 +1026,15 @@ static int peak_usb_create_dev(const struct peak_usb_adapter *peak_usb_adapter,
 	/* get CAN channel id early */
 	dev->adapter->dev_get_can_channel_id(dev, &dev->can_channel_id);
 
-	netdev_info(netdev, "attached to %s channel %u (device 0x%08X)\n",
-		    peak_usb_adapter->name, ctrl_idx, dev->can_channel_id);
+	if (dev->prev_siblings)
+		(dev->prev_siblings)->next_siblings = dev;
 
 	return 0;
 
 adap_dev_free:
-	/* the whole interface is released when probing a channel fails:
-	 * stop RX on this channel, which may already be open, and on the
-	 * channels already created, since their RX URBs may carry records
-	 * for this one.
-	 */
-	peak_usb_stop_rx(dev);
-
 	if (dev->adapter->dev_free)
 		dev->adapter->dev_free(dev);
 
-lbl_unregister_candev:
-	unregister_candev(netdev);
-
 lbl_restore_intf_data:
 	usb_set_intfdata(intf, dev->prev_siblings);
 	kfree(dev->cmd_buf);
@@ -1078,11 +1059,15 @@ static void peak_usb_disconnect(struct usb_interface *intf)
 	for (dev = usb_get_intfdata(intf); dev; dev = dev_prev_siblings) {
 		struct net_device *netdev = dev->netdev;
 		char name[IFNAMSIZ];
+		bool registered;
 
 		dev_prev_siblings = dev->prev_siblings;
 		strscpy(name, netdev->name, IFNAMSIZ);
 
-		unregister_candev(netdev);
+		/* on probe error, some netdevs may not be registered yet */
+		registered = test_bit(PCAN_USB_STATE_REGISTERED, &dev->state);
+		if (registered)
+			unregister_candev(netdev);
 
 		kfree(dev->cmd_buf);
 		dev->next_siblings = NULL;
@@ -1090,7 +1075,8 @@ static void peak_usb_disconnect(struct usb_interface *intf)
 			dev->adapter->dev_free(dev);
 
 		free_candev(netdev);
-		dev_info(&intf->dev, "%s removed\n", name);
+		if (registered)
+			dev_info(&intf->dev, "%s removed\n", name);
 	}
 
 	usb_set_intfdata(intf, NULL);
@@ -1103,6 +1089,7 @@ static int peak_usb_probe(struct usb_interface *intf,
 			  const struct usb_device_id *id)
 {
 	const struct peak_usb_adapter *peak_usb_adapter;
+	struct peak_usb_device *dev;
 	int i, err = -ENOMEM;
 
 	/* get corresponding PCAN-USB adapter */
@@ -1117,13 +1104,40 @@ static int peak_usb_probe(struct usb_interface *intf,
 
 	for (i = 0; i < peak_usb_adapter->ctrl_count; i++) {
 		err = peak_usb_create_dev(peak_usb_adapter, intf, i);
+		if (err)
+			goto lbl_disconnect;
+	}
+
+	/* register the netdevs only once all the channels are set up: the
+	 * channels of an interface share resources (command buffer, firmware
+	 * info, ctrlmode copied from the 1st channel...) that must not be
+	 * used through a netdev while a sibling is being initialized.
+	 */
+	for (dev = usb_get_intfdata(intf); dev->prev_siblings;
+	     dev = dev->prev_siblings)
+		;
+
+	for (; dev; dev = dev->next_siblings) {
+		err = register_candev(dev->netdev);
 		if (err) {
-			/* deregister already created devices */
-			peak_usb_disconnect(intf);
-			break;
+			dev_err(&intf->dev, "couldn't register CAN device: %d\n",
+				err);
+			goto lbl_disconnect;
 		}
+		set_bit(PCAN_USB_STATE_REGISTERED, &dev->state);
+
+		netdev_info(dev->netdev,
+			    "attached to %s channel %u (device 0x%08X)\n",
+			    peak_usb_adapter->name, dev->ctrl_idx,
+			    dev->can_channel_id);
 	}
 
+	return 0;
+
+lbl_disconnect:
+	/* unregister (if needed) and free already created devices */
+	peak_usb_disconnect(intf);
+
 	return err;
 }
 
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.h b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
index cb8777c3e08e..614854c998de 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.h
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
@@ -114,6 +114,7 @@ struct peak_tx_urb_context {
  */
 #define PCAN_USB_STATE_CONNECTED	0
 #define PCAN_USB_STATE_STARTED		1
+#define PCAN_USB_STATE_REGISTERED	2
 
 /* PEAK-System USB device */
 struct peak_usb_device {

-- 
2.53.0


