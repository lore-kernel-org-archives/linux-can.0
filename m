Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B225272621
	for <linux-can@vger.kernel.org>; Sun,  6 Sep 2026 22:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788733299; cv=none; b=q+VsIpr6KxUhlbHXiE8blG52n9Go+VZjluJSSy1+Z1/UAml9mo/s+3qN5b5LsqwewPI8BrPuOnjmsfJYiszllI30jAmKb9wrkVW/lnaeDklXi3K7BjmA2u88o96Q+AnzE0f6IAh+wYa/6mpdhdQvITyhk+E1ahx8Fk/1/CnYZlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788733299; c=relaxed/simple;
	bh=D6hNfgDto5D5sV8zVfuhQ3ZnGglLgYLwa5e8Cn5i140=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Iy/gfWIzn9vc2nLOWomflwpqimLRzMFQW01xcgCVBJwLGCaPLBdyPhJyUxWMEl7xqwXrm8VIK/vssGGu9iBhuqbt0GvLRDlbTjzmSQpt+cF/gH8uxCOaUvRLa185RtM7wM8AJqVokKmxC1a4z/tjzOUyk9HG5LCwuW2/xRfGOnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=mO5Svym7; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="mO5Svym7"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-39647aa9d52so2848147a91.0
        for <linux-can@vger.kernel.org>; Sun, 06 Sep 2026 15:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1788733297; x=1789338097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eHT6Xnp87xDPp5heJQWaTbtcxxsKUy15SETr/oDGMQM=;
        b=mO5Svym7H0V+1ZYHP6IqUT/xD92VSiPoQNYoBFR+xumGRA41HDn0gKDr/ZceSTx5tB
         TT3Cp+rThM/0gwd7uo3v0+v0z0rru83i6DMH8lBetDvsAr8B+FQjwV7CjOjUqM9Ze0Ee
         lChHQYzqzH3k8Gw/XQcC+xvqFQoGi0cTwPOVT8hsyOrCjexn4nm0swJlmObEvb3JX551
         ERRyp56vT+S+drZ05rpQUGHuMJ+yOkI57lhRp01pzOkcyo0/xzSnPXUtsTRXiRKuWjB8
         nGN2ycGPLxsm9Tcjcvimx5y5JLy2+2ojQS8TyAeHM9WZEoKFqGYELGN0bSoM+CyhiR77
         WkXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788733297; x=1789338097;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eHT6Xnp87xDPp5heJQWaTbtcxxsKUy15SETr/oDGMQM=;
        b=Y5Io+zqemu7ZkoUFO1tLja/2S9gKCPeeVDEdpBxwcH/c7c1iFrFHdvtXP19ZBMI40o
         TaMPAgQkhmQdDW6QabBugMJXp/u6Q0fVFb6/dYGW57NhINryXARf2w5NCWYa+npSVx+F
         DVxZJeIAnx6d7JG2P+l7p1CL/tR+fMRzt4bCULzUnV31GjHBwUu56XZUJGpxfLUs0u++
         Z2ea/PqD+TnC9ldlN6f9AUPzi3SJN8vOyMTRlwKODZ1CetUVb1qe8Ogrirg6TCes1EAB
         an4qj7t7Jir/QPBD1v1Y9HF35VP/1c6zzycb0SwtqvhmiPUeYQT84ukTGnSLkDxuMu4n
         DhIA==
X-Forwarded-Encrypted: i=1; AKwUvByr2Wek5ob3xUoWmkFb/HW4qiad5wbA+BKEIO3QcTsg+7+jaEac5pOfCploaS4whQfg3vKdSvel09Y=@vger.kernel.org
X-Gm-Message-State: AFuF++kSLAXhuA7BNGatb+AucJagEo5U9lq2Mu/WWKThDrHwMYbn1x+p
	gtGDFpgoYX+nSOJVBMn6oBrZCnBgHXds3zmcSg6yJxnbZVVOfL3sGcv1NefsKXMMRA==
