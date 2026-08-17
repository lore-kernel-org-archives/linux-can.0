Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95B03D79FE;
	Mon, 17 Aug 2026 23:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787009671; cv=none; b=ccjBk+sITAyUPAw6dCuPRI5TGGwbQUpnCADyJwZaWnoyMpkTCbNNjiGndUt0cxJsXa9fj756N76+a6YxshkTCPFhBLJqWCs/PwcGgarJym/hgO13bxtC9zI07cR+jWRFbhSEpwobzZtTWvdKiqDgMzXZ5P9YCOE9mx3Hs78kR20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787009671; c=relaxed/simple;
	bh=UlFdctv6A1UJYdCVZtpgAqOme882oJBMdCrhjZ63vc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eJc5Y0p7Su1g+gMZjKHHIryZyyBiLOuvneQ9OPHuBSIlIoIFTniIok+01any10mszWcbpsfohyEHfHkzZIPQuDzLvRpi6J30Ce9aKPDrroUWUbwCeBkNpBSryb0fGGbHxQCGDVjimWuB1nBKFKDqke6JLZCjMhGfBOXzX/FCeqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id A94DC202281;
	Tue, 18 Aug 2026 01:34:22 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ww6qU-00220i-1Z;
	Tue, 18 Aug 2026 01:34:22 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 2C4A6585156;
	Mon, 17 Aug 2026 23:34:22 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Cunhao Lu <1579567540@qq.com>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Heiko Stuebner <heiko@sntech.de>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 03/11] can: rockchip: add RK3588 CAN support
Date: Tue, 18 Aug 2026 01:24:30 +0200
Message-ID: <20260817233420.2068204-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817233420.2068204-1-mkl@pengutronix.de>
References: <20260817233420.2068204-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cunhao Lu <1579567540@qq.com>

Add support for the RK3588 CAN controller by introducing a dedicated
model ID and OF match entry.

The block is closely related to the existing RK3568 variants, but it
cannot reuse their match data unchanged. In particular, RK3588
encodes RX_FIFO_CNT in bits 7:5 instead of 6:4, so the RX path needs
SoC-specific handling.

The RX FIFO count bitfield difference was found by comparing Rockchip's
vendor kernel 6.1 CAN support for RK3568 and RK3588. Runtime testing on
RK3588 also confirms that bits 7:5 are needed.

Enable the existing erratum 5 empty-FIFO workaround for RK3588.
Heiko reproduced erratum 6 on RK3588, so enable that workaround as
well.

CAN-FD is enabled for RK3588. The BRS bus-off issue seen in earlier
testing was caused by the transmit delay compensation setting. With
RKCANFD_REG_TRANSMIT_DELAY_COMPENSATION programmed to 0 on RK3588,
CAN-FD with BRS works in local testing.

Tested on an embedfire,rk3588-lubancat-5io board with can0/can1
directly connected, no other device on the bus, 60 Ohm bus
termination, and a 300 MHz CAN clock. Runtime testing used 500 kbit/s
arbitration bitrate and 1, 3 and 5 Mbit/s data bitrates. The 5 Mbit/s
data phase test ran for 15 minutes with cangen using BRS and
cansequence on the receiver. Both interfaces reported 9528377 packets
and 150667356 bytes, with 0 bus-errors, 0 error-warn, 0 error-pass and
0 bus-off events.

Co-developed-by: Heiko Stuebner <heiko.stuebner@cherry.de>
Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Cunhao Lu <1579567540@qq.com>
Link: https://patch.msgid.link/tencent_207E464D12344B3228096E23A001D6882508@qq.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rockchip/rockchip_canfd-core.c | 17 +++++++++++++++++
 drivers/net/can/rockchip/rockchip_canfd-rx.c   |  5 ++++-
 drivers/net/can/rockchip/rockchip_canfd.h      | 14 +++++++++++++-
 3 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net/can/rockchip/rockchip_canfd-core.c
index 29de0c01e4ed..37c1c22c40c9 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-core.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
@@ -50,6 +50,12 @@ static const struct rkcanfd_devtype_data rkcanfd_devtype_data_rk3568v3 = {
 		RKCANFD_QUIRK_CANFD_BROKEN,
 };
 
