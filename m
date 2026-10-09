Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BF64C10E3;
	Fri,  9 Oct 2026 10:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791543259; cv=none; b=oudQSkJbm4i5XHLydwksW4/bm9uDmCTYYpbI56IrBMlC0GcZzSHPdmGxP7RqODtjh62Uf99ywYuMJFadZ9oYsSBuJ1umhthixdEIwJkjbKz/Z4vMWSH0W+gFMuO8hiIC054YYHrSp9yjDR+Oiuxdf+5LSuvJBlscFD5iFdd7thY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791543259; c=relaxed/simple;
	bh=TYchBQhoISpo28QW5Qy8mzIT1xmhRxYetaQ6CIDhK44=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gKIV5sNfO4LNJy38a9NQG6sll4h3/vQwD8fg25AHSK3MR35nx4DaWK2RIOlD6vLl+mhnCOop8I8ZbjZ8se3gF6Zc78wn2XjwwgN2DxXcmTIRz4hZMK9xcchNcqJx2eWYJAksNSV6fj4diGyK5xIiNLI2RzYrRXyIW8NfowJpdUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=MQWCpU8r; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MQWCpU8r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=O8
	IwSzG2bd+Te7qhYDT/NRD6wZ72TqYpvxyaQn7TsAI=; b=MQWCpU8r5F7TY56+kc
	2/Qxg/HQAuxYy70dsdRubAUKJtoGl1NZyL4VKYjwjmfyTkyx1WbVyhdR4+oZDFBc
	sh2rmntYSSiQmmVm61TAIwxScvMlo04XawaRbdXLcGyv1saU6Waj0+lqRULvEPgm
	Oc8K0wU3actKLx8bp2TM8gtCE=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgBnh8G7x8hquKxRDQ--.50493S2;
	Fri, 09 Oct 2026 18:53:48 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: can: cc770: don't discard the IRQ lookup error in probe
Date: Fri,  9 Oct 2026 18:53:47 +0800
Message-ID: <20261009105347.300096-1-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgBnh8G7x8hquKxRDQ--.50493S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFWDZw15CFWkAFyrAr1UKFg_yoW8WF1rpF
	4kKFWfXr4kWa1jk3WkWw1UZFW3ZFna93y7GFy29ws8Z3s5XF9xJr1UJa4jqFsrC397C3WY
	9F4jyF4xuan0vr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UMHqxUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbDABztY2rIx7y4sAAA3D

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
Signed-off-by: Quchaosheng <quchaosheng000406@163.com>
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