X-Gm-Gg: AYBFou3Tv84jln+PLB87gJiyMhYguwMAiCr83k6pgIjF+MaLHWu7cWBUxjWN4TPWEZz
	URVoedl/4GXulSkqmOwvFWu+n/5vRPcFIpx4G96ZV0pncn9EHTWjopoU/gP3hDs4pxaS/MMckpN
	Nx4t9za+7+CNrGCE7VEOuUIzMbatGzdHkELfjQ1pKo6fsMVFCBeMJytEbXPXnsvtHQxTP1EJI7C
	vscg3fXIcwU3xltPfnrNzi1K3unBQWmjFsifKNF5e0zuvy9mP0vsP1qmaNvV2tVYoHleV4rfLEb
	L6YYJ/Ncp/uLo4sTuJ6zWdiO45gKNM4nvOk/7AQJWWRiD9y/eOkGc800haNnxedJBL10aEz9jEe
	1Wd7aHFYd4oiyyzMs8d+/TgOiJEA7Y1fLWL9t3QaUk2GXWuu+ZQqGo52ZaTDRdLkorJJJ+V6rS4
	axiXRHM+XBTj7mP4sDmSHwEM2+E0/T+SE4gQGho4NGRbDsRyS15QeFRDMGEEFZeb/RXWTZuZSjO
	m5cXPeqFcWGd6FYMraTVnkY
X-Received: by 2002:a17:90b:2e46:b0:38f:a81:15b1 with SMTP id 98e67ed59e1d1-39b08653554mr31657500a91.19.1788733297001;
        Sun, 06 Sep 2026 15:21:37 -0700 (PDT)
Received: from p1.. (129-219-8-31.nat.asu.edu. [129.219.8.31])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b314cfcsm22805334eec.19.2026.09.06.15.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 15:21:36 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: mkl@pengutronix.de,
	mailhol@kernel.org,
	linux-can@vger.kernel.org
Cc: s.grosjean@peak-system.fr,
	co+5e2bcf11e7027510@bugs.sh,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net] can: peak_usb: fix slab-out-of-bounds read in pcan_usb_handle_bus_evt()
Date: Sun,  6 Sep 2026 15:21:31 -0700
Message-ID: <20260906222132.3850994-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcan_usb_handle_bus_evt() reads mc->ptr[1] and mc->ptr[2] without checking
them against mc->end. On entry mc->ptr may already equal mc->end, and the
rx buffer is an exact kmalloc(64), so a device sending a full 64-byte
transfer reads past the slab object.

The two bytes end up in pdev->bec, which user space can read back via
IFLA_CAN_BERR_COUNTER.

Bail out unless both bytes are within the buffer.

  BUG: KASAN: slab-out-of-bounds in pcan_usb_decode_buf (drivers/net/can/usb/peak_usb/pcan_usb.c:563)
  Read of size 1 at addr ffff8880100921c1 by task swapper/1/0
  Call Trace:
   <IRQ>
   kasan_report (mm/kasan/report.c:595)
   pcan_usb_decode_buf (drivers/net/can/usb/peak_usb/pcan_usb.c:563)
   peak_usb_read_bulk_callback (drivers/net/can/usb/peak_usb/pcan_usb_core.c:267)
   __usb_hcd_giveback_urb (drivers/usb/core/hcd.c:1657)
   dummy_timer (drivers/usb/gadget/udc/dummy_hcd.c:2019)
   __hrtimer_run_queues (kernel/time/hrtimer.c:2067)
   handle_softirqs (kernel/softirq.c:645)
   </IRQ>

  The buggy address is located 1 bytes to the right of
   allocated 64-byte region [ffff888010092180, ffff8880100921c0)

Fixes: ea8b33bde76c ("can: pcan_usb: add support of rxerr/txerr counters")
Reported-by: co+5e2bcf11e7027510@bugs.sh
Closes: https://lore.kernel.org/linux-can/upsCxxaJjg2FJWhfCx6KjFXLlh8o4IhaHKJi@bugs.sh/
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 8fd058c32856..e87ed7657cc1 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -558,6 +558,8 @@ static int pcan_usb_handle_bus_evt(struct pcan_usb_msg_context *mc, u8 ir)
 	switch (ir) {
 	case PCAN_USB_ERR_CNT_DEC:
 	case PCAN_USB_ERR_CNT_INC:
+		if ((mc->ptr + 3) > mc->end)
+			return -EINVAL;
 
 		/* save rx/tx error counters from in the device context */
 		pdev->bec.rxerr = mc->ptr[1];
-- 
2.43.0

