Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792503055;
	b=Urt5Th1RdX43x55Q1D+784JD7Lb32uTdBO/UXbDw0gC1d1BwlFwy/+xrV+uw5hfbWHn/
	 TxdeyA3LFUWnT1UFoVKMNylUd6ihIyXet5rHxXROIh/1XebRk6GGFBRmurPGPdfGeLGD+
	 p3gOatGucSqVa++Xy4gDQc3tUE5nZRryoF8QTKD2WB/Hn0KQPfrMh2SfqVnxmZm8ucQfy
	 DR1XH60i76kcix1BSwJ0WIZLmtUctHtgYE2mSjw8BgWSLHXU2Tyv4kP8vmwxUN24acU+S
	 xLh4nwjNF82mHJ+Xa0lDLR1PSM24/YxGZWWEkwUvSLcPom4Hq1JVJXtCevWnin/gCgQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792503055;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=rTjjL7SxyXGYIUsoc9vE0/DKk2N0wAl31+Zp/8SaQM4=;
	b=d8aleFMG1AOJege/vg3ExzSoFDlRdXu7a21QQsdMw2vDLUq/kqmzsIpDr6kZiSYTTqtF
	 gPITvDlXSI74aX6sE1ilq+3ss9xZix5im8qRP0LdCxijUw0TLOjNa5Pc1rPidJ98nU+Zt
	 ShQtiRxnguRcfT1ecOKjMUEym6CPLVLQv8WO6ZRHmzXI1w5SffKVLIm6gZ2Rh6+dUWPKw
	 CB/xMCxqxUdxVKh7xQFLZnMoVQW5OvLFT6w351J2fiPcLadL9zjOfqVXimMhhtdaIdul7
	 cmRPMejm41RO7qwgz1wnS2IpIoabnnF8CK8iHux+MravlVGGrqar1NzkVRT0aZTUwPA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KqtILAUw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B7460A260E;
	Tue, 20 Oct 2026 13:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KqtILAUw
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792503055;
	b=gxstZYd9lIUVV7Zjfj93V9qAe19fuHgt8Vxz/NMQkD9Kf10Yvm+VQc5BHdOAUW6ye7HK
	 +PdQIn1/sOzD4qdFbmRjffBKa9e1OWgpvDwfRp+zp1kM20WYEnW9ZhoT5lEfUC069Gd8L
	 dGipNPAQy9bQdXfUt2aGZLcRIp7cMf8RWQJA0CRdPDbP2rbb8ugF7Ljfl666b5Ly+XbQT
	 I0x7Cq96Vx83dKL+3v/DgmnWjkZKTAzeq9h2ZfIAp/2TWxORApC1hnztIAZFMitspiZew
	 0OZyeLf5p2C2uOsqXmcHVooIGDUlwB/TJoBjaLyt12GBGpxDIUrt6L3FBu+tifzb6AQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792503055;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=rTjjL7SxyXGYIUsoc9vE0/DKk2N0wAl31+Zp/8SaQM4=;
	b=S8jmFE5JDzddnxss+ce0Hk1k5Gv3B/0nd0oq18l7wxrtFTEv6cqDJjT4hvLKu4zbzgu6
	 yA0yAyzDg38N5rTuWxS1+J2LIhyTH2slPSlHAPc0gM61h450mKXD/Leqfx8tgH9l/dDFG
	 uP8lT1hzZ4Jg/rB739g8E+JbZ8ylvPPVXh6YC0F7r2zbOsrVsYtzkXArcrortk+1dPyvQ
	 8xVdxxqqPx1O1NXBH7eL+JGVVzBnM76iPRamCjQ+J2ZuL7GqEFyZUD8slIUxzXLVwWXIh
	 I/L29J0sB69DmTsAud7xitb6hqCvfMt8ylOs88EjCweik1XBriVcGt69HqS5XKkrVEg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C701B1F000CD;
	Tue, 20 Oct 2026 13:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792503055;
	bh=rTjjL7SxyXGYIUsoc9vE0/DKk2N0wAl31+Zp/8SaQM4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=KqtILAUw3ngZLib9TD/aZsiSMZJP3L/aUQgZd+M3RoL8EYHLgybcG4qe3xlG9JDXk
	 FKeca2oKxsQPfKL7F5rDIVyVmPD/TEoccNukI5FWTz8MS8K/vEcq10iwHLyoS1W+Vc
	 Z5PRdjRk/hcXHffRHlQIoMXxh85XVIndK7PW750I6Yqr30SSVMWZPsUIdiqXUVtCR5
	 MabgFKqrKTWuC6jSL3UYO3CmPH5DIWYVNNGJ0RjH8i0sZSrQK6cXFRHIIQzaMpzduD
	 qROxSuwRjs7nyGVS9BgwsGZ6SBWE7ADBUnl0lkwOXGYpCnwv+gobcFStl+GMTt1yqg
	 v+s7kSFJnM85Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id BEB954319D;
	Tue, 20 Oct 2026 13:30:51 +0000 (UTC)
