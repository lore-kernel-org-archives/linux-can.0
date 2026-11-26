Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795727163;
	b=M3cVYDBlY2PEpU8wphwvUWVklR5qgdf0tOSU31OfnVHdPsSq9Crj5GhcezLO1GiKR7AD
	 Zy5TeO/H78OUJHqPYUA+A3uQgOT87wA5Pw2ZgIC0fhc5OINKB+1GhpoX3RotnabKhkRVL
	 L6M/0EEeXOPbmlT+Y4O6urUWGWgE6oPPRMVg0rnYtxP711+ueFh5IDc+LGeUOk9Vb4f90
	 v0X8o5kLhJBVx4m+POp3qazKEDEIoy3GCoYvWxo1AyZ0qVuRziMFUWJHenMIWCLJhHzq2
	 2+rIQhghHln5yYGw53H9343emmEgm70r4vYyXKWx9tyAvWYNkshy4So0yQufGeKXEhQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795727163;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=RQvDo7wb44YwI7Q9V21t2z/0sSBdyATUKbs7PxmoSbE=;
	b=xz8FdtPi278XnsyYj4gwSm9zx/7NlUcQeMYh6QFnjQixI97qhO97xQfRLcBneeCqt9nY
	 mi7UhWQd05dOAkxoRfgSFDV/9Nb2EaFJXbdKPPWpwdfB8bSmL7Z2a6Zvm+gW3uuJ3OMM6
	 gsTQcesD+cmiFIfff6//8bYRltMtQKdgm6UK3FfM6W07oNN2bYgvyY82p02NPKeFElG1H
	 LKcgRpw2Eff+vIjl4+uaiPQItrXVeO/qEGbWWRI2lS1VAxTlku82guvfS751/8SeU+Diy
	 805LqPSLuEQdfoBumNhLab9DeEHoZ2ZWfNhXeAepkiJwU8VDw4Z9EShZbMbUaKww8iA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=nEQh5VWb;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=0eEVoGJw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.53
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44CC606A332
	for <linux-can@vger.kernel.org>; Thu, 26 Nov 2026 21:06:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D44CC606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=nEQh5VWb;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=0eEVoGJw
ARC-Seal: i=1; a=rsa-sha256; t=1795727151; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=OPXqzaHiG6dcK/XORAZYOji+tCE3SgZAquLaVMDEk7ev+GgGJZq7A9qXlqg41QbWOt
    ZzP9k8CXnsuaFb61/68mc5rzA/6ApiyO378KbmRo3yAVheMzqiA5whWtW0pZ02JUxmAY
    nO7arGDb8vGiiX4XB6qrGQ6HhRMDrTXPkfvXcDfzxf+Mra8zM85uJRogAKCOnPFSMUoi
    g+H2zoQJQGVPwno6HEOYxPRPygx8iiVCsjlN0aQpJB76nTZQPuvOZTgukgblPhtAgSDV
    ASOVxLQJKF75SPAiZX2myAS8ITFrqJhSUAbUekK8r9YcVvas4QcN1nwYTWaDpd7wXu2I
    Tdyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795727151;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=RQvDo7wb44YwI7Q9V21t2z/0sSBdyATUKbs7PxmoSbE=;
    b=OIkWLM2iD7phsbXvUf0zTXWKHFfNeDZo7hrUSgeXgoxR2+PwTFK6JDbmyMRPyo5G2W
    P457xyC7rZD03KZCi1MxpEdHnSMviVaRBWhxiKZJdc/9gh3hMqIqF14xxCVlagjqhlsx
    eRdrFub3lLCKT44EZL5mL1YD5SKpCNpfaolxlbwyjulXGTBioX5EUgmU4cTeC+byaD0P
    uH+ashs1K1/ZB3UygX0H9DJUvem4YVdbwrnda8gAkjrjaF+I5js/yXxo7n9bm6jtSPOM
    LKjJDa4tCUcBKB1nynEX9C2mpTSUf4FqRMHs8ypXMi6cdm3QfxkeJq4jToPkq489f8bt
    sCDA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795727151;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=RQvDo7wb44YwI7Q9V21t2z/0sSBdyATUKbs7PxmoSbE=;
    b=nEQh5VWbvznI+7PC5F2yPZ2k4AAxwrgEKwB+t9+pZM4QSbzHG8mxCyaYI+9OZ2slGz
    exsW2mS7Gf3lztCsZwTHjMRTGHm9uphxYsTb3Iy20cJnUkz1Ff3S0gAClTLdMOhgV24l
    xJICmUVyISA0ZwxE2gLzQ+EWO8w2DPDmTupu15BZAfxdNyJ3eQPUTZ/TdXgZecpC7xPa
    X69iuZBUDuUgu91K0AgcNLjJ6FsGwzdLtcKhME3CTOLyMT2nQkflVEyMu58Yhde2PuDc
    /RqT+8yh9P2KxGHd9W1GDKwNqskS7OKJN/2phWX2Yvu8B+CBG4ITm0Hm9qc3Vu2HBK3i
    KC7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795727151;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=RQvDo7wb44YwI7Q9V21t2z/0sSBdyATUKbs7PxmoSbE=;
    b=0eEVoGJwG//AzB5l/z7z1Pyx4jeXbtNHIY8XlZ2yHuAi4yKyuKF128EWqZoRj0I8LJ
    h9odGfhJ1LUuNyJXrCBA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AQL5otUZ
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 26 Nov 2026 22:05:50 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Thu, 26 Nov 2026 22:05:45 +0100
Subject: [PATCH can-next 03/22] can: enable memcg accounting for user
 triggered allocations
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
Message-Id: <20261126-getsockopt-memcg-isotp-v1-3-681ef8d8c2c9@hartkopp.net>
References: <20261126-getsockopt-memcg-isotp-v1-0-681ef8d8c2c9@hartkopp.net>
In-Reply-To: <20261126-getsockopt-memcg-isotp-v1-0-681ef8d8c2c9@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Sashiko <sashiko-bot@kernel.org>, Zihan Xi <zihanx@nebusec.ai>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795727150; l=12595;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=ebbWITctP0oEiuMJT99r696YH2lj6HyZ1zSQfp37vBg=;
 b=4gl5oaZjOL1w1ZER6OLF6cyKnlWiTcWz7LPF0/RmNLrhp6k+G86QT0j3YZbxfbqoQBTHUZpm+
 mgKCpCFIAuVCpBvWVDCG07yHeAfzGEMiiLC3vDpYF6dr8IS1nB+al0S
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

