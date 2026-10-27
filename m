Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.80
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793111499;
	b=zesTBxW6BgCLUHXiI3CUJiP1UEhKYBfoKboXi2SHBCOGk/oVi7hFVJ05lXS5Mgqc6yiB
	 vdWcGQ/eoHaiCusY0cnPZW5vipO1sdqpU1b7vRxa2S39Ot9SLES67z4JxS9gu3nnmd+WH
	 5mjCU6MT0Om2aYCri38aXQpbBfsSVcVxE7g324QReQom9+xBAs11kGXgu27nVtdBMcNy+
	 B/79D0sxWyyna9NC2p0uKG4y3KcjumAMddSPreI8jHdJzVBgGSsyuPoUIfMZF4lfJrQ4X
	 q5T7DN85NdFXL1REbgQbCFasdCUviIV7xmil3hRgg/0sGzMwJOlQabzfoWoXxfnRigg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793111499;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=vX6sw4JOeUOr5u4rVXBgWE0mwXAN5EsGfZeawQ1Ewjk=;
	b=y4FW8s8KXQ1KZJ4EgUNUWcZ4Kzf/cYemHs4htDO3urUT+ITDUtpUtgIJufjuaJTaa7DG
	 cIMby2DKtMfLjhT2twfLCUXZ7YrStQMCbIJyoUKTnMnSv9aDHNF9ZgqbeVmkyX66Qu/Bh
	 EGwluKytgUP7tzOsxs4iV1phY4hYCslbdiQ3dDnhYuiB9WvKUJdiibdgGvNcXDaCcSpH4
	 YbSk/Lz7ANfwfVmwoaeEyYM1axHYdJY+62EkGjBj/0f4f5K0xtrrtnh5j/MZesG+yslwa
	 CN6WjbJesIKp/thzMpixAD2DfMscUP5MGPlyNl5vbM4e4XNvCueXJALQwbcppjCXPOA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=XsdaCHFs;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=Gx19b00S;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.80
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C129606A323
	for <linux-can@vger.kernel.org>; Tue, 27 Oct 2026 14:31:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C129606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=XsdaCHFs;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=Gx19b00S
ARC-Seal: i=1; a=rsa-sha256; t=1793111475; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=JASn6lPqxx+Y2PUcpKIUkUyYUOzEXktUQgSXkQIMccl3lWvXZfS1ewQI/f8AP1g+f1
    CeO8vQL+vm4eXCKTiK3arIvgjPNrVWGMN/EuDfZlUKu2T4AWFF6eKDZ1QPA6Kz9h8ZLS
    T5Nr55+6sT3rOsKkl1WfyK6gB1FL04fFQPRw0AD00JL6vahhPqfOTTd62nEF4WpxjQap
    kQ/XhoUZPzBPcxdx0xRwKANILElDnotPjyBeBDQzHpGM03J5rnoc3P/GrdOO8sR4b66p
    FGhvYZZ9yUU4WVGanfNDlO0t75eTSSQoBUdhxEAzIzSY/mDv/hIr1cI0ouxM7eey4ly2
    sMdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1793111475;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=vX6sw4JOeUOr5u4rVXBgWE0mwXAN5EsGfZeawQ1Ewjk=;
    b=ED9Pjo/nPYfRD54CJe9V84hJgq+2sZZu7hQuVTHGYUp5hEOGtA/ogFIurxN6OeDqSG
    kbCL7UJvUh/GOWSV/ss+AHSXWhC3+f6s6QnDN5UXYcWEOOq31J0O7YV0n5VU+dh+1fMj
    cxvvjvzDNIZ7mbsx2gFcAAK949fKMF4Vr/qb62JBYzzl9Z9MTRrrs4i8lGW9IROpgYBQ
    8dATE0gTaH7ckgdTdUoeENg4hQ+JVu/CSXHxlhLVWnkC36KjuZzkyQkcUUdOoUL35HLD
    prc2UfK6pdSsKJ11XbJNO3r/aGZsu7CVgD4sr0AS0guUMnPvFqXYLoSrGkcmfpv5Sh3M
    NVlg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1793111475;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=vX6sw4JOeUOr5u4rVXBgWE0mwXAN5EsGfZeawQ1Ewjk=;
    b=XsdaCHFsGUBOLGz5jjegWn20nRpPwl8cSbwnhGtppPUD+omSomvbWqTJGM0Wg2Vab4
    HYOydnfg3YqRdZxa9CG9t339qkZPttvDDy38ODPKC5gC3SHHO9qh99uNdfQjj+iTUwDL
    G+ggbNRdbSUDbDd6FuLKDH/DL0+id7G1n+08aL37fZfk8iSco59FUhTfhfr77Y1okJQy
    Gl5CXRyQizd533KUcZqhJFsxleWi7MQ2DxcKibb7htDIufP/VenelHJGPbuRjg6Gazeg
    Fm35xfE79OOwzEbi7NOMTSYjweEUvyofRJW9Jb01+OFzvFcOpDI2UGB5RKbQLl/466AN
    1lJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1793111475;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=vX6sw4JOeUOr5u4rVXBgWE0mwXAN5EsGfZeawQ1Ewjk=;
    b=Gx19b00SlPqssXrQIvJ2EAkM2wneYClALvZuqAiqi7DqKojsKmRWiMM2Ocup9hAk53
    nltGA/larf62ULzHwFDg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29REVEAL9
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 27 Oct 2026 15:31:14 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Tue, 27 Oct 2026 15:31:11 +0100
Subject: [PATCH v12 7/7] can: proc: remove pointers from CAN specific proc
 output
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
Message-Id: <20261027-can-rx-lock-v12-7-eb5afc2d8b9b@hartkopp.net>
References: <20261027-can-rx-lock-v12-0-eb5afc2d8b9b@hartkopp.net>
In-Reply-To: <20261027-can-rx-lock-v12-0-eb5afc2d8b9b@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793111472; l=13837;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=eAemgOrLE1WoWAwYCh49WUVGWlQejPNc17l9crGFKPA=;
 b=KpoSIkauHKMrVvz/ZsnWwjOR7vfSIy0pOSKIZvOqPimi4rct1GmcHcg8q/cuu2ZzNV23Z1dMV
 ThSxJbmaIVGDcV8f72BnTN23EXlt2KAaDp4mx3UFzQcIICc0dFG6Bwu
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=

