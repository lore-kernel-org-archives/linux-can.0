Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E10238C2A
	for <linux-can@vger.kernel.org>; Tue, 18 Aug 2026 22:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787091505; cv=none; b=P50qiKu6a9vJqOLjf9InDcpOBGqHRk9asMdx3/48ogF29nrWwopStKjQmgz7zBaxYPzcGHl/GFRASP8oy9HAOVmOqkLTrXVi8sp2ZndZrcUC3bNoBsYwwmBX0CWnFpaDFyVQlSh44coG6G+rnHScLI14RcI8vm3iXBCr5CAcsuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787091505; c=relaxed/simple;
	bh=xeb+tFMObI7h3eVoQvB19uHowJe0ECQUjezaWgqLXiE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SWswKvK6ttu+IQktGWuuHp2CTl9uERaMHxXHlVXpxdEMyO+fnk1+iooQQ7ub/CuEt3dBa3n8TKPEm7Clpc+JFkoSO2Q+WU94M5GAuly2bmT+AfsSSnD44bv2gKaMamOb5ztWIjW2BZE9hdsx5Wep7OPA3ZTn8WKR7cuEg7SO+9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com; spf=pass smtp.mailfrom=xbow.com; dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b=lUISu/hH; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xbow.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b="lUISu/hH"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38759bcd877so552515a91.2
        for <linux-can@vger.kernel.org>; Tue, 18 Aug 2026 15:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xbow.com; s=google; t=1787091503; x=1787696303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=d0XU4Swy3+99fCdFDFJ5dFoqIG7hfBf1CedXoWdbxRw=;
        b=lUISu/hH9KlXRzeS7bl8bHNUc/F828y8S70xyKZYg5ur0/gHx1w7/SDkYPgvAOf/qn
         QCBN9NrIeRR4DzKawhwzII0RVeusMrw+z39qgMrxVMqqI8s61hb/mrBvlLREVaVN83O8
         mOrpMi6yYge/c+zU/dF0TJDuvAalQ9FtCJ0/x8PnvPhGlqqjsShr2tpEw0GmGI120yWv
         UbMBmWLLW9AC5RFNIzPocMGjGus1w0U/iCNwN3Dlhr2dLFuEhTUyCZ46uqOVIvFbfB/g
         VghPYclYMyyph6vuDXdIqapTHEdn47gBzorSEvn97+hcP+51N/vzq/4hEZeFnDovAnbu
         1FZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787091503; x=1787696303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d0XU4Swy3+99fCdFDFJ5dFoqIG7hfBf1CedXoWdbxRw=;
        b=dF4S1eCfBwv/9QywPiHKM2i5L1zUl6NsG/kh+RndmTVbwLECEUQLcf4IdDtFBBT8QB
         NXH91r14D5i8m5NAxAQkPXY9C5Ri8Gk49cTXUzRB90TYmC1/RJoX7jl2n2LBcm6EF5dd
         qguYUczWzw7Z7D28GkMCpgaPaGN7Ay2gJ+IJltVM2suVQzBVB5UKWPYkRtbw1oNeAPdf
         xKfFKkBalLiP5AqoiL7n3C+GZHw9BU2sGC6rkUEK9FWenF6bjgLtawz8F9NHhaAh39mA
         8j5etQV4VZ8fP9q8wRyopuuIL3+DpV2FJajjWlApdToi6b6r5cpKhQK6YKBmBR46hagC
         alnw==
X-Gm-Message-State: AOJu0Yxn6WhLDg5qu64GRrzpDZqXu2vUPvW2g0KxMEg5zQnSD1EHZ8UI
	9DjYckvd7a9aVGTx6u9r1UxLOzU9g0ILp8CyOuKUxtiNjCN1Tprr9PH6hx0hCZX7Lso=
X-Gm-Gg: AR+sD13SklcmylkjYpoAhbSCAcQpvQpFGljIp3fVL5BIi/XnuHEMYJ71Jd/VQ74ZIEM
	++WON/LUaytfheJyqIXzHLm3HAMMxSPgp9FWihduLTSivVi2PyjoYEQRNZk6MNQBGueyEzqxLFC
	R+zfGeTsjKp+nUp01HIIY8HWr5Qw3z3gLsyR/hgHwhhXRzukyMJ1x5VscMWv7KhtSw/ymC6N3/R
	Gni2a8hiUI2U/srU5s7b0tv7bm49XKhjZOnOwtcQuTBRMZY5NnwD/rqL7c50+PYd0CJ7/t6n0mh
	nPMRn8Zex/WpKjyjmLzjoe9aXMXogSViWIFeRjxc+yf9rVCb3XrJ5eNMAYuAGrQhIPYBd6tFLk4
	iTofHaY6J32JByKsA3tvBXlC0OrYwps/pHyLGbY2iAQn6d80naEBv4K0lV+oFPOkCnQdUGGCtym
	KmjbiAP5c98497AZzjXPbuFAHBN5QVuay8P6PzRjU49uGlPhRMrTZUay80GvrdWq8U1MIhZnxvt
	UEJvYoErXbcrSXJ7ouj0t3OrK3F
X-Received: by 2002:a17:90a:d604:b0:38e:97f0:aa4b with SMTP id 98e67ed59e1d1-3958127a5aamr68823a91.13.1787091503346;
        Tue, 18 Aug 2026 15:18:23 -0700 (PDT)
Received: from Mac.lan ([125.128.148.126])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3957fbbf8a7sm187194a91.16.2026.08.18.15.18.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 18 Aug 2026 15:18:22 -0700 (PDT)
From: Baul Lee <baul.lee@xbow.com>
To: max@enpas.org,
	mkl@pengutronix.de,
	mailhol@kernel.org
Cc: linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	federico.kirschbaum@xbow.com
Subject: [PATCH net v2] can: can327: Fix out-of-bounds write in can327_parse_frame()
Date: Wed, 19 Aug 2026 07:18:18 +0900
Message-ID: <20260818221818.49430-1-baul.lee@xbow.com>
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
Cc: stable@vger.kernel.org
Signed-off-by: Baul Lee <baul.lee@xbow.com>
Reviewed-by: Max Staudt <max@enpas.org>
---
v2: add Cc: stable and Max's Reviewed-by, as requested in review of v1
    (https://lore.kernel.org/linux-can/20260818215029.47758-1-baul.lee@xbow.com/).
    No change to the code.

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

