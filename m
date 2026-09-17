Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93324F054A
	for <linux-can@vger.kernel.org>; Thu, 17 Sep 2026 12:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789648657; cv=none; b=U2PX5BgngQDV9YGSTJ+M0UenuojoBANpq7fdsBFhKvuS9c+m+8iZ8pY45UeWRC4HyG3NuY4fla3/nFr7TC9Kz7uT1gfnKD5qWoepCpk+n3QgeyMkf73T/WnsIFKLteG8Lsb5GhYJ12sTi3ya1XMOPsG3F+t1QhPQdYmzhhHICoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789648657; c=relaxed/simple;
	bh=UjrMYB1SJaVixFfmpvISBt1Okp74qLFloaIEp+D4dWE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L+lPJpHrwt3S/Kra1vKvtw5lJ5t4BVs0+tn6wdSDb7EASq1gA3ADQ7YoIKvQ0Z8N9+qASvERruMILopt4TygG037969kWlxwjlOW5XS5hcjojt6fZDPq6JtzNr8xDKhRvLos1La1UwHFJ5zoqoKKoaJNUk48rPkgCcoQSz8yqi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pdp2Dl2I; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pdp2Dl2I"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccd66bb4so724649a91.1
        for <linux-can@vger.kernel.org>; Thu, 17 Sep 2026 05:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789648645; x=1790253445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+wQAdV32Fk3OyDL+A25ZncHwDoalpqgqwEDF4cMme34=;
        b=Pdp2Dl2I9K8jYceUeoTqYt1lNhldV6eEbuM9/H7su8YgfKBXEM0t3VFObJaJzgQWFQ
         /Hbba4wEMfjrPWrpW5YO3t2bTxS9r10d81Zj1s1Vw2hZ/FO/WffYSICsSzqRZ0mOt0fv
         cwsXnYIKRx2gwujHOTuGNAYfizGAhpyXkYlZa18ruJ1DCRukd530swSOJZZtGjI/Q1DV
         bdd47bmR89GobBGrp/7csp4RyRJtUlzTpg9sBoifJ9rLc944IHGoFKdg+bRCKg2xLlTt
         +J6XmLZ3VfjuvEg41LIDHYznVT78HCL0z2T+6kZCzd+quIpi4CLHl55+8thcLnQ4vDLU
         1z5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789648645; x=1790253445;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+wQAdV32Fk3OyDL+A25ZncHwDoalpqgqwEDF4cMme34=;
        b=r4lzIA3ITQox2LAs/+kpBjY65MP8cwRkyNjC/LvJl0HuGD8u7ycgyBvkHWBEiOsXOj
         zQO1cDqwfsb2w2DIhWOz6KdmWdWFs2WbONKulvAqGWWPRdStKQiQyYrZbD2nYJEzJnD1
         fkZjjzS13xkQ6RGx45iXq0T0Bbopua1I//dY7iWBRNLzsaGtlGiKOwODOC3jhb0UYS+o
         URf74BfN724KfJzxQWmrxQrfZYXzIqVVjgFSt4FEALY//7bBhXXCnk8CH3ziBX5fQiL1
         U2w3412NrZN4X9hw61ni25MyNlAxswZMhhtfkiKw5HTGmnLJKrtlWsYquyGcFvjifuWj
         l/0Q==
X-Forwarded-Encrypted: i=1; AKwUvBzYQizy2U/s+Q8qpaVlGD+29WWR6Ps8jVzEsHVj4vsVn8P8/cuECYW0j5JwhDzJ/iBRfzEvfj68Fzo=@vger.kernel.org
X-Gm-Message-State: AFuF++mVFjSJ/UqznTq7k3RCcMnkXbGOdkp2/vDY1lshNWNTH0Fx6IVU
	9wavU0qSe7i16IrnWnjc9+agv0hp8FgMC5K97kZAbsyBPHtGha1Kvem7
