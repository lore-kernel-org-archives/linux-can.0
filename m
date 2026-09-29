Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AAB415F25;
	Tue, 29 Sep 2026 21:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790716036; cv=pass; b=DjTZDHgjA1z5/6sTzVFbSNKpcWzf1Ud8GSqs9QV/XbQXJDoXvCFTbQI/TtDzNxexpGOPyNGqi5Fj8h2rBwbyW+eSpK+xBy9IBkbx1OplJCiwCFOSU9m4iJ9YVdoZ42dyOVwh3xS0Bguqms3J/sh2XgUabQzVHBCrG0WqOQVe6Ts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790716036; c=relaxed/simple;
	bh=kIi1dhT5bfX1wGCm1+Qqe/I7x4PpPb19bjbPHq0KN9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yro+lV4+lZOGYS0qoK7rRqNfLgt3IWIYjSEWDew0cpWayuv+qbHeGvJb84hpCWgCihyoCwmPsp92B0DVVZinbFhJ3KIRiRAhwzi2wv/4buefGvgdhIKz0q9BChlJR2zYsb3OqlQ7Jz+Q5n1MX7+eUm3IsgM02YWUyL0I9E/2lz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=DExSLkOc; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="DExSLkOc"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 921DA2006AF;
	Tue, 29 Sep 2026 23:07:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790716023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b462ccI3jFus0sm/si/8nslxa4Yv2+FLJCVTneiOmIE=;
	b=DExSLkOc7qZJz6mah8dy1j+T2dRHbRIkYBA9eWDU1WOdfeYNbdhEojyZ0GjShmsYbUyc9V
	lIUNmM6ZHAMbMKFJ1zuEfeYvve6a2TvLKfZN2YOaNut/ZtfiMzTGdWDN994p9WXbjBU6FS
	HWLiSHCLZJLh2gVVMbCeJQnuaIBZorJrLJ8olo1qKQiPJJk1UqUZFWYhgofUfFUbKH6TYi
	uMeTDr+gCu/tlD4Oi1GwGJ8L8+6S7dB02GMlQVT445fD38zsfo1bPf/WOX3h0MieFyWI9+
	V2hQIh0W8KwuoKxofCalD6c3CcrZn5uYUGjpm5g69CGh9lvqOJQs+e3GJAlVeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790716023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b462ccI3jFus0sm/si/8nslxa4Yv2+FLJCVTneiOmIE=;
	b=Oz7Im8dqloXiowodzH9Z3yitKII6xyc8uVqtSccWqPysrzcsOdrh4bGzR7a74uHCapIAWK
	yxq3qiXhGZPOyxgqJWCVXtxpMy1e3u6AfJz/vgrB9Yo6a/pzeR0OkAZcxK+eaF8n+V8EsW
	FrogQ6ifZeHtr+FxKAmiCBrKUb3ErCkNPJlRSGvEsWFTgH5vqSBZ4l8+e4D1U2BRD6yNHe
	QvSEM+0vw7hpwD57tTwGtc9pc7VmFEcOqQWuc+7oDSoK+mF+4RTPyt37mDWXpAQjag11mp
	TniCYbCxuAh/QL5j8nx13EZH9gW0Kbm/aeWuNnL3hT7hqDdHM/XeY4XK+JWMYw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790716023; a=rsa-sha256;
	cv=none;
	b=Sit3huHjDxj9Jgtgi+yyxNLzvAKuJlaJNKhd9aybPoAFasy/k+j+w2Qeka5RTS/3hHIlrj
	pxB2LSlaP2z5A/BL775yGCE85dC88MPAhO6vubUTBCMBAMSLyKs1hIbrRL3m/tSrAAlIUL
	+c6PSpQAizoL+h1RYVtDck4dR1Jt8lzHl7gRWxeX3hq4RkE+HKsbYvR3SWkI+8Edrh+mLR
	+MMsBd45K+v1G+9q18RoDQDgjc+1DTtWRgG8G6JJSJyewZUu3yc/YaGeq38JkfZzOemMrW
	6iVHTunJD7z11V6a8lpJLBX8yMWnBimtCF2YWfF4loTiGGEa+WmIGLsgDxyHxQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xBf2V-003S3f-1P;
	Tue, 29 Sep 2026 23:07:03 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 2039E5B4CD4;
	Tue, 29 Sep 2026 21:07:03 +0000 (UTC)
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
Subject: [PATCH net 04/16] can: convert unreliable ARPHRD_CAN type checks to robust can_get_ml_priv()
Date: Tue, 29 Sep 2026 22:43:54 +0200
Message-ID: <20260929210700.1183036-5-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929210700.1183036-1-mkl@pengutronix.de>
References: <20260929210700.1183036-1-mkl@pengutronix.de>
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
pointer (dev->ml_priv) to named users like ML_PRIV_CAN.

