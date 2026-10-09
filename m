Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4AD4BF938;
	Fri,  9 Oct 2026 10:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791543380; cv=none; b=HYJf6LaeP91hMn8/ss2r4ASVzbosA/2/a0JE/ISbz4wq2wbgdncjcmsZ84hg8aeXwrEGbr0Fz1vjmY6eVioNN/50AEuAtNFLFhacGWs7wcgoSzYvozuyq79qQpVDlIjSTNRPDnXoXf0XDg1kqAz2B7QFBiHV+q6qbAkEMhgsCTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791543380; c=relaxed/simple;
	bh=41dWaX+vhPnjlYyHK6blFs3eGdZCr43gQFHTQ20lidU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WuMdJO2HAx3rxt20+i2bUX6ILZZk1nFNlEb3E99Mi76rXw50VuL3a3PKeJ8pVdVpJ/aXP9BjdyB/OUuhtfkco2yBgFWiog08aNv5afLB08PgaxZfGAgPqy1sVSaDtb+MIb2Mp6cPhQyzlm8Jt2/EoJJsgV8qrkWuGaNeloBqzTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Grprwn2R; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Grprwn2R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=v2
	yTmrjLNF/f3MYvF5FGv7mPubQ0QBAfzTrOyH+jXG8=; b=Grprwn2RT/3UKEqHgp
	bZEqORCM5mnXat1jBcJN9sJGMuOns6gcznBfhkUOfOI/Vo7z4hwV4Pv3qtMChnli
	4ToS075HWwL4b1+YJ5DV3ImhDeWaID8+VXqAu09reWSUOc5KRONiGt7lTHs5sqXK
	eDlK8TZ+kBAcNNlrSIM/YAW00=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgCnjIU9yMhqOLqzDg--.17067S4;
	Fri, 09 Oct 2026 18:55:59 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	Chaosheng Qu <quchaosheng000406@163.com>
Subject: [PATCH 2/2] net: can: cc770: update the binding file reference in the driver comment
Date: Fri,  9 Oct 2026 18:55:57 +0800
Message-ID: <20261009105557.301855-3-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009105557.301855-1-quchaosheng000406@163.com>
References: <20261009105557.301855-1-quchaosheng000406@163.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgCnjIU9yMhqOLqzDg--.17067S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7WryUGw1fJryxZryfCF1UAwb_yoWfKwcEka
	n7CF43Jay3Crn2yw4FkryxXFy3Aa4rZr1kuFn3t34aqa48Z3s5tr1vvwnxGwn5WF4IvFn5
	AF9rAr1vk3sIgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRKWrW7UUUUU==
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbDAB8Og2rIyD-AhAAA3D

From: Chaosheng Qu <quchaosheng000406@163.com>

The cc770 binding was converted from cc770.txt to bosch,cc770.yaml, so
update the path mentioned in the comment at the top of the platform
driver.

Assisted-by: LLM
Signed-off-by: Chaosheng Qu <quchaosheng000406@163.com>
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

