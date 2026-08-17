Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285C21A683A
	for <linux-can@vger.kernel.org>; Mon, 17 Aug 2026 01:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786930682; cv=none; b=k1qG7iHneWxGsRDBraASFtoAn0goRF1+lXdy2+junTeHKMxEymc0pU3g0z6akM+HzhyO3+YzWpDSBgb0ZdNZfPeXW7JUI7bNwAi4aK5mwIWgfjNlm7IGHk+5o4H39SaLtllU0yjT8529inWfvmd176hN+tt3em/FEyZ8ccz7dII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786930682; c=relaxed/simple;
	bh=WGZhX3UNcSru063oe0/KPOEzdlRjCev1RZjHtYjB1g8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cjIjt2WzvFknqB0ZU6Nbo3P6nYicpLMUjtHNJCjdU/DREZ7sYUDFlrMZaUYNDigelrg+cTL70fQm0n1OcmcLyLUoBtpeaNXrq/FBg08MQrP7ycFWSDmnyP3ZOaIFgkUGnLzFtQ0WPUsFgoA/qF3SYsG9qrGUOpyMFYkuAgVh+q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qkuDeXow; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qkuDeXow"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38dcbade417so2820959a91.1
        for <linux-can@vger.kernel.org>; Sun, 16 Aug 2026 18:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786930679; x=1787535479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eY8RYhguruvb++TRBB7XQhOx6d1wihTPxhfFylErixw=;
        b=qkuDeXowmk3gWc3wF44DlHxFGXuuE7FyKsA7tAfDvSwPHlmYvP256iynWaFs5SsGSt
         QOkVRcqV9y2celUDvb1Cn8aZBj5iQ3MTh/6NM5Dz5z5JMJgptIa6L1z8j44b0aKjeI/l
         4A4o3fgXRXhkgKzAyJ/G5slBdRBT1wPzQDhy7rNMOzQiLtocQ/MsxjnjWgGpixrMMsLB
         WeMabSXi4HJtwiVO+YddUd8xaXSLlW2r3iOunGh983/E/xFWJ6IxfPEorVM/19uW9cHB
         pe8SITuuiQB2pVWabWNmPKg56ZD3XD1NQxJzcCI7AJRadIRMR6FBQNvHNF8/V04jskd1
         I2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786930679; x=1787535479;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eY8RYhguruvb++TRBB7XQhOx6d1wihTPxhfFylErixw=;
        b=gUaYDSZFJC/9yDLnzIpLmrzhhuUzL4L2U2xCi4sJEUB8UQLBfYAvXCA92n+hDpFaUO
         mVUVJTpcKOIearudAZrTcuYG86h3AEt8mMfrxCp+/Xw8GOD13+2h/5NY6wV2shpSjFqY
         59XHLNEVbpj+lcvtMx2zUFCUNQAhSW3YwUY3j+YnXTgOBnxuHwR5aBo2A8zBtc6yS/wc
         K00Zj0LMYCuI7EKsj6y97+OcV8xtL8yYyTCK33zB8yt/4UGf2vhJr52nHo4A2ieDfdk9
         i+iyWx1cuXRXpagHcECKLxOnjK64X3B+hZgRCR5SAaxz71RJCom+QALd4c6h2nIZcJ4w
         mP9Q==
X-Gm-Message-State: AOJu0YxeqJ8i+5+/H5jXIGGTu7j980wu35bjlQSPvOAF+6CZCQVBiebN
	bNgd1rLp+9d7W/kQAKUC7SlwvmEkPd2/NmpDdz+r5TnUYCbGBw6jRxvg
X-Gm-Gg: AR+sD10GQkuHBphrC0x4qwejKlTmPmEikM+NYxG6Uz9yppFk1zM3uvwiOR7YscqsUbi
	DsibLGGrF6QoAjvwiuJXy37k+7dQHiPM1UBdMFgReh7noBhsuoc78N9z/YmYgUX0YXdYVOfKMq9
	el1MlDcu7l9esO0Gmmr2+hgVhRFFYYDFbiynA1SCkM1lBorn4dNJquXzJZ8atvmm9gnGxLvZQYg
	AXulC1OaFJA1d0CUDsYCbI3sN2iDc9Rv//Zn/jED6tFCkgW9N/rKrgiEXBArem5cTtOkf88y80N
	TNYnKiamsI6tWoQ1GVRur/ZCV+yuesgrlpeuA7Ro74y4CBTMUQ70f9HjSmAeay/6irH8mV3KQcm
	b5dpUx8zUFaCfAUkWA0uRizSdsQDxnUYoydAa60cyWDKvCms63TGF2Q4MknY+n3RUvuGIQs2AHN
	vCw1AyxcrrHRiA7YvmHAfMUqOLPhYNMV6CHSNoy2HxTy6TubwpKR6VMW3P2jhNcNrW5bykyEjL
