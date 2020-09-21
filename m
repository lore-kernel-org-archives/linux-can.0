Return-Path: <SRS0=XQ7n=C6=vger.kernel.org=linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A15C4346E
	for <linux-can@archiver.kernel.org>; Mon, 21 Sep 2020 13:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9696E2084C
	for <linux-can@archiver.kernel.org>; Mon, 21 Sep 2020 13:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbgIUNiy (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Mon, 21 Sep 2020 09:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbgIUNix (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 21 Sep 2020 09:38:53 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4462EC0613D6
        for <linux-can@vger.kernel.org>; Mon, 21 Sep 2020 06:38:52 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kKM1q-0000ox-8S; Mon, 21 Sep 2020 15:38:50 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de,
        =?UTF-8?q?Diego=20Elio=20Petten=C3=B2?= <flameeyes@flameeyes.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 08/38] can: softing: update dead link
Date:   Mon, 21 Sep 2020 15:38:15 +0200
Message-Id: <20200921133845.2249271-9-mkl@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200921133845.2249271-1-mkl@pengutronix.de>
References: <20200921133845.2249271-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Diego Elio Pettenò <flameeyes@flameeyes.com>

BerliOS has not been operating for more than five years. linux-can moved to
GitHub.

Signed-off-by: Diego Elio Pettenò <flameeyes@flameeyes.com>
Link: https://lore.kernel.org/r/20200413170241.13207-1-flameeyes@flameeyes.com
[mkl: split into two patches - handle softing part here]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/softing/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/softing/Kconfig b/drivers/net/can/softing/Kconfig
index 9edc73b13014..8afd7d0a1000 100644
--- a/drivers/net/can/softing/Kconfig
+++ b/drivers/net/can/softing/Kconfig
@@ -24,7 +24,7 @@ config CAN_SOFTING_CS
 	  Support for PCMCIA cards from Softing Gmbh & some cards
 	  from Vector Gmbh.
 	  You need firmware for these, which you can get at
-	  http://developer.berlios.de/projects/socketcan/
+	  https://github.com/linux-can/can-firmware
 	  This version of the driver is written against
 	  firmware version 4.6 (softing-fw-4.6-binaries.tar.gz)
 	  In order to use the card as CAN device, you need the Softing generic
-- 
2.28.0

