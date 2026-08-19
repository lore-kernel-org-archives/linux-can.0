Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B031E3C98A2
	for <linux-can@vger.kernel.org>; Wed, 19 Aug 2026 05:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787118128; cv=none; b=H1rwBOg6aTrzLIiZadfMgN23LSW9weJLnHvlqv7BigvVR/duNp/LELXOP0esMH+N6DGKLym5c5DwkkXZiSYD+oL/pPlYcVfzYB26F+NmxDSOs0HOyoauYpaiY99qwWKsjwvLVnac2wECz7M/BTfkxvZyMyR6HMPvDbAUQ0re/I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787118128; c=relaxed/simple;
	bh=QE9C4a2SKiQIF9oFg+qY0uuRyvsD4L7tCcsdTejkaDw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AkfjTWIPvO+f2pfU2vzRHTt/E5XikSFA7gihOAJI26BYCThPsWnZvI+elRz3Afgc5bHaAL5YSRIp2gndOoWqNcURbGYpawy1nJP9J3T0tFcN0oKDivePiOT0Vu50sg0t78omkVJaKWtQ8elDuocMI/NnrdsSRvUeLPSHBb+YFQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com; spf=pass smtp.mailfrom=xbow.com; dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b=k3f6v7MP; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xbow.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b="k3f6v7MP"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-84e0688b7e8so572952b3a.1
        for <linux-can@vger.kernel.org>; Tue, 18 Aug 2026 22:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xbow.com; s=google; t=1787118126; x=1787722926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6YEZkr3wdZlff5LqCyllrwAL2QGPkgIQWwMDmAIlEzc=;
        b=k3f6v7MPG6K2pG45d3myTJYp5fBNj5uPw8igl3GuM5uf8+imxyoY87YSqptOkaR3bR
         EXyuoBvzQMHPZnw4nm8PveUCTHD0k3xVuYtixblfAgHOiy6SBF7Efb6fl09tQx8m/NbW
         bfhP6RN4z+F+HWYyxz/61x6BUSKRttaj1Rf2nC4Pi3gKDoGUD1lWDxGZtFGu31dZZmDm
         /WKO041JmS+GByugrMIc0eMyt4LTqrDWszfZaO/6/uzEHdoI0q6Bip/Qjft/4JyHxxdO
         V6OzH0R5pOsZJta/oYymvwL8jGPTnDkYmwd/9eTHHbnPFL3IxvPIKI7mcKlVcwYdbOJj
         id+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787118126; x=1787722926;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6YEZkr3wdZlff5LqCyllrwAL2QGPkgIQWwMDmAIlEzc=;
        b=YWleZzols/G5AY2jvFyK4v9MayoaiHtuHO8dniAmmkRRgAty9uUIqVdZwIPYAWWG8E
         lD9OQoM4CjFj328+qyDgMWyCOOMGQJ5h/zyxfsugCAL20NGvu5FFIT9Wa2QsOZsXeMjL
         v/gVE+nYTkfHTTUa5bCUqu7L75fhQsEVwXfgmwRiXW7f0hrfReUOKPlgQL3LMpNnIsSW
         G1ixraQ2e8FioI6keWQ2gold0t0NMjQs37Y55rxn6TA0stDpeluxfn/9eiyJLT6mSs+q
         T7ET1f+28yg5shcJCOa+pRUw4BlH9bXpyvTFAfVujMAj/t99hlJijRV2iTn2ES3EhIeL
         cGmA==
X-Gm-Message-State: AOJu0Ywhh4/I9TyB0VIH7YyILauALsn/0EeiQZT6My7RR1O/axJXH50M
	QSTLdu7zuPTImhJZeX0loiR8/1d10Z61ZylnhhLsIE2eKJCyRjuUELU2We4Ta1Gr9xQ=
X-Gm-Gg: AR+sD112LlPThqJNtFd0teJUPxP6+S7dYiAdiJSLgd9Q3PbrJBRpMgH5nDR14P5NmS/
	mlpxRmu1GQOE+9ybZrUW4Un2nRnanVQLNTgw19RU+EHIBjf4weiYl4/6VKfdSBnLRJmgzMRoAwk
	nvxg1bNlidaY6ACWVTOJfZRAi3ny01oiQO7qc7f0xrLGr4lSaoHakQl6pY7jKsJGy0iwpPAI5Hd
	KyQbkTrQrR/zbouwPLV7nPAv5fHwwYbEbmCMeB1awtSjIVhPRJ8bdZv+Hh4FmshwHE9wKHdXSvt
	/gxiXY39eHDU5MpIt6dQTsptTJsAf0SxGpTFnlaFxIKiDdoUbfXY5sxaT1RUknZNebLangsVhLl
	oEGx4yYfsaZUE8a1X5R1p4DwlWkL9JxO39F3tq4Qk9IIWD/areip6UToRwHWTZf4Kuy9TDV5ZfG
	EOq+7K1MVxh+WgJKMogBWopV87nuAnm2YUVkd+n2FvvLeFq52qfECf4wO4qjQWyLyPI7hCmSzgL
	smTdQ8bSCDort65MzLddtZFW6SN
