From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 05/28] can: dev: call netif_carrier_off() in register_candev()
Date: Tue, 13 Aug 2019 22:25:27 -0400
Message-ID: <20190814022550.17463-5-sashal@kernel.org>
References: <20190814022550.17463-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190814022550.17463-1-sashal@kernel.org>
Sender: netdev-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Willem de Bruijn <willemb@google.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Sasha Levin <sashal@kernel.org>, linux-can@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-can.vger.kernel.org

From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>

[ Upstream commit c63845609c4700488e5eacd6ab4d06d5d420e5ef ]

CONFIG_CAN_LEDS is deprecated. When trying to use the generic netdev
trigger as suggested, there's a small inconsistency with the link
property: The LED is on initially, stays on when the device is brought
up, and then turns off (as expected) when the device is brought down.

Make sure the LED always reflects the state of the CAN device.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Acked-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/dev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index 8b7c6425b681d..9dd968ee792e0 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -1065,6 +1065,8 @@ static struct rtnl_link_ops can_link_ops __read_mostly = {
 int register_candev(struct net_device *dev)
 {
 	dev->rtnl_link_ops = &can_link_ops;
+	netif_carrier_off(dev);
+
 	return register_netdev(dev);
 }
 EXPORT_SYMBOL_GPL(register_candev);
-- 
2.20.1
