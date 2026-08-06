Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABD933ADAC
	for <linux-can@vger.kernel.org>; Thu,  6 Aug 2026 13:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786023353; cv=none; b=ljoS4lJdj1oVc0Qfe/N66oM15IE4UUciiv2DxIrh3/7H8wjMBovZZVRQnkcA8GU+u1OMvKXbqxrkRiCuitxx79JdC0sfXbmADjUectimhc+i7PIytloPTv6XWdwsR02rxevXP7HGmrSrEwqezWR1h0NpiLLbU4b9oucjKdcawi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786023353; c=relaxed/simple;
	bh=T6lwdbp/f7d3l5R6Tp/DBUn/9vIG4N1qfYKJnbLceuQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XITCgmMu2TTibUGPki9TiIrxBeWFY+JwJ4C8IMzgEYyDw8JNCERVCh/MBHPG19rRD6lD5bIYc8Q5w0GHGyiomhTU4nZ9MMVtyUsJaWy8y5jX+LO5ZSyX762HauNgGY+WwMaGHSjTgQbTZAFOYeudPW67mWFImUfDVvoEcwTCXGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jm3efW01; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tIUnteU9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jm3efW01";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tIUnteU9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786023342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xQrWpXa4aAYRQzOonA++KI/CRnpBkGZmTSo2XpeCk4A=;
	b=Jm3efW01En3iVvcBGK+qnOd1IqxYdHXfwc/+uxovDv4Q4MQ8sD8TqS6NmMAonMxv5Uz7aY
	HJ2TrFQocA+POXOzcE5ZUhbhlLZ8QEUdM79s3N/xZeriMUd7gPR29EqzNkIaY4KH8HolHX
	958ytZQjtv4d7hyLrkejrBe2r2eK+oA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-c6l9FpwtOg-bLnMZtGiziw-1; Thu, 06 Aug 2026 09:35:41 -0400
X-MC-Unique: c6l9FpwtOg-bLnMZtGiziw-1
X-Mimecast-MFC-AGG-ID: c6l9FpwtOg-bLnMZtGiziw_1786023340
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4994aebe932so22042535e9.3
        for <linux-can@vger.kernel.org>; Thu, 06 Aug 2026 06:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786023340; x=1786628140; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xQrWpXa4aAYRQzOonA++KI/CRnpBkGZmTSo2XpeCk4A=;
        b=tIUnteU9MgUfx9Jyh3/tj6hGs4owzEtYZUDyo4VHjOo4xBuKTmJeU6DRT7i6N1zUuT
         AgVP74pdvP0iERC7/ha+OnuwMKR2TT36VOhbqVS5XTuWGoMtx/NwQOlo15oAPtbz8ZFt
         iw6fItasgc7Uk4lBg35/6u2MpH8+AyIJUEWuR7klNXyAhg0+V+jKIWV8skwY615LIdU5
         LfMhwYAzPDKNUlm94ePjtJSms7YchOiKhdydy5FJLOY7WoSsDPboP8bFICwSPnCTKK3y
         198nPeSPMRpb/VqNF7p4CVogCnXTEhgSVpXllBxk7/F/dYhPeLoo7201dCwf2jQkyi/h
         b/0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786023340; x=1786628140;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xQrWpXa4aAYRQzOonA++KI/CRnpBkGZmTSo2XpeCk4A=;
        b=kw00H2lDiXm+O1AjzPzXGTlrpCv+ALwZn85JYMHTf37Csyiv/t0kzOqXTsF+DzM8dC
         jqIFzLrPQK/Nfgv0lXSo36RP8xdJx5rlJOp5hAHdUwAiSPcYbK/Pi5cADCw5qBUTaj6d
         JTBRkkZdi8vpCVNsPXWbc4LDkoVDy+t5SgCRS9KSqhVMbaYdiPput8feCRQcCj1S8Rxt
         36uF6icsqosrMW6lPMpbuYCyk5v4bxjuLCWknEM0KLNmCcM027fgmHtPpHoAw/4rpnhf
         RTKb1M86aHZyLFeuYZ/GZSmgDTBgKuBSmXULLwihUkZHyGPErk7DUGnvCJ7AaavQNYoQ
         wCoA==
