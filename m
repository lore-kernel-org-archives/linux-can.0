Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793357109;
	b=36iTqtaPuJ260Zt2L1mW5bigoHi/w8yY3LwOFUZ0gdoKPvXxZQSv04xUQm9/e/BWVnYi
	 CP9ZXBlsTaB2D7VHQ8j6WQiRFRfOp44nzenubUlOLtTMFHgeWORkYxqaXqnoDiOlCdV2l
	 5fez/B4D1/HBsa4oIuMOOKsgMjq0EdWr61ge2QEmmIHDXAch3K8tmEuBGpfkUiLK2Fj78
	 TKhTGJGfJTeAMC92v5eGgzOLAR6UA60YaH1kvXzjfYU2C1cWiGR+VuudoVTzdX8CImXAC
	 MqVkf+N95co6HkyolZmUrE0VDDihFIbUXBcsjbWygiySR7Bl+K94JucFnVnEHscupqg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793357109;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=zioIP25N+/NtKNlmuSpg6KuzX2sgXyXQVeM+7LFdp24=;
	b=lRZBeAFekV09UYTOV94pQ9oHCbbuhRnuXCuKyS2AdRWgJPBlW3fs8hclZ8CUBmENXMxB
	 i7iY7PqNj1owiTPJR1pPzzUZp4iqAaIj0JkWlTZ25kUT5reN8godymT1EtUpy8DgZnFUs
	 ehnmhZ+AFndmIq2a4JIKKOmoj6n7ixVNIANpL8D+AHV2bFtMuBGP02OU+TnyMuj0TIY25
	 NGm54niDy/lsE5IQLV+pJG047Zgd3hVb3gMVGlaizsywiGMnlwMFCxcJd1nyV3dzDZq6F
	 F6ug2qO/6h7+s0HVTisqAOdWwE6mL/M0bbctGFfRRXoFsMbiL7+6l6hTlFT2PHDp7fQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="X/xxVosR";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E548960A2625;
	Fri, 30 Oct 2026 10:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X/xxVosR
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793357108;
	b=rRb4hB5XfbwwdWZyVC9+HNRalRYVzzE6nFi1wBk93aLcm7s0ULPaAx/BC42DBLhSjdda
	 34KXifGiSyi+vL9E0ZQK5PPBN614+woJn32BAOznMl5K2FdrTNULNWWylqkXadMYOve98
	 4Q6jlIdq7LI5a/JKjcAcKIqO0HwKBYFdf1BELuu0c7CjNwdWigzZ0lrEcgm7reGOwKk7e
	 a/CZQOlPAgMTcjZv46utHCnSSebCDzx56sa3IUg/CVFA0n0LPXP+3qnAoP4jPBOkIl9HY
	 cj2vzGud9EnvtnWMH9dZzxAAXTkXidDzFTilllNIHMR1hHA8CvclYb3226LibUMFddw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793357108;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=zioIP25N+/NtKNlmuSpg6KuzX2sgXyXQVeM+7LFdp24=;
	b=UELaFawh2DN5x5vc2wfdVgVSdPJOXZLJ+yon3KkF/298PX/iyuEfKUKqJDXIsgit5XdW
	 buT+ZslfN1ooLBDhWjIho4y9HCM+jxKH3b/LF+8oSYSrP/JtiIjKKM6gCoJfe7hV52ZJQ
	 6Yxh/WseXaJbiiSu8xVnKulzHzpOLjegJSDYoqvoyobYwQ6AzGqAWAoEfO4zQWEFyWb6h
	 G3IzYDxZqSC15OuQSUmnavztiic2M+Il2NgXqI0eax5W7QnPUNoEK5sW/zegFbNIJrb44
	 I6UoQeeHswfCChEWyd00AAA5BnIyIA/gTqv+X4/d5Z1cPnkUXLDM9yBfmxyS7Luj+WA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 108A61F00A1C;
	Fri, 30 Oct 2026 10:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793357108;
	bh=zioIP25N+/NtKNlmuSpg6KuzX2sgXyXQVeM+7LFdp24=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=X/xxVosRKoKZ6yxtaGmKfpe+tK3blq8mSb2/nGqGL/51D5DT6D/QaWV5pmJmsHwCi
	 PJ/vbKezGbJNimvAUpR9qSUC/wV7so4zZt3T5/cMLnIrbFKDOXVK34+xfgrOkrDX4l
	 OBjr93U4/xL4g5TpD9xsIf8lUMasUXODB2cyxcU7k0NCONpDRXwB7cR8UfN67YiugZ
	 P4/aLDx9ZunfS6NyvqFxx3jA4QZvLCYFVVroayUe8K7WqaXmK/NJAMy4oXMoOdJG9g
	 S3CC2QKdsU5gLwi8OR6dCyhqFTmO9d9rX3Evd/RUtNxSFlVJWio/9NN+d80YLKKl7D
	 +LJyOS+iF/VkQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 8507043746;
	Fri, 30 Oct 2026 10:45:04 +0000 (UTC)
