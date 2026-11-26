Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795683703;
	b=XLtFeF/xGofH8qJ/v9bAvwUo9N6xEVr4FvVBAjfH/MWkHF4jwbElu/mN/6VmLXoqaibD
	 cQcK4OKNcyFsXqJm60RCJEULEbAEMS00IItEBuuBZAk+6VjRDsMJrzFCXKOJeu5nlz31Z
	 27/x71McZvCJ2MwMWcQKcntrf3CX9HYvU9EcNHQY9gXt27Wnq8+JpUJJOtgWEGmmb9qBT
	 gi8qRY/KFqL08zRR6G2A0g2XTvPnYxvK+4EBj2pl2W4Wl2W+C0O6oKbp5GVsmi7bsOifp
	 Gul3cKcuHi/wZ2mna835/+PUbrqw670EqTWpm5LPWuWpcPMYFcwbCWD4orF6+HVryhw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795683703;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=NdxKmTob2jKmWmCoJuIG4axqDYMyLxDmQmO+4KJYMMc=;
	b=GcYDZp9IenFecqVej0EBpwpRfFwlQf1imrI32Ro/+FZNz5QiEMdLtKzn/jSHHBORpbNS
	 bPCYZVWQCsHokQgBvNoBkHwGwGSQNcJAZDM7f9WYwkuC1fcfhwFFNILH9oXua968czBRv
	 Ns8eqpDZRi0sPcgppzgiMbPjp7WrrOrU7EIESED+0ulI3NRmDQvVC2baIya2Hq8BAlgzg
	 2K6E1U26qXDOER70mOvXuNjokeArQAWk/m2i64QfIUf0/eNwP1+E2HBaukmvREOlQc4VQ
	 mBguV355uAY4uGaQorR+42nNrNOFoWf2/2GeZC5I45bR2h48jJzPNZa2t48pJKFqdvA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OA51ijPw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E39606A6A1;
	Thu, 26 Nov 2026 09:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OA51ijPw
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795683702;
	b=VkUu/IKKX8I8Gx8uLhbqS9kQRpy9VRlB/uubo8XiD85EwgkXHKQlK6kp6/fLNhqtTD/L
	 1RBBc2RIaJDKKHhrbjv1QyfF9ewTqsfDOIrSCjWWOZekRWddWulAIBJs6rVzyZRSOqBE1
	 Y+lnQz7ynIKI1+kBUxgQJJtI6xFRnMZ8JLTB6HXoGSzz4kIL6yJ9VsFqMQo1ErpsGOiM8
	 N9I9YL3BDQZfRjHk69s8kQvIOlGUWSxMaEhSUM/RLXy7/79aX7RbfrraHS+Pr4/OjgYgj
	 quzqCbPO7k6KXPyuzO3ZygiSdFisD+LSD6DdIaO/za0B79H1Zm1lUbyeYjb5b76UBJQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795683702;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=NdxKmTob2jKmWmCoJuIG4axqDYMyLxDmQmO+4KJYMMc=;
	b=HBlxty0IlnX4FWJClHqjJpA93WUcgXTLS0AdSITqgTEWKAUyBLB6rl33q1vHIYSPezxk
	 NoNUIN3+Ef6G0q87i/QX3GVQZqcQGbDgwZt6kNRMmZpg7Y/qG72hjEKNfpcgG5LlwUaNR
	 8+pT+GytpINFu0XQ0yhHaoKQWTJORm2CEDA1jRS0rRKyN/agW42O9JNT+A6poJl+jzkBa
	 s96MeABog5/28SYHDUPNApoq9E0FsGGrCBOuW6tNFN+YApUWmzMks0xFs5QhPCqgQFnFb
	 Pf+iiq3nesHE2p4G+jg8R9CGxCdWsYwANmqi3V+FTDevID7o2l7b1O6uUUQpPhZHtig==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 9DB8E1F000E0;
	Thu, 26 Nov 2026 09:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795683702;
	bh=NdxKmTob2jKmWmCoJuIG4axqDYMyLxDmQmO+4KJYMMc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=OA51ijPwx3dBveGzyN5mY5wwnXkZYMvo1KiQZ7HZGKMuvRePKzAiDhzfS0dQ4uUXW
	 erkr03hA2IikwjOBA+LrQt8VMJKKRI1ITbpySzFDwbEo6Kukh82EoCQOHlG9d2kEQW
	 GpgHtf+y19NZF3kcgkdzf+VbZ2wP/cRu9hJNhIueY1vcrhqMfHknnKcofKx+cmSvKd
	 5dJSO6TuVG48xHSemW/aLiFG+JUxwxonNqzZMOZwpPn/J+pOMeJepv0Ym116SBlxwj
	 l87iGLO8P/I1JhiZLSNP0gsavA05YnMdf32EraG2NrZm+Ef1kAJA+1yeOcDRflaR5o
	 21bxlCB0G1FZA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 9ADD84D32A;
	Thu, 26 Nov 2026 09:01:20 +0000 (UTC)
From: =?utf-8?q?St=C3=A9phane_Grosjean_via_B4_Relay?= <devnull+s.grosjean.peak-system.fr@kernel.org>
Date: Thu, 26 Nov 2026 10:01:08 +0100
Subject: [PATCH v9 07/14] can: peak_usb: register the netdevs only once all
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
Message-Id: <20261126-canfd_check_channel_idx-v9-7-abe0099b4585@peak-system.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795683678; l=8101;
 i=s.grosjean@peak-system.fr; s=20261020; h=from:subject:message-id;
 bh=2ibTZHw3RWB4dKVVUuEA4Y1McnIMQz/tIqOurBhsX5w=;
 b=nHiDW4S4jGDF7UJr1SNKFIICwHMETeZTgp74Tr8KpUJpXsRc8fROtMku5f1WpGVg0/oD2aiDC
 eW8EImzEGGKD88WcZzRxfvVkNp+9/Xb+LOdBCLGaGuRpX8C3XssLVQu
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
interface resources: on PCAN-USB Pro FD and PCAN-USB X6, the command
buffer and the firmware info used by the sibling init, and the
ctrlmode copied from the first channel.

Moreover, if dev_init() or dev_set_bus() fails, the adapter private
data is released before unregister_candev(), which closes the netdev
if it has been opened in the meantime, and then accesses the released
data (interface object and, on the CAN FD adapters, command buffer).

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
Signed-off-by: Stéphane Grosjean <s.grosjean@peak-system.fr>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c      |  7 ++-
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 68 +++++++++++++++++-----------
 drivers/net/can/usb/peak_usb/pcan_usb_core.h |  1 +
 3 files changed, 47 insertions(+), 29 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 90f69afcba97..451d08421504 100644
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
index 234d20f81154..bed2b3c70f82 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.h
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
@@ -108,6 +108,7 @@ struct peak_tx_urb_context {
  */
 #define PCAN_USB_STATE_CONNECTED	0
 #define PCAN_USB_STATE_STARTED		1
+#define PCAN_USB_STATE_REGISTERED	2
 
 /* PEAK-System USB device */
 struct peak_usb_device {

-- 
2.53.0


