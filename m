Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A6D3D79EF;
	Tue, 30 Jun 2026 16:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782837850; cv=none; b=WW8OlpXVJUoHL5Q7DWy8/QEd0pL8JOy6ljTNckrEmNaRBsD4hMTGGSiRr6qXc/g7KsmsVUjzbdAfsTi23qWT3lH3Gqukls9LxSvC+bjp8xUWFsdASE5Oe9gsuzuLDDbjkfhgG7LIO+79lBQiZwNcZU4OAxi4Vw5dzQ6Lms5EUp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782837850; c=relaxed/simple;
	bh=2T6DjvT5nKKisphSHRAKsfuiYmAi1o6jh/jTo9jD0F0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gNe15zxpbH0E/LfdhvVSmqSzBh4WhGw8vWsiKKePReI5xKliB/nVPXde+5Ye7E67IjYRzRYRA4wKJFkpnrd0e6Y0bZ3LuEqjhRGfSCCppzI3LBeRdh6d1YRbXnGjwFsM++bPy2sDHB/seNN8aZGrSE8uhG8hahwFCxdd6H8rv1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=j7niABot; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="j7niABot"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=vOa+mdayT91izHVqX1UV1GEgdTHLPH6ORjFi0tHHBv0=; b=j7niABot65FEcsVCf15loxOqUF
	geyqCezj7k36DCt6kV06vZQycUNiwspL1MLfN9LT4A8HqyxcjV9+gvyCAgUr+2bsr3pVFrp0OChUB
	Aupi6lCeMRkOA9pUNGjbprECGtnVFjRJnn556FxqqzAPNkGUkOhl+0CUEoDQi0GkVjY8sDgTrPjhm
	DE73j4M9c8f3g22i431xwAW8xcfhOxV2C41geAQ6Z+HLbmvw64e8ju94ErenGKW7K6CWzVEEJ/crm
	lcWrtSAutyhFmVb8kQU5yKhhdarFqJplOki9cZEr/jeyVfguh+m1rEsrD63SURAVo+hKoeIpJPh/f
	IhcFB3Vw==;
From: Heiko Stuebner <heiko@sntech.de>
To: mkl@pengutronix.de,
	mailhol@kernel.org
Cc: kernel@pengutronix.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	shawn.lin@rock-chips.com,
	linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	quentin.schulz@cherry.de,
	zhangqing@rock-chips.com,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH 1/6] dt-bindings: can: rockchip_canfd: add compatible for the RK3588 variant
Date: Tue, 30 Jun 2026 18:43:31 +0200
Message-ID: <20260630164336.3444550-2-heiko@sntech.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630164336.3444550-1-heiko@sntech.de>
References: <20260630164336.3444550-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@cherry.de>

The RK3588 uses a variant of the CAN(-FD) controller introduced at first
with the RK3568 SoC.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 .../devicetree/bindings/net/can/rockchip,rk3568v2-canfd.yaml     | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/can/rockchip,rk3568v2-canfd.yaml b/Documentation/devicetree/bindings/net/can/rockchip,rk3568v2-canfd.yaml
index a077c0330013..02211ea3ec41 100644
--- a/Documentation/devicetree/bindings/net/can/rockchip,rk3568v2-canfd.yaml
+++ b/Documentation/devicetree/bindings/net/can/rockchip,rk3568v2-canfd.yaml
@@ -20,6 +20,7 @@ properties:
       - items:
           - const: rockchip,rk3568v3-canfd
           - const: rockchip,rk3568v2-canfd
+      - const: rockchip,rk3588-canfd
 
   reg:
     maxItems: 1
-- 
2.47.3

