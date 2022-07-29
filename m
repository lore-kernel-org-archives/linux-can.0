Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1CA4C00144
	for <linux-can@archiver.kernel.org>; Fri, 29 Jul 2022 14:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236861AbiG2OGo (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Fri, 29 Jul 2022 10:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236884AbiG2OGi (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 29 Jul 2022 10:06:38 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1B54D4CF;
        Fri, 29 Jul 2022 07:06:36 -0700 (PDT)
Received: from localhost.localdomain (unknown [95.31.173.239])
        by mail.ispras.ru (Postfix) with ESMTPSA id 02EEB40737BF;
        Fri, 29 Jul 2022 14:06:31 +0000 (UTC)
From:   Fedor Pchelkin <pchelkin@ispras.ru>
To:     Robin van der Gracht <robin@protonic.nl>,
        Oleksij Rempel <linux@rempel-privat.de>
Cc:     Fedor Pchelkin <pchelkin@ispras.ru>, kernel@pengutronix.de,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        ldv-project@linuxtesting.org
Subject: [PATCH v2] can: j1939: Replace WARN_ON_ONCE with netdev_warn_once() in j1939_sk_queue_activate_next_locked()
Date:   Fri, 29 Jul 2022 17:06:09 +0300
Message-Id: <20220729140609.980154-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220728165828.GB30201@pengutronix.de>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

We should warn user-space that it is doing something wrong when trying to
activate sessions with identical parameters but WARN_ON_ONCE macro can not
be used here as it serves a different purpose.

So it would be good to replace it with netdev_warn_once() message.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
v1 -> v2: Used netdev_warn_once() instead of pr_warn_once()

 net/can/j1939/socket.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index f5ecfdcf57b2..09e1d78bd22c 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -178,7 +178,10 @@ static void j1939_sk_queue_activate_next_locked(struct j1939_session *session)
 	if (!first)
 		return;
 
-	if (WARN_ON_ONCE(j1939_session_activate(first))) {
+	if (j1939_session_activate(first)) {
+		netdev_warn_once(first->priv->ndev,
+						 "%s: 0x%p: Identical session is already activated.\n",
+						 __func__, first);
 		first->err = -EBUSY;
 		goto activate_next;
 	} else {
-- 
2.25.1

