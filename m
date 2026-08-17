Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2102DE6E3;
	Mon, 17 Aug 2026 23:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787009671; cv=none; b=sq20cXajVBG7ngERkBwQsjAjtFbozovpxj/049Spfn96uRaim7CWVeWwh3hwmrU5b47rqfQFKwaUjlfp+iJcKH7PoCcJYc02NJm1ZaXHrYOkgr7Vui6P5GnKA2nJ9E8LT1Mbn2Bb4CP2FFqLXe4NkM0g4Nklw8pU0bhUF4bGl+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787009671; c=relaxed/simple;
	bh=YxFPte2tLiF8sJs9A+ZMyhmLHugPYWg2Js0zXMHpt4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dELMD05G2FxcuTBhWbRtnFVa65r72upnPOhcrXP6/6qhUD63w0vRiUer2rzwC7Y+S1OGDB2jBbWxKmdm3ue6XqPb+4LMSE/VUAHkAQWYS/++wgkHoxuxoqPbyfPzNodAuUcM7jg6oQGWPZ/VcZDHF5OeoQMFXdKaLW6FiKFzzds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 88023202280;
	Tue, 18 Aug 2026 01:34:22 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ww6qU-00220e-1G;
	Tue, 18 Aug 2026 01:34:22 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 1C97A585155;
	Mon, 17 Aug 2026 23:34:22 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Cunhao Lu <1579567540@qq.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 02/11] dt-bindings: can: rockchip: add rk3588 CAN-FD compatible
Date: Tue, 18 Aug 2026 01:24:29 +0200
Message-ID: <20260817233420.2068204-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817233420.2068204-1-mkl@pengutronix.de>
References: <20260817233420.2068204-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cunhao Lu <1579567540@qq.com>

RK3588 integrates a Rockchip CAN-FD controller variant that is not
fully compatible with RK3568v2. The RX FIFO count register field is
encoded in bits 7:5 on RK3588, while RK3568v2 uses bits 6:4.

Add a dedicated rockchip,rk3588-canfd compatible to describe this
variant. Do not use rockchip,rk3568v2-canfd as a fallback, because that
would describe a register layout that does not match the hardware.

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Cunhao Lu <1579567540@qq.com>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Link: https://patch.msgid.link/tencent_AE1A1199FC8C9ADC680C6458134A46B40309@qq.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../devicetree/bindings/net/can/rockchip,rk3568v2-canfd.yaml  | 4 +++-
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
2.53.0

