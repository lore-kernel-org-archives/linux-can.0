From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] can: af_can: Fix Spectre v1 vulnerability
Date: Fri, 21 Dec 2018 15:22:29 -0600
Message-ID: <20181221212229.GA32635@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
Sender: netdev-owner@vger.kernel.org
To: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: linux-can.vger.kernel.org

protocol is indirectly controlled by user-space, hence leading to
a potential exploitation of the Spectre variant 1 vulnerability.

This issue was detected with the help of Smatch:

net/can/af_can.c:115 can_get_proto() warn: potential spectre issue 'proto_tab' [w]

Fix this by sanitizing protocol before using it to index proto_tab.

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 net/can/af_can.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/can/af_can.c b/net/can/af_can.c
index 1684ba5b51eb..cade7250c6d4 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -59,6 +59,7 @@
 #include <linux/can/core.h>
 #include <linux/can/skb.h>
 #include <linux/ratelimit.h>
+#include <linux/nospec.h>
 #include <net/net_namespace.h>
 #include <net/sock.h>
 
@@ -136,6 +137,7 @@ static int can_create(struct net *net, struct socket *sock, int protocol,
 
 	if (protocol < 0 || protocol >= CAN_NPROTO)
 		return -EINVAL;
+	protocol = array_index_nospec(protocol, CAN_NPROTO);
 
 	cp = can_get_proto(protocol);
 
-- 
2.20.1