The proc content in /proc/net/can/ and /proc/net/can-bcm/ is intended to
check the internal filter lists (af_can, can_raw) and the efficiency and
functionality of can_bcm jobs. While exposing kernel addresses was
acceptable when this code was written the times have changed and multiple
attempts have been made to hash or remove such now sensitive data.

This patch removes the disclosure of pointers and instead provides the
function names and sock inode numbers when available. When the function
name can not be resolved (e.g. KALLSYMS=n or stripped module symbols)
%ps would fall back to the raw text address. Therefore (unknown) is
printed instead in this case. As there's no known tooling around the CAN
specific proc output breaking the ABI with this rework creates no issue.

Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
Changes in v12:
- moved from patch 3 to the end of the series, as it changes the proc
  output ABI and is not intended for stable: the isotp receivers of
  "can: isotp: check the return values of can_rx_register() in
  isotp_bind()" are converted to sock_i_ino(sk) here (no functional
  change)
- v11: https://lore.kernel.org/linux-can/20261026-can-rx-lock-v11-3-3b9a2b829dab@hartkopp.net/
---
 Documentation/networking/can.rst | 16 ++++++++++------
 include/linux/can/core.h         |  2 +-
 net/can/af_can.c                 |  6 +++---
 net/can/af_can.h                 |  2 +-
 net/can/bcm.c                    | 14 +++++++-------
 net/can/gw.c                     |  2 +-
 net/can/isotp.c                  |  4 ++--
 net/can/j1939/main.c             |  2 +-
 net/can/proc.c                   | 26 ++++++++++++++++----------
 net/can/raw.c                    |  4 ++--
 10 files changed, 44 insertions(+), 34 deletions(-)

diff --git a/Documentation/networking/can.rst b/Documentation/networking/can.rst
index 536ff411da1d..51bc70748f75 100644
--- a/Documentation/networking/can.rst
+++ b/Documentation/networking/can.rst
@@ -1038,21 +1038,25 @@ procfs content
 
 As described in :ref:`socketcan-receive-lists` the SocketCAN core uses several filter
 lists to deliver received CAN frames to CAN protocol modules. These
 receive lists, their filters and the count of filter matches can be
 checked in the appropriate receive list. All entries contain the
-device and a protocol module identifier::
+CAN network device, the filter (can_id/can_mask), the number of filter
+matches, the inode number of the subscribing socket and the name of the
+receive function. A sock_inode of 0 denotes a kernel internal subscriber
+without a socket (e.g. CAN gateway or J1939). When the function name can
+not be resolved (e.g. with CONFIG_KALLSYMS=n) "(unknown)" is printed::
 
     foo@bar:~$ cat /proc/net/can/rcvlist_all
 
     receive list 'rx_all':
