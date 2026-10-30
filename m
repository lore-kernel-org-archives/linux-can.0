Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793357114;
	b=ndAqRY8hA9dv1UGEhcXk/VkWJgZCmZo4Iqtu278qDliZVzEMBE4IlKDpOJvpCn+Teh3W
	 lLU2ZQXK3e24foubp23xa1ToB0AmAl8nkvnLqmgA2xilse0GjZPEmglh90tdO1//p4xyw
	 Lhr25HOPe6cIrGjQ46D1oEGpvIa8wXehp2uCwmNU9eZ3CKUTbcIzGygHUbFkRkeeeWcAt
	 BctT0MgePM1z14DCIfiZZ/MMCFigyOXbnhAtG/8gj8Z2eaWAvHfShsitZ3crVLVYmLUFj
	 ZShzt47prFMY9DhGHkXPIFGcdwhi2bqo6rDWcoK31gq/7idM5UKgKQR++Y+t2r+lkaQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793357114;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=HWHo1VyMeZVdvGG1MXQHMJUz3uY5Ij7QXNRfTATnvTc=;
	b=Hd+emQ/f9epib9Q/4Q+CWezsyPhDrRHM4ScRSBiuZtbcGJxXW5+m90Oa54IpSChCsazm
	 9vECIee4hfcjmLo0aNEXHnFcQGVhwTD/5EGVn29hF3CAxfBxLkXyvzdnM4z0i7u/zsM+T
	 rsolSbyn1khy6TFOX7cRCijbtzZ1OcdaBNG7cuKVRwahu5URDEaimkk8T0y4/lmlzYTgF
	 83mrRJlHXNeEjchiuRwd7yqgG9TEkqbgjE+sL4fVn7FGk9yQDebl3Fx3VY90dshF3gAVS
	 tq5sT31QpDZfkmzZEUFVaFluBM9fypdZrZ1lnbNLd8+2Q1zl8RqthTCMNzWpTZZXu4w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C3260A2636;
	Fri, 30 Oct 2026 10:45:09 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793357109;
	b=HCUHdtKV97DeFFxhwQdebhAW9c2ri9k+2vEAjF6ZvK9cfvSuqIV/Cb6YjdFC6vhQa+3S
	 YBlrw9whfsCzeWjKaGIZ4MhtNfX6RNQsx2WobEYGjlKYIQRFqxbTFUhzykXGiHGJRmjMV
	 UPYXofgeamL2BQlAVDiIbKoNGYpHObFqTuOi6MDSxGRBulPuYIBCdoNqUuG4uJxgRRfPo
	 c9xI2dUtpl+1i3KcLP6CRR3V2h2GE0N79C05/wKd288b9TFpgodvHVN5Z+V8txxD2CvJC
	 Zm53eqSNGp3qpZhy7q9+MlPT73HQPfRF8aNg6KRyLh/6QuzMVPh7R8kFSKeaAGfcUSA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793357109;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=HWHo1VyMeZVdvGG1MXQHMJUz3uY5Ij7QXNRfTATnvTc=;
	b=XJXA+Po/3sUvdurdEM+iYMrhq5rspCYEfXmrGx8UaynFRYCEgCOok69ebwvZ1Z+5JM+E
	 uVr7ILnxJECkNFdOe2ntydbiW/mNGIS0hMyAdnPyC2HILkP/PBaT8jhNVgQPXBjUDTIBd
	 LuV8r2IzGUcyaPclKK5VBf076dNIxRkh1MZj/HTZtQuleC/UZuK/zuVR3b1sBsY02T9wG
	 NgtNV5moU7e5IpY4DRE6n0H9qHEH2c0xnnQK6pDzXZYrew5nsqguTiQ5aSzKECZ9tRInK
	 ousj2Vdx6h5uhvxmhdaM2ao7DISeGG0gePMYepsG8rnPtby0/rsHuRzvVmUNLuJja2g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 7C4901F00A17;
	Fri, 30 Oct 2026 10:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793357109;
	bh=HWHo1VyMeZVdvGG1MXQHMJUz3uY5Ij7QXNRfTATnvTc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=WllIHEpzix5anS+2kOV/4BefMYFkMZRIqptRtqxlUMWhtyDQO7v7QM7s0LLKptOnz
	 gMRQqRYps+4CAmLpdTg1qCAtN25ygD7MjxYwULl6C3vBxFsiTyyA3GQZVDHeW6PT1H
	 JM0NZyQghmLqFMHfdKi8Nr18oPw+tbJ/UcUmOOJ5kenLOBZRGtxpY5oBPSLz4pL1va
	 9I0lvF9JGJitrVW/W1/pSZ5R24iE/en6Difa/uUj21CCkU2hU5xhX5LPLXpf6WjHGU
	 Jbd+Vi/cVIHf5t/7jeV1vyeaiFNnS8/8+MxDkUHIubZQrsHngmctcGWc9cxXRkVGkH
	 8OROrNv7JXGDg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A46E243752;
	Fri, 30 Oct 2026 10:45:04 +0000 (UTC)
From: =?utf-8?q?St=C3=A9phane_Grosjean_via_B4_Relay?= <devnull+s.grosjean.peak-system.fr@kernel.org>
Date: Fri, 30 Oct 2026 11:44:57 +0100
Subject: [PATCH v7 08/13] can: peak_usb: reject records for unset channels
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
Message-Id: <20261030-canfd_check_channel_idx-v7-8-fc4a3faf3acf@peak-system.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793357103; l=2985;
 i=s.grosjean@peak-system.fr; s=20261020; h=from:subject:message-id;
 bh=yBztvgADc0ldOVnmTjUXpwFq1BHCu2CwKsqgDlYlkCY=;
 b=kLe91agd8a1idE19d5n3X35jozBHOmB5U6n7cXcIa8SEUlM68nD7INS0WcRzPB83nBWNv0U6Y
 DFnmfJPXov9BgLFPObYo2hNloLqNsog4vaaoUUByn+YGIs1YMEk8+Js
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


