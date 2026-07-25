Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F1E30C619;
	Sat, 25 Jul 2026 07:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784963207; cv=none; b=fAkrMrlG/sIPuXbR6xuZZ45QpwKrMtTIdAvs89SBFSAwOUuCM/F99ZIf2lXV4rq/wulH/EQKbVIje3M/dP1VK/Ysx4u8hT6LG7wzz/6VvXt2woEc7roJnPw5sLRzgJoGpWIpyTSJthLbNDZkD0xbEkCpw16rk027/KyTVM3dQ+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784963207; c=relaxed/simple;
	bh=vrPHEB3+w5G35GPR9mPHQPx28fJ2c9qaFskX6Ayye+4=;
	h=Message-ID:From:Date:Subject:MIME-Version:Content-Type:References:
	 In-Reply-To:To:Cc; b=cBAJYix0hK7chG5l4P0Iw+CciaD4yTS8E+O+aMh4WVwBB+39TsKv/5L0Twf0kotZjiLuBJUMfdT/h/8TgfFTz5lf/thhbJME51VNPpY4s6vhB8Ymq4xmB4BK3v5GQ810+T54DkPeqrDbepxixlW3ywMzkKIfY3OPTWVj4khbX1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=AEuDMnlz; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="AEuDMnlz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1784963193; bh=Qx4ZowKxWnzVWcBE/a6+0KeQkOIKkkshmtvZgxCaZNY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=AEuDMnlz0nHkk6uuoVQ3sXJLsCuR5v/GOpMNOs+IyVYsdGdl3yuS6m2m7M4b1aBpX
	 PTbqyuTqyKHPaRQrxMbGO+AfhLuj2ILGeLVy7peM85JcBTbkzeHeCrT/4+16Y+Vuq6
	 F3C3XZ98YfPi/xwuS9wYmqiRzW8u93qMoeFcGreQ=
Received: from ubuntu2204.localdomain ([2409:8d20:22b:54c:9e54:40ff:fe02:3f0f])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id 19989659; Sat, 25 Jul 2026 15:06:25 +0800
X-QQ-mid: xmsmtpt1784963190tpuv695f1
Message-ID: <tencent_3B918005C4443FD426089A7919D104BD9107@qq.com>
X-QQ-XMAILINFO: NnYhxYSyuBnLSyF5aWrA5BuxYg6Vu4kBCEoYR5pKGishmpaTaj1xJurE+7G+IF
	 6Zck5cgIZs1GsSHjxyra/5fexNlhy/PO9ry7LnGpxZ3njGYQwUxQ9LORfZfWTiBTKPx+lNv2f0f1
	 QqKHYD6xcKlwCJbT9Cmt+ZEjeUF6Y5r3Yg5Qs/X0JQkW3tkdSaFopMewAq1B+qUIlvMr3PX+8KAo
	 ZTgcEaax/35qSfh9a9SAHzTNw73grHuDElXG1naH9sH96DUI/kf2jYXB9EF+Uqhe5rER42MMVkgN
	 Q7MlM6USr61O7z7Tyx960GpaU6pLRbHb0Mx+HpikPjxGr+9Fj4WYXr0AQqodl3gMQmoLlJmpXLw9
	 bVTchYTZXBJAMigrPb9mJuOMjFbo4zyi4s2ISyQ8ZHm+ljho/H/cy1GvgEz5MKniGsLVXrVOW/c3
	 5SOK6GBAyGs0EPreJpMo/e4UzbrXtY5r9BXqr/d7a1iUCpj6bkSnOpmKxR6ETiu0wqzxA9Iy1ifS
	 WXzlGGQ4Rlw+TSDF2CxLZujtKq7zSMty4MdPohMFJijDtaE+b9r2Ky2hft6oSsWzK3F++chxL6yC
	 Nr8XPPzasIebf7KuePjwri/fV4YzAO8uPybvACNvK8Vku1uLz/8B5v63qFge+0MM/a7USCG4QrWz
	 oRMTVOpKJkRFzGflpA3M+olYe9EpX8abGQlm4gVdpIhBBWqJsSjxtSrarOT1BuMAYOZwEPGT5nsJ
	 prBu8aORSD5o9tfzo1TO2dyEN4l+WbWmaDmdgGvazQ5+x+nkiM2WiYWudwL3V8+t8riFJJY3RWC6
	 VPpTHE2lkK4+kQweuOy3CxtZpum9oXkYFSlFkjvS5gYrmdeiQAi2SHM5mxYggaw8nytInuZRmwdd
	 HG0rpAZdR21qk/ubHGTTRM2Q7CFlqJwxrjIAl42t3Oee3eG/dWTUxQDXgH4v/E1Hfs630PDNXqdg
	 sXftDPl97z12NrULWHIo0IMmynloxgHavQVbGAd+uJp6iZdUOmmI/5s/m1kyClWX3lrtA5d7UQl8
	 QiaUgQYk69ZB8YPt2SUV93w4vPTzKAzoE5v7k0kn/VHJPQc0ir111Gl2am64mVzzpROvky6bWnhb
	 Rb4OxwjUvCzn2yjARcq8B0zF9SBSZbFK6mwlmpSu1cHFWmKQdJT66Td0shGatR5wsj+OicDSbxqK
	 Ia4QyJ4nAcU8+9ZKS4Bc/OglFL
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Cunhao Lu <1579567540@qq.com>
Date: Sat, 25 Jul 2026 15:03:32 +0800
Subject: [PATCH v5 2/4] can: rockchip: add RK3588 CAN support
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-OQ-MSGID: <20260725-master-v5-2-75da459d2b93@qq.com>
References: <20260725-master-v5-0-75da459d2b93@qq.com>
In-Reply-To: <20260725-master-v5-0-75da459d2b93@qq.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-can@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Cunhao Lu <1579567540@qq.com>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>
X-Mailer: b4 0.15.2

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
Signed-off-by: Cunhao Lu <1579567540@qq.com>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
---
v3 -> v4:
- Disable TDC on RK3588 by programming
  RKCANFD_REG_TRANSMIT_DELAY_COMPENSATION to 0.
- Drop RKCANFD_QUIRK_CANFD_BROKEN for RK3588 and enable CAN-FD support.
- Document successful RK3588 CAN-FD/BRS testing.
v2 -> v3:
- Use Co-developed-by for Heiko's RK3588 contributions and add his
  Signed-off-by
- Collect Heiko's Reviewed-by and Tested-by tags
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
2.34.1

