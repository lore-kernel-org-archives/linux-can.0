Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=85.215.255.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794153953;
	b=lJZ/1YmiOHxQMZBnioONmO+BL/q1l4cDMIwt/N0O8RK9fH2L9ZNxCo4hTof0KxcINp9g
	 26SgEtGWTrTtKz1pFZB213v+UyW6YgvLAYpKGHdA+WkikvNP+rSu4dMTCngno+S11XqDp
	 HRZ6xxDZKLA2VPH1WVsa6T/2R4NJ3/TDleiXCmYMmt8bBo0jDkEaRqZKMyuBq0gEsfHue
	 r1uVGY5GN5rxLuHHwP8h0OTBk9UZ4TtEl5eNwvQerYv400ZEp3piCFo58RF3dNQjFStb8
	 FCsRrE5aXGaty5Mo6/io1k6RG2S1fDRxzihima5o7Jc6KrkLaSrNx8wsQQH6yUZGCPQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794153953;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=poMk2ZmP7s49fWkaMJ6sJq2BtA2x7ANx+g1lqqWdOcE=;
	b=tIRNH0SkZxwtiwstoSGwtlxnNYtngOA1LWFpOMfeeJ2Pn4c+SeykbOTSrZc5f6Tk3xUS
	 VAlr9hAxmN2CQLiWVXwnvP4lLh80svLi44Xf4hRTqJLnpvuEhZajV0rc/dxlpCxkdvo8K
	 XrPEiQVAhpf/WlpKHkxg6vj8HUTVB9DKikLc1x/O2wGlWLV9VuBVINqwbFH8VEFRSDG0K
	 orZGym/gNDoDGS7NOYfwPgnA3OT4sPwDjlN1C7Jm7EVVUh9oje147OTXNtr95mUEBjjuf
	 7a/gW2ACZNpK2cGclfQUMN0E49QBr4yXkBrT8bXaLAXQdDzWGjzpnD1rWY/I7oxYxqA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=f1icSTCw;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=9DdkTIwi;
	arc=fail smtp.remote-ip=85.215.255.54
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5BA606A326
	for <linux-can@vger.kernel.org>; Sun,  8 Nov 2026 16:05:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD5BA606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=f1icSTCw;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=9DdkTIwi
