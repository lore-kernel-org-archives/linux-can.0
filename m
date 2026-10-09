Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600224C10CA;
	Fri,  9 Oct 2026 10:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791543273; cv=none; b=aYnSQCtIOH4PlQ050zQgsiBhiX7MXgWtzDkg61Cx9pJjXHaEHSg7QFY0xLIkfM78XSnGVzMAbNjE3Ry8ykXRbdhCnYsfxEqAeq3wJAvgXxkJgb7WdxwrylcX14kNcUV5/a18TAL8bu5FV3EJrnkDX5j+JdOSi8lCA7JP38q/9zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791543273; c=relaxed/simple;
	bh=ZwGtM1ckU4atMsC4xjOcWSfgWOoUD3QCZ55YPZTBdXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YKf4bx1/U2NnjpkcWCJGO66SY7YBCe3PrSWZ/UIw6SP1g6CJSWz8S0zECCumxOZn30Bb3Nw9JUu9SDCUFrwXS3JNB9kmOe4T/EBb2kDk+uMcQix1Xzq7jNqSsYjHhN7ZaE3CXsoSejBkCk2wpCYmMFd+x0FxOHJApjFXNRk8u34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Nu/+gznL; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Nu/+gznL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=7p
	cleMH7f1jVKXJZ7O7LrSDIwG8VTMI45esOZ/lKRqs=; b=Nu/+gznLV33eyteCpI
	fgA5x32PEudbMzMWHYQpwfJB50ouQRR7S/y+MjHxXV55rmP9x4HvyCh4KqnmPcAP
	GNnLSP5YEpCILS5EYlPUTKXE/gOhV64XoAIGdB6SHyf1gJ1t7LcXEPbpGgCou04Q
	z1AzZ1DLPokH5tdX6eneptlsQ=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD37zPQx8hqEcvPDQ--.14439S4;
	Fri, 09 Oct 2026 18:54:10 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 2/2] net: can: cc770: update the binding file reference in the driver comment
Date: Fri,  9 Oct 2026 18:54:08 +0800
Message-ID: <20261009105408.300300-3-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009105408.300300-1-quchaosheng000406@163.com>
References: <20261009105408.300300-1-quchaosheng000406@163.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD37zPQx8hqEcvPDQ--.14439S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xr1fXFyxur45WFy8CF4rKrg_yoWfCFgEka
	n7CF45Jay5Crn2yw4FkrWxXFy3Aa4rZr1kuFn3t34aqa48Zr95trnYvw13Gwn5WF40vFn5
	AF9rAry0k3sxKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0i0ePUUUUU==
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC5BLyaGrIx9JM2AAA3P

The cc770 binding was converted from cc770.txt to bosch,cc770.yaml, so
update the path mentioned in the comment at the top of the platform
driver.

Assisted-by: LLM
Signed-off-by: Quchaosheng <quchaosheng000406@163.com>
---
 drivers/net/can/cc770/cc770_platform.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/cc770/cc770_platform.c b/drivers/net/can/cc770/cc770_platform.c
index b6c4f02ffb97..b690167c454f 100644
--- a/drivers/net/can/cc770/cc770_platform.c
+++ b/drivers/net/can/cc770/cc770_platform.c
@@ -30,8 +30,8 @@
  *           bosch,external-clock-frequency = <16000000>;
  *   };
  *
- * See "Documentation/devicetree/bindings/net/can/cc770.txt" for further
- * information.
+ * See "Documentation/devicetree/bindings/net/can/bosch,cc770.yaml" for
+ * further information.
  */
 
 #include <linux/kernel.h>
-- 
2.43.0

