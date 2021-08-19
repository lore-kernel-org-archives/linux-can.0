Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D3DC432BE
	for <linux-can@archiver.kernel.org>; Thu, 19 Aug 2021 13:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A226610A1
	for <linux-can@archiver.kernel.org>; Thu, 19 Aug 2021 13:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240214AbhHSNkF (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Thu, 19 Aug 2021 09:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240176AbhHSNkB (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 19 Aug 2021 09:40:01 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8682EC061764
        for <linux-can@vger.kernel.org>; Thu, 19 Aug 2021 06:39:25 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1mGiGR-0004NL-Uq
        for linux-can@vger.kernel.org; Thu, 19 Aug 2021 15:39:24 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id B448C66A804
        for <linux-can@vger.kernel.org>; Thu, 19 Aug 2021 13:39:21 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 52CFE66A7F6;
        Thu, 19 Aug 2021 13:39:20 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id ba31aa3f;
        Thu, 19 Aug 2021 13:39:15 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 06/22] MAINTAINERS: add Vincent MAILHOL as maintainer for the ETAS ES58X CAN/USB driver
Date:   Thu, 19 Aug 2021 15:38:57 +0200
Message-Id: <20210819133913.657715-7-mkl@pengutronix.de>
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

From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

Adding myself (Vincent Mailhol) as a maintainer for the ETAS ES58X
CAN/USB driver.

Link: https://lore.kernel.org/r/20210814093353.74391-1-mailhol.vincent@wanadoo.fr
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 43ec27b32ee5..652657b27e0d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6905,6 +6905,12 @@ M:	Mark Einon <mark.einon@gmail.com>
 S:	Odd Fixes
 F:	drivers/net/ethernet/agere/
 
+ETAS ES58X CAN/USB DRIVER
+M:	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
+L:	linux-can@vger.kernel.org
+S:	Maintained
+F:	drivers/net/can/usb/etas_es58x/
+
 ETHERNET BRIDGE
 M:	Roopa Prabhu <roopa@nvidia.com>
 M:	Nikolay Aleksandrov <nikolay@nvidia.com>
-- 
2.32.0


