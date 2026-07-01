Received: from out203-205-221-191.mail.qq.com (out203-205-221-191.mail.qq.com [203.205.221.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBEF3B42F5;
	Wed,  1 Jul 2026 07:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782889332; cv=none; b=aDeWckwjL2mfksN3qnyjBKcPTLb8Z+qdjzCvqx085GnE9Omwlf2MyXsVswBHhssWfKIqNLKJAJU/s/PHCSvAFVSIAhS95dfvpXy+Sq9FcOhqXJBCXpwf0ei3IyYS3ppScbx9WEafV01Dg0PHBLtEOSxFvLRiQSAUrT80d5zqNZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782889332; c=relaxed/simple;
	bh=PwsROWE7yGdCTjwi8Mr92KDpX4ZuIGdfyE+D4+4eOKQ=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=bXXKbGneALILThO6CQhPdqvmADf7W63rAvnTJulukbCgLhV0ruXqPO+ZcZvBPQi65nwtowZGPrllG/6dvZZZIzCbOfuD36HDqeR+6I9FSt5c81PAivxT5CkyPuIUev82xbyF+1z3gmtCf4KWdpL/SDxnu6BILgYkk9vS1NVmWUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=GreCodbT; arc=none smtp.client-ip=203.205.221.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="GreCodbT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1782889322; bh=KH9lG3lADyuuhfASdZJ0Hlu8ZLTSCi9nev/mOF2oDdA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GreCodbT3tcs51qul27qACdJoLrQfH/4FINNYaEpeYT2Fw4LwSe3fFFayY4b0RO3e
	 ajvmscrbuonXdOfdCpDHFfv2K8Yl1eGhw1dVyanOC2+YeCojI/NLBjEK840VXMTb7B
	 iKIczzF9Pm2Kq89PODkP4hQ3U0XjEoFvEUgZrySg=
Received: from localhost.localdomain ([2409:8d20:2a:1b57:9e54:40ff:fe02:3f0f])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 71832C3; Wed, 01 Jul 2026 15:01:49 +0800
X-QQ-mid: xmsmtpt1782889319tzlmfzkal
Message-ID: <tencent_5FD72FB1A997864EA622E17964240006F105@qq.com>
X-QQ-XMAILINFO: OR5rDBBXAGpMcj2gkvTYRbvGB+SK657gAAT44mPXmteN7yu8QMvy8mYLIjf0+g
	 1oxanFpbsFRcOObRaHf6AfB9qy7YXCHe/m6fhcgEKmiL/PiooNueSLRoO0iPRsV05jU2RuqWmj7G
	 r4zm/GMR/bIQN/pF7pfEEPIy9gAjcWrakCKelahdOWvKHF6m0TK71kASS0/OprsGftJdMozDZ3Aj
	 mXqIC50RFz9u363aHIfJMWx+8BcMV2pdngCWAg90mk/XeaJ8aRTQ1ZyPmUphEgXaKP5/tutLuHK/
	 4ys1cBTeCsBfhcq4++nByDDJs5BN74aoqX+unDYp2cftrjr0XPZOc+ssfwHrz4BgXOI1EfUZg3Dn
	 eXR0qig7zDAC5nFsHWncI+fpFC0yptCZT0qbl5/Xn6utzi9eZEHbvuM3QTA6en4LdIUzyBwJLgX+
	 qogULTCYYipQU9lpnfYkZZ8+9fz6H0zaPwtE7XBxxcAgzEq6+Ghe5qebcD2Lmy7JKYmkaSdZRx1N
	 f+7vJPC4a+Fbn6wEJHJa4/43yNgIKSlOhaXoFD0ifdB+jwGGCjgyMrq50rUweekX+iECn3wlQBCR
	 FrZZPxs/bQ/oaokHRk53HgcjvNfOfowK/ujYKZaBSFHKBLWvTN7WFbDV8evHOY9XaRPM76+NsXoo
	 34bxwa2f/gWObgTIHRl50jqNcrBni6LfnYgpjpwA/t3WiMtUm57msBC1dcmmMQKFPWwFg4VaQDU5
	 q6elZl4zx7kA9drGa0DBpafB4cbOazCcDIYyGRWuOb0v00ypSL7p/Yl5N2qdYrdkW7HGAtPFcBoW
	 SfaJxf9RQJiBQaUPKFxCyJFG591WDa3Ozg5Dpx8yNSHS4Wjn8HeTkSbtxZ48M+yyxg51+ghkDoPA
	 xfb5DklIiBWWTkdf6ZCyfC/rfyk1PmEe5q4D2656UzHWC8pzO9m6JxTYHZybUYaIhqOyjTLI6ZVK
	 X6v7GiX1Y6Uf26/pYOVUEkgzHXuXyZFnKIIX3Kr7GzXUpF8gSJgclrewpdipytAe5sw4Om5p3NgT
	 Fr760NysLGGFKOcm/p/2TqwDYkxbz2qAumMLu1V1UcHnNwszGw7UJYRr1YiAVQhU3KmAiWIj6K+h
	 4zha0lNXeex/9D3sew1RNs+7xxsH4J+xUcefgc
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
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
Subject: [PATCH 3/3] arm64: dts: rockchip: add CAN-FD nodes for RK3588
Date: Wed,  1 Jul 2026 15:01:28 +0800
X-OQ-MSGID: <20260701070128.2096267-4-1579567540@qq.com>
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

Describe the three CAN-FD controllers integrated in RK3588 in the base
SoC .dtsi.

Add CAN0, CAN1 and CAN2 nodes with their register ranges, interrupts,
clocks and resets, and keep them disabled by default so board DTS files
can enable them as needed.

Signed-off-by: luch00 <1579567540@qq.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
index fc1fdbfd3..f38cd8bd4 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
@@ -2648,6 +2648,45 @@ dmac1: dma-controller@fea30000 {
 		#dma-cells = <1>;
 	};
 
+	can0: can@fea50000 {
+		compatible = "rockchip,rk3588v2-canfd";
+		reg = <0x0 0xfea50000 0x0 0x1000>;
+		interrupts = <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru CLK_CAN0>, <&cru PCLK_CAN0>;
+		clock-names = "baud", "pclk";
+		resets = <&cru SRST_CAN0>, <&cru SRST_P_CAN0>;
+		reset-names = "core", "apb";
+		pinctrl-names = "default";
+		pinctrl-0 = <&can0m0_pins>;
+		status = "disabled";
+	};
+
+	can1: can@fea60000 {
+		compatible = "rockchip,rk3588v2-canfd";
+		reg = <0x0 0xfea60000 0x0 0x1000>;
+		interrupts = <GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru CLK_CAN1>, <&cru PCLK_CAN1>;
+		clock-names = "baud", "pclk";
+		resets = <&cru SRST_CAN1>, <&cru SRST_P_CAN1>;
+		reset-names = "core", "apb";
+		pinctrl-names = "default";
+		pinctrl-0 = <&can1m0_pins>;
+		status = "disabled";
+	};
+
+	can2: can@fea70000 {
+		compatible = "rockchip,rk3588v2-canfd";
+		reg = <0x0 0xfea70000 0x0 0x1000>;
+		interrupts = <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru CLK_CAN2>, <&cru PCLK_CAN2>;
+		clock-names = "baud", "pclk";
+		resets = <&cru SRST_CAN2>, <&cru SRST_P_CAN2>;
+		reset-names = "core", "apb";
+		pinctrl-names = "default";
+		pinctrl-0 = <&can2m0_pins>;
+		status = "disabled";
+	};
+
 	i2c1: i2c@fea90000 {
 		compatible = "rockchip,rk3588-i2c", "rockchip,rk3399-i2c";
 		reg = <0x0 0xfea90000 0x0 0x1000>;
-- 
2.34.1

