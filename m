Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8FB7C43217
	for <linux-can@archiver.kernel.org>; Wed, 23 Feb 2022 22:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244133AbiBWWoX (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Wed, 23 Feb 2022 17:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242257AbiBWWoM (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 23 Feb 2022 17:44:12 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FA23335F
        for <linux-can@vger.kernel.org>; Wed, 23 Feb 2022 14:43:44 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nN0MI-0006V2-C5
        for linux-can@vger.kernel.org; Wed, 23 Feb 2022 23:43:42 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 3604A3BBA7
        for <linux-can@vger.kernel.org>; Wed, 23 Feb 2022 22:43:34 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 9B53D3BB54;
        Wed, 23 Feb 2022 22:43:33 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 80d4b0b2;
        Wed, 23 Feb 2022 22:43:33 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH net-next 05/36] dt-binding: can: m_can: include common CAN controller bindings
Date:   Wed, 23 Feb 2022 23:43:01 +0100
Message-Id: <20220223224332.2965690-6-mkl@pengutronix.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220223224332.2965690-1-mkl@pengutronix.de>
References: <20220223224332.2965690-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Since commit

| 1f9234401ce0 ("dt-bindings: can: add can-controller.yaml")

there is a common CAN controller binding. Add this to the m_can
binding.

Link: https://lore.kernel.org/all/20220124220653.3477172-4-mkl@pengutronix.de
Reviewed-by: Chandrasekar Ramakrishnan <rcsekar@samsung.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 Documentation/devicetree/bindings/net/can/bosch,m_can.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
index fd4d291fe4c1..b7f9803c1c6d 100644
--- a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
+++ b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
@@ -11,6 +11,9 @@ description: Bosch MCAN controller for CAN bus
 maintainers:
   - Chandrasekar Ramakrishnan <rcsekar@samsung.com>
 
+allOf:
+  - $ref: can-controller.yaml#
+
 properties:
   compatible:
     const: bosch,m_can
-- 
2.34.1


