Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.83
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794410527;
	b=UAsU8FJj0fqUP2UHZj279k8nb0RFVHUXGhjTN5qSVTbM0/qOprj0rnWkr6FaH9bzwWa4
	 HQlE04ducVFuUTAANA4zkNy4Y3mrr2Z2UQcGDEr9Z1WScoIMI2e+YxvqcqILR7YRdGOJY
	 x+F04edxtTrHoPgiFlEsOZEsT+URXJ10gk8P1W0KatVhqrTP1ee31f5N85wgLj6M8nX7S
	 0W/MxwMDERIQ25PKsV0RTN0f73E/HNwgEnQne5ENtfSwlvaAiLMS9QCwZxYI+nwok+RUr
	 ajv4mVG0Zqt869FuAdvtK6pgF05FfXsi1ucDMNGH69frDmn97j2suQZRm6fSSAX4isQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794410527;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=NbHQPp6ESPfKBwwW9QOOBkGxQHwu2T3D+NuoFaAEsYE=;
	b=xlGGuvWLWoXomRm96QPERvovZKSC7OPrMH3THXw9s2sQmXsaeuThm2lyArQ2c5s4KQl8
	 2YeN5lsDKZ3CRoEC+XKdqBSolEgyPu1EobH+9E/vJaTMYAXeoqwSxqa25JEq+G2WAityA
	 jCyb1/ED1A4J0SqxglCgDggrzfv4KHfNloDr4Q4Ardmia6FMidtZoRBQ90AtctTYr9RME
	 dRx+0844UKBgjLipQL5uO2RV5D38p+PLqKCdnClU4wC5BDfs8QZcTp2pUik2/zMtW3bkv
	 mVIV9Mkky+GWlKew84Mlsud6Kr14TWl2Zh8O3YQczILvcc1ytWUTnstvNg7ZMKvfieg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=k1kF13Aq;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=SpWypw9B;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.83
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.83])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D91606A326
	for <linux-can@vger.kernel.org>; Wed, 11 Nov 2026 15:22:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50D91606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=k1kF13Aq;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=SpWypw9B
