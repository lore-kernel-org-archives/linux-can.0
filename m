Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF0C38645E
	for <linux-can@vger.kernel.org>; Mon, 14 Sep 2026 05:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789365396; cv=none; b=BNmsABKhHeLbOk8ZX01ZfsJc5NbV4ahq5/+IYFJhBVUdtdnQ9PwHi+JK08UrxAdcmh8lk8A92fk8s3QJGg1wT4uO7Of1JOd0v7l29Hu3lwzYDGems8Q2I1DZKF4TuJHdwXfYTpVBSarF2g26EkroM1R97zJUujqrkzrkXLzxwNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789365396; c=relaxed/simple;
	bh=DR0sqauHnTt47czj4jMTH++EpUUjEQoKnRzBOc3YxPY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qrfp9rtXHuZOyrg5LajTur5oFib6PZtHCwyVLJEO3O2RWzDJWUdyyDqIYfh3rz9UnHc1yQPTi5psEdjmi3UcmNNkMi+A0RtKdpcFJ4KaCpRWqSHZ8BJUyVr8m9QR8I2pRg1sCyX2+Djm4yvt4gQ0h7kMmQJYz8QccjsgGzVefv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=J8lHneYl; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="J8lHneYl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=IF
	F5VvLdk/Jh4RhTSeIEzd3eJ6synOHhmSIWe/oaHC4=; b=J8lHneYlvtNdxisVgK
	Jwz1ajPZpCTtbWPXGp0kZhb1mWGdOrGa371tAKNr313wQpezKJT5tByAeSk8ZSOQ
	f+ZHA+DyWvLERmySqGjEkg3q8cZ4DOeMvbt4VrxbKoJNMaEncCwkpm88Y6CFMuni
	I5+VChyqdRFuQuBznqdXaEEK8=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wCXl7V8jKdqvTE6Ag--.62504S2;
	Mon, 14 Sep 2026 13:56:12 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org,
	quchaosheng000406@163.com
Subject: [PATCH] net: can: cc770: propagate the error from platform_get_irq()
Date: Mon, 14 Sep 2026 13:56:11 +0800
Message-ID: <20260914055611.495105-1-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCXl7V8jKdqvTE6Ag--.62504S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFyUXF1fAF48Zr13JrWrKrg_yoW8JFWDpr
	s7KFWxJr4kWF4jka1kXw15AFW3Z3ZIgrWUKryY9wnxZas5JFyUJr15XFyq9FsrZrWxCa4Y
	gF4jyF47CFs0vF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRO4S5UUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC4xzGPGqnjHyrlQAA3G

cc770_platform_probe() turns every failure of platform_get_irq() into
-ENODEV, including -EPROBE_DEFER. Return the error unchanged so that a
deferred probe stays deferred, and keep -ENODEV for the case where no
interrupt is described at all.

The memory resource is checked separately for the same reason, so that a
missing resource is still reported as -ENODEV rather than being confused
with an interrupt lookup failure.

The same pattern is used by other CAN platform drivers, such as
c_can_platform.c and flexcan-core.c.

Signed-off-by: Quchaosheng <quchaosheng000406@163.com>
---
 drivers/net/can/cc770/cc770_platform.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/cc770/cc770_platform.c b/drivers/net/can/cc770/cc770_platform.c
index b690167c4..9cec95ebd 100644
--- a/drivers/net/can/cc770/cc770_platform.c
+++ b/drivers/net/can/cc770/cc770_platform.c
@@ -156,8 +156,13 @@ static int cc770_platform_probe(struct platform_device *pdev)
 	int err, irq;
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!mem)
+		return -ENODEV;
+
 	irq = platform_get_irq(pdev, 0);
-	if (!mem || irq <= 0)
+	if (irq < 0)
+		return irq;
+	if (!irq)
 		return -ENODEV;
 
 	mem_size = resource_size(mem);
-- 
2.43.0

