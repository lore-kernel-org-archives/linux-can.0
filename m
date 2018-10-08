From: Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH v1 2/5] can: introduce REQUIRED_SIZE macro
Date: Mon,  8 Oct 2018 11:48:33 +0200
Message-ID: <20181008094836.14080-3-o.rempel@pengutronix.de>
References: <20181008094836.14080-1-o.rempel@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20181008094836.14080-1-o.rempel@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de, wg@grandegger.com
Cc: Kurt Van Dijck <kurt.van.dijck@eia.be>, Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, linux-can@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-can.vger.kernel.org

From: Kurt Van Dijck <kurt.van.dijck@eia.be>

The size of this structure will be increased with J1939 support.
To stay binary compatible, the REQUIRED_SIZE macro is introduced
for existing CAN protocols.

Signed-off-by: Kurt Van Dijck <kurt.van.dijck@eia.be>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 include/linux/can/core.h | 8 ++++++++
 net/can/bcm.c            | 4 ++--
 net/can/raw.c            | 4 ++--
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/linux/can/core.h b/include/linux/can/core.h
index 6099bc18bd0c..39ea254bb548 100644
--- a/include/linux/can/core.h
+++ b/include/linux/can/core.h
@@ -41,6 +41,14 @@ struct can_proto {
 	struct proto *prot;
 };
 
+/* required_size
+ * macro to find the minimum size of a struct
+ * that includes a requested member
+ */
+#define REQUIRED_SIZE(struct_type, member) \
+	(offsetof(typeof(struct_type), member) + \
+	 sizeof(((typeof(struct_type) *)(NULL))->member))
+
 /* function prototypes for the CAN networklayer core (af_can.c) */
 
 extern int  can_proto_register(const struct can_proto *cp);
diff --git a/net/can/bcm.c b/net/can/bcm.c
index 0af8f0db892a..3c8ab7fe793f 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -1318,7 +1318,7 @@ static int bcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 		/* no bound device as default => check msg_name */
 		DECLARE_SOCKADDR(struct sockaddr_can *, addr, msg->msg_name);
 
-		if (msg->msg_namelen < sizeof(*addr))
+		if (msg->msg_namelen < REQUIRED_SIZE(*addr, can_ifindex))
 			return -EINVAL;
 
 		if (addr->can_family != AF_CAN)
@@ -1560,7 +1560,7 @@ static int bcm_connect(struct socket *sock, struct sockaddr *uaddr, int len,
 	struct net *net = sock_net(sk);
 	int ret = 0;
 
-	if (len < sizeof(*addr))
+	if (len < REQUIRED_SIZE(*addr, can_ifindex))
 		return -EINVAL;
 
 	lock_sock(sk);
diff --git a/net/can/raw.c b/net/can/raw.c
index 1051eee82581..93f2f7b0f46a 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -399,7 +399,7 @@ static int raw_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 	int err = 0;
 	int notify_enetdown = 0;
 
-	if (len < sizeof(*addr))
+	if (len < REQUIRED_SIZE(*addr, can_ifindex))
 		return -EINVAL;
 	if (addr->can_family != AF_CAN)
 		return -EINVAL;
@@ -735,7 +735,7 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	if (msg->msg_name) {
 		DECLARE_SOCKADDR(struct sockaddr_can *, addr, msg->msg_name);
 
-		if (msg->msg_namelen < sizeof(*addr))
+		if (msg->msg_namelen < REQUIRED_SIZE(*addr, can_ifindex))
 			return -EINVAL;
 
 		if (addr->can_family != AF_CAN)
-- 
2.19.0
