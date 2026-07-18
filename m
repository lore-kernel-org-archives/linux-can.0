Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D263265606
	for <linux-can@vger.kernel.org>; Sat, 18 Jul 2026 05:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784352507; cv=none; b=Llw3aorvsfF6oKcl0L0HxjTiUYsuqhOGyOL7knka3jmGqnzQwPRYtKszjSEqEfLJBqyWZVX6zSHKWeIwKYqrbkQ/4+EISD0RraUb9R2gJB34fALzRIYMo6V1Ywq19UErtP/ZpcZXC8GpvIQiukjnp1271BcUsToVMG+gnawfYqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784352507; c=relaxed/simple;
	bh=TkDJ4FmP8CsXKYshsdPNQxDgexCOgsQdT5y/Gb32wCM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L4mHMRG+0bX6OLXonff60L39xZsnmSP34rSsbEQLpI4IQcY9PA9VejUJnpRKFj3EkWoMrjR0LF0kR0kbuyi936bSp1CFKU/1Yo6TRYcADLC/g6CReJyzyATRHaWDxjoj7ZHYg8GvHEZMUOhLstVP5jt2LarREQ0EYEzOQM/oHeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yb8NAp9g; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yb8NAp9g"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c0a81d286so18878741cf.1
        for <linux-can@vger.kernel.org>; Fri, 17 Jul 2026 22:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784352504; x=1784957304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RNGLrPX1b+m8I8qDGUqtc6iyYbzijqi3N+HkRN1Rmho=;
        b=Yb8NAp9gm3Av5ZFD1WetE79MQ0cqMP8jlTLNIFf+rP8bpvCHHtC9G6xqFlJsu2aEsq
         I/Ml9JNi19OehjvpzxeSKzRcbRfEnWB5Kv1H+4mBdJzS+/HLuzG8/VmgqYKhHmKOpgxV
         vdtllTbt9QBCj+J49WGUYNSVh9C7uh3iQoYnNIKeyR7C4zvhFquwPAxIPXtEtrd4nV2i
         cLWBK6oUbknTKd5J/BUVfW19K6kNFjNOF94sVROnGEDXRvpcxbOmipvM3Lv9wx0NqbIW
         DBj7ZZDG2fI9Q5V86EaYAAdq7B0v0MRH8NsUoyK1qxSynmSpFMcyw5kSoDK5qBCr23RZ
         hRAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784352504; x=1784957304;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RNGLrPX1b+m8I8qDGUqtc6iyYbzijqi3N+HkRN1Rmho=;
        b=cEPehHP8b6ecv1n3+y3pnu06OH/9NYl6UbXbsALqeaPcCQrX63CRZERsp8mrZoPhmR
         Jz8aO71K2mJFESrhVmQPbeUulcV0uRKFGmsE8uUoav+bW7PB+7M4oMEjPUBgvGYdP6cX
         BvA/vyRLNqsgtRUNZS43jBzFaFMMM4b2wdth9StEMmog7CdEEepJd7k6fOPcuzxfZEgx
         8GqJpfo9w1EXyjk3kSdlCbsX0Ww0fL1qUOjp88boxR+Ss6XEV6PmWEJ5oHE8rGcaxDmR
         TAwR9F8tP2zOuAiGvBf+gcpMaVv4L8dGelGhAaMsimeTVs7NSDZK24VXJ+FAhcfNvucu
         09+w==
X-Forwarded-Encrypted: i=1; AHgh+Rr0LfSD0sUIXoMpJHCIsvzFazp5M+ORDIA+C1uxgmK+WaTOLveSr3o0ZZQymKtmTPm2ab2MJXducVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YywqQzKwL2z4ZLxzYq9Chm+3t8FjI5KArtOLZOwffQMZOaqm9XZ
	Q6To0rnzo8BiBCBmVouBcgIERVucLdze9Wg8VKgsO1uxIadkiW666DJI
X-Gm-Gg: AfdE7cle+9abIcArzD5i2nYjdwAdmZgQKSGSR0So1NQx84nCv37/R6IergNTeFQlz3M
	MMIrpzHP3he5J7ezhfWT5D7Gl82o4FCy3rI9RFtu2FJ7RRH9kBQjPeg14d39VNez1Milzx0+sd0
	7CVJdOS76CHOM5EE1Kl2lfuLimnFAoJliinZXu8G3a8SwgsGHUsV/bkguFm7si1MQiYw5GGrK/c
	w05XI3DJ+3L1V/YzItHL9NkzKQfoye/QOqMlAKx6QtNSBLzhaRCzOPNegZtpIBHVqS0fkvgV26l
	Q34K0+oHIEdN3dveHoiKtL2ncI9vUaeKn5xNiOxOTPKbFjhDWkF/3xcqhE9PmSYQLtU3goCqI2H
	y9g89Vk3SBGT75sDHF84BQ8oiqJLmOonirkSQ3ZpCfzQpUGzZu9qaVIEmb2wivJ9+rgl2QjJa3R
	1ReaVhhPthW7pESGsUIn+kB3de6ifMtlo=
X-Received: by 2002:a05:622a:41:b0:51a:8ee6:c54a with SMTP id d75a77b69052e-52129d98067mr53980861cf.11.1784352504598;
        Fri, 17 Jul 2026 22:28:24 -0700 (PDT)
