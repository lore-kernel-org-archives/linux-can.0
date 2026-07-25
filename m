Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D83D175A99;
	Sat, 25 Jul 2026 07:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784963271; cv=none; b=umL1mNj53E6Hqy+XQFJhcNT/035t0PK4npM9J5uHc04lbDMoYvLoquSXZV5EBS/mO0VdJaTuciho713fzbLnJbujKTfmXGNhE4IUsTTH+o/CvQ53DzY6rwJM3xvEm7eXUgSUrNW2F5RzDEiSDnHjQsLmFaAsxNIC6Hwp3rmtOoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784963271; c=relaxed/simple;
	bh=484To6++ZT/hLUM2setPu5cCnJ+O6aptvtwaDSXebbk=;
	h=Message-ID:From:Date:Subject:MIME-Version:Content-Type:References:
	 In-Reply-To:To:Cc; b=SFi/7fF/jlMK+XgsKOAR4iEeniKIrzSamCK9ed8kwyMGhAUvEyXR4yRSHVqRxUlbOXN99/29JxhodTCe7M0fvR4HSkzNTQfEgFGsvD0jM+newW66QaQJ4rgElmCnc9ii/mR7vnVtAIHHJeb+ea5WNoRRRFTQNY9TVo8GsBr3K6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=m6hNMp36; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="m6hNMp36"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1784963265; bh=USSiH9JuC1v5AlfxBel9Z2zX+IhkFx2Yg0F4916TwD4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=m6hNMp36ulqTa94hIKc5F6x9A0ivoXXPcrYPOBUF/8lSO9OUxackI5hnE6vjbH+vs
	 OH/OIRvmln7Hs0frNqVJCseefxafsUtCyx/+5MSYCV9Drj73iP7FR2GWNdqk3Uo9Sf
	 ECLPaMMa5Y3gxoYfDYNcXuNka7XdozYhaFID8Sh4=
Received: from ubuntu2204.localdomain ([2409:8d20:22b:54c:9e54:40ff:fe02:3f0f])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id 19989659; Sat, 25 Jul 2026 15:06:25 +0800
X-QQ-mid: xmsmtpt1784963192tfxjfozrp
Message-ID: <tencent_BE229ADF4693078DBBCC6C02CC0855C01E06@qq.com>
X-QQ-XMAILINFO: NMiAo2azIaDA6K4Ssw4mZvYLnQmxw5sFN+oDeTXrEqi10F2itRfr7TxhEpJhe1
	 7AfIE3/f6vGpevpjcilErr/3QxEswqzxT6RSPaLAEXrMK8IKfCoAtevQ3qEvMV/G7uRDgoblFtaZ
	 ZaCZVmhla7wdhBDgG2mZlndAoLxn/RXV/enXjX3+IgdeAqit1BDtsGewKW34sDruFmj+vImMfX18
	 psLaeiYlvXYp647ZVzbeVbr1ndojlGHluo1maXA1NMxAddj9ucNCqFSOm+auRmIRniNxSEDwmeSp
	 yTlJdC0j9k1+6/TP4+/xRtLJvXSAlTFIHmlKwrZuGeM3FuGc+UTxhobMrOWyqz63vCSTmqZr9dFZ
	 F+XCXSVsspPPXH37yZFpYEk3m3tCtyqkrS7lA3BZCIUKKpBy9jEDnHyZKTy7EU5pqboKwEqjnSbK
	 1d6N9HNeGbByIbwaLFgTgWgBHDrsaby17gB/f1MTevk0GWET2EgMt/9RozC0MXHsqB+5B1GPBG5N
	 BGBgzAI+TypmN0u1/G8634ZIHofn+Asxs9R5c4c8zK036nB5SkRteqhAZJnUKuo2BHDkl8+5lPt+
	 /Vw81lZDlNO5dOpfqA7JIEpjwi1QtTKgfyErbe41IIUPEDRsmtwHflj3t4ZH8qBd3W7nHM9mJbYH
	 76JLJe4QobHMBtvj/1odSOOaO0/oktcArkBf2XwntTSx0EmovMYnOt12IK5faHmT51H2CK4Hv/lM
	 NrOHgTd82wPnXatnGCk32RJGNGlOwi+GhzBNxYMTARULoTTjwGaL7XIbBem3Nd8OCqlmzQynN4fd
	 FsoRdZ70eYQFkByLdlB+aXb12hVZpuimvbx1OedgRAJ8c2uVkbUizX0YFIAtzuxIdshoR3JwzJLw
	 d3swhGzL7+GP/G/d8NlP24dwkdngieJJQDeuZCV4z/Rt0tzH40mWZlwgbEg9A/+Gfwg6YFibnLHS
	 WVTszTm2gs7K4N7WtZ+iyKS/6bfdTXHmSPWylzJ1CjKx6m5oKBZ3LpPnaa2tRYJ9SYZ9JwPRJnbH
	 vJh7H5+vZllNj5BSNeFffsoimBYX3sQfke8nOQPcIkY9lLZ4NWG/j9u2bCEuxojOrc5jjOu92rT8
	 q5LI9t/7ZhQN56fe+wL8DYOjj/Ic4f2drHVkhowxhycSwWTrT/OHu1Xmhg4W86wxt9/1SN
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: Cunhao Lu <1579567540@qq.com>
Date: Sat, 25 Jul 2026 15:03:33 +0800
Subject: [PATCH v5 3/4] arm64: dts: rockchip: add CAN-FD nodes for RK3588
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-OQ-MSGID: <20260725-master-v5-3-75da459d2b93@qq.com>
References: <20260725-master-v5-0-75da459d2b93@qq.com>
In-Reply-To: <20260725-master-v5-0-75da459d2b93@qq.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-can@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Cunhao Lu <1579567540@qq.com>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15.2

Describe the three CAN-FD controllers integrated in RK3588 in the base
SoC .dtsi.

Add CAN0, CAN1 and CAN2 nodes with their register ranges, interrupts,
clocks and resets, and keep them disabled by default so board DTS files
can enable them as needed.

Co-developed-by: Heiko Stuebner <heiko.stuebner@cherry.de>
Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
Signed-off-by: Cunhao Lu <1579567540@qq.com>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
v4 -> v5:
- Collect Quentin's Reviewed-by tag
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

