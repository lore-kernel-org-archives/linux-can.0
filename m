Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE3FC6377C
	for <linux-can@archiver.kernel.org>; Wed, 21 Jul 2021 19:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14AA26120D
	for <linux-can@archiver.kernel.org>; Wed, 21 Jul 2021 19:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240338AbhGUTKL (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Wed, 21 Jul 2021 15:10:11 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:5615 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S239624AbhGUTKJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 21 Jul 2021 15:10:09 -0400
X-IronPort-AV: E=Sophos;i="5.84,258,1620658800"; 
   d="scan'208";a="88350330"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 22 Jul 2021 04:50:44 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 837D8400D4D6;
        Thu, 22 Jul 2021 04:50:41 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v3 3/3] arm64: dts: renesas: r9a07g044: Add CANFD node
Date:   Wed, 21 Jul 2021 20:49:51 +0100
Message-Id: <20210721194951.30983-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210721194951.30983-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210721194951.30983-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Add CANFD node to R9A07G044 (RZ/G2L) SoC DTSI.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
index 9a7489dc70d1..51655c09f1f8 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
@@ -13,6 +13,13 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 
+	/* External CAN clock - to be overridden by boards that provide it */
+	can_clk: can {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+	};
+
 	/* clock can be either from exclk or crystal oscillator (XIN/XOUT) */
 	extal_clk: extal {
 		compatible = "fixed-clock";
@@ -89,6 +96,40 @@
 			status = "disabled";
 		};
 
+		canfd: can@10050000 {
+			compatible = "renesas,r9a07g044-canfd", "renesas,rzg2l-canfd";
+			reg = <0 0x10050000 0 0x8000>;
+			interrupts = <GIC_SPI 426 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 427 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 428 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 429 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "g_err", "g_recc",
+					  "ch0_err", "ch0_rec", "ch0_trx",
+					  "ch1_err", "ch1_rec", "ch1_trx";
+			clocks = <&cpg CPG_MOD R9A07G044_CANFD_PCLK>,
+				 <&cpg CPG_CORE R9A07G044_CLK_P0_DIV2>,
+				 <&can_clk>;
+			clock-names = "fck", "canfd", "can_clk";
+			assigned-clocks = <&cpg CPG_CORE R9A07G044_CLK_P0_DIV2>;
+			assigned-clock-rates = <50000000>;
+			resets = <&cpg R9A07G044_CANFD_RSTP_N>,
+				 <&cpg R9A07G044_CANFD_RSTC_N>;
+			reset-names = "rstp_n", "rstc_n";
+			power-domains = <&cpg>;
+			status = "disabled";
+
+			channel0 {
+				status = "disabled";
+			};
+			channel1 {
+				status = "disabled";
+			};
+		};
+
 		i2c0: i2c@10058000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.17.1

