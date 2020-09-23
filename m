Return-Path: <SRS0=s8nA=DA=vger.kernel.org=linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33572C4727F
	for <linux-can@archiver.kernel.org>; Wed, 23 Sep 2020 12:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E18E32137B
	for <linux-can@archiver.kernel.org>; Wed, 23 Sep 2020 12:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbgIWMxQ (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Wed, 23 Sep 2020 08:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbgIWMxN (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 23 Sep 2020 08:53:13 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED2CC0613CE
        for <linux-can@vger.kernel.org>; Wed, 23 Sep 2020 05:53:12 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1kL4Gf-0003nL-8o; Wed, 23 Sep 2020 14:53:05 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1kL4Gd-0007RW-3w; Wed, 23 Sep 2020 14:53:03 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     mkl@pengutronix.de, Wolfgang Grandegger <wg@grandegger.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, Thomas Kopp <thomas.kopp@microchip.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] dt-binding: can: mcp25xxfd: documentation fixes
Date:   Wed, 23 Sep 2020 14:53:01 +0200
Message-Id: <20200923125301.27200-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Apply following fixes:
- Use 'interrupts'. (interrupts-extended will automagically be supported
  by the tools)
- *-supply is always a single item. So, drop maxItems=1
- add "additionalProperties: false" flag to detect unneeded properties.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
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

