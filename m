Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794258258;
	b=tk022I0e7fhQE+N4AtNtRxOQ9x/DtHjo3QmFsnnk2YSh4R7G1V5idw2AU8XmZ1Ky3sim
	 mQnOe6VrNZlyp88Mwew4FMPRLDpWkG8d9ATB+1Wr2adIncYlW/63QhPB1EwIeDflw/SdD
	 0250wDlJSjUZsQOwCxwP3HmZ34nQGmwcLPo6dZTqri6WqruvJmxyKlYq+4mfo6x9sO1jH
	 XeMN+ZaQrLQYeJQwjfYUtQ7ABKbS54UDAV3HesgQCG40qIrB9NNQYDfp4bBaOHfDARcyK
	 bocQY1rbyIlN57fC6XU8hx6bkI5G3BU95YrhIxxMq2yA8fWV9+CyPGA30UJ/LrTjnbQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794258258;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=VnLp+7CV7onYKZAZJ0AKvfyhy42pEO8IZ6x0/wamn14=;
	b=nb5dSju/nQ0ZDBPR6kz1iVn4rmGaXbvCmPMvlbJPrMasoSIJPli1kc1yLE1Y0n5emLKA
	 stizM00C0A0tLyZWKc/iRakyRx7/ncIYhlHFkPxw0BayxeVPq+zQ0W3cGre7UV3Cs/Hya
	 rjnJFsc+1kNo4o2aYl6l2oGUEZcY1s4jYOz3l6iedanW5geidATJ2YqJgxOrE0HH93Oqk
	 uJaOS5nLoW615YunbSqIfWoH3t0XnVyZ8kdOj//pWTa1ZjekvLXMlsyvJEL/s5WsxKWh5
	 T3KTXladV95ww3Nd1wS6hJTNQIimviHrn1qCwazGCLuQem8rrQbndE6cmzEm/snIWLg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=IEaiyYDJ;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b="y0sg+/Tl";
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.50
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4868606A321
	for <linux-can@vger.kernel.org>; Mon,  9 Nov 2026 21:04:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4868606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=IEaiyYDJ;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=y0sg+/Tl
