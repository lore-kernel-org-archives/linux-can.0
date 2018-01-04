From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 1/4] can: vxcan: improve handling of missing peer name attribute
Date: Thu,  4 Jan 2018 16:33:52 +0100
Message-ID: <20180104153355.11243-2-mkl@pengutronix.de>
References: <20180104153355.11243-1-mkl@pengutronix.de>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180104153355.11243-1-mkl@pengutronix.de>
Sender: stable-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Oliver Hartkopp <socketcan@hartkopp.net>, Serhey Popovych <serhe.popovych@gmail.com>, linux-stable <stable@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: Oliver Hartkopp <socketcan@hartkopp.net>

Picking up the patch from Serhey Popovych (commit 191cdb3822e5df6b3c8,
"veth: Be more robust on network device creation when no attributes").

When the peer name attribute is not provided the former implementation tries
to register the given device name twice ... which leads to -EEXIST.
If only one device name is given apply an automatic generated and valid name
for the peer.

Cc: Serhey Popovych <serhe.popovych@gmail.com>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/vxcan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
index 8404e8852a0f..b4c4a2c76437 100644
--- a/drivers/net/can/vxcan.c
+++ b/drivers/net/can/vxcan.c
@@ -194,7 +194,7 @@ static int vxcan_newlink(struct net *net, struct net_device *dev,
 		tbp = peer_tb;
 	}
 
-	if (tbp[IFLA_IFNAME]) {
+	if (ifmp && tbp[IFLA_IFNAME]) {
 		nla_strlcpy(ifname, tbp[IFLA_IFNAME], IFNAMSIZ);
 		name_assign_type = NET_NAME_USER;
 	} else {
-- 
2.15.1