+static const struct rkcanfd_devtype_data rkcanfd_devtype_data_rk3588 = {
+	.model = RKCANFD_MODEL_RK3588,
+	.quirks = RKCANFD_QUIRK_RK3568_ERRATUM_5 |
+		RKCANFD_QUIRK_RK3568_ERRATUM_6,
+};
+
 static const char *__rkcanfd_get_model_str(enum rkcanfd_model model)
 {
 	switch (model) {
@@ -57,6 +63,8 @@ static const char *__rkcanfd_get_model_str(enum rkcanfd_model model)
 		return "rk3568v2";
 	case RKCANFD_MODEL_RK3568V3:
 		return "rk3568v3";
+	case RKCANFD_MODEL_RK3588:
+		return "rk3588";
 	}
 
 	return "<unknown>";
@@ -148,6 +156,12 @@ static int rkcanfd_set_bittiming(struct rkcanfd_priv *priv)
 
 	rkcanfd_write(priv, RKCANFD_REG_FD_DATA_BITTIMING, reg_dbt);
 
+	/* RK3588 CAN-FD BRS works with TDC disabled. */
+	if (priv->devtype_data.model == RKCANFD_MODEL_RK3588) {
+		rkcanfd_write(priv, RKCANFD_REG_TRANSMIT_DELAY_COMPENSATION, 0);
+		return 0;
+	}
+
 	tdco = (priv->can.clock.freq / dbt->bitrate) * 2 / 3;
 	tdco = min(tdco, FIELD_MAX(RKCANFD_REG_TRANSMIT_DELAY_COMPENSATION_TDC_OFFSET));
 
@@ -846,6 +860,9 @@ static const struct of_device_id rkcanfd_of_match[] = {
 	}, {
 		.compatible = "rockchip,rk3568v3-canfd",
 		.data = &rkcanfd_devtype_data_rk3568v3,
+	}, {
+		.compatible = "rockchip,rk3588-canfd",
+		.data = &rkcanfd_devtype_data_rk3588,
 	}, {
 		/* sentinel */
 	},
diff --git a/drivers/net/can/rockchip/rockchip_canfd-rx.c b/drivers/net/can/rockchip/rockchip_canfd-rx.c
index 475c0409e215..24e87daa1df0 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-rx.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-rx.c
@@ -281,7 +281,10 @@ rkcanfd_rx_fifo_get_len(const struct rkcanfd_priv *priv)
 {
 	const u32 reg = rkcanfd_read(priv, RKCANFD_REG_RX_FIFO_CTRL);
 
-	return FIELD_GET(RKCANFD_REG_RX_FIFO_CTRL_RX_FIFO_CNT, reg);
+	if (priv->devtype_data.model == RKCANFD_MODEL_RK3588)
+		return FIELD_GET(RKCANFD_REG_RX_FIFO_CTRL_RX_FIFO_CNT_RK3588, reg);
+
+	return FIELD_GET(RKCANFD_REG_RX_FIFO_CTRL_RX_FIFO_CNT_RK3568, reg);
 }
 
 int rkcanfd_handle_rx_int(struct rkcanfd_priv *priv)
diff --git a/drivers/net/can/rockchip/rockchip_canfd.h b/drivers/net/can/rockchip/rockchip_canfd.h
index 93131c7d7f54..95bea9bfd8a2 100644
--- a/drivers/net/can/rockchip/rockchip_canfd.h
+++ b/drivers/net/can/rockchip/rockchip_canfd.h
@@ -214,7 +214,8 @@
 #define RKCANFD_REG_TXEVENT_FIFO_CTRL_TXE_FIFO_ENABLE BIT(0)
 
 #define RKCANFD_REG_RX_FIFO_CTRL 0x118
-#define RKCANFD_REG_RX_FIFO_CTRL_RX_FIFO_CNT GENMASK(6, 4)
+#define RKCANFD_REG_RX_FIFO_CTRL_RX_FIFO_CNT_RK3568 GENMASK(6, 4)
+#define RKCANFD_REG_RX_FIFO_CTRL_RX_FIFO_CNT_RK3588 GENMASK(7, 5)
 #define RKCANFD_REG_RX_FIFO_CTRL_RX_FIFO_FULL_WATERMARK GENMASK(3, 1)
 #define RKCANFD_REG_RX_FIFO_CTRL_RX_FIFO_ENABLE BIT(0)
 
@@ -331,6 +332,11 @@
  * rarely with the standard clock of 300 MHz, but almost immediately
  * at 80 MHz.
  *
+ * Tests on the rk3588 show the same empty FIFO condition.
+ * In that setup rx_fifo_empty_errors increments when the bus
+ * transitions from idle to high CAN-FD load and stops growing once
+ * the bus reaches a steady state.
+ *
  * To workaround this problem, check for empty FIFO with
  * rkcanfd_fifo_header_empty() in rkcanfd_handle_rx_int_one() and exit
  * early.
@@ -344,6 +350,8 @@
 /* Erratum 6: The CAN controller's transmission of extended frames may
  * intermittently change into standard frames
  *
+ * Tests on the rk3588 show the same problem.
+ *
  * Work around this issue by activating self reception (RXSTX). If we
  * have pending TX CAN frames, check all RX'ed CAN frames in
  * rkcanfd_rxstx_filter().
@@ -424,6 +432,9 @@
  *     cansequence -rv -i 1
  *
  * - TX starvation after repeated Bus-Off
+ *   Tests on the rk3588 show the same problem. In a
+ *   10-cycle Bus-Off recovery test, 9 cycles failed to send after the
+ *   controller restarted.
  *   To reproduce:
  *   host:
  *     sleep 3 && cangen can0 -I2 -Li -Di -p10 -g 0.0
@@ -434,6 +445,7 @@
 enum rkcanfd_model {
 	RKCANFD_MODEL_RK3568V2 = 0x35682,
 	RKCANFD_MODEL_RK3568V3 = 0x35683,
+	RKCANFD_MODEL_RK3588 = 0x3588,
 };
 
 struct rkcanfd_devtype_data {
-- 
2.53.0

