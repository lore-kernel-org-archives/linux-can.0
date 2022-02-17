Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A29C4332F
	for <linux-can@archiver.kernel.org>; Thu, 17 Feb 2022 11:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240019AbiBQLjW (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Thu, 17 Feb 2022 06:39:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240025AbiBQLjO (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 17 Feb 2022 06:39:14 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D721B2AE72E
        for <linux-can@vger.kernel.org>; Thu, 17 Feb 2022 03:38:42 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nKf7R-0002to-C3
        for linux-can@vger.kernel.org; Thu, 17 Feb 2022 12:38:41 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id CA38F3638F
        for <linux-can@vger.kernel.org>; Thu, 17 Feb 2022 11:38:40 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id AC7773638A;
        Thu, 17 Feb 2022 11:38:40 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 51571721;
        Thu, 17 Feb 2022 11:38:40 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>
Subject: [PATCH net-next] dt-binding: can: m_can: list Chandrasekar Ramakrishnan as maintainer
Date:   Thu, 17 Feb 2022 12:38:39 +0100
Message-Id: <20220217113839.2311417-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Since Sriram Dash's email bounces, change the maintainer entry to
Chandrasekar Ramakrishnan. Chandrasekar Ramakrishnan is already listed
as a maintainer in the MAINTAINERS file.

Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 Documentation/devicetree/bindings/net/can/bosch,m_can.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
index 3bc1ed39a0a5..b7f9803c1c6d 100644
--- a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
+++ b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
@@ -9,7 +9,7 @@ title: Bosch MCAN controller Bindings
 description: Bosch MCAN controller for CAN bus
 
 maintainers:
-  - Sriram Dash <sriram.dash@samsung.com>
+  - Chandrasekar Ramakrishnan <rcsekar@samsung.com>
 
 allOf:
   - $ref: can-controller.yaml#
-- 
2.34.1


