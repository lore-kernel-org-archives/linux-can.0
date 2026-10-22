Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792679279;
	b=gRNRbYCUulXIRb5O7jfLtYOjgo9I+HIXL4jJLSd4DqwPMiog8T6n516rfuExEUFA2Vd4
	 ksnlE+tXvjN5EvKyB3+V5Dz3cfIaZaqaiMIyleYeqs1p5EWbQO89w3BzPteCrqmE2yc8s
	 lY4xJozlIB6XXM3Shz8FHq0U6WaCOEnFCELNXZCBBLISpCN5kD4dRGs2J8PENDg9DymuM
	 oTJx+wOKNhXVOJaLmJdJrB2gIseUnF0yKSujzJ5WmoShIkKgEqcrOi6BpYZJ1JHBX7LuI
	 40uhEiqI6qTC9mC1wceE7LMcxnGY5Oh1B5QTNhr0vkKoJe9O8jch+hmkApfGheSesaw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792679279;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=HWHo1VyMeZVdvGG1MXQHMJUz3uY5Ij7QXNRfTATnvTc=;
	b=DHtkj4bDitwMGE3oQ728SZ/drnosUciQ5OIQ6OuiYdh2+SM4P42V/dVO5HFxtAPR58yi
	 buQ0RUl7q6al1h75P3PxIRJuIZ3luMLTNdme4c09cVKCVi32dtI10VQTACK7zV/8viP26
	 DWQQg7RyfoTV7LHUjAVIy2H6nyUauOS9KasWx7I2qxaGK1MCfVFbLdoUkpZvD1ZmTqBmn
	 D165/VjmMTdOQVnyrFhkvl289JZdd9WwQNVVACgXk7V1Y+DMRdfleE1obY1ZR1q5RqIVA
	 /YTjeHgbtvwplNaqQ9H/Fhoy6XezHfUxczjyPqxYCp4aBPqoL3wvF8UiMVNjQC/6fHA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XeGJYNE6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A0360A260E;
	Thu, 22 Oct 2026 14:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XeGJYNE6
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792679279;
	b=LHv32WpXpGVSSTB83mN1/ebPP8JXoqhf7tFcqFHV5lnPa0GWpXCOjthi/NlpHhs/kkuD
	 HCaH8rp2YiyqIX13+4S4hDq2CiVzqo2T/Vmfm0CV/ZSRtl1cjykiFl1yZd8GMQgDi0uwG
	 3VV+TqhGk1UtbFQ07pdAsXwaOI66bWgizMLqTeN1yGVAktO6VX+a6d4crRiVPgyaXMKoG
	 8bvle9NE+5i4uGRJkSz7gkbVAQHn5ev4ank+sMex9tUv8VhMvDO/OlT5z0PVstmm0DOc5
	 Hwy+p8iDfFcWHpgFCBhqdlyTq75PensOumdK+HsV2KmASpB6GHZbOMMS389ezK+U27g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792679279;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=HWHo1VyMeZVdvGG1MXQHMJUz3uY5Ij7QXNRfTATnvTc=;
	b=P0hpSkSuSdJmYe3mOI1QkhWWEJKzitFDiM0OAmsuWM3vKXZ78UOXjiNbCOKwaKF2kcCm
	 KZl59WiVtLVuEb24woJhn7GjvTDJoGp7mH7cUXVjf0+Hke6K0tRs/rWOsx6wMcAk1nmUN
	 l/AW264gFSnuCpKy6MDpeyYH6gDKI8eOoj5O+Mxu5V41ic5GktOkCvGPoG7297PlgnIvg
	 a9lpxnhkvnpNBFKl0dVCWjsceaB0felP4Y7Of2+3pSm0QZzXEOs0otkjJrm1QxTyeW2Ry
	 iqTntQTO+1nK4H/ChYiy/joMUQQ6mR6fJIQpYXhzlezfRiWeLwWz5VXCPjCqhpPKVHw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id BB31C1F000CE;
	Thu, 22 Oct 2026 14:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792679279;
	bh=HWHo1VyMeZVdvGG1MXQHMJUz3uY5Ij7QXNRfTATnvTc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=XeGJYNE6Rm+myvGiaJuRMa9vDNI8NomkB6+sIhJA0nxl7jrw1WFIjsTA+U5WM2d39
	 9ZHtzF2YwRjLrCgYRyOvNXLcJYFgufL9nPSYO4RWJTjRw9YH89kqh9HB22DuZUWzmF
	 cBxDBlmAB1L+CjBcrjha7vB+pr8sLLisO6mLVMXalMZ7z75XHCCEFPdhone58A5ctc
	 s9VYMw64FHBFt24qEX3v6yPJ2+p/TIDiYMZ8R/T+zNt5FQ+X7Q+cLAnTzyHTrG9OtB
	 Hk6OjQPAe7JOEQMy5cFy0qUevHdW7tbhbO6K7+D1T1CwUQT2Qqk3RQJN3n7H5MgqWH
	 vI8cPgo12/RAQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C42FD435CD;
	Thu, 22 Oct 2026 14:27:54 +0000 (UTC)
From: =?utf-8?q?St=C3=A9phane_Grosjean_via_B4_Relay?= <devnull+s.grosjean.peak-system.fr@kernel.org>
Date: Thu, 22 Oct 2026 16:27:53 +0200
Subject: [PATCH v6 08/13] can: peak_usb: reject records for unset channels
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
Message-Id: <20261022-canfd_check_channel_idx-v6-8-197704231551@peak-system.fr>
References: <20261022-canfd_check_channel_idx-v6-0-197704231551@peak-system.fr>
In-Reply-To: <20261022-canfd_check_channel_idx-v6-0-197704231551@peak-system.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Wolfgang Grandegger <wg@grandegger.com>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>, 
 Dan Carpenter <error27@gmail.com>, Lukas Magel <lukas.magel@posteo.net>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792679273; l=2985;
 i=s.grosjean@peak-system.fr; s=20261020; h=from:subject:message-id;
 bh=yBztvgADc0ldOVnmTjUXpwFq1BHCu2CwKsqgDlYlkCY=;
 b=w8Ulyj8hjdUSdjKon8ula0KwTZ1d5Pub7sRlIxE49M+ZFOjrZSa6XZdwhi2LW+211dmfm8B1y
 lU0Gzw5mnAiDHi1yWoRlLyoQZE6Ub0Lpj+EqZlnp4bI99ydxKIexBFI
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


