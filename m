Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3300372696;
	Fri,  3 Jul 2026 08:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783065713; cv=none; b=GWCwlIBs3fGqVCFQIeHn2ehmNtY88l8UbMcSzlsVVGjPZQnKooeM8nS1C5Af35PPr4cMZeJU98yUoLRUeF4ey5Vu4XWAB8nqRP0qvMJzww3zXedE1gCliqi65zInjBa7k/UpHGKHWxsSihKqxZ2orM5KQznznTxzon1H3abtUeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783065713; c=relaxed/simple;
	bh=Ge+54fhaGO7awrh/f5wLXHGX6o86XFeCOZzQstNDEU8=;
	h=Message-ID:From:Date:Subject:MIME-Version:Content-Type:References:
	 In-Reply-To:To:Cc; b=B01TGJkIQpOMpGtPQcCm7m1ISKXb4F5gF9gwPlCgISyC83rutJy2Fux1aKZTeCkpiwqd19uOxV2hBHXBRG5wlQtLetSswsMG741dK1UbWoZM6mTNug9fpvUwGzEZxUg6HzBC23ReDOQWVDwn9xD3xK1UPI8hy9DriWvDYIQqnVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=A/My9xQj; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="A/My9xQj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1783065706; bh=FNpeTTaxZzlztLRm8w0bMFvau88h3vRn+4DN6i85aPU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=A/My9xQj4mts/W3erMsGKGNTu1fD8b1M7Xsce0ojDdt2OnAYWOsQpyTNF/LYXtHwZ
	 V2tTGZ4yVhfLTnizkdzrrQc3zQ5kI+VnqfzyP9Y5zIsUXmMoOJpvCiF2MOKho/eCs4
	 8yFwwgGEXsKczZesLcj1AYZOPeism/vsj/KcgjtY=
Received: from ubuntu2204.localdomain ([218.4.149.66])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id 6622C6D; Fri, 03 Jul 2026 16:01:38 +0800
X-QQ-mid: xmsmtpt1783065703to60n66h5
Message-ID: <tencent_48121342466E02301067FDB89BEA68886509@qq.com>
X-QQ-XMAILINFO: NbgegmlEc3Ju/QNpdGKi0FoBdgmbPC6VWoOUSy+A92JizyDLsIv3UryUA44qsT
	 x7qANg0RMIeBE+xi5cD7PxKOno8sb+BqRINt74xhZS4bCF4NA9Rr5gHQuQFTdQMItBlwCnajDMvI
	 lEaHwCDf40gx8HhtU5raAjpbQd5eg5jb7ic18UEDfJGKAYcm9cPrKB7TUaME24iR/657lzee3PVR
	 kTnHh0lcMudeqo5nGFxXVrDSmcjvHsQAuz1w09jhAx2MPWP22aaqpogWl5B+n/MwzbNIYvckn3MM
	 5+vrWvOE7lEzjiki7faNqSRa+OcSEgHYlFyS7nYe0TxPKvN4F8MmgJQWmRGiPjRKcTDx6/vsNq1T
	 qYu3EHPzytPnjihLBkgKokOsavnRKbrDHLHdK1nMgySqneBEWH9vCGHF8TlF8eS0ZxJ/bghNqnxB
	 l9m/j4SShuFlJkk2QrnP7Ar0J35m/FdW7iGp55S9LiOUFMuMPfxvq7nkubAleHJ7usg4JM92qy1+
	 BEBzH/dKCX+cei6RKioVwPDrv5mOcGNzFxOUXBXGfdqbAzSzCJTHAGQKNTbTtRq3OVYFJL3aEzRJ
	 ejNxbb6GnY1jKoMAYuTImjFuqVwlrIo8f0HNQxOZKU333S0DY9owWC7yd0lIZZYW1SXmZdR2tkWs
	 QUJ0DmLphDCdXN+cKZ8lq1ASTy9/nQupmxOt6XdN/D+0QMSN434aDUsZg8GzyeGGV7TJw1wuMEAM
	 xMKY8BDz3GirJE25SI4asX8bjEUnUpgrF31L305SgIQCHK0a4owSeu+TRlz0luGVk7PZ3UG8lIRx
	 2h48u6E3xCFYa5Qdj1em+koNtGf7/O8NwmXJI0rTwqFsH9SuhVnNH/3XqL5oObopaxblZ5bPhx2q
	 y2STno/2c3sv9OVbK27FCggFf1FEqQF5aSWD+wxcu6fzfk0Ecv+j8QS9jRX4jxkz/SD/tMwNgC3Z
	 FiJ0GIqUiwxUGv4ZLmhau6M+yjSVRD1RlsqsvG/uMFmcWkQ3PaAX3EsS+LRhcFDpQwhKkEN3QFbI
	 PWc6bzRneBErPz9v6bE4HxCSl1R6wLIhw267UWmnA35PIw6cirV2WiDl7bVxnue67pCekL3Rbzpc
	 8TXFpTJeOaq6/4rlO92DFpFDH5KSFXe4O0OnAAEtp0Im6ZogDF4kym7F2CSQ==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: Cunhao Lu <1579567540@qq.com>
Date: Fri, 03 Jul 2026 16:01:28 +0800
Subject: [PATCH v4 3/4] arm64: dts: rockchip: add CAN-FD nodes for RK3588
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-OQ-MSGID: <20260703-master-v4-3-47d40bbf5fda@qq.com>
References: <20260703-master-v4-0-47d40bbf5fda@qq.com>
In-Reply-To: <20260703-master-v4-0-47d40bbf5fda@qq.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-can@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Cunhao Lu <1579567540@qq.com>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>
X-Mailer: b4 0.15.2

Describe the three CAN-FD controllers integrated in RK3588 in the base
SoC .dtsi.

Add CAN0, CAN1 and CAN2 nodes with their register ranges, interrupts,
clocks and resets, and keep them disabled by default so board DTS files
can enable them as needed.

Co-developed-by: Heiko Stuebner <heiko.stuebner@cherry.de>
Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
Signed-off-by: Cunhao Lu <1579567540@qq.com>
---
v2 -> v3:
- Use Co-developed-by for Heiko's RK3588 contributions and add his
  Signed-off-by
---
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi | 39 +++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
index fc1fdbfd3162..b340973775c5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
@@ -2648,6 +2648,45 @@ dmac1: dma-controller@fea30000 {
 		#dma-cells = <1>;
 	};
 
+	can0: can@fea50000 {
+		compatible = "rockchip,rk3588-canfd";
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
+		compatible = "rockchip,rk3588-canfd";
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
+		compatible = "rockchip,rk3588-canfd";
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

