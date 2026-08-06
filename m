Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1632E37F310
	for <linux-can@vger.kernel.org>; Thu,  6 Aug 2026 13:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786023356; cv=none; b=PH4pTHdYo9r/sJR4ykXMMO0ty7diAAFsQtcBk2HQ8Cg2+8Ca9IF0mRZ4zIyrsgEgrxJvtxFUa/ERT1GzIYVZTDdNxI/t7n2pkqQUoEfALdtLkamfrBTOIuARQmjgRItGhlBbk/mzPxs593ReTTzSPUP5gL0tfFOa/TE9oex+TD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786023356; c=relaxed/simple;
	bh=I9Tpewx0y4avoLQ3T21AWTGQ4e2DoCZBg9FxbxfK5VU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lu5BpK6wrzhfkG8S5jZujowUKKv/rcjVkOujIRFxALrmP0RDesf2wFoKGrDbA40YpOZjW/h/ZDXUdvmdJ1LEOeKyC5OfsqnTDBoCOUP1CLZ/s6y22ZlKYkV8FN95ceTzI1JkUgoRThgV+dNGzxA3p8ypQGlfI3WpP6wJatpZqmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AxIFh+d5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fQqpVTAc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AxIFh+d5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fQqpVTAc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786023345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G5NLj39QWLt6tSiEKmf3W33O7WHFW7BLbLj5+zXxhEY=;
	b=AxIFh+d5FsUCu28OMBteOcewsseTcCQAOQgonCw0/6XGsQWo4z+9zbk3urDsJbyRAoWJM6
	8OsShHv1jLI+oKZ4Kev59lv1gSM0V065U2X25DDcO6Ar/FmUVyHPVxxr5EIHOI8aPCy+21
	PH6QWnLL/V+STW4z13sMhXkBgGrJX3o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-qDKgbYJSOKq-mvglDcVyBA-1; Thu, 06 Aug 2026 09:35:43 -0400
X-MC-Unique: qDKgbYJSOKq-mvglDcVyBA-1
X-Mimecast-MFC-AGG-ID: qDKgbYJSOKq-mvglDcVyBA_1786023342
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4956c1655c3so12415305e9.0
        for <linux-can@vger.kernel.org>; Thu, 06 Aug 2026 06:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786023341; x=1786628141; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G5NLj39QWLt6tSiEKmf3W33O7WHFW7BLbLj5+zXxhEY=;
        b=fQqpVTAcS41c/BdnYAzHWCd7eomnrb6GvAQHiHdkqiCBiOB7hsJ5ovvd88bLGnqvUQ
         OziA/ybP5gUkAYX8pOyYFE59IxQ6qKfmHbXHm5dw9w3OiwM0NfUwnaho9wpxqlEDbUjQ
         teMvR8erLgVkYTn81ZszvF89tcU3o2LwqTNQVYDJNbZ+Isthzd20HuoZCv9qKHqc8zW9
         /4X4lkafVbymbovQp5fIVS1aOYV4fjg6mjgOi35uWuRPaiMJxsHeEscTjW/WbhsLoC5/
         jpxOfh7JOUr6MGM9kXx159vNazDx4DK0gbl7jUBsVHwlUPAZXTsaEUXVgB2OUs7K2gGV
         /c4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786023341; x=1786628141;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G5NLj39QWLt6tSiEKmf3W33O7WHFW7BLbLj5+zXxhEY=;
        b=BrDsDOSSxNsUqZNFNuejPukAiXuNfL+WB8ScLoiWPU3qPFBRfcRxFaKhFFB7Oao9Rl
         /6qMl24XF1vGC4MIkqqCpTtVn9VgRY8WOe6OoH0jf0rokIOlHFJb8qcBTCct+ZAKipQy
         osq19409TTAH//xM+ufy3+vheZIs/9X3JDnbvVwRPwIAv2PqCiZLu75p7Q779+ggBFAc
         nkUJjvifXxDXm/HqJqOWtU2gtYGBJYWiF22WYSXcHSN9nXKQnXBbaXsIMOWHcc+UxTUh
         aoiXw8RAEoqwox9sb0tklcf1H8pH9+xfAO3AjRBbmiGyRxrn0feZjeM5RgaPUQI3vXqW
         mmbg==
