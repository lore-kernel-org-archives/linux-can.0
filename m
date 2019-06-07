From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6/9] can: m_can: implement errata "Needless activation of MRAF irq"
Date: Fri,  7 Jun 2019 23:15:38 +0200
Message-ID: <20190607211541.16095-7-mkl@pengutronix.de>
References: <20190607211541.16095-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190607211541.16095-1-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Eugen Hristev <eugen.hristev@microchip.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

During frame reception while the MCAN is in Error Passive state and the
Receive Error Counter has thevalue MCAN_ECR.REC = 127, it may happen
that MCAN_IR.MRAF is set although there was no Message RAM access
failure. If MCAN_IR.MRAF is enabled, an interrupt to the Host CPU is
generated.

Work around:
The Message RAM Access Failure interrupt routine needs to check whether

    MCAN_ECR.RP = '1' and MCAN_ECR.REC = '127'.

In this case, reset MCAN_IR.MRAF. No further action is required.
This affects versions older than 3.2.0

Errata explained on Sama5d2 SoC which includes this hardware block:
http://ww1.microchip.com/downloads/en/DeviceDoc/SAMA5D2-Family-Silicon-Errata-and-Data-Sheet-Clarification-DS80000803B.pdf
chapter 6.2

Reproducibility: If 2 devices with m_can are connected back to back,
configuring different bitrate on them will lead to interrupt storm on
the receiving side, with error "Message RAM access failure occurred".
Another way is to have a bad hardware connection. Bad wire connection
can lead to this issue as well.

This patch fixes the issue according to provided workaround.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Reviewed-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 9b449400376b..deb274a19ba0 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -822,6 +822,27 @@ static int m_can_poll(struct napi_struct *napi, int quota)
 	if (!irqstatus)
 		goto end;
 
+	/* Errata workaround for issue "Needless activation of MRAF irq"
+	 * During frame reception while the MCAN is in Error Passive state
+	 * and the Receive Error Counter has the value MCAN_ECR.REC = 127,
+	 * it may happen that MCAN_IR.MRAF is set although there was no
+	 * Message RAM access failure.
+	 * If MCAN_IR.MRAF is enabled, an interrupt to the Host CPU is generated
+	 * The Message RAM Access Failure interrupt routine needs to check
+	 * whether MCAN_ECR.RP = ’1’ and MCAN_ECR.REC = 127.
+	 * In this case, reset MCAN_IR.MRAF. No further action is required.
+	 */
+	if ((priv->version <= 31) && (irqstatus & IR_MRAF) &&
+	    (m_can_read(priv, M_CAN_ECR) & ECR_RP)) {
+		struct can_berr_counter bec;
+
+		__m_can_get_berr_counter(dev, &bec);
+		if (bec.rxerr == 127) {
+			m_can_write(priv, M_CAN_IR, IR_MRAF);
+			irqstatus &= ~IR_MRAF;
+		}
+	}
+
 	psr = m_can_read(priv, M_CAN_PSR);
 	if (irqstatus & IR_ERR_STATE)
 		work_done += m_can_handle_state_errors(dev, psr);
-- 
2.20.1