Received: from i4-l-hqh5357-03.ad.psu.edu ([130.203.139.71])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5214f015f71sm27624941cf.16.2026.07.17.22.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 22:28:24 -0700 (PDT)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>
Cc: Celeste Liu <uwu@coelacanthus.name>,
	Kees Cook <kees@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shuangpeng Bai <shuangpeng.kernel@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH can] can: gs_usb: fix hardware timestamp state for mixed channels
Date: Sat, 18 Jul 2026 01:28:15 -0400
Message-ID: <20260718052815.2507496-1-shuangpeng.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hardware timestamp state is shared by struct gs_usb, but gs_can_open()
and gs_can_close() tie its initialization and teardown to active_channels
and to the feature bits of the channel being opened or closed.

This is wrong for mixed-channel devices in both directions. If a
non-timestamp channel opens first, a later timestamp-capable channel does
not initialize the shared cyclecounter/timecounter because active_channels
is already non-zero. Timestamp RX then calls timecounter_cyc2time() with
parent->tc.cc unset.

Conversely, if a timestamp-capable channel opens first and starts the
shared delayed work, then closes while a non-timestamp channel remains
active, disconnect may close the non-timestamp channel last. The old
teardown check skips gs_usb_timestamp_stop() in that case and frees
struct gs_usb while the delayed work timer is still queued.

Track whether the shared timestamp work has been started in struct
gs_usb. Start it whenever opening a timestamp-capable channel and the
shared state is not started yet, and stop it when the last channel closes
regardless of that channel's feature bits. Initialize the delayed work and
lock once during probe.

Fixes: 45dfa45f52e6 ("can: gs_usb: add RX and TX hardware timestamp support")
Cc: stable@vger.kernel.org
Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
---
 drivers/net/can/usb/gs_usb.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index ec9a7cbbbc69..bf956fef0d19 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -337,6 +337,7 @@ struct gs_usb {
 
 	unsigned int hf_size_rx;
 	u8 active_channels;
+	bool timestamp_started;
 	u8 channel_cnt;
 
 	unsigned int pipe_in;
@@ -480,19 +481,23 @@ static void gs_usb_timestamp_init(struct gs_usb *parent)
 	cc->shift = 32 - bits_per(NSEC_PER_SEC / GS_USB_TIMESTAMP_TIMER_HZ);
 	cc->mult = clocksource_hz2mult(GS_USB_TIMESTAMP_TIMER_HZ, cc->shift);
 
-	spin_lock_init(&parent->tc_lock);
 	spin_lock_bh(&parent->tc_lock);
 	timecounter_init(&parent->tc, &parent->cc, ktime_get_real_ns());
 	spin_unlock_bh(&parent->tc_lock);
 
-	INIT_DELAYED_WORK(&parent->timestamp, gs_usb_timestamp_work);
 	schedule_delayed_work(&parent->timestamp,
 			      GS_USB_TIMESTAMP_WORK_DELAY_SEC * HZ);
+
+	parent->timestamp_started = true;
 }
 
 static void gs_usb_timestamp_stop(struct gs_usb *parent)
 {
+	if (!parent->timestamp_started)
+		return;
+
 	cancel_delayed_work_sync(&parent->timestamp);
+	parent->timestamp_started = false;
 }
 
 static void gs_update_state(struct gs_can *dev, struct can_frame *cf)
@@ -959,6 +964,7 @@ static int gs_can_open(struct net_device *netdev)
 	struct urb *urb = NULL;
 	u32 ctrlmode;
 	u32 flags = 0;
+	bool timestamp_started = false;
 	int rc, i;
 
 	rc = open_candev(netdev);
@@ -980,10 +986,13 @@ static int gs_can_open(struct net_device *netdev)
 
 	can_rx_offload_enable(&dev->offload);
 
-	if (!parent->active_channels) {
-		if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
-			gs_usb_timestamp_init(parent);
+	if ((dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP) &&
+	    !parent->timestamp_started) {
+		gs_usb_timestamp_init(parent);
+		timestamp_started = true;
+	}
 
+	if (!parent->active_channels) {
 		for (i = 0; i < GS_MAX_RX_URBS; i++) {
 			u8 *buf;
 
@@ -1094,11 +1103,11 @@ static int gs_can_open(struct net_device *netdev)
 out_usb_free_urb:
 	usb_free_urb(urb);
 out_usb_kill_anchored_urbs:
+	if (timestamp_started)
+		gs_usb_timestamp_stop(parent);
+
 	if (!parent->active_channels) {
 		usb_kill_anchored_urbs(&parent->rx_submitted);
-
-		if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
-			gs_usb_timestamp_stop(parent);
 	}
 
 	can_rx_offload_disable(&dev->offload);
@@ -1155,8 +1164,7 @@ static int gs_can_close(struct net_device *netdev)
 	if (!parent->active_channels) {
 		usb_kill_anchored_urbs(&parent->rx_submitted);
 
-		if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
-			gs_usb_timestamp_stop(parent);
+		gs_usb_timestamp_stop(parent);
 	}
 
 	/* Stop sending URBs */
@@ -1577,6 +1585,8 @@ static int gs_usb_probe(struct usb_interface *intf,
 	parent->channel_cnt = icount;
 
 	init_usb_anchor(&parent->rx_submitted);
+	spin_lock_init(&parent->tc_lock);
+	INIT_DELAYED_WORK(&parent->timestamp, gs_usb_timestamp_work);
 
 	usb_set_intfdata(intf, parent);
 	parent->udev = udev;
-- 
2.43.0

