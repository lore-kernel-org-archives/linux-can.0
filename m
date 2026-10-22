Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792679279;
	b=FkzCXjHmYozIlw4Lk4aqRP4j0glXOWOkcKA6Oi4dnakK/8ayuk23ICAe4AKspvuQzs5D
	 AmhhqBVQ+wnu+hywRj5c5NS4KdAtjwxIZTvqVf21ym+GQcGJlIcGVhp+4LvTsCeVMghPK
	 WCfS//8SGjyehWBiDho8kkm7cLs3+xvQwz0kvL1oBCeEVMPj5g/yE+zgkjm4BX8TBmK+k
	 LuhxLrlU8ZTAdu4Q1K/RWE0QrPVvY8f9Vt6SnvwsLWk+MKueAJr4R4qnoeZ7E1mmSR8F1
	 BXV8+AiCsgUy9uI7U8oOn5q4819CMxTXHxLwI6EuhELZC2yrC4APVVNuGP6FCtoj5eQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792679279;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=gXdC28kjKsNvFs+Nj3XMr4fQGQHTNexPAHwtYkqDynE=;
	b=3HYLJJutrN5u60mIQ67hc2GSa5YiKtFHl4G92+9HgZ4ba94S3VCPrzEY4C7gWh+RJxmQ
	 s79qySHLwtaDDjHaIvF/Cbu7uiNU1XsI9GBGs3DIPIESfu3Ai00WfuTOa3GmM8v6cd+C8
	 LS5a8GgOz67pgO72wsAUPtdgzwPSR8MmC+KgFzph7BNPpA04p1+LSGw0vAzTY149e9gfo
	 vhVG3scDoBdvXjFRaB7u9/NKEvYvr4AYfQJrdopSYEwGrRb1+ljwAQD8fxdsrH6tNtR9a
	 xmNbsaaPnYSVs6b2dz6T24b1K7K9zcq09aoc1d83Iae4BuOWX+Y4JEhDwKlWEUMBV/g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bVUf611I;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD0160A260D;
	Thu, 22 Oct 2026 14:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bVUf611I
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792679279;
	b=CQykxnIgkHewEWUwLuXmwg+zlqkH8WEY8PB8EuYYy3xVfueksw6cEBYZl5VPM0lr8iZO
	 2qzeDUuIzxTop40t9BTd4ewW1ftYZg3Q1owWsrYeL1dTdnTBujR2L53mNP7i5NEwAYFKe
	 qFK0/JkWPHd0TzNcds5Sa3IPISbbOKRw4CQCKMsuG7EozTdjGyfyISVjnmgrfdThamEIN
	 ES/vupSKYZ3pZeaT0IC8jk81RyF6AJJHuPX5CaXqUQRaUL6mUY63e/jO1jCSNG9S+bAsa
	 Byv1l4ES7xK9Vd5f1EXqShX7oK1LA08rDQ9UGtDWrQv7XSrvKyBnNbe99hIY//83c9Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792679279;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=gXdC28kjKsNvFs+Nj3XMr4fQGQHTNexPAHwtYkqDynE=;
	b=yc2QCcaZOA+PCMx0NGBlIMhBfx4ybPVwcwtzlVZrzl24WqE3qs/WRxLCYzN39hpwPiX9
	 jeHWf8hBgd7226ftmaJH1Deehtt8E7wFPaUcA+iB4mqYPdL6o0W/TRFAsuCjW9B8MutiN
	 bguTmH5g89QLUE1TU7oD7SsFVDg8MElAT3jxvZjOGobvRI7jXih8blJECxi7tdM9FsDsV
	 67Cs22fCATGvmp8lz4QqlK+Mgu0nXrdMLoWVHjgLx8j4CuJP9Ql1VhWdbsSvYgkMriDi1
	 H/ushIqYOffdrLDTb6zpxl5PshI/6wt6e8dPlb0cNCr8rHpc0XJ3Vq0uY2QnkvJamuA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E1CC51F000C1;
	Thu, 22 Oct 2026 14:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792679279;
	bh=gXdC28kjKsNvFs+Nj3XMr4fQGQHTNexPAHwtYkqDynE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=bVUf611I5Pghw61o4P3u57FLIPYcC1NyIp63CvIaFmKwqFFHx2Y9YZcO4gMdoG/o6
	 sex10bhy9ND2sO1uh0XhEiri6qPwJbXdV1mrYInV93q9TrdRFW9eGrwl8A/jk4tEhs
	 o4krALWE38ihaTSSysmbphtwKSYBhO7GLqmSTlr2da0fVP+E9zB8OcJnsddzqO+XhL
	 0/yhEV69KozsXfLhC1GIN12RIB92tRF1f21A0nPIJx8rFFAHtNe/A8hFKXV+CuWooC
	 olSYdf2l1t77b1+nOyP5kfKqXFiL5NecWz6RqpdJ3WA3zIqcj9vezWmJypuZku1Cch
	 QgULMj/ebQ6Gw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id CC3B6435D1;
	Thu, 22 Oct 2026 14:27:54 +0000 (UTC)
