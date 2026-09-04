Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704854AA59B
	for <linux-can@vger.kernel.org>; Fri,  4 Sep 2026 14:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788531241; cv=none; b=PSlja5l3qCn9lUUqiSP/bhyGg6aq7cO5YMlHhcJ2ot9SCr88M24FCgFdnz6IQ6eQ/MqcM72OugJhSfO0Oa20qEcjzjK4M4grUIF4uM5sHBe7iqtlhhLN9RhAL113nqJUO+6NZpE2Im2/jmNPKn9/m+k8RL7+PKGi4wEDFlCw7yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788531241; c=relaxed/simple;
	bh=CMt5OxzQo9gUjs46LR/ZRw33RyxboQD+dZSGDnunS9E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HSOM0kjFMmc3NUr1yblGKhHW603PYmvTqGdupsX6xTZeyOweF59IOTzDirWlpY+4wOuemYhIATblLmqHYQWP399Gg3rIIehtm0USgKJZ28c8uyx0OVSaLq96+6EdVR/JJQr+dmoEE6wsGRBPPhOguvMSBpvwPrL8pL1BuYAVDTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ijYwbFG5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KslGUAeA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ijYwbFG5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KslGUAeA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788531238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r+a+Ui2IG/IYjZBcZJW46rJTJn9gybEC3Akztqk6iMI=;
	b=ijYwbFG5VqWF7/1/npBUkGnSglBOlDOZHsEKETSOh0FqwAjnGNLsxDX0xhF5TjRBk59OCQ
	Vjg68osfcMW29eVmJPaM7bCe2+eci+oElDlsZLmRrpsomSwk4rBQkq2xWxghRninhEWM+h
	LHAdpZELyx1mc90HHzVjf6k/G2PjMCA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-efLCOFDJMVK0_r_1e4dPGg-1; Fri, 04 Sep 2026 10:13:57 -0400
X-MC-Unique: efLCOFDJMVK0_r_1e4dPGg-1
X-Mimecast-MFC-AGG-ID: efLCOFDJMVK0_r_1e4dPGg_1788531235
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49cdc4080ddso6562865e9.1
        for <linux-can@vger.kernel.org>; Fri, 04 Sep 2026 07:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788531235; x=1789136035; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r+a+Ui2IG/IYjZBcZJW46rJTJn9gybEC3Akztqk6iMI=;
        b=KslGUAeAYKC5Q7K5gZLP/hjgnWmHt1cRjCL9+aMuPYMZxiCFtPqSwzA7JzrHk8xBRN
         r0uVBqQCqtmJ5s4zvrvGtQXrdAowD1BlChBRxXruYrzTEccZuQiK/Z9wvpY6YxpdOn46
         D94oBgA+CuSUqqqJiF9ZB+paKp6Y/+3p2pIAaLsx9qG7hPsdu1XaDemaTDdp0OlhipPi
         rZODPCRVraY3UqIV7EZDYWa45Ew6tVLFEReVpOdOQMsn5ltxqOEazoxDRzRtszi4GSHZ
         EVxyOkbm56vSjn0G1MhOUl+ALV3plHzDR+U+ekx0J24pdMw3zh+neBTMfbkq3Z5Y+Rcn
         U3lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788531235; x=1789136035;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r+a+Ui2IG/IYjZBcZJW46rJTJn9gybEC3Akztqk6iMI=;
        b=O8V5PKrO1nJ5QsBT3441JhKVX9VrDXJ1JlX7Qd1vouIMnCzh21uGomzaZ7zWjC9kr0
         +xbluSuLmrhO5F3T9NnUGyy6UMhYd64RpxM+KaZo+yYKUgJSAPyD8u8h5WkebXdlLMvR
         N4o9lqN7G35LtU5CgSznDoYLdYaVWNtd2rqULUNC1xP15J0Qh0G6XjpspCJMEyReYc6B
         h8hhsWbNshK82eiVsko5yEKwAgHO0SuqKcvBelxez/DWp+YNRiBQC6rmDEEVTtOAExMV
         ud579QcQywthGIT+F27FsHFSs5jsO3QhNMBGlPt20EzWu9Sv0NXhQndk76M358wvmiXW
         nf9A==
X-Gm-Message-State: AFuF++kGnrPnl3MWZ5/wjuVQSoesJe1WJ6OydHr0atjwHSexu6udMHdv
	rETucvWZaWEAVtbDjd1mcs1eux013U+2Ae+Yxt8ofTlgLt/ths2daO+nVmv0ZJHq7K7EaVIC0Y5
	Kaf0nFcz9rzWBc7K29buGENGAnjCkwMEZPfNkc5kQlbsaUkaiml5vPS0TgXPcDw==
