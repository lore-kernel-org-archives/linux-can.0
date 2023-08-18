Return-Path: <linux-can-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ACE5C7112B
	for <linux-can@archiver.kernel.org>; Fri, 18 Aug 2023 11:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238832AbjHRLps (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Fri, 18 Aug 2023 07:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376619AbjHRLp3 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 18 Aug 2023 07:45:29 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08952723
        for <linux-can@vger.kernel.org>; Fri, 18 Aug 2023 04:45:25 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 4C7CD240101
        for <linux-can@vger.kernel.org>; Fri, 18 Aug 2023 13:45:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1692359118; bh=wplfaXgikB9Y7P4o0QyCy38t46P9xFoSSYt30+lyiBY=;
        h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
         Content-Transfer-Encoding:From;
        b=LSSg9YxmirGESX5aVbv1blPCGzLyxgaV9/bxf+aXOqTksY57OWCmLT4V7mfLYkEpX
         LYp733qRD0TvYeGJEhM/cdW5joqUajF947igbwhrIfLdezOPAkPM25NFZk3Ma6QxqQ
         /pxv6DLhv59tzTdNyzRKIj9CN5lOJk8/JshGix6x4T/4kAT9yPrepjaBidqPxCv2tk
         XAn8WGh8BCSJI6zja3gFD6/yyQYlNqSHf77Z2kNCiALdcrwGqYO3e7rlcCjin0aBuu
         dMHPsTTcLG97w+FXspWgo3F85lHmEF9oIXDJ70HlVJToRlAzUn1P7927n74OAdckw+
         dphR4lgBKAjvQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4RS0Rd3G2Vz6tsf;
        Fri, 18 Aug 2023 13:45:17 +0200 (CEST)
From:   Lukas Magel <lukas.magel@posteo.net>
To:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Michal Sojka <michal.sojka@cvut.cz>,
        Maxime Jayat <maxime.jayat@mobile-devices.fr>
Cc:     linux-can@vger.kernel.org, Lukas Magel <lukas.magel@posteo.net>
Subject: [PATCH] can: isotp: isotp_sendmsg(): fix TX state detection and wait behavior
Date:   Fri, 18 Aug 2023 11:43:45 +0000
Message-ID: <20230818114345.142983-1-lukas.magel@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

With patch [1], isotp_poll was updated to also queue the poller in the
so->wait queue, which is used for send state changes. Since the queue
now also contains polling tasks that are not interested in sending, the
queue fill state can no longer be used as an indication of send
readiness. As a consequence, nonblocking writes can lead to a race and
lock-up of the socket if there is a second task polling the socket in
parallel.

With this patch, isotp_sendmsg does not consult wq_has_sleepers but
instead tries to atomically set so->tx.state and waits on so->wait if it
is unable to do so. This behavior is in alignment with isotp_poll, which
also checks so->tx.state to determine send readiness.

The patch also takes a direct exit if the wait is interrupted before
changing so->tx.state. Previously, the code jumped to err_event_drop,
resetting so->tx.state.

[1] https://lore.kernel.org/all/20230331125511.372783-1-michal.sojka@cvut.cz

Reported-by: Maxime Jayat <maxime.jayat@mobile-devices.fr>
Closes: https://lore.kernel.org/linux-can/11328958-453f-447f-9af8-3b5824dfb041@munic.io/
Signed-off-by: Lukas Magel <lukas.magel@posteo.net>

---
---
 net/can/isotp.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 99770ed285..653cdb93f5 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -954,21 +954,18 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	if (!so->bound || so->tx.state == ISOTP_SHUTDOWN)
 		return -EADDRNOTAVAIL;
 
-wait_free_buffer:
-	/* we do not support multiple buffers - for now */
-	if (wq_has_sleeper(&so->wait) && (msg->msg_flags & MSG_DONTWAIT))
-		return -EAGAIN;
+	while (cmpxchg(&so->tx.state, ISOTP_IDLE, ISOTP_SENDING) != ISOTP_IDLE) {
+		/* we do not support multiple buffers - for now */
+		if (msg->msg_flags & MSG_DONTWAIT)
+			return -EAGAIN;
 
-	/* wait for complete transmission of current pdu */
-	err = wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE);
-	if (err)
-		goto err_event_drop;
-
-	if (cmpxchg(&so->tx.state, ISOTP_IDLE, ISOTP_SENDING) != ISOTP_IDLE) {
 		if (so->tx.state == ISOTP_SHUTDOWN)
 			return -EADDRNOTAVAIL;
 
-		goto wait_free_buffer;
+		/* wait for complete transmission of current pdu */
+		err = wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE);
+		if (err)
+			return err;
 	}
 
 	/* PDU size > default => try max_pdu_size */
-- 
2.41.0

