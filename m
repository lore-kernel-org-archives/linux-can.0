Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BACC43461
	for <linux-can@archiver.kernel.org>; Fri, 16 Apr 2021 11:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E65F613B4
	for <linux-can@archiver.kernel.org>; Fri, 16 Apr 2021 11:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242974AbhDPLnb (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Fri, 16 Apr 2021 07:43:31 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:53996 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242958AbhDPLna (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 16 Apr 2021 07:43:30 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 13GBgtwM111966;
        Fri, 16 Apr 2021 06:42:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1618573375;
        bh=enRc7RAWZYWWXCGcJnJQ/Ayc5meEKxS/gtm2L2XI474=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=hT7p1ZoePSpWQHHVS7W96x3eOY4LhheUeqeP6y2FkHhUxa99BrRHu+Fx1rDxkjeCS
         QavIH2KHFOjDHouI6xUw0wd6UGx6yqoSpNUxzI2rqshbDZ6otN6RRZgk0wnILPIKCd
         zG1maTcxr9IV/PPHuYXnCP0W3wEssMMnDR0YO1Cs=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 13GBgt47097649
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 16 Apr 2021 06:42:55 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 16
 Apr 2021 06:42:55 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 16 Apr 2021 06:42:54 -0500
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 13GBgj3D039401;
        Fri, 16 Apr 2021 06:42:50 -0500
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Rob Herring <robh+dt@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>
Subject: [PATCH v3 1/2] dt-bindings: net: can: Document transceiver implementation as phy
Date:   Fri, 16 Apr 2021 17:12:44 +0530
Message-ID: <20210416114245.24829-2-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210416114245.24829-1-a-govindraju@ti.com>
References: <20210416114245.24829-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Faiz Abbas <faiz_abbas@ti.com>

Some transceivers need a configuration step (for example, pulling the
standby or enable lines) for them to start sending messages. The
transceiver can be implemented as a phy with the configuration done in the
phy driver. The bit rate limitation can the be obtained by the driver using
the phy node.

Document the above implementation in the bosch mcan bindings

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/net/can/bosch,m_can.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
index 798fa5fb7bb2..25f74db46bae 100644
--- a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
+++ b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
@@ -109,6 +109,9 @@ properties:
   can-transceiver:
     $ref: can-transceiver.yaml#
 
+  phys:
+    maxItems: 1
+
 required:
   - compatible
   - reg
-- 
2.17.1

