Return-Path: <SRS0=bHV0=DH=vger.kernel.org=linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4175BC47420
	for <linux-can@archiver.kernel.org>; Wed, 30 Sep 2020 09:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF4DB2071E
	for <linux-can@archiver.kernel.org>; Wed, 30 Sep 2020 09:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="RKeXRCkh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbgI3JP0 (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Wed, 30 Sep 2020 05:15:26 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:61943 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729026AbgI3JO3 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 30 Sep 2020 05:14:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1601457269; x=1632993269;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/ZYP5huKS3E3Wxm1rD7Bg9qcbtinex3PHKYcP+sfMWI=;
  b=RKeXRCkhEPEWun/U29Jti5DDVFvxY3yHqH71fAT93I3mZ9uP7bvBgUE+
   sBARWL4SxoB+6wi9s392Sy0XUuV9X2RDKmeRoqiy1iTvHVzZO9dh3qjQX
   FlzWX7r0Itkcbb3sDWvBGI/94zDfwKHzkP5gYQ+5T//AZcJ5/3jKfoTVQ
   MwoBF/YB5JzHr0b7/Gu48PuSBml1RGCfJPeo4mhPO2EgEyWoI5xB4OaIY
   kuhH2M2VzMaAZkv6vbqRKgR9MGPJsnQUqjKnJgR+z4PVwtcHu3XW632dH
   z5syl8qLJPorWVHUpplVx7hS0oK8V3cTTXzIkmLy+nBytFtMKZpBK0thD
   Q==;
IronPort-SDR: QdNnkcz7UsvwKZazBrZJjG3Xl4+tj7KFuGHiwrh7cLwTExbKqg+DXvOVc20hq3Y2p00pb89U2J
 +8sWIaWtqgNrOrwyVx7wxSnhBZysWioivYSfa8EfhP7vT1IiZmzRBvG2ut2CMgoAO8CD/kC9aH
 isUD0Tu5NWwWDLG/TvuuOVDrkOZLrAbOm+Wiy5a2NxFFkYH0ykPoB1R+LBMbwJHY2/0GxW0Rf9
 x1ENeJcA/Rl/MyFRqjKnNR06u9UV5fpeq4CAaCl0Vy498Hln7JwENGez4EREAyVNczoqbke3N7
 9qA=
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="92928482"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Sep 2020 02:14:29 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 30 Sep 2020 02:14:28 -0700
Received: from HNO-LT-M43677A.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 30 Sep 2020 02:14:26 -0700
From:   Thomas Kopp <thomas.kopp@microchip.com>
To:     <mkl@pengutronix.de>, <manivannan.sadhasivam@linaro.org>,
        <o.rempel@pengutronix.de>, <geert@linux-m68k.org>
CC:     <linux-can@vger.kernel.org>, <thomas.kopp@microchip.com>,
        <dev.kurt@vandijck-laurijssen.be>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, <wg@grandegger.com>
Subject: [PATCH 2/2] can: mcp25xxfd: narrow down wildcards in device tree bindings
Date:   Wed, 30 Sep 2020 11:14:23 +0200
Message-ID: <20200930091423.755-2-thomas.kopp@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200930091423.755-1-thomas.kopp@microchip.com>
References: <20200930091423.755-1-thomas.kopp@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The wildcard should be narrowed down to prevent existing and
future devices that are not compatible from matching.
It is very unlikely that incompatible devices will be released
that do not match the wildcard.

This is the documentation part of the commit.

Discussion Reference: https://lore.kernel.org/r/CAMuHMdVkwGjr6dJuMyhQNqFoJqbh6Ec5V2b5LenCshwpM2SDsQ@mail.gmail.com/

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>

Signed-off-by: Thomas Kopp <thomas.kopp@microchip.com>
---
 .../devicetree/bindings/net/can/microchip,mcp25xxfd.yaml      | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml b/Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml
index 5beb00a614bf..6765f4c611c5 100644
--- a/Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml
+++ b/Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml
@@ -18,7 +18,7 @@ properties:
         description: for MCP2517FD
       - const: microchip,mcp2518fd
         description: for MCP2518FD
-      - const: microchip,mcp25xxfd
+      - const: microchip,mcp251xfd
         description: to autodetect chip variant
 
   reg:
@@ -65,7 +65,7 @@ examples:
         #size-cells = <0>;
 
         can@0 {
-            compatible = "microchip,mcp25xxfd";
+            compatible = "microchip,mcp251xfd";
             reg = <0>;
             clocks = <&can0_osc>;
             pinctrl-names = "default";
-- 
2.25.1

