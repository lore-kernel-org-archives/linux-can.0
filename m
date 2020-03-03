From: Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 06/16] can: add missing attribute validation for termination
Date: Mon,  2 Mar 2020 21:05:16 -0800
Message-ID: <20200303050526.4088735-7-kuba@kernel.org>
References: <20200303050526.4088735-1-kuba@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726164AbgCCFFn (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 3 Mar 2020 00:05:43 -0500
In-Reply-To: <20200303050526.4088735-1-kuba@kernel.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

Add missing attribute validation for IFLA_CAN_TERMINATION
to the netlink policy.

Fixes: 12a6075cabc0 ("can: dev: add CAN interface termination API")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: Wolfgang Grandegger <wg@grandegger.com>
CC: Marc Kleine-Budde <mkl@pengutronix.de>
CC: Oliver Hartkopp <socketcan@hartkopp.net>
CC: linux-can@vger.kernel.org
---
 drivers/net/can/dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index 6ee06a49fb4c..68834a2853c9 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -883,6 +883,7 @@ static const struct nla_policy can_policy[IFLA_CAN_MAX + 1] = {
 				= { .len = sizeof(struct can_bittiming) },
 	[IFLA_CAN_DATA_BITTIMING_CONST]
 				= { .len = sizeof(struct can_bittiming_const) },
+	[IFLA_CAN_TERMINATION]	= { .type = NLA_U16 },
 };
 
 static int can_validate(struct nlattr *tb[], struct nlattr *data[],
-- 
2.24.1