From: =?utf-8?q?St=C3=A9phane_Grosjean_via_B4_Relay?= <devnull+s.grosjean.peak-system.fr@kernel.org>
Date: Fri, 30 Oct 2026 11:44:54 +0100
Subject: [PATCH v7 05/13] can: peak_usb: replace open-coded bitmask
 operations with bitops
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
Message-Id: <20261030-canfd_check_channel_idx-v7-5-fc4a3faf3acf@peak-system.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793357103; l=6592;
 i=s.grosjean@peak-system.fr; s=20261020; h=from:subject:message-id;
 bh=p42mXjmiigrEaUiTmqRJFDMyO8gSZC8CLCf1FZzVJTo=;
 b=NcEJp3WNE714zN+eOpH3yq3+lJwvBo4iue6CxVdj95jxftgSC/JjT4Rr6bJ49savneNDdZU4W
 MQPQUfZG04gC61joPLMOd2D1yaQS2HDxbv4d0PV5rs0RKMDDySaeYd0
X-Developer-Key: i=s.grosjean@peak-system.fr; a=ed25519;
 pk=bP7QV2zvvAKAfConZlUOGKGEcXL64SNUpVUm++Ai+/c=
X-Endpoint-Received: by B4 Relay for s.grosjean@peak-system.fr/20261020
 with auth_id=1250
X-Original-From: =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>
Reply-To: s.grosjean@peak-system.fr
Content-Transfer-Encoding: 8bit

From: Stéphane Grosjean <s.grosjean@peak-system.fr>

The PCAN_USB_STATE_* flags of struct peak_usb_device are set, cleared
and tested from different contexts (ndo_open/ndo_stop, USB disconnect,
URB completion) with non-atomic open-coded bitmask operations.

Turn these flags into bit numbers, make the state field an unsigned
long and use set_bit(), clear_bit() and test_bit() instead, so that
updating one flag can no longer overwrite a concurrent update of
another one. The next patch relies on this to clear CONNECTED while a
channel may be opened.

dev->state is zeroed by alloc_candev(), so setting CONNECTED with
set_bit() at creation is equivalent to the former assignment.

Signed-off-by: Stéphane Grosjean <s.grosjean@peak-system.fr>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c      |  4 ++--
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 10 +++++-----
 drivers/net/can/usb/peak_usb/pcan_usb_core.h |  9 ++++++---
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c   |  2 +-
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c  |  6 +++---
 5 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index b515acd36466..b9cd6cbeb912 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -158,7 +158,7 @@ static int pcan_usb_send_cmd(struct peak_usb_device *dev, u8 f, u8 n, u8 *p)
 	int actual_length;
 
 	/* usb device unregistered? */
-	if (!(dev->state & PCAN_USB_STATE_CONNECTED))
+	if (!test_bit(PCAN_USB_STATE_CONNECTED, &dev->state))
 		return 0;
 
 	dev->cmd_buf[PCAN_USB_CMD_FUNC] = f;
@@ -188,7 +188,7 @@ static int pcan_usb_wait_rsp(struct peak_usb_device *dev, u8 f, u8 n, u8 *p)
 	int actual_length;
 
 	/* usb device unregistered? */
