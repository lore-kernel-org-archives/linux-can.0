Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794137683;
	b=LoyoZFcKTexU5wLf6lUJPt8DXjpKV3YFv7fEcqiDuEc55achKao8xtGmWIKE4fq9MKka
	 XfxO9bESP4xuDSxrUJwCb7tQ0KwlfgRnzddhXmQrYENH/ecYCCcufBZiIkWzrQTkRa/w3
	 665wa+UeRFFFKN8qSJfJu7V5d1sVK67TgzN0q7cezlJ53JLKHIsOC8NwqXtjIleRibBnt
	 ez6bB5FYktjCqYWVS5jzO16UAZmwWPlc+YmVdMRu7JWL82k/fBTuQZhlCoU3hUwLWJwUI
	 B6XUnMxqEgIFuKrxjn+3DI53+gykCuaqTGq91isuD5NutN5pWswdWlnNCq37vOulWLA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794137683;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=6Ye3YRIsT97Mj7VVEQLs8MErXXMktUlYSgMTSWOhF4w=;
	b=W+gooKePDAXGm+UvALOHOtjbzZfxlgZgNRgrlq7nN8ES9zaujyZ03uv74Ga/xegCr8tu
	 qr7vNduHx2d5TGukARz45AYBhA2xviAJsmMBxMBo9g+c7HqI0wi21KGpkqgunNeBTCHkw
	 HfOWSPzCtVUUIqIRiJmRsGMmTI8dFb/Z+xoEcnvyDO2vVq/yC92yRSPR8nD2VXvQInY3k
	 xlFVlmFam5aBId+inrGO2vC+V+fI/ddNscmDVJ9XbTfcCdIdkZivrHMnSdH0BB2PEDq4V
	 NUil7Whfm3ZKHXqVkcmW7cIg+4Kvk6f1y/5yC0nqDW7hoevX3dHVzbSn3/60Ozk2pmQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=otrhMECy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABAC606A33E;
	Sun,  8 Nov 2026 11:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=otrhMECy
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794137682;
	b=QfYVReiec3EULbGuPW3vDW0ICkvM/WHed+oE+RlevzsQy+yfRgLgcdexdErf4MKR2w8i
	 xTgp1rYZWDsFOy0aVAGPLvpCsR+AZW6zb3/xeuOSuJExb2h8MOs4Ba2XhH02PTumqQwka
	 bBBNRgAdJ6dyzcZkFCYTwlM6iuEMGNAoIjuMHLv2TUbPoMwQQ6pX34ym3aU32LbSQHBxC
	 efXB99M9gkuwJRniCiS+WfsHnwVvHKbgJVno+MDorjothHilAWHX4+kFM1fJprcHCCRVr
	 +8fW7UEhe/QIlqV+16d6gt+pMku6dDfLOs3ZL0oRlg1oR06Sr6anf7DK+lz6AndSD8A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794137682;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=6Ye3YRIsT97Mj7VVEQLs8MErXXMktUlYSgMTSWOhF4w=;
	b=OUJsFmE5n+mVlP6dXiAwmpx27L/e8dogJebSD/JwY6NQwqlASwQoZGlSV6ZSZqCBPTum
	 fAhw4tQqQ6mPb3l8xqY+MueC3lqhQNuUE+a2QffrBxJVZkS9Z4JeoZE/rSxsUv+P/YN3Y
	 zOzB6jERj1Rt81YqhBDsMcl0Iv2g9090FZxjuCD6QxHONfRWLtVaEe2H24E2QkDS2aS5S
	 qXeXihniUf94X5GEG/QmJCXrVOp7VLd8cRGnmbPyDC5/O9v3SOh+PLhfYZ18oNjvzHNYL
	 4QI6ylVjhNY96ooK+yNQEDLXVBqPDlAXWeEPMk+8mUDCTG0Q57buRMWtb5WvGB7kMAA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id EBBD41F008A5;
	Sun,  8 Nov 2026 11:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794137682;
	bh=6Ye3YRIsT97Mj7VVEQLs8MErXXMktUlYSgMTSWOhF4w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=otrhMECykSAOHeuA9cyDYHupSYlcHcI+mK7Gfgfhkirbxzl4vmR5s2OX0ABkan8IT
	 wbig14/YLgnV6I58XZBztaB0FFv6VYQ7+v/sexlDfr61z76Ft15Zeh6O7/Hd1jgNr5
	 sCsF3cA8QQVrHkA5CJEot8MzeU+4O4BAwuxR9d55VRR1C6s+27Iwoc2tgMd5Q3K9BX
	 yvfwgZMA31obUMYtlSTC+aD22b4rFVo0N3QOI2L7itDjUGxxCq/YZGUQY82xhAvTaJ
	 E7R1m1QvOhgfSy4GDWyvMSYd1R+K1OdnC/f2xTAnrQdAMrXj7GqhNyaPKG45+qqiba
	 O+aFThzpF+fVQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 6CD5A47F1D;
	Sun,  8 Nov 2026 11:34:40 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Sun, 08 Nov 2026 19:33:32 +0800
