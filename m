Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15712C433EF
	for <linux-can@archiver.kernel.org>; Thu, 17 Mar 2022 20:31:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiCQUcp (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Thu, 17 Mar 2022 16:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiCQUco (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 17 Mar 2022 16:32:44 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC104123409
        for <linux-can@vger.kernel.org>; Thu, 17 Mar 2022 13:31:25 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nUwmJ-0007hG-6s
        for linux-can@vger.kernel.org; Thu, 17 Mar 2022 21:31:23 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 91AE94D729
        for <linux-can@vger.kernel.org>; Thu, 17 Mar 2022 20:31:22 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 6D14E4D727;
        Thu, 17 Mar 2022 20:31:22 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 25b7e84e;
        Thu, 17 Mar 2022 20:31:22 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Subject: [PATCH] can: xilinx_can: mark bit timing constants as const
Date:   Thu, 17 Mar 2022 21:31:19 +0100
Message-Id: <20220317203119.792552-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch marks the bit timing constants as const.

Fixes: c223da689324 ("can: xilinx_can: Add support for CANFD FD frames")
Cc: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Cc: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/xilinx_can.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index e562c5ab1149..43f0c6a064ba 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -239,7 +239,7 @@ static const struct can_bittiming_const xcan_bittiming_const_canfd = {
 };
 
 /* AXI CANFD Data Bittiming constants as per AXI CANFD 1.0 specs */
-static struct can_bittiming_const xcan_data_bittiming_const_canfd = {
+static const struct can_bittiming_const xcan_data_bittiming_const_canfd = {
 	.name = DRIVER_NAME,
 	.tseg1_min = 1,
 	.tseg1_max = 16,
@@ -265,7 +265,7 @@ static const struct can_bittiming_const xcan_bittiming_const_canfd2 = {
 };
 
 /* AXI CANFD 2.0 Data Bittiming constants as per AXI CANFD 2.0 spec */
-static struct can_bittiming_const xcan_data_bittiming_const_canfd2 = {
+static const struct can_bittiming_const xcan_data_bittiming_const_canfd2 = {
 	.name = DRIVER_NAME,
 	.tseg1_min = 1,
 	.tseg1_max = 32,
-- 
2.35.1