ARC-Seal: i=1; a=rsa-sha256; t=1794410513; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=OpjQwFKOuJWqNjPKtQpravT1ibKzlaY5dHBwqbrFxsuQ+mkQWtzWedYGoJR7YJcEpz
    8ntXaVn6mwuHItcX2h2yVHoqB8HG3BZd1iPS+kPnw87UGmmjSJVcCl1YWAil688QXdgM
    4M2GpcTLiceRgm7iOg8WemtbkHEipMpk/fPLCTXvPkVYMWS8051x2jSl5lr3XCDPlxvN
    TeLpDyGxfWBFoFD2juiKuTaVn4iD0odFlIk83BmmW+5IWrfmQ9v90EjB1jHLX+YZLZu4
    Vbx3kVVzM8RlI6gyOdgmvHzaZRCMWF465rnFs/2SumpbFgZpug0gIxMenCPWs225mM3q
    e3uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794410513;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=NbHQPp6ESPfKBwwW9QOOBkGxQHwu2T3D+NuoFaAEsYE=;
    b=Lk0rCAwei1uJk1ZTKApS3EMqVN5KLFlpJWzL6OlZski9waA/Qy3N4SNigN19nb2s9/
    xBuRhZGIceVd0IWd+LAkp3zu6xsdkHiGZGUEFAkPzJWmEjKN9HA+2XiAvE+hpXdcOqiY
    D6sQU3kU412nLS3sOd+lUOAlCUJtP1Tk0vFAlTVXyfWXTAuAGjuSH3oWmaEQotwEPZUm
    GnunH+f2TkGT/odIVrQelclwtLC+Hf1aw4OsVmPd5j500HnD+K9/vFwz6wZdiJdTfsMk
    6gwiBZ8IJJaAm7bNVhFQyUWmlr2pgo9ha0RET5NZJ5XYKHcM4v9SmIiZelZp3oRGup+K
    NtMA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794410513;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=NbHQPp6ESPfKBwwW9QOOBkGxQHwu2T3D+NuoFaAEsYE=;
    b=k1kF13Aqpaowy2RIsszfLM6OMSv32RFjA1w6jwJx0YG12OPmmmTdeM8HC+vCdt2Sto
    oDdOizqZl6zETHk1eh/Gn1x7TdN78lb/bKu+vG6941IkzHJdwFnPfYH0dfic8EYalDwh
    nFb8UXhFD2bAIuKZSj+rsot/9El8y7dt+Xf1CG4fUlTrLlsruw8inRuhAF0jVSLHWXPh
    jOv5jfa9gXdGlTPMInY+hBP7563eV9bJsFxzDMOGsBs/Mz9+CphrZO6U7HDebM7jaabC
    3VTo4S/g4/vOz7YTCrDEB6QdZ/VOcXUWTRX5HWEVqK/Xw1UrrgxKX0e3OET3QWjmblxP
    xaLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794410513;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=NbHQPp6ESPfKBwwW9QOOBkGxQHwu2T3D+NuoFaAEsYE=;
    b=SpWypw9BAT/gbwC28uov9OgD2CJQDbUzkGqCxBA5GqLONuF4X/wdXywZHoByWEVjuR
    b7EYa0SUTGmyBpqMokDw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2ABFLr9M4
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 11 Nov 2026 16:21:53 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Wed, 11 Nov 2026 16:21:51 +0100
Subject: [PATCH v4 6/6] can: enable memcg accounting for user triggered
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
Message-Id: <20261111-can-bcmlock-memcg-v4-6-5428607a608f@hartkopp.net>
References: <20261111-can-bcmlock-memcg-v4-0-5428607a608f@hartkopp.net>
In-Reply-To: <20261111-can-bcmlock-memcg-v4-0-5428607a608f@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, Sashiko <sashiko-bot@kernel.org>, 
 Zihan Xi <zihanx@nebusec.ai>, Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794410512; l=13155;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=Mv76avFFgI5FIYCDbaKwZZKrDda/JIT1bvE0hD4yCtw=;
 b=WTGVj2LXp0u3YAqxha/w86yTsjgyglJEhpOsAs5TxcOS1n161Re0rbDnT74acW1BOSZMEJote
 kPa/rVhj5QQCF8Ns0MSuB8ZDkz8xgOUkH8hiorgF2DUEPdjG1EJEm6o
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
- isotp: the TX and RX buffers for PDUs > DEFAULT_MAX_PDU_SIZE
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
softirq context and is charged to the memory cgroup of the socket with
set_active_memcg(). As GFP_ATOMIC contains __GFP_HIGH, the charge is
forced when the cgroup is at its limit, so the reception of a PDU does
not fail because of the accounting. The j1939 RX sessions are allocated
in softirq context before a socket is involved and can not be
attributed to a process. The j1939 TX sessions only exist for the
duration of a transfer and the can-gw jobs require CAP_NET_ADMIN in the
initial user namespace, so they are not changed. The local j1939 ECUs
created by bind() are allocated with BH disabled and their number is
limited by the number of bound j1939 sockets, which are accounted.
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
Changes in v4:
- charge the isotp RX buffer for PDUs > DEFAULT_MAX_PDU_SIZE to the
  memory cgroup of the socket with set_active_memcg() (Sashiko review)
- v3: https://lore.kernel.org/linux-can/20261109-can-bcmlock-memcg-v3-3-2d798ca30578@hartkopp.net/

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
 net/can/isotp.c        | 11 +++++++++--
 net/can/j1939/main.c   |  2 +-
 net/can/j1939/socket.c | 12 +++++++++---
 net/can/raw.c          | 14 ++++++++++----
 6 files changed, 41 insertions(+), 20 deletions(-)

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
index 50a3f4cd2b31..5e6940aea5ed 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -55,10 +55,11 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/spinlock.h>
 #include <linux/hrtimer.h>
+#include <linux/sched/mm.h>
 #include <linux/wait.h>
 #include <linux/uio.h>
 #include <linux/net.h>
 #include <linux/netdevice.h>
 #include <linux/socket.h>
@@ -609,11 +610,17 @@ static int isotp_rcv_ff(struct sock *sk, struct canfd_frame *cf, int ae)
 	if (so->rx.len + ae + off + ff_pci_sz < so->rx.ll_dl)
 		return 1;
 
 	/* PDU size > default => try max_pdu_size */
 	if (so->rx.len > so->rx.buflen && so->rx.buflen < max_pdu_size) {
-		u8 *newbuf = kmalloc(max_pdu_size, GFP_ATOMIC);
+		struct mem_cgroup *old_memcg;
+		u8 *newbuf;
+
+		/* charge the buffer to the memcg of the socket owner */
+		old_memcg = set_active_memcg(mem_cgroup_from_sk(sk));
+		newbuf = kmalloc(max_pdu_size, GFP_ATOMIC | __GFP_ACCOUNT);
+		set_active_memcg(old_memcg);
 
 		if (newbuf) {
 			so->rx.buf = newbuf;
 			so->rx.buflen = max_pdu_size;
 		}
@@ -1183,11 +1190,11 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
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
index 641661ef4399..e6603756d65d 100644
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