ARC-Seal: i=1; a=rsa-sha256; t=1794258240; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=J+/0650UXpxRq7S/FBcHUsrVz1hGKrhSg37ENF77y+zF6lO8oyhTcnDQpQE++IB0PV
    f/C8vkFuU0kZlMlKmlr71ljIx48Pt5wUrNsi7WIEqaZLdDeNDLFc/DOFGyx4uPIiFRqL
    Yxwn4v412K3BjlcZ7rx5YenUCNtE9aimUAMvFaiCNMHWPn1Ytu6To6biG3mA2nopjKx9
    nCyY2XRDZSIo1gndEpRlOrLhy5e19TkrGskdgHQd8Y0lfua4ZPzJ51NweW4rTGz05uvC
    dcEec86KOP5noBm2gFuaNDpXLtUbowpjwVk4mdOONj2ndcYt24MwJsjvjQSzv67XryIx
    t1Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794258240;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=VnLp+7CV7onYKZAZJ0AKvfyhy42pEO8IZ6x0/wamn14=;
    b=Mn8tGrT58dhJdCTYu4lt+LChJczl7G48JMnN7XHuTZPTAOvnbzuTBqazRMB2aZ99kK
    VsYyIBb4eVxwjRY8QgHzfBgxCVLcyaoEayKadK4EsNnp+sPl99uez5Qvcm5UmH1UrTnY
    VeGeTMvSChqs7tgtqH+zBTv4viDmHKR3U2srW8+eE/tQax2vknxWxEzM0CxFhYKrGtNF
    Mvy4vq2ngy1TOFE2N3FXQeBVyYHqUNM7ZSNfwypFCscZn+35KUsYQqil5TSOsQstZEGO
    r0/qOCMkqdNpjiK4TUfgnGHsnuHhmvKQ369flxSeahfHjZhCE/Y7tzV8CFfHZemiYS/L
    4wsg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794258240;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=VnLp+7CV7onYKZAZJ0AKvfyhy42pEO8IZ6x0/wamn14=;
    b=IEaiyYDJUdFf0Sz9HMIyDVDAXD0v1HQwjf0a9kicNxVJ4rTULD8hv0a+8TgfW/VGxG
    nrfquue3Yx4o4myu3NvUKhj1vBEi0WTdNeqQTtBDI6sa8n860fklCaTS/FzVQRJpTBhg
    fvcHP+USIH0URfFnn2YBzMEQOEzz2U3ThZEXfkmOmVLvXee1g/UZZ1qG/ClL92bi228b
    xbFbRqjfjUFdxW8zqkH/VJzvyozuE7XvxiSVn87gjY0cu/wI7cfvmqYI//VT4ZP41GD+
    66Ao6sXbN2+uC08yNvda5E3lhkaTgqZKdB54t8hw5FNkUh2XcV/aHeVAtvMhsyEOA+cZ
    j03w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794258240;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=VnLp+7CV7onYKZAZJ0AKvfyhy42pEO8IZ6x0/wamn14=;
    b=y0sg+/TlTpFWICnYX/41oeXPA+BEk2SUe+dBVQHw8u0bIcCymqGRiK50sZ6EwK0tFz
    uEmmLh4xIYG7uxa0HDCw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2A9L40w3E
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 9 Nov 2026 22:04:00 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Mon, 09 Nov 2026 22:03:56 +0100
Subject: [PATCH v3 3/3] can: enable memcg accounting for user triggered
 allocations
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
Message-Id: <20261109-can-bcmlock-memcg-v3-3-2d798ca30578@hartkopp.net>
References: <20261109-can-bcmlock-memcg-v3-0-2d798ca30578@hartkopp.net>
In-Reply-To: <20261109-can-bcmlock-memcg-v3-0-2d798ca30578@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, Sashiko <sashiko-bot@kernel.org>, 
 Zihan Xi <zihanx@nebusec.ai>, Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794258240; l=11529;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=Ut4IkDZnMCpC9ExHrY2hDHArbsbvpxI3KIPR23FAevE=;
 b=k4shRQ2hZgNjbzm36KuPvjhbOxPmujkptxWh78cLQmIyZjvPG1zSamvARkfbOIdMNZs7l6Wmk
 a9atps/2KJuBjmhn+dO6NxJtVbDt4xl9RqndeImWFrtTvj4PcHNkzvk
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=

Unprivileged users can create CAN sockets and trigger allocations that
stay in the kernel for the lifetime of the socket or of the related
objects. E.g. each CAN_BCM RX_SETUP for a new CAN ID creates a bcm_op
with optional frame arrays of up to 257 CAN FD frames and a CAN
receiver, without requiring a CAN device (ifindex 0) and without a
limit for the number of ops per socket.

None of these allocations are accounted to the memory cgroup of the
process that triggers them. So a process can bypass the memory limit
of its cgroup, e.g. of a container or a systemd service, and exhaust
the memory of the whole system. The OOM killer can not attribute this
kernel memory to the responsible process either, which has nearly no
RSS, and terminates unrelated processes instead.

Enable memcg accounting for these allocations, as it has been done for
other objects that can be created by unprivileged users. This does not
introduce any new CAN specific limit and does not make assumptions
about the number of sockets, filters or BCM operations an application
needs. The CAN related kernel memory is just charged to the cgroup of
the allocating process, so that the memory limits which are already
configured for this cgroup apply to it as well. Without a configured
limit the behaviour is unchanged.

A per socket limit for the number or the memory of the BCM operations,
as suggested in the reports, does not bound the memory consumption, as
a process can open many sockets and fork. Hard-coded limits can also
break existing applications, e.g. one that monitors all 2048 SFF CAN
IDs with individual RX operations, without a possibility to adjust
them.

