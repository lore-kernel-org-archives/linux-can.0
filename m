Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF853C4320E
	for <linux-can@archiver.kernel.org>; Thu, 19 Aug 2021 13:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B816B61159
	for <linux-can@archiver.kernel.org>; Thu, 19 Aug 2021 13:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240118AbhHSNkA (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Thu, 19 Aug 2021 09:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239922AbhHSNj7 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 19 Aug 2021 09:39:59 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A26C061575
        for <linux-can@vger.kernel.org>; Thu, 19 Aug 2021 06:39:22 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1mGiGP-0004HP-8i
        for linux-can@vger.kernel.org; Thu, 19 Aug 2021 15:39:21 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 604CE66A7E8
        for <linux-can@vger.kernel.org>; Thu, 19 Aug 2021 13:39:19 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id F23AC66A7D5;
        Thu, 19 Aug 2021 13:39:17 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id ef99aad8;
        Thu, 19 Aug 2021 13:39:15 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Oleksij Rempel <o.rempel@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 02/22] dt-bindings: can-controller: add support for termination-gpios
Date:   Thu, 19 Aug 2021 15:38:53 +0200
Message-Id: <20210819133913.657715-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210819133913.657715-1-mkl@pengutronix.de>
References: <20210819133913.657715-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Oleksij Rempel <o.rempel@pengutronix.de>

Some boards provide GPIO controllable termination resistor. Provide
binding to make use of it.

Link: https://lore.kernel.org/r/20210818071232.20585-2-o.rempel@pengutronix.de
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../devicetree/bindings/net/can/can-controller.yaml      | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/can-controller.yaml b/Documentation/devicetree/bindings/net/can/can-controller.yaml
index 9cf2ae097156..1f0e98051074 100644
--- a/Documentation/devicetree/bindings/net/can/can-controller.yaml
+++ b/Documentation/devicetree/bindings/net/can/can-controller.yaml
@@ -13,6 +13,15 @@ properties:
   $nodename:
     pattern: "^can(@.*)?$"
 
+  termination-gpios:
+    description: GPIO pin to enable CAN bus termination.
+    maxItems: 1
+
+  termination-ohms:
+    description: The resistance value of the CAN bus termination resistor.
+    minimum: 1
+    maximum: 65535
+
 additionalProperties: true
 
 ...
-- 
2.32.0