From: =?utf-8?q?St=C3=A9phane_Grosjean_via_B4_Relay?= <devnull+s.grosjean.peak-system.fr@kernel.org>
Date: Thu, 22 Oct 2026 16:27:54 +0200
Subject: [PATCH v6 09/13] can: peak_usb: register the netdevs only once all
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
Message-Id: <20261022-canfd_check_channel_idx-v6-9-197704231551@peak-system.fr>
References: <20261022-canfd_check_channel_idx-v6-0-197704231551@peak-system.fr>
In-Reply-To: <20261022-canfd_check_channel_idx-v6-0-197704231551@peak-system.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Wolfgang Grandegger <wg@grandegger.com>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>, 
 Dan Carpenter <error27@gmail.com>, Lukas Magel <lukas.magel@posteo.net>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792679273; l=7291;
 i=s.grosjean@peak-system.fr; s=20261020; h=from:subject:message-id;
 bh=RvVCTQm8fLAuJShZhiQJSqe9W+BR2PIIqFnBMhgsOKM=;
 b=fFW82Rwy7VA1bdT1QK1dFrFmwSS6hyLH/bwfLomf3PiJ4WEswVVEquG/w24/4kptmPxyY879O
 OBHqikSDjMWAcrXEpGgvP1HAWbuS3Auc3tQWSD+BiCYCIh4RaWx4Rb2
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

Register the netdevs in peak_usb_probe(), only once all the channels
of the interface have been initialized, and only unregister the
registered ones in peak_usb_disconnect(). Since no netdev can be opened
during probe anymore, there is no RX to stop when probing a channel
fails. Since the channel id is now read before the netdev is
registered, PCAN-USB reports a failure to read it with dev_err()
instead of netdev_err().

Fixes: bb4785551f64 ("can: usb: PEAK-System Technik USB adapters driver core")
Assisted-by: LLM
Signed-off-by: Stéphane Grosjean <s.grosjean@peak-system.fr>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c      |  7 +++-
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 61 ++++++++++++++++------------
 drivers/net/can/usb/peak_usb/pcan_usb_core.h |  1 +
 3 files changed, 42 insertions(+), 27 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 6a5ecb10c4f3..8a0a132983c4 100644
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
index 49d2c01b8ef7..ea6c28f3ed0b 100644
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
@@ -1035,24 +1026,15 @@ static int peak_usb_create_dev(const struct peak_usb_adapter *peak_usb_adapter,
 	/* get CAN channel id early */
 	dev->adapter->dev_get_can_channel_id(dev, &dev->can_channel_id);
 
-	netdev_info(netdev, "attached to %s channel %u (device 0x%08X)\n",
-		    peak_usb_adapter->name, ctrl_idx, dev->can_channel_id);
+	if (dev->prev_siblings)
+		(dev->prev_siblings)->next_siblings = dev;
 
 	return 0;
 
 adap_dev_free:
-	/* the whole interface is released when probing a channel fails:
-	 * stop RX on the channels already created, since their RX URBs may
-	 * carry records for this one.
-	 */
-	peak_usb_stop_rx(dev->prev_siblings);
-
 	if (dev->adapter->dev_free)
 		dev->adapter->dev_free(dev);
 
-lbl_unregister_candev:
-	unregister_candev(netdev);
-
 lbl_restore_intf_data:
 	usb_set_intfdata(intf, dev->prev_siblings);
 	kfree(dev->cmd_buf);
@@ -1081,7 +1063,8 @@ static void peak_usb_disconnect(struct usb_interface *intf)
 		dev_prev_siblings = dev->prev_siblings;
 		strscpy(name, netdev->name, IFNAMSIZ);
 
-		unregister_candev(netdev);
+		if (test_bit(PCAN_USB_STATE_REGISTERED, &dev->state))
+			unregister_candev(netdev);
 
 		kfree(dev->cmd_buf);
 		dev->next_siblings = NULL;
@@ -1102,6 +1085,7 @@ static int peak_usb_probe(struct usb_interface *intf,
 			  const struct usb_device_id *id)
 {
 	const struct peak_usb_adapter *peak_usb_adapter;
+	struct peak_usb_device *dev;
 	int i, err = -ENOMEM;
 
 	/* get corresponding PCAN-USB adapter */
@@ -1116,13 +1100,40 @@ static int peak_usb_probe(struct usb_interface *intf,
 
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


