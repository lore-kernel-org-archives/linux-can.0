Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.204.34.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794288236;
	b=EfGLjAiw/RQQs2wOMazDhnkGVfL3FM12Fo51TcCBp0OFyzoCsz/eI11/A8UYIjJSdCGr
	 TB9a0j9TqL+RvHVCAHnCPy5w/TaY27urKPZ+erGQ59e8OmFATA4NPSft8sZ5oukn009w8
	 PXWjfdvPTovZ5JM+dOIFe7mzu48//nGex81MlZK1Yqo3w+lewo6+IMdxXPDqglE0UkQb5
	 ilXhGki+KvZWAXMwPy9NP/gwQHzaAYPQQG4+MWGDTyMRn438NwwPnLbohEN3H6JQSyAsd
	 tN6lqLp0q7rJDjHyM4mKKrcILb3pJA4+cNU02JKAHc1L+gH4TNt5ibqGVB7e9hN3JIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794288236;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=sZoEub8xC7/KZjauTyVsYrj5FvRAI2frkkyKZ9meGEg=;
	b=4GMYeosvl3d/6otX7uYpTryUA6lvhhzUarFbOs2HcZAcOIbbxHDMq7Ecfbqn84f2dVZz
	 D4EBG0IkW29qjLumRlf4Jg83p/Jhj0WtDiOyb5Diygx//l7gUEZZbDXtdpRGZmeS9rXPv
	 KM9XXekZ81sx4WI35c9SiDqvkoLwnmaI0xAQ0RWuXjFR45wyEVnHu0cKkF1ZmSMOAnwrn
	 Py7lPSHQVWpUsxDclJWtrXwbqiDJRTEMxNBSLGgjvOfzHG+ZUm6IvEDDbu7fkVymmPbnY
	 9un9Msa5zUK30Bi6syY2+SvqWEnjv4an7VVbXRiBcqqxQcIJ8ImpEDAspRiq0N5TNiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniontech.com;
	spf=pass smtp.mailfrom=uniontech.com;
	dkim=pass header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=W6J3PR2i;
	arc=none smtp.remote-ip=54.204.34.130
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDEE606A31C;
	Tue, 10 Nov 2026 05:23:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEDEE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=W6J3PR2i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1794288213;
	bh=sZoEub8xC7/KZjauTyVsYrj5FvRAI2frkkyKZ9meGEg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=W6J3PR2iklzI8SzMwJ3+ms0BjYuazVHrc5XatCfhjJy+jfM7U9NPQSXPxh6FmU2Av
	 QK2dUVHrYJQb5DQ1mT8PE30iZBnxxThRBXdhnT0sC/D8av/QbXI41FYeft8RJks2KH
	 IAGuNKouSF09i9DWq798XVzRI0339+NG8BNsDiHA=
X-QQ-mid: zesmtpgz3t1794288198tc4852c7d
X-QQ-Originating-IP: 2bpRC/v0khIWf3yMX4dko8q4kxZ/hahK1KFarMNJ56M=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 10 Nov 2026 13:23:16 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10700453655678917406
EX-QQ-RecipientCnt: 5
From: raoxu <raoxu@uniontech.com>
To: socketcan@hartkopp.net
Cc: mkl@pengutronix.de,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	raoxu@uniontech.com
Subject: [PATCH] can: bcm: Account cyclic transmissions only on success
Date: Tue, 10 Nov 2026 13:23:15 +0800
Message-ID: <45A9B6D8611C63C9+20261110052315.253367-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MW//binZVb2sdQ949MHn+1Me8jWsxNo38L+ppWCtouWVubvSSJHpZ0Az
	SV3b4eNhtkQYNkycqY+SbSiDEyeoirQ9Gmq4cQkuM4WAVK2+0JhKsb6P/T1qYeJY9ZDMz8y
	80uYqMJbPdVzniA0L4I4NjkRd9B22rcjQ2GgCM2vqP/axmFYJQygkGAxi4dnVN4aO6sR10J
	Hyztr2QUlEoQm4MYRK+iizaTe0PPzfrtpVXY24GyFOLiE1az9eDNXZVcnqzTWtC838fQzsN
	EO/FP2uO5tDvpslyNsXAWgH+DiJ0StW/EI7WiM/aRk7LsNzEbftgRaWiyDuTx2oIHe9T6L6
	dbjiNd/WrSVNIOlLCY4WyzHsZbPxWQM9yuQQeYXD7dgS6rD4VgpHsfwYXDEdfwFsBjz+9n7
	FHxJ0Q8SgfQ0vTvVE/FCjKkWW1gndMnbN2hP8qklE8iNTFVKAspojBDMxqPIm7umHmMQjV0
	RBpxs33Z0ZLBYhsxMUNV8UQMDilgQ2Jf0mmsIEsEBzYOBXPqr7bUZsuG0hsOOPuE3bBudTB
	Bl8KB3kTa02iJ70tng3lXixuHISup4FJ9z5B6OhmA0aS3s+uMZjrd0YNoQTlh+WL5qnPVPJ
	/1mMAdrvux2AFHFaFIHQmt0ulu9XXlCLRbkGMhDaU4Q7YIFXYsq3bUc9p8bopPlVYb16mOp
	5jfDv/W4GyjHeudNnZiNiMpQWs08jKCslI96YBaYzq+YV5VnFv0cfJJ1QmOKdQTSodGT78U
	46no12gRcbIGKJIeD1ACLk2+sSvoCYq+jLx7QyG9E0Tw/8P8joL4m/+igj9i0zuPB5C3KJg
	VkpH2AyGxl0Ru0IiH4qfotICBfJJzWLRr8nyFRQFXjHVZlDF/x3U3Uc9NaScdcT9j5SBleX
	IsOr7CIAtYttgMK55ShV9horu9/DjE9Cq787q1Qp511H+s8qMuVjLPlI+l+dz5iYLkZccFz
	1uffgjXkLAo9GN+1YJLFnjSjTCnH6aDLIaPvZt8pfKxeDm4yEOJr7kZWAC9jqhNIZ2KE5vT
	INtA6g6YCKtDYx6KTd50WBOewbLY1RmF1M1+Y7GVTseSzLBJJ1XnjQhyZW9nyC5zfpPfHhm
	A==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

From: Xu Rao <raoxu@uniontech.com>

The CAN broadcast manager advances the cyclic frame index and decrements
the initial-interval transmission count even when can_send() fails.
For example, taking the CAN interface down makes can_send() return
-ENETDOWN, but the timer still consumes the configured transmissions and
can report TX_EXPIRED without sending a frame.

Only update cyclic bookkeeping after can_send() succeeds. This matches
the existing successful-send accounting of frames_abs while preserving
the concurrent TX_RESET_MULTI_IDX check.

Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
 net/can/bcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index 7bd2aa39777a..cd66b23bf95c 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -375,7 +375,7 @@ static void bcm_can_tx(struct bcm_op *op, struct canfd_frame *cf)
 	 * we were sending - a concurrent TX_RESET_MULTI_IDX means this
 	 * frame's bookkeeping belongs to a sequence that no longer exists
 	 */
-	if (!cyclic || op->currframe == idx) {
+	if (!err && (!cyclic || op->currframe == idx)) {
 		op->currframe++;

 		/* reached last frame? */
--
2.50.1

