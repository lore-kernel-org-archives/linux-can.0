Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9A13E1736;
	Tue,  7 Jul 2026 10:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783419893; cv=none; b=AM+u17UlvAdtR3m0Mj0GXs3Fz9vrddBU/I35m9q+ntJ5gssfboGre4Dbz6xJYs5URRqjqnukXZkiuSD70jNfyby9VCKWb/CR5QEjvpHX01WQ0aAntrW3mNYy5JKbI28RXwXw4NjoW70dUjSkDsmXL8rl85mJFgYlmizFQiipDRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783419893; c=relaxed/simple;
	bh=MZJ7Hd/vCUj3mk7MLVlPkN71CzC7Z+KRw4aNarsAn88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gZ1J6Q3wJyZihH7aDoMd3jlR6dN2oe1estDiWC3Gp7YOslVwUCbwVjKJJpkQAeA9e2O2X+de4kkSwePFVA8NBLj5nGbTeAPz5OTCcnGfl3nzVKLGrTWNTANxhpfgtDB3PkC94iu5PVfckXYh4L0w76hFcheWhFqpGTO/Izh2UEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06FAA1F000E9;
	Tue,  7 Jul 2026 10:24:47 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea+renesas@tuxon.dev>
To: mkl@pengutronix.de,
	mailhol@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	bmasney@redhat.com,
	biju.das.jz@bp.renesas.com,
	tu.nguyen.xg@renesas.com,
	fabrizio.castro.jz@renesas.com
Cc: claudiu.beznea@tuxon.dev,
	linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 6/8] can: rcar_canfd: Add support for Renesas RZ/G3S
Date: Tue,  7 Jul 2026 13:24:16 +0300
Message-ID: <20260707102418.1646159-7-claudiu.beznea+renesas@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707102418.1646159-1-claudiu.beznea+renesas@tuxon.dev>
References: <20260707102418.1646159-1-claudiu.beznea+renesas@tuxon.dev>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Add support for Renesas RZ/G3S

The Renesas RZ/G3S CAN-FD controller is largely compatible with the
variant found on the Renesas RZ/G3E. The main differences are:
- the RZ/G3S provides 128 acceptance filters
- the RZ/G3S supports only two channels
- the RZ/G3S supports only CAN-FD operation and does not implement the
  bits used to select between classical CAN-only and CAN FD-only modes.
- the RZ/G3S includes an internal divider that allows the peripheral
  clock to be used as the CAN FD clock source.

Add support for the Renesas RZ/G3S.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 9b0a67195824..bcb91fc0a35a 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -661,6 +661,25 @@ static const struct rcar_canfd_hw_info rzg2l_hw_info = {
 	.mode_select_na = 0,
 };
 
+static const struct rcar_canfd_hw_info r9a08g045_hw_info = {
+	.nom_bittiming = &rcar_canfd_gen4_nom_bittiming_const,
+	.data_bittiming = &rcar_canfd_gen4_data_bittiming_const,
+	.tdc_const = &rcar_canfd_gen4_tdc_const,
+	.regs = &rcar_gen4_regs,
+	.sh = &rcar_gen4_shift_data,
+	.rnc_field_width = 16,
+	.max_aflpn = 127,
+	.max_cftml = 31,
+	.max_channels = 2,
+	.postdiv = 2,
+	.multi_channel_irqs = 1,
+	.ch_interface_mode = 1,
+	.shared_can_regs = 1,
+	.external_clk = 1,
+	.fcan_pclk = 1,
+	.mode_select_na = 1,
+};
+
 static const struct rcar_canfd_hw_info r9a09g047_hw_info = {
 	.nom_bittiming = &rcar_canfd_gen4_nom_bittiming_const,
 	.data_bittiming = &rcar_canfd_gen4_data_bittiming_const,
@@ -2382,6 +2401,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(rcar_canfd_pm_ops, rcar_canfd_suspend,
 
 static const __maybe_unused struct of_device_id rcar_canfd_of_table[] = {
 	{ .compatible = "renesas,r8a779a0-canfd", .data = &rcar_gen4_hw_info },
+	{ .compatible = "renesas,r9a08g045-canfd", .data = &r9a08g045_hw_info },
 	{ .compatible = "renesas,r9a09g047-canfd", .data = &r9a09g047_hw_info },
 	{ .compatible = "renesas,r9a09g077-canfd", .data = &r9a09g077_hw_info },
 	{ .compatible = "renesas,rcar-gen3-canfd", .data = &rcar_gen3_hw_info },
-- 
2.43.0

