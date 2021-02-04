Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB91AC433DB
	for <linux-can@archiver.kernel.org>; Thu,  4 Feb 2021 18:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91CA264F4D
	for <linux-can@archiver.kernel.org>; Thu,  4 Feb 2021 18:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238770AbhBDSIr (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Thu, 4 Feb 2021 13:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238827AbhBDSDF (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 4 Feb 2021 13:03:05 -0500
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED9CC0617A9
        for <linux-can@vger.kernel.org>; Thu,  4 Feb 2021 10:02:24 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by albert.telenet-ops.be with bizsmtp
        id R62L2400H4C55Sk0662LEl; Thu, 04 Feb 2021 19:02:23 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1l7im7-003Fgj-Dv; Thu, 04 Feb 2021 18:50:39 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1l7eEU-006uI4-D1; Thu, 04 Feb 2021 13:59:38 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] dt-bindings: can: rcar_canfd: Group tuples in pin control properties
Date:   Thu,  4 Feb 2021 13:59:37 +0100
Message-Id: <20210204125937.1646305-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

To improve human readability and enable automatic validation, the tuples
in "pinctrl-*" properties should be grouped using angle brackets.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/net/can/rcar_canfd.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/can/rcar_canfd.txt b/Documentation/devicetree/bindings/net/can/rcar_canfd.txt
index 22cf2a889b2c7d6b..248c4ed97a0a078e 100644
--- a/Documentation/devicetree/bindings/net/can/rcar_canfd.txt
+++ b/Documentation/devicetree/bindings/net/can/rcar_canfd.txt
@@ -97,7 +97,7 @@ E.g. below enables Channel 0 alone in the board using External clock
 as fCAN clock.
 
 &canfd {
-	pinctrl-0 = <&canfd0_pins &can_clk_pins>;
+	pinctrl-0 = <&canfd0_pins>, <&can_clk_pins>;
 	pinctrl-names = "default";
 	status = "okay";
 
-- 
2.25.1