The following allocations are accounted:

- af_can: the CAN socket structures (e.g. struct isotp_sock contains
  two DEFAULT_MAX_PDU_SIZE buffers), the CAN receivers of all CAN
  protocols and the per-netns receive lists and statistics
- bcm: the bcm_op structures and their frames/last_frames arrays
- raw: the per-cpu uniq data and the CAN_RAW_FILTER filters
- isotp: the TX buffer for PDUs > DEFAULT_MAX_PDU_SIZE
- j1939: the SO_J1939_FILTER filters and the per device j1939_priv,
  which is created by the first bind() to a CAN device

The CAN socket structures are allocated with GFP_KERNEL_ACCOUNT in
sk_alloc() instead of creating dedicated slab caches with
proto_register(), as the CAN protocols copy socket options directly
from their socket structures to user space, which would require
usercopy whitelists for these caches.

memdup_sockptr() does not support memcg accounting, so the filters are
allocated with the GFP_USER | __GFP_NOWARN flags of memdup_sockptr()
plus __GFP_ACCOUNT and copied explicitly.

The isotp RX buffer and the j1939 RX sessions are allocated in softirq
context and can not be attributed to a process. The j1939 TX sessions
only exist for the duration of a transfer and the can-gw jobs require
CAP_NET_ADMIN in the initial user namespace, so they are not changed.
The local j1939 ECUs created by bind() are allocated with BH disabled
and their number is limited by the number of bound j1939 sockets,
which are accounted. Temporary buffers that are freed before the
syscall returns are not accounted either.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260707-bcm_fixes-v5-0-c3c74f8d8ff7@hartkopp.net
Reported-by: Zihan Xi <zihanx@nebusec.ai>
Closes: https://lore.kernel.org/linux-can/cover.1793089479.git.zihanx@nebusec.ai/
Link: https://lore.kernel.org/linux-can/350df96b-5f69-490e-b39e-ed6e9bca4754@hartkopp.net/
Cc: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
Changes in v2:
- allocate the CAN_RAW_FILTER and SO_J1939_FILTER filters with
  GFP_USER | __GFP_NOWARN | __GFP_ACCOUNT, like memdup_sockptr() plus
  accounting (Sashiko review)
- commit message: describe why the local j1939 ECUs are not accounted
  (Sashiko review)
- v1: https://lore.kernel.org/linux-can/20261107-can-bcmlock-memcg-v1-3-482d9f5be1fd@hartkopp.net/
---
 net/can/af_can.c       | 12 +++++++-----
 net/can/bcm.c          | 10 +++++-----
 net/can/isotp.c        |  2 +-
 net/can/j1939/main.c   |  2 +-
 net/can/j1939/socket.c | 12 +++++++++---
 net/can/raw.c          | 14 ++++++++++----
 6 files changed, 33 insertions(+), 19 deletions(-)

diff --git a/net/can/af_can.c b/net/can/af_can.c
index 0f3051a61aab..6f958c2bb49d 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -153,11 +153,11 @@ static int can_create(struct net *net, struct socket *sock, int protocol,
 		goto errout;
 	}
 
 	sock->ops = cp->ops;
 
-	sk = sk_alloc(net, PF_CAN, GFP_KERNEL, cp->prot, kern);
+	sk = sk_alloc(net, PF_CAN, GFP_KERNEL_ACCOUNT, cp->prot, kern);
 	if (!sk) {
 		err = -ENOMEM;
 		goto errout;
 	}
 
