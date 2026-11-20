Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.167
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795174148;
	b=KRvK1obcNSkCoBDujvmjf4i6qt27vGxDRkw4eE7pXXo4pLW7aJTM6rYu0BJHlA8cL1KF
	 utcClfB+cAfYMbNBwfAYBjanmmCaLYzVVbpQif5ge4VcMnvQGJMuprmODuG0io+AXU5BJ
	 dA+AE4XZAzItsF5/3gyAggSSp8kGugMrC3JVSX8KWapRhtyrr3mwUU0Cc91vlnRld4IvS
	 vnvBLoVs8flXsfdwZNXJC97vv545ah1ntt8beBlTdBHnT7UOobl+6kUnYh9zXTIPl6PbH
	 5lzefsYRSPFiIDppcqGi2XZtEvqERLErnBWIb0E1IvlupG57jktUsso0linQcj5Tfww==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795174148;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=dyfeK/GUPie55ziz2SjorD4OfwLrUe0NHuQHCGK1cTQ=;
	b=uz9m4aAySIZYx3KXrmeCHicgdB5t1yELnXRbuPk3VONSi9v8V0wW26BYhxrMGDv+l/hc
	 6Do0VLd/NHqBbG1dd0qO5ekAOC41C73nyyQVPAJMGh+soYcyRhY8yaIKlAWjcmg0MqorX
	 Y8022L3604NMhp2U7h67nIBkjCNRjr7s3+hpfXwW6KtRr2atQdOr08XACjSgk4NVJWb36
	 62zSpbmiMELbrwZX1yvS9lkDRT/2RTd0y5TB5eU4cQY8E7iYAjW+STr6Pyf7a1FMZfwOT
	 XrwB55Ovd1aU+yMGhy+JW1mCKrlDyaS6ZT2ud/bFIxXZYqyMGEAaud9zXMqGf/htXRQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=ISbaUp3X;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b="dGyO/b7w";
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.167
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB4160A2605
	for <linux-can@vger.kernel.org>; Fri, 20 Nov 2026 11:29:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4AB4160A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=ISbaUp3X;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=dGyO/b7w
ARC-Seal: i=1; a=rsa-sha256; t=1795174142; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=oRyYnRcdn1+zFfYcFBTd+a4OQPQWKm5OoeTeOTijUbDJuU5F+LHKKxMr6nc83AaTe+
    rT+nLsmGvyJXe1eATbGeKvMc2hISm2zmr0cZ6O2bvm75KEGIQwx65v/nOpKkMhcxzaNr
    8rbj4ncgUcRQF6Qtnv3ekQn6L3XLXSfqWWpr9g8GewHpXq5fQWqyR+1BKOn9kzXkcOb4
    q+9/jpnHwLdnE9hcV+kpJetZmEXmvjmJBI25RLsjemTY8qcdnDHaJAtgFT1Zi/eb6Q9S
    4VbAp4qWLWN7Oj2uyvNLzJC8LdU5wbPr2M9sMIodTq7AU4g1YjtjE19RjTthQEz2Mjz5
    6Ikg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795174142;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=dyfeK/GUPie55ziz2SjorD4OfwLrUe0NHuQHCGK1cTQ=;
    b=VntYZ8/uhhIZKIYm8iwJBi3vZqP+fM3bA4r5xk3/S2qZcbdEkVGJYQ6+mUUBLKYh7f
    34ihlnzh6AUfgOYe/ZOQ9ppKDCNHvV5JI9NCnr7zKEvyP7QzF8OIulodedgy8D8EOaxr
    JLIX2qQwMjbWNM9NDCohM2qf1Y/DTmMSus6nTlU0WJdF2kHGQb+vpVJjNvq71mM4dvUk
    xkhTgPNqcNCVhobL2QLAB4OYkY7Cwtp+5/3EFvk7YUvDKMfJTG0TcAOuCFKrsdC8tyQe
    KOECX12FT9XcUQsUIohQFrruAVH9LaKTWXpfhxMv7TzyoFBUA7r+L3yIcHLwmFM3mYv+
    dqAQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795174142;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=dyfeK/GUPie55ziz2SjorD4OfwLrUe0NHuQHCGK1cTQ=;
    b=ISbaUp3XBL8vDPFYjvjBZumPEZ8f/QR64Ddb6zOY2j6/8akQs8XpK+Ngdll3s3X0do
    BTU3VLXWcMTze7B1pVyyzqfj1WPkCYjVvBBCzfGIvBT2HpZMkvW569FA9bmdVhFMJ/F4
    6ssfzxTlsNxHxsqtj0O2uH5clWs5IZeAd9MFN7Yd/vqM38p7VjF24o1sM/hvbPgUt/oQ
    K++prqQA5kaVI0m++8YZo/eqA9vsmFbMLaSJEGTa8zFzjnuoA562yCk/pO+NKMEKsg3e
    IWJ3x9vSkPECVyvwbXEmMF3UyaM81h6vZhqTgf7aa2wBVQbhO23RiExIzbzGkWT4FcCh
    PViw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795174142;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=dyfeK/GUPie55ziz2SjorD4OfwLrUe0NHuQHCGK1cTQ=;
    b=dGyO/b7wcaRdP+4Thphm67ZibKrbkCCM1b4Ggez3sq6r+J540RnZdMWPGzPGN3ooQc
    LNdKPO6XDniKRijA3TAw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AKBT1QM7
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 20 Nov 2026 12:29:01 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Fri, 20 Nov 2026 12:28:56 +0100
Subject: [PATCH v7 2/8] can: bcm: do not remove the procfs entry in
 bcm_notify()
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
Message-Id: <20261120-can-bcmlock-memcg-v7-2-f6b84f5257b1@hartkopp.net>
References: <20261120-can-bcmlock-memcg-v7-0-f6b84f5257b1@hartkopp.net>
In-Reply-To: <20261120-can-bcmlock-memcg-v7-0-f6b84f5257b1@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Zhu Ling <zhuling0805@qq.com>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795174141; l=5744;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=5ZVj9zJbo3hpX3s/iiPgBkIURgOaGpGZNd2t5brt1xk=;
 b=awrKP+gqwZywFQtkEMBWmapfUFv0cBVfnG9iy/Wy50GUUb2kZsoRqKaT4pw0EAQrog4cXWVeQ
 a8gZOE2FPrRBZMVDoAnrvn4TFdhmcwwwCrPKHpvze7pf8HGdg/68oZX
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=

