Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=85.215.255.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793020123;
	b=Ncl38QShQTcoVlT51IRnxNBsoN/TadwBTPXccHjJrUzFH9PSY4WqEBy8zyMPz9h9sYyI
	 mgN2RJ6U+cwgKl0WPTmg+uBb+0niL2nPa++I0WWAJqfKtZixoD8NWjBfsqaAE948lEvtk
	 5+iFozXGImKChEnrMmR4TKUZGItZFM0vIBbUfXR/B/7/KuSyb9zClXMVz+aws8UQA7xHg
	 3gKgT0J12scVyS+3NTIyA/ERugXHkfmLtG5Kpxahn9innyJFJqSyU+J5hbaodzY0bhqKd
	 hBJIaQx6iOiqyRVdkK/6qxm+rWRtvq0yn5eGSPJRz4xpuD7PTsNyYshN3VFFjcaa1hQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793020123;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Lu5d/sbu+0aIZ5lOY9fcnjFZIyA+Lq1nxDa9Mho71Ws=;
	b=GpZe4bQkcOnemfFDfSJlexlICRIsXy20UtoLAADTLkXaqdeG5ZJ/+TderPYTKPaeSAN+
	 Rf/t4smlxzsCtc/CkttmBUBGnTDyFRYGU+5mVBlXR89CfOKlCVEBh1WCynEmC6Po9zae7
	 rGpb+LnX+EfInrbTQHdQVDULVDolVbNWeSxn3LwXDkSs8foIlKtYWJ6PGfDo7ihK44xnW
	 IcSRb1m0Ix679ORRRoXAtV6g2Q86blaqtr4AAcIFDADOpqnoV0ryQ0QUGs5ekD3zvOG4h
	 6pdoyOAnu31x0pFEDiO8/wMUTQ6Al7VCVXc8UB9bmJvmnXIwMXTIK3zQppSkAtaRkLA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=lWVS+MC7;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=5svMLmBf;
	arc=fail smtp.remote-ip=85.215.255.51
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F015D606A31F
	for <linux-can@vger.kernel.org>; Mon, 26 Oct 2026 13:08:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F015D606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=lWVS+MC7;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=5svMLmBf
ARC-Seal: i=1; a=rsa-sha256; t=1793020118; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Qv9Tsu6dPGZ/g8eQ+Mtmm6i/FRrMHkx9ASUXBdMrn90VD9R6/Uxe/VASkwOoKo7+37
    XRH8aqqWDhxMXWQufOx2ZxdAMItj4XEtQDhkX0zWMhPQGicxnCtQ1nLVbnrnlYXGBZuK
    CKFUiO4QvuOaD92BDy9Z78+HhFJdIsu3YEFdtkjoP/izh9JyoYRxE7agLNWI+DeSAQ3v
    pAKtMA0zIRfQ9QD26u0hpgQO4+zu1fuU5Ues9kWU7etSDVwv8HZL1y/Uqljcb0g7Yn+Q
    xBHnBVVhUCfRuSQlHe5Niom5k4rYvVAwBlpLCMPR/mpr0d+nzU0v/FBVfktyvW8pCHs9
    FMKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1793020118;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=Lu5d/sbu+0aIZ5lOY9fcnjFZIyA+Lq1nxDa9Mho71Ws=;
    b=FVgrlKKecGLjaJ60MpliUmm5ZYqDxylK8Mtl2h2ZxuBLelPqYOBQHDjMdWTkzWFRtP
    lnrL9xhYO15amLYqreaId9bA63lp9A+7CANTobxAe7Qr6EokDAmkbnIUEdHXa+FJBx40
    9FOtm5RqNuJ2kc6aynXrteSs8nIOn8zwo2wyT5idDaUP/9jGNYDE91CurJ/4j4eXlKH/
    cX7+UCeM5tBtezREa5oYp6F4rexDroiyw6LYIvnw/m/awIRH9oUgrgQ+qgcDZjLKljWG
    AjR44kHw593A/oL27gT33Ug8TE4rZOUA/qU+OA5g/5UbXMSmppxFGqlAJzkCjhFpxL7n
    Z3EQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1793020118;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=Lu5d/sbu+0aIZ5lOY9fcnjFZIyA+Lq1nxDa9Mho71Ws=;
    b=lWVS+MC7VeiR7VZO2jo5Z6P+9kVvx2R3e7I3dI8WnwYzloXBdcKmU45baScbhAiRW3
    X5AoD1ZxQWUYJgZspl3KhZMS3biwHHu/JSciErC66qqYGm0MZdKyRhAbHXsJhQe96J0h
    PeYJyZuC6phU+/F+P8wkJj/fZOQ/a8J4LI40tvQPLnHzeEqwXC5oMfPnLYkE+VUjWhR2
    mO3Pvf2CthID3+X2/0Wd1IGTiUTnmX9LVNdvEZvfNj+aOywWjFV1diVkpeKCXCPVH4sD
    tge1Yy4aG1viw69CAB5kqxCLoa6Tq7lMEmYnrFQ42f6yO5QhjHAEBXFELP4jZdrPR/iG
    ZaDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1793020118;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=Lu5d/sbu+0aIZ5lOY9fcnjFZIyA+Lq1nxDa9Mho71Ws=;
    b=5svMLmBfTK+Bo8AAsyLkCSPX5du0MV5ScTJp5uYvBhZNmIxN+lFCElyNh//kg673m5
    uEPzx7H+kCKBJ6b2zbAw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29QD8c2Wy
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 26 Oct 2026 14:08:38 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Mon, 26 Oct 2026 14:08:32 +0100
Subject: [PATCH v11 4/7] can: replace ARPHRD_CAN type checks with
 can_get_ml_priv()
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-can-rx-lock-v11-4-3b9a2b829dab@hartkopp.net>
References: <20261026-can-rx-lock-v11-0-3b9a2b829dab@hartkopp.net>
In-Reply-To: <20261026-can-rx-lock-v11-0-3b9a2b829dab@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793020116; l=10836;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=TPgaFWBk12No1ZNqZEE07HEMy14afNsAQP2FiZWs2m0=;
 b=9hgbmIOiR4t/8G/g5lODBDphpv11s+kZ335ZvF+JbDaWHkPf3LBnWb4kLjuXpQ4qiKbPSBwT2
 LNbm6ovsvvODOrM57V3wtkN3iTOPUrcy7aLFxMINqf+q4Vki80JVphl
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=