@@ -828,18 +828,20 @@ void can_proto_unregister(const struct can_proto *cp)
 EXPORT_SYMBOL(can_proto_unregister);
 
 static int can_pernet_init(struct net *net)
 {
 	spin_lock_init(&net->can.rcvlists_lock);
-	net->can.rx_alldev_list = kzalloc_obj(*net->can.rx_alldev_list);
+	net->can.rx_alldev_list = kzalloc_obj(*net->can.rx_alldev_list,
+					      GFP_KERNEL_ACCOUNT);
 	if (!net->can.rx_alldev_list)
 		goto out;
 	spin_lock_init(&net->can.rx_alldev_list->lock);
-	net->can.pkg_stats = kzalloc_obj(*net->can.pkg_stats);
+	net->can.pkg_stats = kzalloc_obj(*net->can.pkg_stats, GFP_KERNEL_ACCOUNT);
 	if (!net->can.pkg_stats)
 		goto out_free_rx_alldev_list;
-	net->can.rcv_lists_stats = kzalloc_obj(*net->can.rcv_lists_stats);
+	net->can.rcv_lists_stats = kzalloc_obj(*net->can.rcv_lists_stats,
+					       GFP_KERNEL_ACCOUNT);
 	if (!net->can.rcv_lists_stats)
 		goto out_free_pkg_stats;
 
 	if (IS_ENABLED(CONFIG_PROC_FS)) {
 		/* the statistics are updated every second (timer triggered) */
@@ -917,11 +919,11 @@ static __init int can_init(void)
 		     offsetof(struct canfd_frame, data));
 
 	pr_info("can: controller area network core\n");
 
 	rcv_cache = kmem_cache_create("can_receiver", sizeof(struct receiver),
-				      0, 0, NULL);
+				      0, SLAB_ACCOUNT, NULL);
 	if (!rcv_cache)
 		return -ENOMEM;
 
 	err = register_pernet_subsys(&can_pernet_ops);
 	if (err)
diff --git a/net/can/bcm.c b/net/can/bcm.c
index 1595b7720c98..d4ac2147b9f4 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -1158,11 +1158,11 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 		kfree(new_frames);
 
 	} else {
 		/* insert new BCM operation for the given can_id */
 
-		op = kzalloc(OPSIZ, GFP_KERNEL);
+		op = kzalloc(OPSIZ, GFP_KERNEL_ACCOUNT);
 		if (!op)
 			return -ENOMEM;
 
 		spin_lock_init(&op->bcm_tx_lock);
 		op->can_id = msg_head->can_id;
@@ -1175,11 +1175,11 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 
 		/* create array for CAN frames and copy the data */
 		if (msg_head->nframes > 1) {
 			op->frames = kmalloc_array(msg_head->nframes,
 						   op->cfsiz,
-						   GFP_KERNEL);
+						   GFP_KERNEL_ACCOUNT);
 			if (!op->frames) {
 				kfree(op);
 				return -ENOMEM;
 			}
 		} else
@@ -1406,11 +1406,11 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 		 */
 		do_rx_register = (ifindex && !op->rx_reg_dev) ? 1 : 0;
 
 	} else {
 		/* insert new BCM operation for the given can_id */
-		op = kzalloc(OPSIZ, GFP_KERNEL);
+		op = kzalloc(OPSIZ, GFP_KERNEL_ACCOUNT);
 		if (!op)
 			return -ENOMEM;
 
 		spin_lock_init(&op->bcm_tx_lock);
 		spin_lock_init(&op->bcm_rx_update_lock);
@@ -1421,20 +1421,20 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 
 		if (msg_head->nframes > 1) {
 			/* create array for CAN frames and copy the data */
 			op->frames = kmalloc_array(msg_head->nframes,
 						   op->cfsiz,
-						   GFP_KERNEL);
+						   GFP_KERNEL_ACCOUNT);
 			if (!op->frames) {
 				kfree(op);
 				return -ENOMEM;
 			}
 
 			/* create and init array for received CAN frames */
 			op->last_frames = kcalloc(msg_head->nframes,
 						  op->cfsiz,
-						  GFP_KERNEL);
+						  GFP_KERNEL_ACCOUNT);
 			if (!op->last_frames) {
 				kfree(op->frames);
 				kfree(op);
 				return -ENOMEM;
 			}
