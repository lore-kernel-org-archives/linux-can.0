From: Benoit <benoit@pouic.eu>
Subject: mcp251x.c : patch to avoid repeated frame bug
Date: Mon, 27 Aug 2012 15:02:45 +0200
Message-ID: <503B6FF5.6000800@pouic.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from pouic.eu ([109.190.18.85]:60364 "EHLO smtp.pouic.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751136Ab2H0NMA (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 27 Aug 2012 09:12:00 -0400
Received: from [163.157.129.250] (gw.skf.net [163.157.254.25])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.pouic.eu (Magpie Mail Daemon) with ESMTPSA id 4BAFF28A064
	for <linux-can@vger.kernel.org>; Mon, 27 Aug 2012 15:02:48 +0200 (CEST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hello,

The MCP2515 has a silicon bug causing repeated frame transmission, see=20
section 5 of MCP2515 Rev. B Silicon Errata Revision G (March 2007).

Basically, setting TXBnCTRL.TXREQ in either SPI mode (00 or 11) will=20
eventually cause the bug. The workaround proposed by Microchip is to us=
e=20
mode 00 and send an RTS command on the SPI bus to initiate the=20
transmission. Accordingly, I have modified the transmission routine as=20
follows in file mcp251x.c:


--- drivers/net/can/mcp251x.c-original	2012-08-26 15:00:28.000000000 +0=
200
+++ drivers/net/can/mcp251x.c	2012-08-26 20:42:58.000000000 +0200
@@ -83,6 +83,10 @@
  #define INSTRUCTION_LOAD_TXB(n)	(0x40 + 2 * (n))
  #define INSTRUCTION_READ_RXB(n)	(((n) =3D=3D 0) ? 0x90 : 0x94)
  #define INSTRUCTION_RESET	0xC0
+#define	RTS_TXB0		0x01
+#define	RTS_TXB1		0x02
+#define	RTS_TXB2		0x04
+#define INSTRUCTION_RTS(txb)	(0x80 | ((txb) & 0x07))
 =20
  /* MPC251x registers */
  #define CANSTAT	      0x0e
@@ -394,9 +398,20 @@
  	}
  }
 =20
+
+/*
+ * CAN frame is now sent using instruction RTS over SPI to work around
+ * repeated frame problem as per MCP2515 Rev B. Silicon Errata revisio=
n G
+ * (March 2007) about repeated frames (see section 5 of document).
+ * Note that repeated frames can still occur if using SPI mode 11. It =
seems
+ * however that spi mode is forcibly set to 0, so it looks safe.
+ *
+ */
  static void mcp251x_hw_tx(struct spi_device *spi, struct can_frame *f=
rame,
  			  int tx_buf_idx)
  {
+	struct mcp251x_priv *priv =3D dev_get_drvdata(&spi->dev);
+	int ret;
  	u32 sid, eid, exide, rtr;
  	u8 buf[SPI_TRANSFER_BUF_LEN];
 =20
@@ -418,7 +433,12 @@
  	buf[TXBDLC_OFF] =3D (rtr << DLC_RTR_SHIFT) | frame->can_dlc;
  	memcpy(buf + TXBDAT_OFF, frame->data, frame->can_dlc);
  	mcp251x_hw_tx_frame(spi, buf, frame->can_dlc, tx_buf_idx);
-	mcp251x_write_reg(spi, TXBCTRL(tx_buf_idx), TXBCTRL_TXREQ);
+
+	priv->spi_tx_buf[0] =3D INSTRUCTION_RTS(1 << tx_buf_idx);
+	ret =3D spi_write(spi, priv->spi_tx_buf, 1);
+	if (ret) {
+		dev_err(&spi->dev, "RTS failed: ret =3D %d\n", ret);
+	}
  }
 =20
  static void mcp251x_hw_rx_frame(struct spi_device *spi, u8 *buf,



Would it be possible to integrate this patch into mainstream mcp251x.c?

Kind Regards,

Beno=EEt.