With this extension the CAN device specific ml_priv assignment became a
robust indicator to identify a valid CAN device, when can_get_ml_priv()
returns a valid pointer.

This has been used directly by the referenced commit in the CAN specific
j1939 and proc code but not in the other parts of the CAN subsystem.

With the TUN/TAP driver a device's ARPHRD type can be controlled by
userspace independently of its midlayer private data (ml_priv). The
TUNSETLINK ioctl allows a down TUN/TAP device to overwrite its hardware
type to become ARPHRD_CAN while dev->ml_priv remains NULL (uninitialized).

Instead of checking dev->type being the unreliable ARPHRD_CAN value convert
the missing "valid CAN devices" checks to can_get_ml_priv().

Fixes: 4e096a18867a ("net: introduce CAN specific pointer in the struct net_device")
Cc: stable@kernel.org
Cc: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://patch.msgid.link/20260929163424.16382-3-socketcan@hartkopp.net
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/af_can.c | 12 ++++++------
 net/can/bcm.c    |  7 ++++---
 net/can/gw.c     |  7 ++++---
 net/can/isotp.c  |  5 +++--
 net/can/raw.c    |  4 ++--
 5 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/net/can/af_can.c b/net/can/af_can.c
index 7bc86b176b4d..ef435f22ac93 100644
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
@@ -687,7 +687,7 @@ static void can_receive(struct sk_buff *skb, struct net_device *dev)
 static int can_rcv(struct sk_buff *skb, struct net_device *dev,
 		   struct packet_type *pt, struct net_device *orig_dev)
 {
-	if (unlikely(dev->type != ARPHRD_CAN || !can_get_ml_priv(dev) ||
+	if (unlikely(!can_get_ml_priv(dev) ||
 		     !can_skb_ext_find(skb) || !can_is_can_skb(skb))) {
 		pr_warn_once("PF_CAN: dropped non conform CAN skbuff: dev type %d, len %d\n",
 			     dev->type, skb->len);
@@ -703,7 +703,7 @@ static int can_rcv(struct sk_buff *skb, struct net_device *dev,
 static int canfd_rcv(struct sk_buff *skb, struct net_device *dev,
 		     struct packet_type *pt, struct net_device *orig_dev)
 {
-	if (unlikely(dev->type != ARPHRD_CAN || !can_get_ml_priv(dev) ||
+	if (unlikely(!can_get_ml_priv(dev) ||
 		     !can_skb_ext_find(skb) || !can_is_canfd_skb(skb))) {
 		pr_warn_once("PF_CAN: dropped non conform CAN FD skbuff: dev type %d, len %d\n",
 			     dev->type, skb->len);
@@ -719,7 +719,7 @@ static int canfd_rcv(struct sk_buff *skb, struct net_device *dev,
 static int canxl_rcv(struct sk_buff *skb, struct net_device *dev,
 		     struct packet_type *pt, struct net_device *orig_dev)
 {
-	if (unlikely(dev->type != ARPHRD_CAN || !can_get_ml_priv(dev) ||
+	if (unlikely(!can_get_ml_priv(dev) ||
 		     !can_skb_ext_find(skb) || !can_is_canxl_skb(skb))) {
 		pr_warn_once("PF_CAN: dropped non conform CAN XL skbuff: dev type %d, len %d\n",
 			     dev->type, skb->len);
diff --git a/net/can/bcm.c b/net/can/bcm.c
index cd3522ec32c0..940b917e3830 100644
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
@@ -1760,7 +1761,7 @@ static int bcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 				goto out_release;
 			}
 
-			if (dev->type != ARPHRD_CAN) {
+			if (!can_get_ml_priv(dev)) {
 				dev_put(dev);
 				ret = -ENODEV;
 				goto out_release;
@@ -1908,7 +1909,7 @@ static int bcm_notifier(struct notifier_block *nb, unsigned long msg,
 {
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
 
-	if (dev->type != ARPHRD_CAN)
+	if (!can_get_ml_priv(dev))
 		return NOTIFY_DONE;
 	if (msg != NETDEV_UNREGISTER && msg != NETDEV_DOWN)
 		return NOTIFY_DONE;
@@ -2069,7 +2070,7 @@ static int bcm_connect(struct socket *sock, struct sockaddr_unsized *uaddr, int
 			ret = -ENODEV;
 			goto fail;
 		}
-		if (dev->type != ARPHRD_CAN) {
+		if (!can_get_ml_priv(dev)) {
 			dev_put(dev);
 			ret = -ENODEV;
 			goto fail;
diff --git a/net/can/gw.c b/net/can/gw.c
index 0ec99f68aa45..d9912dea738b 100644
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
@@ -609,7 +610,7 @@ static int cgw_notifier(struct notifier_block *nb,
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
 	struct net *net = dev_net(dev);
 
-	if (dev->type != ARPHRD_CAN)
+	if (!can_get_ml_priv(dev))
 		return NOTIFY_DONE;
 
 	if (msg == NETDEV_UNREGISTER) {
@@ -1160,7 +1161,7 @@ static int cgw_create_job(struct sk_buff *skb,  struct nlmsghdr *nlh,
 	if (!gwj->src.dev)
 		goto out;
 
-	if (gwj->src.dev->type != ARPHRD_CAN)
+	if (!can_get_ml_priv(gwj->src.dev))
 		goto out;
 
 	gwj->dst.dev = __dev_get_by_index(net, gwj->ccgw.dst_idx);
@@ -1168,7 +1169,7 @@ static int cgw_create_job(struct sk_buff *skb,  struct nlmsghdr *nlh,
 	if (!gwj->dst.dev)
 		goto out;
 
-	if (gwj->dst.dev->type != ARPHRD_CAN)
+	if (!can_get_ml_priv(gwj->dst.dev))
 		goto out;
 
 	/* is sending the skb back to the incoming interface intended? */
diff --git a/net/can/isotp.c b/net/can/isotp.c
index 0835a4758a72..d3f79efc9c1e 100644
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
@@ -1606,7 +1607,7 @@ static int isotp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int l
 		err = -ENODEV;
 		goto out;
 	}
-	if (dev->type != ARPHRD_CAN) {
+	if (!can_get_ml_priv(dev)) {
 		err = -ENODEV;
 		goto out_put_dev;
 	}
@@ -1890,7 +1891,7 @@ static int isotp_notifier(struct notifier_block *nb, unsigned long msg,
 {
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
 
-	if (dev->type != ARPHRD_CAN)
+	if (!can_get_ml_priv(dev))
 		return NOTIFY_DONE;
 	if (msg != NETDEV_UNREGISTER && msg != NETDEV_DOWN)
 		return NOTIFY_DONE;
diff --git a/net/can/raw.c b/net/can/raw.c
index c5596fc9aac5..7c48ff36e6cd 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -341,7 +341,7 @@ static int raw_notifier(struct notifier_block *nb, unsigned long msg,
 {
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
 
-	if (dev->type != ARPHRD_CAN)
+	if (!can_get_ml_priv(dev))
 		return NOTIFY_DONE;
 	if (msg != NETDEV_UNREGISTER && msg != NETDEV_DOWN)
 		return NOTIFY_DONE;
@@ -484,7 +484,7 @@ static int raw_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int len
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