bcm_notify() removes the procfs entry of a CAN_BCM socket that is bound
to a vanishing CAN device with remove_proc_entry() while holding RTNL.
remove_proc_entry() waits for all running readers of this entry. A
reader of /proc/net/can-bcm/<inode> that stalls in its copy to user
space, e.g. on a FUSE backed mapping, therefore blocks RTNL on the
unregistration or namespace change of the bound CAN device.

The entry has been removed in bcm_notify() so that a later
bcm_connect() of the unbound socket can register it again without a
"proc_dir_entry already registered" warning.

The CAN_BCM socket itself stays usable after a NETDEV_UNREGISTER:
bcm_notify() only unbinds it and reports ENODEV, so the application can
connect() the socket again, e.g. to a re-created CAN device. The name
of the procfs entry is the inode number of the socket, which does not
change until the socket is closed.

Keep the procfs entry until bcm_release() instead, which removes it
after the socket has left the notifier list and without holding RTNL.
bcm_connect() only creates the entry, if it does not exist yet.
bcm_proc_show() reports an unbound socket as "unbound" instead of
showing the cleared ifindex as "any".

As bcm_proc_show() can now run while the socket is bound or unbound, it
reads bo->ifindex locklessly with READ_ONCE() and the writers use
WRITE_ONCE(). The NETDEV_DOWN handling in bcm_notify(), which runs
without lock_sock(), reads bo->bound and bo->ifindex with READ_ONCE()
as well. bo->ifindex is still only modified under lock_sock(). A
concurrent bind or unbind may show an intermediate state in the procfs
output, which is acceptable for this debug information.

Fixes: 76fe372ccb81 ("can: bcm: Remove proc entry when dev is unregistered.")
Cc: stable@vger.kernel.org
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
Changes in v3:
- read bo->bound and bo->ifindex with READ_ONCE() for NETDEV_DOWN and
  shortened the bcm_notify() comment (Sashiko review)
- v2: https://lore.kernel.org/linux-can/20261108-can-bcmlock-memcg-v2-2-19fafdfc9d12@hartkopp.net/

Changes in v2:
- read bo->ifindex with READ_ONCE() in bcm_proc_show() and write it
  with WRITE_ONCE(), updated the bcm_notify() comment (Sashiko review)
