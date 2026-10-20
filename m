Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.27.42.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792487411;
	b=jhE6RUyK2OC3MNb15Wq/NuZPaaOonY67tHhV+J0TWUpfYFPt9el4xpNTNw0DhPERUwm7
	 X63qJfYbKe+c95rGeNJ+3BwmSkpuXZKTmttuszW/2X7wFSwIWvlHvwQRKisiKehKRFsht
	 6BKF37okf0EaP5XnwfwOOSJjLWkfalL4v+RMHYe25yumMBrV2B0MOVAcuPxSkIVpElKLX
	 BLsllD+rlvpqsoKtJTnmIC4nVAYDO/ZBBuokdp5go2S63etbr9/mx2kzTsMl/eFJYAcmX
	 21IcrujYDEWaNd3v37FB7fYgpMX/OLtK27gYujiLwgrLrXbQVTzAq8anjV7LXOc1RCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792487411;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=5Pod1YmxY0mwyxZMirX/Q5jewqNFd+iNhCd3CzounCc=;
	b=UP9MsNSx5CGgmrGbhIsyhsWksKaEXdFsy9VvOLpPAs90nIb8glNcXXeg9S2B5Q3cI8cU
	 OT0zFvKmL9BZFQIfaJW+WAn70ruQEgHyuPYBPJhyp3/LpTBejqAEjNLKakqCGlplJqALi
	 jT5Qeedmu2dgaEvFAKgRAzOZZxcZKN3AEczl4G5oEPBQtv1CCLyUuLAwfazwRROKMFioA
	 lvWwq98h8sKfqFLufNxCR+ITalXGKyUxQeP3YCggDT7b32s+qY3/BYD/VP/FLTJ5IV2Sk
	 jMo4baYvi2gRKVXZwt3Dpol/LM7WBqzPreDi9Wye7ua8obc+cjZrr502r0wOuIGVtew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=free.fr;
	spf=pass smtp.mailfrom=free.fr;
	dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=TAVGKHER;
	arc=none smtp.remote-ip=212.27.42.6
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7921E606A32C;
	Tue, 20 Oct 2026 09:10:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7921E606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=TAVGKHER
Received: from [127.0.1.1] (unknown [82.96.140.143])
	(Authenticated sender: stephane.grosjean@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id 33D16780507;
	Tue, 20 Oct 2026 11:10:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1792487408;
	bh=JqXCGcRDqtL7zkcf9fyXFxgm56IFtxVuG9kG9TF756g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TAVGKHERQhuj34HJj7uBt3k5r4f8afa3zt0FOQCyTkkANhu32iG5u9qqazSnDjtdl
	 3Gch/xwJsG6F5xHT6IaKvQeq4UUjIwghVdg3CAab5T6Xva/lJJkqRRjfmUknLqicIV
	 44ejQ0Ck6Mhf4uRzE3XH7pBPHKGxErofiBXNe27j2z+j/NpZ99/2cqiHyNTGhDgTCk
	 Nib6K1617pb0Kf81/tI7Gm84fjUaB2FmZ/+PPNBTNyN53ofWmevJIKjRa1RhPR8hV9
	 azwkP0ZX6aQ/2XhHJswQVDQfxdhD3yCP4KMmQD5YPH/XWTwuzwysC9HQW5gkBm9Qzm
	 VfYhCf2hSpVZQ==
From: =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@free.fr>
Date: Tue, 20 Oct 2026 11:08:13 +0200
Subject: [PATCH v3 08/10] can: peak_usb: reject records for unset channels
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261020-canfd_check_channel_idx-v3-8-74d17c5a599e@peak-system.fr>
References: <20261020-canfd_check_channel_idx-v3-0-74d17c5a599e@peak-system.fr>
In-Reply-To: <20261020-canfd_check_channel_idx-v3-0-74d17c5a599e@peak-system.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Dan Carpenter <error27@gmail.com>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>, 
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3

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

