Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795683700;
	b=vFzqCZntDImwt7oZc//jBn+g/BmJBjgfGWR4BjbW5ME6vga0r2evEgKFnG0zJgA1UZex
	 obgud/F4VHdKR5zkezbcxHa9H1tk2qw9CqWH6/Ykb7+RRKpf1kA9aGWFQKt032agdWw6q
	 8A/ckm/GQmBeQNp3zA62nEGomLjBk7TurZ5hsrFNSs+ynoAaevxe8axhpVndJYeVolD8J
	 dGh4Itv4WqWhBqIzFtjYJPvDuvM9Hoh99CK5pcywJcePkUCMh9384S21SGb7UWsyGl8EU
	 e1tsGsJ5yBYx6a0dV+8WUJVQsw49Jq+nyBSa23DTGz2xRv/uv5rBSyTcAg4j5tA+Qbw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795683700;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Z5opSqTe0WXZ/7LAGX6sd4SyI2buU2hSxG5lHgowj7Q=;
	b=XXktUwKlPpjIT7xw+DnlmJrKqbC2wXCOtXznIyxRN0eO7Mk7MdOZ8dqB+aJP6EUxf5mp
	 JAm9JMjoGpzwdDC3UsEemwlTscIwSiYT3fBeV1rrTu6tFd8XFrLuTyyPX/KCukiQE3/4S
	 ffMVmmCDX/8Jma2wvccuyo3E9YQhANjuN98QlD6pBMMhsj2wCtjAUpzJlnl8zbHufyGo4
	 TemZqjsByaKmMAfW7kFFhk0cxOm8ouhdBwZ57MJC3iF598pp/0GAU2g0y3h2gUZGveN7K
	 UCdtsR/Wcajg35XDJw1LUqMDK2+zYRuTAoPgcATijxh0SwjBDKUBk1N8D2xB+QpJTxw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jOXtTAb0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B18606A339;
	Thu, 26 Nov 2026 09:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jOXtTAb0
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795683700;
	b=2R2RbjlPPGW6n42KmJdr6zt6TcsYwA1iOpde5GZiQFV6ep0lbv9xgy1C55enC2ziSjkV
	 geDXzeYbbl+xFR+uRmZKqnp9RstUaeHQObAnw8aua75mqiOORIYZY/+dayIZQHkV4UA0S
	 ttTeyaOUcP5QHSnbEG/s9WM4cDUnLjjc+3BWily88y7/uF8AoCPvSlm64VCsaDZzg+qBL
	 QKJVnhsCAiFJeYWJjz4DmiB8xfb9aJk8Q4rUz8YKQko74aWWxa2uBCR0EyHCeH8Qs9TOT
	 t9mVQW/X78g9P6xrbH6mu4YBxhUWvt6qd8nbZTmvn5yCZo8uY7FyMAIwDE/CXaJNX5g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795683700;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Z5opSqTe0WXZ/7LAGX6sd4SyI2buU2hSxG5lHgowj7Q=;
	b=2f77M5cAkAsmhZ3HnE5FQHNSaDIkTi/ZHPdAJmFcSMse7OatbHsPnoxnWMLv3wOcGI2D
	 w8Y6KT70+ZJ75QZGTk4b2jhV+vUqsFuYGus80OI5/sFlY5N3vthl9g2cI4LsSgbLnzWnq
	 +jwyOTPwqYD679oYnPgx17fK4oHKDTDN0fCm+Ds48Yz/BcqgqTzqg3MHZKZLV5Dq+oXjl
	 kKI52jXCWt25PIBpFMUSAQ9uqXSIYkKG2fJtYRkwOhOMIHUz5ZxwiVxDWP471IHtD69Yb
	 fdhq9Yn1cvvlQGaFkqjmAArk6mGYy1lq859v2r+e2fFfFVH68ZObEUcV8lyuUULA3EQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 64D011F000D4;
	Thu, 26 Nov 2026 09:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795683700;
	bh=Z5opSqTe0WXZ/7LAGX6sd4SyI2buU2hSxG5lHgowj7Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=jOXtTAb0OikyCpb6rGmjiKUCVO3R61eybu92Idf/bg7x+BRmkM7IlnQT08LYvDcBw
	 Gl0ANOTQZ6nxruCtCLqLxrXFoOafBfIeAX7o/e2aTwDKwHVWWs3b7QGjKGbkEiSSeL
	 6XNcyFftyaejQy+UCJB4SglNoVivM5FkU7aAk47rjmO0rSq0zymO+9njYVa3astraP
	 2sUf4GIQycb8jPve4kJkgrW0bXae4nanaI+79hLhbxYXGd2fR9SQUJuyvwSzoy1k8Z
	 rAqICCM77HWuMy0ed15LxEcwtUwRX30QbDp4lDi5uDjHPRm/3bcBk5Amjm2WsEMfVA
	 mowYOlUsr7pwg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7AFF64D326;
	Thu, 26 Nov 2026 09:01:20 +0000 (UTC)
