Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7C24AA003
	for <linux-can@vger.kernel.org>; Fri,  4 Sep 2026 14:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788531252; cv=none; b=usghCYB88ZJacHoA4we8gL/W1ARBX6TiIT8im10uhDW6abKx3LfxQ4Je2Fc61XHVZhMVbQQ1fQrjs7/qXUFWAMX1Kx8kI4TAh/0CXh2QYVa7CoN9rwvw4j1h1jJeehGZwC+HCIPiaEWycleROK7f1ALf+Hd7fcwbJOO3zLzfysU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788531252; c=relaxed/simple;
	bh=JUrnPX2hZSZ9iKCZdbA9fwVc25ZurqHFWMLVnuk2hy4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mR8e7PORN95UaAkwtojNZYAgIO9UKuPupMZJwjN4f/0OQqrQkWfqKAF6S3XSHcXWK8/ZDqxniCd2lbfx64x6wvhYRvxhE/0FN5Ch8Gxxq9htvubY//1MYKEOQKg2Jz/lGrvugiODgzVpmsH6bD74CCMj/k8DAsA0PlEFo0p+p2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=amBZGvge; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XKCr4sM1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="amBZGvge";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XKCr4sM1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788531250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jo7HBIxK8pS1RtD5OrfnWsLrpxzequmtwdBo3SwUJ5w=;
	b=amBZGvge6dOK5104V1WltVqsaqYXBHOtNJSQuVOv67o9AwDpipd/jiyEan6ZndJQSyzq2L
	qk3ky8GsUcyW22wnAk2JnW+3XOSreRxbX54h8x7HL1empc9wG3+u0FsDbXmWwrqyNN1xmy
	rSPe6TABuSlR6eUY5Gr7kAMcMPUaKiw=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-zPYEzUniNTSktgfpg51O9g-1; Fri, 04 Sep 2026 10:14:06 -0400
X-MC-Unique: zPYEzUniNTSktgfpg51O9g-1
X-Mimecast-MFC-AGG-ID: zPYEzUniNTSktgfpg51O9g_1788531245
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5b632c887a0so256588e87.2
        for <linux-can@vger.kernel.org>; Fri, 04 Sep 2026 07:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788531245; x=1789136045; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jo7HBIxK8pS1RtD5OrfnWsLrpxzequmtwdBo3SwUJ5w=;
        b=XKCr4sM1pZEtJPVBqgRzh/XO6xVweu9aBbstv9Zivu7GqU7uL0kc09miyUS1USlnTS
         jqsinRdDh8N8vb9wbGOLVqMxtb9bAW8nemD4RWpm74AniUdE2pN4IMm3ULt+OGDOddXt
         PpVczrp6mRpVEPgLx9suYiVSqOK19NgQVHOSjeZhP4jUN394beYNqH2FXsGvqP2wNKr/
         8eXX/thhxIYRnqV2sfJb6sJbM6F18XX5XXE7P7YrLLu7KUkMQjF1UUvTCdiG4vnvJYw7
         O00JJSOzhn/JKOID68C1xXrDoLcnJ5zjU5avo4WU9HEOB1iuBuK7lVpt00GYUkCEYz4X
         R4fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788531245; x=1789136045;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jo7HBIxK8pS1RtD5OrfnWsLrpxzequmtwdBo3SwUJ5w=;
        b=j7s1hfq5IpK4wvxYLUcuTwiiVeB1f/7BuNs6zzXQZhyQRZmnWBkC/vizyzl9dj6XWL
         n9RxIMOMjMMfeUnYBnGYSPB67NltT/hWQQjPx91JVgNb8P8S1Ul4ADaUhwwN/8CE6Esv
         JlAY8DiC6cBSZx/ni2GTXIR7sKnbTaJiEoBXb++lVqZvt4Hh09ZY6CY9bpb4EAiG2S3E
         fEpTXa1ouB0TuKVEisXm4bf7xqbF4M8CT9rdPzrUqo983EXtq32Q3IeWMIIUJ8HVUvC9
         BpSMZXWoa5v86bYi0LlIdwdisk5yGCwWT4e4de+lfIQKiP4FdGTJKJ2ZXw409MJKBAgH
         2uEw==
X-Gm-Message-State: AFuF++knFA50QFEh0A4Y+MJtmhbCwhn8NJlbDhsqX9eXspuHwSWSO2+e
	BcEROIoW7YMUWtuvsp+tY6PGJqUcIe7T3wI+9bknKPpA+gAf37ADyxU4hvXBQeq0RN23ZQvRlJ4
	cPlC4DOx3kGtbaIUzalQSPrB4PIWf9ls/qrSoLuSIO7wD+9bJZ6OxVn1Q7PzjgpqD1fcZYe/X
