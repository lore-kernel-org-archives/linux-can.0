Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63353F328C;
	Mon, 17 Aug 2026 23:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787009676; cv=none; b=F0noIuV726/Lh459QFT/S2kvIoGXOtKZLgsyS3THAF6tIsh5SEpzLak0IXdLchzwb6XmMljTzV1O8jAZcYPwAbUhC4SQSvjcAjjgJb7f1QM3BujRc4jvabn5L9JFIpTgG74R3L4dvP1UIw7g1hvjqHHkEybxnfJiriC6mxpL2cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787009676; c=relaxed/simple;
	bh=wjGr5AXhhzPvJ4hcK9Ff/G40P9EYnk65OM3CgJVnqDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XXoTJbfgLF3RjVIeid0GVLWu+J3GFImgPQI9WEfSj89sHCt+awWpSrlqI2RlHLw9g0DuaFudO8K92VTzCpeW+X+Gcb3HBhwiver84qJfi+jFzKJPzEn7mnj3SXqhbAZ4gU6FkmgQnQZGW6TIFXfAnOW9MR582pQy/rFntlGMveI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id D341D202284;
	Tue, 18 Aug 2026 01:34:22 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ww6qU-00220q-2E;
	Tue, 18 Aug 2026 01:34:22 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 48D6A585158;
	Mon, 17 Aug 2026 23:34:22 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 05/11] can: vxcan: support per-netns device unregistration.
Date: Tue, 18 Aug 2026 01:24:32 +0200
Message-ID: <20260817233420.2068204-6-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817233420.2068204-1-mkl@pengutronix.de>
References: <20260817233420.2068204-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@google.com>

Currently, vxcan_dellink() unregisters both local and peer devices
synchronously under RTNL.

Once RTNL is removed, it can be called concurrently from different
netns.

Let's use xchg() and unregister_netdevice_queue_net() to support
per-netns device unregistration.

This way, each device is queued for destruction only once by
the winner of the race.

Note that the extra netdev_hold() ensures that @peer obtained by
the first xchg() is not freed during the subsequent access to
netdev_priv(peer).  The 2nd xchg() overwrites @dev to balance
the refcount.

Tested:

1. Create two vxcan pairs (vxcan1-2, vxcan3-4) between two netns
   (ns1 & ns2).

  # ip netns add ns1
  # ip netns add ns2
  # ip -n ns1 link add vxcan1 type vxcan peer vxcan2 netns ns2
  # ip -n ns1 link add vxcan3 type vxcan peer vxcan4 netns ns2

2. Run bpftrace to check if the same process does NOT
   unregister the paired vxcan devices

  # bpftrace -e '#include <linux/netdevice.h>
  kprobe:free_netdev {
      $dev = (struct net_device *)arg0;
      printf("PID: %d | DEV: %s%s\n", pid, $dev->name, kstack());
  }'

3. Remove vxcan2 in ns2 and check bpftrace output

  # ip -n ns2 link del vxcan2

  PID: 1524 | DEV: vxcan2
          free_netdev+5
          netdev_run_todo+4798
          rtnl_dellink+1507
          rtnetlink_rcv_msg+1791
          netlink_rcv_skb+504
  ...
  PID: 453 | DEV: vxcan1
          free_netdev+5
          netdev_run_todo+4798
          process_scheduled_works+2538
          worker_thread+1906
          kthread+806
          ret_from_fork+805
          ret_from_fork_asm+17

4. Remove ns2 (thus vxcan4) and check bpftrace output

  # ip netns del ns2

  PID: 12 | DEV: vxcan4
          free_netdev+5
          netdev_run_todo+4798
          default_device_exit_batch+2271
          ops_undo_list+993
          cleanup_net+1122
          process_scheduled_works+2538
          worker_thread+1906
          kthread+806
          ret_from_fork+805
          ret_from_fork_asm+17
  ...
  PID: 462 | DEV: vxcan3
          free_netdev+5
          netdev_run_todo+4798
          process_scheduled_works+2538
          worker_thread+1906
          kthread+806
          ret_from_fork+805
          ret_from_fork_asm+17

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/20260731231755.2474376-1-kuniyu@google.com
[mkl: fix indention struct vxcan_priv::peer_tracker]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/vxcan.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
index e882250180ef..9e2e25d02471 100644
--- a/drivers/net/can/vxcan.c
+++ b/drivers/net/can/vxcan.c
@@ -33,6 +33,7 @@ MODULE_ALIAS_RTNL_LINK(DRV_NAME);
 
 struct vxcan_priv {
 	struct net_device __rcu	*peer;
+	netdevice_tracker peer_tracker;
 };
 
 static netdev_tx_t vxcan_xmit(struct sk_buff *oskb, struct net_device *dev)
@@ -268,9 +269,11 @@ static int vxcan_newlink(struct net_device *dev,
 	/* cross link the device pair */
 	priv = netdev_priv(dev);
 	rcu_assign_pointer(priv->peer, peer);
+	netdev_hold(peer, &priv->peer_tracker, GFP_KERNEL);
 
 	priv = netdev_priv(peer);
 	rcu_assign_pointer(priv->peer, dev);
+	netdev_hold(dev, &priv->peer_tracker, GFP_KERNEL);
 
 	return 0;
 
@@ -281,24 +284,25 @@ static int vxcan_newlink(struct net_device *dev,
 
 static void vxcan_dellink(struct net_device *dev, struct list_head *head)
 {
+	netdevice_tracker *peer_tracker;
 	struct vxcan_priv *priv;
 	struct net_device *peer;
 
 	priv = netdev_priv(dev);
-	peer = rtnl_dereference(priv->peer);
+	peer_tracker = &priv->peer_tracker;
+	peer = unrcu_pointer(xchg(&priv->peer, NULL));
+	if (!peer)
+		return;
 
-	/* Note : dellink() is called from default_device_exit_batch(),
-	 * before a rcu_synchronize() point. The devices are guaranteed
-	 * not being freed before one RCU grace period.
-	 */
-	RCU_INIT_POINTER(priv->peer, NULL);
 	unregister_netdevice_queue(dev, head);
 
-	if (peer) {
-		priv = netdev_priv(peer);
-		RCU_INIT_POINTER(priv->peer, NULL);
-		unregister_netdevice_queue(peer, head);
-	}
+	priv = netdev_priv(peer);
+	dev = unrcu_pointer(xchg(&priv->peer, NULL));
+	if (dev)
+		unregister_netdevice_queue_net(dev_net(dev), peer, head);
+
+	netdev_put(peer, peer_tracker);
+	netdev_put(dev, &priv->peer_tracker);
 }
 
 static const struct nla_policy vxcan_policy[VXCAN_INFO_MAX + 1] = {
-- 
2.53.0

