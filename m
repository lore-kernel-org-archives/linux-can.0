Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78FE2BEC3F
	for <linux-can@vger.kernel.org>; Thu,  6 Aug 2026 13:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786023485; cv=none; b=EweD0bFpOq9LiGiVizSBrTg3MjTefOyrOPvkOWVjAahIU2l1m7kRUE8Wsl91mYDx9yzYkoj7zYF9CRz5juWcWi5IxDjQYgYFaxOWAn8p0UmRQNJxD+azABx9PpcPbAt2EzFBf2Abtu1YgNoWyU6137w+SeeKdi0qMBhtyx+YmTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786023485; c=relaxed/simple;
	bh=zB1N/lmHN1ujtJwc+SHK+2NtyuO3vAQCWkJXJkhC6yU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AKQKzL1YOrD4tW70kODPxUHQy7oTTFH0J8hn+5obtPzTY+WQvJNfPuJAF2Twqt+rNsvPSkUWMr5EPq1sM6gT9RPNl9xDLREBdwKHwht9VFvL6th2cWKotbEF36YQgGRqZDozB7/4pe8Oa5gPnoSKup4WNr5s8COMCU1B6pLrPYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HQHKzzMZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CmPB9OQH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HQHKzzMZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CmPB9OQH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786023482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Awai38MWrY1vEnecOIfsO7NyqZq1zeBlPLHLuAUTnE=;
	b=HQHKzzMZgSAnzQKVINVWqpx30O1bxZ1naQwUB/h+vUMhmChfzouzRYTxMkLvFik0ln228z
	djHuMUCj+e/mv6CmGNoLDcgyeON7+EqCljDLq+Qem1h28q7jjZpEZJjZ+2GutnapOsVqbw
	6LvliYHeTeJqG9PEI2HNmnO/vA9Z0E8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-wg8gz52HONqpEHRz4JwgDw-1; Thu, 06 Aug 2026 09:35:40 -0400
X-MC-Unique: wg8gz52HONqpEHRz4JwgDw-1
X-Mimecast-MFC-AGG-ID: wg8gz52HONqpEHRz4JwgDw_1786023338
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4955ce558d8so21084705e9.3
        for <linux-can@vger.kernel.org>; Thu, 06 Aug 2026 06:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786023338; x=1786628138; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+Awai38MWrY1vEnecOIfsO7NyqZq1zeBlPLHLuAUTnE=;
        b=CmPB9OQH2llqHNCDzfcnVDThs8a3Zvfwy/qv6xo204Li2hqbld0jVpJM/pEcV7zq/f
         kCwTaU2Llk0PV311IjF6NbvS7Ik3/7PaJbLOoXMwbNmXAn1lBl/QjUslCk1waNv+rpB2
         mB6J4uXiHwkc0ttnSJRcRD0+mH36TDy3ynXG1obbfG+YGfDHIgYfxfBvEJCpH/VlGMGl
         uYQN/csbfCjzvnushgaiebsxCOV23F8tBRs4GOMJTVVES/El1+pzX/UBDlBT3RgWs93P
         rE15J7LEcIC34iQmgJC2VNRdqTrvXZSI4PxU2WIP4uq294IKEXyi4gezd/FYhZt+vQ0y
         +KYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786023338; x=1786628138;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+Awai38MWrY1vEnecOIfsO7NyqZq1zeBlPLHLuAUTnE=;
        b=HtSqVBOk0DdVAMOdkuE+KZ2hnEEhnIMU8yPPlPCZ2pV5DSsBlka+vidQh8GVoX8PpW
         NoULDFSNCnwwa6wO4bOML9t2pcwDwnlru1V0wNV4HMI9XwdUVJrHA2vJg4JTwNNxZe35
         ovLndnc+fYl89COXlhK/9SH52BixTPE4y/IFTW9oQjkFmvz2XH1333B94d+cBGPeFld3
         ifkY+cZ1k8y46uWJPtJG5qvYQR9pSJQmfm+KPl7wXyhHTO+4YdsSdLVyRQhGJuh6V2L1
         PjXieUEaaAGCrpeQoVK4+N7cxOYgB53EcA6sxjuINO6aj+wJjcBeDI/xtFMQTuf8HhPl
         khiw==
X-Gm-Message-State: AOJu0YzDChGGxz0wHjJHf7Dmc01V6hs1e5gMNs1u6QWZiVoZJuU2RRMA
	UOOs2lYogqrNLtqdx8AhjXC+c08QBXrBidqwk1BbsSIpwzpo60SjoCYz1+0VjHFhl5KuBNaTg5m
	9ZSr9XR5dRWKdZVzial80lrZwJKIybvnM4cIMVEvwWHiYCQhTzzDqXuzWQsc6Iw==
X-Gm-Gg: AR+sD10SnGEIW4KnQwGLjQskMk4EOiEXAJnMPvJ2ZxMhIXVViee0MRyxBNhc0XZ54pp
	C05xGw5WT41PUfmu9rX+1GPvzhYBU8BFPsJ4L9avBWoeJ3ZucSUbfZyfO+CzoP5rz/6tLwX9/QQ
	OLpVAyYT8R6bsWtmattHEntvoYus8L0Sj0bdyFz5osYsHzWUZKrhn9KNEdK7nXRoKVbL5ifl5J4
	GboZWirVzLpvenwMsLfg0cHnzI9XB1zKDqNEjagtZDEU31gC1aKYHFMjefmuXX/hlcvF6NpyDpa
	ZQ91BAWBMiq1J5lx3fx6Z0O4wD50mR7mQSOOpWAkhcyvzKwOvYhe2SVzWfV+6qhkLmdTDqvV3zG
	3niLK9TCDZrE0kfi1l+WfsgYdYK1rJolB2nWHbW3sHZ2M9pFUpCLwFw1HNDVb6rxgRt866EiBPC
	M3qIlEyw==
X-Received: by 2002:a05:600c:1f86:b0:499:52ab:a50c with SMTP id 5b1f17b1804b1-49952aba5b3mr90838005e9.1.1786023337885;
        Thu, 06 Aug 2026 06:35:37 -0700 (PDT)
X-Received: by 2002:a05:600c:1f86:b0:499:52ab:a50c with SMTP id 5b1f17b1804b1-49952aba5b3mr90837175e9.1.1786023337504;
        Thu, 06 Aug 2026 06:35:37 -0700 (PDT)
Received: from fstornio-thinkpadx1carbongen11.remote.csb (host-87-1-27-205.retail.telecomitalia.it. [87.1.27.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49954246f9dsm75112735e9.15.2026.08.06.06.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 06:35:37 -0700 (PDT)
From: Filippo Storniolo <fstornio@redhat.com>
Date: Thu, 06 Aug 2026 15:14:13 +0200
Subject: [PATCH can-next v2 1/3] af_can: ensure sk_protocol is always set
 on socket creation
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-feat-can-diag-v2-1-832597ee4cb9@redhat.com>
References: <20260806-feat-can-diag-v2-0-832597ee4cb9@redhat.com>
In-Reply-To: <20260806-feat-can-diag-v2-0-832597ee4cb9@redhat.com>
To: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Robin van der Gracht <robin@protonic.nl>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, 
 Urs Thuermann <urs.thuermann@volkswagen.de>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-can@vger.kernel.org, Davide Caratti <dcaratti@redhat.com>
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
---
 net/can/af_can.c       | 1 +
 net/can/j1939/socket.c | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/can/af_can.c b/net/can/af_can.c
index 7bc86b176b4d..65af25946985 100644
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
2.55.0

