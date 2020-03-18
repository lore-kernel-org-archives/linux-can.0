From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 16/73] can: add missing attribute validation for termination
Date: Wed, 18 Mar 2020 16:52:40 -0400
Message-ID: <20200318205337.16279-16-sashal@kernel.org>
References: <20200318205337.16279-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200318205337.16279-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, Oliver Hartkopp <socketcan@hartkopp.net>, "David S . Miller" <davem@davemloft.net>, Sasha Levin <sashal@kernel.org>, linux-can@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-can.vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit ab02ad660586b94f5d08912a3952b939cf4c4430 ]

Add missing attribute validation for IFLA_CAN_TERMINATION
to the netlink policy.

Fixes: 12a6075cabc0 ("can: dev: add CAN interface termination API")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index 1c88c361938cc..3a33fb5034005 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -884,6 +884,7 @@ static const struct nla_policy can_policy[IFLA_CAN_MAX + 1] = {
 				= { .len = sizeof(struct can_bittiming) },
 	[IFLA_CAN_DATA_BITTIMING_CONST]
 				= { .len = sizeof(struct can_bittiming_const) },
+	[IFLA_CAN_TERMINATION]	= { .type = NLA_U16 },
 };
 
 static int can_validate(struct nlattr *tb[], struct nlattr *data[],
-- 
2.20.1
