Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.167
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792528463;
	b=o7PokVwy6fBPrzYaDPRx1k//hflF6CG3/PYimQpMmNfWLIbgHKt4zItczZw0FLZAf/Qc
	 4uU/Jzyv5VCAF+VJUMrDODTTifz+GjB0I5BJNgNzqWOXL1o5vpLVSvF8zqjiD/u3dANAz
	 vMCyM9Z65pxZUkzF7y8oibE2r7oXPTFwQQlFsCe/mrnE6R53pMC1kIzkKmPWXL168k0IO
	 BiVShJcbBc+WJj2c9gDAS0OvKz7HkDUEsdOxRtxeE+Sh/+SzDoVMaMNRNKdB7buUZMtLx
	 QDpYWop2VrirEgnuxd74u0Jvl+Igln0ovT88po5cIYUClhANvH8mp+K0BA64ovQ460g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792528463;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=GoklJZBDhk1WUIjxmbOB6jIuhZElYRWCVUEyXeOwZGo=;
	b=Zc5jzMVfs4TdFP0mpPWnRtjIZIfejC+HA93ac80NZZmBRguEV0iVD2EVfgm453meTZO8
	 ohrYJ5U82y6/C1ZtyWoIb3n/HnoKGfSneNR8xPUZfCkxlzdRIKsm1OpCK9jwx1vmb32DA
	 8Hl/CR92x12+MDjY/vpew46j6tErdxw8+Xb5LTgOE8C4Jd0pdGT+tE/mtP8Tx/RYndJq8
	 Lh55QKQ6kA+AK6HL5CTm88I+eQxW+c3L6FPhjuvCnz8AMFukhs1JnZiJOSxNhgYhFl8gn
	 0zi6vLihj56jhTcoyKzat0cgxai0rSBhyPe28b15K7YjtEiksDLrfyEkUu8P91lTygA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=KEARtKHN;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=FQUQxDAl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.167
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0675B606A319
	for <linux-can@vger.kernel.org>; Tue, 20 Oct 2026 20:34:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0675B606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=KEARtKHN;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=FQUQxDAl
ARC-Seal: i=1; a=rsa-sha256; t=1792528385; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=YoRWqlw0liaVlqhf0RgSUVtwx8IX5Dt4MX62kuPfm1PCE53/UDaOiX13D+TGtywcdo
    EAEr8pQBiB6Ms8esniXoSeLJPE7Z8OpowGaEwopJ8q8xaQLmBRpL2xLOPuCdJcOZenm7
    uKZJg/nRlN0kzq4aBn+zbnMhgV2wDs9hILXO7+b/li+zf+Xqc4GL/Zp+zXC/gIBW71Ai
    NaRMm7S6LbtY/IRoFWdvvRfis0uDNkci45nsevREiI9lbp481PLMXG3YzE7IdIYx3Z5B
    q1zSd72ApZy65L8rLd9f+5i9iUf8/Am/oRvKm2loGI29VJU8djCNUPf1/j8BpDG4MF/B
    q6mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792528385;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=GoklJZBDhk1WUIjxmbOB6jIuhZElYRWCVUEyXeOwZGo=;
    b=HSnhlABA2b99y4Kx5zq37/TapJlbWUJftIOA9/gRjEqTlmlDhsKursg3WapNKXlr3O
    o5p4etL1+6x0BQYOcKPnkrgbGfXfim2VlGs0DTlknTAGMZDELJX7KQybeI0eFxteCFjO
    R1lTN9dT1W2fE9CBFVMeh1moGHzieDKmYd6lH5/01vupl5nOsBSos0o0xKf8bpNbm978
    iLX7mDJyHjIOoTSfUzIhG+xJjDhtrxXlpeWJQ0ty//PoITfPrmdgw/S4+Fk/piKbnKVf
    dp9nICqj5adrISAvpaeLXEBBf6X5BYqhgn0dazza4NXimGgVMb0dHIPhyobZ3z0FEPjg
    7v0Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792528385;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=GoklJZBDhk1WUIjxmbOB6jIuhZElYRWCVUEyXeOwZGo=;
    b=KEARtKHNTFe+8wwDt7O9PqEG9sm7bsM7D7mXqSCGTz7nxMKMoU/z2c7xm73GEIpv9Z
    uLUNhNCgI+FzUbI/bMkTXp9ayADNpBCAGEIgIoqYUgXRFOygqgKkDcCwDvWjNPwkHqrI
    SwIPHQJXPnX9WipYeOx7bBrUlBTo0bb0fibwHCdWEr9kiWDSKSIfxMESOxDoQ5v2AcPS
    lSpZZqkhz5xynJlPaVCsu8QNctMgskWitoIK4j/TTU3lDylkNqpTI5UZk2AzNjr7le7U
    oEnai3uhDZCu5TbG8sqxNBhiQMpoyIcXOEged5FRWaMfXDAPKZVbfkpXwkblIP+7IoeL
    wJLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792528385;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=GoklJZBDhk1WUIjxmbOB6jIuhZElYRWCVUEyXeOwZGo=;
    b=FQUQxDAlUz7m5cAaj15CKSp+LPVhJzx/uzXRSbbUPAYHIzd/wbuLFk4GY9dt4r5XfP
    vtSJyw6P1edaViMTg0AQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29KKX5dMs
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 20 Oct 2026 22:33:05 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	stable@kernel.org,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH can-next v5 4/5] can: replace ARPHRD_CAN type checks with can_get_ml_priv()
Date: Tue, 20 Oct 2026 22:32:56 +0200
Message-ID: <20261020203257.230955-5-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261020203257.230955-1-socketcan@hartkopp.net>
References: <20261020203257.230955-1-socketcan@hartkopp.net>
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
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
Cc: stable@kernel.org
Cc: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://patch.msgid.link/20261012164802.94113-1-socketcan@hartkopp.net
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
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
index 3e57f72a3afe..dfea48768b23 100644
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
2.43.0