-      (vcan3: no entry)
-      (vcan2: no entry)
-      (vcan1: no entry)
-      device   can_id   can_mask  function  userdata   matches  ident
-       vcan0     000    00000000  f88e6370  f6c6f400         0  raw
       (any: no entry)
+      device   can_id   can_mask   matches  sock_inode  function
+       vcan0     000    00000000         0       63586  raw_rcv [can_raw]
+      (vcan1: no entry)
+      (vcan2: no entry)
+      (vcan3: no entry)
 
 In this example an application requests any CAN traffic from vcan0::
 
     rcvlist_all - list for unfiltered entries (no filter operations)
     rcvlist_eff - list for single extended frame (EFF) entries
diff --git a/include/linux/can/core.h b/include/linux/can/core.h
index 2de74c2b78b6..effb5c31ef40 100644
--- a/include/linux/can/core.h
+++ b/include/linux/can/core.h
@@ -49,11 +49,11 @@ extern int  can_proto_register(const struct can_proto *cp);
 extern void can_proto_unregister(const struct can_proto *cp);
 
 int can_rx_register(struct net *net, struct net_device *dev,
 		    canid_t can_id, canid_t mask,
 		    void (*func)(struct sk_buff *, void *),
-		    void *data, char *ident, struct sock *sk);
+		    void *data, u64 ino, struct sock *sk);
 
 extern void can_rx_unregister(struct net *net, struct net_device *dev,
 			      canid_t can_id, canid_t mask,
 			      void (*func)(struct sk_buff *, void *),
 			      void *data);
