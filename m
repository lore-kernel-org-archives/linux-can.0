From: Marcel Ziswiler <marcel@ziswiler.com>
Subject: [PATCH] apalis_t30: fix can2
Date: Mon, 25 Jun 2018 09:59:48 +0200
Message-ID: <20180625075948.32040-1-marcel@ziswiler.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-tegra@vger.kernel.org, linux-can@vger.kernel.org
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>, devicetree@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-can.vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

CAN2 currently fails on probe as follows:

mcp251x spi1.1: Probe failed, err=19

Fix this by enabling input on pin mux of resp. SPI4 pins.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra30-apalis.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
index d1d21ec2a844..9ff6aafd72b3 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -118,6 +118,7 @@
 				nvidia,function = "spi4";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 			/* CAN_INT2 */
 			spi2_cs2_n_pw3 {
-- 
2.14.4
