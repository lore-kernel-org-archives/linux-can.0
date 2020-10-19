Return-Path: <SRS0=yT01=D2=vger.kernel.org=linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93238C388F2
	for <linux-can@archiver.kernel.org>; Mon, 19 Oct 2020 19:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48BCB22365
	for <linux-can@archiver.kernel.org>; Mon, 19 Oct 2020 19:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731105AbgJSTFg (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Mon, 19 Oct 2020 15:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731112AbgJSTFg (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 19 Oct 2020 15:05:36 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449E0C0613D0
        for <linux-can@vger.kernel.org>; Mon, 19 Oct 2020 12:05:36 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kUaTO-0005v5-C4; Mon, 19 Oct 2020 21:05:34 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Oliver Hartkopp <socketcan@hartkopp.net>,
        Thomas Wagner <thwa1@web.de>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [net-rfc 09/16] can: isotp: enable RX timeout handling in listen-only mode
Date:   Mon, 19 Oct 2020 21:05:17 +0200
Message-Id: <20201019190524.1285319-10-mkl@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201019190524.1285319-1-mkl@pengutronix.de>
References: <20201019190524.1285319-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Oliver Hartkopp <socketcan@hartkopp.net>

As reported by Thomas Wagner:

    https://github.com/hartkopp/can-isotp/issues/34

the timeout handling for data frames is not enabled when the isotp socket is
used in listen-only mode (sockopt CAN_ISOTP_LISTEN_MODE). This mode is enabled
by the isotpsniffer application which therefore became inconsistend with the
strict rx timeout rules when running the isotp protocol in the operational
mode.

This patch fixes this inconsistency by moving the return condition for the
listen-only mode behind the timeout handling code.

Reported-by: Thomas Wagner <thwa1@web.de>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Fixes: e057dd3fc20f ("can: add ISO 15765-2:2016 transport protocol")
Link: https://github.com/hartkopp/can-isotp/issues/34
Link: https://lore.kernel.org/r/20201019120229.89326-1-socketcan@hartkopp.net
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/isotp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 4c2062875893..a79287ef86da 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -569,10 +569,6 @@ static int isotp_rcv_cf(struct sock *sk, struct canfd_frame *cf, int ae,
 		return 0;
 	}
 
-	/* no creation of flow control frames */
-	if (so->opt.flags & CAN_ISOTP_LISTEN_MODE)
-		return 0;
-
 	/* perform blocksize handling, if enabled */
 	if (!so->rxfc.bs || ++so->rx.bs < so->rxfc.bs) {
 		/* start rx timeout watchdog */
@@ -581,6 +577,10 @@ static int isotp_rcv_cf(struct sock *sk, struct canfd_frame *cf, int ae,
 		return 0;
 	}
 
+	/* no creation of flow control frames */
+	if (so->opt.flags & CAN_ISOTP_LISTEN_MODE)
+		return 0;
+
 	/* we reached the specified blocksize so->rxfc.bs */
 	isotp_send_fc(sk, ae, ISOTP_FC_CTS);
 	return 0;
-- 
2.28.0

