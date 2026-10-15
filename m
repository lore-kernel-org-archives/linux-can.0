Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC67386C0A;
	Thu, 15 Oct 2026 01:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792029231; cv=pass; b=Cw3sBZEfC+XZ4fuyT7aMw1YxKLAI6Tl6ivISy+t1kZ55LnpYNB9DpmcgK4TZPlr/HvjeMXjp5yOWMHjgYOYwJFE8H1QcHw5pKHKPMY0VFuDuSXNCyGhvcCzuozFW4H1EC6S6Cx99JcHVefCRIOAHEO1dt+ieW8pdNcJW9CNkoKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792029231; c=relaxed/simple;
	bh=5L8Rq89isI1n20HoSkvg4t/6OMK+z9wSrWBPPC71lsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aMjan1WyYLcO5BPyQ6/maLrw6phsitbKu2MpSSlks/gGFp9Wm5ezVu2cYvnmJmjV2HK2hYWovPM5fk6Zt+CO46V72JFm0VlwRKwF/MSGHJ6imkAcW9EhHgKYPUTueFJ3Sj5XMN2uz2l9HS3XCCPgYVwuLDlaPCApD2DmfK26lL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=H/vVFLQR; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="H/vVFLQR"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id D6B662027E5;
	Thu, 15 Oct 2026 03:53:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792029221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xI2KABebe/b/OSwminy3Mgw3MuIMrJSLzl04iYS300I=;
	b=H/vVFLQRl3lIfDqBqjM5i74TK8uqSdjIpQwK+OfhezdSaoqH6+z+h0NqBl1ANPBdnbHn+V
	R0M+C4S4wLDZW2ieuOdbQNAAWkubyGLMoreR6+6OEGleRntEan/ovogtBIJOTC4SvLsRmd
	FjJvWtMR39VQihOn9m1dv5ezz1R7cctJzHI11R8EXpEaNAO78695kkI1/wMWvkBQ2PNdsA
	U/3j+2oQ5kE0uVddt5aoRK2iQ8xXTwhztR8ljy2d96msjJBhUumgj8akwfNQPFW7THfT/a
	0+7VeTKQJLtcY4FjEHNUNMxI3S4tGRp4sTeVVMeMBJdnWCXweGtt8qPt3P08bg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792029221; a=rsa-sha256;
	cv=none;
	b=KMsHya1I2zCt0fi/xdGp1cZq8IVWxZ9PNp+7QEsSsCjzAE6PcqhR8TldBTuHdXjFJ9r2Tj
	O52IGk/M7XUS+l7mFX85zlvsZrlTQPlbI7PndolDst1Buqb+MR/hXBXklU+3L3lOiqVBBJ
	sxywcw7ASCBvHgAqI9lk3HKvYzLSBcIY5Xbhh3r4eyakf95mjrADMU6HIOllWIXz02Kog8
	3fiUyZ8VSpgWEdL78gvt6FuO78Whx6wZxVTrI3lr+1MRp6yC6GQb5qAWfiHkVifd85IAzI
	/ODe4KrfAMJ2mc4b66p/QNIw5O74NJmduSi0eYt07nzXs5T3yW97tGYTOFw9hg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792029221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xI2KABebe/b/OSwminy3Mgw3MuIMrJSLzl04iYS300I=;
	b=BEGvLqjmVDK9cr3e2qhj0GS6m5jzYGwxQP+FYdKoNxoQmsqDrcqg0PaoBTudSI/RvN/5SO
	23mrtczoYfvM6bxU/yUhfhOfUDWmQVrDicDcmbsjrRCpkuXPT69sFQM/6vsGXQUhKl9N27
	ysd668BCFVtyRaZk5KICmuExNKGKOrPIUrLnxLECgPftzkaFIbAbY2sDgSoVhgvxJSkQGm
	XznWpcGlR+egc2I3C+XNINoOPtkBZueoESQw1iCC4p+PQc6sB2GBN0MrFVEBaWFBBYIvWC
	035jjguOFOOcz6bsMPNLvnK/l3TL/C+9/GTttcbpIKcuvzgIbR4eb0HPyl0yQw==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xHAf7-005wrH-2T;
	Thu, 15 Oct 2026 03:53:41 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 74CCB5C4798;
	Thu, 15 Oct 2026 01:53:41 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Chaosheng Qu <quchaosheng000406@163.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 26/37] can: cc770: don't discard the IRQ lookup error in probe
Date: Thu, 15 Oct 2026 03:40:24 +0200
Message-ID: <20261015015336.816543-27-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015015336.816543-1-mkl@pengutronix.de>
References: <20261015015336.816543-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chaosheng Qu <quchaosheng000406@163.com>

This is a robustness and consistency cleanup, this issue has not been seen
on real hardware.

cc770_platform_probe() collapses every failure of platform_get_irq()
into -ENODEV:

	irq = platform_get_irq(pdev, 0);
	if (!mem || irq <= 0)
		return -ENODEV;

That discards -EPROBE_DEFER, so a probe that has to wait for its
interrupt controller is never retried and the device stays unbound.

Return the lookup error unchanged, which is what the neighbouring CAN
platform drivers already do (c_can_platform.c, flexcan-core.c,
sja1000_platform.c). A device tree without an interrupt now reports
-ENXIO rather than -ENODEV; the driver core treats those two the same
way, so the outcome does not change.

The memory resource is checked first and on its own, so a missing
region no longer triggers an IRQ lookup that cannot succeed.

Assisted-by: LLM
Signed-off-by: Chaosheng Qu <quchaosheng000406@163.com>
Link: https://patch.msgid.link/20261009105556.301821-1-quchaosheng000406@163.com
[mkl: clarify commit message]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/cc770/cc770_platform.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/cc770/cc770_platform.c b/drivers/net/can/cc770/cc770_platform.c
index b6c4f02ffb97..64fbdf14e8ab 100644
--- a/drivers/net/can/cc770/cc770_platform.c
+++ b/drivers/net/can/cc770/cc770_platform.c
@@ -156,10 +156,13 @@ static int cc770_platform_probe(struct platform_device *pdev)
 	int err, irq;
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	irq = platform_get_irq(pdev, 0);
-	if (!mem || irq <= 0)
+	if (!mem)
 		return -ENODEV;
 
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
 	mem_size = resource_size(mem);
 	if (!request_mem_region(mem->start, mem_size, pdev->name))
 		return -EBUSY;
-- 
2.53.0

