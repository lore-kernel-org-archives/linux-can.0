Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794568516;
	b=KHywZ9x/vUBzcXEB+OcPW2/+hRG2+IOGkulzZE8tGurG+AI8+qAp+pgFl1nwJyyywGeF
	 GKB+0YUI8bcNDfwZmJ8exjypCtzMgXXE2R6B0nh30lLPWAJeUEcwcScNQ7sDQMZxdRHCJ
	 9Dzis6HtmZEyTOKmilgw/AJcxO/KaaOLcnoSSaTtdWjHeNmVND5I9C3nMnHPCFeOkw0db
	 mN+2eHJ5VGNI3dGHSPOjeJeCq8yIQURDYlkcRLZoXapApZhmmqIPFfa2uja8hfjSlEcNO
	 crxrRH4eGHTBMQRkwgAWxidzNlLlA+XEVnCwJJGp5Z0GtFCF6x3a08iPkhoV+YxYTCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794568516;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=sv7Njo4sjx3uPzx9ri5E6oB8aEVrJL+1lzhL0pMN+fc=;
	b=WkTkzbhnd0IJ1EoZuNhU9CvFmUZciBx/VAAcOTnOT6hR3Tcw3ZrVm16nmO8po0BGbZoG
	 WdGWDmtIY/H/MZX7deoiaFz2qH2K2+7K0kTVm0hDgwBzfHGysbls7A4qKhBZ5M6+QmM9/
	 8qxAl04U+xDg/04f5qpjMCJZGLk/clpILMT4wC5iS4Wtfl6weLhc36RTnGQaKVl2kjy1u
	 o8XJkEl6KhBEHQp/rwjgz5XYX7IDzccz2D9Y5gel1fNQdgS9Ctkwn3KpIpoSzKz81mY9L
	 SnSDX68cO3h27jTIUMibNLfglg4rDsZQITW+vM+uU5PRnn6I85HU+XDeb5wmM1jFErQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bYqbnh9m;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=AhZzKOHc;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4283606A31C
	for <linux-can@vger.kernel.org>; Fri, 13 Nov 2026 11:15:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4283606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bYqbnh9m;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=AhZzKOHc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794568515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sv7Njo4sjx3uPzx9ri5E6oB8aEVrJL+1lzhL0pMN+fc=;
	b=bYqbnh9mHCE/FC1kWTAfgh5VAquyibcZPPBDEGFg3mXBh016woVQ0Kt61YmT7gV4GEjl28
	QaMQe8t6jMWkMSrQfY37diCOh9KEn2S83JZonfzvudWA5OhKNudHII1HIhlZNtIB94c6oQ
	wCkmnXjPnAVskSfzfFFw/dDogvEt10o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-cDLXdgiEPGqd0Ifiz0DLGw-1; Fri, 13 Nov 2026 06:15:13 -0500
X-MC-Unique: cDLXdgiEPGqd0Ifiz0DLGw-1
X-Mimecast-MFC-AGG-ID: cDLXdgiEPGqd0Ifiz0DLGw_1794568512
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4b9fde3044dso5460325e9.0
        for <linux-can@vger.kernel.org>; Fri, 13 Nov 2026 03:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794568512; x=1795173312; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sv7Njo4sjx3uPzx9ri5E6oB8aEVrJL+1lzhL0pMN+fc=;
        b=AhZzKOHc+dcQGzpNO/EGZbw+MBtqC+HL+oxR/BkxZX59SWLmZHDJi4/IqL6miF6NcK
         HKeKyZDiFgT84xyBQOFfUxeL0hc/4N94bJfM3uI+Rb0EKNHYx1GIaF6Yd7m4jXxN8i96
         4xS/pBGa8XvAWfoCx1h5brqpFY7P1tONHeE8b7rvbdILM5xKGh5tRbKMoxfGaeGtwoLw
         K1VgBzwISiDhu9D7VjwraCLq8ZN4zZWFAESMx+FNibySEcHkKVBtrqFg9HXk/k/OfLMu
         fRni1y/xZ9nYDMBoNXc0RCtRxDLe1Q5r5lwqGBjv4vvH9NbuiRnjIDbTfxQm7xer3rDP
         viTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794568512; x=1795173312;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sv7Njo4sjx3uPzx9ri5E6oB8aEVrJL+1lzhL0pMN+fc=;
        b=E/KMiTfTa3WE7tM086U6LfK+GJPcdJshX11mrGD1S7UVSG1xsUPIlaD86ct5fU/WFD
         Dp2HXXw6DnxbEzDidQaMflYWxlAP/VS7jv4H+H/qzIv7YFVuF0DLNgS8ixMareFH/r0V
         hnZ5GcCE3/xBsn35ccKnw+um6TK1vsSe4l2qfFL5gv+Q4UVw8CzY8Zsb55bYT4wcbAhC
         EGDzonz0Oys5FNjb8Qc9DyJgTYrj/E/NKO7njomV/AUxXRTmiS3jym8AhECpElIdweE2
         U2WfJCLDCSvciZ7LsHk3YdkcoOJFwUfqW2lltwVd3t0DYsPCh0lEWStM0CEnlpO4U8cS
         X2BA==
