Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF2954704D
	for <linux-can@vger.kernel.org>; Sun, 20 Sep 2026 03:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789876604; cv=none; b=tCiVTsYPs54h6Ogu2kD7nBHraxSosHW0xKAk7C6LtVIFaXoq+cAv8G/YNfzWRISBdiUSwjMSz5wZbsuCZqlC1NCkFl/1uCelTuy4Z9AfnpC6/p6hy7RVCiIxUfB+TgJZzmrS8IKkZAa9kN431mhaWyR1B5a5vQCeYNLMfz1ghwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789876604; c=relaxed/simple;
	bh=5xtl8vECwI7N2hTr71DbOthQhLvmhRGN/CfVoklgn3k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cwalY5dM25GtN2vlVHsFCceAmkhqfr9owmq1Obx+NJDIjfGM0dTIvKBN2xCto0cFKXLi84yX4xvIbkdZEolQja2HVJYvbaNP9+Z9jIlWRA2dFT3btsTEPtCkSebAMVhUfoK9AeW8Gw4FwyDI7Lt2dsHsr5Nle0rY7c9S0BjhHis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E56QnhEb; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E56QnhEb"
Received: by mail-pj2-f42.google.com with SMTP id d9443c01a7336-2df36461d63so3941935ad.3
        for <linux-can@vger.kernel.org>; Sat, 19 Sep 2026 20:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789876603; x=1790481403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=F4hmql1IX0BfyhMHnyF3zu0V+uINNkKnUB2MDx+f0d0=;
        b=E56QnhEbiTcs9Unli4lDyRv1RtmsbHVW6B1Ey3/ZOvY3bgddKSK9YY8LXKhTcyhqCZ
         i0p5sXxWnU860dbbaY0/2oboV8HkMHlqW0MooWrqQH6hHVxoqDaJ2oIJc5LHimB2703p
         wjH1oP1Xjz1KqBKK+DcGPr1URb7NtiIrLN0KEO1pqING4bKGjnnImIgTQ1rvswd1wFaB
         WBL1aM+Fw03rymtmwirCtVIV4HnVUirk6Pzm3oZd+Yo9kJf9B3me/KNEOaMiMbRXfcpU
         8hw7tP59rN3Nk9qR1gFbI5DwkZOyQNrsF8Ac7QOD+8GZGbY70wxo4p9sMsuNInMPyecx
         vjow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789876603; x=1790481403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F4hmql1IX0BfyhMHnyF3zu0V+uINNkKnUB2MDx+f0d0=;
        b=V0pZyOItP8pz7cWhALe+uqngdqRwqznRZJyhXj6j+ounsUmuUmV08pP/XXSZhBz2G7
         A2SknuPZ6G9rXEcZ0V4e6cKZutx8HX3DXkMCmIqp53trYY0omotSE2VDJ7xGQiXW+Yt8
         VPtQQbcXX7N/S6g+QxV1dkh0LGNG/poxu2D+iBo3613DZnmhCgtQEH99rbd4Tvjxkofn
         GQI5XPjlACXACtZxEWk2oz48LjvHIf1V6Dc6Xd+aLUnzEYEDTqqjiJOSq7kYckyLhxa3
         5eeFyalhdDobxjbfBBUY0+51rveEbhMJYF/1s5ndEaJY2lXLXwn51bVW5wf/aDo6I0V+
         A1eA==
X-Forwarded-Encrypted: i=1; AKwUvBzZmws4TUh19Ph0tKz0h8/CfU4dDwD2Ku3vNwMe9cdQUcGcG+BIbj1o8WS4RWqr4THE7/N8ZFSnfD8=@vger.kernel.org
X-Gm-Message-State: AFuF++mHHIECwC0+Ma9IPhIIjPr2Fc8dRaVvt9n2H4LpF8tXKJzk9+yo
	E0vyd2BxfqjkEzfhNCrjNL4rcN1+clC4BFz0tJRS2MCVBd0bowGWJx2b+BXqdxWm
