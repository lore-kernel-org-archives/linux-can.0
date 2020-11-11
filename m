Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DB5C388F9
	for <linux-can@archiver.kernel.org>; Wed, 11 Nov 2020 13:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C677D2074B
	for <linux-can@archiver.kernel.org>; Wed, 11 Nov 2020 13:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgKKNFV (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Wed, 11 Nov 2020 08:05:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbgKKNFQ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 11 Nov 2020 08:05:16 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97E3C0613D1
        for <linux-can@vger.kernel.org>; Wed, 11 Nov 2020 05:05:16 -0800 (PST)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kcpoF-000306-VV; Wed, 11 Nov 2020 14:05:12 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        devicetree@vger.kernel.org
Subject: [net v2 3/4] dt-bindings: can: fsl,flexcan.yaml: fix compatible for i.MX35 and i.MX53
Date:   Wed, 11 Nov 2020 14:05:06 +0100
Message-Id: <20201111130507.1560881-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201111130507.1560881-1-mkl@pengutronix.de>
References: <[net v2 0/4] arm: imx: flexcan: fix yaml bindings and DTs>
 <20201111130507.1560881-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

As both the i.MX35 and i.MX53 flexcan IP cores are compatible to the i.MX25,
they are listed as:

    compatible = "fsl,imx35-flexcan", "fsl,imx25-flexcan";

and:

    compatible = "fsl,imx53-flexcan", "fsl,imx25-flexcan";

in the SoC device trees.

This patch fixes the following errors, which shows up during a dtbs_check:

arch/arm/boot/dts/imx53-ard.dt.yaml: can@53fc8000: compatible: 'oneOf' conditional failed, one must be fixed:
   ['fsl,imx53-flexcan', 'fsl,imx25-flexcan'] is too long
   Additional items are not allowed ('fsl,imx25-flexcan' was unexpected)
   'fsl,imx53-flexcan' is not one of ['fsl,imx7d-flexcan', 'fsl,imx6ul-flexcan', 'fsl,imx6sx-flexcan']
   'fsl,imx53-flexcan' is not one of ['fsl,ls1028ar1-flexcan']
   'fsl,imx6q-flexcan' was expected
   'fsl,lx2160ar1-flexcan' was expected
   From schema: Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml

Cc: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: devicetree@vger.kernel.org
Reported-by: Rob Herring <robh+dt@kernel.org>
Fixes: e5ab9aa7e49b ("dt-bindings: can: flexcan: convert fsl,*flexcan bindings to yaml")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
index 43df15ba8fa4..04127714e704 100644
--- a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
+++ b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
@@ -28,6 +28,11 @@ properties:
           - fsl,vf610-flexcan
           - fsl,ls1021ar2-flexcan
           - fsl,lx2160ar1-flexcan
+      - items:
+          - enum:
+              - fsl,imx53-flexcan
+              - fsl,imx35-flexcan
+          - const: fsl,imx25-flexcan
       - items:
           - enum:
               - fsl,imx7d-flexcan
-- 
2.28.0