X-Gm-Gg: AYBFou3Hkl/B4uflJhDUUYLRQL8nuAXI2ICoRJMXEGiRSRY1AMjwb1zYafYxd5ohxBv
	eAEg25F8gqP6f10FOb/Xkir4fXcfHxFQnwkGyPxwymO/2AJxIb6SdA7I8D+vt42gV/mSJw89aAh
	/B/gMCISKEpMQtU1n9JvvK5tMSjuW9P50amBZHeKmv+MkCH2CbYxzCnP/7/fGYpyaw7lI6OXms/
	o3mVgv5pm82O7/QcpWx1BFXrJSUDO9PrSp08nTyePCi/H/V2ctlQTMYrBnDvYaprKdaw966qAUk
	fZQ3QAofVnw1OdEAWHt6ghrRGhyyoSuT3FewMjTlKxGQ5f6Hci0if5dMvD6B/uhvT96h8KdJ5WA
	Cz4a2GsgIHFtrpSfiMeqEDawrOAI1LF5UKXItRAU=
X-Received: by 2002:a05:6512:1284:b0:5b4:9d34:eb67 with SMTP id 2adb3069b0e04-5b616f4bfcdmr1701629e87.24.1788531244890;
        Fri, 04 Sep 2026 07:14:04 -0700 (PDT)
X-Received: by 2002:a05:600c:8b11:b0:49c:edfe:d525 with SMTP id 5b1f17b1804b1-49cf82417f7mr124799685e9.10.1788531233510;
        Fri, 04 Sep 2026 07:13:53 -0700 (PDT)
