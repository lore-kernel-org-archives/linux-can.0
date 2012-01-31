From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 03/12] can: flexcan: fix irq flooding by clearing all interrupt sources
Date: Tue, 31 Jan 2012 22:46:41 +0100
Message-ID: <1328046410-21392-4-git-send-email-mkl@pengutronix.de>
References: <1328046410-21392-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44837 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755329Ab2AaVq5 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 31 Jan 2012 16:46:57 -0500
In-Reply-To: <1328046410-21392-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Wolfgang Grandegger <wg@grandegger.com>, Reuben Dowle <Reuben.Dowle@navico.com>, =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>, Marc Kleine-Budde <mkl@pengutronix.de>

=46rom: Wolfgang Grandegger <wg@grandegger.com>

As pointed out by Reuben Dowle and Lothar Wa=C3=9Fmann, the TWRN_INT,
RWRN_INT, BOFF_INT interrupt sources need to be cleared as well
to avoid interrupt flooding, at least for the Flexcan on i.MX28
SOCs. Furthermore, the interrupts are only cleared, if really one
of those interrupt sources are pending (which is not the case for
rx and tx done).

CC: Reuben Dowle <Reuben.Dowle@navico.com>
CC: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 7fd8089..96d2357 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -118,6 +118,9 @@
 	(FLEXCAN_ESR_TWRN_INT | FLEXCAN_ESR_RWRN_INT | FLEXCAN_ESR_BOFF_INT)
 #define FLEXCAN_ESR_ERR_ALL \
 	(FLEXCAN_ESR_ERR_BUS | FLEXCAN_ESR_ERR_STATE)
+#define FLEXCAN_ESR_ALL_INT \
+	(FLEXCAN_ESR_TWRN_INT | FLEXCAN_ESR_RWRN_INT | \
+	 FLEXCAN_ESR_BOFF_INT | FLEXCAN_ESR_ERR_INT)
=20
 /* FLEXCAN interrupt flag register (IFLAG) bits */
 #define FLEXCAN_TX_BUF_ID		8
@@ -577,7 +580,9 @@ static irqreturn_t flexcan_irq(int irq, void *dev_i=
d)
=20
 	reg_iflag1 =3D flexcan_read(&regs->iflag1);
 	reg_esr =3D flexcan_read(&regs->esr);
-	flexcan_write(FLEXCAN_ESR_ERR_INT, &regs->esr);	/* ACK err IRQ */
+	/* ACK all bus error and state change IRQ sources */
+	if (reg_esr & FLEXCAN_ESR_ALL_INT)
+		flexcan_write(reg_esr & FLEXCAN_ESR_ALL_INT, &regs->esr);
=20
 	/*
 	 * schedule NAPI in case of:
--=20
1.7.4.1

