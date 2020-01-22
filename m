From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH 3/3] arm64: defconfig: Add Support for Bosch M_CAN controllers
Date: Wed, 22 Jan 2020 13:33:10 +0530
Message-ID: <20200122080310.24653-4-faiz_abbas@ti.com>
References: <20200122080310.24653-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from fllv0016.ext.ti.com ([198.47.19.142]:39232 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbgAVICP (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 22 Jan 2020 03:02:15 -0500
In-Reply-To: <20200122080310.24653-1-faiz_abbas@ti.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, netdev@vger.kernel.org, linux-can@vger.kernel.org
Cc: catalin.marinas@arm.com, mark.rutland@arm.com, robh+dt@kernel.org, davem@davemloft.net, mkl@pengutronix.de, wg@grandegger.com, sriram.dash@samsung.com, dmurphy@ti.com, faiz_abbas@ti.com, nm@ti.com, t-kristo@ti.com

Enable configs for supporting Bosch M_CAN controllers.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 458bddeba89c..9d2ea46cc4ae 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -159,6 +159,9 @@ CONFIG_QRTR=m
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
