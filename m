Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.166
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794565998;
	b=03tqc7KefUBGsvLb9KExH64Gj64GyWph71CmCFKF/J/cymtX77KqRAXO6rZ56RvUPfVk
	 mDiirBFGHeLbchNQQ0veLrtQ5T2t8g04LGortrqDbeAdbJslTeXIblAyWU3Rvc8BIObND
	 P+Sn5UWwRDJU08pnUgae4V/wDFPvE0MGg24PLagkYm9yXWaNezsbxlEvMVtfnAmgTmWWX
	 DQVOBu9WN6hQatGj1QESsX3mBsgAn9l093JxaiNXQBQsFpkgxzuZHB8O1Yu9W5HHD2X/G
	 ugKO9R4WocpNpYP2yq3U0uvxy5zA2/MJCTDE2PbFAJM77K5GPNtYfkcs4QccmrvaAhw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794565998;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=dyfeK/GUPie55ziz2SjorD4OfwLrUe0NHuQHCGK1cTQ=;
	b=VvPu3xI3pzCvfLRDLV8rIy/PvPIaBxyvTZx4hDVvdp7K9WX31tSts0QjpdNEWPATRRHC
	 YT3QOEPrIHY6aeLSS1NzfnnVHRpLo6NmPQDIBjAJp2sJrEd5N4JZeefCxGt/bNOfLtVKp
	 yaR6hQ3nvXtQaYlUcG8QrDONGwCsJJawMdRptgoe2Eqzzgm0mH2LBR8NdFRIfmHLBVfif
	 WwOpBjF1DIEk76/BVDz0TISmSIGzWWAsSEA8cMYchMyUSppMFM+OFQGWJGcQnw7TbNJ34
	 cZKIaiUqu8zeyGmwLUAr8oWbD9sBtQAqwLaVdb9Fqn3h2KOEEEQ362FKWRh29rmH48Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=CDCeMV5z;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=OKXWgRjR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.166
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98977606A321
	for <linux-can@vger.kernel.org>; Fri, 13 Nov 2026 10:33:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98977606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=CDCeMV5z;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=OKXWgRjR
ARC-Seal: i=1; a=rsa-sha256; t=1794565995; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=h7XBAY5GU+xHIH/v/3Vc+mGV0dKxJwUSlAfiFNOI5oV3Y3grRABdsWBbiCVl2QUwP2
    7/er+eeY63jtKPnWiQV2cPCC7ek5NWFRdqu1GN5kim0gGwKF8Kl05lDmP/Os06M12rZD
    Bo4rNRCo9gRy2wQstBSZpDgHljIJIrm/ABx/11wOKcH+ee9dzAiY4Ga8mhEyRbfVU5mi
    DUFkfz1Vam2FBfhBkKpYb7HaAXroKPyao2VjcdNlMBM9ofFfFC8Dgmw3CwEu3iZ2onVM
    5n0qR9yRFYRGle1OyL9vfVa72HyqY3E6mj+3cVu9m1XNgPyYFiVtmEy1ySOQQuX0YBWI
    klvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794565995;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=dyfeK/GUPie55ziz2SjorD4OfwLrUe0NHuQHCGK1cTQ=;
    b=MsQqBOTE+CNzXFIxlASugrFJiqmzeZ9m38NlH+Bzv/KUVXDBdezBilhC9zjstWYLVp
    ZySxyyvnR/KVfDbgkJzeeDb5bEnaGgkVRffpAcudzPyKJBFUWWe9gUcMxyhNLe3/Oojg
    EjF5Z4koLT+yiQ+jCwASJRDmCVhmZQXLlbtqTIIPhdnpzgPEIgdjerIm6Cyr6HXPq6OA
    MdBW9Uf7e9fFE8WBtxsrjq6qVUNzkI5snNNt6gvh8M7KVG3BAIdcAa2yCwfaty6f9dAy
    nGL1Knr1vgP8Kw7X3DS1CRcAbhup13dugwEvC7OlOyzSBk7HWE8suiU9WI3KtGHGN1IV
    w2rA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794565995;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=dyfeK/GUPie55ziz2SjorD4OfwLrUe0NHuQHCGK1cTQ=;
    b=CDCeMV5zSMiSred4ijKkmo6UtbzQT3HsgRrRxZry64+nszzAwS0hQSf6rYiMncBOj0
    zJ5jW/VlOgH951YXahwgMjP9eaAC5VuPG7YpCWpAq/a8N2rPGgiIVeBmiyGsxcbzXCiL
    iN/gQTfs1C3/z12ibJ6eFzNCbJll30apOyqFwA0l8vBRuFxac8F7il9V+6LPdK+VZ94y
    37EWMcyqqxsGvZ7dcrd7+2FM/CY74clL3hWjuA5CB6Rohq4K6uFvx7hLAqmQtqWfYZry
    efgiX/HPq+8zEHcIF2f0g2aB9Fx7+BX0y0d7v89hSzobOPZUXPO5QREr3gpjhtwj1IpT
    cRlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794565995;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=dyfeK/GUPie55ziz2SjorD4OfwLrUe0NHuQHCGK1cTQ=;
    b=OKXWgRjR6gCyAXwm1Jk8NLOq8F0C+aC2yRNeL6INv9LlqYcuyB3laanLMiHtXOLPjp
    yUXejbxAMJCxzUs/y3Cw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2ADAXFIs7
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 13 Nov 2026 11:33:15 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Fri, 13 Nov 2026 11:33:09 +0100
Subject: [PATCH v5 2/5] can: bcm: do not remove the procfs entry in
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
Message-Id: <20261113-can-bcmlock-memcg-v5-2-634c0e04bc72@hartkopp.net>
References: <20261113-can-bcmlock-memcg-v5-0-634c0e04bc72@hartkopp.net>
In-Reply-To: <20261113-can-bcmlock-memcg-v5-0-634c0e04bc72@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794565994; l=5744;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=5ZVj9zJbo3hpX3s/iiPgBkIURgOaGpGZNd2t5brt1xk=;
 b=jN6QddqHfffm8+FwPIJZASSdsDV11M+G8b1fZncTQ/5Ie7xhSpEHEJNBXPU+VqrTXdbONj1wB
 YxVb6WW0JOADR/xkzSkpv8DKNTXVhh28/NUrIJSAR4nXQim3hAUwYhE
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

