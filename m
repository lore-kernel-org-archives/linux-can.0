Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795683691;
	b=X6OF1yvy6v6B+YCa49OzUu8Cf7R8J4er+WwiCY16HQim52Fc1y2Wtnc4KKfmf1qwTocN
	 M6R/QuIfkpx4W7KJeUjuT1jTQ2+mkn1rrlseYpG/OL9XvSWoFdmCp985yTZ56Vvgk1vNb
	 MroNJCtFFEXIj355Eal8GyHeqOBo1pXZ5x/9/F3YK3XfNetk9d4JY8dEm0SDWNHNqzeUY
	 hfVB91kZ+wd172V4SGDFAcCbkTdXZ+k+juzcLCiuKlITq226kvPK/Dnxi5330Z6KhG5k9
	 A/7libx7WYrGUOCHA52GUSxDJMeOK2yy4U3Sjvks23jT5i1+g9K8ijdAcALS5wgiWJA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795683691;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=/0uv7wlnqwjf34IUQhcXoKJMYYHi9n6aoQ86OEYBRdw=;
	b=VQHazObP5pGzFvQPY4YwZGWiMgix11h0GBHAn+6qGTuQ2j8K9g3yvdARwOE9+rAFb2e0
	 jRgiG0c7NjBfjVu/PlAD4y3QL7tgA+Kpq5ghxlpr6rXAJFp7HBhXfRMtb2YZGWetCGhWE
	 dFnl4JNqS0M2lRFjV6nWXv7izzAJTzGBq38X17Kxx0DYygT5VuoqDXbU/mBv/XZTg9AgO
	 We665UiWkRdglt5vo9F4xTGWIO2W2wa2n4/S9B1pNnfcHvFXB7cx+H5rZDhTZ4Od6/72y
	 uLvZHxGoTHjYliCi7k6Om86+JhY3GfqzWDgmRtBjM/bCEqV4wYdDf4IYMGUV749wKJw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Wpzv6YD/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8674C606A31C;
	Thu, 26 Nov 2026 09:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wpzv6YD/
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795683690;
	b=tD4nsTKm1jDfsjzclfebo4ZGdh7L19mLSk1cdZCKKNlQ9VVfheyggKRzV9PcJ/L946Et
	 YEGAkuzziLA0MFa1JT3hroeuWP8sbehHRkUorgB8yonwUxoU1inuuOwnQDWIDqRzO+olV
	 JcMTOCk3ahJXhp1rqgs+QexgVF95yb3nGRs69N3AhcbA+Iv0ADz+ex4ntbl/RAniMkVrU
	 Xv3CM30wacI423rWkEp8eedDpcunhWwp5R5XkE4AzQLA8L0GPg9DxlzXWc+HszIP6vdjS
	 AH+1CwRahoDYCgkWKoPQ6CZiH9jYFqOYIgMHU9B5lIl2RUghtrwItsPsTff4CkU57rQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795683690;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=/0uv7wlnqwjf34IUQhcXoKJMYYHi9n6aoQ86OEYBRdw=;
	b=WBTLhmH8VnBWQWwrofNIAuDm+/E41UsRncPogz8bXU9Ps6z8PRZpgcMt3+NY8sCmx/Kv
	 Fyu1h9abksAY+y8dmgXv81aAPy9XJwLAjcoYk+I0kCZ0djbImA/JWxGoXfedtNbhEoK8Z
	 nBFQABLWVuW0j3DuQb8CINOU8meLuq7BweUtsqxQBIQKpAsduogysvkMT0uitTiePJZfu
	 PS5Tp0EnbLa8FIRji39FO5PA/CgZj+GPnrz3F6wesAJzatF3hrGIxr3tMglkb7cb/KDRb
	 ydgy/a587P4Jt5qOpn4On1HemAk8bPQRaG6Li/LmrAQ6h2aEZP3Y6i9nBAR3Y2Eamaw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 8E4851F000D0;
	Thu, 26 Nov 2026 09:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795683690;
	bh=/0uv7wlnqwjf34IUQhcXoKJMYYHi9n6aoQ86OEYBRdw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Wpzv6YD/qs2FiU+Q89hcu2AYdx4LJso1vRlmIP2dbnKR7MDpvw6MdUhDYzNg5MBoc
	 Ru88onufVIHPrQoJFOnVTF0covlNFnI4HhlTlgYWO0+oVOXcYMUvigDK106SdUz+gl
	 M6JTaBx6VRNoSdV4SUVhZXDskEEHyBzsVrhkU2SN6qv61OR+ZXW/e6wYZZ16gRMWgT
	 FHPiuo1CzkW6mO894krkn5gtH3k3Bsb+TleUNBOTKtlGJUP1B+mjpcAhO8jYJQqo+R
	 25L7kVF56asKIZXESCKyXRlLLe/fxn4RvDTkg0vBB46yHLUkn0OWc1CzR0VryfVnXG
	 PlWW6xFY3KvrQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 1FF634D31A;
	Thu, 26 Nov 2026 09:01:20 +0000 (UTC)
From: =?utf-8?q?St=C3=A9phane_Grosjean_via_B4_Relay?= <devnull+s.grosjean.peak-system.fr@kernel.org>
Date: Thu, 26 Nov 2026 10:01:04 +0100
Subject: [PATCH v9 03/14] can: peak_usb: replace open-coded bitmask
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
Message-Id: <20261126-canfd_check_channel_idx-v9-3-abe0099b4585@peak-system.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795683678; l=6592;
 i=s.grosjean@peak-system.fr; s=20261020; h=from:subject:message-id;
 bh=+Goq8BnTw1yJujkBUo2VvSqYQyop2E0p4mPbB+A7U1I=;
 b=QYnsvV57tmXVMkYmb7GLVYwRRtPClO0cm0ig4M4GRvjLTUyPNQmTMM8jPQuDh9JJOgaQs7t7V
 eXBByWEhKRgCVEaQd23ZSF1jeBr+nKakrZRYu1zAA5PrhVsv7pHcMqa
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
index f79b651ab4a7..76cf042a9f11 100644
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
index 65999f04f4b7..234d20f81154 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.h
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
@@ -103,15 +103,18 @@ struct peak_tx_urb_context {
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
index 39f0740421c3..729d294f71e5 100644
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
index b6be8c19e537..e38aee7834ce 100644
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


