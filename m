Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0B879DA
	for <linux-can@vger.kernel.org>; Sun, 19 Jul 2026 03:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784430035; cv=none; b=LLASvUwKpah4DBlkPjmpLSqBRUeHCZGWfw7NePSRCJ5fHvXQfzNBEmrR1DRRW11eKB+RTrZGHw9zcngSeRqi/AQ11Pi4vvOnjpONJQnBg77tZNwGLYZTgZEKWzWr/0wSswVyBexnZ6/Egc4u6tmQo5zNVtEr6dRpzPMFFzN8+2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784430035; c=relaxed/simple;
	bh=Jn33P+/6FTfvH5tB+4YcYehstSunwoyd5SiHVTVlZz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MCI4/caFxZBnOO/MSeQsS/HVncqqAs9t4OMsxW7KQn+kZCfb9ttFrXAOo/+C5UUIez7PUVWUgHDcnEAR42hvqifO05oBqG6bXNHQYPddbT2l7ZUHwmArd1RJWfAAoDhcnRKIpXBWAA2aBriVu3C3B+YEIiIlXiN1M18aPwmA2bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lI8NQ+Rr; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lI8NQ+Rr"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c01089e8aso40802871cf.2
        for <linux-can@vger.kernel.org>; Sat, 18 Jul 2026 20:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784430031; x=1785034831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8VKY6n6oODsytlm7jYrsNeF3Lue+neWZnZVfcsQNCPs=;
        b=lI8NQ+Rrnf8oYxMmCdApHmFEb48jlzs0LGnVeIjLNjlsDTJAa5bdBfkZ6QR6ZY5C8b
         pXto3JwD1OFkVOEc9DrNlMuM08uxAUDjJaQ8E6TvnMPDLOsdgLmUmOt5U09PUWlANSNs
         sFCjGuGPHLm7YkpwuYsUkN74Flnow14E4YaCyJVqM18a/9oELx9o4J25l8fDZCeYrz4Q
         98ZB6fGUJ2joROmVyIv+4gvJQMrYPkp5onykkeROLla5yeVCENZbxyF47eINYGksBaEb
         IESWxv6bIZnqcfVLMIUC6pXI0l0rgVaO1XIvPaFItnbuvI9YJmQjitWMx4HG1zmM2ICe
         5ZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784430031; x=1785034831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8VKY6n6oODsytlm7jYrsNeF3Lue+neWZnZVfcsQNCPs=;
        b=cIAk3SXe+U7fjoplwKIjing4tw4EsV9JI7sz4xEsxH2fxXlWhlg0JaDhLCEMY9RPdn
         TdK+kg3HPRa1HU6IrrVwCmHkW02SxDgPSwfRkYXk+69ld8Y49v98FnmsTlNAOjrlWEp4
         QGfSiRwmnECgAFC0XqMIjttmk3E2nBcaNCG7jso7cx6BoDAO1BB/Ssd73GKN82XzyNx9
         MReXneDEbQEA6PmWD5tVf7vMhhdkVXCqflghWfGfTYUoLFH71rbRP5zmJ0k4Uknw58Qd
         ezA2MFnDozxntVqNORDufNjOqbFuPe3pEsRXRvPKV0AH36jljs0zjvayHvYHEB++6QCW
         o3Jg==
X-Forwarded-Encrypted: i=1; AHgh+RoxTaFUveDlFp/SPKfaTYoYAc4piIV/KRW3mDCk2JlQW/vi9m+UPkczjCZAX5TAxFr9JAhTvVY0caU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMXsKRDHGlHxFo213buajVns5T37CpyPGMBCNmCJOA5lXyJB2n
	dkE1q4N+MPlef9cXUT/fKpSWzHJbJJArGKTDCI1Khd9juZIXQNDF7RZ5
X-Gm-Gg: AfdE7cm+8EKxf4BGHXfKEgTWXTkxWBtcWaIpzxkQpq1R1UF3vhZBVQt9nmvYcatqkL3
	2/vVJCDVtooWnYcmJS25mf6lnZhgS7SFX1JZyTCjQmIZDAhUnBmc2LN9EVl2y7hv764v92syPq7
	yQZTWqvTj7WY4i9oFYEltkfcCwbgYChqo9hYHHG3zaPRJ9sBnEtBmurb+w4O11JaXoKl+qoEEpP
	qusBSotBo4huWk0Ijv6A9yirkLUJUh3itvEieXHu/ChluGoMMla+/MaqIpXck0ZPsDlMWil1gwC
	fwoTvfkrIZQ/FMtpRY/RWCBeMBCf/Kh7GfuhpKJneIazMVhtkS+A/33GfhBe7J3y9phvqw4Uq70
	/R79bdclsrov5NDJkswYUDoyxFYxeweCUm2rkhaNlmSyU/Yfi5e0GN0/EJxk4JwvABcaPDzqFaH
	/zQf1mnWEu7rv2fmzFgUk4HgV45s9wsJQ=
