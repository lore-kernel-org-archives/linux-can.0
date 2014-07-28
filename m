From: Matthias Klein <matthias.klein@optimeas.de>
Subject: [PATCH V2 2/5] net: can: flexcan: disable error interrupts in non ERR-Active state
Date: Mon, 28 Jul 2014 08:34:25 +0200
Message-ID: <1406529268-20126-2-git-send-email-matthias.klein@optimeas.de>
References: <1406529268-20126-1-git-send-email-matthias.klein@optimeas.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from obi-wan.optimeas.de ([82.165.198.204]:40256 "EHLO
	obi-wan.optimeas.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907AbaG1Geh (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 28 Jul 2014 02:34:37 -0400
In-Reply-To: <1406529268-20126-1-git-send-email-matthias.klein@optimeas.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: wg@grandegger.com, mkl@pengutronix.de, linux-can@vger.kernel.org, support@karo-electronics.de
Cc: bigeasy@linutronix.de

=46rom: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

On imx53 I receive continuously STF_ERR error interrupts after sending =
a
CAN frame on an open BUS.
This patch disables error interrupts once we leave the ERR-Active state
since I doubt further error interrupts are of any interest especially i=
f
they render the system unresponsible.
According to the manual in this case the system remains in passive stat=
e
and RX-err counter is >127 and won't increment any further and so it
won't enter BUS-Off state. Once the system receives a CAN message, the
RX-error counter should by set to 119 =E2=80=A6 127 which brings the CA=
N module
back to ERR-active state which then should activate error reporting
again.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Matthias Klein <matthias.klein@optimeas.de>
---
 drivers/net/can/flexcan.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index f677b49..2b98da2 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -628,7 +628,17 @@ static int flexcan_poll(struct napi_struct *napi, =
int quota)
 		napi_complete(napi);
 		/* enable IRQs */
 		flexcan_write(FLEXCAN_IFLAG_DEFAULT, &regs->imask1);
-		flexcan_write(priv->reg_ctrl_default, &regs->ctrl);
+		/*
+		 * On an open CAN-bus the iMX51 keeps reporting the STF_ERR
+		 * event after an attempt to send a CAN message. This will
+		 * disable further error reports (or that one that keeps
+		 * nagging) once we leave the ERR-Active state.
+		 */
+		if (reg_esr & FLEXCAN_ESR_FLT_CONF_MASK)
+			flexcan_write(priv->reg_ctrl_default &
+					~FLEXCAN_CTRL_ERR_MSK, &regs->ctrl);
+		else
+			flexcan_write(priv->reg_ctrl_default, &regs->ctrl);
 	}
=20
 	return work_done;
@@ -656,8 +666,8 @@ static irqreturn_t flexcan_irq(int irq, void *dev_i=
d)
 	 * - bus error IRQ and bus error reporting is activated
 	 */
 	if ((reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_AVAILABLE) ||
-	    (reg_esr & FLEXCAN_ESR_ERR_STATE) ||
-	    flexcan_has_and_handle_berr(priv, reg_esr)) {
+	    (reg_esr & FLEXCAN_ESR_ERR_ALL)) {
+
 		/*
 		 * The error bits are cleared on read,
 		 * save them for later use.
--=20
2.0.1

