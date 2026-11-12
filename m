Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.254.200.128
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794450721;
	b=SxAkBovN7Um1CQHTfHx/LZJ1O66xUoJbPMvIGaZ8Lz/hzkHBPOdEJlI7qYCKRAg6CFj2
	 cmiTc3sjR69Ma8jHMjebdvLVyG1cjEXrl2gt29SnsY0KCk1FBqGQvd1TNHDGsZIsQOV/v
	 TldOWMwcTVeKhbCZurX77f3Qgx2Va1YiyDkqGvmCOjrBylC8/d2MJIcoK0F7OxTkAV0xF
	 APX1ZyAP1zxGAZmJzEzh7H4UeG3Tnwof1DvJCZQ00sh3czQOLBFoZOciUrfFl2FjQ/z3B
	 YeArq0XGY3GSfmq9ODr9RnQvL3iJzzChRrMbsewuoljQt1NiTEpFv/jj7NitKITBA+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794450721;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=nV2murFzK6Id3OzsA14Tj/XTXZ8jVdkIsvs9wKWBvWQ=;
	b=yWYTsRkcYQZ0Ma5XwHjXLydqFxniCRqfhGOEd3HePjfksUiSEo033TbEXCgIXc4SZbFq
	 TVqogA04ow3aPPj+4YUPbAeQ+81kmXcf2s8MzK7gsdLB0701XimX8wWMOutzzkO8GdImj
	 jhk7Mq6Ow934LTU1VaHEg1uI/RSjIxWB5de58aww+yZ5QkjLPjbhYUyosP65DqlrlG9AS
	 AS7a8tULojz1Ii57N+Oag36aAigf4QF7wlQZEKYqq+DuOr2o+QDYaxggpc5KKTrSgV4g1
	 CiTsq2nymivkfENj97OPvjSxXEtu6WGCL6Se7kXF0Bc4pKr9s/4dDF8bAizSE//sdfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniontech.com;
	spf=pass smtp.mailfrom=uniontech.com;
	dkim=pass header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=iA4r9sjF;
	arc=none smtp.remote-ip=54.254.200.128
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CA5606A334;
	Thu, 12 Nov 2026 02:31:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1CA5606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=iA4r9sjF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1794450682;
	bh=nV2murFzK6Id3OzsA14Tj/XTXZ8jVdkIsvs9wKWBvWQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=iA4r9sjFtLoOHwjoIc1jZ8Z5HTvb/1yn3Ycmc3TZCOLXtmIt1G0bVGItfdWIujkak
	 Z7IAw0HVIHFavJfmXAsMOQA+vRTPDwOL63ofuaOOeeQ+8Vdhfaia5H27WrjkpBXIF8
	 dFJJ/WVz91lb+MCVzV6sDmCf7CNLhBA2e4+YCicg=
X-QQ-mid: zesmtpgz3t1794450677t2a70f49d
X-QQ-Originating-IP: LPLIix0d1dOs8h+/ort2k/3s/9IXSF8BgFpyPjy3Svs=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 12 Nov 2026 10:31:16 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 13082129355398645022
EX-QQ-RecipientCnt: 8
From: raoxu <raoxu@uniontech.com>
To: socketcan@hartkopp.net,
	mkl@pengutronix.de
Cc: linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	corbet@lwn.net,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	raoxu@uniontech.com
Subject: [PATCH net-next] can: bcm: Document ival1 count semantics
Date: Thu, 12 Nov 2026 10:31:10 +0800
Message-ID: <12B691026195694E+20261112023110.1234039-1-raoxu@uniontech.com>
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
X-QQ-XMAILINFO: OKhYnE1LzMsBiVblgfzh1Ihh/jzNbaxbRiqrW0PC4RLzVRcns3iUQkMD
	bEav44c2qm4jE7HAXlcZWNP1Zl1/DhU4xURC3TSuZrzLFWJpsDFFQUxwAzFmbppEjkMUhYQ
	1ASZmWinIyYRGVnHYgEIc0gDKfaOcyr1TYsl7CeT8AvaBwtUd2BGWrDc5ATINyloQFAw/Jn
	cUohm/osbJn82w5OYvknCjMqgFyBa0WRcBRF4mKZ9QK1hfeyOpg05n93AI7jGSPCi+KJWjt
	X90SENk2rVVDWRhsYLigYO8M2h7hKZwW3gv5Vmmw68R1pivEuCIftN5HhUVKgnV9vK2NfEJ
	cM5nZElAqHYl+rW50xSowz+vy2Z+HDX5FnlKIq+V1pPSqh0bNSepdbVM/bI0AthXz4/0+f3
	VUYrwEzIMIYAtCfbv2CeE77rmZucno7DcO5M1q+kaU/unoIe6tLN3hDy8/xQj4VRHrAQwsW
	7FZBvPF2DeFnm5vGuyF7bRSWY29ZhPma5179bzziN6ojk8Z+Nqg1XOh5FFsUCXKNEjMnGzw
	e6CvxsVtE080wEadeiFNlhYLdyRiQJixmnq/SNL4bFlhu6e1d/HyEsaDqK5+46tXWjPAt3w
	UNgNRPWyunU2hwR5VTxgxQsI0mWwWCfl8T9HIxgin+pCu3UJ+6GdN1z9oZHB0YPZHFeUEgW
	JZANyidvKVectLw4XhKtdjszj5RPN4elCEY7C2GynFhzwRyOfqx1DlpzHlYjIB5E/QO/br8
	x/0MUgkgfM7ve/aGOpLxEIpjgg1eGPtqVdSjkP4p/6ux9bMyxq5DXB3iYrOAjl0DMLKXr09
	bT5pbg4cB7o/j3BYuOxO0NX7TbBsxW6iRIWJ2DZZjoVhzX/6g+vlDzzrlvpHIHkSvNvLJZe
	a6B0QIfT/qgTEyn5QHvopR5saJHLbyux6ouv/sJzgGzFHVOHA+Oysi1zkt99n9nGkrF1+91
	BZ4hJKrIuI5hNGAxzTHx89z0nb0jNTQSaA2nB96slCJa6y+ihGMQ/0/xj6DwLW2zUxiMB2H
	3Od4oPvNadHCGNCPWlD7oeCvFYcAcvzaWFCgknNw==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

From: Xu Rao <raoxu@uniontech.com>

Clarify that count controls the initial transmission schedule rather
than counting successfully transmitted CAN frames. An error returned by
can_send() does not prevent the counter from advancing.

Describe the transition to ival2 when count reaches zero, or termination
if ival2 is zero.

Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
This documentation-only patch follows Oliver Hartkopp's suggestion to
clarify count semantics in the discussion of my earlier patch,
"can: bcm: Account cyclic transmissions only on success".
That code change has been dropped; this patch does not change BCM behavior.

 Documentation/networking/can.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/networking/can.rst b/Documentation/networking/can.rst
index 51bc70748f75..840d840665a4 100644
--- a/Documentation/networking/can.rst
+++ b/Documentation/networking/can.rst
@@ -892,6 +892,11 @@ only one timer is needed 'count' is set to zero and only 'ival2' is used.
 When SET_TIMER and START_TIMER flag were set the timers are activated.
 The timer values can be altered at runtime when only SET_TIMER is set.

+For cyclic transmission tasks, ``count`` specifies the number of
+transmission attempts scheduled at ``ival1``, not the number of
+successfully transmitted CAN frames. The counter advances even when
+``can_send()`` returns an error. When ``count`` reaches zero, the
+transmission continues at ``ival2`` if nonzero, or stops otherwise.

 Broadcast Manager message sequence transmission
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
2.50.1