X-Gm-Gg: AYBFou1OLYmTjIziO6ugxBssc22hnW6zogY/OsbucOYINMeVPLxqjPbnF2SBpg09tyj
	d+yApRzLr/1HQ2+mx0M15cXo3a5FD0L6woY1sl1fa9qfmAASAg5gNCY3sKW6v03TmOQIU/f+z47
	t75UrAbN+Pmam49/eWupeNiTD4NzJgvj0PyD6ybLR46XaGHJwim7ysbVH0evO4nFgt0ZpIsOEFY
	Y4BtegnVEOzt/e9vJVkMWS5PccTVeif/89eP09fpy8rXxa1O0+WqRvLAZWMOuiUBDF25ZrxYBsf
	fXgmczHVMnLFmgkNzSvp8LUEBpdouWHIk6hMqpPsXU/uP4ohH6Ip6L4GYDrGkrGqljQ7z/4BaEG
	YuVk9T0/mdgVfKcx6LKCO4vLs1LJikszO0va7g2IOmyGTLzyWFDVOB3atjh0x0BsVRcewS9GyI6
	F5KVFjMlU9KCyLjfg3xpfntTxD6fDgg2VrYTsKXMkauuZOxaLRzj5C5l06A0EnmTIv2dcAT62sQ
	fxbrD3LdRUGmsX5oH4m46bKmDg=
X-Received: by 2002:a17:903:1b03:b0:2dd:c0ff:e725 with SMTP id d9443c01a7336-2ddc0ffe981mr49870745ad.55.1789876602819;
        Sat, 19 Sep 2026 20:56:42 -0700 (PDT)
Received: from csl-conti-dell7859.ntu.edu.sg ([155.69.199.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2de217b3a97sm14689445ad.31.2026.09.19.20.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 20:56:41 -0700 (PDT)
From: Kaixuan Li <kaixuanli0131@gmail.com>
To: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Kaixuan Li <kaixuanli0131@gmail.com>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] can: isotp: check the frame type, not just the length
Date: Sun, 20 Sep 2026 11:56:26 +0800
Message-Id: <20260920035626.2581040-1-kaixuanli0131@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

isotp_rcv() separates Classic CAN from CAN FD by skb->len alone:

	if (skb->len != so->ll.mtu)
		return;

	cf = (struct canfd_frame *)skb->data;

A CAN XL frame with cxl->len 4 is CAN_MTU bytes, so it passes, and is then
read as a canfd_frame whose len comes out of canxl_frame.flags: at least
0x80.

Of the paths that follow, only the flow control one uses that length
without bounding it first, so check_pad() walks to 255 over a 16-byte
frame and the caller reports EBADMSG on an unrelated socket.

bcm_rx_handler(), j1939_can_recv(), can_can_gw_rcv() and raw_rcv() check
the frame type here, and can_dropped_invalid_skb() switches on
skb->protocol on the transmit side. isotp_rcv() is the gap.

Fixes: fb08cba12b52 ("can: canxl: update CAN infrastructure for CAN XL frames")
Signed-off-by: Kaixuan Li <kaixuanli0131@gmail.com>
Reviewed-by: Oliver Hartkopp <socketcan@hartkopp.net>
Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
v2: shorten the comment above the new check to say what it does; the
    reasoning stays in the description (Oliver Hartkopp). Add Oliver's
    Reviewed-by and Acked-by. No code change.

v1: https://lore.kernel.org/linux-can/20260919122852.1868961-1-kaixuanli0131@gmail.com/

Reproduced on v7.2.4 over vcan, one isotp socket per case bound rx 0x123
with RX_PADDING|CHK_PAD_DATA and rxpad_content 0xAA, a first frame in
flight, and one frame injected from a CAN_RAW socket.

	case                            stock     patched
	A CAN XL, cxl->len 4, flags ff  EBADMSG   none
	B Classic FC, padded 0xAA       none      none
	C Classic FC, padded 0x00       EBADMSG   EBADMSG
	D as A, with CHK_PAD_LEN on     EBADMSG   none

C bounds the impact: a malformed Classic FC frame from any sender on the
bus gives the same EBADMSG, so nothing becomes reachable that was not
already. D differs only in which branch of check_pad() returns.

No memory safety issue. KASAN was on for all eight runs and reported
nothing.
---
 net/can/isotp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -754,8 +754,16 @@ static void isotp_rcv(struct sk_buff *skb, void *data)
 	 */
 	if (skb->len != so->ll.mtu)
 		return;
 
+	/* check for correct CAN CC/FD frame content */
+	if (so->ll.mtu == CAN_MTU) {
+		if (!can_is_can_skb(skb))
+			return;
+	} else if (!can_is_canfd_skb(skb)) {
+		return;
+	}
+
 	cf = (struct canfd_frame *)skb->data;
 
 	/* if enabled: check reception of my configured extended address */
 	if (ae && cf->data[0] != so->opt.rx_ext_address)