Received: from fstornio-thinkpadx1carbongen11.remote.csb ([130.25.253.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf7703cefsm99744845e9.5.2026.09.04.07.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 07:13:52 -0700 (PDT)
From: Filippo Storniolo <fstornio@redhat.com>
Date: Fri, 04 Sep 2026 16:12:56 +0200
Subject: [PATCH can-next v3 2/3] af_can: store socket pointers in struct
 netns_can
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-feat-can-diag-v3-2-bdcebf07b373@redhat.com>
References: <20260904-feat-can-diag-v3-0-bdcebf07b373@redhat.com>
In-Reply-To: <20260904-feat-can-diag-v3-0-bdcebf07b373@redhat.com>
To: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Robin van der Gracht <robin@protonic.nl>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, 
 Urs Thuermann <urs.thuermann@volkswagen.de>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-can@vger.kernel.org, Filippo Storniolo <fstornio@redhat.com>
X-Mailer: b4 0.14.3

AF_CAN sockets need to be stored in the netns_can structure
in order to be retrieved by the CAN diagnostic module when
a netlink request message is issued by the userspace.

On socket creation (`can_create()`), add the pointer to the
new socket to `netns_can::sk_list`. During socket release
(`isotp_release()`, `raw_release()`, `j1939_release()`,
`bcm_release()`), remove the corresponding pointer from
this list.

Since this is a prerequisite of the CAN diagnostic module,
deletes and insert operations are conditioned by
IS_ENABLED(CONFIG_CAN_DIAG).

Signed-off-by: Filippo Storniolo <fstornio@redhat.com>
---
 include/linux/can/core.h | 11 +++++++++++
 include/net/netns/can.h  |  6 ++++++
 net/can/af_can.c         | 50 ++++++++++++++++++++++++++++++++++++++++++++++++
 net/can/bcm.c            |  2 ++
 net/can/isotp.c          |  2 ++
 net/can/j1939/socket.c   |  2 ++
 net/can/raw.c            |  2 ++
 7 files changed, 75 insertions(+)

diff --git a/include/linux/can/core.h b/include/linux/can/core.h
index 3287232e3cad..75d9139f33fb 100644
--- a/include/linux/can/core.h
+++ b/include/linux/can/core.h
@@ -61,4 +61,15 @@ extern int can_send(struct sk_buff *skb, int loop);
 void can_set_skb_uid(struct sk_buff *skb);
 void can_sock_destruct(struct sock *sk);
 
+/* function prototypes for the CAN diag module */
+#if IS_ENABLED(CONFIG_CAN_DIAG)
+void lock_can_diag_mutex(struct net *net);
+void unlock_can_diag_mutex(struct net *net);
+void can_add_sock_sklist(struct sock *sk);
+void can_remove_sock_sklist(struct sock *sk);
+#else
+static inline void can_add_sock_sklist(struct sock *sk) {};
+static inline void can_remove_sock_sklist(struct sock *sk) {};
+#endif
+
 #endif /* !_CAN_CORE_H */
diff --git a/include/net/netns/can.h b/include/net/netns/can.h
index 48b79f7e6236..d60273d8a95d 100644
--- a/include/net/netns/can.h
+++ b/include/net/netns/can.h
@@ -36,6 +36,12 @@ struct netns_can {
 
 	/* CAN GW per-net gateway jobs */
 	struct hlist_head cgw_list;
+
+#if IS_ENABLED(CONFIG_CAN_DIAG)
+	/* CAN diag support */
+	struct mutex sklist_lock;
+	struct hlist_head sklist;
+#endif
 };
 
 #endif /* __NETNS_CAN_H__ */
diff --git a/net/can/af_can.c b/net/can/af_can.c
index 65af25946985..1ea36411f219 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -111,6 +111,44 @@ static inline void can_put_proto(const struct can_proto *cp)
 	module_put(cp->prot->owner);
 }
 
+#if IS_ENABLED(CONFIG_CAN_DIAG)
+void lock_can_diag_mutex(struct net *net)
+{
+	mutex_lock(&net->can.sklist_lock);
+}
+EXPORT_SYMBOL(lock_can_diag_mutex);
+
+void unlock_can_diag_mutex(struct net *net)
+{
+	mutex_unlock(&net->can.sklist_lock);
+}
+EXPORT_SYMBOL(unlock_can_diag_mutex);
+
+void can_add_sock_sklist(struct sock *sk)
+{
+	struct net *net;
+
+	net = sock_net(sk);
+
+	lock_can_diag_mutex(net);
+	sk_add_node(sk, &net->can.sklist);
+	unlock_can_diag_mutex(net);
+}
+EXPORT_SYMBOL(can_add_sock_sklist);
+
+void can_remove_sock_sklist(struct sock *sk)
+{
+	struct net *net;
+
+	net = sock_net(sk);
+
+	lock_can_diag_mutex(net);
+	sk_del_node_init(sk);
+	unlock_can_diag_mutex(net);
+}
+EXPORT_SYMBOL(can_remove_sock_sklist);
+#endif
+
 static int can_create(struct net *net, struct socket *sock, int protocol,
 		      int kern)
 {
@@ -174,6 +212,8 @@ static int can_create(struct net *net, struct socket *sock, int protocol,
 		sock_put(sk);
 		sock->sk = NULL;
 	} else {
+		can_add_sock_sklist(sk);
+
 		sock_prot_inuse_add(net, sk->sk_prot, 1);
 	}
 
@@ -799,6 +839,12 @@ EXPORT_SYMBOL(can_proto_unregister);
 static int can_pernet_init(struct net *net)
 {
 	spin_lock_init(&net->can.rcvlists_lock);
+
+#if IS_ENABLED(CONFIG_CAN_DIAG)
+	mutex_init(&net->can.sklist_lock);
+	INIT_HLIST_HEAD(&net->can.sklist);
+#endif
+
 	net->can.rx_alldev_list = kzalloc_obj(*net->can.rx_alldev_list);
 	if (!net->can.rx_alldev_list)
 		goto out;
@@ -842,6 +888,10 @@ static void can_pernet_exit(struct net *net)
 	kfree(net->can.rx_alldev_list);
 	kfree(net->can.pkg_stats);
 	kfree(net->can.rcv_lists_stats);
+
+#if IS_ENABLED(CONFIG_CAN_DIAG)
+	WARN_ON_ONCE(!hlist_empty(&net->can.sklist));
+#endif
 }
 
 /* af_can module init/exit functions */
diff --git a/net/can/bcm.c b/net/can/bcm.c
index 3d637a1e0ac1..a90b7aea2869 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -1921,6 +1921,8 @@ static int bcm_release(struct socket *sock)
 	if (!sk)
 		return 0;
 
+	can_remove_sock_sklist(sk);
+
 	net = sock_net(sk);
 	bo = bcm_sk(sk);
 
diff --git a/net/can/isotp.c b/net/can/isotp.c
index 155530aedce2..25098c5546d2 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1455,6 +1455,8 @@ static int isotp_release(struct socket *sock)
 	so = isotp_sk(sk);
 	net = sock_net(sk);
 
+	can_remove_sock_sklist(sk);
+
 	/* best-effort: wait for a running pdu to finish, but don't block on
 	 * it forever - give up after the first signal
 	 */
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index ccd43ff5519c..cbfd0b888768 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -641,6 +641,8 @@ static int j1939_sk_release(struct socket *sock)
 	if (!sk)
 		return 0;
 
+	can_remove_sock_sklist(sk);
+
 	lock_sock(sk);
 	jsk = j1939_sk(sk);
 
diff --git a/net/can/raw.c b/net/can/raw.c
index 82d9c0499c95..7784b8fd8d19 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -418,6 +418,8 @@ static int raw_release(struct socket *sock)
 	ro = raw_sk(sk);
 	net = sock_net(sk);
 
+	can_remove_sock_sklist(sk);
+
 	spin_lock(&raw_notifier_lock);
 	while (raw_busy_notifier == ro) {
 		spin_unlock(&raw_notifier_lock);

-- 
2.55.0

