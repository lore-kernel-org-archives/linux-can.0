Return-Path: <SRS0=L53H=DN=vger.kernel.org=linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D3BC47420
	for <linux-can@archiver.kernel.org>; Tue,  6 Oct 2020 20:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 689E520870
	for <linux-can@archiver.kernel.org>; Tue,  6 Oct 2020 20:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbgJFUh7 (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Tue, 6 Oct 2020 16:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727321AbgJFUh6 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 6 Oct 2020 16:37:58 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558F1C0613D2
        for <linux-can@vger.kernel.org>; Tue,  6 Oct 2020 13:37:58 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kPtie-0002n3-0L; Tue, 06 Oct 2020 22:37:56 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>,
        devicetree <devicetree@vger.kernel.org>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH 13/17] dt-bindings: can: flexcan: remove ack_grp and ack_bit from fsl,stop-mode
Date:   Tue,  6 Oct 2020 22:37:44 +0200
Message-Id: <20201006203748.1750156-14-mkl@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201006203748.1750156-1-mkl@pengutronix.de>
References: <20201006203748.1750156-1-mkl@pengutronix.de>
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

    048e3a34a2e7 can: flexcan: poll MCR_LPM_ACK instead of GPR ACK for stop mode acknowledgment

the driver polls the IP core's internal bit MCR[LPM_ACK] as stop mode
acknowledge and not the acknowledgment on chip level.

This means the 4th and 5th value of the property "fsl,stop-mode" isn't used
anymore. It will be removed from the driver in the next patch, so remove it
from the binding documentation.

Fixes: 048e3a34a2e7 ("can: flexcan: poll MCR_LPM_ACK instead of GPR ACK for stop mode acknowledgment")
Cc: devicetree <devicetree@vger.kernel.org>
Cc: Joakim Zhang <qiangqing.zhang@nxp.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 Documentation/devicetree/bindings/net/can/fsl-flexcan.txt | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
index c6152dc2d2d0..e10b6eb955e1 100644
--- a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
+++ b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
@@ -31,12 +31,10 @@ Optional properties:
               endian.
 
 - fsl,stop-mode: register bits of stop mode control, the format is
-		 <&gpr req_gpr req_bit ack_gpr ack_bit>.
+		 <&gpr req_gpr req_bit>.
 		 gpr is the phandle to general purpose register node.
 		 req_gpr is the gpr register offset of CAN stop request.
 		 req_bit is the bit offset of CAN stop request.
-		 ack_gpr is the gpr register offset of CAN stop acknowledge.
-		 ack_bit is the bit offset of CAN stop acknowledge.
 
 - fsl,clk-source: Select the clock source to the CAN Protocol Engine (PE).
 		  It's SoC Implementation dependent. Refer to RM for detailed
-- 
2.28.0

