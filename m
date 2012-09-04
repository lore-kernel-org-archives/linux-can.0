From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH] can: mcp251x: avoid repeated frame bug
Date: Tue,  4 Sep 2012 22:55:42 +0200
Message-ID: <1346792142-17609-2-git-send-email-mkl@pengutronix.de>
References: <1346792142-17609-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35288 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757685Ab2IDUz4 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 4 Sep 2012 16:55:56 -0400
In-Reply-To: <1346792142-17609-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, =?UTF-8?q?Beno=C3=AEt=20Locher?= <Benoit.Locher@skf.com>, stable@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>

=46rom: Beno=C3=AEt Locher <Benoit.Locher@skf.com>

The MCP2515 has a silicon bug causing repeated frame transmission, see =
section
5 of MCP2515 Rev. B Silicon Errata Revision G (March 2007).

Basically, setting TXBnCTRL.TXREQ in either SPI mode (00 or 11) will ev=
entually
cause the bug. The workaround proposed by Microchip is to use mode 00 a=
nd send
a RTS command on the SPI bus to initiate the transmission.

Cc: <stable@vger.kernel.org>
Signed-off-by: Beno=C3=AEt Locher <Benoit.Locher@skf.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/mcp251x.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/mcp251x.c b/drivers/net/can/mcp251x.c
index a580db2..26e7129 100644
--- a/drivers/net/can/mcp251x.c
+++ b/drivers/net/can/mcp251x.c
@@ -83,6 +83,11 @@
 #define INSTRUCTION_LOAD_TXB(n)	(0x40 + 2 * (n))
 #define INSTRUCTION_READ_RXB(n)	(((n) =3D=3D 0) ? 0x90 : 0x94)
 #define INSTRUCTION_RESET	0xC0
+#define RTS_TXB0		0x01
+#define RTS_TXB1		0x02
+#define RTS_TXB2		0x04
+#define INSTRUCTION_RTS(n)	(0x80 | ((n) & 0x07))
+
=20
 /* MPC251x registers */
 #define CANSTAT	      0x0e
@@ -397,6 +402,7 @@ static void mcp251x_hw_tx_frame(struct spi_device *=
spi, u8 *buf,
 static void mcp251x_hw_tx(struct spi_device *spi, struct can_frame *fr=
ame,
 			  int tx_buf_idx)
 {
+	struct mcp251x_priv *priv =3D dev_get_drvdata(&spi->dev);
 	u32 sid, eid, exide, rtr;
 	u8 buf[SPI_TRANSFER_BUF_LEN];
=20
@@ -418,7 +424,10 @@ static void mcp251x_hw_tx(struct spi_device *spi, =
struct can_frame *frame,
 	buf[TXBDLC_OFF] =3D (rtr << DLC_RTR_SHIFT) | frame->can_dlc;
 	memcpy(buf + TXBDAT_OFF, frame->data, frame->can_dlc);
 	mcp251x_hw_tx_frame(spi, buf, frame->can_dlc, tx_buf_idx);
-	mcp251x_write_reg(spi, TXBCTRL(tx_buf_idx), TXBCTRL_TXREQ);
+
+	/* use INSTRUCTION_RTS, to avoid "repeated frame problem" */
+	priv->spi_tx_buf[0] =3D INSTRUCTION_RTS(1 << tx_buf_idx);
+	mcp251x_spi_trans(priv->spi, 1);
 }
=20
 static void mcp251x_hw_rx_frame(struct spi_device *spi, u8 *buf,
--=20
1.7.10

