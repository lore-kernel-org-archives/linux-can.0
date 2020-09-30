Return-Path: <SRS0=bHV0=DH=vger.kernel.org=linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 262ADC47420
	for <linux-can@archiver.kernel.org>; Wed, 30 Sep 2020 09:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D87E720739
	for <linux-can@archiver.kernel.org>; Wed, 30 Sep 2020 09:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbgI3JPV (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Wed, 30 Sep 2020 05:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729055AbgI3JOd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 30 Sep 2020 05:14:33 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FFDC0613D4
        for <linux-can@vger.kernel.org>; Wed, 30 Sep 2020 02:14:29 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kNYBv-0007UQ-Sj; Wed, 30 Sep 2020 11:14:27 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Oleksij Rempel <o.rempel@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 05/12] dt-binding: can: mcp25xxfd: documentation fixes
Date:   Wed, 30 Sep 2020 11:14:17 +0200
Message-Id: <20200930091424.792165-6-mkl@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930091424.792165-1-mkl@pengutronix.de>
References: <20200930091424.792165-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Oleksij Rempel <o.rempel@pengutronix.de>

Apply following fixes:
- Use 'interrupts'. (interrupts-extended will automagically be supported
  by the tools)
- *-supply is always a single item. So, drop maxItems=1
- add "additionalProperties: false" flag to detect unneeded properties.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Link: https://lore.kernel.org/r/20200923125301.27200-1-o.rempel@pengutronix.de
Reported-by: Rob Herring <robh@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Fixes: 1b5a78e69c1f ("dt-binding: can: mcp25xxfd: document device tree bindings")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../devicetree/bindings/net/can/microchip,mcp25xxfd.yaml  | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml b/Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml
index aa2cad14d6d7..5beb00a614bf 100644
--- a/Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml
+++ b/Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml
@@ -24,7 +24,7 @@ properties:
   reg:
     maxItems: 1
 
-  interrupts-extended:
+  interrupts:
     maxItems: 1
 
   clocks:
@@ -32,11 +32,9 @@ properties:
 
   vdd-supply:
     description: Regulator that powers the CAN controller.
-    maxItems: 1
 
   xceiver-supply:
     description: Regulator that powers the CAN transceiver.
-    maxItems: 1
 
   microchip,rx-int-gpios:
     description:
@@ -52,9 +50,11 @@ properties:
 required:
   - compatible
   - reg
-  - interrupts-extended
+  - interrupts
   - clocks
 
+additionalProperties: false
+
 examples:
   - |
     #include <dt-bindings/gpio/gpio.h>
-- 
2.28.0