X-Gm-Message-State: AOJu0YyK283bI8gGVi9798WOH06lcm/d2qZaGcYqGONghypxD9BsTrJX
	3+Nn8N4caWSwdxz7933/HwfnCzHsN2fKAtChA7DXPnrUtpFoWNfWZ9ZyMq3hDrAVPqzaqwzTyD9
	+qBozCMhoi2uS4w9eQl2M3CkHk6jYT9pWrUTRxIzzbMTPO5kM2fU8I78qO1idzg==
X-Gm-Gg: AR+sD13iBoJIG4fXu0EkyGokASV0LwC/Kjpl4W//wLvOFM+/KpUGM6anwTUUj3nHT+D
	35R9KShQBrLns7ZG3p1/NamuYyGq8ea46L+9Zw7ZFqEGShkrNzEr/uLrfHpJ0Cy96h0rCTq5Xkl
	6uHYRv3hQqZ/LmRxpH+xXo0e+C9O9JNn164xK9gv9mXC9Y3pXbGe54PDtWmhPCR5xqi/YIhFx6W
	219JwdRAMWJs+q2nqnnMrJ9KP9pflaqVc5JzM9LqciWfpzeZGzVAX9amyCQfieCDRY8ogkVG7b0
	/MFYDx8zrOsH2a7SmWNLX35+agh+mPn6cMtKsk42j2EGlYahepeQfyjczi32XJoSscOryMiYIs6
	pcC+mQ1zk7bvNkKExmeKow971CKyl2N2/vEpURrCBrc11hUYBfcnu4pVyShE5dOhX7UYUECDssQ
	2PDRHnXA==
X-Received: by 2002:a05:600c:1913:b0:499:5282:f8d1 with SMTP id 5b1f17b1804b1-4995282f8dfmr95258205e9.12.1786023341371;
        Thu, 06 Aug 2026 06:35:41 -0700 (PDT)
X-Received: by 2002:a05:600c:1913:b0:499:5282:f8d1 with SMTP id 5b1f17b1804b1-4995282f8dfmr95256995e9.12.1786023340792;
        Thu, 06 Aug 2026 06:35:40 -0700 (PDT)
