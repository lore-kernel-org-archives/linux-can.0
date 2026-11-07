Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=85.215.255.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794056827;
	b=FuG+ex760V9cM1EX667hvaqx2/LdcjfClgfLJDLSreB18GD7fSrgbLijHOKgjIWL07fn
	 3d7BRnPvQmmcJylcd8T6mtHLzYcWhmKuSFFqMtJWT70lo5aiSLwCGgfpd/h0baEkJ/qr2
	 M5SBtGAfXwBI+z1aQIsPSFeWxd1rXrM058JIotQz4+D46y2TZuydTNhnmaYMHTtHQ+Z6f
	 fneOaH8LtBnPx18tdFCRMSTBgK9CVAPcAV3JzktSTU3dC79vLBK9fgQSv8K+9lH5mnXfs
	 isbuHTKv0Xyn73aCbeXCaxyoVCYoimDZMIOeicygaXjnqVniunyU1RWi9Ht0vmXn5XA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794056827;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=iDBjylgIUDl9bFZsKNgztjwZDso9Sb5PJsKvmprM+VY=;
	b=up2ZC1sOiPEPU7hpf8tALA5Ll8n1B2J/jR5wc2NRg3sBoLyQfoq0sHdzRz02p0cVFgK6
	 iCiTrrKcDGcmnEgQ9gXHfQae5q3uBnCEUlDS+G/zahk5xbOH7Wn0imAYbeRFfJsAXhKly
	 xLlmFDLX1DsFekA4japPDSQJb3pZpGQ7kTJPmgyqrkJgHaQYlLZPsZii35UiosWCTdUc2
	 C/YalfKHKdPrVoTZ4Vi1BcEXzJiLq6kF7iToOelEmMW9ZxnusrR+Jbh1QNRucHSKOOOYf
	 KipIh2XpSlK67GBqXAtBm+rTBz6ylX0+MH/mjgflrw5slMlX7DgGOSeuT5ZaIXGkZ9Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=T364omlT;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=mJr9MCFA;
	arc=fail smtp.remote-ip=85.215.255.51
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FB9606A32C
	for <linux-can@vger.kernel.org>; Sat,  7 Nov 2026 13:07:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4FB9606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=T364omlT;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=mJr9MCFA