X-Gm-Message-State: APuU4Z9hwgiMmW1aAPhbDZqxwMoNh60nKg59H39+JxfER0GmtEbsjTfE
	/YSehkEcCmSYURRd5DpC4IB+sIdugcS2bbOwIB878H3dgeKqrLgdGN/FUgtEPlGPkCdpxZyH2QK
	Nz9gyJHsRvr2RUgG3QuoRSM6NElkmA41f1GqgIGfOrzXjmhpRNlW2gwpvVDOzoQ==
X-Gm-Gg: AYBFou0telXvk+fTmTnnqlXCBd+rLEev6nTZBOZon9R8FD2NtU/5TsyVW+qIrFl0ynj
	xelq0Au8u3PmfRfiMOFImzPUU1hdDfBfgdd/YMo4jPy1Olg2K5JeO58dTduDmRW3y6ayxBvB+At
	62Ne2M+xX/vQ23tnGBKE6TVknRcrexpsreotbw7ERbVm36X3Re1F/0ErsF205FHNjkDNhiOX83P
	r3w+IYbrxE7FTOXrR2M6WsoKFMCopefjOkd8SMENOwZaWKnZXkG6rm1/ZBgCmtDY5fNFrmBQmMt
	MRC4JO84I7awHIIueL78AYkKw1DoT8wQVDQCZokaXfC46JvSEBktbUXf9piShORuPlvbZjiMvb7
	D6V7llwJQZV9PwDSOYpQT0Ywxpf6A4bNC92MvzVK8s1jzYGyvQTdALZ/k6i6RSsJIEpIMtF7ZGf
	7b/Vnuu4mbKe3X
X-Received: by 2002:a05:600c:c0c5:b0:4b9:ff69:19ac with SMTP id 5b1f17b1804b1-4bb55a66040mr33457925e9.11.1794568512489;
        Fri, 13 Nov 2026 03:15:12 -0800 (PST)
X-Received: by 2002:a05:600c:c0c5:b0:4b9:ff69:19ac with SMTP id 5b1f17b1804b1-4bb55a66040mr33457635e9.11.1794568512057;
        Fri, 13 Nov 2026 03:15:12 -0800 (PST)
Received: from fstornio-thinkpadx1carbongen11.remote.csb ([130.25.253.240])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb56f8d054sm29531115e9.3.2026.11.13.03.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 03:15:11 -0800 (PST)
From: Filippo Storniolo <fstornio@redhat.com>
Date: Fri, 13 Nov 2026 12:14:33 +0100
Subject: [PATCH can-next v4 1/3] can: ensure sk_protocol is always set on
 socket creation
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
Message-Id: <20261113-feat-can-diag-v4-1-c28842c74c95@redhat.com>
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

From: Davide Caratti <dcaratti@redhat.com>

Currently, only j1939 assigns a value to 'sk_protocol'. As a prerequisite
for the implementation of CAN sockets diagnostics, AF_CAN sockets need an
easy way to determine which protocol is on top of an existing socket.

POC test using can-tests:

 | # perf probe -m can_j1939 --add "j1939_sk_recvmsg sock->sk->sk_protocol"
 | # perf record -e probe:j1939_sk_recvmsg -aR -- ./j1939/tst-j1939-ac
 | [...]
 | # perf script
 | tst-j1939-ac  5807 [002] 322767.312599: probe:j1939_sk_recvmsg: (ffffffffc0b29a14) sk_protocol=0x7
 |  ^^^ 0x7, that's CAN_J1939

 | # perf probe -m can_raw --add "raw_recvmsg sock->sk->sk_protocol"
 | # perf record -e probe:raw_recvmsg -aR ./netlayer/tst-rcv-own-msgs vcan0
 | # perf script
 | [...]
 | tst-rcv-own-msg  5816 [001] 323173.651122: probe:raw_recvmsg: (ffffffffc0b20154) sk_protocol=0x1
 |  ^^^ 0x1, that's CAN_RAW. It was 0x0 on unpatched kernel

Storing the "protocol" value in can_create() fixes the problem. This also
fixes AF_CAN support for the following system call:

 | getsockopt(..., SOL_SOCKET, SO_PROTOCOL, &proto, sizeof(proto))

that was assigning 0 to 'proto' since the earliest kernel versions.

Fixes: 0d66548a10cb ("[CAN]: Add PF_CAN core module")
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Signed-off-by: Filippo Storniolo <fstornio@redhat.com>
---
 net/can/af_can.c       | 1 +
 net/can/j1939/socket.c | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/can/af_can.c b/net/can/af_can.c
index 0f3051a61aab..b4255fc570aa 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -162,6 +162,7 @@ static int can_create(struct net *net, struct socket *sock, int protocol,
 	}
 
 	sock_init_data(sock, sk);
+	sk->sk_protocol = protocol;
 	sk->sk_destruct = can_sock_destruct;
 
 	if (sk->sk_prot->init)
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 50a598ef5fd4..ccd43ff5519c 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -420,7 +420,6 @@ static int j1939_sk_init(struct sock *sk)
 	/* j1939_sk_sock_destruct() depends on SOCK_RCU_FREE flag */
 	sock_set_flag(sk, SOCK_RCU_FREE);
 	sk->sk_destruct = j1939_sk_sock_destruct;
-	sk->sk_protocol = CAN_J1939;
 
 	return 0;
 }

-- 
2.56.0

