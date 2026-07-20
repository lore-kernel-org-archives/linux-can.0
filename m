Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC69F446C0E
	for <linux-can@vger.kernel.org>; Mon, 20 Jul 2026 18:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784572854; cv=none; b=NxnjenClyZcOv1VXljCRMzt1ycfDUZWonUSXcA31U8zqV6teceZR+0O7s889h6P2q7QK9kSM6DWGjKevI0dbYx1mMEQncKXgwDmUlks/QowPqia8CIxnHo1CtTxxDwRxeL+EA/SghgoKvPEVke0DV2wqF32sOyI+Lr4oYQTSvkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784572854; c=relaxed/simple;
	bh=IDOXc2ksnJ7yvgqbRgtFzV+7bZqxgMcEWALPvR5eZwE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cgYQPNVIB09YfpQafD0EVI+8abfcGKbymmCIofVQFFX6RUcoehX8nPxT53YWEbfcmB6TC+/lC+OhGyhRISs38rXG5B2zocOI1qt6QIqmer/wFqr5vG0dl3iCv+vjBBs6iTSSBjmcYSZUYEZZDWtkLE5CHM/4dDeZ4THyB+ZQfZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ehijxy1X; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehijxy1X"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c2a449c57so105546521cf.1
        for <linux-can@vger.kernel.org>; Mon, 20 Jul 2026 11:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784572850; x=1785177650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7usnKBS1qvOF6Txeg4inGxwu3o7K4Mtvix/BZ3+/BJw=;
        b=ehijxy1XzglQf4vUsvRdZPWTe6Gri6H6je/bYQzhcsf1TqAatU9EZ+iZKT4/XUU2NK
         MwGWtouM/kk7YHQWgH3d9xV3mYQhUedcDYUOtYFIL7F4S6WrzUn31Jq+W/w0QA7lWVLE
         QU292XuRGfvSlOVXjOmsWStETN0Gvwg2t1syOLEU0t8/hFZILiHDjMA1ggwk3stdz6Si
         mhvyNx3iVUqGCPjrWfjMJpf2dYSHB83b7PJ+1UnEunPyhgsNlRWI8wx1AvLZcquyL7Y+
         vItbajl/Na2q4329+mMv1FF4FYEwSwv3xrdpao//0lRSx55aGOV4JXrCezWHTMBS4GG6
         Xh2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784572850; x=1785177650;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7usnKBS1qvOF6Txeg4inGxwu3o7K4Mtvix/BZ3+/BJw=;
        b=Pc/A0zVpCznB1XAYCSGHARnpiDoHhuMyHZl1h2be+vVzFNADWf4/0AIBIgar5dg6/X
         uwk87eL/5Vwt/vY6vBLRvMcnuZ0ac2E4kPMrVKt5kcxY8kTaaj3m11lJwfdq/e9ZKJKd
         ODOm/8x4DtvQgKrZ19m3XPz1OA+TItP015SH+fPXcbGOev/yJx0V4Nhw+enHJe4sbBrq
         IPRBtUFTfWNOyf1CgkdowttSwy9Di42ma8YktgU+QoWVBtbUmt4kADGx6yHLCYX40cWq
         gxXDxI7xC42BDQw5fuy4EcJztOgbF3yD6dCZTHli+pzt29T12/vJxnK87IRcWPBwKisK
         1Hxg==
X-Forwarded-Encrypted: i=1; AHgh+RrbKMOaaK1rROBYxxONkLq8dIQ8bCdxxzOnEE217I+T/3cakOm7Xr+h/pCcIZ/nAyvDP7eKLKdYQTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGTFJJ/PxnW0PxLWfjfpvBIXz+G1TFtksBTq0yspnmCCFLPWOr
	TImtWr7JlXsDdNyTlkMk+j3rZzrk6Z9VuLlv0VDbT2ifhBHnk4jSCwnSwMN5y20z
X-Gm-Gg: AfdE7cnFITLWITVFb5+qdNXZyLbMX0JNFFJcXGIJvFFsqxrzbS3Lo9gMb3BL8qQBk+p
	HJxs0/VBoqd777J3QP9TPcGHYvym9jVNO6WfrAB8wBHxufdWyubnSD5riLMweuGJ5P8/KIqS9IJ
	9vVdvoz9t7bpqHmzFoSPF/LtiknRE2RMg/W7ojzkUA9Mp2oQjtiyJLUlvb0roXy6z+5BC1Gh9PT
	ez+jKnTh4ZsCvK4rx2hDeT9Nx1IKS3pnfRGmvZMawcn60xRotsN3+9xfeMlL3raV3Fd5Sjez5zA
	RuKEsDjERlbg0yaNXGmWdu/ZHfpWpuZNVZT/dtaPIHRO+uW3qYmnCYCTTbRTiK4tycg4mH+/ai1
	NNCx8C/kOe8JgKARq8mepHs864G1Nc4nS1HCdCGygCELPStes74yF7bdcdIfcONdbECTRb6p5rp
	6Q4nE3rjPOecGMmaTaGN7HENWbZGPf51w=
