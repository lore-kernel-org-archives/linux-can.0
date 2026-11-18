Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.254.200.128
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794993611;
	b=p11ZlEsAxKLZItlgNhyXZpO9YWVMWVGcxx5UpopUrm5HNpDe5ucaMyWxDW338F23Wy09
	 jIoh7uJo9lR23jghwHxOuc403sGLZYQ0Qr3OThxRz3Qfy9gtrE//rcXu/BiXqONnYapnj
	 Q4V/KKXmM1s3tE9KMIdYk0jkjICDukOZw3wMMN6QFMUCFWqIKf3Cc5H2QHBjV9hXUz+VD
	 qjbOFSI06ZndScr23BCq4hm5FziLPHNbY5+mtdb115BXQzlSaGetYiHaC8h3N++w/exDR
	 XDBOiIK6k0nKO/1dsxa2HX0HYi721zLRI+z9fO2l7yDR2spjc+Dmvn6unwlWKl38I3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794993611;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=/RT9EeL7ji2hmMv3LbgGRfUUnKv+b38QkNlxTETqKtI=;
	b=GWeQiw7mqT/Z/Hb8VCJszLWmr0j0RHf62kGGrOpocSKebabNKEvdWv7O1BVXCrE1y1sA
	 WtKpWR0aOqMngYmCaML0vVRa7Ri2UNLjYGy0Qnd+17u+ll/lb8NrELdwXslg9mliySJPS
	 dlwYcVEoi2WNqcQoTl5lxj+hs2o7W4RIt2fteqPL2p5Hl261nptB6ChE7rBrMgIfd94r2
	 /K/sCxWSKZYimRoPXv8jIJeU8HV909pHehjY3iwUlAcLRkhUhP/5smhFfOH3UfpEL9gHU
	 R3xcTNmrhcg5owBcNNQFY+LwvkdtR3uMrpy54BupkjkjZl0+xiClnlHaKte1HYyRvIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniontech.com;
	spf=pass smtp.mailfrom=uniontech.com;
	dkim=pass header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=GwfvFYIA;
	arc=none smtp.remote-ip=54.254.200.128
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41679606A31C;
	Wed, 18 Nov 2026 09:20:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41679606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=GwfvFYIA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1794993599;
	bh=/RT9EeL7ji2hmMv3LbgGRfUUnKv+b38QkNlxTETqKtI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=GwfvFYIA7ln/PPRp6ROhqJRgvOG/tc001EEYQFYqFlIf891ktU3EmyYe8ZuvUuiQI
	 BMLv89ItbTiHIlmFitUGbtgZHFRjPZOylGafK6WpzUijgeafEDL+FIufyVnvV5zfg7
	 OmONp1Mg/DjzlrsjiGTE2bk4W/Xr5hUz4/COdaDA=
X-QQ-mid: esmtpgz15t1794993582tbf0479e5
X-QQ-Originating-IP: 3YK9IcMNkk1Tp97SCHpvldHX7zURvlorPi+rZRCCm1A=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 18 Nov 2026 17:19:40 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10124214066944920201
EX-QQ-RecipientCnt: 15
From: raoxu <raoxu@uniontech.com>
To: socketcan@hartkopp.net
Cc: mkl@pengutronix.de,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	corbet@lwn.net,
	horms@kernel.org,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	raoxu@uniontech.com
