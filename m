Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795704391;
	b=dxoIYzcn7m0I1KK1RnR6M6fNIgTJIIInF1iFU9Wu5kIs1DToV+grrLcrx5j3FyxxGwYy
	 fc3KHWKmS9rIgbo39tYIY/sSNIyzBI3if7nJ/VTdh62qs5yyhQDMdxwNKL6g4aorohKlQ
	 C+56l/oQT6hXN/8cgQo8W1+8jbD5WIWM2Z/l1F94DvvfUB167tOr/10ZeSJNuvcy2lJyc
	 GBo60wyDN+dS/yNwkyjOhdoR1GLgis0ELAFI69pOfL1KGXztv4sNtbY3d7BX197d1sCpM
	 5Bftqn9q9ib88w4cJw9XOWhUu39782SymEQ1Nh2RmI6sE5wC4S+s5U8d36DVWALehMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795704391;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=OmKRzxxqQq1PoNy2kWqSjJKHAfh2pWtu6K/xMddIM1A=;
	b=WT+Qya+IEJBsTe4OcOFcC4JuWedDjQWLVnyorTgCbZZtljoFy6Px0Gz/Ahd78HPcqiES
	 Akse8zOCPKruwMuaSFs4BwwW/r05iH1DgCTz0BGrwZ6T8fuh2R4vThJJ/yILmztXbV64+
	 Mf1f9TzQ6edNd9Z6WjK7i1a9/xI/Da0W9w3wAk35/38BusBQDMsar+liEHZN33kVDgCef
	 d+vUvqaB4lnAkW1vL1kIromEqNxEllNknOG+pYLXg4rBwLGJhB1JElGbkw93gqrUmBLR3
	 RxOwGX6m82g9t/3MIZNHC6iaGcttZwgI4Pmc1wx1cvOX3SHJCnPOT3TbSEW5WxLzfbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=exHbqaM2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877B1606A323;
	Thu, 26 Nov 2026 14:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=exHbqaM2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 882631F000C0;
	Thu, 26 Nov 2026 14:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795704391;
	bh=OmKRzxxqQq1PoNy2kWqSjJKHAfh2pWtu6K/xMddIM1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=exHbqaM2PAmfUyxwELdJR0eLDO2IPkj3FTM0kN75yLeEeTVxquGLTS/j+MWXFSaSd
	 DUpqhCqw2/gJtWIFCOeFNFOwfXP5uEdpzuugZIDymAXlKNCO0G+nxlbWm0CqvbDS3N
	 Y3qMHLZFjN96ZA7KN45pPWADvH8HVNN4LHYSFmGWlKZYXAVqqZyTUKhKZT/GNmyaEK
	 vdqpSXVqAceAdWkzmjGxE2gOUck2ieB+jG/rzdQl2fHCQQK+kL/Lp8XK3Nbc8Y5l7z
	 nsI6HrWqmq00mXEkZC5CiRu3/heCXnAKKyMjT5ppJE78bhTph5uJAGjLmLqKNjaIYl
	 Vkhv4A5TPQetQ==
From: Geert Uytterhoeven <geert@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 4/4] can: rcar_canfd: Add support for R-Car Gen5
Date: Thu, 26 Nov 2026 15:46:09 +0100
Message-ID: <d83095f877c2134e1350c6b86304998ab9d0bb95.1795703576.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1795703576.git.geert+renesas@glider.be>
References: <cover.1795703576.git.geert+renesas@glider.be>
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geert Uytterhoeven <geert+renesas@glider.be>

The CAN-FD block on R-Car Gen5 is similar to the variant on R-Car Gen4,
but uses split global and per-channel interrupts, and has no /2
postdivider for the canfd clock input.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Correct .postdiv,
  - Rebase.
---
 drivers/net/can/rcar/rcar_canfd.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index ce1d6629c1922fe3..c199ceff8f47555d 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -642,6 +642,25 @@ static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
 	.fixed_canfd = 0,
 };
 
+static const struct rcar_canfd_hw_info rcar_gen5_hw_info = {
+	.nom_bittiming = &rcar_canfd_gen4_nom_bittiming_const,
+	.data_bittiming = &rcar_canfd_gen4_data_bittiming_const,
+	.tdc_const = &rcar_canfd_gen4_tdc_const,
+	.regs = &rcar_gen4_regs,
+	.sh = &rcar_gen4_shift_data,
+	.rnc_field_width = 16,
+	.max_aflpn = 127,
+	.max_cftml = 31,
+	.max_channels = 8,
+	.postdiv = 1,
+	.multi_channel_irqs = 1,
+	.ch_interface_mode = 1,
+	.shared_can_regs = 1,
+	.external_clk = 1,
+	.fcan_pclk = 0,
+	.fixed_canfd = 0,
+};
+
 static const struct rcar_canfd_hw_info rzg2l_hw_info = {
 	.nom_bittiming = &rcar_canfd_gen3_nom_bittiming_const,
 	.data_bittiming = &rcar_canfd_gen3_data_bittiming_const,
@@ -2437,6 +2456,7 @@ static const __maybe_unused struct of_device_id rcar_canfd_of_table[] = {
 	{ .compatible = "renesas,r9a09g077-canfd", .data = &r9a09g077_hw_info },
 	{ .compatible = "renesas,rcar-gen3-canfd", .data = &rcar_gen3_hw_info },
 	{ .compatible = "renesas,rcar-gen4-canfd", .data = &rcar_gen4_hw_info },
+	{ .compatible = "renesas,rcar-gen5-canfd", .data = &rcar_gen5_hw_info },
 	{ .compatible = "renesas,rzg2l-canfd", .data = &rzg2l_hw_info },
 	{ }
 };
-- 
2.43.0