- v1: https://lore.kernel.org/linux-can/20261107-can-bcmlock-memcg-v1-2-482d9f5be1fd@hartkopp.net/
---
 net/can/bcm.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index 3f4c8d828337..1595b7720c98 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -217,15 +217,20 @@ static int bcm_proc_show(struct seq_file *m, void *v)
 {
 	char ifname[IFNAMSIZ];
 	struct net *net = m->private;
 	struct sock *sk = (struct sock *)pde_data(m->file->f_inode);
 	struct bcm_sock *bo = bcm_sk(sk);
+	int ifindex = READ_ONCE(bo->ifindex);
 	struct bcm_op *op;
 
 	seq_printf(m, ">>> sock inode %s", bo->procname);
 	seq_printf(m, " / dropped %lu", bo->dropped_usr_msgs);
-	seq_printf(m, " / bound %s", bcm_proc_getifname(net, ifname, bo->ifindex));
+	if (READ_ONCE(bo->bound))
+		seq_printf(m, " / bound %s",
+			   bcm_proc_getifname(net, ifname, ifindex));
+	else
+		seq_puts(m, " / unbound");
 	seq_printf(m, " <<<\n");
 
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(op, &bo->rx_ops, list) {
@@ -1864,23 +1869,13 @@ static void bcm_notify(struct bcm_sock *bo, unsigned long msg,
 			if (op->ifindex == dev->ifindex)
 				hrtimer_cancel(&op->timer);
 
 		/* remove device reference, if this is our bound device */
 		if (bo->bound && bo->ifindex == dev->ifindex) {
-#if IS_ENABLED(CONFIG_PROC_FS)
-			if (sock_net(sk)->can.bcmproc_dir && bo->bcm_proc_read) {
-				remove_proc_entry(bo->procname, sock_net(sk)->can.bcmproc_dir);
-				bo->bcm_proc_read = NULL;
-			}
-#endif
-			/* Paired with the lockless fast-path check in
-			 * bcm_sendmsg(); bo->ifindex itself is only ever
-			 * accessed under lock_sock() so it needs no
-			 * annotation.
-			 */
+			/* pairs with the lockless check in bcm_sendmsg() */
 			WRITE_ONCE(bo->bound, 0);
-			bo->ifindex = 0;
+			WRITE_ONCE(bo->ifindex, 0);
 			notify_enodev = 1;
 		}
 
 		release_sock(sk);
 
@@ -1890,11 +1885,12 @@ static void bcm_notify(struct bcm_sock *bo, unsigned long msg,
 				sk_error_report(sk);
 		}
 		break;
 
 	case NETDEV_DOWN:
-		if (bo->bound && bo->ifindex == dev->ifindex) {
+		if (READ_ONCE(bo->bound) &&
+		    READ_ONCE(bo->ifindex) == dev->ifindex) {
 			sk->sk_err = ENETDOWN;
 			if (!sock_flag(sk, SOCK_DEAD))
 				sk_error_report(sk);
 		}
 	}
@@ -2011,11 +2007,11 @@ static int bcm_release(struct socket *sock)
 	}
 
 	/* remove device reference */
 	if (bo->bound) {
 		WRITE_ONCE(bo->bound, 0);
-		bo->ifindex = 0;
+		WRITE_ONCE(bo->ifindex, 0);
 	}
 
 	sock_orphan(sk);
 	sock->sk = NULL;
 
@@ -2058,20 +2054,21 @@ static int bcm_connect(struct socket *sock, struct sockaddr_unsized *uaddr, int
 			dev_put(dev);
 			ret = -ENODEV;
 			goto fail;
 		}
 
-		bo->ifindex = dev->ifindex;
+		WRITE_ONCE(bo->ifindex, dev->ifindex);
 		dev_put(dev);
 
 	} else {
 		/* no interface reference for ifindex = 0 ('any' CAN device) */
-		bo->ifindex = 0;
+		WRITE_ONCE(bo->ifindex, 0);
 	}
 
 #if IS_ENABLED(CONFIG_PROC_FS)
-	if (net->can.bcmproc_dir) {
+	/* create the procfs entry once, it is removed in bcm_release() */
+	if (net->can.bcmproc_dir && !bo->bcm_proc_read) {
 		/* use unique socket inode number as filename */
 		snprintf(bo->procname, sizeof(bo->procname),
 			 "%llu", sock_i_ino(sk));
 		bo->bcm_proc_read = proc_create_net_single(bo->procname, 0644,
 						     net->can.bcmproc_dir,

-- 
2.53.0

