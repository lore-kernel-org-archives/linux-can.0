Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B341F33A9F3;
	Mon, 14 Sep 2026 03:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789354954; cv=none; b=RwOWSOvALsJp3/QaFkxgKWSsX58ijq1q42is+q8jnwq0BBavZT+eEvd+ilNPJxnOcGLypuVIuuvTflbgbOcpy1F5w44S9HeKPNpQpV6TD1hAvEvTSQQhTCZEjkbWWmgXUFIIQw4/6k6TyRBPiIS0TDsyS3RY6pjlrwaJzarmrFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789354954; c=relaxed/simple;
	bh=+rFPb2IKEOKLaIwcuwqM/mKnmV31/dxWt2lWN56Xs9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tBx6OtFf8BHLeCHZMMTn+iW3woiumXQ4FJ/TSj3Lv2mHOKwIxS2TQIxWfEEVzp7bNBZ1RfJ06CIY1JakfXZML2qTbOxq7N79sP2TePnXVm2GkDrCKSou0d5N+C3Abhah8kErYPSSMw1sPcmrMb9SXB1WzYH0QNLRT7cXt/CP8LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=PRQoq3AV; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="PRQoq3AV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=5A
	eKrSDJDIqeKJogaq6we9CBgDgQfzvsKhskHLuBgEU=; b=PRQoq3AVGLTIuSg1YU
	7SPrVKU2sM2dltC2nlN36h0zRHRoc8f/1h+0dOJriRlwjZFidbO4jzosPQGYyk9n
	lQ3b7X4nM/C/n2d2kRwQmofNRHeDQJCTv+FL+p5Ri7QuDqNUKYo6BwF7GSki6g7W
	Y2KPcwmBf9V+tRcp3GGr1Tp9g=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wBHh8m3Y6dqeVk+Ag--.7653S3;
	Mon, 14 Sep 2026 11:02:17 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	quchaosheng000406@163.com
Subject: [PATCH] net: can: cc770: update the binding file reference in the driver comment
Date: Mon, 14 Sep 2026 11:02:13 +0800
Message-ID: <20260914030215.437602-2-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914030215.437602-1-quchaosheng000406@163.com>
References: <20260914030215.437602-1-quchaosheng000406@163.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHh8m3Y6dqeVk+Ag--.7653S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xr1fXFykZryDXrykuFWfKrg_yoWfWFcEka
	n7CF45Jay3Crn2yw4FkrWxXFy3AayrZw1kuFn3t343Xa48Zr95trnYyw13Gwn5WF40vFn5
	AF9rAry0k3sIgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRZGYp5UUUUU==
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC4xmLAWqnY7lhiQAA3P

The cc770 binding was converted from cc770.txt to bosch,cc770.yaml, so
update the path mentioned in the comment at the top of the platform
driver.

Signed-off-by: Quchaosheng <quchaosheng000406@163.com>
---
 drivers/net/can/cc770/cc770_platform.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/cc770/cc770_platform.c b/drivers/net/can/cc770/cc770_platform.c
index b6c4f02ff..b690167c4 100644
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

