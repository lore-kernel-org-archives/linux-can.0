Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D4F4E36DC;
	Fri,  9 Oct 2026 13:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553423; cv=pass; b=KtwCwtiJW2qrJq8Q3Jvw+bnTGbVmVP8yZp40d4GE7/xx6GSeprNUyI+NNokMC3n8gEAy/TXHP2RZ6SGGi8aCC9WDq3ExwgSexh+jo+RK8EsH53TdnErp+tnhpRbQFFO250DP/0inQLh/+qbzgZ/WhyggpgEMl57eZfDcKBkoKlk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553423; c=relaxed/simple;
	bh=tA8AhGZk7hbowSNlGPvIS8pWHJEEWQqOHheerDGc62A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nGGFoJ5872ICjjgzQ9Uum+bWbVKko0RJpeFw+6mIPECVePdRyBjSI8jTZfdj9SARpVdaDPIpObT+YvhcdgiHEyXF84D2OJYHPlkblXT49pSlKeupBufPPCTJvonRvue/0gwBXb+dDYhzaDWL62RMM+PxoOR+VFYMM5cOX9RGF3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=gRpVXptO; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="gRpVXptO"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 7298D202664;
	Fri, 09 Oct 2026 15:43:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791553418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nrV60qykOkiFooqhY7dbMa9F9uJN5Ez5A7f3T3LfIQQ=;
	b=gRpVXptOgQi4UVE8kaqOvk14yIYwTUoEcP5Oh3MPqXMb3RSyubUreC0+mvj2UUohwEMY19
	VH5oQsN92LjN2poaU6utCp3b2x0EKvW0/Q7ROIBaiY/pX7MlWy1KDKR7wYGEFWAOHHN7Xb
	ngizORk5iAKNqq8muQoDb4lQcqagqmN0Ma3G5jze91IMOfkD9P6BlVKLrbKjMuxYg5u5wR
	yJuPd9znITvCtsIGOLssTY6Z/JZEanvzn5LzMCihzrWmbdKFijxHDQJlgfkSR354JBEhhq
	vThlmmBGFFMCA0mVxVSVDbI8uQ3aDxo/7gkEnc5j5h8gQw3vGLTiYqm6uGcnKQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791553418; a=rsa-sha256;
	cv=none;
	b=YS8ppiw0B8EkSVhIjvbGXbn3ns6RfW87nR+jPk/MtagrQtB/hSp2rCUgBpQK/62MOMkjjL
	xgacjx1VR6/OVsZFPqD/KR0y3+5uFrsOUchbx3elXHir+zhdkAPg2q0Sp1JK57p3LJOo/L
	SsDmFOKaWZrIigBiuZ0Ir2jHyob0P06NJhIqTeA7kh1PhWnnweP7u5FnMaCERVWgbJx0BD
	HCq+IeLdx/Yod+uiGi/B4b6yOFqrLllwe2ffw2qfI//Svmukkp9uugSAtodFu1yQ6AiEmq
	RalSsbOaADvF93j7UER+3gFPN7o8VdugGtKJmt5t4BSWuxnul0vy9tUXXMbURw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791553418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nrV60qykOkiFooqhY7dbMa9F9uJN5Ez5A7f3T3LfIQQ=;
	b=RZ/QwjyO0f3A4X8nxmqtSmduvC9w/J3rbi2R7pMUXqgERAQuWfHsXynBgBNDWNEfw6osPb
	jWRJqtRPpPKbNuqFAc3OLwdPIMmLDsbHL3bYYg0K3e0uRfOAKa69wW2TJ2atpQmDec3Zj2
	4CJx0aF/5i6A5plQf9MfmTb8dH7XbmoS+o4MrTe5O6wQW4mrB88CPHny60JUN9a5jumxsn
	h0DJnRtWaHwEal5RynCN4Nxa6g8PNmI2bEuFAZn6QAuGEWgObtD97J9OYkB9Ws8Zf+M49I
	9kcnjibXK/V8Tx9rLT7wFNG9Gg9y0DqZe6otovOBortG3CcIFReK+Kera11Tlw==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xFAss-0053T2-1B;
	Fri, 09 Oct 2026 15:43:38 +0200
Received: from blackshift.org (90-182-211-1.rcp.o2.cz [90.182.211.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id F32785BD8D3;
	Fri, 09 Oct 2026 13:43:37 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Chaosheng Qu <quchaosheng000406@163.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 24/37] can: cc770: don't discard the IRQ lookup error in probe
Date: Fri,  9 Oct 2026 15:27:56 +0200
Message-ID: <20261009134323.64064-25-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009134323.64064-1-mkl@pengutronix.de>
References: <20261009134323.64064-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chaosheng Qu <quchaosheng000406@163.com>

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

