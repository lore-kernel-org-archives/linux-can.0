Return-Path: <linux-can-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29D8C77B75
	for <linux-can@archiver.kernel.org>; Tue,  9 May 2023 12:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234704AbjEIM3B (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Tue, 9 May 2023 08:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233784AbjEIM3A (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 May 2023 08:29:00 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E46171E
        for <linux-can@vger.kernel.org>; Tue,  9 May 2023 05:29:00 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pwMSg-0005Vg-IT
        for linux-can@vger.kernel.org; Tue, 09 May 2023 14:28:58 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id EA34E1C0DF7
        for <linux-can@vger.kernel.org>; Tue,  9 May 2023 12:28:57 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 45CDD1C0DF4;
        Tue,  9 May 2023 12:28:57 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id e1812aa0;
        Tue, 9 May 2023 12:28:56 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH] can: length: make header self contained
Date:   Tue,  9 May 2023 14:28:54 +0200
Message-Id: <20230509122854.350426-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Include the headers that "can/length.h" depends on.

Fixes: bdd2e413192d ("can: dev: move length related code into seperate file")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 include/linux/can/length.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/can/length.h b/include/linux/can/length.h
index 6995092b774e..69336549d24f 100644
--- a/include/linux/can/length.h
+++ b/include/linux/can/length.h
@@ -6,6 +6,9 @@
 #ifndef _CAN_LENGTH_H
 #define _CAN_LENGTH_H
 
+#include <linux/can.h>
+#include <linux/can/netlink.h>
+
 /*
  * Size of a Classical CAN Standard Frame
  *
-- 
2.39.2