X-Received: by 2002:ac8:5714:0:b0:51c:1857:b622 with SMTP id d75a77b69052e-5213e082210mr141974371cf.54.1784572849532;
        Mon, 20 Jul 2026 11:40:49 -0700 (PDT)
Received: from i4-l-hqh5357-03.ad.psu.edu ([130.203.139.71])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5214f01654fsm79458301cf.19.2026.07.20.11.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 11:40:49 -0700 (PDT)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: mkl@pengutronix.de,
	mailhol@kernel.org
Cc: vadim.fedorenko@linux.dev,
	uwu@coelacanthus.name,
	kees@kernel.org,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Subject: [PATCH can v3] can: gs_usb: fix hardware timestamp state for mixed channels
Date: Mon, 20 Jul 2026 14:40:42 -0400
Message-ID: <20260720184042.1712217-1-shuangpeng.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hardware timestamp state is shared by struct gs_usb, but
gs_can_open() and gs_can_close() tie its initialization and teardown to
active_channels and to the feature bits of the channel being opened or
closed.

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

Count the number of active timestamp-capable channels instead. Start the
shared timestamp state when the first such channel opens, stop it when the
last such channel closes, and unwind the count if open fails.

Initialize the shared timestamp lock and delayed work once during probe.
The first timestamp-capable channel may be opened while RX URBs are
already active, so guard the count and timecounter access with the same
lock. Keep the count zero until timecounter_init() completes, and make RX
and delayed work skip the timecounter while the count is zero.

Fixes: 45dfa45f52e6 ("can: gs_usb: add RX and TX hardware timestamp support")
Cc: stable@vger.kernel.org
Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
---
Changes in v3:
- Drop Suggested-by tag.
- Move active_timestamp_channels management into the timestamp init/stop
  helpers.
- Protect active_timestamp_channels with tc_lock, and keep it zero until
  timecounter_init() has completed.
- Make RX timestamp conversion and the delayed work skip the timecounter
  while no timestamp-capable channel is active.
- Initialize the shared timestamp lock and delayed work once during probe.

Changes in v2:
- Count active timestamp-capable channels instead of tracking only whether
  the shared timestamp worker has been started.
- Stop the shared timestamp worker when the last timestamp-capable channel
  closes, even if non-timestamp channels remain open.
