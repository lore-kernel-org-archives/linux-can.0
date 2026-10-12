Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89714B403B
	for <linux-can@vger.kernel.org>; Mon, 12 Oct 2026 16:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.163
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791824064; cv=pass; b=K9JaBNsKxcMrprRuTfeF7LzIZoAG4qzo+EAMbj8AIPgBbG/X1mldee5EF9xoELQrUgl4RJltiQ4LVuFCsY4aKHpLVgXCF1/0dbh2CZhHCBvXjlB76IlvJKdGPqmNefqQNo6AoloZKgIf3s6r1MfHNd/Z6uk7p+XVrxP7ufcDmqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791824064; c=relaxed/simple;
	bh=OtnWhKK45wRLtGqhqvPv6WkfRRfbsJx0DoObs/po3cc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d/7a4tJmXyB9DQu28W3M09LuRs/rHT7HAhNyJLXTSMDIBUHUuWE308u6SyrZZh5gQf+3Rv8nM8fBttkbZD00EcUeQABQeVl/BU7/Pk2D3Ulhkg89kZOvX3j6o7YEY7UA/l1NuDPfYGOaI//tWDpMNQFaHRqD7Jf37fdg7WDAQ6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=SYVJctSU; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=N5jHqsmy; arc=pass smtp.client-ip=81.169.146.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="SYVJctSU";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="N5jHqsmy"
ARC-Seal: i=1; a=rsa-sha256; t=1791823692; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=jYrK/bO6Dq6M/ZStLYq5fKCXvL9cT9ol1idBYjj26vl8j7h28YZxapl+WS39/CMtWo
    B6vISVw2HRXHgTyiNyp1wUl8a/saQBcy56a5wRv4slYI53W5c0tAq1gRMxWGIfbo02g+
    XwTXZ46TbF7/OqrrV9aDVNfM+PjSYoI/JnI5jm9Smi68FbY+RaVw8577q+FGTPscSxSM
    3Gf9LdNe7QBbUnQaU90xd37zEu4U7KPazI+++r1OoTp8kspvzuBto1DK7Y5dbme/YD3x
    simugprJEzhkiXCyDcweOh7IJYzOx2O3Emh11w6c/XcmKErgEAh5TUy49/oqGGy1H/L1
    S0pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1791823692;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=QWrt8gjveFFjzhgCaAlhDNK45EQNnvERxN1BJBUlwj4=;
    b=CXESY6rzazO9I5x2mWLV3d1mzAsuSbta+soliiNZ3FNcYWEDuWvStN/u5F7u6dz5cT
    CPRJnJvk8FHtw2PzEfkInQU1p5VO8LT1Xbm4166hGJtMvx2p5ctEvFVCIK+M9Fir7mQT
    g4ma8Wn7PQRXzXLVFLUyzB+htubo6jAPWKGRn9W+Wd7w90YqcMC/AokxqxFzI12TBVOs
    Xu23Sc0xJp8FjXYNxs3RCwbnAUJz88X9wFSKOAOPc1SDMjUCGifr+pKvK2KclH/uRMcI
    QSo98H4pNZkkWhT7aW+mOO1oWjO2yxUaCXJ2WYuTSMHmDv4sIn0gJo7Zz94s8uGWu22d
    Vg+Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1791823692;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=QWrt8gjveFFjzhgCaAlhDNK45EQNnvERxN1BJBUlwj4=;
    b=SYVJctSUPWN+/40OYeFxNQu/D2Sl74fqr54KMVQIRbLl2DAprtrXoFnv599fgeig/l
    rQLZ5SWcTLqx+uLWc2oJk1RXtr5Xy4fotZkdlWacuHmphVbJH9ypdpLBHSErXU9LVang
    vMU9kPRI8dEpKky0cTuN6DXdXQhy37+RpFdlZbB4XHWKGztCzdlnIRA9JTMVKe2jcctK
    bjKcTnZcEupg2n7zPohf5UMvfdAcEx0Rf/p6EwB54qJWKgqftIbPWCQpEypF65E32O0w
    K4xnpO1jkLs+ppIIYoMlXtb/wDamlXfpCFNM2n62zOtVW0JBjwMEB8Y35O6iyVqOn8vh
    aeTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1791823692;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=QWrt8gjveFFjzhgCaAlhDNK45EQNnvERxN1BJBUlwj4=;
    b=N5jHqsmyqxywJp6qvqx/qJWh//wgcvQL0G+Y95IXg3mgp464Ab8xsDTcubFms2wuld
    A5uOLDy7d725JcWpxnCg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29CGmB1tN
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 12 Oct 2026 18:48:11 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	stable@kernel.org,
	Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [can-next v2] can: replace ARPHRD_CAN type checks with can_get_ml_priv()
