Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335D223ED5E
	for <linux-can@vger.kernel.org>; Tue, 18 Aug 2026 21:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787089838; cv=none; b=ZDwg/vxpOcNn5tyEZYEK/DjxqBygkbDVhiDDm0AhkAkP8YkMyvf/YQxKVBp/hwcGgArnGj+fDiWRdefWNWv1V/97h+SezfIHhzP8aHgkpiGkr6Vg/G6AeCfGTKKJQnw9vgPOk6rbsCa7PLq2Avu1+KV0pSppef0SCppeBnE0a7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787089838; c=relaxed/simple;
	bh=LbviQGy33/VrflqEdGmEC31Fge9f4eLgCpK74UV/Mto=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hm4QQmVtmG9rWtLJ2cOi0fkZIW9qujtRX7qHhLh3B5jGzb6SPrvY9P0N3HhMD/7nRDRrjtmY5giUjm9OxoAM66AqtgEjrtNP5wEhiobwccZvy05Rc2MIHdNkKSc0OiSNh1MitLodDyxind7BseA1hFuD+vjyKGEXXSKYuFErxR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com; spf=pass smtp.mailfrom=xbow.com; dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b=LbWe7fNv; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xbow.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b="LbWe7fNv"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38759bcd877so528139a91.2
        for <linux-can@vger.kernel.org>; Tue, 18 Aug 2026 14:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xbow.com; s=google; t=1787089834; x=1787694634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nB44X2BHNRtk2rWj3ofb0fstOoc1QxVcXE0ahPC36tk=;
        b=LbWe7fNvj+ltC538owXMeJyCdjc4RjHgMl8nm9qBk3Z0yzDKbw1HxXZBO/UhbDeSXg
         6HHUAEDv7RFEBwITlcrXOtX0u9IbIXmCxaj/9YZxO8pnmrKTBKDp2b1pqNnl/omK3TCw
         TxwyxAIyJVCyJ6Nr64BIbFBiMkc6dEB8jQv/Nx99bKzEEMoONJp0LU7Mqx2kTnOCAuip
         XKXaSFmvzaB3nJZksgla5aKG/maXScVXJoe8RbijisTCuWBUL8KnbxIfsHx4XFQHHFCk
         6f6CXJ338/lyJrwBgZ284TJGEeHRWY9oKMIkUkf3QbPP1KvSSDyIxGE2r/X8zBMbOEa8
         KCXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787089834; x=1787694634;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nB44X2BHNRtk2rWj3ofb0fstOoc1QxVcXE0ahPC36tk=;
        b=o1GbW1Y40EcNy4tfNwB9iAB444qLkFSpY3kGLtX3qboKXVz7SoCtPIjR4a32l7Viy4
         w0M1bAF4wOCof4+kukYnZqoCEuwrd58Q8jvYNnrHmRJLqA4i1D5/EDcp/mGLas+9N7Dx
         zgeiWPPPCl5W59qdfJ9kN6HyKEY8UdvmcEgrjzPRynZJxY56KE8csPjqAABaxYhDIS5i
         mJGACTtmSvPzzOqOnojb7bArzrpcM7UkS8q361KsoaewIPriorlfjjWOZDs7VrHdQOBF
         U63/HwDiGPVvaM8NHCzgrddfoV2gKetQ6J5b2z7DCq26CpG51HhgejXJ8xh8YDvpjvuA
         GITQ==
X-Gm-Message-State: AOJu0YzNx8Iuo8JR+tAPhBSqlxzkcQL8S0CdZQu0DaVf+pHDUHWfla/I
	tEGNfB3pLYJMqiz3ON+GDaSqfM+Vdjp2yGZ6Iu8Hb+/SMFddQhRB5gyhxQeLzAvmgmIk8XKhzQ9
	KZgoc
X-Gm-Gg: AR+sD13KfLAmlRMpXlNTUlOAtSJewfoswUZL9uhCLkl3NHjmmCqPIkYaFvfcPWw038l
	R0tsyQ56gO4+lurrEpF/VXxlV/rgnQwZEbZ5hzV75k0AUfVIUycTZ/ljpeUJm5K+fQ/qqWpxcE4
	vBUOiRGj2EhXHgQLPhgJqodUEQ4vdw4f/FXteFpPYDPL1zMoHKHrN7JfMq5mL75llxFqcbPRo9p
	6Yv2OmAHZ4AB8/W71a+Ph9T0XIFg7s8nFZ6vvpmRAWeekUi3oslmrmG4j4ognlxjaWhUZjBVHer
	K6dvxHmsZR/f7ZZA/Mlh/Q9gpg6IJbqr5mv5F5ifXC1pzNowvkf6nGL0Sx1eiIj4a0BD09NLGy+
	jHxNJocabaSbqxtzdPGS2gW8H6CVWn10GQwqIo5tu2T5TVIR9bmeWX5SIgqCZgNgeWvohBLnn9V
	P2n7FVpWUDAXNOvZ1XPlwz6nlLBqCBgQh8kYUyxUw54V8jsn5yHrLeRR4vqEJUU9kkalit8dloQ
	Ckm9Ex8dfXbcJfrKt+gvwSk6g00
