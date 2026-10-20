Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792503055;
	b=grfyy2lAnjqs7dZlBHB9lhQDt20VjDwgjE2F0dU39Bp6yc1dg3LAZZbBW2+TxqQdLN69
	 RX9lmoasqFBwvn1X2LBC3/eidpj6KH2WVlvVMXV5NPu9OWOubsnbY7PTIIUHplylqqpMV
	 e257Psw4D7/3nnz2NxztHRP185i3GkpWZCy4JkXsFgrSZAR9y/kHO1Yr88k8gji4f/76q
	 9+olFVNLCPPv9Sxa8a5VIGNyXCmKyh0VyP6zXX1c4Lvk9aA8nUc9PRJvb2xvDOoN7jYEz
	 IQ1oCgLjwVW57NUyrDtkVsg5KnevRp4KpMyEOYGO8I3ljMo4pFkFqWPf5skscVJppSA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792503055;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=5Pod1YmxY0mwyxZMirX/Q5jewqNFd+iNhCd3CzounCc=;
	b=Bbi6u8dgTwuvn3Igxi5f1FABwSMe7CKljFPJKHkJ96KaVbDTn5wpyQQnyXUuF6nchObx
	 39EwfRKiWoJ8vhVYKn7M1oS7gSdy+IrlTPJJGd4Oso5EzSS9nVlDIQM0K1DsXUCMa9J4I
	 eDJ5xXYLEOg7QbZfopJKPBtA9FrqPmITMMN1GBxmbR6fdNeP464RA6Xa51P1E0SY5W+TF
	 RQkgruXHVHjnPfePUgQkQWGCR8+P8WaseAoicyVfV8mNMpNSIEbKOVTd/LJH3CbcBw7ZD
	 9BtUBhuT+VgF0OPhML7kLA19U1YsG4sAJGF6yLKjIB9t0e2dKeENczI000+Lvpjt22w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bQDDys3Z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769E660A2617;
	Tue, 20 Oct 2026 13:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bQDDys3Z
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792503054;
	b=xPyXR3DzMiPNxjz1UT6TDcugYrtMDjiv2HYIQMr5VKxIX/UiELl3veVeQgGCqGD8KhbX
	 9pUvmqEjvTXfrhDSzZRbmhFV5uLMSqtXPzcdf+6+qxX4daBQzN2gFZ273w6FRNNGtVO2s
	 sfoWh+c0l8NML5cq6f1BXGcj6CgARhSnpnh/lZG+EadLWL7jnEV/AWQ3/q2+Z3IKnN6bv
	 Prpl5UmME4xPnyQVTt30VLcc2zrRyqu/UWUJvj2sPUYZdsVERifDom9TeTbjgpsBaAE+r
	 IAXA7yVOIrRyw4RMymWlIsP7HdSxSn3vxFQm9nu7HNhSQBvNhmI/AHyQ3lQLkKTorEw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792503054;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=5Pod1YmxY0mwyxZMirX/Q5jewqNFd+iNhCd3CzounCc=;
	b=Kiq8U/z2pu24Ol3q5TuZH2vSgj35654wN77XfqiaPvIzfysC7W/ITcfRiWPG5TH0Pn/m
	 KejokoPeCo1E+oxkbPFtaRUibBc+9IN0eKzNc1spV+wdN9qpFNl7qMZxd9A6OedkBm9Hz
	 X8QxAXyabXEFMdcaHhy7lCtoQg3ZXn3qslgZb1ebIJLSqSvvY7g4jGRkQzhuya8Yn761g
	 quPp7oFeVZ9YR6IwTRbEdsPCGq8dFbS6fDMp8pMyg1YlVkY+hIaigvrdVo1C+fIN91u7t
	 WpTSQGyPFWx8KrZfg7ebhAI7KwVoRGCqb0vaDC0tClXP/Yr1uQAuZFfLP8Z0M4KcUhQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B67EB1F000CB;
	Tue, 20 Oct 2026 13:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792503054;
	bh=5Pod1YmxY0mwyxZMirX/Q5jewqNFd+iNhCd3CzounCc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=bQDDys3ZlKJtD41MGvKR6XDzIgGEYoebPs6LAgD4R4gIHIFd1bvqXPWZVIhxpYzAi
	 oKNJrqIXYYDoWwAkOwjyEqDCOYNMjR3yUvNQzhC3UYlW42UjyAiTK8l4q+ODCCzmlp
	 RZp2KYG7YAYGAvfh6Xw44KsADoV0xdv7pXNKPfP+XLxpx8AwwygnaaUczqD04nZiHI
	 xqwGPiLfICryijPoBGIDQPdWuWndGLzZ4FV5eWmL5XhMypZLZk0t/JcQk7Ygtvch8h
	 8s1lEeq98uAYy5cPBp6oWajB4ETBxlyt3VR8OujYIBz6xiwdR9BaC6YLuxS6hr9Zwt
	 JdQrXf7wJuohw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B79F943199;
	Tue, 20 Oct 2026 13:30:51 +0000 (UTC)
From: =?utf-8?q?St=C3=A9phane_Grosjean_via_B4_Relay?= <devnull+s.grosjean.peak-system.fr@kernel.org>
Date: Tue, 20 Oct 2026 15:30:47 +0200
Subject: [PATCH v5 08/10] can: peak_usb: reject records for unset channels
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
Message-Id: <20261020-canfd_check_channel_idx-v5-8-a62b35b867f0@peak-system.fr>
References: <20261020-canfd_check_channel_idx-v5-0-a62b35b867f0@peak-system.fr>
In-Reply-To: <20261020-canfd_check_channel_idx-v5-0-a62b35b867f0@peak-system.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Dan Carpenter <error27@gmail.com>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>, 
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792503050; l=2967;
 i=s.grosjean@peak-system.fr; s=20261020; h=from:subject:message-id;
 bh=7cZFn3PowfU4SRYPZttd6kMIm8eGedioX77nVvlSNqY=;
 b=6IwngBMI2zLcSOO43f6SvpRK+tTwXXRVX3XKIxnVOSH9Ha6TF8MpueRhEWKvUrcM8HyGYm3eZ
 wOIUMmSGDCsAobzaH4CitNDiLPOrZZd6lKIar4kBJ/N57/8hSXLjMBK
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
index cbc23953ce61..151c5ea2859b 100644
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