Subject: [PATCH can-next v2] can: bcm: Document cyclic transmission failures
Date: Wed, 18 Nov 2026 17:19:38 +0800
Message-ID: <75785AF83A9D9B09+20261118091938.3365557-1-raoxu@uniontech.com>
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
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MxdW4jxL6NvXjZ0qWDpfrMwtPCDrN5doXGNnERIuprLdTmHByeIp05Ou
	29YFNzrwFwbqEZcIMN2lPW9TrWOSaXI9g7Ny1Aql74YQPTuuaLFa/0qeVGUk6vUnYXOmsRq
	qkvVVdDTp9uSrjIyp59+bSHExqN26YlbS1a4e4pyvdj23B+bCZD+pd/OGXCxhIoaCxRo97U
	y4y7la4nLbW6raqjBw1nso02PYxPLvuasHheClIR7BAC7vM0ZMVCZjlwcgfVN+LcAMpq8I5
	0ElHw/rFY4PSOeeNIfUWG0ouenVStXaY+VDDOaA3/3ngtwRnG9IrnYj8WGmoU8w7CIQxBEd
	HGjoBqeIElK7usmt4+JMZy0uPUR55lpTSo5omo6KUoz4dfl8PRASePqpafK7Dm+3yNCU0r4
	PTbqBZ2FIGJ8rFc6K5MqrmtYWbPXBUZKJZpOz7CNx0s8ImVU81vJtR3mCjQ6PsuQ1Rrft0z
	OPVRBVhSwS6v0Bdx4DGYFPlvkJ+qPj/C3g9dKO6ijGE2KQVUxnKIO+fvwODP5bsXEdPM8YH
	A1rElu5kWBtNxCqR86PRFuGz47o22xjZRFgE0eECb8gq/KsMnbIOOpO5fg7hdkdEprF8eon
	2uxeaZkMHbOAqPZ1dFfUXeYSOuQGQIzEMHxIM0WKcmaGHyKGDKXPKaD5+NHBM9lVnLPpJfK
	rspuFa4THj4IrJJXOzb29VP/b0TLVwXAfRFku9qDhzy4OAqHk+66TxDUHtgmf1aHd/oS9yR
	6/LScF4EJ5FJXvo3w+9rG9qEcd2PfPqF41Y5IXuOMSglVwgGoqAUR/NAXJOdsr3YGR7DdQ0
	YvY7k361gyfwSnPn59Y0dvgDN6vYsLTAjFmEfLGn5M1KIb1h47s/DBlybPb3pPa+IN+B0Cj
	llWtB8A8khhXGGd0HBNmm+ymBRoj8Fz3mzkkevg8sBsLPyQaK2II7PCIW+io1X6lojvkpEp
	hpH3rGKrFwxw3j+QHWfjE587WhYIiUeQFA9K6bAcggVeVNujPHjm1XYBrmL9a44wgm7J+QZ
	SizK6dwiiMAX8I5wMv5YtrXy/2gw24ywxG+Wt/Gw==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

From: Xu Rao <raoxu@uniontech.com>

The CAN broadcast manager continues its configured cyclic transmission
schedule even when a CAN frame cannot be passed to the configured
network interface.

Such failures are not reported to user space. The failed transmission
is not retried by the broadcast manager, the timing remains unchanged,
and a non-zero count is decremented.

As a result, a TX_EXPIRED notification requested with TX_COUNTEVT
indicates that the configured transmissions at ival1 have been
processed, not that they were successfully sent.

Document this behavior to prevent applications from treating TX_EXPIRED
as confirmation of successful transmission.

Suggested-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
Changes in v2:
- Target can-next as requested by Oliver Hartkopp.
- Adopt Oliver's suggested wording describing transmission failures
  from the user's perspective.
- Clarify the TX_EXPIRED notification semantics and scope the lack of
  retries to the broadcast manager.
- Remove implementation details and redundant descriptions.

This documentation-only update follows the review of v1. The earlier
proposal to change BCM transmission accounting was dropped.

 Documentation/networking/can.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/networking/can.rst b/Documentation/networking/can.rst
index 51bc70748f75..ae47f40bf456 100644
--- a/Documentation/networking/can.rst
+++ b/Documentation/networking/can.rst
@@ -892,6 +892,14 @@ only one timer is needed 'count' is set to zero and only 'ival2' is used.
 When SET_TIMER and START_TIMER flag were set the timers are activated.
 The timer values can be altered at runtime when only SET_TIMER is set.

+If a CAN frame cannot be passed to the configured CAN network interface
+(e.g. due to a full transmit queue or the interface being down), this
+failure is not reported to user space. The transmission sequence
+continues as configured: the frame is not retried by the broadcast
+manager, the timing remains unchanged, and a non-zero ``count`` is
+decremented anyway. Therefore, a ``TX_EXPIRED`` notification (requested
+with ``TX_COUNTEVT``) only indicates that the ``count`` transmissions
+at ``ival1`` have been processed, not that they were successfully sent.

 Broadcast Manager message sequence transmission
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
2.50.1
