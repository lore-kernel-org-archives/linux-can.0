Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31144C433E0
	for <linux-can@archiver.kernel.org>; Wed, 13 Jan 2021 20:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B944622DD3
	for <linux-can@archiver.kernel.org>; Wed, 13 Jan 2021 20:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbhAMUkl (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Wed, 13 Jan 2021 15:40:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbhAMUkl (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 13 Jan 2021 15:40:41 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B20C061575
        for <linux-can@vger.kernel.org>; Wed, 13 Jan 2021 12:40:00 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kzmvv-0006s8-8t
        for linux-can@vger.kernel.org; Wed, 13 Jan 2021 21:39:59 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 5E8BA5C2FD7
        for <linux-can@vger.kernel.org>; Wed, 13 Jan 2021 20:39:58 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 02F255C2FD4;
        Wed, 13 Jan 2021 20:39:57 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id b18106ba;
        Wed, 13 Jan 2021 20:39:57 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [net-next] can: tcan4x5x: remove __packed attribute from struct tcan4x5x_map_buf
Date:   Wed, 13 Jan 2021 21:39:55 +0100
Message-Id: <20210113203955.912916-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The first member of struct tcan4x5x_map_buf is the struct tcan4x5x_buf_cmd,
which has a size of 4 bytes. It's followed by an array of u8. The compiler
places the array directly after the struct tcan4x5x_buf_cmd.

This patch removes the not needed attribute __packed from the struct
tcan4x5x_map_buf.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/tcan4x5x.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/tcan4x5x.h b/drivers/net/can/m_can/tcan4x5x.h
index 7bf264f8e81f..c66da829b795 100644
--- a/drivers/net/can/m_can/tcan4x5x.h
+++ b/drivers/net/can/m_can/tcan4x5x.h
@@ -25,7 +25,7 @@ struct __packed tcan4x5x_buf_cmd {
 	u8 len;
 };
 
-struct __packed tcan4x5x_map_buf {
+struct tcan4x5x_map_buf {
 	struct tcan4x5x_buf_cmd cmd;
 	u8 data[256 * sizeof(u32)];
 } ____cacheline_aligned;
-- 
2.29.2