The isotp RX buffer for PDUs > DEFAULT_MAX_PDU_SIZE is allocated in
softirq context and is not accounted. It could be charged to the memory
cgroup of the socket with set_active_memcg(), but a charge in atomic
context can not reclaim memory. With GFP_ATOMIC the charge is forced,
which allows a cgroup to exceed its limit by up to max_pdu_size per
socket. Without __GFP_HIGH the allocation fails at the limit, so the
reception of the PDU fails, and it loses the access to the atomic
reserves on systems without a memory limit as well. This buffer is only
used when the administrator has increased the max_pdu_size module
parameter. The j1939 RX sessions are allocated in softirq context
before a socket is involved and can not be attributed to a process.
The j1939 TX sessions only exist for the duration of a transfer and the
can-gw jobs require CAP_NET_ADMIN in the initial user namespace, so
they are not changed. The local j1939 ECUs created by bind() are
allocated with BH disabled and their number is limited by the number of
bound j1939 sockets, which are accounted. Temporary buffers that are
freed before the syscall returns are not accounted either.

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
 net/can/isotp.c        |  9 +++++++--
 net/can/j1939/main.c   |  2 +-
 net/can/j1939/socket.c | 12 +++++++++---
 net/can/raw.c          | 14 ++++++++++----
 6 files changed, 39 insertions(+), 20 deletions(-)

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
index dc9e2890490a..f3d93a203071 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -1159,11 +1159,11 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 		kfree(new_frames);
 
 	} else {
 		/* insert new BCM operation for the given can_id */
 
-		op = kzalloc(OPSIZ, GFP_KERNEL);
+		op = kzalloc(OPSIZ, GFP_KERNEL_ACCOUNT);
 		if (!op)
 			return -ENOMEM;
 
 		spin_lock_init(&op->bcm_tx_lock);
 		op->can_id = msg_head->can_id;
@@ -1176,11 +1176,11 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 
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
@@ -1407,11 +1407,11 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
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
@@ -1422,20 +1422,20 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 
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
index 98a7e489ca3e..3b83507a8c21 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -607,11 +607,16 @@ static int isotp_rcv_ff(struct sock *sk, struct canfd_frame *cf, int ae)
 	off = (so->rx.ll_dl > CAN_MAX_DLEN) ? 1 : 0;
 
 	if (so->rx.len + ae + off + ff_pci_sz < so->rx.ll_dl)
 		return 1;
 
-	/* PDU size > default => try max_pdu_size */
+	/* PDU size > default => try max_pdu_size
+	 *
+	 * This buffer is not accounted to a memory cgroup: In softirq
+	 * context the charge would either have to be forced beyond the
+	 * limit of the cgroup or the reception would fail at the limit.
+	 */
 	if (so->rx.len > so->rx.buflen && so->rx.buflen < max_pdu_size) {
 		u8 *newbuf = kmalloc(max_pdu_size, GFP_ATOMIC);
 
 		if (newbuf) {
 			so->rx.buf = newbuf;
@@ -1192,11 +1197,11 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	ae = (so->opt.flags & CAN_ISOTP_EXTEND_ADDR) ? 1 : 0;
 	wait_tx_done = (so->opt.flags & CAN_ISOTP_WAIT_TX_DONE) ? 1 : 0;
 
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
index cf1770432dad..da462e9874f1 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -416,11 +416,11 @@ static int raw_init(struct sock *sk)
 	ro->fd_frames        = 0;
 	ro->xl_frames        = 0;
 	ro->join_filters     = 0;
 
 	/* alloc_percpu provides zero'ed memory */
-	ro->uniq = alloc_percpu(struct uniqframe);
+	ro->uniq = alloc_percpu_gfp(struct uniqframe, GFP_KERNEL_ACCOUNT);
 	if (unlikely(!ro->uniq))
 		return -ENOMEM;
 
 	sk->sk_destruct = raw_sock_destruct;
 
@@ -761,13 +761,19 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 
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