diff --git a/net/can/af_can.c b/net/can/af_can.c
index 167b2dc40eeb..0f3051a61aab 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -416,11 +416,11 @@ static struct hlist_head *can_rcv_list_find(canid_t *can_id, canid_t *mask,
  * @dev: pointer to netdevice (NULL => subscribe from 'all' CAN devices list)
  * @can_id: CAN identifier (see description)
  * @mask: CAN mask (see description)
  * @func: callback function on filter match
  * @data: returned parameter for callback function
- * @ident: string for calling module identification
+ * @ino: inode number of sock (0 = unknown)
  * @sk: socket pointer (might be NULL)
  *
  * Description:
  *  Invokes the callback function with the received sk_buff and the given
  *  parameter 'data' on a matching receive filter. A filter matches, when
@@ -441,11 +441,11 @@ static struct hlist_head *can_rcv_list_find(canid_t *can_id, canid_t *mask,
  *  -ENOMEM on missing cache mem to create subscription entry
  *  -ENODEV unknown device
  */
 int can_rx_register(struct net *net, struct net_device *dev, canid_t can_id,
 		    canid_t mask, void (*func)(struct sk_buff *, void *),
-		    void *data, char *ident, struct sock *sk)
+		    void *data, u64 ino, struct sock *sk)
 {
 	struct receiver *rcv;
 	struct hlist_head *rcv_list;
 	struct can_dev_rcv_lists *dev_rcv_lists;
 	struct can_rcv_lists_stats *rcv_lists_stats = net->can.rcv_lists_stats;
@@ -471,11 +471,11 @@ int can_rx_register(struct net *net, struct net_device *dev, canid_t can_id,
 	rcv->can_id = can_id;
 	rcv->mask = mask;
 	atomic_long_set(&rcv->matches, 0);
 	rcv->func = func;
 	rcv->data = data;
-	rcv->ident = ident;
+	rcv->ino = ino;
 	rcv->sk = sk;
 
 	hlist_add_head_rcu(&rcv->list, rcv_list);
 	dev_rcv_lists->entries++;
 
diff --git a/net/can/af_can.h b/net/can/af_can.h
index 87887014f562..6e593ed5db5f 100644
--- a/net/can/af_can.h
+++ b/net/can/af_can.h
@@ -53,11 +53,11 @@ struct receiver {
 	canid_t can_id;
 	canid_t mask;
 	atomic_long_t matches;
 	void (*func)(struct sk_buff *skb, void *data);
 	void *data;
-	char *ident;
+	u64 ino;
 	struct sock *sk;
 	struct rcu_head rcu;
 };
 
 /* statistic structures */
diff --git a/net/can/bcm.c b/net/can/bcm.c
index 9288b96724da..7bd2aa39777a 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -219,13 +219,11 @@ static int bcm_proc_show(struct seq_file *m, void *v)
 	struct net *net = m->private;
 	struct sock *sk = (struct sock *)pde_data(m->file->f_inode);
 	struct bcm_sock *bo = bcm_sk(sk);
 	struct bcm_op *op;
 
-	seq_printf(m, ">>> socket %pK", sk->sk_socket);
-	seq_printf(m, " / sk %pK", sk);
-	seq_printf(m, " / bo %pK", bo);
+	seq_printf(m, ">>> sock inode %s", bo->procname);
 	seq_printf(m, " / dropped %lu", bo->dropped_usr_msgs);
 	seq_printf(m, " / bound %s", bcm_proc_getifname(net, ifname, bo->ifindex));
 	seq_printf(m, " <<<\n");
 
 	rcu_read_lock();
@@ -1524,11 +1522,11 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 			if (dev) {
 				err = can_rx_register(sock_net(sk), dev,
 						      op->can_id,
 						      REGMASK(op->can_id),
 						      bcm_rx_handler, op,
-						      "bcm", sk);
+						      sock_i_ino(sk), sk);
 
 				/* keep a tracked reference so that a later
 				 * unregister can safely reach the device even
 				 * if a concurrent NETDEV_UNREGISTER has
 				 * already unlisted it by ifindex
@@ -1548,11 +1546,12 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 			}
 
 		} else {
 			err = can_rx_register(sock_net(sk), NULL, op->can_id,
 					      REGMASK(op->can_id),
-					      bcm_rx_handler, op, "bcm", sk);
+					      bcm_rx_handler, op,
+					      sock_i_ino(sk), sk);
 		}
 
 		if (err) {
 			/* newly created bcm rx op is broken -> remove it */
 			if (new_op) {
@@ -2020,12 +2019,13 @@ static int bcm_connect(struct socket *sock, struct sockaddr_unsized *uaddr, int
 		bo->ifindex = 0;
 	}
 
 #if IS_ENABLED(CONFIG_PROC_FS)
 	if (net->can.bcmproc_dir) {
-		/* unique socket address as filename */
-		sprintf(bo->procname, "%llu", sock_i_ino(sk));
+		/* use unique socket inode number as filename */
+		snprintf(bo->procname, sizeof(bo->procname),
+			 "%llu", sock_i_ino(sk));
 		bo->bcm_proc_read = proc_create_net_single(bo->procname, 0644,
 						     net->can.bcmproc_dir,
 						     bcm_proc_show, sk);
 		if (!bo->bcm_proc_read) {
 			ret = -ENOMEM;
diff --git a/net/can/gw.c b/net/can/gw.c
index 54bb5bd3242a..8a5327d8a00e 100644
--- a/net/can/gw.c
+++ b/net/can/gw.c
@@ -578,11 +578,11 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
 
 static inline int cgw_register_filter(struct net *net, struct cgw_job *gwj)
 {
 	return can_rx_register(net, gwj->src.dev, gwj->ccgw.filter.can_id,
 			       gwj->ccgw.filter.can_mask, can_can_gw_rcv,
-			       gwj, "gw", NULL);
+			       gwj, 0, NULL);
 }
 
 static inline void cgw_unregister_filter(struct net *net, struct cgw_job *gwj)
 {
 	can_rx_unregister(net, gwj->src.dev, gwj->ccgw.filter.can_id,
diff --git a/net/can/isotp.c b/net/can/isotp.c
index 370744ccd42e..d107ae50e6f1 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1630,17 +1630,17 @@ static int isotp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int l
 	/* no consecutive frame echo skb in flight */
 	WRITE_ONCE(so->cfecho, 0);
 
 	/* register for echo skb's first (no echo traffic at this point) */
 	err = can_rx_register(net, dev, tx_id, SINGLE_MASK(tx_id),
-			      isotp_rcv_echo, sk, "isotpe", sk);
+			      isotp_rcv_echo, sk, sock_i_ino(sk), sk);
 	if (err)
 		goto out_put_dev;
 
 	if (isotp_register_rxid(so)) {
 		err = can_rx_register(net, dev, rx_id, SINGLE_MASK(rx_id),
-				      isotp_rcv, sk, "isotp", sk);
+				      isotp_rcv, sk, sock_i_ino(sk), sk);
 		if (err) {
 			/* unregister echo skb subscription */
 			can_rx_unregister(net, dev, tx_id, SINGLE_MASK(tx_id),
 					  isotp_rcv_echo, sk);
 			goto out_put_dev;
diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
index 5e5e6c228f22..d9384cf0e356 100644
--- a/net/can/j1939/main.c
+++ b/net/can/j1939/main.c
@@ -182,11 +182,11 @@ static int j1939_can_rx_register(struct j1939_priv *priv)
 	struct net_device *ndev = priv->ndev;
 	int ret;
 
 	j1939_priv_get(priv);
 	ret = can_rx_register(dev_net(ndev), ndev, J1939_CAN_ID, J1939_CAN_MASK,
-			      j1939_can_recv, priv, "j1939", NULL);
+			      j1939_can_recv, priv, 0, NULL);
 	if (ret < 0) {
 		j1939_priv_put(priv);
 		return ret;
 	}
 
diff --git a/net/can/proc.c b/net/can/proc.c
index fb144d2adc35..b7496d2a37cd 100644
--- a/net/can/proc.c
+++ b/net/can/proc.c
@@ -202,30 +202,36 @@ static void can_print_rcvlist(struct seq_file *m, struct hlist_head *rx_list,
 			      struct net_device *dev)
 {
 	struct receiver *r;
 
 	hlist_for_each_entry_rcu(r, rx_list, list) {
+		char symcheck[4];
 		char *fmt = (r->can_id & CAN_EFF_FLAG)?
-			"   %-5s  %08x  %08x  %pK  %pK  %8ld  %s\n" :
-			"   %-5s     %03x    %08x  %pK  %pK  %8ld  %s\n";
+			"  %6s  %08x  %08x  %8ld  %10llu" :
+			"  %6s     %03x    %08x  %8ld  %10llu";
 
 		seq_printf(m, fmt, DNAME(dev), r->can_id, r->mask,
-			   r->func, r->data, atomic_long_read(&r->matches),
-			   r->ident);
+			   atomic_long_read(&r->matches), r->ino);
+
+		/* %ps falls back to the raw text address when the symbol
+		 * can not be resolved (KALLSYMS=n, stripped module symbols)
+		 */
+		snprintf(symcheck, sizeof(symcheck), "%ps", r->func);
+		if (strncmp(symcheck, "0x", 2))
+			seq_printf(m, "  %ps\n", r->func);
+		else
+			seq_puts(m, "  (unknown)\n");
 	}
 }
 
 static void can_print_recv_banner(struct seq_file *m)
 {
 	/*
-	 *                  can1.  00000000  00000000  00000000
-	 *                 .......          0  tp20
+	 *    device   can_id   can_mask   matches  sock_inode  function
+	 *     vcan0     000    00000000         0       43798  raw_rcv [can_raw]
 	 */
-	if (IS_ENABLED(CONFIG_64BIT))
-		seq_puts(m, "  device   can_id   can_mask      function          userdata       matches  ident\n");
-	else
-		seq_puts(m, "  device   can_id   can_mask  function  userdata   matches  ident\n");
+	seq_puts(m, "  device   can_id   can_mask   matches  sock_inode  function\n");
 }
 
 static int can_stats_proc_show(struct seq_file *m, void *v)
 {
 	struct net *net = m->private;
diff --git a/net/can/raw.c b/net/can/raw.c
index 0926d5686e41..f14270b56f52 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -226,11 +226,11 @@ static int raw_enable_filters(struct net *net, struct net_device *dev,
 
 	for (i = 0; i < count; i++) {
 		cond_resched();
 		err = can_rx_register(net, dev, filter[i].can_id,
 				      filter[i].can_mask,
-				      raw_rcv, sk, "raw", sk);
+				      raw_rcv, sk, sock_i_ino(sk), sk);
 		if (err) {
 			/* clean up successfully registered filters */
 			while (--i >= 0)
 				can_rx_unregister(net, dev, filter[i].can_id,
 						  filter[i].can_mask,
@@ -247,11 +247,11 @@ static int raw_enable_errfilter(struct net *net, struct net_device *dev,
 {
 	int err = 0;
 
 	if (err_mask)
 		err = can_rx_register(net, dev, 0, err_mask | CAN_ERR_FLAG,
-				      raw_rcv, sk, "raw", sk);
+				      raw_rcv, sk, sock_i_ino(sk), sk);
 
 	return err;
 }
 
 static void raw_disable_filters(struct net *net, struct net_device *dev,

-- 
2.53.0

