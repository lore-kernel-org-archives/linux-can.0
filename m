Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794568524;
	b=gnwEaHP+FE5hGgp1kwI0VuFiIt5elZNG4VwfuqdHrV2E0JDllwpHqphJkgPICy87fiwy
	 EeGZjmP3rJbc5g6FlVojEZkGi/w5OCLYv4lYB6onNCX7Nh7f/MsBYktrIJMRQLya9Sh7X
	 KkF7IMEnzvdA0Iz28b6P3kWH4rBYFfWQIt7OVgHMIjAA3rE/OCn/Gg+U3LFWGIVogHv1o
	 7I+DS3l0dFGmvSvuhvb9Hpj37o2JgQSVGBYeXYZEFneyfMUpf5hvPWNRYUSHJUd7GXllL
	 Mr+PRYodItzkfM7BsnUbqx0cp+mAnu29JDcyykdvldsitmIZLriLuZmnE6YDZtqmplg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794568524;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=ijVm9cmTTlSH5fCpSgyOqm76OQLFqefwYc64PFISs/Y=;
	b=FHQDcwccHPuQnnkheYwIO++d/ZGyj5gEh8U38nljCEvPc1CIyjHP8pFsSTAnMuVsuMJ4
	 0S6hKWerNu8NXtobglfnRsEm4HFnjbD1vrObi8KrMMnu1JIdcggoxlXsBIWEbc5mjSh7T
	 qaqaZFe20poTg4k9C6nxxZ6D2BeErzJky0GmWJ74X23c14Pg3HFqORX5pnrDHv05Nxr/J
	 oKQnznOtjmI2fu70Yk4KH1Mk1lE7C3QrmXjRYr6t63CFI+TNg44nxhwfg2Q119nwerm2Z
	 8qi8WdMyGUEIy0ov+SNY7dkQaMfM4WjgN7MgjX+EtnXvarze+jVaErw5Yr6FdbiBEyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Qg7ND1fa;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=C+gkhPy7;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F40606A333
	for <linux-can@vger.kernel.org>; Fri, 13 Nov 2026 11:15:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48F40606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Qg7ND1fa;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=C+gkhPy7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794568523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ijVm9cmTTlSH5fCpSgyOqm76OQLFqefwYc64PFISs/Y=;
	b=Qg7ND1faL5uuE/JoFfwyjV4arbqUBIWl4zbh6Tswg3t4E6QYdDvAFO0Vu+fPyUsZIAMwXV
	LjSou6nG32YYZMk3DXW0O5/mSRNe2hlchX0e6pItu5tc+MQi3K/su8pw2jIXliDcllklkQ
	6eZ8Z1ZE+X3BYowDy53dOPmMRSZ9Vp4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401--3M4zdjTNRim5pdgTnJsaw-1; Fri, 13 Nov 2026 06:15:19 -0500
X-MC-Unique: -3M4zdjTNRim5pdgTnJsaw-1
X-Mimecast-MFC-AGG-ID: -3M4zdjTNRim5pdgTnJsaw_1794568519
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4ba078abd70so4916445e9.3
        for <linux-can@vger.kernel.org>; Fri, 13 Nov 2026 03:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794568518; x=1795173318; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ijVm9cmTTlSH5fCpSgyOqm76OQLFqefwYc64PFISs/Y=;
        b=C+gkhPy7Ow4xC+wpxPgHI2gXYFavsAJ6D03xWafG+6JKWuyfC2IcU2kq0Hg3taaMI9
         ZI3VATO9NAUfPg+ddpedKRoIUw9OQOyY1TONxfJKhk/D5uti2JigliiNF7CBW8yyhSaB
         PEyaVl2slOtn3VLFblcA9eQAJCi31xHLSOvj7wJASq43TsGNZ46/InQ27fOwrG5LANrK
         3P7CqTxi5IOcVbucVPk5krZv/4VSfKYSe0pSHpKt4YpGvJcpAITlaPmDNumtb2sNk2d/
         fPSN6uBWzVWQs2x69yl/l4ljYumNiPrj4WZnbALbFKRRGI5wfrh9TYdjGlqSDx0iE/2u
         TMyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794568518; x=1795173318;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ijVm9cmTTlSH5fCpSgyOqm76OQLFqefwYc64PFISs/Y=;
        b=a7JCsnhVFqhGhYVFnLkGJvPZDSKwWfvrwPGstTGoae3wXHVJL1grLltyoT4NAf6Hmg
         ERCEh2UvEKx/Pc36lxFy3HRZTxLs1KvAD2TvDMW9L8ideDrB90538z5Hv5N1aHryqSA9
         8uaKpvKndAtgqsFCc8tkytV/DzvViYc2iTVhxWZlxM5yuUjazCXCz+b3m+aJUgS849Un
         EeKgNM3WO8qtzZH7iGBCohe5UGSlvyw0cmqncENGbDkiNTh+HWrONQAu2bNlx/PFTR75
         Kmz+EgmznSJ4jpXPv0kcZR3NlDEl63wGkdvWm7JPPET2wFK5PYYdJhSzpB3+2Wil2m8Z
         e66w==
