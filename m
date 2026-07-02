Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1543C1979
	for <linux-can@vger.kernel.org>; Thu,  2 Jul 2026 14:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783001260; cv=none; b=LgT+wQUTpE7vLJCjf6RF67JftDYlKd3HRS09gROJA7o4qlBJOgLONBTSUYnu7RTqWbUFwZi3Nj1E9iVYGi/JOi3sJzA2DLzqjelANE/00Efm3g5DgYYWXGDNgOJHuabQiXocTiunziMqhQ8xI2AFEZjU2Jq7TTtonxq3qpmgG5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783001260; c=relaxed/simple;
	bh=qyTpcIRPWEscRWq1R4iL6JYhWk+HtX95/WPvHp692G0=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=KNaxz8cY+CM45q3bwlZWqIaoWBgm0sq0FtW8Z39KosHTwJ8TTexVi+ye8e0Ca7CUYEJin3LprDVA8Z/dZV6vLZxSLa4v3gpJggo21fNhhItlEaF42T5RqnyOI5BYDIbeff1EPWGoh/v+bPC9taZnMkBI8DGXH4Dc8KqvlJogy6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=XDRZAHdm; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="XDRZAHdm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1783001253; bh=P425fM/rBBS0j1oZORjD+XrNmSOQbuseZQzT9mLZQ04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XDRZAHdmJopGxJec+caVcRctsy5ybmEoG30WsPwM8SIkcoMUSi8V0KZIWqBBD/kIW
	 sklkMf6jjQP/BOXlf1LXdnPhi3kHgYJJZFRIB1xnWuK9knXCo6ToWKlpz1nISIEcHL
	 pgsmpolXOgrkn9zjltSIK6fl6qKgAC6RI+0mYqtY=
Received: from localhost.localdomain ([218.4.149.66])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id 1D09A800; Thu, 02 Jul 2026 22:07:16 +0800
X-QQ-mid: xmsmtpt1783001244te2v7ym0h
Message-ID: <tencent_F077D309CDB6CC4802CC086D8009E29BDF06@qq.com>
X-QQ-XMAILINFO: MRMtjO3A6C9XhJM17Yzj2wXaEfL9jFM469zyenpKe3msaZ+UNQ1Qfn03/6mJft
	 +buVv2jxkBDgXPwgOkV/dsIhsiE9KOTMgrnT8yaiq4uWX4m0+L2hwEqRchEFN3yNO/e+NAjaEeit
	 iHRIjvSG+fqAtz7V5GYm9e4etVMcJ9nInVYX6ioRyhMcJzE1fmTPwsiU/kovS7mha5oWhCn+0kCS
	 QLA6eVU4L7JEzQHWymn2Wa5R2QGRQr/hqtUlobntnC/NB1n7DsLUZorixbuGRktO0hkqq0BTbeFG
	 X0KkSgS1gRcSpjHdprUdfwEvLkJJYKpL4FcF4IcuIg3DFC/QHSRJytjNSV3kCge9BOssLpoAfGQT
	 meg5l8Pxqgmc1feCu5va21lewiX30BJ1k4rwYjgRiEk078dVYYB/x7CKTwHtPUCKgrzk+T/W1y52
	 yF3tjj3QhfF5+FJZmEWYqbuUWUKopf66yz3PSQahvucgZQOp3z6hrTx5jnf28H/klHsVmxfQHD0D
	 8qQ3HuEG9zW5LYgDFzxk4pA4iqb4BELTrT45KJTlIbh5oFvfPEdHjBJQhAm2aYg5xFzyLlnhJTm4
	 mTrzR6Yrb8tlzXB29s1ilFF9LY1PqbyYPMytLgcC5t7qF8M5Dq5AVEQcWlrMCmoYX6O6wKosNnXC
	 UcAghJ0sQZZ2LemNpWsLCD3aLNdjvq1nMiEQDCn+CLCMU1nIY62f6WDY0NpbpZwRJKBvLXpVpJBO
	 s4ME6RYXm52Sa78bDo5M4sLUvFgUY5HFzbAwE3rw2Xr+tbg29608PgL88LO31laizTkubvVFxZQd
	 c5hAyRCK2dp+cSBmEpWZlCfS5Sxsy3vbGBzrSCcvbCNTPRzXSFF8fKOE0wgJTn4GCXzYhFi8ARUS
	 FVpUpNTBX0mipqmdzanjt2OuQZglidq/NPIf1oaSWRdU3BIfYLjqrMAl7vwd59Rz7z7R57CNnzRN
	 nvdpX9jVFJtzmv1GLc7/N1IvKGqPe3Zl3dwfbN5R3VzweRPx7rwGfVfYT/IC8RCMyJQTArwnGiOo
	 8TxK5aY2r3pTPSLSDnbzkh1iJ5Za5L+fY5pHmUEDrXyGh8HIEX
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: 1579567540@qq.com
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	linux-can <linux-can@vger.kernel.org>
Cc: Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	kernel <kernel@pengutronix.de>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Eric Biggers <ebiggers@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	Yixun Lan <dlan@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	devicetree <devicetree@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	linux-rockchip <linux-rockchip@lists.infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Cunhao Lu <1579567540@qq.com>,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH v2 2/4] can: rockchip: add RK3588 CAN support
Date: Thu,  2 Jul 2026 22:06:52 +0800
X-OQ-MSGID: <20260702140654.2961561-3-1579567540@qq.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260702140654.2961561-1-1579567540@qq.com>
References: <20260702140654.2961561-1-1579567540@qq.com>
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

