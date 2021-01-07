Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39660C4332B
	for <linux-can@archiver.kernel.org>; Thu,  7 Jan 2021 09:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12DDB2333F
	for <linux-can@archiver.kernel.org>; Thu,  7 Jan 2021 09:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbhAGJvx (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Thu, 7 Jan 2021 04:51:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727946AbhAGJvx (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 7 Jan 2021 04:51:53 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8357FC061245
        for <linux-can@vger.kernel.org>; Thu,  7 Jan 2021 01:50:06 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kxRvg-0001OT-S1
        for linux-can@vger.kernel.org; Thu, 07 Jan 2021 10:50:04 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id DD2AE5BBA4B
        for <linux-can@vger.kernel.org>; Thu,  7 Jan 2021 09:49:04 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id D34645BBA14;
        Thu,  7 Jan 2021 09:49:01 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 5f62d16e;
        Thu, 7 Jan 2021 09:49:01 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>,
        Dan Murphy <dmurphy@ti.com>, Sean Nyekjaer <sean@geanix.com>
Subject: [net-next 01/19] can: tcan4x5x: replace DEVICE_NAME by KBUILD_MODNAME
Date:   Thu,  7 Jan 2021 10:48:42 +0100
Message-Id: <20210107094900.173046-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210107094900.173046-1-mkl@pengutronix.de>
References: <20210107094900.173046-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch replaces the DEVICE_NAME macro by KBUILD_MODNAME and removed the
superfluous DEVICE_NAME.

Reviewed-by: Dan Murphy <dmurphy@ti.com>
Tested-by: Sean Nyekjaer <sean@geanix.com>
Link: https://lore.kernel.org/r/20201215231746.1132907-2-mkl@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/tcan4x5x.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/m_can/tcan4x5x.c b/drivers/net/can/m_can/tcan4x5x.c
index 24c737c4fc44..1b5f706674af 100644
--- a/drivers/net/can/m_can/tcan4x5x.c
+++ b/drivers/net/can/m_can/tcan4x5x.c
@@ -10,7 +10,6 @@
 
 #include "m_can.h"
 
-#define DEVICE_NAME "tcan4x5x"
 #define TCAN4X5X_EXT_CLK_DEF 40000000
 
 #define TCAN4X5X_DEV_ID0 0x00
@@ -132,7 +131,7 @@ static inline struct tcan4x5x_priv *cdev_to_priv(struct m_can_classdev *cdev)
 }
 
 static struct can_bittiming_const tcan4x5x_bittiming_const = {
-	.name = DEVICE_NAME,
+	.name = KBUILD_MODNAME,
 	.tseg1_min = 2,
 	.tseg1_max = 31,
 	.tseg2_min = 2,
@@ -144,7 +143,7 @@ static struct can_bittiming_const tcan4x5x_bittiming_const = {
 };
 
 static struct can_bittiming_const tcan4x5x_data_bittiming_const = {
-	.name = DEVICE_NAME,
+	.name = KBUILD_MODNAME,
 	.tseg1_min = 1,
 	.tseg1_max = 32,
 	.tseg2_min = 1,
@@ -544,7 +543,7 @@ MODULE_DEVICE_TABLE(spi, tcan4x5x_id_table);
 
 static struct spi_driver tcan4x5x_can_driver = {
 	.driver = {
-		.name = DEVICE_NAME,
+		.name = KBUILD_MODNAME,
 		.of_match_table = tcan4x5x_of_match,
 		.pm = NULL,
 	},

base-commit: ede71cae72855f8d6f6268510895210adc317666
-- 
2.29.2


