Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829C84C9E1C;
	Fri,  9 Oct 2026 10:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791543381; cv=none; b=n8imeNMtg3trXrxqChPBrkD3zDQA6CJRUTsGR/j3ipxygUDjFjMjOvDw62pAm9vW8Ia59zg4rZAqsIBrTQIrOR0e2rEgesiYYfi4ABxCVTRKL44Jeighh5pvOzlzy5/vsf4uz8FU2J0vvoFfwUlGw1r5SDjhmT0lGIao6jl/QQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791543381; c=relaxed/simple;
	bh=lC5CNDCAtvnBvgtzLLWiyRoXgynJuQPr2CxC7+SokhA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tmOgrRDOfzeF9q00y+JqJCIXjiBxl4Fl2PYI/EoEGAlJR2NtTNQEjs+V4J6Q4LaHYClyMjTPJLXhNQbK2KPV5myJelMuu+DouujcUatvGYGKD6bRNJMdaiWYvJoqPRIzWYuMNgFqEcleJ5sCnpbuehpbj28zrlZRuOVhVb3FU/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=kGnEXfMc; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kGnEXfMc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=7d
	+xLTYOcPTxp6MgpMPZ+pdq/SMHGlsB2ace6TTUrs0=; b=kGnEXfMcG0Arw404vw
	UAxuQFNKr2iT09g+z2zdospsDYr+m8+UgaQvRMoHq9PSePO1tw5mya97DRMMBzwp
	CiLt0pEfVabMnN/wa1LPbGGWmbF5OPOulrRU5VSYOkKvc7WH8rYr9Mh9Lnvk4Ada
	a0XB/pI2UA1Skt1jdnAcg3tKY=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3v608yMhqQuaPDg--.39909S2;
	Fri, 09 Oct 2026 18:55:57 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chaosheng Qu <quchaosheng000406@163.com>
Subject: [PATCH] net: can: cc770: don't discard the IRQ lookup error in probe
Date: Fri,  9 Oct 2026 18:55:56 +0800
Message-ID: <20261009105556.301821-1-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3v608yMhqQuaPDg--.39909S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zw18ZFyrJr45AFyrXF4fZrb_yoW8Ww13pF
	4kKFWxur4kuw4jk3WkWw1UZFW3ZFna9rW7KFy2kw1DZ3s5Xr9xJr1UJa4jqFsrA397C3WY
	9F4jyF4xAan0vw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEmLvPUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC5B0Og2rIyD1S2wAA3q

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
2.43.0

