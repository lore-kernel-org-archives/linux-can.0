From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH v6 4/6] can: m_can: Support higher speed CAN-FD bitrates
Date: Fri, 22 Dec 2017 19:01:26 +0530
Message-ID: <1513949488-13026-5-git-send-email-faiz_abbas@ti.com>
References: <1513949488-13026-1-git-send-email-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lelnx194.ext.ti.com ([198.47.27.80]:49172 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755982AbdLVNbU (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 22 Dec 2017 08:31:20 -0500
In-Reply-To: <1513949488-13026-1-git-send-email-faiz_abbas@ti.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: wg@grandegger.com, mkl@pengutronix.de, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, faiz_abbas@ti.com, nsekhar@ti.com, fcooper@ti.com, robh@kernel.org, Wenyou.Yang@microchip.com, sergei.shtylyov@cogentembedded.com

From: Franklin S Cooper Jr <fcooper@ti.com>

During test transmitting using CAN-FD at high bitrates (> 2 Mbps)
would fail. Scoping the signals I noticed that only a single bit
was being transmitted and with a bit more investigation realized the actual
MCAN IP would go back to initialization mode automatically.

It appears this issue is due to the MCAN needing to use the Transmitter
Delay Compensation Mode with the correct value for the transmitter delay
compensation offset (tdco). What impacts the tdco value isn't 100% clear
but to calculate it you use an equation defined in the MCAN User's Guide.

The user guide mentions that this register needs to be set based on clock
values, secondary sample point and the data bitrate. One of the key
variables that can't automatically be determined is the secondary
sample point (ssp). This ssp is similar to the sp but is specific to this
transmitter delay compensation mode. The guidelines for configuring
ssp is rather vague but via some CAN test it appears for DRA76x that putting
the value same as data sampling point works.

The CAN-CIA's "Bit Time Requirements for CAN FD" paper presented at
the International CAN Conference 2013 indicates that this TDC mode is
only needed for data bit rates above 2.5 Mbps. Therefore, only enable
this mode when the data bit rate is above 2.5 Mbps.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/net/can/m_can/m_can.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 53e764f..371ffc1 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -127,6 +127,12 @@ enum m_can_mram_cfg {
 #define DBTP_DSJW_SHIFT		0
 #define DBTP_DSJW_MASK		(0xf << DBTP_DSJW_SHIFT)
 
+/* Transmitter Delay Compensation Register (TDCR) */
+#define TDCR_TDCO_SHIFT		8
+#define TDCR_TDCO_MASK		(0x7F << TDCR_TDCO_SHIFT)
+#define TDCR_TDCF_SHIFT		0
+#define TDCR_TDCF_MASK		(0x7F << TDCR_TDCF_SHIFT)
+
 /* Test Register (TEST) */
 #define TEST_LBCK		BIT(4)
 
@@ -991,7 +997,8 @@ static int m_can_set_bittiming(struct net_device *dev)
 	const struct can_bittiming *bt = &priv->can.bittiming;
 	const struct can_bittiming *dbt = &priv->can.data_bittiming;
 	u16 brp, sjw, tseg1, tseg2;
-	u32 reg_btp;
+	u32 reg_btp, tdco, ssp;
+	bool enable_tdc = false;
 
 	brp = bt->brp - 1;
 	sjw = bt->sjw - 1;
@@ -1006,9 +1013,41 @@ static int m_can_set_bittiming(struct net_device *dev)
 		sjw = dbt->sjw - 1;
 		tseg1 = dbt->prop_seg + dbt->phase_seg1 - 1;
 		tseg2 = dbt->phase_seg2 - 1;
+
+		/* TDC is only needed for bitrates beyond 2.5 MBit/s.
+		 * This is mentioned in the "Bit Time Requirements for CAN FD"
+		 * paper presented at the International CAN Conference 2013
+		 */
+		if (dbt->bitrate > 2500000) {
+			/* Use the same value of secondary sampling point
+			 * as the data sampling point
+			 */
+			ssp = dbt->sample_point;
+
+			/* Equation based on Bosch's M_CAN User Manual's
+			 * Transmitter Delay Compensation Section
+			 */
+			tdco = (priv->can.clock.freq / 1000) *
+			       ssp / dbt->bitrate;
+
+			/* Max valid TDCO value is 127 */
+			if (tdco > 127) {
+				netdev_warn(dev, "TDCO value of %u is beyond maximum limit. Disabling Transmitter Delay Compensation mode\n",
+					    tdco);
+			} else {
+				enable_tdc = true;
+				m_can_write(priv, M_CAN_TDCR,
+					    tdco << TDCR_TDCO_SHIFT);
+			}
+		}
+
 		reg_btp = (brp << DBTP_DBRP_SHIFT) | (sjw << DBTP_DSJW_SHIFT) |
 			(tseg1 << DBTP_DTSEG1_SHIFT) |
 			(tseg2 << DBTP_DTSEG2_SHIFT);
+
+		if (enable_tdc)
+			reg_btp |= DBTP_TDC;
+
 		m_can_write(priv, M_CAN_DBTP, reg_btp);
 	}
 
-- 
2.7.4

