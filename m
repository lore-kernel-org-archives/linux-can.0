Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AB23612CF
	for <linux-can@vger.kernel.org>; Fri, 31 Jul 2026 23:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785539879; cv=none; b=rS1Z5ofAYAWwFZxWLQ2ANWafpgmS1i258ibAcUez9ofb1lV56XunocFlVDSEfmBay9tHAWeHkrRgK6OtnXkcjilfFH6YJbCSxwYqAC6xpeyikLzj2fDWIl8ug2qHJDIW3cEO2AgIs3JoGZgAbX4ALcS5h3rI5UP5upR6yGnzLZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785539879; c=relaxed/simple;
	bh=2J74l0n/n8xU/ZTfvTlyhrO3owtDtIFNJ6tx4xfBGTY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nC8Xr0OliVbCSj/gMYzJHWIAOQ88qvM16XcxhWcWR+ttdQbAQzxLdQFoQdp9b7vEKd0Y3k8w7fvUKODUKC+r6AFWgCF8o6shv4Zr3jhnLtT9LC10/kFwzuM3JuRPQ0G0Q5qktXFaHYBPoighCZjM2RZSr7zX9Zv8mwcuOmoiofM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PZ1ulG0+; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PZ1ulG0+"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cc7e86e7c5so28025835ad.3
        for <linux-can@vger.kernel.org>; Fri, 31 Jul 2026 16:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785539877; x=1786144677; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2Ud6J+POpBAx8mNcaRij0vS2ZuUm8caJUzPhHe6iuIY=;
        b=PZ1ulG0+89fWxps3dQFQ2xA1+q902gQzOeefgGzVjIPzOyTRbcocLzmlUWc5xHmbdk
         601fBUQfCZ2l7aNVTormWd1Z4itIn82Oxm1YAI2tsqEo/+AjBiS7AKVyI89a6U+vcXSx
         ldgX6lXrpEWbnRaCxZP03g5usAoFfX2MfyjLooriDlEkNknKXRc2GkhgEt5qfSU+/a0e
         RSJ8fR9ir6kTVjtbTZ0uPJj+w5i0cs6hL5ugCOiP0wa6qY79fzohYpYsby/InL8qxBwY
         rqG0RHkWKIsmcrEaPBVwjy5kgkXlpjuIH7FzW2CPu3CDtVDxeRfupENTWd1zBr862dAy
         W3Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785539877; x=1786144677;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2Ud6J+POpBAx8mNcaRij0vS2ZuUm8caJUzPhHe6iuIY=;
        b=E3uBSDcTW0kYM8B60G/3ZtW6gLMSB0oL76bW73izzOjbXQhLSdypi9aET6iXVd/vZ+
         BoKMdRh39F004B+VLkw21x75memEFJ4OFo2fQ9bghXwbTQsE+WULZYP+4BDoFyeYWWGv
         pOjcG8whQQ75lfb4uzTOahLqP9A9EA/XUyZgXzd49jcDQYWi+ylgeq/rjIKwFlYXu2G0
         qhnPy/y6tkcg+seytoMfN2hRlj5HuqwPXR1i1lHQNfGkpRH2HXvH4wAhIKvYAXgnaZoj
         zBGM8c9FYdZemX7d3wvj6barUjwCxBjzgVkl3/jGTx+XmdWrmtFfolpilOCFl11cpnC5
         KHEA==
X-Forwarded-Encrypted: i=1; AHgh+Rq+iQnyjZLMBBq2Zyf8Tz4fm2S0N2aSAEniwO5DHf/SQqJr8eWHrn1M2e+3RL8p33RA6CkuRsNMa7c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/jOiZA4kpS9VZj2QqrZYUpQIXfNKxvPh1kKQoVcoXgx/Ns2Y0
	13pUk4e3rD0mJcw3tf0XrJ+iWyAgkM3SfVO2tl3UlhtTf5fxaeQ/59+2y7/ABDoA4FQxC7hsqYP
	+KfiS5w==
X-Received: from pjuu7.prod.google.com ([2002:a17:90b:5867:b0:38d:f003:cd24])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:53c7:b0:380:105f:8ffd
 with SMTP id 98e67ed59e1d1-38fbc48b61emr1386129a91.16.1785539876973; Fri, 31
 Jul 2026 16:17:56 -0700 (PDT)
Date: Fri, 31 Jul 2026 23:17:53 +0000
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260731231755.2474376-1-kuniyu@google.com>
Subject: [PATCH RESEND v1] vxcan: Support per-netns device unregistration.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

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
---
This mirros commit d7fda2c776b2 ("veth: Support per-netns device
unregistration.").
---
 drivers/net/can/vxcan.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
index e882250180ef..b7efed1226d8 100644
--- a/drivers/net/can/vxcan.c
+++ b/drivers/net/can/vxcan.c
@@ -33,6 +33,7 @@ MODULE_ALIAS_RTNL_LINK(DRV_NAME);
 
 struct vxcan_priv {
 	struct net_device __rcu	*peer;
+	netdevice_tracker	peer_tracker;
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
2.55.0.571.g244d577d93-goog

