Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2461D3DB64D;
	Sun, 18 Oct 2026 16:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792342224; cv=pass; b=Mk2729aB9Mv6184ondu9d1l6daZWFDdC5JNLiExXeqOXE7qNruliMkrrhkD1LPxTyFI4NZcuxUmFNAbp7r5iKUId71HyR7rglxvWHrUXZ1HTxNEp09EDppaRzhX/0KBeDqgayJE64Q2I1EmqdiYv1aZjKT2CHMd+1nPotMllGRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792342224; c=relaxed/simple;
	bh=NEaZRyvdrpIo8edS3Lf3m84TZ0AMKAi+YlEEwmsqEMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rn9adyiuQBpcc5pkXHLdzph+gssH5VL8Cz7Rad9ZusY8s0rqDZJtbA2yfTpwj2dI0znRyxgEcU4qzFWZl01ZmQB/J+zeYL+K7uKT8bXCqeDwomuQPBvXkWw+dR5baihi8/bOGBa0uespNgiYoUU8k46K7m3jeYUStKuOdaSEfis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=OqLwRS7Z; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="OqLwRS7Z"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id D6F13202823;
	Sun, 18 Oct 2026 18:44:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792341859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uqZgiZ/0Nf5Hmr0iiZYkewmDXDhlFR3RpILRb55BR3w=;
	b=OqLwRS7ZR80dQwH8TSVDPYhvSlP7SjifFM+mjhGf8Vl7N606vwvkfGScBeeT5Tmc91OU45
	vA5RYJx8pv5KXKdvPbrhtFBxJSJOShFX+uWhCWu6G7wYNSbnMjIHAMYULirPmg/pIw8NFw
	F5/BKBIYg38c+V/pztFg8KO+lZQWtBww73VlBhLnjDtb3bAjQyO+nFyD8T2W3v3od1s9hI
	v8Ag+uDt88u+ObcjZPGDVAus6KVyV/RzH4dBYesDe8MQNxqCVHBUwhQkvZBRxSdCF4rzem
	rcnBbjqEqKaz318z5MBnwdD5Jy85Usmof/tl6ehQuJrWH4zp6SG/MbU3DU0nEw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792341859; a=rsa-sha256;
	cv=none;
	b=M4JicZP6n0H8RafrlHIwDeiT6YUc7WL+f6/UoCHpfASVmxghBWBIbmSvZihvqlxO0zI0zf
	b55pzBlOvR3X7jUr33XpwhetsaMgJHRiGhynpUrD6OxpZfQAGRR0/J8BPB7GAZrC6Z2C8s
	ixmLSojrQ9pn2vXvBfe1lomRrW2py1mcIIy/YdftuMHHrlQ2r5hH0MXu9h2thiMNwAXsYQ
	E2X3Da7d6b/lNhXg0VehDwA6HXQ3ECrloV5FBd1bh+RyW52pq/fI1AS3TbTnDZ8owLu9ES
	ASfpXM/YMMFxw8iDNDhgJFbrNly8XZY35gbo3aUM7IDoP4mYsuxVqHDdvqIJhA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792341859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uqZgiZ/0Nf5Hmr0iiZYkewmDXDhlFR3RpILRb55BR3w=;
	b=fXTMGYL0HD0VCCcsP9hkY6b36o9JsBNd3eSMQbqnOV5AjYl6r8VjXvyM54jsUUxL40hVYT
	KC9YTWcqF6IVdAHvvmRWlsCEnBeZx+JCcYqhvpC18MLbhTy1wCRhHVYvyLVlDc1eU77fPy
	OP9sPUfpnQQeQ4yZeeOwFFxTj4/I3B88ypy7zjYvbOUn4Er7xKGSPxkiBkP/7zS6IhhT7d
	kVP0Wti+uZZ8cqOx3nxIEDNUWRqvW5392j2CwllIbk2HXFhFZccDTs9JpLcKf+mmBUmHMf
	XblQqd9wzd67tO9e/zryS6YxeEtqBbm79wKDw2q+P8omlXxd57RoxnfVHuL31A==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xITzf-0006SF-2V;
	Sun, 18 Oct 2026 18:44:19 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 702885C7D93;
	Sun, 18 Oct 2026 16:44:19 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	stable@kernel.org,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 03/12] can: replace ARPHRD_CAN type checks with can_get_ml_priv()
Date: Sun, 18 Oct 2026 18:41:39 +0200
Message-ID: <20261018164417.1540449-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261018164417.1540449-1-mkl@pengutronix.de>
References: <20261018164417.1540449-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Oliver Hartkopp <socketcan@hartkopp.net>

