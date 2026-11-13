Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794568521;
	b=uEHA+SdZrIO7z9l4jQ7HLhPE/3HawKrrniWMAPyUhTUKqGgQEfXPUQEP1SNVifo92hHi
	 u8nZahMlQJwhpLG+RczJR/035H/OK6YN7Lv6Q8FnHp0DVzCk+V7QoweCJ7o+UIacGdSAn
	 yvso75Vb/dtcv/bO5jwSRTt855jfN1qN9IYQSkd4PbKUyyqYk0Oz3cEtoDEmtIgAulaE1
	 7ZmAbeVr2Y8xQTdRPHOQ94GgRd6NFCm1uiH30XkOVtfIMBXFckFUuheTPaglhFqhdpfjJ
	 iCjwMntN5lzKCkA86I4MA1TDro04w3P8Lbyji7LVJ+f3UAOvqFTHgV55VrfNw6jzFcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794568521;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=6b9vAJqkNlo2rqbjSJbjGlluV2l7kIAdl+sJ66+qiow=;
	b=h498Bq4nk1EY6nH/TsSsdBI1z6xLowvOE2ipAiHXE4wXkQIGFP21lUGHmSWkZPQbepD6
	 eC8UujdG/07oY29WFM2Af86WYI7vX8HV0/WWxnM30q3+D0SZQ2Va0GhybG8IEoCN2+zdW
	 Y2iOJtrHPr586DnvyDpcF2ubr+/OLrne28KVMbecN0ToZDAc30N7FewxsmDp9b3IPXLDc
	 4wTbOzb9wRuhfwekf/UJU7mTBARHnHcNwY0H4B5sdH7Bc1qR2gHmNfdKC64lyGvPmcGWn
	 hFrXfkOeXbC6u+gRkGuei8BvWQPFLD6zbB1KG2UA9jlnRcss+ZZ8eBq+TyGBEpDovoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eW4sL6yY;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=dsKw90Uq;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCA8606A333
	for <linux-can@vger.kernel.org>; Fri, 13 Nov 2026 11:15:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FCA8606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eW4sL6yY;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=dsKw90Uq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794568519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6b9vAJqkNlo2rqbjSJbjGlluV2l7kIAdl+sJ66+qiow=;
	b=eW4sL6yYnQJHvsXKFX1HlTiF4uqwpRj4Hyna9OAkf5BcU50KPE7jBw19aLciN01nghxeme
	hK9IN6TN9nDHm+WlcmyTIFWjC20P8H1KkeYnQbJcAksPcDXG6nmjUsjJdghmMKv9sLbYSu
	PPXJbbTURt8G8mHMp4qm1oVJoDtFFZ0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-5-rX959ROD2Wn57cjGVlQA-1; Fri, 13 Nov 2026 06:15:16 -0500
X-MC-Unique: 5-rX959ROD2Wn57cjGVlQA-1
X-Mimecast-MFC-AGG-ID: 5-rX959ROD2Wn57cjGVlQA_1794568515
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49953abe51fso4578515e9.1
        for <linux-can@vger.kernel.org>; Fri, 13 Nov 2026 03:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794568515; x=1795173315; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6b9vAJqkNlo2rqbjSJbjGlluV2l7kIAdl+sJ66+qiow=;
        b=dsKw90UqgJCjEXaDdShIpFFZ8zxCQKks+zoiweZyP0xphjbinc+5J8P/19lfLmH/NG
         ZHf4GFJMuFVlZB7xRXxnOPWADeKODOccmyRBNDEBjI7t2jN3BX36Iqowjw2JdTmBmmGB
         uAYT3JXWx0FyTAHnL6ra2zVCeKweKoPK0ss4oaJntFDsuxeXH8qZVFFz0L3KRC6E02My
         vA/G3/AerhMLzXmqSIwd0W6qVfVIegct4PT+CEAwNPkPNjTaOK7nDBIMVsQDALjruTUN
         0ToZiqFAYDvJVu4a2krizcfitDGcKmEDgH4mK5EhIR3NoIj1hh9xUVW4Mwnceog3cf0h
         PZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794568515; x=1795173315;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6b9vAJqkNlo2rqbjSJbjGlluV2l7kIAdl+sJ66+qiow=;
        b=Z+bhxR+Ed3uoagIyu2HZH2zjyHobpDfoClSf/1feu4+TvxRGT23YQLo9eFGVN0flCQ
         jL4ICBIl2mncrHAMYLpXiViO73IF1ITbMQk4yuEj/fzqLJrMvn9u61I5DrP/C0sV6S8x
         /GsnCTo7PZg0GeMaIy4xwI6SpbPugkff7+bvh+El2fkXOv1eiR0l7d19EB0am4sxQS31
         nvXuda0lHx7NuUsofM7t46EUUuawsL/TXBWTEsntk88YCUvjxQCBK/Gbrk4jEV8A7JQo
         TboY7lkhUTDVk35dyKarTX9l6I7IEDQ3cwxnUVXstbfkKL3EkC2BsKEiCSrTSqADXD8x
         T6Yw==