X-Received: by 2002:a05:6a00:179c:b0:848:2b8f:c9d7 with SMTP id d2e1a72fcca58-851d3a87889mr3230385b3a.18.1787118125727;
        Tue, 18 Aug 2026 22:42:05 -0700 (PDT)
Received: from Mac.lan ([125.128.148.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851d3389fcfsm214485b3a.18.2026.08.18.22.42.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 18 Aug 2026 22:42:05 -0700 (PDT)
From: Baul Lee <baul.lee@xbow.com>
To: max@enpas.org,
	mkl@pengutronix.de,
	mailhol@kernel.org
Cc: linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	federico.kirschbaum@xbow.com
Subject: [PATCH net] can: can327: Fix stack out-of-bounds write in can327_handle_prompt()
Date: Wed, 19 Aug 2026 14:42:01 +0900
Message-ID: <20260819054201.67294-1-baul.lee@xbow.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

can327_handle_prompt() hexdumps the frame queued for transmission, two
hex characters per payload byte, into an 18-byte on-stack buffer sized
for a classical 8-byte payload. The loop runs frame->len times without a
clamp, and frame is a struct can_frame copied verbatim from the skb
passed to can327_netdev_start_xmit().

A CAN XL frame aliases struct can_frame such that canxl_frame.flags,
which must carry CANXL_XLF, overlaps can_frame.len, so it arrives with
frame->len == 0x80. can327 is a classical CAN device, but
can_dev_dropped_skb() only rejects CAN FD for a non-FD device; for
ETH_P_CANXL, can_dropped_invalid_skb() checks only that the frame is a
well-formed CAN XL frame, not that the device supports one. The smallest
such frame, CANXL_HDR_SIZE + CANXL_MIN_DLEN, is 13 bytes, so it also
passes the MTU check on a CAN_MTU device. CAN_RAW rejects it, as
raw_check_txframe() requires CAN_CAP_XL, but an AF_PACKET SOCK_RAW
socket does not go through that check.

The loop then writes 128 hex pairs over the buffer and past the end of
the stack frame:

  BUG: KASAN: stack-out-of-bounds in vsnprintf+0x550/0x83c
  Write of size 1 at addr ffff800085407a32 by task kworker/u18:0/36
  Call trace:
   vsnprintf+0x550/0x83c
   snprintf+0xa4/0xe0
   can327_handle_prompt+0x5c4/0x69c
   can327_parse_rxbuf+0x618/0xb50
   can327_ldisc_rx+0x118/0x1c0
   tty_ldisc_receive_buf+0xc0/0xe0
   flush_to_ldisc+0x11c/0x278
  This frame has 1 object:
   [32, 50) 'local_txbuf'
  Kernel panic - not syncing: stack-protector: Kernel stack is corrupted
  in: can327_handle_prompt+0x66c/0x69c

Clamp the dump to CAN_MAX_DLEN, which is what the buffer is sized for.

Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>

Fixes: fb08cba12b52 ("can: canxl: update CAN infrastructure for CAN XL frames")
Signed-off-by: Baul Lee <baul.lee@xbow.com>
---
 drivers/net/can/can327.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/can327.c b/drivers/net/can/can327.c
index 90f5e35f3c8f..396db56775a6 100644
--- a/drivers/net/can/can327.c
+++ b/drivers/net/can/can327.c
@@ -624,9 +624,10 @@ static void can327_handle_prompt(struct can327 *elm)
 			snprintf(local_txbuf, sizeof(local_txbuf), "ATRTR\r");
 		} else {
 			/* Send a regular CAN data frame */
+			int dlc = min_t(int, frame->len, CAN_MAX_DLEN);
 			int i;
 
-			for (i = 0; i < frame->len; i++) {
+			for (i = 0; i < dlc; i++) {
 				snprintf(&local_txbuf[2 * i],
 					 sizeof(local_txbuf), "%02X",
 					 frame->data[i]);
-- 
2.50.1

