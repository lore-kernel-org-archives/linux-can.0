Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.27.42.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792492911;
	b=xmxCexUw4oqWQZxUTCI8jgx69fX7W9J2+jblVt1Z/eEL0Uawp3xe7oaMqiRTv6ZrtsOO
	 HcGPVU6cRvEYDqz7fjIYeSd4FeUH2lRebfZ/g2yGUySzqeMkwHjNZV0gJ7m5F6tDeHz1l
	 OGEnBY0b8JJaDB81Y/oSlM0CP8Au1qIuk0qNXhA1U/Z8D1g/cFfv0V2IxCirt8f/vQkHl
	 NlJJmi0EpvlOIpASGUlFC+mkiShWtK92ecbg7GZJZLZ9Mact2BqJFm+NMhHdCwkEgXozb
	 lsZ1QjaVQ0tINbtfI43LkescQWGvJB647iT4K3tsFzjCR3LXJomrstWPHC3JprG/eww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792492911;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=5Pod1YmxY0mwyxZMirX/Q5jewqNFd+iNhCd3CzounCc=;
	b=HROaqPKiRren4mpuCyxrcEE4StCL8pmhrjGkhYrEpL77gG8eC2nzkrEotL43cCUIn3XI
	 AYCX61ChlUw5BsBnEwAHWoG1xslUkX3XrBfzyCjxmjtlscNoRsDXfmHJ0mpjfVWDFhb31
	 E374AKFFZuKFA7sM8UvCif6mBTPHuwYplSJpDnRj4E3kMMoUSLSF1Q+w91NLTLcMFrv01
	 ONYcrAGQFrYdo+XWy4h7pT/gGxtsLaxL436IMaLKG7Cjb2knYc7z19jL/5fstrwFR9ABR
	 238GDh1Hm6djR33o1ydn2yf7FN6wjjPgnL20Hux2TIjseiS45L6/AOeJDo4osXVgbKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=free.fr;
	spf=pass smtp.mailfrom=free.fr;
	dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=IGTviBcq;
	arc=none smtp.remote-ip=212.27.42.6
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844B5606A319;
	Tue, 20 Oct 2026 10:41:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 844B5606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=IGTviBcq
Received: from [127.0.1.1] (unknown [82.96.140.143])
	(Authenticated sender: stephane.grosjean@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id 69DA17804FD;
	Tue, 20 Oct 2026 12:41:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1792492909;
	bh=JqXCGcRDqtL7zkcf9fyXFxgm56IFtxVuG9kG9TF756g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IGTviBcq4+8zGEfdgw0p6e9Rkg7dOWddmPnqX31UvKgufpfDasSYN3My0/K0FM+sn
	 oeeVhz34zZja7K4VdUB8HgsZNz4u3WLThgOAqb9oRaes6F0OXgWNGwliQkZI/xTMvI
	 3ZnlPKSp4OBFrVa4DuvTKrA2o6SnMuxAz68YGHogfkjkUOGRn0vZ8RI8R0Wr3euZHh
	 Jk+llZ5/nkvu71gJe9GXSXRhqEFPK5Ivo5uIcKZaE40wCKHHWQxLgVcafnzbAWTVJe
	 71YQGHyNugm9ZFDwjWoT76R4GtB8MmlhT58DnEsjjYKUOP9B8gJcbTP0K4WEigzdn2
	 fbqm0/robkF0g==
From: =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@free.fr>
Date: Tue, 20 Oct 2026 12:40:23 +0200
Subject: [PATCH v4 08/10] can: peak_usb: reject records for unset channels
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
Message-Id: <20261020-canfd_check_channel_idx-v4-8-bfbde81f8bab@peak-system.fr>
References: <20261020-canfd_check_channel_idx-v4-0-bfbde81f8bab@peak-system.fr>
In-Reply-To: <20261020-canfd_check_channel_idx-v4-0-bfbde81f8bab@peak-system.fr>
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