X-Gm-Message-State: APuU4Z+IEzlJcrrw1/y7PB1jNWL1dkD7duflr89F3bsPI4tl6pO/+C8u
	rZOt7OFpCsk+/Q9ggZTclW/H1VW6L43xd9VVYvihadEG1Nymaj3tJKf4DwC51pX+d7FMWygbZuG
	ztaCkvcgJv2fdWO1DNn+jCpNqE41rMO2NJytkeVJImpE5nAZ0+bXWXUsk+HvugQ==
X-Gm-Gg: AYBFou0dgryvWqOuMFBFzB6ynFIAaygUQOVIrL4fYa20X85EzElBmdBiiKWWaCAMukz
	TXrEuHeB7Tpp3V9URFfCoxcTtEYNVBy/9o2I3EIKVESgvhDXTppo50yF27eYtgM8lWLlA/+dv1Q
	uIhTpdODQkNdjMsKCXNnudIJ6TGKqgAR9szz09rIH/vmguiP4DAgdaT6qBDXieQag85XZEf/SLG
	z5yAZmuhFPaaphT9WspVjNNj1I/MW6XyGy6cXqkQ/ZcRLlmOB+uuO5BwgXzwnP5m1RlOw8VC3pM
	Zsqljjq3ID7c8w6Wm7WXC0Mcxoq+OqmNEfVD15PQDBEdA3LyiqpWxIIh0kO4nnCg0VSho33GJ2Y
	1hYmamy68I41bqH78evGaWEzpHoGkB4kXUOjJYg08ECNX2GpmJieyBmBgXY9mnl9HsN6EWJjKpt
	Zgo8HiE91x8kGv
X-Received: by 2002:a05:600c:628c:b0:4ba:7e6:53d6 with SMTP id 5b1f17b1804b1-4bb55ae78c1mr42228255e9.33.1794568515246;
        Fri, 13 Nov 2026 03:15:15 -0800 (PST)
X-Received: by 2002:a05:600c:628c:b0:4ba:7e6:53d6 with SMTP id 5b1f17b1804b1-4bb55ae78c1mr42227635e9.33.1794568514691;
        Fri, 13 Nov 2026 03:15:14 -0800 (PST)
Received: from fstornio-thinkpadx1carbongen11.remote.csb ([130.25.253.240])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb56f8d054sm29531115e9.3.2026.11.13.03.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 03:15:14 -0800 (PST)
From: Filippo Storniolo <fstornio@redhat.com>
Date: Fri, 13 Nov 2026 12:14:34 +0100
Subject: [PATCH can-next v4 2/3] can: store socket pointers in struct
 netns_can
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
Message-Id: <20261113-feat-can-diag-v4-2-c28842c74c95@redhat.com>
References: <20261113-feat-can-diag-v4-0-c28842c74c95@redhat.com>
In-Reply-To: <20261113-feat-can-diag-v4-0-c28842c74c95@redhat.com>
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
 include/linux/can/core.h | 11 ++++++++++
 include/net/netns/can.h  |  6 ++++++
 net/can/Makefile         |  2 ++
 net/can/af_can.c         | 53 ++++++++++++++++++++++++++++++++++++++++++++++++
 net/can/bcm.c            |  2 ++
 net/can/isotp.c          |  2 ++
 net/can/j1939/socket.c   |  2 ++
 net/can/raw.c            |  2 ++
 8 files changed, 80 insertions(+)

diff --git a/include/linux/can/core.h b/include/linux/can/core.h
index effb5c31ef40..ae3cfa537ea8 100644
--- a/include/linux/can/core.h
+++ b/include/linux/can/core.h
@@ -62,4 +62,15 @@ extern int can_send(struct sk_buff *skb, int loop);
 void can_set_skb_uid(struct can_skb_ext *csx);
 void can_sock_destruct(struct sock *sk);
 
+/* function prototypes for the CAN diag module */
+#if IS_ENABLED(CONFIG_CAN_DIAG)
+void lock_can_diag_mutex(struct net *net) __acquires(&net->can.sklist_lock);
+void unlock_can_diag_mutex(struct net *net) __releases(&net->can.sklist_lock);
+void can_add_sock_sklist(struct sock *sk);
+void can_remove_sock_sklist(struct sock *sk);
+#else
+static inline void can_add_sock_sklist(struct sock *sk) {};
+static inline void can_remove_sock_sklist(struct sock *sk) {};
+#endif
+
 #endif /* !_CAN_CORE_H */