From: =?utf-8?q?St=C3=A9phane_Grosjean_via_B4_Relay?= <devnull+s.grosjean.peak-system.fr@kernel.org>
Date: Tue, 20 Oct 2026 15:30:48 +0200
Subject: [PATCH v5 09/10] can: peak_usb: register the netdevs only once all
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
Message-Id: <20261020-canfd_check_channel_idx-v5-9-a62b35b867f0@peak-system.fr>
References: <20261020-canfd_check_channel_idx-v5-0-a62b35b867f0@peak-system.fr>
In-Reply-To: <20261020-canfd_check_channel_idx-v5-0-a62b35b867f0@peak-system.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Dan Carpenter <error27@gmail.com>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>, 
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792503050; l=7271;
 i=s.grosjean@peak-system.fr; s=20261020; h=from:subject:message-id;
 bh=KZTWBY8IAWmYaGhKBCyj9RsygLBOLtJVG8kqRF6TXJ0=;
 b=LHpfg+G6SoaJaGryFXURL/y5MpCvKr9wpy5J39Wd+QokZgxdyXwi63A9Vlu+4kXrrC+CDYBib
 NQdWr/g8KJ/Dj5NDWXlbWAc8kJX6HxdEmhtbHh3mTQgXRX9rlgHBBFD
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
Signed-off-by: Stéphane Grosjean <s.grosjean@peak-system.fr>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c      |  7 +++-
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 61 ++++++++++++++++------------
 drivers/net/can/usb/peak_usb/pcan_usb_core.h |  1 +
 3 files changed, 42 insertions(+), 27 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 4c8cfed31634..c7246465dcc7 100644
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
index 4c08656e7768..a12ee6ec71e6 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -998,15 +998,6 @@ static int peak_usb_create_dev(const struct peak_usb_adapter *peak_usb_adapter,
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
@@ -1014,7 +1005,7 @@ static int peak_usb_create_dev(const struct peak_usb_adapter *peak_usb_adapter,
 	if (dev->adapter->dev_init) {
 		err = dev->adapter->dev_init(dev);
 		if (err)
-			goto lbl_unregister_candev;
+			goto lbl_restore_intf_data;
 	}
 
 	/* set bus off */
@@ -1027,24 +1018,15 @@ static int peak_usb_create_dev(const struct peak_usb_adapter *peak_usb_adapter,
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
@@ -1073,7 +1055,8 @@ static void peak_usb_disconnect(struct usb_interface *intf)
 		dev_prev_siblings = dev->prev_siblings;
 		strscpy(name, netdev->name, IFNAMSIZ);
 
-		unregister_candev(netdev);
+		if (test_bit(PCAN_USB_STATE_REGISTERED, &dev->state))
+			unregister_candev(netdev);
 
 		kfree(dev->cmd_buf);
 		dev->next_siblings = NULL;
@@ -1094,6 +1077,7 @@ static int peak_usb_probe(struct usb_interface *intf,
 			  const struct usb_device_id *id)
 {
 	const struct peak_usb_adapter *peak_usb_adapter;
+	struct peak_usb_device *dev;
 	int i, err = -ENOMEM;
 
 	/* get corresponding PCAN-USB adapter */
@@ -1108,13 +1092,40 @@ static int peak_usb_probe(struct usb_interface *intf,
 
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


