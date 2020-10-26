Return-Path: <SRS0=7GTK=EB=vger.kernel.org=linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604B8C55178
	for <linux-can@archiver.kernel.org>; Mon, 26 Oct 2020 15:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1221722400
	for <linux-can@archiver.kernel.org>; Mon, 26 Oct 2020 15:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603726588;
	bh=0nSgFPUCz1doewmaEwSrcCLEaOm85Iixrcmcb5glcxg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=rGPD+duUHH2VPyLg5PZDH3BWB4hsotmo86tM/KCWgJhvM19KlHdyCqLPoYwrbn2Qh
	 TTgfW/bzV5skHXkdK+H7NcrPuVYsa+l9XoFpoupKKd3XdYCggxZyqbAva25JfSp1nR
	 +iqPTg8v7jv5vY7/QN37Ztqoar6n3/2c7RvYbGmA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1784002AbgJZPg1 (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Mon, 26 Oct 2020 11:36:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:60260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1783972AbgJZPg1 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 26 Oct 2020 11:36:27 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4AF722404;
        Mon, 26 Oct 2020 15:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603726586;
        bh=0nSgFPUCz1doewmaEwSrcCLEaOm85Iixrcmcb5glcxg=;
        h=From:To:Cc:Subject:Date:From;
        b=GsnGTtsubdanGJaWCG8+skz9VY+W7vlRpoPJVR5/4YylDQnZ/chlZDS6zJYULemPi
         TOVJoiw0K6rubvfvDJn1YIi0snC5TSZgkLw0kSS4y5jmDcN74wymB/MSjXa6RYTXcB
         J0O44mYQYqyy7/HK5nbRrobECYsk3Y5yV6Crvkr4=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>
Subject: [RESEND PATCH v2] dt-bindings: net: correct interrupt flags in examples
Date:   Mon, 26 Oct 2020 16:36:20 +0100
Message-Id: <20201026153620.89268-1-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

GPIO_ACTIVE_x flags are not correct in the context of interrupt flags.
These are simple defines so they could be used in DTS but they will not
have the same meaning:
1. GPIO_ACTIVE_HIGH = 0 = IRQ_TYPE_NONE
2. GPIO_ACTIVE_LOW  = 1 = IRQ_TYPE_EDGE_RISING

Correct the interrupt flags, assuming the author of the code wanted same
logical behavior behind the name "ACTIVE_xxx", this is:
  ACTIVE_LOW  => IRQ_TYPE_LEVEL_LOW
  ACTIVE_HIGH => IRQ_TYPE_LEVEL_HIGH

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Marc Kleine-Budde <mkl@pengutronix.de> # for tcan4x5x.txt

---

Changes since v1:
1. Add acks
---
 Documentation/devicetree/bindings/net/can/tcan4x5x.txt | 2 +-
 Documentation/devicetree/bindings/net/nfc/nxp-nci.txt  | 2 +-
 Documentation/devicetree/bindings/net/nfc/pn544.txt    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/tcan4x5x.txt b/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
index 3613c2c8f75d..0968b40aef1e 100644
--- a/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
+++ b/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
@@ -33,7 +33,7 @@ tcan4x5x: tcan4x5x@0 {
 		spi-max-frequency = <10000000>;
 		bosch,mram-cfg = <0x0 0 0 32 0 0 1 1>;
 		interrupt-parent = <&gpio1>;
-		interrupts = <14 GPIO_ACTIVE_LOW>;
+		interrupts = <14 IRQ_TYPE_LEVEL_LOW>;
 		device-state-gpios = <&gpio3 21 GPIO_ACTIVE_HIGH>;
 		device-wake-gpios = <&gpio1 15 GPIO_ACTIVE_HIGH>;
 		reset-gpios = <&gpio1 27 GPIO_ACTIVE_HIGH>;
diff --git a/Documentation/devicetree/bindings/net/nfc/nxp-nci.txt b/Documentation/devicetree/bindings/net/nfc/nxp-nci.txt
index cfaf88998918..9e4dc510a40a 100644
--- a/Documentation/devicetree/bindings/net/nfc/nxp-nci.txt
+++ b/Documentation/devicetree/bindings/net/nfc/nxp-nci.txt
@@ -25,7 +25,7 @@ Example (for ARM-based BeagleBone with NPC100 NFC controller on I2C2):
 		clock-frequency = <100000>;
 
 		interrupt-parent = <&gpio1>;
-		interrupts = <29 GPIO_ACTIVE_HIGH>;
+		interrupts = <29 IRQ_TYPE_LEVEL_HIGH>;
 
 		enable-gpios = <&gpio0 30 GPIO_ACTIVE_HIGH>;
 		firmware-gpios = <&gpio0 31 GPIO_ACTIVE_HIGH>;
diff --git a/Documentation/devicetree/bindings/net/nfc/pn544.txt b/Documentation/devicetree/bindings/net/nfc/pn544.txt
index 92f399ec22b8..2bd82562ce8e 100644
--- a/Documentation/devicetree/bindings/net/nfc/pn544.txt
+++ b/Documentation/devicetree/bindings/net/nfc/pn544.txt
@@ -25,7 +25,7 @@ Example (for ARM-based BeagleBone with PN544 on I2C2):
 		clock-frequency = <400000>;
 
 		interrupt-parent = <&gpio1>;
-		interrupts = <17 GPIO_ACTIVE_HIGH>;
+		interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
 
 		enable-gpios = <&gpio3 21 GPIO_ACTIVE_HIGH>;
 		firmware-gpios = <&gpio3 19 GPIO_ACTIVE_HIGH>;
-- 
2.25.1

