From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 1/2] can: flexcan: fix regression in flexcan_chip_start(), abort pending TX
Date: Fri,  4 Oct 2013 12:48:52 +0200
Message-ID: <1380883733-11995-2-git-send-email-mkl@pengutronix.de>
References: <1380883733-11995-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59317 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149Ab3JDKtH (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 4 Oct 2013 06:49:07 -0400
In-Reply-To: <1380883733-11995-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: kernel@pengutronix.de, =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>, Marc Kleine-Budde <mkl@pengutronix.de>

In patch

    0d1862e can: flexcan: fix flexcan_chip_start() on imx6

the loop in flexcan_chip_start() that iterates over all mailboxes after=
 the
soft reset of the CAN core was removed. This loop put all mailboxes (ev=
en the
ones marked as reserved 1...7) into EMPTY/INACTIVE mode. On mailbox 8, =
which is
used for TX, this aborts any pending TX messages.

If the interface is disabled with a pending message (usually due to an =
error
condition on the CAN bus), this message is retransmitted after enabling=
 the
interface again. This patch fixes the regression by putting only the TX=
 mailbox
into EMPTY/INACTIVE, so that the CAN core is properly reset on interfac=
e
(re)activation.

Cc: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 3f21142..82a23dd 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -771,6 +771,10 @@ static int flexcan_chip_start(struct net_device *d=
ev)
 	netdev_dbg(dev, "%s: writing ctrl=3D0x%08x", __func__, reg_ctrl);
 	flexcan_write(reg_ctrl, &regs->ctrl);
=20
+	/* Abort any pending TX, mark Mailbox as INACTIVE */
+	flexcan_write(FLEXCAN_MB_CNT_CODE(0x4),
+		      &regs->cantxfg[FLEXCAN_TX_BUF_ID].can_ctrl);
+
 	/* acceptance mask/acceptance code (accept everything) */
 	flexcan_write(0x0, &regs->rxgmask);
 	flexcan_write(0x0, &regs->rx14mask);
--=20
1.8.4.rc3