- Unwind the timestamp-capable channel count on gs_can_open() failures.

 drivers/net/can/usb/gs_usb.c | 81 ++++++++++++++++++++++++------------
 1 file changed, 54 insertions(+), 27 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index ec9a7cbbbc69..be25d82cedcb 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -337,6 +337,7 @@ struct gs_usb {
 
 	unsigned int hf_size_rx;
 	u8 active_channels;
+	u8 active_timestamp_channels;
 	u8 channel_cnt;
 
 	unsigned int pipe_in;
@@ -447,14 +448,20 @@ static void gs_usb_timestamp_work(struct work_struct *work)
 {
 	struct delayed_work *delayed_work = to_delayed_work(work);
 	struct gs_usb *parent;
+	bool active;
 
 	parent = container_of(delayed_work, struct gs_usb, timestamp);
 	spin_lock_bh(&parent->tc_lock);
-	timecounter_read(&parent->tc);
+	active = parent->active_timestamp_channels;
+	if (active) {
+		timecounter_read(&parent->tc);
+		active = parent->active_timestamp_channels;
+	}
 	spin_unlock_bh(&parent->tc_lock);
 
-	schedule_delayed_work(&parent->timestamp,
-			      GS_USB_TIMESTAMP_WORK_DELAY_SEC * HZ);
+	if (active)
+		schedule_delayed_work(&parent->timestamp,
+				      GS_USB_TIMESTAMP_WORK_DELAY_SEC * HZ);
 }
 
 static void gs_usb_skb_set_timestamp(struct gs_can *dev,
@@ -465,6 +472,11 @@ static void gs_usb_skb_set_timestamp(struct gs_can *dev,
 	u64 ns;
 
 	spin_lock_bh(&parent->tc_lock);
+	if (!parent->active_timestamp_channels) {
+		spin_unlock_bh(&parent->tc_lock);
+		return;
+	}
+
 	ns = timecounter_cyc2time(&parent->tc, timestamp);
 	spin_unlock_bh(&parent->tc_lock);
 
@@ -474,25 +486,40 @@ static void gs_usb_skb_set_timestamp(struct gs_can *dev,
 static void gs_usb_timestamp_init(struct gs_usb *parent)
 {
 	struct cyclecounter *cc = &parent->cc;
+	bool first = false;
 
-	cc->read = gs_usb_timestamp_read;
-	cc->mask = CYCLECOUNTER_MASK(32);
-	cc->shift = 32 - bits_per(NSEC_PER_SEC / GS_USB_TIMESTAMP_TIMER_HZ);
-	cc->mult = clocksource_hz2mult(GS_USB_TIMESTAMP_TIMER_HZ, cc->shift);
-
-	spin_lock_init(&parent->tc_lock);
 	spin_lock_bh(&parent->tc_lock);
-	timecounter_init(&parent->tc, &parent->cc, ktime_get_real_ns());
+	if (!parent->active_timestamp_channels) {
+		cc->read = gs_usb_timestamp_read;
+		cc->mask = CYCLECOUNTER_MASK(32);
+		cc->shift = 32 - bits_per(NSEC_PER_SEC /
+					      GS_USB_TIMESTAMP_TIMER_HZ);
+		cc->mult = clocksource_hz2mult(GS_USB_TIMESTAMP_TIMER_HZ,
+					       cc->shift);
+
+		timecounter_init(&parent->tc, &parent->cc,
+				 ktime_get_real_ns());
+		first = true;
+	}
+	parent->active_timestamp_channels++;
 	spin_unlock_bh(&parent->tc_lock);
 
-	INIT_DELAYED_WORK(&parent->timestamp, gs_usb_timestamp_work);
-	schedule_delayed_work(&parent->timestamp,
-			      GS_USB_TIMESTAMP_WORK_DELAY_SEC * HZ);
+	if (first)
+		schedule_delayed_work(&parent->timestamp,
+				      GS_USB_TIMESTAMP_WORK_DELAY_SEC * HZ);
 }
 
 static void gs_usb_timestamp_stop(struct gs_usb *parent)
 {
-	cancel_delayed_work_sync(&parent->timestamp);
+	bool last;
+
+	spin_lock_bh(&parent->tc_lock);
+	parent->active_timestamp_channels--;
+	last = !parent->active_timestamp_channels;
+	spin_unlock_bh(&parent->tc_lock);
+
+	if (last)
+		cancel_delayed_work_sync(&parent->timestamp);
 }
 
 static void gs_update_state(struct gs_can *dev, struct can_frame *cf)
@@ -980,10 +1007,10 @@ static int gs_can_open(struct net_device *netdev)
 
 	can_rx_offload_enable(&dev->offload);
 
-	if (!parent->active_channels) {
-		if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
-			gs_usb_timestamp_init(parent);
+	if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
+		gs_usb_timestamp_init(parent);
 
+	if (!parent->active_channels) {
 		for (i = 0; i < GS_MAX_RX_URBS; i++) {
 			u8 *buf;
 
@@ -1094,12 +1121,11 @@ static int gs_can_open(struct net_device *netdev)
 out_usb_free_urb:
 	usb_free_urb(urb);
 out_usb_kill_anchored_urbs:
-	if (!parent->active_channels) {
-		usb_kill_anchored_urbs(&parent->rx_submitted);
+	if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
+		gs_usb_timestamp_stop(parent);
 
-		if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
-			gs_usb_timestamp_stop(parent);
-	}
+	if (!parent->active_channels)
+		usb_kill_anchored_urbs(&parent->rx_submitted);
 
 	can_rx_offload_disable(&dev->offload);
 	close_candev(netdev);
@@ -1152,12 +1178,11 @@ static int gs_can_close(struct net_device *netdev)
 
 	/* Stop polling */
 	parent->active_channels--;
-	if (!parent->active_channels) {
-		usb_kill_anchored_urbs(&parent->rx_submitted);
+	if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
+		gs_usb_timestamp_stop(parent);
 
-		if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
-			gs_usb_timestamp_stop(parent);
-	}
+	if (!parent->active_channels)
+		usb_kill_anchored_urbs(&parent->rx_submitted);
 
 	/* Stop sending URBs */
 	usb_kill_anchored_urbs(&dev->tx_submitted);
@@ -1577,6 +1602,8 @@ static int gs_usb_probe(struct usb_interface *intf,
 	parent->channel_cnt = icount;
 
 	init_usb_anchor(&parent->rx_submitted);
+	spin_lock_init(&parent->tc_lock);
+	INIT_DELAYED_WORK(&parent->timestamp, gs_usb_timestamp_work);
 
 	usb_set_intfdata(intf, parent);
 	parent->udev = udev;
-- 
2.43.0