From: =?utf-8?q?St=C3=A9phane_Grosjean_via_B4_Relay?= <devnull+s.grosjean.peak-system.fr@kernel.org>
Date: Thu, 26 Nov 2026 10:01:07 +0100
Subject: [PATCH v9 06/14] can: peak_usb: reject records for unset channels
 in PCAN-USB Pro
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
Message-Id: <20261126-canfd_check_channel_idx-v9-6-abe0099b4585@peak-system.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795683678; l=2967;
 i=s.grosjean@peak-system.fr; s=20261020; h=from:subject:message-id;
 bh=1tv/9XfwW3pXE9HbHyeQvHAH+t9fa2d+NqgwGd8wB0w=;
 b=5oeg+IXRheVtBPQ80AT0ilDH6d0IN7JiL0YMM4L8SOFrK2gS25pZCRt2sRFhotCA+WGYJRnGN
 frjwyiUUw3YAldfWXoKvgV6Djkp41plvNVaPU0CJI/FRXCqvEiAe5WX
X-Developer-Key: i=s.grosjean@peak-system.fr; a=ed25519;
 pk=bP7QV2zvvAKAfConZlUOGKGEcXL64SNUpVUm++Ai+/c=
X-Endpoint-Received: by B4 Relay for s.grosjean@peak-system.fr/20261020
 with auth_id=1250
X-Original-From: =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>
Reply-To: s.grosjean@peak-system.fr
Content-Transfer-Encoding: 8bit

From: Stéphane Grosjean <s.grosjean@peak-system.fr>

Records received from a PCAN-USB Pro device carry a CAN channel number
used to index the CAN device table usb_if->dev[]. The decoders only
check this number against the size of the table.

The slot of channel 1 stays NULL until that channel has been
initialized, while the RX URBs of channel 0, which share the same
bulk-in endpoint, may already be running. A record for channel 1
received in that window leads to a NULL pointer dereference in URB
completion context. Moreover, when probing channel 1 fails after its
slot has been filled, the slot keeps pointing to the freed channel.

Reject records for a channel whose slot is empty, and clear the slot
of a channel in pcan_usb_pro_free(). Slots are published with
smp_store_release() and read with READ_ONCE().

Fixes: d8a199355f8f ("can: usb: PEAK-System Technik PCAN-USB Pro specific part")
Signed-off-by: Stéphane Grosjean <s.grosjean@peak-system.fr>
---
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
index e38aee7834ce..9e2f48683a9d 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
@@ -543,7 +543,12 @@ static int pcan_usb_pro_handle_canmsg(struct pcan_usb_pro_interface *usb_if,
 	if (ctrl_idx >= ARRAY_SIZE(usb_if->dev))
 		return -EINVAL;
 
-	dev = usb_if->dev[ctrl_idx];
+	dev = READ_ONCE(usb_if->dev[ctrl_idx]);
+
+	/* reject records for a channel that is not (or no longer) set up */
+	if (!dev)
+		return -EINVAL;
+
 	netdev = dev->netdev;
 
 	skb = alloc_can_skb(netdev, &can_frame);
@@ -590,7 +595,12 @@ static int pcan_usb_pro_handle_error(struct pcan_usb_pro_interface *usb_if,
 	if (ctrl_idx >= ARRAY_SIZE(usb_if->dev))
 		return -EINVAL;
 
-	dev = usb_if->dev[ctrl_idx];
+	dev = READ_ONCE(usb_if->dev[ctrl_idx]);
+
+	/* reject records for a channel that is not (or no longer) set up */
+	if (!dev)
+		return -EINVAL;
+
 	netdev = dev->netdev;
 
 	/* nothing should be sent while in BUS_OFF state */
@@ -933,7 +943,8 @@ static int pcan_usb_pro_init(struct peak_usb_device *dev)
 	}
 
 	pdev->usb_if = usb_if;
-	usb_if->dev[dev->ctrl_idx] = dev;
+	/* publish dev to the decoders */
+	smp_store_release(&usb_if->dev[dev->ctrl_idx], dev);
 
 	/* set LED in default state (end of init phase) */
 	pcan_usb_pro_set_led(dev, PCAN_USBPRO_LED_DEVICE, 1);
@@ -981,6 +992,9 @@ static void pcan_usb_pro_exit(struct peak_usb_device *dev)
  */
 static void pcan_usb_pro_free(struct peak_usb_device *dev)
 {
+	/* clear this channel's slot: dev is going to be freed */
+	WRITE_ONCE(pcan_usb_pro_dev_if(dev)->dev[dev->ctrl_idx], NULL);
+
 	/* last device: can free pcan_usb_pro_interface object now */
 	if (!dev->prev_siblings && !dev->next_siblings)
 		kfree(pcan_usb_pro_dev_if(dev));

-- 
2.53.0


