From: Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH linux-can-next] can: flexcan: add correctable errors correction when HW supports ECC
Date: Wed, 12 Feb 2020 19:46:20 +0800
Message-ID: <20200212114620.15416-1-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: mkl@pengutronix.de, linux-can@vger.kernel.org
Cc: linux-imx@nxp.com, netdev@vger.kernel.org
List-Id: linux-can.vger.kernel.org

commit cdce844865be ("can: flexcan: add vf610 support for FlexCAN")
From above commit by Stefan Agner, the patch just disables
non-correctable errors interrupt and freeze mode. It still can correct
the correctable errors since ECC enabled by default after reset (MECR[ECCDIS]=0,
enable memory error correct) if HW supports ECC.

commit 5e269324db5a ("can: flexcan: disable completely the ECC mechanism")
From above commit by Joakim Zhang, the patch disables ECC completely (assert
MECR[ECCDIS]) according to the explanation of FLEXCAN_QUIRK_DISABLE_MECR that
disable memory error detection. This cause correctable errors cannot be
corrected even HW supports ECC.

The error correction mechanism ensures that in this 13-bit word, errors
in one bit can be corrected (correctable errors) and errors in two bits can
be detected but not corrected (non-correctable errors). Errors in more than
two bits may not be detected.

If HW supports ECC, we can use this to correct the correctable errors detected
from FlexCAN memory. Then disable non-correctable errors interrupt and freeze
mode to avoid that put FlexCAN in freeze mode.

This patch adds correctable errors correction when HW supports ECC, and
modify explanation for FLEXCAN_QUIRK_DISABLE_MECR.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 drivers/net/can/flexcan.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 3a754355ebe6..aa871953003a 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -187,7 +187,7 @@
 #define FLEXCAN_QUIRK_BROKEN_WERR_STATE	BIT(1) /* [TR]WRN_INT not connected */
 #define FLEXCAN_QUIRK_DISABLE_RXFG	BIT(2) /* Disable RX FIFO Global mask */
 #define FLEXCAN_QUIRK_ENABLE_EACEN_RRS	BIT(3) /* Enable EACEN and RRS bit in ctrl2 */
-#define FLEXCAN_QUIRK_DISABLE_MECR	BIT(4) /* Disable Memory error detection */
+#define FLEXCAN_QUIRK_DISABLE_MECR	BIT(4) /* Disable non-correctable errors interrupt and freeze mode */
 #define FLEXCAN_QUIRK_USE_OFF_TIMESTAMP	BIT(5) /* Use timestamp based offloading */
 #define FLEXCAN_QUIRK_BROKEN_PERR_STATE	BIT(6) /* No interrupt for error passive */
 #define FLEXCAN_QUIRK_DEFAULT_BIG_ENDIAN	BIT(7) /* default to BE register access */
@@ -1203,8 +1203,8 @@ static int flexcan_chip_start(struct net_device *dev)
 	for (i = 0; i < priv->mb_count; i++)
 		priv->write(0, &regs->rximr[i]);
 
-	/* On Vybrid, disable memory error detection interrupts
-	 * and freeze mode.
+	/* On Vybrid, disable non-correctable errors interrupt and freeze
+	 * mode. It still can correct the correctable errors when HW supports ECC.
 	 * This also works around errata e5295 which generates
 	 * false positive memory errors and put the device in
 	 * freeze mode.
@@ -1212,19 +1212,32 @@ static int flexcan_chip_start(struct net_device *dev)
 	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_DISABLE_MECR) {
 		/* Follow the protocol as described in "Detection
 		 * and Correction of Memory Errors" to write to
-		 * MECR register
+		 * MECR register (step 1 - 5)
+		 * 1. By default, CTRL2[ECRWRE] = 0, MECR[ECRWRDIS] = 1
+		 * 2. set CTRL2[ECRWRE]
 		 */
 		reg_ctrl2 = priv->read(&regs->ctrl2);
 		reg_ctrl2 |= FLEXCAN_CTRL2_ECRWRE;
 		priv->write(reg_ctrl2, &regs->ctrl2);
 
+		/* 3. clear MECR[ECRWRDIS] */
 		reg_mecr = priv->read(&regs->mecr);
 		reg_mecr &= ~FLEXCAN_MECR_ECRWRDIS;
 		priv->write(reg_mecr, &regs->mecr);
-		reg_mecr |= FLEXCAN_MECR_ECCDIS;
+
+		/* 4. all writes to MECR must keep MECR[ECRWRDIS] cleared */
 		reg_mecr &= ~(FLEXCAN_MECR_NCEFAFRZ | FLEXCAN_MECR_HANCEI_MSK |
 			      FLEXCAN_MECR_FANCEI_MSK);
 		priv->write(reg_mecr, &regs->mecr);
+
+		/* 5. after configuration done, lock MECR by either setting
+		 * MECR[ECRWRDIS] or clearing CTRL2[ECRWRE]
+		 */
+		reg_mecr |= FLEXCAN_MECR_ECRWRDIS;
+		priv->write(reg_mecr, &regs->mecr);
+		reg_ctrl2 &= ~FLEXCAN_CTRL2_ECRWRE;
+		priv->write(reg_ctrl2, &regs->ctrl2);
+
 	}
 
 	err = flexcan_transceiver_enable(priv);
-- 
2.17.1