Subject: [PATCH net v8 05/10] can: dev: add
 close_candev_cancel_restart_sync()
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
Message-Id: <20261108-rockchip-canfd-restart-close-v8-5-3e7a23fd9eae@qq.com>
References: <20261108-rockchip-canfd-restart-close-v8-0-3e7a23fd9eae@qq.com>
In-Reply-To: <20261108-rockchip-canfd-restart-close-v8-0-3e7a23fd9eae@qq.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Vincent Mailhol <mailhol@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: Cunhao Lu <1579567540@qq.com>, linux-can@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794137678; l=2772;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=v/w3baS7Y/4CSnrJdEt045rABuum9hoKz/eYbLPkCUU=;
 b=b3fWueZPiCxmEK+6grqDu5zrIpvgA7n/YvlaHeR4G9+5+brdmJ92xQykmGoimm7mTHi5zzedz
 Eh1phgIqbOqAEMPwYMHhuGTH9h23g4xGBI4I0ve8VZG8+RBy6qKsY3G
X-Developer-Key: i=1579567540@qq.com; a=ed25519;
 pk=sUTWrzlIwT4C7ctjNfVZAzzg0G7QUn2XxRGpYsw4RtM=
X-Endpoint-Received: by B4 Relay for 1579567540@qq.com/20261015 with
 auth_id=1177
X-Original-From: Cunhao Lu <1579567540@qq.com>
Reply-To: 1579567540@qq.com
Content-Transfer-Encoding: 7bit

From: Cunhao Lu <1579567540@qq.com>

Drivers may need to wait for bus-off recovery before tearing down the
IRQ and hardware resources used by their restart callback. Calling
close_candev() at that point also flushes echo skbs, which belongs after
the driver has quiesced the users of those buffers.

Add close_candev_cancel_restart_sync() in linux/can/dev.h so drivers can
cancel the core restart work separately, without accessing can_priv's
work item directly. The helper only cancels restart work; callers must
still stop its producers and call close_candev() for the final cleanup.

Use the helper in close_candev(), preserving its existing cancellation
and echo cleanup order.

The following Rockchip fix uses the helper at the start of rkcanfd_stop()
to wait for recovery before IRQ teardown, leaving echo cleanup to
close_candev().

Signed-off-by: Cunhao Lu <1579567540@qq.com>

---
Changes in v6:
- Describe the helper's use by the following Rockchip fix.
---
 drivers/net/can/dev/dev.c |  4 +---
 include/linux/can/dev.h   | 17 +++++++++++++++++
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index a893a49a3381..39271a3ef0fa 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -537,9 +537,7 @@ EXPORT_SYMBOL_GPL(of_can_transceiver);
  */
 void close_candev(struct net_device *dev)
 {
-	struct can_priv *priv = netdev_priv(dev);
-
-	cancel_delayed_work_sync(&priv->restart_work);
+	close_candev_cancel_restart_sync(dev);
 	can_flush_echo_skb(dev);
 }
 EXPORT_SYMBOL_GPL(close_candev);
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 346faddee02e..2a286f906394 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -22,6 +22,7 @@
 #include <linux/can/skb.h>
 #include <linux/ethtool.h>
 #include <linux/netdevice.h>
+#include <linux/workqueue.h>
 
 /*
  * CAN mode
@@ -115,6 +116,22 @@ struct can_priv *safe_candev_priv(struct net_device *dev);
 
 int open_candev(struct net_device *dev);
 void close_candev(struct net_device *dev);
+
+/**
+ * close_candev_cancel_restart_sync() - cancel bus-off restart synchronously
+ * @dev: CAN network device
+ *
+ * Call before tearing down resources used by the restart callback.
+ * The driver must quiesce restart work producers before calling
+ * close_candev() for the final cleanup.
+ */
+static inline void close_candev_cancel_restart_sync(struct net_device *dev)
+{
+	struct can_priv *priv = netdev_priv(dev);
+
+	cancel_delayed_work_sync(&priv->restart_work);
+}
+
 void can_set_default_mtu(struct net_device *dev);
 void can_set_cap_info(struct net_device *dev);
 int __must_check can_set_static_ctrlmode(struct net_device *dev,

-- 
2.34.1