-	if (!(dev->state & PCAN_USB_STATE_CONNECTED))
+	if (!test_bit(PCAN_USB_STATE_CONNECTED, &dev->state))
 		return 0;
 
 	/* first, send command */
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index 55aad01cd8ca..a1b17e1e6fea 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -263,7 +263,7 @@ static void peak_usb_read_bulk_callback(struct urb *urb)
 	/* protect from any incoming empty msgs */
 	if ((urb->actual_length > 0) && (dev->adapter->dev_decode_buf)) {
 		/* handle these kinds of msgs only if _start callback called */
-		if (dev->state & PCAN_USB_STATE_STARTED) {
+		if (test_bit(PCAN_USB_STATE_STARTED, &dev->state)) {
 			err = dev->adapter->dev_decode_buf(dev, urb);
 			if (err)
 				pcan_dump_mem("received usb message",
@@ -537,7 +537,7 @@ static int peak_usb_start(struct peak_usb_device *dev)
 			goto err_adapter;
 	}
 
-	dev->state |= PCAN_USB_STATE_STARTED;
+	set_bit(PCAN_USB_STATE_STARTED, &dev->state);
 
 	/* can set bus on now */
 	if (dev->adapter->dev_set_bus) {
@@ -631,7 +631,7 @@ static int peak_usb_ndo_stop(struct net_device *netdev)
 {
 	struct peak_usb_device *dev = netdev_priv(netdev);
 
-	dev->state &= ~PCAN_USB_STATE_STARTED;
+	clear_bit(PCAN_USB_STATE_STARTED, &dev->state);
 	netif_stop_queue(netdev);
 
 	close_candev(netdev);
@@ -941,7 +941,7 @@ static int peak_usb_create_dev(const struct peak_usb_adapter *peak_usb_adapter,
 	dev->netdev = netdev;
 	dev->adapter = peak_usb_adapter;
 	dev->ctrl_idx = ctrl_idx;
-	dev->state = PCAN_USB_STATE_CONNECTED;
+	set_bit(PCAN_USB_STATE_CONNECTED, &dev->state);
 
 	dev->ep_msg_in = peak_usb_adapter->ep_msg_in;
 	dev->ep_msg_out = peak_usb_adapter->ep_msg_out[ctrl_idx];
@@ -1044,7 +1044,7 @@ static void peak_usb_disconnect(struct usb_interface *intf)
 		char name[IFNAMSIZ];
 
 		dev_prev_siblings = dev->prev_siblings;
-		dev->state &= ~PCAN_USB_STATE_CONNECTED;
+		clear_bit(PCAN_USB_STATE_CONNECTED, &dev->state);
 		strscpy(name, netdev->name, IFNAMSIZ);
 
 		unregister_candev(netdev);
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.h b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
index 9ad7d31d2720..cb8777c3e08e 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.h
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
@@ -109,15 +109,18 @@ struct peak_tx_urb_context {
 	struct urb *urb;
 };
 
-#define PCAN_USB_STATE_CONNECTED	0x00000001
-#define PCAN_USB_STATE_STARTED		0x00000002
+/* bit numbers for struct peak_usb_device::state (used with set_bit()/
+ * clear_bit()/test_bit() for atomic read-modify-write across contexts)
+ */
+#define PCAN_USB_STATE_CONNECTED	0
+#define PCAN_USB_STATE_STARTED		1
 
 /* PEAK-System USB device */
 struct peak_usb_device {
 	struct can_priv can;
 	const struct peak_usb_adapter *adapter;
 	unsigned int ctrl_idx;
-	u32 state;
+	unsigned long state;
 
 	struct usb_device *udev;
 	struct net_device *netdev;
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
index 82502594a409..15d275d6a127 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
@@ -202,7 +202,7 @@ static int pcan_usb_fd_send_cmd(struct peak_usb_device *dev, void *cmd_tail)
 	ptrdiff_t cmd_len;
 
 	/* usb device unregistered? */
-	if (!(dev->state & PCAN_USB_STATE_CONNECTED))
+	if (!test_bit(PCAN_USB_STATE_CONNECTED, &dev->state))
 		return 0;
 
 	/* if a packet is not filled completely by commands, the command list
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
index 4c3d89a160af..cbc23953ce61 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
@@ -210,7 +210,7 @@ static int pcan_usb_pro_send_cmd(struct peak_usb_device *dev,
 	int err;
 
 	/* usb device unregistered? */
-	if (!(dev->state & PCAN_USB_STATE_CONNECTED))
+	if (!test_bit(PCAN_USB_STATE_CONNECTED, &dev->state))
 		return 0;
 
 	err = usb_bulk_msg(dev->udev,
@@ -234,7 +234,7 @@ static int pcan_usb_pro_wait_rsp(struct peak_usb_device *dev,
 	int i, err = 0;
 
 	/* usb device unregistered? */
-	if (!(dev->state & PCAN_USB_STATE_CONNECTED))
+	if (!test_bit(PCAN_USB_STATE_CONNECTED, &dev->state))
 		return 0;
 
 	req_data_type = pum->u.rec_buffer[4];
@@ -318,7 +318,7 @@ int pcan_usb_pro_send_req(struct peak_usb_device *dev, int req_id,
 	unsigned int p;
 
 	/* usb device unregistered? */
-	if (!(dev->state & PCAN_USB_STATE_CONNECTED))
+	if (!test_bit(PCAN_USB_STATE_CONNECTED, &dev->state))
 		return 0;
 
 	req_type = USB_TYPE_VENDOR | USB_RECIP_OTHER;

-- 
2.53.0