X-Gm-Gg: AYBFou2r0w/eAT92FHXsOsBcZJl5XLaaF9YTiLNTIEz4Tb14WREridRcjbGscyNXL5w
	U/V6nDT9FGvsfMHRJONxtjpZKer+n7tjWfD6ngUrrEZovz7m/TBpnjAUpDCu2+XlkG/5rpEB/FA
	Oe0T559EXNXokKz/qP5MXzmOaRaMIASyTrtd+qsbqdBd+7nrhWYtQAtEGB6jylupoN5qC8qpW7Z
	0GUDQ75AAZsHPTtTzfALxbWk8CXAWKv2CSh6cIHd7GfSl5PL3t8Q71nUJIb3ozNrQ200KQdy1XR
	RXHhkY/4BpL9Q1nXvbufqRVemLdi9plIwwJGFzuzw95VJ9LrxWwsqPKPrPtkeeoSvJJHCxzuwbe
	oXubeepPWxLjYfpZZ1J2TMX98av9gqXGwG9DoAus=
X-Received: by 2002:a05:600c:3105:b0:499:59fd:dbfc with SMTP id 5b1f17b1804b1-49cf82bea15mr50377755e9.1.1788531235254;
        Fri, 04 Sep 2026 07:13:55 -0700 (PDT)
X-Received: by 2002:a05:600c:3105:b0:499:59fd:dbfc with SMTP id 5b1f17b1804b1-49cf82bea15mr50377045e9.1.1788531234715;
        Fri, 04 Sep 2026 07:13:54 -0700 (PDT)