X-Received: by 2002:ac8:5e49:0:b0:51c:7b12:1202 with SMTP id d75a77b69052e-5213f36fceamr85793061cf.80.1784430031320;
        Sat, 18 Jul 2026 20:00:31 -0700 (PDT)
Received: from i4-l-hqh5357-03.ad.psu.edu ([130.203.139.71])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5214f01654fsm44853871cf.19.2026.07.18.20.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 20:00:30 -0700 (PDT)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Celeste Liu <uwu@coelacanthus.name>,
	Kees Cook <kees@kernel.org>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shuangpeng Bai <shuangpeng.kernel@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH can v2] can: gs_usb: fix hardware timestamp state for mixed channels
Date: Sat, 18 Jul 2026 23:00:00 -0400
Message-ID: <20260719030000.3667449-1-shuangpeng.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260718052815.2507496-1-shuangpeng.kernel@gmail.com>
References: <20260718052815.2507496-1-shuangpeng.kernel@gmail.com>
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

Count the number of active timestamp-capable channels. Start the shared
timestamp worker when the first such channel opens, stop it when the last
such channel closes, and unwind the count if open fails.

Fixes: 45dfa45f52e6 ("can: gs_usb: add RX and TX hardware timestamp support")
Cc: stable@vger.kernel.org
Suggested-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
---
Changes in v2:
- Count active timestamp-capable channels instead of tracking only whether
  the shared timestamp worker has been started.
- Stop the shared timestamp worker when the last timestamp-capable channel
  closes, even if non-timestamp channels remain open.
- Unwind the timestamp-capable channel count on gs_can_open() failures.

 drivers/net/can/usb/gs_usb.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index ec9a7cbbbc69..9cc197803e0d 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -337,6 +337,7 @@ struct gs_usb {
 
 	unsigned int hf_size_rx;
 	u8 active_channels;
+	u8 active_timestamp_channels;
 	u8 channel_cnt;
 
 	unsigned int pipe_in;
@@ -980,10 +981,13 @@ static int gs_can_open(struct net_device *netdev)
 
 	can_rx_offload_enable(&dev->offload);
 
-	if (!parent->active_channels) {
-		if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
+	if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP) {
+		if (!parent->active_timestamp_channels)
 			gs_usb_timestamp_init(parent);
+		parent->active_timestamp_channels++;
+	}
 
+	if (!parent->active_channels) {
 		for (i = 0; i < GS_MAX_RX_URBS; i++) {
 			u8 *buf;
 
@@ -1094,13 +1098,15 @@ static int gs_can_open(struct net_device *netdev)
 out_usb_free_urb:
 	usb_free_urb(urb);
 out_usb_kill_anchored_urbs:
-	if (!parent->active_channels) {
-		usb_kill_anchored_urbs(&parent->rx_submitted);
-
-		if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
+	if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP) {
+		parent->active_timestamp_channels--;
+		if (!parent->active_timestamp_channels)
 			gs_usb_timestamp_stop(parent);
 	}
 
+	if (!parent->active_channels)
+		usb_kill_anchored_urbs(&parent->rx_submitted);
+
 	can_rx_offload_disable(&dev->offload);
 	close_candev(netdev);
 
@@ -1152,13 +1158,15 @@ static int gs_can_close(struct net_device *netdev)
 
 	/* Stop polling */
 	parent->active_channels--;
-	if (!parent->active_channels) {
-		usb_kill_anchored_urbs(&parent->rx_submitted);
-
-		if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
+	if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP) {
+		parent->active_timestamp_channels--;
+		if (!parent->active_timestamp_channels)
 			gs_usb_timestamp_stop(parent);
 	}
 
+	if (!parent->active_channels)
+		usb_kill_anchored_urbs(&parent->rx_submitted);
+
 	/* Stop sending URBs */
 	usb_kill_anchored_urbs(&dev->tx_submitted);
 	atomic_set(&dev->active_tx_urbs, 0);
-- 
2.43.0
