Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7033E0230;
	Tue,  7 Jul 2026 10:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783419884; cv=none; b=E4qKN6Ne8arPcUsNs071MD30/yv5qENw+tDX72HOSdlM9vRo5TuGPioxk+NfDWLD4NszeBLQjWkj2VpWoToGhMIbE4fr7mZ07AfPmF3xaFSAuXThUS24a9dalepLFH/6+bbmHqHqvAc9vmoGGRDhk9+3UpZV3ijIwz3KSNwtJzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783419884; c=relaxed/simple;
	bh=rJgIeaS/Q8CeIUARWgHx+LCbqAfJHRbtvbdY6oK32XM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rV1I0QJ+ceGAIx7C91VDMQ+2yM/SYgXhGqFYffd2Pf07Bckczz9VIGwMNZqSkhJMd009DBINjnZohqbC0Opy4s8rxKY/9ZM42mQ09mpGpLfBZFFXzXQbCJXI2qntxq87rfxzWWPtZzJAtc3MlFyPhhDfE0tYWpHfWHTmsknoeuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EDBE1F000E9;
	Tue,  7 Jul 2026 10:24:39 +0000 (UTC)
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
Subject: [PATCH 4/8] can: rcar_canfd: Allow the CAN FD clock to be sourced from fck
Date: Tue,  7 Jul 2026 13:24:14 +0300
Message-ID: <20260707102418.1646159-5-claudiu.beznea+renesas@tuxon.dev>
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

On the Renesas RZ/G3S, the CAN FD clock can be sourced either from fck
(the peripheral clock) or from an external clock (can_clk). When fck is
used, it is divided internally by the CAN FD controller.

Adjust the existing canfd clock handling code to support the RZ/G3S CAN.

The existing struct rcar_canfd_hw_info instances were updated to address
the request in the Link discussion.

Link: https://lore.kernel.org/all/1d9719e3-10ff-4cd8-b729-55fea93c37ce@wanadoo.fr
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 879f31c97276..75512d41e3ee 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -444,6 +444,7 @@ struct rcar_canfd_hw_info {
 	unsigned ch_interface_mode:1;	/* Has channel interface mode */
 	unsigned shared_can_regs:1;	/* Has shared classical can registers */
 	unsigned external_clk:1;	/* Has external clock */
+	unsigned fcan_pclk:1;		/* Has fcan sourced from pclk. */
 };
 
 /* Channel priv data */
@@ -617,6 +618,7 @@ static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
 	.ch_interface_mode = 0,
 	.shared_can_regs = 0,
 	.external_clk = 1,
+	.fcan_pclk = 0,
 };
 
 static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
@@ -634,6 +636,7 @@ static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
 	.ch_interface_mode = 1,
 	.shared_can_regs = 1,
 	.external_clk = 1,
+	.fcan_pclk = 0,
 };
 
 static const struct rcar_canfd_hw_info rzg2l_hw_info = {
@@ -651,6 +654,7 @@ static const struct rcar_canfd_hw_info rzg2l_hw_info = {
 	.ch_interface_mode = 0,
 	.shared_can_regs = 0,
 	.external_clk = 1,
+	.fcan_pclk = 0,
 };
 
 static const struct rcar_canfd_hw_info r9a09g047_hw_info = {
@@ -668,6 +672,7 @@ static const struct rcar_canfd_hw_info r9a09g047_hw_info = {
 	.ch_interface_mode = 1,
 	.shared_can_regs = 1,
 	.external_clk = 0,
+	.fcan_pclk = 0,
 };
 
 static const struct rcar_canfd_hw_info r9a09g077_hw_info = {
@@ -685,6 +690,7 @@ static const struct rcar_canfd_hw_info r9a09g077_hw_info = {
 	.ch_interface_mode = 1,
 	.shared_can_regs = 1,
 	.external_clk = 1,
+	.fcan_pclk = 0,
 };
 
 /* Helper functions */
@@ -2191,13 +2197,18 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 	 */
 	gpriv->can_clk = devm_clk_get(dev, "can_clk");
 	if (IS_ERR(gpriv->can_clk) || (clk_get_rate(gpriv->can_clk) == 0)) {
-		gpriv->can_clk = devm_clk_get(dev, "canfd");
+		gpriv->can_clk = devm_clk_get_optional(dev, "canfd");
 		if (IS_ERR(gpriv->can_clk))
 			return dev_err_probe(dev, PTR_ERR(gpriv->can_clk),
 					     "cannot get canfd clock\n");
 
+		if (gpriv->can_clk)
+			fcan_freq = clk_get_rate(gpriv->can_clk);
+		else if (info->fcan_pclk)
+			fcan_freq = clk_get_rate(gpriv->clkp);
+
 		/* CANFD clock may be further divided within the IP */
-		fcan_freq = clk_get_rate(gpriv->can_clk) / info->postdiv;
+		fcan_freq /= info->postdiv;
 	} else {
 		fcan_freq = clk_get_rate(gpriv->can_clk);
 		gpriv->extclk = gpriv->info->external_clk;
-- 
2.43.0