diff --git a/include/net/netns/can.h b/include/net/netns/can.h
index 54f23681e0d4..691dcb808b3a 100644
--- a/include/net/netns/can.h
+++ b/include/net/netns/can.h
@@ -36,6 +36,12 @@ struct netns_can {
 
 	/* CAN GW per-net gateway jobs */
 	struct hlist_head cgw_list;
+
+#if IS_ENABLED(CONFIG_CAN_DIAG)
+	/* CAN diag support */
+	struct mutex sklist_lock;
+	struct hlist_head sklist __guarded_by(&sklist_lock);
+#endif
 };
 
 #endif /* __NETNS_CAN_H__ */
diff --git a/net/can/Makefile b/net/can/Makefile
index 58f2c31c1ef3..7116c8c7f331 100644
--- a/net/can/Makefile
+++ b/net/can/Makefile
@@ -3,6 +3,8 @@
 #  Makefile for the Linux Controller Area Network core.
 #
 
+CONTEXT_ANALYSIS := y
+
 obj-$(CONFIG_CAN)	+= can.o
 can-y			:= af_can.o
 can-$(CONFIG_PROC_FS)	+= proc.o
diff --git a/net/can/af_can.c b/net/can/af_can.c
index b4255fc570aa..6ee035fc14af 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -111,6 +111,46 @@ static inline void can_put_proto(const struct can_proto *cp)
 	module_put(cp->prot->owner);
 }
 
+#if IS_ENABLED(CONFIG_CAN_DIAG)
+void lock_can_diag_mutex(struct net *net)
+	__acquires(&net->can.sklist_lock)
+{
+	mutex_lock(&net->can.sklist_lock);
+}
+EXPORT_SYMBOL(lock_can_diag_mutex);
+
+void unlock_can_diag_mutex(struct net *net)
+	__releases(&net->can.sklist_lock)
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
@@ -174,6 +214,8 @@ static int can_create(struct net *net, struct socket *sock, int protocol,
 		sock_put(sk);
 		sock->sk = NULL;
 	} else {
+		can_add_sock_sklist(sk);
+
 		sock_prot_inuse_add(net, sk->sk_prot, 1);
 	}
 
@@ -831,6 +873,12 @@ EXPORT_SYMBOL(can_proto_unregister);
 static int can_pernet_init(struct net *net)
 {
 	spin_lock_init(&net->can.rcvlists_lock);
+
+#if IS_ENABLED(CONFIG_CAN_DIAG)
+	scoped_guard(mutex_init, &net->can.sklist_lock)
+		INIT_HLIST_HEAD(&net->can.sklist);
+#endif
+
 	net->can.rx_alldev_list = kzalloc_obj(*net->can.rx_alldev_list);
 	if (!net->can.rx_alldev_list)
 		goto out;
@@ -875,6 +923,11 @@ static void can_pernet_exit(struct net *net)
 	kfree(net->can.rx_alldev_list);
 	kfree(net->can.pkg_stats);
 	kfree(net->can.rcv_lists_stats);
+
+#if IS_ENABLED(CONFIG_CAN_DIAG)
+	scoped_guard(mutex, &net->can.sklist_lock)
+		WARN_ON_ONCE(!hlist_empty(&net->can.sklist));
+#endif
 }
 
 /* af_can module init/exit functions */
diff --git a/net/can/bcm.c b/net/can/bcm.c
index 7bd2aa39777a..512faa7a62b6 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -1910,6 +1910,8 @@ static int bcm_release(struct socket *sock)
 	if (!sk)
 		return 0;
 
+	can_remove_sock_sklist(sk);
+
 	net = sock_net(sk);
 	bo = bcm_sk(sk);
 
diff --git a/net/can/isotp.c b/net/can/isotp.c
index 7a90ba3f1cf1..1141c4757082 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1468,6 +1468,8 @@ static int isotp_release(struct socket *sock)
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
index f14270b56f52..7f99af2548b6 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -442,6 +442,8 @@ static int raw_release(struct socket *sock)
 	ro = raw_sk(sk);
 	net = sock_net(sk);
 
+	can_remove_sock_sklist(sk);
+
 	spin_lock(&raw_notifier_lock);
 	while (raw_busy_notifier == ro) {
 		spin_unlock(&raw_notifier_lock);

-- 
2.56.0

