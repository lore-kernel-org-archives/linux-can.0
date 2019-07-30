From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH net-next v2] can: fix ioctl function removal
Date: Tue, 30 Jul 2019 08:43:33 +0200
Message-ID: <20190730064333.1581-1-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: davem@davemloft.net, netdev@vger.kernel.org
Cc: linux-can@vger.kernel.org, sfr@canb.auug.org.au, Oliver Hartkopp <socketcan@hartkopp.net>, kernel test robot <rong.a.chen@intel.com>
List-Id: linux-can.vger.kernel.org

Commit 60649d4e0af6c26b ("can: remove obsolete empty ioctl() handler") replaced
the almost empty can_ioctl() function with sock_no_ioctl() which always returns
-EOPNOTSUPP.

Even though we don't have any ioctl() functions on socket/network layer we need
to return -ENOIOCTLCMD to be able to forward ioctl commands like SIOCGIFINDEX
to the network driver layer.

This patch fixes the wrong return codes in the CAN network layer protocols.

Reported-by: kernel test robot <rong.a.chen@intel.com>
Fixes: 60649d4e0af6c26b ("can: remove obsolete empty ioctl() handler")
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---

 v2: Changed SHA1 tag to be a least 12 digits long

 net/can/bcm.c | 9 ++++++++-
 net/can/raw.c | 9 ++++++++-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index 8da986b19d88..bf1d0bbecec8 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -1680,6 +1680,13 @@ static int bcm_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
 	return size;
 }
 
+int bcm_sock_no_ioctlcmd(struct socket *sock, unsigned int cmd,
+			 unsigned long arg)
+{
+	/* no ioctls for socket layer -> hand it down to NIC layer */
+	return -ENOIOCTLCMD;
+}
+
 static const struct proto_ops bcm_ops = {
 	.family        = PF_CAN,
 	.release       = bcm_release,
@@ -1689,7 +1696,7 @@ static const struct proto_ops bcm_ops = {
 	.accept        = sock_no_accept,
 	.getname       = sock_no_getname,
 	.poll          = datagram_poll,
-	.ioctl         = sock_no_ioctl,
+	.ioctl         = bcm_sock_no_ioctlcmd,
 	.gettstamp     = sock_gettstamp,
 	.listen        = sock_no_listen,
 	.shutdown      = sock_no_shutdown,
diff --git a/net/can/raw.c b/net/can/raw.c
index ff720272f7b7..da386f1fa815 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -837,6 +837,13 @@ static int raw_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
 	return size;
 }
 
+int raw_sock_no_ioctlcmd(struct socket *sock, unsigned int cmd,
+			 unsigned long arg)
+{
+	/* no ioctls for socket layer -> hand it down to NIC layer */
+	return -ENOIOCTLCMD;
+}
+
 static const struct proto_ops raw_ops = {
 	.family        = PF_CAN,
 	.release       = raw_release,
@@ -846,7 +853,7 @@ static const struct proto_ops raw_ops = {
 	.accept        = sock_no_accept,
 	.getname       = raw_getname,
 	.poll          = datagram_poll,
-	.ioctl         = sock_no_ioctl,
+	.ioctl         = raw_sock_no_ioctlcmd,
 	.gettstamp     = sock_gettstamp,
 	.listen        = sock_no_listen,
 	.shutdown      = sock_no_shutdown,
-- 
2.20.1