ARC-Seal: i=1; a=rsa-sha256; t=1794056819; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Y1l4cSIEuRCFHwCGQd8Y/0xr3meLfK9KCoOUdruirraTXCcHudVpXrTJmuSQch2mG6
    1DGfBKKztVCFSfFURITrYc7lZWQRDBtWAS/rjMj7805dLU0fWAU7CPYZlMiHzvUoPpi6
    S9V45rfqnYEymZaR7sMV1trzIbwh2AqF0bpv2X/Gne8SASOgiLuw40Gj6lOq+OxjdFgv
    bXrmIHvDlfRudiHPwYc4A2Q3dEP4ffHdRBBMrruTHK4YEeSlm1oDfaJhTwBYzayPPREj
    LDuG8lzmAQ2AHpEH5/o+Qz2HWQ9knHZ/mIoKk+rbqJzO4xyw7LeuawWYiyabALqiLyB/
    Larw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794056819;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=iDBjylgIUDl9bFZsKNgztjwZDso9Sb5PJsKvmprM+VY=;
    b=ZFK39J2hPYID7RcC9zU7M5N1K+Z0662X6fYd1qFL6FxnOFifPFcNf02PSK406TiZDS
    3b0fz4O5k4HrmOfDq5llNwNHDbw9PX4LEbBzsVm7BVwGs6f2X4NAuSHcS72Rq2Na7gwN
    Y6jjdlYSDM3jTYQbfL84dYyOWcqFDOauPYWhpjApFwJ7zDKCVfqkmWVXZ534glky/PFD
    j5kEOFETtwxW15WzWcGzLg/4+XZMWIUek0jB0tOk2idVRwH+8IQa36TG7t8I6wmQbfcu
    CQTJQcZZJr4oEzo5v7pX0obUiFqk7EpK9CKA0Yu0uoT/MKk7fsvgW9IBKNyr07KsaRBP
    aAPg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794056819;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=iDBjylgIUDl9bFZsKNgztjwZDso9Sb5PJsKvmprM+VY=;
    b=T364omlTbGvlN3fvK5Bxg5sj04wyGq6T9AKIVEIp1XizX2iaY11CynseoHGq3tQU5e
    bO/m6HEh7jpkGq/hJle33+pAbXz5inH91bWikgfDp6ODT98Yw6vyRUXpk4ZLEcQB8E2k
    +iR7hsZeynkR1w1LXXBz+ejx5juiN/poYBefHbJjudd+QY82ZkVqVgj5u05ufymvuf6n
    EKRmnekKCJLgQk45PhNdB9xbCpKPUoBjri+jTlcqzWwRxW4plCZ+KjGn1dM1XfCBfiqQ
    E/Zy1urb2Iiqj8keeiTt8LUW+NMJELMoLWjS/cLzV3KXp6OxVNAFA355RY5Sp1z0/UJ4
    Wgzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794056819;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=iDBjylgIUDl9bFZsKNgztjwZDso9Sb5PJsKvmprM+VY=;
    b=mJr9MCFA+cf6jfO6Nn53Po43cN2cozaIbrORfGhHz/WXVCBhbXWg0BnOXn9rVUjsVD
    cGUmuyifpF+jhDTzFaBQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2A7D6xlPX
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 7 Nov 2026 14:06:59 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Sat, 07 Nov 2026 14:06:45 +0100
Subject: [PATCH 2/3] can: bcm: do not remove the procfs entry in
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
Message-Id: <20261107-can-bcmlock-memcg-v1-2-482d9f5be1fd@hartkopp.net>
References: <20261107-can-bcmlock-memcg-v1-0-482d9f5be1fd@hartkopp.net>
In-Reply-To: <20261107-can-bcmlock-memcg-v1-0-482d9f5be1fd@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794056818; l=3516;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=ralpx01ii5ZAylTnmJdCocP45EBlc13c8sOl/l1KBPU=;
 b=ZX9X06tTTSzK3I/+c+oz+8K/jgLpytCBHVmR1QJWBhUpWO+JkltL+p0J3H+T/5XYLEsFuIxVk
 QLBUl+77yBtDnMcfoSnIEBiA3RmO9qoV8w2ZJwNijV+ZgVj9zkeKnxw
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

Fixes: 76fe372ccb81 ("can: bcm: Remove proc entry when dev is unregistered.")
Cc: stable@vger.kernel.org
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/bcm.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index 9c39f7363ca5..0631293a8b54 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -221,11 +221,15 @@ static int bcm_proc_show(struct seq_file *m, void *v)
 	struct bcm_sock *bo = bcm_sk(sk);
 	struct bcm_op *op;
 
 	seq_printf(m, ">>> sock inode %s", bo->procname);
 	seq_printf(m, " / dropped %lu", bo->dropped_usr_msgs);
-	seq_printf(m, " / bound %s", bcm_proc_getifname(net, ifname, bo->ifindex));
+	if (READ_ONCE(bo->bound))
+		seq_printf(m, " / bound %s",
+			   bcm_proc_getifname(net, ifname, bo->ifindex));
+	else
+		seq_puts(m, " / unbound");
 	seq_printf(m, " <<<\n");
 
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(op, &bo->rx_ops, list) {
@@ -1864,16 +1868,10 @@ static void bcm_notify(struct bcm_sock *bo, unsigned long msg,
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
 			 * bcm_sendmsg(); bo->ifindex itself is only ever
 			 * accessed under lock_sock() so it needs no
 			 * annotation.
 			 */
@@ -2067,11 +2065,12 @@ static int bcm_connect(struct socket *sock, struct sockaddr_unsized *uaddr, int
 		/* no interface reference for ifindex = 0 ('any' CAN device) */
 		bo->ifindex = 0;
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

