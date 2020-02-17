From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH v2 3/3] arm64: defconfig: Add Support for Bosch M_CAN controllers
Date: Mon, 17 Feb 2020 19:58:36 +0530
Message-ID: <20200217142836.23702-4-faiz_abbas@ti.com>
References: <20200217142836.23702-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200217142836.23702-1-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, netdev@vger.kernel.org, linux-can@vger.kernel.org
Cc: broonie@kernel.org, lgirdwood@gmail.com, catalin.marinas@arm.com, mark.rutland@arm.com, robh+dt@kernel.org, mkl@pengutronix.de, wg@grandegger.com, sriram.dash@samsung.com, dmurphy@ti.com, faiz_abbas@ti.com
List-Id: linux-can.vger.kernel.org

Enable configs for supporting Bosch M_CAN controllers.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 905109f6814f..b25bbcf691b6 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -161,6 +161,9 @@ CONFIG_QRTR=m
 CONFIG_QRTR_SMD=m
 CONFIG_QRTR_TUN=m
 CONFIG_BPF_JIT=y
+CONFIG_CAN=m
+CONFIG_CAN_M_CAN=m
+CONFIG_CAN_M_CAN_PLATFORM=m
 CONFIG_BT=m
 CONFIG_BT_HIDP=m
 # CONFIG_BT_HS is not set
-- 
2.19.2