X-Gm-Gg: AYBFou1drOYK8TzZtd2QEOuDsF5Agv76AgDnhxekKNTS1z0ZSKiwTUqx9onQgLUTRGp
	IaaluC/2PhrKvMqAa5ZlqJziLTOv/FC6LfIvVvD6M6GPG/ImceYn58aYsbE+/A8ewmhF8fOKD0q
	jvcmcjNZrHByYyQv9OoOAl8SvatPRskhnc++c3Dz6tdpHT5brPwuP2bMKLRE11k+Kh4+CBMUPo7
	MAry+nyedXueh6Je5X24SRbGJbNOasDG3/Q5LiejEVdxPGLOpVzvaGhUgjDzyBs9eN/FjCTW1YK
	a0iwdGd8IuiOx3xldQkTjSEYA5Gf2VkB1+n2ia+7rFhulePGR4y2fViECDUCYS/uFKKpzkW4zGi
	fJWrKXiM1CWWGIAmKPy5iRnZDCjI5pHngrzfukA4ZqDWNqvAVVeE9NKeEkuOgbfzrV3gMhyLNvn
	rysTdFJMIG/+qPkHQ5Jp5bqseHgMFJknPYO1WJN/wbZIhaMex5eT328psrAFk4MnBcXSZABMszX
	UUQQJfsU2sLrpb2xEbeA09B/xDEBjHD9GOtGrM=
X-Received: by 2002:a17:90b:314c:b0:39d:f4fd:8075 with SMTP id 98e67ed59e1d1-39e1e4e3559mr13681823a91.19.1789648645405;
        Thu, 17 Sep 2026 05:37:25 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a1e:2e81:7320:9190:e5c6:16a4:8428])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e362f0f07sm6057546a91.17.2026.09.17.05.37.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 17 Sep 2026 05:37:24 -0700 (PDT)
From: zjamg <ndaugoing@gmail.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Paolo Abeni <pabeni@redhat.com>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zjamg <ndaugoing@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] can: restore skb header initialisations in init_can_skb()
Date: Thu, 17 Sep 2026 20:37:16 +0800
Message-ID: <20260917123716.63116-1-ndaugoing@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 9f10374bb024 ("can: remove private CAN skb headroom infrastructure")
removed the skb_reset_mac_header()/skb_reset_network_header()/
skb_reset_transport_header() calls from init_can_skb(). As a result, RX
skbs from alloc_can_skb() and friends again carry mac_header = 0xFFFF.
When such an skb reaches packet_rcv_spkt() (SOCK_PACKET), the push length
calculation overflows and triggers skb_under_panic -> kernel BUG -> full
machine panic.

The same issue was originally reported in 2014 on linux-can and fixed by
commit 969439016d2c ("can: add missing initialisations in CAN related
skbuffs"). packet_rcv_spkt() itself has never been hardened: only
packet_rcv() and tpacket_rcv() gained dev_has_header() checks in
commit d549699048b4 ("net/packet: fix packet receive on L3 devices
without visible hard header").

Fixes: 9f10374bb024 ("can: remove private CAN skb headroom infrastructure")
Cc: stable@vger.kernel.org
Reviewed-by: Oliver Hartkopp <socketcan@hartkopp.net>
Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: zjamg <ndaugoing@gmail.com>
---
v2:
 - Remove in-code comment per Oliver's feedback.
 - Pick up Reviewed-by and Acked-by tags from Oliver Hartkopp.

 drivers/net/can/dev/skb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
index 95fcdc1026f8..14edec5afb57 100644
--- a/drivers/net/can/dev/skb.c
+++ b/drivers/net/can/dev/skb.c
@@ -210,6 +210,10 @@ static void init_can_skb(struct sk_buff *skb)
 {
 	skb->pkt_type = PACKET_BROADCAST;
 	skb->ip_summed = CHECKSUM_UNNECESSARY;
+
+	skb_reset_mac_header(skb);
+	skb_reset_network_header(skb);
+	skb_reset_transport_header(skb);
 }
 
 struct sk_buff *alloc_can_skb(struct net_device *dev, struct can_frame **cf)
-- 
2.53.0

