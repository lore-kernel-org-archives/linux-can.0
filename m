Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0AE4AF682
	for <linux-can@vger.kernel.org>; Fri,  4 Sep 2026 14:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788531238; cv=none; b=uvRnefQW3klYAsql6Uyt1KA9gCsBvB4xZhBdwxjPx5xVPBJnQCu3dRPTJpPlyUxB2Mu0N6QAW0k5R1PfrryTihvbNu3nwc6V7Wjvlsek7aSF3yLmfXM1QQcW2KGDVOe93Rd7mXW2KOn25clBLitAc7TVkyup1T/Z260dzh0WM2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788531238; c=relaxed/simple;
	bh=zB1N/lmHN1ujtJwc+SHK+2NtyuO3vAQCWkJXJkhC6yU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gj/wS/dAcCM8buTFRGAO59ECiWZNjbrp7L1UsJ01CvMtyOAPp8Oj+fQxNB+UOcKxqGORLm1VFq32KeccKGxt41Wb9+bNDvhK1moXoIjl0pjc5uT4wPHqcKqYx9h5O5Xh1sezVkQOPbNhnrlKhiDiMQZb4cA2thgAEY/mrr7lLH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cuu0mUfG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=t9KdXJyv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cuu0mUfG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="t9KdXJyv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788531236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Awai38MWrY1vEnecOIfsO7NyqZq1zeBlPLHLuAUTnE=;
	b=cuu0mUfGHSpUbog9Zh4JFOkWTHYtVz2ROZCgLrWeD0xb4zz2iTIe4fRY0gSQoBu6OMabQO
	9umg56Q13A5z1r2znRXqBNb3ioldJQCgCHZEnTAugajA+1n34lDgTuTiI/ncxdfvSVVCM6
	anPFLK2KJO2263GDVQ632uxngJUh3fs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-W_pyU97ONTis5ceR3j0kPA-1; Fri, 04 Sep 2026 10:13:53 -0400
X-MC-Unique: W_pyU97ONTis5ceR3j0kPA-1
X-Mimecast-MFC-AGG-ID: W_pyU97ONTis5ceR3j0kPA_1788531233
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4994cf6cdb9so7367365e9.3
        for <linux-can@vger.kernel.org>; Fri, 04 Sep 2026 07:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788531232; x=1789136032; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+Awai38MWrY1vEnecOIfsO7NyqZq1zeBlPLHLuAUTnE=;
        b=t9KdXJyvQ7Z7RXS6mX+dp3BE8JzA16SLh4dZ5illtfHVR0ixYLMXJKIYiHIYtEXBl2
         OMiTuugUnFYG3LMyspdkvLe3O1rvXCSVwZeaVobOlFNaO729E9qddgs6+2p+JA/Mu34n
         hS36VXQHHlnuXHIeJPlTZT0DOCGjEI6KuktFRe8CprCiu8VQ/rE13bpxRJEwhjhO7GaK
         zvpm2kGalgjNuJX5pC8V8ZZSk5xKfQTLPAZUNcenQ+2MxOzNe4BZrsF46Er2Q5JETahW
         epN0KY/4UPO37pYBeau/BrzOEYE8p72ZAMk4BFvQqoPy/EgDieCoj3gV7z/SO6MNXi2i
         CtKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788531232; x=1789136032;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+Awai38MWrY1vEnecOIfsO7NyqZq1zeBlPLHLuAUTnE=;
        b=R0Mrdtqkekpdv2x/L8I7oAGCvBGVSeLnEz4WzaueTAwQ6sFWum1ZntW53pOqJBkt6T
         5JmARHDSM8yLcmYmt7IPcrCZU0815kEgUQj3Z8GPwq9R22H2A58Ak2IaaxqxE8/ymwAb
         GFd0uPtiQpZ57E3d44fssaN/Jp0KV7aIGMdaMHvPC58DDhKI70v6xgDQEymx2EIPMo35
         YU3O0hpbr16CrkgEA1Q8snopTeDrqktfyOOg5wPLt1NzB/ujl7kxs7gXNNfefhNFsF+1
         Z8Yda8e2nuqBSaHPyUcMTAjyygT1+fZrFjgzPSmkspiGWujfnHmUTF5CyNi2uBgrxqFS
         v3oA==
X-Gm-Message-State: AFuF++kxQvufwHeryP3uXm9D3UToleqxT8zV/DbVzV8hMh6X40WnORTG
	KPhAHDkLtJbalaft2k/7p6UjELvNklqJciVI3l1JmIhjaLk1TzckPdCeLYHETg9rOAgw5AhPaqh
	M0N/1SUB0dELIV6pTgqm2CSZ1IJuprdz67GCgFo8wxvZxTeSYA9WZVHcJRz6nfg==
X-Gm-Gg: AYBFou0PtSpH1YVxKo5AF1ZRYM5qjF+7vpRPwJEA1S90Aptvajxf12jw+MoXqjyjILg
	9D7gKRHKv8SF1EJz0XPY3f2nbyvMkG1v3iwJVux416V3SgUQRl7zsHyMT5V7p/mK8KaNE2KHTiO
	doChj5J9N2+Xek/p9rmwtZYonpTiLp1catAy9e1hyAcxBVvQK8JpzMJfbLYrwrSyR3kIycl7cy/
	xC4m0ZW5XLJRzMyYtNlYrvZLN4urMxyypBMwdeIO/zCekj5wHiIqe1VTrCN56O+kWjGN21Ea+hA
	gr9O1CwZ6yt2y7xbRUvqVoAarZqNiNycUN94Z4IxmR4tEFFkyKO2bQvp6HqtX134KKtcQBpyt7d
	hYabBSMJsgrySNVCtZvGHfsJZ
X-Received: by 2002:a05:600c:8b6b:b0:49c:e1cd:536 with SMTP id 5b1f17b1804b1-49cf826be5bmr62019735e9.12.1788531232581;
        Fri, 04 Sep 2026 07:13:52 -0700 (PDT)
X-Received: by 2002:a05:600c:8b6b:b0:49c:e1cd:536 with SMTP id 5b1f17b1804b1-49cf826be5bmr62019155e9.12.1788531232084;
        Fri, 04 Sep 2026 07:13:52 -0700 (PDT)
Received: from fstornio-thinkpadx1carbongen11.remote.csb ([130.25.253.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf7703cefsm99744845e9.5.2026.09.04.07.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 07:13:51 -0700 (PDT)
From: Filippo Storniolo <fstornio@redhat.com>
Date: Fri, 04 Sep 2026 16:12:55 +0200
Subject: [PATCH can-next v3 1/3] af_can: ensure sk_protocol is always set
 on socket creation
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-feat-can-diag-v3-1-bdcebf07b373@redhat.com>
References: <20260904-feat-can-diag-v3-0-bdcebf07b373@redhat.com>
In-Reply-To: <20260904-feat-can-diag-v3-0-bdcebf07b373@redhat.com>
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

