Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE86C41621
	for <linux-can@archiver.kernel.org>; Tue, 19 Jan 2021 18:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7ED182311C
	for <linux-can@archiver.kernel.org>; Tue, 19 Jan 2021 18:28:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387750AbhASRHP (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Tue, 19 Jan 2021 12:07:15 -0500
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:26268 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390671AbhASRGW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 19 Jan 2021 12:06:22 -0500
Received: from tomoyo.flets-east.jp ([153.202.107.157])
        by mwinf5d12 with ME
        id Jh3z2400G3PnFJp03h4My9; Tue, 19 Jan 2021 18:04:24 +0100
X-ME-Helo: tomoyo.flets-east.jp
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Tue, 19 Jan 2021 18:04:24 +0100
X-ME-IP: 153.202.107.157
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Alejandro Concepcion Rodriguez <alejandro@acoro.eu>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH] can: dev: export can_get_state_str() function
Date:   Wed, 20 Jan 2021 02:03:55 +0900
Message-Id: <20210119170355.12040-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The can_get_state_str() function is also relevant to the
drivers. Export the symbol and make it visible in the can/dev.h
header.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/dev/dev.c | 3 ++-
 include/linux/can/dev.h   | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index f580f0ac6497..8240743599b2 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -74,7 +74,7 @@ static int can_rx_state_to_frame(struct net_device *dev, enum can_state state)
 	}
 }
 
-static const char *can_get_state_str(const enum can_state state)
+const char *can_get_state_str(const enum can_state state)
 {
 	switch (state) {
 	case CAN_STATE_ERROR_ACTIVE:
@@ -95,6 +95,7 @@ static const char *can_get_state_str(const enum can_state state)
 
 	return "<unknown>";
 }
+EXPORT_SYMBOL_GPL(can_get_state_str);
 
 void can_change_state(struct net_device *dev, struct can_frame *cf,
 		      enum can_state tx_state, enum can_state rx_state)
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 7faf6a37d5b2..ac4d83a1ab81 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -123,6 +123,7 @@ void unregister_candev(struct net_device *dev);
 int can_restart_now(struct net_device *dev);
 void can_bus_off(struct net_device *dev);
 
+const char *can_get_state_str(const enum can_state state);
 void can_change_state(struct net_device *dev, struct can_frame *cf,
 		      enum can_state tx_state, enum can_state rx_state);
 

base-commit: 1105592cb8fdfcc96f2c9c693ff4106bac5fac7c
-- 
2.26.2

