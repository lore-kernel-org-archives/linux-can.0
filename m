Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5353E0230;
	Tue,  7 Jul 2026 10:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783419889; cv=none; b=OB9soWLOkZ5wsZfxxIpNgloomMv4eejdiVsXQgeg2dBwTHMR9l1TM5kGv9dYJbrSNWj27y28GSowaCUBsoSv3aKz4zZe8gaSistLelLgLa4PDEDLQInlFNk1Xr0XBE24hEs2i53WnEXT2mHx1JsdLljfq3j02gzg+W6+qyzfr9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783419889; c=relaxed/simple;
	bh=efSlp3cQ6CjEjzT7boZVT+/LNeiQIgqFDtwqqTFzsCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KUcaK63RY8trZ1aNK3aPkJpC+T+sVeomOXVIGjLFMvpLrD+hRJuN3vdANQ0WN6h/U53F4kD7jQBns6VpO6SNtJXuVsVTbFb2mlg/6yuvD7q26QZ08DFWenjiWiXBkwup/j07y9AigApOM8vwyYmPH2j3SJ1jP/r8yaBROWJ7t8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B2941F00A3A;
	Tue,  7 Jul 2026 10:24:43 +0000 (UTC)
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
Subject: [PATCH 5/8] can: rcar_canfd: Do not set registers selecting the CAN mode
Date: Tue,  7 Jul 2026 13:24:15 +0300
Message-ID: <20260707102418.1646159-6-claudiu.beznea+renesas@tuxon.dev>
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

The bits 30 (classical CAN-only mode) and 28 (FD-only enable) of the
Channel n CAN-FD Configuration Register of the Renesas RZ/G3S SoC are not
available. The IP supports only CAN-FD mode. RZ/G3S HW manual (revision
1.30) specify the bits are read as zero and the write value should always
be zero.

Add the mode_select_na flag in struct rcar_canfd_hw_info to cover RZ/G3S
and avoid writing to unavailable bits.

The existing struct rcar_canfd_hw_info instances were updated to address
the request in the Link discussion.

Link: https://lore.kernel.org/all/1d9719e3-10ff-4cd8-b729-55fea93c37ce@wanadoo.fr
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 75512d41e3ee..9b0a67195824 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -445,6 +445,7 @@ struct rcar_canfd_hw_info {
 	unsigned shared_can_regs:1;	/* Has shared classical can registers */
 	unsigned external_clk:1;	/* Has external clock */
 	unsigned fcan_pclk:1;		/* Has fcan sourced from pclk. */
+	unsigned mode_select_na:1;	/* Has no bits for selecting the mode. */
 };
 
 /* Channel priv data */
@@ -619,6 +620,7 @@ static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
 	.shared_can_regs = 0,
 	.external_clk = 1,
 	.fcan_pclk = 0,
+	.mode_select_na = 0,
 };
 
 static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
@@ -637,6 +639,7 @@ static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
 	.shared_can_regs = 1,
 	.external_clk = 1,
 	.fcan_pclk = 0,
+	.mode_select_na = 0,
 };
 
 static const struct rcar_canfd_hw_info rzg2l_hw_info = {
@@ -655,6 +658,7 @@ static const struct rcar_canfd_hw_info rzg2l_hw_info = {
 	.shared_can_regs = 0,
 	.external_clk = 1,
 	.fcan_pclk = 0,
+	.mode_select_na = 0,
 };
 
 static const struct rcar_canfd_hw_info r9a09g047_hw_info = {
@@ -673,6 +677,7 @@ static const struct rcar_canfd_hw_info r9a09g047_hw_info = {
 	.shared_can_regs = 1,
 	.external_clk = 0,
 	.fcan_pclk = 0,
+	.mode_select_na = 0,
 };
 
 static const struct rcar_canfd_hw_info r9a09g077_hw_info = {
@@ -691,6 +696,7 @@ static const struct rcar_canfd_hw_info r9a09g077_hw_info = {
 	.shared_can_regs = 1,
 	.external_clk = 1,
 	.fcan_pclk = 0,
+	.mode_select_na = 0,
 };
 
 /* Helper functions */
@@ -846,6 +852,9 @@ static int rcar_canfd_reset_controller(struct rcar_canfd_global *gpriv)
 		}
 
 		/* Set the controller into appropriate mode */
+		if (gpriv->info->mode_select_na)
+			continue;
+
 		if (gpriv->info->ch_interface_mode) {
 			/* Do not set CLOE and FDOE simultaneously */
 			if (!gpriv->fdmode) {
-- 
2.43.0