diff --git a/net/can/isotp.c b/net/can/isotp.c
index 7a90ba3f1cf1..34cccb480141 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1182,11 +1182,11 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 		goto err_out_drop;
 	}
 
 	/* PDU size > default => try max_pdu_size */
 	if (size > so->tx.buflen && so->tx.buflen < max_pdu_size) {
-		u8 *newbuf = kmalloc(max_pdu_size, GFP_KERNEL);
+		u8 *newbuf = kmalloc(max_pdu_size, GFP_KERNEL_ACCOUNT);
 
 		if (newbuf) {
 			so->tx.buf = newbuf;
 			so->tx.buflen = max_pdu_size;
 		}
diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
index d9384cf0e356..77adb817b36c 100644
--- a/net/can/j1939/main.c
+++ b/net/can/j1939/main.c
@@ -126,11 +126,11 @@ static DEFINE_MUTEX(j1939_netdev_lock);
 
 static struct j1939_priv *j1939_priv_create(struct net_device *ndev)
 {
 	struct j1939_priv *priv;
 
-	priv = kzalloc_obj(*priv);
+	priv = kzalloc_obj(*priv, GFP_KERNEL_ACCOUNT);
 	if (!priv)
 		return NULL;
 
 	rwlock_init(&priv->lock);
 	INIT_LIST_HEAD(&priv->ecus);
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 50a598ef5fd4..85b7e8847c06 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -714,13 +714,19 @@ static int j1939_sk_setsockopt(struct socket *sock, int level, int optname,
 			if (optlen > J1939_FILTER_MAX *
 			    sizeof(struct j1939_filter))
 				return -EINVAL;
 
 			count = optlen / sizeof(*filters);
-			filters = memdup_sockptr(optval, optlen);
-			if (IS_ERR(filters))
-				return PTR_ERR(filters);
+			filters = kmalloc(optlen, GFP_USER | __GFP_NOWARN |
+					  __GFP_ACCOUNT);
+			if (!filters)
+				return -ENOMEM;
+
+			if (copy_from_sockptr(filters, optval, optlen)) {
+				kfree(filters);
+				return -EFAULT;
+			}
 
 			for (f = filters, c = count; c; f++, c--) {
 				f->name &= f->name_mask;
 				f->pgn &= f->pgn_mask;
 				f->addr &= f->addr_mask;
diff --git a/net/can/raw.c b/net/can/raw.c
index f14270b56f52..a11636af3bb2 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -414,11 +414,11 @@ static int raw_init(struct sock *sk)
 	ro->fd_frames        = 0;
 	ro->xl_frames        = 0;
 	ro->join_filters     = 0;
 
 	/* alloc_percpu provides zero'ed memory */
-	ro->uniq = alloc_percpu(struct uniqframe);
+	ro->uniq = alloc_percpu_gfp(struct uniqframe, GFP_KERNEL_ACCOUNT);
 	if (unlikely(!ro->uniq))
 		return -ENOMEM;
 
 	sk->sk_destruct = raw_sock_destruct;
 
@@ -758,13 +758,19 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 
 		count = optlen / sizeof(struct can_filter);
 
 		if (count > 1) {
 			/* filter does not fit into dfilter => alloc space */
-			filter = memdup_sockptr(optval, optlen);
-			if (IS_ERR(filter))
-				return PTR_ERR(filter);
+			filter = kmalloc(optlen, GFP_USER | __GFP_NOWARN |
+					 __GFP_ACCOUNT);
+			if (!filter)
+				return -ENOMEM;
+
+			if (copy_from_sockptr(filter, optval, optlen)) {
+				kfree(filter);
+				return -EFAULT;
+			}
 		} else if (count == 1) {
 			if (copy_from_sockptr(&sfilter, optval, sizeof(sfilter)))
 				return -EFAULT;
 			filter = &sfilter;
 		}

-- 
2.53.0