Keep RKCANFD_QUIRK_CANFD_BROKEN enabled for RK3588, so CAN-FD stays
disabled for now. Local testing did not reproduce the two known CAN-FD
trigger frames that cause Error Interrupts on RK3568 variants. Instead,
RK3588 shows a different CAN-FD failure mode: CAN-FD frames without BRS
work in this setup, but BRS with a data bitrate different from the
nominal bitrate immediately drives the controller bus-off.

Reported-by: Heiko Stuebner <heiko.stuebner@cherry.de>
Link: https://lore.kernel.org/lkml/20260630164336.3444550-4-heiko@sntech.de/

Signed-off-by: Cunhao Lu <1579567540@qq.com>
---
 .../net/can/rockchip/rockchip_canfd-core.c    | 12 +++++++++
 drivers/net/can/rockchip/rockchip_canfd-rx.c  |  5 +++-
 drivers/net/can/rockchip/rockchip_canfd.h     | 26 ++++++++++++++++++-
 3 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net/can/rockchip/rockchip_canfd-core.c
index 29de0c01e4ed..178d69edf1bb 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-core.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
@@ -50,6 +50,13 @@ static const struct rkcanfd_devtype_data rkcanfd_devtype_data_rk3568v3 = {
 		RKCANFD_QUIRK_CANFD_BROKEN,
 };
 
+static const struct rkcanfd_devtype_data rkcanfd_devtype_data_rk3588 = {
+	.model = RKCANFD_MODEL_RK3588,
+	.quirks = RKCANFD_QUIRK_RK3568_ERRATUM_5 |
+		RKCANFD_QUIRK_RK3568_ERRATUM_6 |
+		RKCANFD_QUIRK_CANFD_BROKEN,
+};
+
 static const char *__rkcanfd_get_model_str(enum rkcanfd_model model)
 {
 	switch (model) {
@@ -57,6 +64,8 @@ static const char *__rkcanfd_get_model_str(enum rkcanfd_model model)
 		return "rk3568v2";
 	case RKCANFD_MODEL_RK3568V3:
 		return "rk3568v3";
+	case RKCANFD_MODEL_RK3588:
+		return "rk3588";
 	}
 
 	return "<unknown>";
@@ -846,6 +855,9 @@ static const struct of_device_id rkcanfd_of_match[] = {
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
index 93131c7d7f54..82a617e4ca66 100644
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
@@ -408,6 +416,18 @@
  *     cansend can0 002##07217010000000000
  *   DUT:
  *     candump any,0:0,#FFFFFFFF -cexdHtA
+ *
+ * Tests on the rk3588 show a different CAN-FD failure mode: these two
+ * CAN-FD frames do not trigger Error Interrupt or Error-Warning. CAN-FD
+ * frames without bitrate switching work in this setup, but BRS with a
+ * data bitrate different from the nominal bitrate drives the controller
+ * bus-off immediately.
+ *
+ * To reproduce:
+ * host:
+ *   cangen can0 -I 2 -Li -Di -p 10 -f -g 1 -c32 -b
+ * DUT:
+ *   cansequence -rv can1 -f
  */
 #define RKCANFD_QUIRK_CANFD_BROKEN BIT(12)
 
@@ -424,6 +444,9 @@
  *     cansequence -rv -i 1
  *
  * - TX starvation after repeated Bus-Off
+ *   Tests on the rk3588 show the same problem. In a
+ *   10-cycle Bus-Off recovery test, 9 cycles failed to send after the
+ *   controller restarted.
  *   To reproduce:
  *   host:
  *     sleep 3 && cangen can0 -I2 -Li -Di -p10 -g 0.0
@@ -434,6 +457,7 @@
 enum rkcanfd_model {
 	RKCANFD_MODEL_RK3568V2 = 0x35682,
 	RKCANFD_MODEL_RK3568V3 = 0x35683,
+	RKCANFD_MODEL_RK3588 = 0x3588,
 };
 
 struct rkcanfd_devtype_data {
-- 
2.34.1

