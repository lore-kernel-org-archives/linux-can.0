Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793709030;
	b=Qqy26bdFlv3Ve/BrzjcZFn3b5td8rOBeoeoAsXWZ4/mM9sr+chI/EGNgwpG+gS2upcU1
	 rAYpRA/WvHjVnn+y8peeJBACRXAyJRzTRImBS+7gT/xjr5GonhKTlXhbVRN8BR4z/iJvg
	 JN1EO5PeYAN9XVccnVrv0RC6aZgHh3Ig9XZDxjKrPv4nCNwNjKuu64a7nhKsKjPcaPdmq
	 cqUAT4PUXa+ycgWdrmc3MUVvfb2+amlcIILHs1IX4kYViIyrOgeac9JFYKaLwI426qR60
	 neWyVPud3LBDZvOCz4nzEBnHx/0EeAvPrvFdYDThGcSv8j7fTGg6IPXn6OZMLOuHFIQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793709030;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=bOwFUNdLBVTZXvMFj034/EgiBq5/Z2tdxaCiUfuCqy4=;
	b=SX9zduSA0tcKniV09JetOp8h5hN1hCek6Wf6CaTOxy5BNGVHwv9h2AKj9ojE7E7ziE+j
	 ENrb7S3JLpzAEb4UBrZi+BVnQCWVacQ2gfCEB8oN2MFfyO0LXuOmQDw0NUHB2OnrNuxuh
	 Nd9VbeaIH88X+QbCh3++8XvM1JjbE7Q2aVfuctKmzWUbhJleU35ef1YDqwtc9k6Tt1RGg
	 UKD2muYUiHaV8rnK2BZWELDYgMfmf92tt3okicU3cOj0eEtWKnESS0s3u/wEG7W2ZNWqW
	 SUiZuDv3D3j/9K/S0HkZqLqM5vBc3yxSJq982GfB6b/ZqsZji37yBWD0OrfHcljcl1w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UUGKZF5b;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34C2606D822;
	Tue,  3 Nov 2026 12:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UUGKZF5b
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793709029;
	b=egVPrZXouz2WuQM9VtwzwW5IncCIBjMTSdZA9mLwb0fBVEKiUzNRhkSlmyDdUChMRrwR
	 qRoGK9Bk5gsPRtlnbEVXMZfWN/8c08QpOjgh7xBSPHgnrZCAEVM9+jfEZRHt/WbQLWw44
	 04W7/qfzls8DJSTSz/s+A1/TTNkAH7PnTuigkCJDa60fObgdPprjdGg8jxKpQrW/E9EEu
	 uPS9zP84nLonnO3MUwZbcMI2asEDGUzLKclLvhxA6cj7Oh+p8lOxFgqaBVriMNbgJKmoU
	 7e/wiD1uZPi5dFRpJ3NtH+YUaNl34oQgTUg/Rr9gYun/RK7uCq+vnQrMenXJkM1lM5w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793709029;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=bOwFUNdLBVTZXvMFj034/EgiBq5/Z2tdxaCiUfuCqy4=;
	b=ajSi3MSMhnfFKb7chqCB16+OQp4AxfWAGjUxHo11mH3fGwHzjtUAUDNQ3fKnRjFIGt97
	 THZ0js6EpDskNaqurCk34vaa+Kb6sQaxsBZmV8/0ioDbPxc8/U1G9Dn5PHQzgRF//NbhB
	 eHbbWhxI1dhaey3WvR6MF/jHgGbL+KWVBEJqXK86YXXyHMUDGAy3mJOfrMruRAzuq5zVw
	 JWzo7DgYEQHu3QH2bsA7kCwtz/wgiE70+a+K4E97LJd8MbjLuGphElsp4iOF1H4ywTh2i
	 HCE2m1cx/26zs3+C7wRlf27zM2mYC31GuJJV6XgaZV5oZRDAm17YxZJIisYTsejVLmw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 10EFA1F00A16;
	Tue,  3 Nov 2026 12:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793709029;
	bh=bOwFUNdLBVTZXvMFj034/EgiBq5/Z2tdxaCiUfuCqy4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=UUGKZF5bkHxvhZL7uY5qmasDoMgGuHM80+GdtL2Z9TMO40075KkzmOS6lwWASYMH5
	 setjYXwGYw6XPLPKR3ZYuErvI0s1FOnE5hh+xrgnV6Xtiluw/luoNkeMdSFSJpbpg9
	 ol4qNRgzvIg3THHH8neByBFN0zXqpL1uVJrlgPk/vXY9d8BSGFh2aT03FLeAN0PU50
	 k9OfZxCy5yXn8DjEObAQGTAGee5IuKDbCGbMUOdLhGi6Ijgp6bKl7ACWxOTQbu3nHu
	 2g2IB4UQHKphdY24/LFoZZ+CQTSnPDSGUWJYpv53etZFzkLUMFVSYvIFf/o+TiU4uR
	 tGePMT+KMjkgg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7064C46938;
	Tue,  3 Nov 2026 12:30:25 +0000 (UTC)
From: =?utf-8?q?St=C3=A9phane_Grosjean_via_B4_Relay?= <devnull+s.grosjean.peak-system.fr@kernel.org>
Date: Tue, 03 Nov 2026 13:30:22 +0100
Subject: [PATCH v8 06/14] can: peak_usb: reject records for unset channels
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
Message-Id: <20261103-canfd_check_channel_idx-v8-6-4e8b2c0a8806@peak-system.fr>
References: <20261103-canfd_check_channel_idx-v8-0-4e8b2c0a8806@peak-system.fr>
In-Reply-To: <20261103-canfd_check_channel_idx-v8-0-4e8b2c0a8806@peak-system.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Wolfgang Grandegger <wg@grandegger.com>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>, 
 Dan Carpenter <error27@gmail.com>, Lukas Magel <lukas.magel@posteo.net>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tristan Madani <tristmd@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793709024; l=2985;
 i=s.grosjean@peak-system.fr; s=20261020; h=from:subject:message-id;
 bh=bN/0zrh0R7MUNYeuAPZD8b88LOd0Urf3DxJPfyFeHNA=;
 b=nSOtbv6//4gmhPx0SeoR1sthUY/AQjC4t+fz6EAVsrz8Xac4x1/SPwEMrBMWMKgxWQm120ppa
 5L391UotedqAOqUaGzecZpQ7XzEEHzRalzi0/Mas5BeqQVAOS4ViDAe
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
Assisted-by: LLM
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