Received: from fstornio-thinkpadx1carbongen11.remote.csb (host-87-1-27-205.retail.telecomitalia.it. [87.1.27.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49954246f9dsm75112735e9.15.2026.08.06.06.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 06:35:40 -0700 (PDT)
From: Filippo Storniolo <fstornio@redhat.com>
Date: Thu, 06 Aug 2026 15:14:15 +0200
Subject: [PATCH can-next v2 3/3] can: add can diag interface
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-feat-can-diag-v2-3-832597ee4cb9@redhat.com>
References: <20260806-feat-can-diag-v2-0-832597ee4cb9@redhat.com>
In-Reply-To: <20260806-feat-can-diag-v2-0-832597ee4cb9@redhat.com>
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

The userspace ABI is defined in <linux/can_diag.h> and includes
netlink request and response structs.  The request queries open
can sockets and the response contains socket information fields
including the interface index for bound sockets, inode number,
transport protocol etc.

Support can be added later by extending can_diag_dump().

Suggested-by: Davide Caratti <dcaratti@redhat.com>
Signed-off-by: Filippo Storniolo <fstornio@redhat.com>
---
 MAINTAINERS                   |   1 +
 include/uapi/linux/can/diag.h |  55 +++++++++++++
 net/can/Kconfig               |  10 +++
 net/can/Makefile              |   3 +
 net/can/diag.c                | 185 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 254 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 932ea1db048e..178caa25a6d2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5827,6 +5827,7 @@ F:	include/net/can.h
 F:	include/net/netns/can.h
 F:	include/uapi/linux/can.h
 F:	include/uapi/linux/can/bcm.h
+F:	include/uapi/linux/can/diag.h
 F:	include/uapi/linux/can/gw.h
 F:	include/uapi/linux/can/isotp.h
 F:	include/uapi/linux/can/raw.h
diff --git a/include/uapi/linux/can/diag.h b/include/uapi/linux/can/diag.h
new file mode 100644
index 000000000000..7f99f85c4242
--- /dev/null
+++ b/include/uapi/linux/can/diag.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+
+#ifndef _UAPI_CAN_DIAG_H_
+#define _UAPI_CAN_DIAG_H_
+
+#include <linux/types.h>
+#include <linux/can.h>
+
+/* Request */
+struct can_diag_req {
+	__u8	sdiag_family;	/* must be AF_CAN */
+	__u8	sdiag_protocol; /* for future filtering of transport protocols */
+	__u16	pad;
+	__u32	cdiag_states;
+	__u32	cdiag_ino;
+	__u32	cdiag_show;
+	__u32	cdiag_cookie[2];
+};
+
+enum {
+	CAN_DIAG_UNSPEC,
+	CAN_DIAG_UID,
+	CAN_DIAG_ISOTP_ADDR,
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
+struct can_diag_isotp_addr {
+	canid_t tx_id;
+	canid_t rx_id;
+};
+
+struct can_diag_j1939_addr {
+	__u64	name;
+	__u32	pgn;
+	__u8	addr;
+};
+
+#endif /* _UAPI_CAN_DIAG_H_ */
diff --git a/net/can/Kconfig b/net/can/Kconfig
index abbb4be7ad21..ed210d62da7c 100644
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
+	  If unsure, say Y.
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
index 000000000000..e9132ba3f8cc
--- /dev/null
+++ b/net/can/diag.c
@@ -0,0 +1,185 @@
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
+static int sk_diag_fill(struct sock *sk, struct sk_buff *skb,
+			struct can_diag_req *req, /* will be used for filtering */
+			struct user_namespace *user_ns,
+			u32 portid, u32 seq, u32 flags, u64 sk_ino)
+{
+	struct sockaddr_can can_addr;
+	struct can_diag_msg *rep;
+	struct nlmsghdr *nlh;
+	uid_t uid;
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
+	uid = from_kuid_munged(user_ns, sk_uid(sk));
+	err = nla_put(skb, CAN_DIAG_UID, sizeof(uid_t), &uid);
+	if (err < 0)
+		goto cancel_nlmsg_err;
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
+		struct can_diag_isotp_addr isotp_addr;
+
+		memset(&isotp_addr, 0, sizeof(isotp_addr));
+
+		isotp_addr.tx_id = can_addr.can_addr.tp.tx_id;
+		isotp_addr.rx_id = can_addr.can_addr.tp.rx_id;
+
+		err = nla_put(skb, CAN_DIAG_ISOTP_ADDR, sizeof(struct can_diag_isotp_addr),
+			      &isotp_addr);
+	}
+		break;
+	case CAN_J1939:
+	{
+		struct can_diag_j1939_addr j1939_addr;
+
+		memset(&j1939_addr, 0, sizeof(j1939_addr));
+
+		j1939_addr.name = can_addr.can_addr.j1939.name;
+		j1939_addr.pgn = can_addr.can_addr.j1939.pgn;
+		j1939_addr.addr = can_addr.can_addr.j1939.addr;
+
+		err = nla_put(skb, CAN_DIAG_J1939_ADDR, sizeof(struct can_diag_j1939_addr),
+			      &j1939_addr);
+	}
+		break;
+	default:
+		break;
+	}
+
+	if (err < 0)
+		goto cancel_nlmsg_err;
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

