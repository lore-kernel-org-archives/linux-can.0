From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH] can: mcp251x: avoid repeated frame bug
Date: Mon,  3 Sep 2012 14:17:29 +0200
Message-ID: <1346674649-10181-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35202 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752724Ab2ICMRf (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 3 Sep 2012 08:17:35 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Benoit <benoit@pouic.eu>, Marc Kleine-Budde <mkl@pengutronix.de>

From: Benoit <benoit@pouic.eu>

The MCP2515 has a silicon bug causing repeated frame transmission, see section
5 of MCP2515 Rev. B Silicon Errata Revision G (March 2007).

Basically, setting TXBnCTRL.TXREQ in either SPI mode (00 or 11) will eventually
cause the bug. The workaround proposed by Microchip is to use mode 00 and send
an RTS command on the SPI bus to initiate the transmission.

TODO: get S-o-b from Benoit <benoit@pouic.eu>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Hello Benoit,

can you please test this patch, if it still fixes your problem. In order to
integrate this patch into the kernel, I need you Signed-off-by [1] with you
real name.

regards, Marc

[1] http://lxr.free-electrons.com/source/Documentation/SubmittingPatches#L298

 drivers/net/can/mcp251x.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/mcp251x.c b/drivers/net/can/mcp251x.c
index a580db2..26e7129 100644
--- a/drivers/net/can/mcp251x.c
+++ b/drivers/net/can/mcp251x.c
@@ -83,6 +83,11 @@
 #define INSTRUCTION_LOAD_TXB(n)	(0x40 + 2 * (n))
 #define INSTRUCTION_READ_RXB(n)	(((n) == 0) ? 0x90 : 0x94)
 #define INSTRUCTION_RESET	0xC0
+#define RTS_TXB0		0x01
+#define RTS_TXB1		0x02
+#define RTS_TXB2		0x04
+#define INSTRUCTION_RTS(n)	(0x80 | ((n) & 0x07))
+
 
 /* MPC251x registers */
 #define CANSTAT	      0x0e
@@ -397,6 +402,7 @@ static void mcp251x_hw_tx_frame(struct spi_device *spi, u8 *buf,
 static void mcp251x_hw_tx(struct spi_device *spi, struct can_frame *frame,
 			  int tx_buf_idx)
 {
+	struct mcp251x_priv *priv = dev_get_drvdata(&spi->dev);
 	u32 sid, eid, exide, rtr;
 	u8 buf[SPI_TRANSFER_BUF_LEN];
 
@@ -418,7 +424,10 @@ static void mcp251x_hw_tx(struct spi_device *spi, struct can_frame *frame,
 	buf[TXBDLC_OFF] = (rtr << DLC_RTR_SHIFT) | frame->can_dlc;
 	memcpy(buf + TXBDAT_OFF, frame->data, frame->can_dlc);
 	mcp251x_hw_tx_frame(spi, buf, frame->can_dlc, tx_buf_idx);
-	mcp251x_write_reg(spi, TXBCTRL(tx_buf_idx), TXBCTRL_TXREQ);
+
+	/* use INSTRUCTION_RTS, to avoid "repeated frame problem" */
+	priv->spi_tx_buf[0] = INSTRUCTION_RTS(1 << tx_buf_idx);
+	mcp251x_spi_trans(priv->spi, 1);
 }
 
 static void mcp251x_hw_rx_frame(struct spi_device *spi, u8 *buf,
-- 
1.7.10