X-Received: by 2002:a17:90a:da84:b0:38e:97f0:aa4b with SMTP id 98e67ed59e1d1-3957b38f768mr1186311a91.13.1787089834370;
        Tue, 18 Aug 2026 14:50:34 -0700 (PDT)
Received: from Mac.lan ([125.128.148.126])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3957fbbf8a7sm127600a91.16.2026.08.18.14.50.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 18 Aug 2026 14:50:33 -0700 (PDT)
From: Baul Lee <baul.lee@xbow.com>
To: max@enpas.org,
	mkl@pengutronix.de,
	mailhol@kernel.org
Cc: linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	federico.kirschbaum@xbow.com
Subject: [PATCH net] can: can327: Fix out-of-bounds write in can327_parse_frame()
Date: Wed, 19 Aug 2026 06:50:29 +0900
Message-ID: <20260818215029.47758-1-baul.lee@xbow.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

can327_parse_frame() assigns the CAN payload length from the DLC nibble
of the adapter's ASCII frame line, hex_to_bin(elm->rxbuf[datastart - 2]),
without validating it. A standard-format line only has to satisfy
rxbuf[3] == ' ' and rxbuf[5] == ' ', so the DLC nibble rxbuf[4] can be a
space, for which hex_to_bin() returns -1, and that becomes 255 in the u8
frame->len. A hex nibble of 9 to f is not rejected either, while
CAN_MAX_DLEN is 8.

frame->data[] is the 8-byte payload of the 16-byte struct can_frame
returned by alloc_can_skb(), so the data-nibble loop writes up to 255
device-controlled bytes, 247 of them past the frame and over the
trailing skb_shared_info. The length check before the loop only requires
the line to be frame->len * 3 + datastart bytes, which a long enough
line of hex and spaces satisfies. Freeing the corrupted skb then faults:

  pc : skb_release_data+0xf4/0x200
  Call trace:
   skb_release_data+0xf4/0x200 (P)
   sk_skb_reason_drop+0x40/0xa4
   can_rcv+0x6c/0xbc
   __netif_receive_skb_one_core+0x40/0x4c
   can327_ldisc_rx+0xc8/0x140
   tty_ldisc_receive_buf+0x48/0x60
   flush_to_ldisc+0xdc/0x1b0
  Kernel panic - not syncing: Oops: Fatal exception in interrupt

Reject the line when the nibble is not a hex digit or exceeds
CAN_MAX_DLEN, as the parser already does for other malformed lines.

Attaching the N_CAN327 line discipline requires CAP_NET_ADMIN, but the
frame lines then come from the ELM327 device, so a malicious adapter
reaches this path with device-controlled data.

Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>

Fixes: 43da2f07622f ("can: can327: CAN/ldisc driver for ELM327 based OBD-II adapters")
Signed-off-by: Baul Lee <baul.lee@xbow.com>
---
 drivers/net/can/can327.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/can327.c b/drivers/net/can/can327.c
index 90f5e35f3c8f..c76a6378d4d6 100644
--- a/drivers/net/can/can327.c
+++ b/drivers/net/can/can327.c
@@ -395,6 +395,7 @@ static int can327_parse_frame(struct can327 *elm, size_t len)
 	struct sk_buff *skb;
 	int hexlen;
 	int datastart;
+	int dlc;
 	int i;
 
 	lockdep_assert_held(&elm->lock);
@@ -460,7 +461,13 @@ static int can327_parse_frame(struct can327 *elm, size_t len)
 	 */
 
 	/* Read CAN data length */
-	frame->len = (hex_to_bin(elm->rxbuf[datastart - 2]) << 0);
+	dlc = hex_to_bin(elm->rxbuf[datastart - 2]);
+	if (dlc < 0 || dlc > CAN_MAX_DLEN) {
+		/* Not a hex digit, or more than CAN_MAX_DLEN bytes. */
+		kfree_skb(skb);
+		return -ENODATA;
+	}
+	frame->len = dlc;
 
 	/* Read CAN ID */
 	if (frame->can_id & CAN_EFF_FLAG) {
-- 
2.50.1

