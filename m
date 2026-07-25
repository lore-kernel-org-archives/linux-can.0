Received: from out203-205-221-191.mail.qq.com (out203-205-221-191.mail.qq.com [203.205.221.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA072874F5;
	Sat, 25 Jul 2026 07:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784963198; cv=none; b=r6k8mXn5h4OOC5wknWrOzBopsa1pPfhsRR4ojYrIyMWdNQKo3F8ROPmRke8FJyzAH09Na5wrRNCN0+xPPuhLcDO3/t/GIt0Ub8RTlif8avjqzS4XdYThetalRq83FbFdaXR8JGTZGgnYjAErSJeMDvWtuwrRwbOEK/45Zl3yyjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784963198; c=relaxed/simple;
	bh=ew2brvOSYmN1ky2D8NosJqzmW3szyey/bOJzq3A82QI=;
	h=Message-ID:From:Date:Subject:MIME-Version:Content-Type:References:
	 In-Reply-To:To:Cc; b=sYGM7KNXa4+HiPL+r53UfRqX/YyeKc8LUw5RZCe2HGhD+BQcc69RihyNyOMFeMTY41GyYuJdyUb4rhwUITvdNsYacRaGApFwNvOZj727MUqVIFzmcetPPgA6vbYGWfQLh4SlZlTLoZkGfXcYIpLHs0lJBw8P5WfV+beI7SVJF6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=nBM5G76E; arc=none smtp.client-ip=203.205.221.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="nBM5G76E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1784963191; bh=Vz7yzuowqwsGsfyfQvMihkNn4ZFIprdXXMLcR6PYob8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=nBM5G76EomdYu6Mtfaa1Bg+4j5FbbUhAGzMY2LgEjJMQuyE56jgLq2W0NAzLzwVZg
	 SgDU5Xa4nx/w2SqTVaAtI/COZvcDu6LseDm8FflNXcOSeo11mZIYv26kK3nhyicsNq
	 KacebA7SMSx1ovVYa6l68WPemxyArme74VfRgiZM=
Received: from ubuntu2204.localdomain ([2409:8d20:22b:54c:9e54:40ff:fe02:3f0f])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id 19989659; Sat, 25 Jul 2026 15:06:25 +0800
X-QQ-mid: xmsmtpt1784963188t0x0rjvih
Message-ID: <tencent_76C8BC251C8C3C068C23BAF859351DD3300A@qq.com>
X-QQ-XMAILINFO: NbgegmlEc3Jue+F2vLrGacXGOKYvYWpO/RUL+wYGsTf9uoi7RscE/8TTfquBm2
	 vySwgYzgaR2oSCHZ6b2EkQdw1AsaUJv7hwj/PVw25xNkQ42W/C90hKpHj0eW5QmmO3fFTiWu/Ddz
	 xAJaukWp5J4UtF7go9HnWgi2oFwpOZE0wAihCXYdPc3dHRitJQGIaJ1MRWnKUQpKnZp1+IvFGaZ6
	 VHQpIeaBODL5FO/MDOf7S4A8avPl04TrJXhGgkVKiG5zoOo3wb6oHk9JDSc9/ZFb+RwQqEcVq1n3
	 eQW9iq50zlUUSdqfbf69GOeAeHnV7r7MahllGHb5+tQ58Gasr5Kfz1J1M7JmmwqvZwTxH/ESFHTj
	 /SPF9zm0HHXd+h/hHoWw5oDQ8x9Ha0jVwWMcJCH2QcdcWkZHjmgAqjXTzFzYPRRQKCrGy26MJUj9
	 gfmtmquyIg+P/sRuf1iIDtIGV34fcCvlL7kjxaqkHWq17V3mm3lcE52gh86UzuXvtyrR5tqC0vlb
	 pe52R5KGhgz3IZMoNeICC7zihGldGARJNmUtVCMvfEHwUPAJViGKgebb7y8tCB/tZf4P7tlE4W6o
	 SlO69PBFux5sqCZutf8J5jHgqC9VaovsBJ2q2KoCPs18eAP2NvQuBD/STEhzqL8/ITLJygM/KC9F
	 OtdXhGFU0y6UFH5Vm3dC+TyP5q1E3waIGhlvESHrVPz9Snw8yplCtG7M13XaLv+YGRpSMF5qSXy4
	 MlPYV144tZcQfp92GRhue/dSlLRlTKKXeymBp1Jgb8g5wj/21F8dttx8xLRqHKPmOd8lIfDxVZE+
	 XsDu2DgluVZnfdU1lyWBmDdV5K6zMVk3E9zV0X7qG1XzifWnJhH/TzchcG5iF5T0J+ktVW/J1rzq
	 qiRyBxLYQeejM703DPFtvaGwoSy26DVLFy1toxVr9OvjBA7F2aTJQ6tu+MsrOZzYO2HU6K/H08Fr
	 jM4QrFv+ShjN1d4YRSPAA0B2iepLkYe9l/JRgYKsZLBZJs3TGryqR9UQqeyy4kU5gIRSpwp4BF2D
	 0ZscVtRhj80OXAA4FnFklKXtlzzWNn3EWfvAea+ZmRoAj2MLF2KsvDOH4UFhMqCZhfTeGSrrKTay
	 cgdVFlv9Tetdc5knVzH0wu/1sTibZDpdUSktgvmbAQl4t0c2psis+fXRu5yaa9IBYT28qyR07jAq
	 t25sBvS/8b8bs6fg==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Cunhao Lu <1579567540@qq.com>
Date: Sat, 25 Jul 2026 15:03:31 +0800
Subject: [PATCH v5 1/4] dt-bindings: can: rockchip: add rk3588 CAN-FD
 compatible
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-OQ-MSGID: <20260725-master-v5-1-75da459d2b93@qq.com>
References: <20260725-master-v5-0-75da459d2b93@qq.com>
In-Reply-To: <20260725-master-v5-0-75da459d2b93@qq.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-can@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Cunhao Lu <1579567540@qq.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2

RK3588 integrates a Rockchip CAN-FD controller variant that is not
fully compatible with RK3568v2. The RX FIFO count register field is
encoded in bits 7:5 on RK3588, while RK3568v2 uses bits 6:4.

Add a dedicated rockchip,rk3588-canfd compatible to describe this
variant. Do not use rockchip,rk3568v2-canfd as a fallback, because that
would describe a register layout that does not match the hardware.

Signed-off-by: Cunhao Lu <1579567540@qq.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
v3 -> v4:
- Collect Krzysztof's Acked-by tag.
v2 -> v3:
- Move the Changelog below ---
- Collect Heiko's Reviewed-by tag
v1 -> v2:
- Use enum for the single-compatible entries, as suggested by Krzysztof.
- Reword the commit message to explain the hardware difference instead
  of referring to Linux driver match data.
---
 .../devicetree/bindings/net/can/rockchip,rk3568v2-canfd.yaml          | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/can/rockchip,rk3568v2-canfd.yaml b/Documentation/devicetree/bindings/net/can/rockchip,rk3568v2-canfd.yaml
index a077c0330013..81e2b6dfeb02 100644
--- a/Documentation/devicetree/bindings/net/can/rockchip,rk3568v2-canfd.yaml
+++ b/Documentation/devicetree/bindings/net/can/rockchip,rk3568v2-canfd.yaml
@@ -16,7 +16,9 @@ allOf:
 properties:
   compatible:
     oneOf:
-      - const: rockchip,rk3568v2-canfd
+      - enum:
+          - rockchip,rk3568v2-canfd
+          - rockchip,rk3588-canfd
       - items:
           - const: rockchip,rk3568v3-canfd
           - const: rockchip,rk3568v2-canfd

-- 
2.34.1