X-Received: by 2002:a17:90b:224a:b0:38f:837e:fc5d with SMTP id 98e67ed59e1d1-3933b786507mr20975985a91.3.1786930679299;
        Sun, 16 Aug 2026 18:37:59 -0700 (PDT)
Received: from localhost.localdomain ([120.236.7.85])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3954d3d2adcsm222657a91.17.2026.08.16.18.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 18:37:58 -0700 (PDT)
From: Cheng Liu <chengliu480@gmail.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Elaine Zhang <zhangqing@rock-chips.com>,
	Cheng Liu <chengliu480@gmail.com>
Subject: [PATCH can] can: rockchip: rk3576: fix rtnl_lock deadlock during interface down under bus traffic
Date: Mon, 17 Aug 2026 09:37:50 +0800
Message-Id: <20260817013750.1836064-1-chengliu480@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When bringing the CAN interface down (via `ip link set can0 down`) while
there is heavy incoming CAN traffic or continuous hardware error frames,
the system hangs and deadlocks. Existing and new networking operations
(such as `ifconfig`, SSH logins, Socket operations) hang indefinitely
waiting for `rtnl_lock`.

The deadlock occurs because `rk3576_canfd_close()` calls `napi_disable()`
before `rk3576_canfd_stop()`. Since hardware interrupts are still
active, incoming CAN frames and error interrupts continuously trigger
`napi_schedule()`, preventing `napi_disable()` from seeing the
`NAPI_STATE_SCHED` bit cleared and causing it to loop infinitely in
`msleep(1)`. Because `dev_close()` holds the global `rtnl_lock`, the
entire networking subsystem deadlocks:

Call trace:
  __switch_to+0xdc/0x120
  __schedule+0x2ac/0x840
  schedule+0x54/0xe0
  schedule_hrtimeout_range_clock+0x98/0x134
  usleep_range_state+0x7c/0xb0
  napi_disable+0xc0/0x110
  rk3576_canfd_close+0x44/0xd0
  __dev_close_many+0xb0/0x14c
  dev_change_flags+0x28/0x64
  do_setlink+0x618/0xe2c
  rtnetlink_rcv_msg+0x2a8/0x380

Fix this by:
1. Reordering `rk3576_canfd_close()` to call `rk3576_canfd_stop()` before
   `napi_disable()`, ensuring interrupts are disabled and controller is
   in reset mode before waiting for NAPI to complete.
2. Standardizing `rk3576_canfd_rx_poll()` to respect the NAPI
   quota/budget and properly complete NAPI polling via
   `napi_complete_done()`.
3. Guarding against NULL pointer dereference in `rk3576_canfd_err()` when
   `alloc_can_err_skb()` fails, and calling `can_bus_off()` upon bus-off.

Signed-off-by: Cheng Liu <chengliu480@gmail.com>
---
 drivers/net/can/rockchip/rk3576_canfd.c | 61 +++++++++++++------------
 1 file changed, 32 insertions(+), 29 deletions(-)