Received: from fstornio-thinkpadx1carbongen11.remote.csb ([130.25.253.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf7703cefsm99744845e9.5.2026.09.04.07.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 07:13:54 -0700 (PDT)
From: Filippo Storniolo <fstornio@redhat.com>
Date: Fri, 04 Sep 2026 16:12:57 +0200
Subject: [PATCH can-next v3 3/3] can: add can diag interface
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-feat-can-diag-v3-3-bdcebf07b373@redhat.com>
References: <20260904-feat-can-diag-v3-0-bdcebf07b373@redhat.com>
In-Reply-To: <20260904-feat-can-diag-v3-0-bdcebf07b373@redhat.com>
To: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Robin van der Gracht <robin@protonic.nl>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, 
 Urs Thuermann <urs.thuermann@volkswagen.de>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-can@vger.kernel.org, Davide Caratti <dcaratti@redhat.com>, 
 Filippo Storniolo <fstornio@redhat.com>
X-Mailer: b4 0.14.3

Add the can_diag interface for querying sockets from userspace.
ss(8) tool can use this interface to list open sockets.

The userspace ABI is defined in <linux/can/diag.h> and includes
netlink request and response structs.  The request queries open
can sockets and the response contains socket information fields
including the interface index for bound sockets, inode number,
transport protocol etc.

Support can be added later by extending can_diag_dump().

Suggested-by: Davide Caratti <dcaratti@redhat.com>
Signed-off-by: Filippo Storniolo <fstornio@redhat.com>
---
 MAINTAINERS                   |   1 +
 include/uapi/linux/can/diag.h |  50 +++++++++++
 net/can/Kconfig               |  10 +++
 net/can/Makefile              |   3 +
 net/can/diag.c                | 203 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 267 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b23fb6f2f4ef..c718d7477fa7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5859,6 +5859,7 @@ F:	include/net/can.h
 F:	include/net/netns/can.h
 F:	include/uapi/linux/can.h
 F:	include/uapi/linux/can/bcm.h
+F:	include/uapi/linux/can/diag.h
 F:	include/uapi/linux/can/gw.h
 F:	include/uapi/linux/can/isotp.h
 F:	include/uapi/linux/can/raw.h
diff --git a/include/uapi/linux/can/diag.h b/include/uapi/linux/can/diag.h
new file mode 100644
index 000000000000..f22103e7bf90
--- /dev/null
+++ b/include/uapi/linux/can/diag.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+
+#ifndef _UAPI_CAN_DIAG_H_
+#define _UAPI_CAN_DIAG_H_
+
+#include <linux/types.h>
+#include <linux/can.h>
+#include <linux/const.h>
+
+/* Request */
+struct can_diag_req {
+	__u8	sdiag_family;	/* must be AF_CAN */
+	__u8	pad;
+	__u16	sdiag_protocol; /* for future filtering of transport protocols */
+	__u32	cdiag_states;
+	__u32	cdiag_ino;
+	__u32	cdiag_show;
+	__u32	cdiag_cookie[2];
+};
+
+#define CDIAG_SHOW_UID		_BITUL(0) /* show socket's UID */
+
+enum {
+	CAN_DIAG_UNSPEC,
+	CAN_DIAG_UID,
+	CAN_DIAG_ISOTP_TX_ID,
+	CAN_DIAG_ISOTP_RX_ID,
+	CAN_DIAG_J1939_NAME,
+	CAN_DIAG_J1939_PGN,
+	CAN_DIAG_J1939_ADDR,
+
+	__CAN_DIAG_MAX,
+};
+
+#define CAN_DIAG_MAX (__CAN_DIAG_MAX - 1)
+
+/* Response */
+struct can_diag_msg {
+	__u8	cdiag_family;	/* AF_CAN */
+	__u8	cdiag_state;
+	__u16	cdiag_protocol;
+	__u16	cdiag_type;
+	__u16	pad16;
+	__u32	cdiag_cookie[2];
+	__s32	cdiag_ifindex;
+	__u32	pad32;
+	__u64	cdiag_ino;
+};
+
+#endif /* _UAPI_CAN_DIAG_H_ */
diff --git a/net/can/Kconfig b/net/can/Kconfig
index abbb4be7ad21..bbab2c70326b 100644
--- a/net/can/Kconfig
+++ b/net/can/Kconfig
@@ -70,4 +70,14 @@ config CAN_ISOTP
 	  as needed e.g. for vehicle diagnosis (UDS, ISO 14229) or IP-over-CAN
 	  traffic.
 
+config CAN_DIAG
+	tristate "CAN socket monitoring interface"
+	depends on CAN
+	default m
+	help
+	  Support for CAN socket monitoring interface used by the ss tool.
+	  If unsure, say M.
+
+	  Enable this module so userspace applications can query open sockets.
+
 endif
diff --git a/net/can/Makefile b/net/can/Makefile
index 58f2c31c1ef3..c0ddeb9a012c 100644
--- a/net/can/Makefile
+++ b/net/can/Makefile
@@ -20,3 +20,6 @@ obj-$(CONFIG_CAN_J1939)	+= j1939/
 
 obj-$(CONFIG_CAN_ISOTP)	+= can-isotp.o
 can-isotp-y		:= isotp.o
+
+obj-$(CONFIG_CAN_DIAG) += can-diag.o
+can-diag-y		:= diag.o
diff --git a/net/can/diag.c b/net/can/diag.c
new file mode 100644
index 000000000000..647a94636a54
--- /dev/null
+++ b/net/can/diag.c
@@ -0,0 +1,203 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *
+ * Copyright (C) 2026 Red Hat
+ * Author: Filippo Storniolo <fstornio@redhat.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/net.h>
+#include <net/netlink.h>
+#include <linux/sock_diag.h>
+#include <linux/can.h>
+#include <linux/can/diag.h>
+#include <net/net_namespace.h>
+#include <net/sock.h>
+#include <linux/netdevice.h>
+#include <linux/user_namespace.h>
+#include <linux/can/core.h>
+
+static int sk_diag_dump_uid(struct sock *sk, struct sk_buff *skb,
+			    struct user_namespace *user_ns)
+{
+	uid_t uid = from_kuid_munged(user_ns, sk_uid(sk));
+
+	return nla_put(skb, CAN_DIAG_UID, sizeof(uid_t), &uid);
+}
+
+static int sk_diag_fill(struct sock *sk, struct sk_buff *skb,
+			struct can_diag_req *req, /* will be used for filtering */
+			struct user_namespace *user_ns,
+			u32 portid, u32 seq, u32 flags, u64 sk_ino)
+{
+	struct sockaddr_can can_addr;
+	struct can_diag_msg *rep;
+	struct nlmsghdr *nlh;
+	int err;
+
+	nlh = nlmsg_put(skb, portid, seq, SOCK_DIAG_BY_FAMILY, sizeof(*rep), flags);
+	if (!nlh)
+		return -EMSGSIZE;
+
+	rep = nlmsg_data(nlh);
+	memset(rep, 0, sizeof(struct can_diag_msg));
+
+	rep->cdiag_family = AF_CAN;
+	rep->cdiag_type = sk->sk_type;
+	rep->cdiag_ino = sk_ino;
+	rep->cdiag_protocol = sk->sk_protocol;
+	rep->cdiag_state = READ_ONCE(sk->sk_state);
+	sock_diag_save_cookie(sk, rep->cdiag_cookie);
+
+	if ((req->cdiag_show & CDIAG_SHOW_UID)) {
+		err = sk_diag_dump_uid(sk, skb, user_ns);
+		if (err < 0)
+			goto cancel_nlmsg_err;
+	}
+
+	memset(&can_addr, 0, sizeof(can_addr));
+
+	err = kernel_getsockname(sk->sk_socket, (struct sockaddr *)&can_addr);
+	if (err < 0) {
+		/* Some protocols (e.g. CAN_BCM) do not implement kernel_getsockname().
+		 * No error returned because the netlink message is still valid.
+		 */
+		if (err == -EOPNOTSUPP)
+			goto exit_no_err;
+
+		goto cancel_nlmsg_err;
+	}
+
+	rep->cdiag_ifindex = can_addr.can_ifindex;
+
+	switch (sk->sk_protocol) {
+	case CAN_ISOTP:
+	{
+		canid_t tx_id;
+		canid_t rx_id;
+
+		tx_id = can_addr.can_addr.tp.tx_id;
+		rx_id = can_addr.can_addr.tp.rx_id;
+
+		err = nla_put(skb, CAN_DIAG_ISOTP_TX_ID, sizeof(canid_t), &tx_id);
+		if (err < 0)
+			goto cancel_nlmsg_err;
+
+		err = nla_put(skb, CAN_DIAG_ISOTP_RX_ID, sizeof(canid_t), &rx_id);
+		if (err < 0)
+			goto cancel_nlmsg_err;
+	}
+		break;
+	case CAN_J1939:
+	{
+		__u64	j1939_name;
+		__u32	j1939_pgn;
+		__u8	j1939_addr;
+
+		j1939_name = can_addr.can_addr.j1939.name;
+		j1939_pgn = can_addr.can_addr.j1939.pgn;
+		j1939_addr = can_addr.can_addr.j1939.addr;
+
+		err = nla_put(skb, CAN_DIAG_J1939_NAME, sizeof(j1939_name), &j1939_name);
+		if (err < 0)
+			goto cancel_nlmsg_err;
+
+		err = nla_put(skb, CAN_DIAG_J1939_PGN, sizeof(j1939_pgn), &j1939_pgn);
+		if (err < 0)
+			goto cancel_nlmsg_err;
+
+		err = nla_put(skb, CAN_DIAG_J1939_ADDR, sizeof(j1939_addr), &j1939_addr);
+		if (err < 0)
+			goto cancel_nlmsg_err;
+	}
+		break;
+	default:
+		break;
+	}
+
+exit_no_err:
+	nlmsg_end(skb, nlh);
+	return 0;
+
+cancel_nlmsg_err:
+	nlmsg_cancel(skb, nlh);
+	return err;
+}
+
+static int can_diag_dump(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	int num = 0, s_num = cb->args[0];
+	struct can_diag_req *req;
+	struct net *net;
+	struct sock *sk;
+
+	net = sock_net(skb->sk);
+	req = nlmsg_data(cb->nlh);
+
+	lock_can_diag_mutex(net);
+	sk_for_each(sk, &net->can.sklist) {
+		if (num < s_num)
+			goto next;
+
+		if (sk_diag_fill(sk, skb, req,
+				 sk_user_ns(NETLINK_CB(cb->skb).sk),
+				 NETLINK_CB(cb->skb).portid,
+				 cb->nlh->nlmsg_seq, NLM_F_MULTI,
+				 sock_i_ino(sk)) < 0)
+			goto done;
+next:
+		num++;
+	}
+done:
+	unlock_can_diag_mutex(net);
+	cb->args[0] = num;
+
+	return skb->len;
+}
+
+static int can_diag_handler_dump(struct sk_buff *skb, struct nlmsghdr *h)
+{
+	int hdrlen = sizeof(struct can_diag_req);
+	struct net *net = sock_net(skb->sk);
+	struct can_diag_req *req;
+
+	if (nlmsg_len(h) < hdrlen)
+		return -EINVAL;
+
+	req = nlmsg_data(h);
+	if (req->sdiag_protocol)
+		return -EINVAL;
+
+	if (h->nlmsg_flags & NLM_F_DUMP) {
+		struct netlink_dump_control c = {
+			.dump = can_diag_dump
+		};
+		return netlink_dump_start(net->diag_nlsk, skb, h, &c);
+	}
+
+	return -EOPNOTSUPP;
+}
+
+static const struct sock_diag_handler can_diag_handler = {
+	.owner = THIS_MODULE,
+	.family = AF_CAN,
+	.dump = can_diag_handler_dump,
+};
+
+static int __init can_diag_init(void)
+{
+	pr_info("can: diagnostic module\n");
+	return sock_diag_register(&can_diag_handler);
+}
+
+static void __exit can_diag_exit(void)
+{
+	sock_diag_unregister(&can_diag_handler);
+}
+
+module_init(can_diag_init);
+module_exit(can_diag_exit);
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("CAN socket monitoring via SOCK_DIAG");
+MODULE_ALIAS_NET_PF_PROTO_TYPE(PF_NETLINK, NETLINK_SOCK_DIAG, AF_CAN);

-- 
2.55.0