Commit 4e096a18867a ("net: introduce CAN specific pointer in the struct
net_device") introduced an explicit way to assign the midlayer private
pointer (dev->ml_priv) to named users like ML_PRIV_CAN. A valid pointer
returned by can_get_ml_priv() therefore identifies a real CAN device.

The referenced commit only converted the j1939 and proc code to this
check, while the other parts of the CAN subsystem still rely on
dev->type == ARPHRD_CAN.

The TUNSETLINK ioctl allows a down TUN/TAP device to set its hardware
type to ARPHRD_CAN while dev->ml_priv remains NULL. Such a repurposed
netdevice passes the ARPHRD_CAN checks.

Commit 8aa59e355949 ("can: af_can: fix NULL pointer dereference in
can_rx_register()") already made can_rx_register() reject such devices.
But can_rx_unregister() still only checks dev->type and dereferences
the NULL ml_priv when it walks the receive lists of the device.

CAN_ISOTP reaches this path: isotp_bind() ignores the return values of
can_rx_register() and binds the socket anyway. When the socket is
released or the device is unregistered, isotp_release() and
isotp_notify() remove the filters that have never been registered and
trigger the NULL pointer dereference in can_rx_unregister(). This only
requires owning a TUN/TAP device or CAP_NET_ADMIN in an unprivileged
user namespace.

Convert the remaining ARPHRD_CAN checks in af_can, bcm, gw, isotp and
raw to can_get_ml_priv().

Fixes: 4e096a18867a ("net: introduce CAN specific pointer in the struct net_device")
Cc: stable@vger.kernel.org
Cc: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/af_can.c | 15 ++++++---------
 net/can/bcm.c    |  7 ++++---
 net/can/gw.c     |  7 ++++---
 net/can/isotp.c  |  5 +++--
 net/can/raw.c    |  4 ++--
 5 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/net/can/af_can.c b/net/can/af_can.c
index 6ebe9d3689ac..d97f85fc3232 100644
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
index 6c85a76477c3..6759662e024c 100644
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
@@ -1716,11 +1717,11 @@ static int bcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
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
 
@@ -1864,11 +1865,11 @@ static void bcm_notify(struct bcm_sock *bo, unsigned long msg,
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
@@ -2021,11 +2022,11 @@ static int bcm_connect(struct socket *sock, struct sockaddr_unsized *uaddr, int
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
index 36f9aa0f7026..8a5327d8a00e 100644
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
index b239f4b45518..1a272ce6a2bd 100644
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
index 98808a75212e..09a5c0275ae6 100644
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