X-Gm-Message-State: AOJu0Yx3aLKN0tDWhBgjp491dVixwPoT8w6Uf3TF1F/Sp9iwMWb3IrMk
	Oq9EBX8GsN0YP18yXQ6lHZQRyLIkl5V/XKlQE+/CNSjwddS8GsUIlx5dQe4rxsMVKwAA0agvU+G
	nwtMOf2udnmMirCvUHochNeSYXglCPHUcorfK3bN4kp82FK0cAEjWrF2y/e/njQ==
X-Gm-Gg: AR+sD1356oZOkmy5a/iIQJ3D9Xpt6Whgxw3q2q54bLP2UCjnrxkOo09vlMuyIFhxaSJ
	9cH3HNCbQLHN6zVtpFtEr9V0DwLvDFrN9XzQhaTiy0NadSueMrT9AX9ZbNG7NCfKdzZb3X9nEQ6
	mLARusil3BfdA1J5Tfd2uBTLTkhev7vqy5WH9mMTcSx/K1kjDBGCUc7XV82uw8wOCXq2aJt9F2l
	Onjjy4xx8jfqCNaw2Dg53pAhzpR7j+tab0OBufJqGsk/lsYQSKkG/XWhuZVUI7jKnH/RYO9y4/N
	HI6rHq8OyZySjsiAx4fNWxv9YFlHLQbobkblP6thwG/GUf5gSkMf8p9rYKczFDz0zLCNWx077On
	gQuMSu4cxsCCDzouuF2ccA8y+4W+uGVChmTPjK4zzrHvzYEJ75QuIeOXkUrNwA3v5x7qmvckX6F
	+3sFIzLg==
X-Received: by 2002:a05:600c:8b75:b0:495:4fd4:619b with SMTP id 5b1f17b1804b1-4994e70a6eamr240658865e9.1.1786023339798;
        Thu, 06 Aug 2026 06:35:39 -0700 (PDT)
X-Received: by 2002:a05:600c:8b75:b0:495:4fd4:619b with SMTP id 5b1f17b1804b1-4994e70a6eamr240657345e9.1.1786023339248;
        Thu, 06 Aug 2026 06:35:39 -0700 (PDT)
Received: from fstornio-thinkpadx1carbongen11.remote.csb (host-87-1-27-205.retail.telecomitalia.it. [87.1.27.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49954246f9dsm75112735e9.15.2026.08.06.06.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 06:35:38 -0700 (PDT)
From: Filippo Storniolo <fstornio@redhat.com>
Date: Thu, 06 Aug 2026 15:14:14 +0200
Subject: [PATCH can-next v2 2/3] af_can: store socket pointers in struct
 netns_can
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-feat-can-diag-v2-2-832597ee4cb9@redhat.com>
References: <20260806-feat-can-diag-v2-0-832597ee4cb9@redhat.com>
In-Reply-To: <20260806-feat-can-diag-v2-0-832597ee4cb9@redhat.com>
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
index 3287232e3cad..5132f5c89b7c 100644
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
+#define can_add_sock_sklist(sk)
+#define can_remove_sock_sklist(sk)
+#endif
+
 #endif /* !_CAN_CORE_H */
diff --git a/include/net/netns/can.h b/include/net/netns/can.h
index 48b79f7e6236..bcafff5e6669 100644
--- a/include/net/netns/can.h
+++ b/include/net/netns/can.h
@@ -36,6 +36,12 @@ struct netns_can {
 
 	/* CAN GW per-net gateway jobs */
 	struct hlist_head cgw_list;
+
+#if IS_ENABLED(CONFIG_CAN_DIAG)
+	/* CAN diag support */
+	struct mutex		sklist_lock;
+	struct hlist_head	sklist;
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