Commit 4e096a18867a ("net: introduce CAN specific pointer in the struct
net_device") introduced an explicit way to assign the midlayer private
pointer (dev->ml_priv) to named users like ML_PRIV_CAN. A valid pointer
returned by can_get_ml_priv() therefore identifies a real CAN device.

The referenced commit only converted the j1939 and proc code to this
check, while the other parts of the CAN subsystem still rely on
dev->type == ARPHRD_CAN.

The TUNSETLINK ioctl allows a down TUN/TAP device to set its hardware
type to ARPHRD_CAN while dev->ml_priv remains NULL. Such a repurposed
netdevice passes the ARPHRD_CAN checks in the CAN subsystem, which can
lead to a NULL pointer dereference of the CAN specific ml_priv. This
only requires owning a TUN/TAP device or CAP_NET_ADMIN in an
unprivileged user namespace.

can_rx_register() already rejects such a device since commit 8aa59e355949
("can: af_can: fix NULL pointer dereference in can_rx_register()"),
but can_rx_unregister() only checks dev->type and dereferences the NULL
ml_priv in can_dev_rcv_lists_find().

This path is reachable via isotp: isotp_bind() only checked for
ARPHRD_CAN and ignored the -ENODEV from can_rx_register(), so the socket
was marked as bound to the TUN device. A later isotp_release() or
NETDEV_UNREGISTER notification then crashes in can_rx_unregister().

Replace all remaining ARPHRD_CAN checks in net/can with
can_get_ml_priv(). For can_rx_register() and the can*_rcv() functions
this is a simplification without functional change.

Fixes: 4e096a18867a ("net: introduce CAN specific pointer in the struct net_device")
Cc: stable@kernel.org
Cc: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://patch.msgid.link/20261016093525.327367-1-socketcan@hartkopp.net
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
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
@@ -226,7 +226,7 @@ int can_send(struct sk_buff *skb, int loop)
 		goto inval_skb;
 	}
 
