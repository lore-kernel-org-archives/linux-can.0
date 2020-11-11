Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF4CC5517A
	for <linux-can@archiver.kernel.org>; Wed, 11 Nov 2020 21:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29E3720637
	for <linux-can@archiver.kernel.org>; Wed, 11 Nov 2020 21:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgKKVfz (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Wed, 11 Nov 2020 16:35:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgKKVfz (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 11 Nov 2020 16:35:55 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592B2C0613D1
        for <linux-can@vger.kernel.org>; Wed, 11 Nov 2020 13:35:55 -0800 (PST)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kcxmQ-0007CU-Id; Wed, 11 Nov 2020 22:35:50 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     kernel@pengutronix.de
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH] dt-bindings: clock: imx5: fix example
Date:   Wed, 11 Nov 2020 22:35:48 +0100
Message-Id: <20201111213548.1621094-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Since commit:

    0e030a373df3 ("can: flexcan: fix endianess detection")

the fsl,imx53-flexcan isn't compatible with the fsl,p1010-flexcan any more. As
the former accesses the IP core in Little Endian mode and the latter uses Big
Endian mode.

With the conversion of the flexcan DT bindings to yaml, the dt_binding_check
this throws the following error:

Documentation/devicetree/bindings/clock/imx5-clock.example.dt.yaml: can@53fc8000: compatible: 'oneOf' conditional failed, one must be fixed:
        ['fsl,imx53-flexcan', 'fsl,imx25-flexcan'] is too long
        Additional items are not allowed ('fsl,imx25-flexcan' was unexpected)
        'fsl,imx53-flexcan' is not one of ['fsl,imx7d-flexcan', 'fsl,imx6ul-flexcan', 'fsl,imx6sx-flexcan']
        'fsl,imx53-flexcan' is not one of ['fsl,ls1028ar1-flexcan']
        'fsl,imx6q-flexcan' was expected
        'fsl,lx2160ar1-flexcan' was expected
        From schema: Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml

The error is fixed by removing the "fsl,p1010-flexcan" compatible (which turned
out the be incompatible) from the binding example.

Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: devicetree@vger.kernel.org
Reported-by: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 Documentation/devicetree/bindings/clock/imx5-clock.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/imx5-clock.yaml b/Documentation/devicetree/bindings/clock/imx5-clock.yaml
index 4d9e7c73dce9..155379c3c41e 100644
--- a/Documentation/devicetree/bindings/clock/imx5-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/imx5-clock.yaml
@@ -57,7 +57,7 @@ examples:
     };
 
     can@53fc8000 {
-        compatible = "fsl,imx53-flexcan", "fsl,p1010-flexcan";
+        compatible = "fsl,imx53-flexcan";
         reg = <0x53fc8000 0x4000>;
         interrupts = <82>;
         clocks = <&clks IMX5_CLK_CAN1_IPG_GATE>, <&clks IMX5_CLK_CAN1_SERIAL_GATE>;
-- 
2.28.0

