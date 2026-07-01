Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D008E35AC07;
	Wed,  1 Jul 2026 07:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782889409; cv=none; b=rjmAMA34bRFkeTeuD8/wUdGiOaJ1tDuIjnnIdLAl4cEwuUe6h7iS1gTfMFP5/lxOdw41BMHrF5lV5K7VI7fyM/B3ap8J9+W5rKBQl1omWw9tsnbuaRrWEGvgNnJjFoRZ1+AQ+gO9Yz/MPSNv8z6aM80EXBjwOSFIlGQeSwWNBEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782889409; c=relaxed/simple;
	bh=I5Mpkpq0oBzgIvL8nHnYhPvyxTuXl3mmF+CqdHZuCVI=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=iQxLQFBcgPBWaM9kzIhvqo+2MHmiUYEMu6xkP+4I0lXcmzI4O/zhbMKSYd3JvFvG/qexyEsvVf0JGAaD2Mx/CXJnRUzGE580FjhgpmyJtR7huXGwtcBp9uvJDURVivPommzMTLyoUew/PbvnotvRldCidUpQS+sPKNQuZi0Bd3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=TwSAMjvn; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="TwSAMjvn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1782889403; bh=FShFSBar2e4LM7uO/40Qd7kb3xOrWO4j2ojR50S1ZIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TwSAMjvnt1TKjQNG7LUI6Q2iioD8JRO/x5/LvQgWUKWuk/70aQILookHAMO+iTKd6
	 PsXXfei9UsG+Fzua1cUuHdwtuPMLzFZjV1mFzbJMcNJ+zWRwp8TEw5Tk2UWevZ6ieH
	 yiJqSt+2iPsVAlsauliKHMHIRZm80ae/UIoQ1SZg=
Received: from localhost.localdomain ([2409:8d20:2a:1b57:9e54:40ff:fe02:3f0f])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 71832C3; Wed, 01 Jul 2026 15:01:49 +0800
X-QQ-mid: xmsmtpt1782889312ts72e70l2
Message-ID: <tencent_83A61C9A79199D04CC118A8026C435BFB907@qq.com>
X-QQ-XMAILINFO: NwdNTztrVPAhWG/Ary8iIcgmz746y/a+3zoJp7nCqTD9tf1OdnigiabLGRksUa
	 CoALf6Q8iPt2i3x4D0ul9kBYkgnnfA4MvQbBfj3hfBaxx6JzIJpgNc5fniq30N0q4YD1hNSrITNZ
	 FLqpkTGWL7WpfiqDWlUryCU4t8zhIl2Pz925IVRjJxb6QEWe286xYkmSfAzN/ecJTbLqPXj471jM
	 cXoHfegvO2xhMw+Ir8cFUO/ASvkzKyTpPAKHn0nzxQNY1UcgsMcXGM+spgICj83emfpGzpKTDxNQ
	 rSEuOL/LNQLhz/XFboJbhF22F9dbxFZYE0tbhDT4kCIfOfmyWpcyMW35eY+kFxQEE6hbADIFCT7M
	 sK3MX6uYHMlctw2lPJoxCCDPBzNMEcVeR08BkmqqtpaZnHDpYvKjGLwz4IlR7abAsSdUq0Z0B3j9
	 tq5GSUmlzR10wShQkTYQ6MfupHVn6jDzGDcbcurkanr01wqGJ2CQZ+EAdt16JJiOZHH+n6qPgrD4
	 SPR5/wWqPhwFE4tI6nW9EoNVnZkS2gNFgD6lSb8jYwnxvKuLP5b1Y9gvAIhNDUBuVvVXSkp5/fq7
	 KBPrqrwfvCond3ugQDzmaHiyHfBHWGhULIyou6hBIW+S7UgLlYHXn9pvc3zNw3q4BoMq6S3OLrrB
	 apOwlZdDrtax8wiovZkbO3V6lF/6Q6lb9tPnFU4NiBRjuCctKgjRKU7rmwyQg4KrSKTAu1hIv/MV
	 urfICn9+0c4xmX/3l/bHht8ShzUZwALgNbcBBUpZRvfTnvHXUgDpu/63Cd5EJqfmatcjSudrKE/s
	 rbilbHK1r89PpCBro3c843TDmg/lrPtaoujs5fsddNf6C4YOXO/6EaDP3rWvB/bEUO2hKLDyuxWV
	 0EOJgm04RNs7DJksG0mpHYRkxxhQ4Dltp5lnevkPCqUgfySLxrWoSBGkTIGVGw+3DoF/Duh0KVqI
	 2BDc1ZVHxL6dm48aV6hYMdtb6B/Y8HQUVVLm7UzY4XzaEggZmGSXd09N0JTn3T5fHZ/Xj4nGK331
	 p3TgsIvw7WZFpKl11VJrYAXwsd5gG60B2pRTr1uy8gkvG8IDTmf+gNhtlcistjxJqJ30+u2aMAFs
	 loBDSSniwbc1ryTFsIgpF2sOaCYtOKweSwYm7T56sREcVbiZhEgOtYNnBnyEz3eL+gori5
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: 1579567540@qq.com
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol@kernel.org>,
	kernel@pengutronix.de,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	luch00 <1579567540@qq.com>
Subject: [PATCH 1/3] dt-bindings: can: rockchip: add rk3588v2 CAN-FD compatible
Date: Wed,  1 Jul 2026 15:01:26 +0800
X-OQ-MSGID: <20260701070128.2096267-2-1579567540@qq.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260701070128.2096267-1-1579567540@qq.com>
References: <20260701070128.2096267-1-1579567540@qq.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: luch00 <1579567540@qq.com>

The RK3588 CAN-FD controller uses the same DT properties as the
existing Rockchip CAN-FD blocks, so extend the current schema with a
SoC-specific rockchip,rk3588v2-canfd compatible instead of creating a
new binding file.

Keep RK3588v2 as its own compatible rather than an rk3568v2 fallback.
Driver support uses separate match data and the RX FIFO count field
layout differs from rk3568v2, so a dedicated compatible is the safer
description.

Signed-off-by: luch00 <1579567540@qq.com>
---
 .../devicetree/bindings/net/can/rockchip,rk3568v2-canfd.yaml     | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/can/rockchip,rk3568v2-canfd.yaml b/Documentation/devicetree/bindings/net/can/rockchip,rk3568v2-canfd.yaml
index a077c0330..aa31ec78e 100644
--- a/Documentation/devicetree/bindings/net/can/rockchip,rk3568v2-canfd.yaml
+++ b/Documentation/devicetree/bindings/net/can/rockchip,rk3568v2-canfd.yaml
@@ -17,6 +17,7 @@ properties:
   compatible:
     oneOf:
       - const: rockchip,rk3568v2-canfd
+      - const: rockchip,rk3588v2-canfd
       - items:
           - const: rockchip,rk3568v3-canfd
           - const: rockchip,rk3568v2-canfd
-- 
2.34.1

