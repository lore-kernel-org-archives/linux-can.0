Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794933358;
	b=fNzXZEC3FvYUF4R+xqAR/MQ9Q/V4vnH1aEb8sq6l8E3BWrabnJdYWgNV1xcjjvJgE63k
	 mea+vlhTYajx/Iks0ay1MyQXaig6ni82QrnO8eWzgrojttB5Q8DpiAlPMaI1Txx5/joQ7
	 dcSTgKA7o0Enej5drnqC1yj/I/9WqX366TreJc60ot1XtBT/0whBBZ03dXf0wsdz+sm4C
	 oQLsEC7sVwGfvhl22/pJM4PJtdifiZ+hf5oiEMaC/kopkZjLtzqlw3rJmBLYvegJWHmrI
	 j6dXSFkGkFMm1lgIj98YHJ+x8NDEVcnTW4C3zBFCihY7cLEWIozvZ5BvSD2R9740Ccg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794933358;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=dyfeK/GUPie55ziz2SjorD4OfwLrUe0NHuQHCGK1cTQ=;
	b=etsnQkfXdlyLMY47+T8+fcZauuNPZq0Hoi54kg0FymaxAxk5jc+YHNPQ6fl14KLVQJYY
	 44aDvL93860l5Acuw2FQxQBujJ3Oi+nNtQMPXUEP+dGdzM8NMEzi8xF9NXdlFT68eDogR
	 hECJR/Z632RuRrJO2d2rmNLcd08C/9YhE6UyFHYNcG1zsouyesoyDh0yIbYk7TSaG0jCa
	 VQVJFQLKYBOc85//crVzU2GHnG0MNT7jN2IHj0Qi/K6yGLytve6jlNwLBZNhcSEbvtTcV
	 OxBkLBBMnpvJNMBSwBR4Zf/VMrr/D0uJp21kHPxmBguWAn7SpwiY0dZdXkwQBoHTCEA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b="YqkGY4/M";
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=ZwV6UiBP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.53
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E82606A31C
	for <linux-can@vger.kernel.org>; Tue, 17 Nov 2026 16:35:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83E82606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=YqkGY4/M;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=ZwV6UiBP
ARC-Seal: i=1; a=rsa-sha256; t=1794933347; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=gbMvs8ZimtApmpdyC3Jj07dCIn5g8jdi5JHx9zyyd6wHbeB3xxQwHqO23mA043Mvrl
    asFJE9ClEaOstT2RNZF+BiK1Q4gL14PI67rGrf8GetkikAR57rHZHcjwyrkzYV0CjnzH
    o9l2uwGkOYWuAUmCuPOOYlmZj6yUglbSmsgcGAJle1OqSb7AWKVpIMUJ78R1pdMQXG5+
    BEs3X/xNRhNDX34ax9SyjuNgnrNMv1Mk24VfJD/auzuOO93MSPZCEWg/Kh94/5xijOB1
    S5KAVUX6SAyneQFBfh9wmQorrIpxOrZbzQxhfhH9Hupbo8Om3E2Je3O+UAl8KoPDo+ho
    PVFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794933347;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=dyfeK/GUPie55ziz2SjorD4OfwLrUe0NHuQHCGK1cTQ=;
    b=JIl+MtERpqPBTt+Tcx7TegGH3F7vqDzoLby0XrLlJQlIQUXuO8Zo9DNoa1kzUBhVqf
    01DGSYcHfXlgBPh40jKkuG2Zvol17I4/dO7NeqfitgH65n/9pSHQp9fUf6Avp/IAPVLM
    5upcS56Pw+oCwDqD3sH9cvxs58rgdkhtXoDc9lrAyzz53+0py75rp6j0AQdc9WlgEC9A
    cErXePJKz2Lod9Xrr7CNbtJthav+RPt4dLFLXC/8oG++RBrztQ6b2JxvHRTFcob2FutY
    ZLmXDjHd3l1OecF4+qrIoJZhI3FRB8Uiw2eeFXpLtAMOnNKwOrj7iX/RfhmfccL77rHB
    sf7w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794933347;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=dyfeK/GUPie55ziz2SjorD4OfwLrUe0NHuQHCGK1cTQ=;
    b=YqkGY4/M7A5pxIk+5KGNcUg1NUDcSS1Yyr3w+QwssAUMklG5FE+g06cYZoxfaWVUbs
    4xBvAwHnOj501bg/rbVtwsjdLKBu6rxSvusuFqleDQJmg/ifnhJMJkxxmpoWaZFLwd8n
    406wfFWbPhjY+AS+S8zaey3kY/V8YN0VO3LXh7VRQCe9BmW2TJigJcJrfU1Zh6KM5aoP
    ALD08F1Ij3nLyYLdA3sIa/It/MNq/O/5rhj6Uhk4sLEkHNtf2CKQmg1kGviGjRlZD98u
    +h2kfWEAyKVCOiiiXnQYdZyao46dCtDS2Y0nHCnYkTEAqyBmaj/DY9DBkJGQsqCcfEBa
    zTLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794933347;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=dyfeK/GUPie55ziz2SjorD4OfwLrUe0NHuQHCGK1cTQ=;
    b=ZwV6UiBPRO1M4wLK3J06RYvRyggNc05iVwu/IMKDZI1FgVwkPioUMQ7bsE7LmYpoDh
    SnWTkWRwvxXYFbkVkhBQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AHGZlceT
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 17 Nov 2026 17:35:47 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Tue, 17 Nov 2026 17:35:43 +0100
Subject: [PATCH v6 2/8] can: bcm: do not remove the procfs entry in
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
Message-Id: <20261117-can-bcmlock-memcg-v6-2-6826a6227d36@hartkopp.net>
References: <20261117-can-bcmlock-memcg-v6-0-6826a6227d36@hartkopp.net>
In-Reply-To: <20261117-can-bcmlock-memcg-v6-0-6826a6227d36@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Zhu Ling <zhuling0805@qq.com>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794933347; l=5744;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=5ZVj9zJbo3hpX3s/iiPgBkIURgOaGpGZNd2t5brt1xk=;
 b=dPGNwcYoT7hHpIUzeOaUSHTl2zI3cVsiYR8qnjIkKTxNbXKEg252b0w8K/x+7vcLYHvngY7mc
 EUj8Ey64Nn6CIczMq8xbYe7pMBUcRXXJvxYbVaRWz+8WpbOHdKf/8gN
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