diff --git a/drivers/net/can/rockchip/rk3576_canfd.c b/drivers/net/can/rockchip/rk3576_canfd.c
index 2c0d7f056..d0f581bce 100644
--- a/drivers/net/can/rockchip/rk3576_canfd.c
+++ b/drivers/net/can/rockchip/rk3576_canfd.c
@@ -859,31 +859,28 @@ static int rk3576_canfd_rx_poll(struct napi_struct *napi, int quota)
 {
 	struct net_device *ndev = napi->dev;
 	struct rk3576_canfd *rcan = netdev_priv(ndev);
-	int work_done = 0, cnt = 0;
+	int work_done = 0;
+	u32 frames_avail;
 
 	if (rcan->use_dma) {
-		while (work_done < rcan->quota)
+		while (work_done < rcan->quota && work_done < quota)
 			work_done += rk3576_canfd_rx(ndev, work_done);
 
-		if (work_done <= rcan->rx_fifo_depth) {
-			napi_complete_done(napi, work_done);
-			rk3576_canfd_write(rcan, CANFD_INT_MASK, INT_ENABLE);
+		if (work_done < quota) {
+			if (napi_complete_done(napi, work_done))
+				rk3576_canfd_write(rcan, CANFD_INT_MASK, INT_ENABLE);
 		}
 	} else {
-		quota = (rk3576_canfd_read(rcan, CANFD_STR_STATE) & rcan->rx_fifo_mask) >>
-			rcan->rx_fifo_shift;
-		quota = quota / rcan->rx_max_data;
-		cnt = (rk3576_canfd_read(rcan, CANFD_STR_STATE) & INTM_CNT_MASK) >> INTM_CNT_SHIFT;
-		if (quota != cnt)
-			quota = ((rk3576_canfd_read(rcan, CANFD_STR_STATE) & rcan->rx_fifo_mask) >>
-				rcan->rx_fifo_shift) / rcan->rx_max_data;
-
-		while (work_done < quota)
+		frames_avail = (rk3576_canfd_read(rcan, CANFD_STR_STATE) & rcan->rx_fifo_mask) >>
+			       rcan->rx_fifo_shift;
+		frames_avail = frames_avail / rcan->rx_max_data;
+
+		while (work_done < frames_avail && work_done < quota)
 			work_done += rk3576_canfd_rx(ndev, CANFD_RXFRD);
 
-		if (work_done <= rcan->rx_fifo_depth) {
-			napi_complete_done(napi, work_done);
-			rk3576_canfd_write(rcan, CANFD_INT_MASK, INT_ENABLE);
+		if (work_done < quota) {
+			if (napi_complete_done(napi, work_done))
+				rk3576_canfd_write(rcan, CANFD_INT_MASK, INT_ENABLE);
 		}
 	}
 	return work_done;
@@ -926,7 +923,7 @@ static int rk3576_canfd_err(struct net_device *ndev, u32 isr)
 {
 	struct rk3576_canfd *rcan = netdev_priv(ndev);
 	struct net_device_stats *stats = &ndev->stats;
-	struct can_frame *cf;
+	struct can_frame *cf = NULL;
 	struct sk_buff *skb;
 	unsigned int rxerr, txerr;
 	u32 sta_reg;
@@ -945,17 +942,21 @@ static int rk3576_canfd_err(struct net_device *ndev, u32 isr)
 	if (isr & BUS_OFF_INT) {
 		rcan->can.state = CAN_STATE_BUS_OFF;
 		rcan->can.can_stats.bus_off++;
-		cf->can_id |= CAN_ERR_BUSOFF;
+		can_bus_off(ndev);
+		if (skb)
+			cf->can_id |= CAN_ERR_BUSOFF;
 	} else if (isr & PASSIVE_ERR_INT) {
 		rcan->can.can_stats.error_passive++;
 		rcan->can.state = CAN_STATE_ERROR_PASSIVE;
 		/* error passive state */
-		cf->can_id |= CAN_ERR_CRTL;
-		cf->data[1] = (txerr > rxerr) ?
-					CAN_ERR_CRTL_TX_WARNING :
-					CAN_ERR_CRTL_RX_WARNING;
-		cf->data[6] = txerr;
-		cf->data[7] = rxerr;
+		if (skb) {
+			cf->can_id |= CAN_ERR_CRTL;
+			cf->data[1] = (txerr > rxerr) ?
+						CAN_ERR_CRTL_TX_WARNING :
+						CAN_ERR_CRTL_RX_WARNING;
+			cf->data[6] = txerr;
+			cf->data[7] = rxerr;
+		}
 	}
 	if (sta_reg & ERR_WARNING_STATE) {
 		rcan->can.can_stats.error_warning++;
@@ -984,9 +985,11 @@ static int rk3576_canfd_err(struct net_device *ndev, u32 isr)
 		can_free_echo_skb(ndev, 0, NULL);
 		netif_start_queue(ndev);
 	}
-	stats->rx_packets++;
-	stats->rx_bytes += cf->can_dlc;
-	netif_rx(skb);
+	if (skb) {
+		stats->rx_packets++;
+		stats->rx_bytes += cf->can_dlc;
+		netif_rx(skb);
+	}
 
 	return 0;
 }
@@ -1070,8 +1073,8 @@ static int rk3576_canfd_close(struct net_device *ndev)
 	struct rk3576_canfd *rcan = netdev_priv(ndev);
 
 	netif_stop_queue(ndev);
-	napi_disable(&rcan->napi);
 	rk3576_canfd_stop(ndev);
+	napi_disable(&rcan->napi);
 	close_candev(ndev);
 	pm_runtime_put(rcan->dev);
 
-- 
2.34.1

