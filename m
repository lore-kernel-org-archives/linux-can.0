Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=85.215.255.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794056828;
	b=c3YOUqprHj0cGyg8JC/NfXPHsSJfCnOie4XIbjCvh+b4qSdVfdnS/G0pBiDYwi+tk8l2
	 /1fB04BWzMB1XbBvWYUu10AcL7kg8LeSzGxuBjnz9gLZ6vk5SCL9Ch2zecYNEdQ3WOJXm
	 tYGPBxeUxGRBx8vNBefvux+k9IoFBmKs/WW9oTVIRzaMBh0HnGQE3EuOA5qRxUIh6DUbU
	 7lMlErNbSPHSjWf9LQVsxQraaoltzv4wkoyLcvsAhyHVVB8YcyG+SsXCYzNeUNz0FoJBH
	 Jtn0teBgvrCbHqmzpF4adU+LKWzSyPIfxYX6yJ50oAifKzGSiscCYfYqpta8XUXzzlA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794056828;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=mIdXyL7etaBYyT5spdh0wMDNMcK2jjWv77c0FfD7OUI=;
	b=i7WgU/bjZYiqrKPqKbfz1XU9f8FNp6QUh2PpsXFBJ5B3RwSIGK9AG4YMzCwMTtxf7YV6
	 vlSegazGfQ0Exdlh8EeN0k6R2zDEPqpO/oHG8QIdILI2nLB5nzgPW3kaCapxUHWHGd8BI
	 nj6dTO6UuL2lpZQ81RY/bGMFL52vbw41iUEvfdOhbGdblZNo8XoN9QzhUie5Y0F8DVoec
	 k4FDDESrhIrzDU7C2pIPbsPjLXEHMeDHjXBL/Ss50X+w66ti+u2eDx3ELnb4jZJ/YZFn/
	 RLnKqJYidS0pTar9G0q5keCTTkqLZFDwuuOslpgG31Gu8Vm56vhiBqBQw4dg4g8VQLA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=H5OXoBrN;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=7+J3IHNu;
	arc=fail smtp.remote-ip=85.215.255.54
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9EC606A32E
	for <linux-can@vger.kernel.org>; Sat,  7 Nov 2026 13:07:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F9EC606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=H5OXoBrN;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=7+J3IHNu
ARC-Seal: i=1; a=rsa-sha256; t=1794056819; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=iExu3lYFWlYPjm2PhN2uZOYqxkNQZ0bullygJIquXH3RA2zdNq/mK1ubjXwxlx4Nel
    3e/X+Qn/ZkwFb7hSBo+mmLwqZ33iZXxTxBjtmn9OcKJEnxGz77B2nbyRE839aGJHAXh5
    RiJu2YKz9NXBsLF5QrI3xvV8gdvjd2Yrw9EbsU/cg6gbjA8kushR6DuGxP3P4+mUY6ZQ
    OJCFVkMZGAM9XwpYRBox1nJ08AUjWMusYdN6R6pxj8fUdIKizPnHmX7BwOmuqRqksRbQ
    tQQrYzyqPFYt34Y9zt6GDy77zTz1D3kNU7yGdhojom1YOI99ZnV5k6xEULyjRS5Ej2Pv
    h3VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794056819;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=mIdXyL7etaBYyT5spdh0wMDNMcK2jjWv77c0FfD7OUI=;
    b=DoviJxIrjHofXTYs5hsX/KwhYNqPYcSXkBHm6Lnr8013ItP8G3NErVSf1jECMiMvux
    ddMPxwypGdLwxjNLww0XPuqv3emSw6w9ImJMAxJqN6UeplBD8kHsOTFCJqG7YUGOmZ+j
    5eN7A5rksvuzPNMPkyVp82pv4xFMJZ51FkpEhoaQIwqvRCzvHisak4hdCslZd1AAEvBf
    VEnqfX3tI7j5z4KPMVb4HNUz9NL7X+ODgUMUQ+H1YBI7xLARkvdIrPq0O3TmGvV1IgbZ
    fmjGqSjdgT5O59g2H45jg1c1dn69AUc377E8B2/rsGZuwZQRvi+FKWJrxv845Ywj0TSP
    /Etw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794056819;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=mIdXyL7etaBYyT5spdh0wMDNMcK2jjWv77c0FfD7OUI=;
    b=H5OXoBrN2meCW1QTkPH6Zuw4dAm53K7phiQIAUQV8bHXoPOyLxTFfOdUtaUt4DjSKf
    WpOH2jMV3dZZ5wu4WLddOZurOYcwKRNyjffmc118YGO4lF5qI6ymTeMvjBcRh2kYZTPp
    lMFIT0ORZ3w0PR/YN+qj/U2id8avmUG43yxPwQJwnr/3GXPGRWdgp7vNc4wWF9aZNrXc
    C8oOZkZnFagPRoVC4xTYrpLol1/CdAGIT/3xq8Zo8+vyo0fUuRK0v6Hv/NEs1h7077Fb
    RRDh6I7ha7eMYq9wtjgqYhwSNE3CNuyWJz9gm3Yw2J3g7nBZVm+7tqxFGgdWZ6LKXdzo
    I8qw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794056819;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=mIdXyL7etaBYyT5spdh0wMDNMcK2jjWv77c0FfD7OUI=;
    b=7+J3IHNuUwbfB5sDq/wcSYzR3Eb03P2uL0uBOR2UD94YBsc2oMhwPYsqgOvHu/IZIb
    dHHyFzuu2fOB2uUPDKAw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2A7D6xlPY
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 7 Nov 2026 14:06:59 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Sat, 07 Nov 2026 14:06:46 +0100
Subject: [PATCH 3/3] can: enable memcg accounting for user triggered
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
Message-Id: <20261107-can-bcmlock-memcg-v1-3-482d9f5be1fd@hartkopp.net>
References: <20261107-can-bcmlock-memcg-v1-0-482d9f5be1fd@hartkopp.net>
In-Reply-To: <20261107-can-bcmlock-memcg-v1-0-482d9f5be1fd@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, Sashiko <sashiko-bot@kernel.org>, 
 Zihan Xi <zihanx@nebusec.ai>, Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794056818; l=10852;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=JZ3aw0tewEvwsKYEyeSfu7kw0VLIGJitp2KHbsH+HGo=;
 b=Lo2Le13EYdK3HoCtB7pA/SX4U0b8tl/JlRbUl45g7fdKPGen4f0TlzDRWNDEsaQKpo+C2RVgj
 wZNn9IYA6F+BpvzUnXnezS8iOw+DXLKfdirOdj07RPjLkhecKXJh9bo
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
allocated and copied explicitly.