X-Gm-Message-State: APuU4Z8/D1CUPMvYwBamt9/ZdXlkxls/4H48VwvdW3DTLzpfbNzG7q69
	wYNutmgjwTWoCG4rc7eemGtHfL6ewmslSrFEHUnIhG5URUsSzg2qnXEXJmn6gAlvXAmHCfj8xcY
	IXxVNglZqXPPPjjTSZVb9213YMxxGjZmS3lhIuBVVS2bu2HX5Swp4DwtphgFxCQ==
X-Gm-Gg: AYBFou0bB3evNfL4o4eZS4h4LVyjq/GtqWguam97vwhHNppStYRpnyusAeohVEFQUsv
	8fMtIxFDHq1WrUdAoHM7i0rA8eFWDp8PMIX1cTiO4hvLzDZDEnw/jCHdd5HX4diKj7liFzmqs0w
	Cgl+zbf056GT3X3UFoHbbfKf6peZFyBEwSyW2t0KKS+iFiqrFLMeYJ1GNZLGeD9XQARCM4XTWQb
	9jlfi4lMm5eysTirR0rlU7EVmdAEVDJjF4/ctaopJSultNsdSlyTCEzwhgwZZ0vUgZHiwaLK2hL
	EPhMEpzOIqrnx8wdImBtpxMD5Cp4tZH/Zx8sxM6py+mjXiMGpcVZy+RNDHfKhQUO6prBSD7MYjk
	82+ojHU1uE/FPH4pgskaMgsVvtnsv3+G8ygx2oWiNl/ClXnLBn65wR8+vfFVJe4GdE2s/boNSTa
	eaqw5gs4qHADgd
X-Received: by 2002:a05:600c:a012:b0:4a3:5aee:2c25 with SMTP id 5b1f17b1804b1-4bb55a907cfmr43028895e9.31.1794568518491;
        Fri, 13 Nov 2026 03:15:18 -0800 (PST)
X-Received: by 2002:a05:600c:a012:b0:4a3:5aee:2c25 with SMTP id 5b1f17b1804b1-4bb55a907cfmr43028215e9.31.1794568517967;
        Fri, 13 Nov 2026 03:15:17 -0800 (PST)
Received: from fstornio-thinkpadx1carbongen11.remote.csb ([130.25.253.240])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb56f8d054sm29531115e9.3.2026.11.13.03.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 03:15:17 -0800 (PST)
From: Filippo Storniolo <fstornio@redhat.com>
Date: Fri, 13 Nov 2026 12:14:35 +0100
Subject: [PATCH can-next v4 3/3] can: add can diag interface
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
Message-Id: <20261113-feat-can-diag-v4-3-c28842c74c95@redhat.com>
References: <20261113-feat-can-diag-v4-0-c28842c74c95@redhat.com>
In-Reply-To: <20261113-feat-can-diag-v4-0-c28842c74c95@redhat.com>
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
 net/can/Kconfig               |   9 ++
 net/can/Makefile              |   3 +
 net/can/diag.c                | 204 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 267 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c583367c88bc..71e98ca362ad 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6029,6 +6029,7 @@ F:	include/net/can.h
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
index abbb4be7ad21..6766efe83630 100644
--- a/net/can/Kconfig
+++ b/net/can/Kconfig
@@ -70,4 +70,13 @@ config CAN_ISOTP
 	  as needed e.g. for vehicle diagnosis (UDS, ISO 14229) or IP-over-CAN
 	  traffic.
 
+config CAN_DIAG
+	tristate "CAN socket monitoring interface"
+	default m
+	help
+	  Support for CAN socket monitoring interface used by the ss tool.
+	  If unsure, say M.
+
+	  Enable this module so userspace applications can query open sockets.
+
 endif
diff --git a/net/can/Makefile b/net/can/Makefile
index 7116c8c7f331..7c375220c57f 100644
--- a/net/can/Makefile
+++ b/net/can/Makefile
@@ -22,3 +22,6 @@ obj-$(CONFIG_CAN_J1939)	+= j1939/
 
 obj-$(CONFIG_CAN_ISOTP)	+= can-isotp.o
 can-isotp-y		:= isotp.o
+
+obj-$(CONFIG_CAN_DIAG) += can-diag.o
+can-diag-y		:= diag.o
diff --git a/net/can/diag.c b/net/can/diag.c
new file mode 100644
index 000000000000..11281f75ecd5
--- /dev/null
+++ b/net/can/diag.c
@@ -0,0 +1,204 @@
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
+#include <linux/can/j1939.h>
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
+		name_t	j1939_name;
+		pgn_t	j1939_pgn;
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
2.56.0