ARC-Seal: i=1; a=rsa-sha256; t=1794153944; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=H0J0hBOfxgtGcm76NiQzvYZ6l7TqblpKIyQp8X27MdIVx3dvLK5PtG1wrYD+c5qftn
    Sj4QmKgwcIP4qYbDyEd8QMYvqaRoWJ56wLK5UnUHwFvxtthvAiYrlwkHAIize1AkBG6+
    ghWEj8ot430Pei+QwrdcQcibbpHQ6Llj5PW4a0YAhc6yKdfcvvC/7sTu/h/TjRdqhQFo
    7UVyaiAbL04J03xlwjZ3BkCugKpaOYUPlR3QT5akvQhsw+u5f/gVqljNhnLX7kkq6Y58
    qulIPdqsXlugBft/4KK//BDiZDu8AdIJ+D1JaZmOng6TAp6Hh0e4G7eeKwY5Ge3V5yc/
    oZkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794153944;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=poMk2ZmP7s49fWkaMJ6sJq2BtA2x7ANx+g1lqqWdOcE=;
    b=rf6TbSuP8gncxcgPH4+hEGHy3JCK78kn9uStvng4QUfxyAnkj02HYjqdQxOjxvnsXh
    rgjLdjdbCcbLTBvtps6aZHo7EaAovdSNAMAKpzn2PwKW3ntaaeQ7YbayK+cBBBr0DJIm
    mRgX9dsHirLyDdzUw2NNnerephFcgndTkQqcZTwiZ0+AkO7uCCC0Dkq8F9WMNgqG0giS
    ET3gVy3Rn8EoRXk19ltVv0SWCmdLORcxFNkusVIegOY7Xxwl7KsONGjp9zgaVtLDpGyG
    YBvlrhANV3R/v2eylKX9svT2ELjlRM9VA2VtEMn4KknibiACvaAtP8AGnCXUiAF2yPca
    fTnQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794153944;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=poMk2ZmP7s49fWkaMJ6sJq2BtA2x7ANx+g1lqqWdOcE=;
    b=f1icSTCwH1AyI81IiWJnfRX9xxL5aCpaGLFuEIP0wSHT5Uqlzk+ERdfc6AejKH8W+u
    VkIXFHet26jhDxkHr+Kt1rENKijcWWqaqnzZBWApn9otHiuGHY93yqaS5uAmaV3IEJSH
    ZtCJ2MHvMkKr165nP89hAJREBgNxvxFXtky6T8+bA44o4SWQTduogHlAIYcCUVEM3SlN
    4Z81EbZcjP1GKvw9U/la+DJD8d+T7RbpPFniZFs7OXr5EUDD3OLyN7Gdahs/f0TWQ8Hb
    2iyZmRooMPeZTt8exw6xmLQsKZGg11EfJVSIo67nuYNl4FG/v1QAzMo3uQ3OLuKIZlr6
    mOYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794153944;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=poMk2ZmP7s49fWkaMJ6sJq2BtA2x7ANx+g1lqqWdOcE=;
    b=9DdkTIwitO1rkGS5HS0kV/sG8QX2HuaGeo930+LKXb/QgFjssnUkencWCqVM/IMyP5
    p2NMRGOew7oXmc8RzjAw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2A8G5hoVx
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 8 Nov 2026 17:05:43 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Sun, 08 Nov 2026 17:05:39 +0100
Subject: [PATCH v2 2/3] can: bcm: do not remove the procfs entry in
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
Message-Id: <20261108-can-bcmlock-memcg-v2-2-19fafdfc9d12@hartkopp.net>
References: <20261108-can-bcmlock-memcg-v2-0-19fafdfc9d12@hartkopp.net>
In-Reply-To: <20261108-can-bcmlock-memcg-v2-0-19fafdfc9d12@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794153943; l=5030;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=ZdLAh1x6IZaNyTojCjhoEE9f2qzXW6P5VjhzHFZqj4o=;
 b=NLLy1vTuF5cENG2g7Re6TW5XlQrh1CUFeZ09qrShxHP8palP1C9kVQw9QkAAahawiz0ZO7GAd
 9sBCaAM8tY4DnlRfGuv3Dp6at/7Dx8aIhgA5bLxry5gko7Ltp86BdJ/
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
WRITE_ONCE(). bo->ifindex is still only modified under lock_sock(). A
concurrent bind or unbind may show an intermediate state in the procfs
output, which is acceptable for this debug information.

Fixes: 76fe372ccb81 ("can: bcm: Remove proc entry when dev is unregistered.")
Cc: stable@vger.kernel.org
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
Changes in v2:
- read bo->ifindex with READ_ONCE() in bcm_proc_show() and write it
  with WRITE_ONCE(), updated the bcm_notify() comment (Sashiko review)
- v1: https://lore.kernel.org/linux-can/20261107-can-bcmlock-memcg-v1-2-482d9f5be1fd@hartkopp.net/
---
 net/can/bcm.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index 3f4c8d828337..0a6b8998582f 100644
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
@@ -1864,23 +1869,16 @@ static void bcm_notify(struct bcm_sock *bo, unsigned long msg,
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
 			/* Paired with the lockless fast-path check in
-			 * bcm_sendmsg(); bo->ifindex itself is only ever
-			 * accessed under lock_sock() so it needs no
-			 * annotation.
+			 * bcm_sendmsg(). bo->ifindex is only mutated under
+			 * lock_sock(), but read locklessly in bcm_proc_show().
 			 */
 			WRITE_ONCE(bo->bound, 0);
-			bo->ifindex = 0;
+			WRITE_ONCE(bo->ifindex, 0);
 			notify_enodev = 1;
 		}
 
 		release_sock(sk);
 
@@ -2011,11 +2009,11 @@ static int bcm_release(struct socket *sock)
 	}
 
 	/* remove device reference */
 	if (bo->bound) {
 		WRITE_ONCE(bo->bound, 0);
-		bo->ifindex = 0;
+		WRITE_ONCE(bo->ifindex, 0);
 	}
 
 	sock_orphan(sk);
 	sock->sk = NULL;
 
@@ -2058,20 +2056,21 @@ static int bcm_connect(struct socket *sock, struct sockaddr_unsized *uaddr, int
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

