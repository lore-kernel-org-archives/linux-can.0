Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6ECC4DAF96;
	Fri,  9 Oct 2026 13:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553416; cv=pass; b=RIEDQ3oBxlSpRGXhxu2xPFTNsYfmQZkWuwFd4pZRnlx25m/FsucrClhEJ3FYnyjFya3+Ed1XeXQ/ZCAM3LXp0udmHx2qlIQ+JJg2/JtbmCnQWxCg8W9P4OYlnaeVf8bDz4tEbtohgiDpEEIESEI8HTu6xThmEQUt4gOjuFxNArk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553416; c=relaxed/simple;
	bh=MjKeih5GP0NPauSj1KpLOc/fzl1rL/GBuf6XPRSmDHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WJAHrRz21buKksJa+XkUm1B4dbNHXLQVmCpJBYurkcKQwdXQpHhZuagGzGdE+6RGbWht9oclBl1T0VI8Q/nkwZz7V9kqy5QFV9pUNbHRa7DxBMnQLStB9nwBAPViagnja0Ira9RvaBlRBZ5Pgc/oOVXTlYJ3BATuYd7b2OPO7ck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=fFFX0aOH; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="fFFX0aOH"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 4E034202601;
	Fri, 09 Oct 2026 15:43:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791553412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w0uIS6B18d4ja6FLjRfxob+h5H6ZdDTQ+S4kGi4cLEk=;
	b=fFFX0aOHBCkFtgFON1cHhh6OKIVYBHknuRpcHRWt6u2vL0MsdHnHWeTlNGJ98VLeVVdaZz
	O8d+kfVs+A+nefYgfRbVLrgonZJueWU81Z0CTFS3Zo3q03E2+pQy4viFXAxPfYMB5VgBnR
	U/3dz1wVcm8EXWo32CEuOsxNhMkjkqIFM310De7hWyCUb0tm8DNRQGoFmDkPVc20U/3qOv
	o7glXT5CSrgyRgK4c08/g9sZxbZ1FyOmiBipNUr5wrZQVDc8mU9vMG0+X1g654ClnIHDtn
	HPkqavRYvqrX0gGqhuH9ZrsRh5uF6S59YMNnbYr2g4fUQlSZ8TcJ9iZkOTOo+A==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791553412; a=rsa-sha256;
	cv=none;
	b=UIoPioHANUCcZrhDgfumy2gBBZdhajZaPaRFMY8gFhcF++awD77JOeoRu8skf9qZ6OwFHP
	RVvwEJdbrugSoF84QZAxXdbfwGIedmNdui8wE95vuuPI9yJYSZmCR2GdRdV8iviozX3AsM
	gbtGuZ1IS36HYJUSHnXSjnynrEwGTwYoloKzDRR1hxQNBmci7DYXH7rKlhvjKhueUTkrb3
	6dBCZpDe7cft5QKuw9QiXv1oljAfzFCkTmuEu6GkHnM0Tktv/Yk4i5cH7pZW2qS/4n9yV4
	LlM1muSuW+IlkO3deZLCOc/J6R+VLat3bf9RRKRhabp4APIN7jq2NccG4QB5fA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791553412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w0uIS6B18d4ja6FLjRfxob+h5H6ZdDTQ+S4kGi4cLEk=;
	b=IkBbpWqxd4tzsqK1tz8cEhy5WYMbG99ZKR/rwciIkh7y2ODs2YNQ39Gysqvo1wfwdo6L6q
	C1QlaQEVq13MYj/eLafcb2Q6bEBSSGBUX0F1HIJYBbLF1u1lgX0D+Uq7Ymaqe23CWGasEM
	Er/hw1tsuiTdfk1c4f2HuNbyn32PZsZ73AxqZLv0y6qglvgzA/PCcFN0aO6OVpZyLpIY02
	L7W4MQ1Em0OpDJ2ZmkeC5oPyJTO0VntQXbCehfmkmummY3SXgZ6aHK4m/WyFYdeth0bUu4
	CMUWID49RdQRRRvnFtXM6Bz9VS2VIO9UTlPrX1bfb+B7HJncdGmA7FQY40ZVIg==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xFAsm-0053Rh-0g;
	Fri, 09 Oct 2026 15:43:32 +0200
Received: from blackshift.org (90-182-211-1.rcp.o2.cz [90.182.211.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id B9AF95BD89E;
	Fri, 09 Oct 2026 13:43:31 +0000 (UTC)
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
Subject: [PATCH net-next 03/37] can: convert unreliable ARPHRD_CAN type checks to robust can_get_ml_priv()
Date: Fri,  9 Oct 2026 15:27:35 +0200
Message-ID: <20261009134323.64064-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009134323.64064-1-mkl@pengutronix.de>
References: <20261009134323.64064-1-mkl@pengutronix.de>
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
Link: https://patch.msgid.link/20261009121115.61012-1-socketcan@hartkopp.net
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