Date: Mon, 12 Oct 2026 18:48:02 +0200
Message-ID: <20261012164802.94113-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

Commit 4e096a18867a ("net: introduce CAN specific pointer in the struct
net_device") introduced an explicit way to assign the midlayer private
pointer (dev->ml_priv) to named users like ML_PRIV_CAN. A valid pointer
returned by can_get_ml_priv() therefore identifies a real CAN device.

The referenced commit only converted the j1939 and proc code to this
check, while the other parts of the CAN subsystem still rely on
dev->type == ARPHRD_CAN.

The TUNSETLINK ioctl allows a down TUN/TAP device to set its hardware
type to ARPHRD_CAN while dev->ml_priv remains NULL. Such a repurposed
netdevice passes the ARPHRD_CAN checks and triggers a NULL pointer
dereference when CAN filters are created and when they are removed,
e.g. by the CAN protocols' netdevice notifier handlers. This only
requires owning a TUN/TAP device or CAP_NET_ADMIN in an unprivileged
user namespace.

Convert the remaining ARPHRD_CAN checks in af_can, bcm, gw, isotp and
raw to can_get_ml_priv().

Fixes: 4e096a18867a ("net: introduce CAN specific pointer in the struct net_device")
Cc: stable@kernel.org
Cc: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
v2: rephrased the commit message due to sashiko-bot feedback
---
 net/can/af_can.c | 15 ++++++---------
 net/can/bcm.c    |  7 ++++---
 net/can/gw.c     |  7 ++++---
 net/can/isotp.c  |  5 +++--
 net/can/raw.c    |  4 ++--
 5 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/net/can/af_can.c b/net/can/af_can.c
index 34fe3b28d576..dc27ace43719 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -224,11 +224,11 @@ int can_send(struct sk_buff *skb, int loop)
 	if (unlikely(skb->len > READ_ONCE(skb->dev->mtu))) {
 		err = -EMSGSIZE;
 		goto inval_skb;
 	}
 
-	if (unlikely(skb->dev->type != ARPHRD_CAN)) {
+	if (unlikely(!can_get_ml_priv(skb->dev))) {
 		err = -EPERM;
 		goto inval_skb;
 	}
 
 	if (unlikely(!(skb->dev->flags & IFF_UP))) {
@@ -450,11 +450,11 @@ int can_rx_register(struct net *net, struct net_device *dev, canid_t can_id,
 	struct can_dev_rcv_lists *dev_rcv_lists;
 	struct can_rcv_lists_stats *rcv_lists_stats = net->can.rcv_lists_stats;
 
 	/* insert new receiver  (dev,canid,mask) -> (func,data) */
 
-	if (dev && (dev->type != ARPHRD_CAN || !can_get_ml_priv(dev)))
+	if (dev && !can_get_ml_priv(dev))
 		return -ENODEV;
 
 	if (dev && !net_eq(net, dev_net(dev)))
 		return -ENODEV;
 
@@ -517,11 +517,11 @@ void can_rx_unregister(struct net *net, struct net_device *dev, canid_t can_id,
 	struct receiver *rcv = NULL;
 	struct hlist_head *rcv_list;
 	struct can_rcv_lists_stats *rcv_lists_stats = net->can.rcv_lists_stats;
 	struct can_dev_rcv_lists *dev_rcv_lists;
 
-	if (dev && dev->type != ARPHRD_CAN)
+	if (dev && !can_get_ml_priv(dev))
 		return;
 
 	if (dev && !net_eq(net, dev_net(dev)))
 		return;
 
@@ -682,12 +682,11 @@ static void can_receive(struct sk_buff *skb, struct net_device *dev)
 static int can_rcv(struct sk_buff *skb, struct net_device *dev,
 		   struct packet_type *pt, struct net_device *orig_dev)
 {
 	struct can_skb_ext *csx = can_skb_ext_find(skb);
 
-	if (unlikely(dev->type != ARPHRD_CAN || !can_get_ml_priv(dev) ||
-		     !csx || !can_is_can_skb(skb))) {
+	if (unlikely(!can_get_ml_priv(dev) || !csx || !can_is_can_skb(skb))) {
 		pr_warn_once("PF_CAN: dropped non conform CAN skbuff: dev type %d, len %d\n",
 			     dev->type, skb->len);
 
 		kfree_skb_reason(skb, SKB_DROP_REASON_CAN_RX_INVALID_FRAME);
 		return NET_RX_DROP;
@@ -708,12 +707,11 @@ static int can_rcv(struct sk_buff *skb, struct net_device *dev,
 static int canfd_rcv(struct sk_buff *skb, struct net_device *dev,
 		     struct packet_type *pt, struct net_device *orig_dev)
 {
 	struct can_skb_ext *csx = can_skb_ext_find(skb);
 
-	if (unlikely(dev->type != ARPHRD_CAN || !can_get_ml_priv(dev) ||
-		     !csx || !can_is_canfd_skb(skb))) {
+	if (unlikely(!can_get_ml_priv(dev) || !csx || !can_is_canfd_skb(skb))) {
 		pr_warn_once("PF_CAN: dropped non conform CAN FD skbuff: dev type %d, len %d\n",
 			     dev->type, skb->len);
 
 		kfree_skb_reason(skb, SKB_DROP_REASON_CANFD_RX_INVALID_FRAME);
 		return NET_RX_DROP;
@@ -734,12 +732,11 @@ static int canfd_rcv(struct sk_buff *skb, struct net_device *dev,
 static int canxl_rcv(struct sk_buff *skb, struct net_device *dev,
 		     struct packet_type *pt, struct net_device *orig_dev)
 {
 	struct can_skb_ext *csx = can_skb_ext_find(skb);
 
-	if (unlikely(dev->type != ARPHRD_CAN || !can_get_ml_priv(dev) ||
-		     !csx || !can_is_canxl_skb(skb))) {
+	if (unlikely(!can_get_ml_priv(dev) || !csx || !can_is_canxl_skb(skb))) {
 		pr_warn_once("PF_CAN: dropped non conform CAN XL skbuff: dev type %d, len %d\n",
 			     dev->type, skb->len);
 
 		kfree_skb_reason(skb, SKB_DROP_REASON_CANXL_RX_INVALID_FRAME);
 		return NET_RX_DROP;
diff --git a/net/can/bcm.c b/net/can/bcm.c
index 3d637a1e0ac1..60406439a13f 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -52,10 +52,11 @@
 #include <linux/netdevice.h>
 #include <linux/socket.h>
 #include <linux/if_arp.h>
 #include <linux/skbuff.h>
 #include <linux/can.h>
+#include <linux/can/can-ml.h>
 #include <linux/can/core.h>
 #include <linux/can/skb.h>
 #include <linux/can/bcm.h>
 #include <linux/slab.h>
 #include <linux/workqueue.h>
@@ -1717,11 +1718,11 @@ static int bcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 			if (!dev) {
 				ret = -ENODEV;
 				goto out_release;
 			}
 
-			if (dev->type != ARPHRD_CAN) {
+			if (!can_get_ml_priv(dev)) {
 				dev_put(dev);
 				ret = -ENODEV;
 				goto out_release;
 			}
 
@@ -1865,11 +1866,11 @@ static void bcm_notify(struct bcm_sock *bo, unsigned long msg,
 static int bcm_notifier(struct notifier_block *nb, unsigned long msg,
 			void *ptr)
 {
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
 
-	if (dev->type != ARPHRD_CAN)
+	if (!can_get_ml_priv(dev))
 		return NOTIFY_DONE;
 	if (msg != NETDEV_UNREGISTER && msg != NETDEV_DOWN)
 		return NOTIFY_DONE;
 	if (unlikely(bcm_busy_notifier)) /* Check for reentrant bug. */
 		return NOTIFY_DONE;
@@ -2022,11 +2023,11 @@ static int bcm_connect(struct socket *sock, struct sockaddr_unsized *uaddr, int
 		dev = dev_get_by_index(net, addr->can_ifindex);
 		if (!dev) {
 			ret = -ENODEV;
 			goto fail;
 		}
-		if (dev->type != ARPHRD_CAN) {
+		if (!can_get_ml_priv(dev)) {
 			dev_put(dev);
 			ret = -ENODEV;
 			goto fail;
 		}
 
diff --git a/net/can/gw.c b/net/can/gw.c
index 5793cb2420ed..54bb5bd3242a 100644
--- a/net/can/gw.c
+++ b/net/can/gw.c
@@ -50,10 +50,11 @@
 #include <linux/net.h>
 #include <linux/netdevice.h>
 #include <linux/if_arp.h>
 #include <linux/skbuff.h>
 #include <linux/can.h>
+#include <linux/can/can-ml.h>
 #include <linux/can/core.h>
 #include <linux/can/skb.h>
 #include <linux/can/gw.h>
 #include <net/can.h>
 #include <net/rtnetlink.h>
@@ -610,11 +611,11 @@ static int cgw_notifier(struct notifier_block *nb,
 			unsigned long msg, void *ptr)
 {
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
 	struct net *net = dev_net(dev);
 
-	if (dev->type != ARPHRD_CAN)
+	if (!can_get_ml_priv(dev))
 		return NOTIFY_DONE;
 
 	if (msg == NETDEV_UNREGISTER) {
 		struct cgw_job *gwj = NULL;
 		struct hlist_node *nx;
@@ -1161,19 +1162,19 @@ static int cgw_create_job(struct sk_buff *skb,  struct nlmsghdr *nlh,
 	gwj->src.dev = __dev_get_by_index(net, gwj->ccgw.src_idx);
 
 	if (!gwj->src.dev)
 		goto out;
 
-	if (gwj->src.dev->type != ARPHRD_CAN)
+	if (!can_get_ml_priv(gwj->src.dev))
 		goto out;
 
 	gwj->dst.dev = __dev_get_by_index(net, gwj->ccgw.dst_idx);
 
 	if (!gwj->dst.dev)
 		goto out;
 
-	if (gwj->dst.dev->type != ARPHRD_CAN)
+	if (!can_get_ml_priv(gwj->dst.dev))
 		goto out;
 
 	/* is sending the skb back to the incoming interface intended? */
 	if (gwj->src.dev == gwj->dst.dev &&
 	    !(gwj->flags & CGW_FLAGS_CAN_IIF_TX_OK)) {
diff --git a/net/can/isotp.c b/net/can/isotp.c
index f5dc9d04bd68..6c28802c0605 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -63,10 +63,11 @@
 #include <linux/netdevice.h>
 #include <linux/socket.h>
 #include <linux/if_arp.h>
 #include <linux/skbuff.h>
 #include <linux/can.h>
+#include <linux/can/can-ml.h>
 #include <linux/can/core.h>
 #include <linux/can/skb.h>
 #include <linux/can/isotp.h>
 #include <linux/slab.h>
 #include <net/can.h>
@@ -1608,11 +1609,11 @@ static int isotp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int l
 	dev = dev_get_by_index(net, addr->can_ifindex);
 	if (!dev) {
 		err = -ENODEV;
 		goto out;
 	}
-	if (dev->type != ARPHRD_CAN) {
+	if (!can_get_ml_priv(dev)) {
 		err = -ENODEV;
 		goto out_put_dev;
 	}
 	if (READ_ONCE(dev->mtu) < so->ll.mtu) {
 		err = -EINVAL;
@@ -1895,11 +1896,11 @@ static void isotp_notify(struct isotp_sock *so, unsigned long msg,
 static int isotp_notifier(struct notifier_block *nb, unsigned long msg,
 			  void *ptr)
 {
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
 
-	if (dev->type != ARPHRD_CAN)
+	if (!can_get_ml_priv(dev))
 		return NOTIFY_DONE;
 	if (msg != NETDEV_UNREGISTER && msg != NETDEV_DOWN)
 		return NOTIFY_DONE;
 	if (unlikely(isotp_busy_notifier)) /* Check for reentrant bug. */
 		return NOTIFY_DONE;
diff --git a/net/can/raw.c b/net/can/raw.c
index 6944ebab3feb..ad611906b308 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -346,11 +346,11 @@ static void raw_notify(struct raw_sock *ro, unsigned long msg,
 static int raw_notifier(struct notifier_block *nb, unsigned long msg,
 			void *ptr)
 {
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
 
-	if (dev->type != ARPHRD_CAN)
+	if (!can_get_ml_priv(dev))
 		return NOTIFY_DONE;
 	if (msg != NETDEV_UNREGISTER && msg != NETDEV_DOWN)
 		return NOTIFY_DONE;
 	if (unlikely(raw_busy_notifier)) /* Check for reentrant bug. */
 		return NOTIFY_DONE;
@@ -489,11 +489,11 @@ static int raw_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int len
 		dev = dev_get_by_index(sock_net(sk), addr->can_ifindex);
 		if (!dev) {
 			err = -ENODEV;
 			goto out;
 		}
-		if (dev->type != ARPHRD_CAN) {
+		if (!can_get_ml_priv(dev)) {
 			err = -ENODEV;
 			goto out_put_dev;
 		}
 
 		if (!(dev->flags & IFF_UP))
-- 
2.53.0

