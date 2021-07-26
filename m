Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD90C432BE
	for <linux-can@archiver.kernel.org>; Mon, 26 Jul 2021 09:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBB2460F11
	for <linux-can@archiver.kernel.org>; Mon, 26 Jul 2021 09:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbhGZItg (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Mon, 26 Jul 2021 04:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233361AbhGZIt2 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 26 Jul 2021 04:49:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4860CC061765
        for <linux-can@vger.kernel.org>; Mon, 26 Jul 2021 02:29:56 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1m7wvr-0007zV-5h
        for linux-can@vger.kernel.org; Mon, 26 Jul 2021 11:29:55 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 6A8D0657E12
        for <linux-can@vger.kernel.org>; Mon, 26 Jul 2021 09:29:54 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 03595657E0F;
        Mon, 26 Jul 2021 09:29:53 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 150dcd24;
        Mon, 26 Jul 2021 09:29:53 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     =?UTF-8?q?Remigiusz=20Ko=C5=82=C5=82=C4=85taj?= 
        <remigiusz.kollataj@mobica.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH] MAINTAINERS: add Yasushi SHOJI as reviewer for the Microchip CAN BUS Analyzer Tool driver
Date:   Mon, 26 Jul 2021 11:29:45 +0200
Message-Id: <20210726092945.1017567-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch adds Yasushi SHOJI as a reviewer for the Microchip CAN BUS
Analyzer Tool driver.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 58afeb12d3b3..8a002b48fbdb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11327,6 +11327,12 @@ W:	https://linuxtv.org
 T:	git git://linuxtv.org/media_tree.git
 F:	drivers/media/radio/radio-maxiradio*
 
+MCAB MICROCHIP CAN BUS ANALYZER TOOL DRIVER
+R:	Yasushi SHOJI <yasushi.shoji@gmail.com>
+L:	linux-can@vger.kernel.org
+S:	Maintained
+F:	drivers/net/can/usb/mcba_usb.c
+
 MCAN MMIO DEVICE DRIVER
 M:	Chandrasekar Ramakrishnan <rcsekar@samsung.com>
 L:	linux-can@vger.kernel.org
-- 
2.30.2


