Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792679277;
	b=Ql6oCDAyGm/Yj8yybxQry2N/swN4kv23nMQAWTQoRT/yQt1yfwQBVVUpveMT9nJDr4QF
	 P/gjiJbMUB1v7n7aMB2QmgYBsvMpCscwmL9NApBLO/C9TKX0OIxJhjHBvL7PMZcoJrlQb
	 rVG+Xym0I+YzJ9+ELfccpkwJ/i5OXc5w2+uoNM2liCMc9vCkYa3Ioya/oBqSp/wy5WwX8
	 BIqvkcAvEMNiirps+ituWJvHHgp/w0w4dCd9pb8tBBtcr+UGhK2yRd/9AgOTz256nYV68
	 TGaAgntitdicoGwuVmM1UM8Jj6FKao8RlYzYhmBWOXxwHoRD5oKM3Oto5IoeIP7QaRw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792679277;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=1Melciw7ehwXTAwTcKOQZ4sgd9JcwdjHYlQFpqkIAx4=;
	b=zEnrG/rXq910bUCvCHpcYmzGc5KL+LXqDbw2AmEuKeCLnOE5HqmAjj49MhBQxUzDRvyI
	 ZRq2qQeLa2wxxAQMlfjrGJuJZASTX3YY6hlivOcTHhIRRepGbYADYQJjH/eZmHKBy27Ts
	 zg5pFavkk4OT241v9jzWlVu+/JmjJAw2rl/5V5ew+4+diF8GRqGJNMqdYuPcMU8Mgwqgv
	 UYJD0QsF4C3Jf9JyxEP3EqiqGQRb6df94eEbpa8Nk+md1TyVc0F6N2HnP7TftKDduiEmt
	 /vV9FT/lXUg8GFz7vNvUMS7229yGbFWvanzClWpo/Asw+Jsp8hQNIjsMbriTFE5qeDg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=im7F9GrD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EDA606A31E;
	Thu, 22 Oct 2026 14:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=im7F9GrD
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792679277;
	b=mIWdi8MMAgLUTQlwhIN4uDTc33gF9pxFoMXLS6rAYtxoPZqB0ygwDyut6+PGZ4nPHM/X
	 ViRXBHnJPHQnUnuBRfi236nZcmTcQ4A3DObWJu0pCZKta8amVSJpFb75/WD3BFrYmCdEt
	 P7Gcmq5wsfXqsZsWEUE1zymycnDeVBw8u8ZER13yuVTDdf91hHNbUmCtT9Jn/3bMLSoLH
	 HIo4vNOx8ytDEwb/ju9MVhqip/KKZeINDYDF5mkfKSIwA0O6i75diqFnXT5k/MrXRJDBo
	 0pi7OoC8Z3ttU+Eoi4HpD2wB0ok9hsOe32Kf8r3Cb+ZXda4/vWqR3NvW1moftZU+dig==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792679277;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=1Melciw7ehwXTAwTcKOQZ4sgd9JcwdjHYlQFpqkIAx4=;
	b=GAgx3PpaVCul6Msd69dVzcvibv+kQLP4qTl6TxBwr1NdsHVpwflgzn9SIrY4Mxppy7Ec
	 FeHcYgSW06Xs5rk8TA2RF1WyHwUhEb4w7XWxTpdvt3lIK5KyNoXYEomeT3DBU9M/skwil
	 AjlDWD4Uhm2RcpUtAmdEN+SxwroL9qeztdzrRKUR7c4WZ4YvE0bp5yY8Fn+B3vzLvl4tX
	 hc0SRGBIeMQRW2IT80faZmpo+nCMJoTK+Wy64FwrC/xmK/87X5oHiD1zIDFFBC0AX7LXF
	 ZVGskfKvYS2MqxXu8m7e8ToIvhH5Bu+wtdp13ykzdIkzoTry1mNjUBzM/RCKiYdJ/tg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3CA6D1F000CA;
	Thu, 22 Oct 2026 14:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792679277;
	bh=1Melciw7ehwXTAwTcKOQZ4sgd9JcwdjHYlQFpqkIAx4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=im7F9GrDhxgttABJgaPJNXgA02TKsPLZI8Okp20ptZ3VJWJaoVjXzVXoEL1eVHpkL
	 GtS8OjzcuBa0WGY/JpbMp4bY/NvYdHk/l7EkICZ5SxSG+4+QAXhfSVieU8qFAtjSKJ
	 0IJMIPbmbRvqMOnlM2TMFCnaJq0q/qbRFmcqJqnHm/GRQpJHylEb2XNNPdOXSdX0+t
	 iKDlcFQ52KTv2KdxbzQEUX47DrwWgo6142Efe+EuJZmc9LBSUCx7CtCJa1Nf+4XPDL
	 fwehdEGv1TJysXklfyY2VjIQgYYsNiBRUK7y3tMpB0FDE3NLSmTO2RyuW4OEWqURXg
	 v4HcM6o5YhvVA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id AA11E435C1;
	Thu, 22 Oct 2026 14:27:54 +0000 (UTC)
From: =?utf-8?q?St=C3=A9phane_Grosjean_via_B4_Relay?= <devnull+s.grosjean.peak-system.fr@kernel.org>
Date: Thu, 22 Oct 2026 16:27:50 +0200
Subject: [PATCH v6 05/13] can: peak_usb: replace open-coded bitmask
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
Message-Id: <20261022-canfd_check_channel_idx-v6-5-197704231551@peak-system.fr>
References: <20261022-canfd_check_channel_idx-v6-0-197704231551@peak-system.fr>
In-Reply-To: <20261022-canfd_check_channel_idx-v6-0-197704231551@peak-system.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Wolfgang Grandegger <wg@grandegger.com>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>, 
 Dan Carpenter <error27@gmail.com>, Lukas Magel <lukas.magel@posteo.net>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792679273; l=6592;
 i=s.grosjean@peak-system.fr; s=20261020; h=from:subject:message-id;
 bh=nQyQ44v+InsbZVERsOlgObbCokwsrHOkh2r9DVOCK+4=;
 b=JosqeGzlBDHpCbbf8CwCVYq+UMaRE/X91Vaj0U0yAFJK2OESI1iAuMDTY9sWLeDwaInYw8Ow7
 O1y9apZtYv2A0EZzO2PuTo3mqwc6sn1gdFxzJH/FFmiNmTSsjAHOB8b
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
index 5da91d5dc67a..93da0fd4f10e 100644
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