-	if (unlikely(skb->dev->type != ARPHRD_CAN)) {
+	if (unlikely(!can_get_ml_priv(skb->dev))) {
 		err = -EPERM;
 		goto inval_skb;
 	}
@@ -452,7 +452,7 @@ int can_rx_register(struct net *net, struct net_device *dev, canid_t can_id,
 
 	/* insert new receiver  (dev,canid,mask) -> (func,data) */
 
-	if (dev && (dev->type != ARPHRD_CAN || !can_get_ml_priv(dev)))
+	if (dev && !can_get_ml_priv(dev))
 		return -ENODEV;
 
 	if (dev && !net_eq(net, dev_net(dev)))
@@ -519,7 +519,7 @@ void can_rx_unregister(struct net *net, struct net_device *dev, canid_t can_id,
 	struct can_rcv_lists_stats *rcv_lists_stats = net->can.rcv_lists_stats;
 	struct can_dev_rcv_lists *dev_rcv_lists;
 
-	if (dev && dev->type != ARPHRD_CAN)
+	if (dev && !can_get_ml_priv(dev))
 		return;
 
 	if (dev && !net_eq(net, dev_net(dev)))
@@ -684,8 +684,7 @@ static int can_rcv(struct sk_buff *skb, struct net_device *dev,
 {
 	struct can_skb_ext *csx = can_skb_ext_find(skb);
 
-	if (unlikely(dev->type != ARPHRD_CAN || !can_get_ml_priv(dev) ||
-		     !csx || !can_is_can_skb(skb))) {
+	if (unlikely(!can_get_ml_priv(dev) || !csx || !can_is_can_skb(skb))) {
 		pr_warn_once("PF_CAN: dropped non conform CAN skbuff: dev type %d, len %d\n",
 			     dev->type, skb->len);
 
@@ -710,8 +709,7 @@ static int canfd_rcv(struct sk_buff *skb, struct net_device *dev,
 {
 	struct can_skb_ext *csx = can_skb_ext_find(skb);
 
-	if (unlikely(dev->type != ARPHRD_CAN || !can_get_ml_priv(dev) ||
-		     !csx || !can_is_canfd_skb(skb))) {
+	if (unlikely(!can_get_ml_priv(dev) || !csx || !can_is_canfd_skb(skb))) {
 		pr_warn_once("PF_CAN: dropped non conform CAN FD skbuff: dev type %d, len %d\n",
 			     dev->type, skb->len);
 
@@ -736,8 +734,7 @@ static int canxl_rcv(struct sk_buff *skb, struct net_device *dev,
 {
 	struct can_skb_ext *csx = can_skb_ext_find(skb);
 
-	if (unlikely(dev->type != ARPHRD_CAN || !can_get_ml_priv(dev) ||
-		     !csx || !can_is_canxl_skb(skb))) {
+	if (unlikely(!can_get_ml_priv(dev) || !csx || !can_is_canxl_skb(skb))) {
 		pr_warn_once("PF_CAN: dropped non conform CAN XL skbuff: dev type %d, len %d\n",
 			     dev->type, skb->len);
 
diff --git a/net/can/bcm.c b/net/can/bcm.c
index 3d637a1e0ac1..60406439a13f 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -54,6 +54,7 @@
 #include <linux/if_arp.h>
 #include <linux/skbuff.h>
 #include <linux/can.h>
+#include <linux/can/can-ml.h>
 #include <linux/can/core.h>
 #include <linux/can/skb.h>
 #include <linux/can/bcm.h>
@@ -1719,7 +1720,7 @@ static int bcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 				goto out_release;
 			}
 
-			if (dev->type != ARPHRD_CAN) {
+			if (!can_get_ml_priv(dev)) {
 				dev_put(dev);
 				ret = -ENODEV;
 				goto out_release;
@@ -1867,7 +1868,7 @@ static int bcm_notifier(struct notifier_block *nb, unsigned long msg,
 {
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
 
-	if (dev->type != ARPHRD_CAN)
+	if (!can_get_ml_priv(dev))
 		return NOTIFY_DONE;
 	if (msg != NETDEV_UNREGISTER && msg != NETDEV_DOWN)
 		return NOTIFY_DONE;
@@ -2024,7 +2025,7 @@ static int bcm_connect(struct socket *sock, struct sockaddr_unsized *uaddr, int
 			ret = -ENODEV;
 			goto fail;
 		}
-		if (dev->type != ARPHRD_CAN) {
+		if (!can_get_ml_priv(dev)) {
 			dev_put(dev);
 			ret = -ENODEV;
 			goto fail;
diff --git a/net/can/gw.c b/net/can/gw.c
index 5793cb2420ed..54bb5bd3242a 100644
--- a/net/can/gw.c
+++ b/net/can/gw.c
@@ -52,6 +52,7 @@
 #include <linux/if_arp.h>
 #include <linux/skbuff.h>
 #include <linux/can.h>
+#include <linux/can/can-ml.h>
 #include <linux/can/core.h>
 #include <linux/can/skb.h>
 #include <linux/can/gw.h>
@@ -612,7 +613,7 @@ static int cgw_notifier(struct notifier_block *nb,
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
 	struct net *net = dev_net(dev);
 
-	if (dev->type != ARPHRD_CAN)
+	if (!can_get_ml_priv(dev))
 		return NOTIFY_DONE;
 
 	if (msg == NETDEV_UNREGISTER) {
@@ -1163,7 +1164,7 @@ static int cgw_create_job(struct sk_buff *skb,  struct nlmsghdr *nlh,
 	if (!gwj->src.dev)
 		goto out;
 
-	if (gwj->src.dev->type != ARPHRD_CAN)
+	if (!can_get_ml_priv(gwj->src.dev))
 		goto out;
 
 	gwj->dst.dev = __dev_get_by_index(net, gwj->ccgw.dst_idx);
@@ -1171,7 +1172,7 @@ static int cgw_create_job(struct sk_buff *skb,  struct nlmsghdr *nlh,
 	if (!gwj->dst.dev)
 		goto out;
 
-	if (gwj->dst.dev->type != ARPHRD_CAN)
+	if (!can_get_ml_priv(gwj->dst.dev))
 		goto out;
 
 	/* is sending the skb back to the incoming interface intended? */
diff --git a/net/can/isotp.c b/net/can/isotp.c
index f5dc9d04bd68..6c28802c0605 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -65,6 +65,7 @@
 #include <linux/if_arp.h>
 #include <linux/skbuff.h>
 #include <linux/can.h>
+#include <linux/can/can-ml.h>
 #include <linux/can/core.h>
 #include <linux/can/skb.h>
 #include <linux/can/isotp.h>
@@ -1610,7 +1611,7 @@ static int isotp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int l
 		err = -ENODEV;
 		goto out;
 	}
-	if (dev->type != ARPHRD_CAN) {
+	if (!can_get_ml_priv(dev)) {
 		err = -ENODEV;
 		goto out_put_dev;
 	}
@@ -1897,7 +1898,7 @@ static int isotp_notifier(struct notifier_block *nb, unsigned long msg,
 {
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
 
-	if (dev->type != ARPHRD_CAN)
+	if (!can_get_ml_priv(dev))
 		return NOTIFY_DONE;
 	if (msg != NETDEV_UNREGISTER && msg != NETDEV_DOWN)
 		return NOTIFY_DONE;
diff --git a/net/can/raw.c b/net/can/raw.c
index 6944ebab3feb..ad611906b308 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -348,7 +348,7 @@ static int raw_notifier(struct notifier_block *nb, unsigned long msg,
 {
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
 
-	if (dev->type != ARPHRD_CAN)
+	if (!can_get_ml_priv(dev))
 		return NOTIFY_DONE;
 	if (msg != NETDEV_UNREGISTER && msg != NETDEV_DOWN)
 		return NOTIFY_DONE;
@@ -491,7 +491,7 @@ static int raw_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int len
 			err = -ENODEV;
 			goto out;
 		}
-		if (dev->type != ARPHRD_CAN) {
+		if (!can_get_ml_priv(dev)) {
 			err = -ENODEV;
 			goto out_put_dev;
 		}
-- 
2.53.0