The isotp RX buffer and the j1939 RX sessions are allocated in softirq
context and can not be attributed to a process. The j1939 TX sessions
only exist for the duration of a transfer and the can-gw jobs require
CAP_NET_ADMIN in the initial user namespace, so they are not changed.
Temporary buffers that are freed before the syscall returns are not
accounted either.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260707-bcm_fixes-v5-0-c3c74f8d8ff7@hartkopp.net
Reported-by: Zihan Xi <zihanx@nebusec.ai>
Closes: https://lore.kernel.org/linux-can/cover.1793089479.git.zihanx@nebusec.ai/
Link: https://lore.kernel.org/linux-can/350df96b-5f69-490e-b39e-ed6e9bca4754@hartkopp.net/
Cc: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/af_can.c       | 12 +++++++-----
 net/can/bcm.c          | 10 +++++-----
 net/can/isotp.c        |  2 +-
 net/can/j1939/main.c   |  2 +-
 net/can/j1939/socket.c | 11 ++++++++---
 net/can/raw.c          | 13 +++++++++----
 6 files changed, 31 insertions(+), 19 deletions(-)

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
index 0631293a8b54..83c1b6ee6d27 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -1157,11 +1157,11 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 		kfree(new_frames);
 
 	} else {
 		/* insert new BCM operation for the given can_id */
 
-		op = kzalloc(OPSIZ, GFP_KERNEL);
+		op = kzalloc(OPSIZ, GFP_KERNEL_ACCOUNT);
 		if (!op)
 			return -ENOMEM;
 
 		spin_lock_init(&op->bcm_tx_lock);
 		op->can_id = msg_head->can_id;
@@ -1174,11 +1174,11 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 
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
@@ -1405,11 +1405,11 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
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
@@ -1420,20 +1420,20 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 
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
index 50a598ef5fd4..c83246587604 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -714,13 +714,18 @@ static int j1939_sk_setsockopt(struct socket *sock, int level, int optname,
 			if (optlen > J1939_FILTER_MAX *
 			    sizeof(struct j1939_filter))
 				return -EINVAL;
 
 			count = optlen / sizeof(*filters);
-			filters = memdup_sockptr(optval, optlen);
-			if (IS_ERR(filters))
-				return PTR_ERR(filters);
+			filters = kmalloc(optlen, GFP_KERNEL_ACCOUNT);
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
index f14270b56f52..dd5b9600bad9 100644
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
 
@@ -758,13 +758,18 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 
 		count = optlen / sizeof(struct can_filter);
 
 		if (count > 1) {
 			/* filter does not fit into dfilter => alloc space */
-			filter = memdup_sockptr(optval, optlen);
-			if (IS_ERR(filter))
-				return PTR_ERR(filter);
+			filter = kmalloc(optlen, GFP_KERNEL_ACCOUNT);
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

