Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DCD448CFA;
	Wed, 29 Jul 2026 10:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785320978; cv=none; b=Xeptt3GHA/Ea2Is3oHxWhUjFZKVLs+3HckcNEf4XeRhafl9ayFntBPZxVDyWwpt+tmQZdHWUxFo2SA9waLIw+A7ByB+SgrqpbW9R//E5cf9QnJ7x1nhHY2tTnmuWCkWL0w5+yxJAg7o+rA8q2h0/uKxjVVgWUmCGsYTv5MupDIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785320978; c=relaxed/simple;
	bh=iCbQlx6LqPNKX3VuttIJAOJcdebFGkMGvw5iTCDmNRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D67HyR+mTNRGJtzpk2U5IvCm6u4BL6wItf3fni0aZN6KleQVe+C9z1UPede+MkcvEJmBOxkZu7aAGkp1dunKxVG2HqID2JYWPjkPohPepU0aM74thsSsMKh0nxNvnFKMjnG+/Oi/cBVd7GacKREBiz8lfGSGuufr1kqruqRh3qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 928D2202B65;
	Wed, 29 Jul 2026 12:29:26 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wp1XS-001rnH-1H;
	Wed, 29 Jul 2026 12:29:26 +0200
Received: from blackshift.org (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id CE773575DC0;
	Wed, 29 Jul 2026 10:28:10 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Minhong He <heminhong@kylinos.cn>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 04/20] can: isotp: check register_netdevice_notifier() error in module init
Date: Wed, 29 Jul 2026 12:12:44 +0200
Message-ID: <20260729102802.505168-5-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729102802.505168-1-mkl@pengutronix.de>
References: <20260729102802.505168-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Minhong He <heminhong@kylinos.cn>

Register the netdevice notifier before can_proto_register() and check the
return value. If protocol registration fails, unregister the notifier
before returning the error.

Align isotp_module_init() with the reordering already done for raw.c
(commit c28b3bffe49e ("can: raw: process optimization in raw_init()")) and
bcm.c (commit edd1a7e42f1d ("can: bcm: registration process optimization
in bcm_module_init()")).

Fixes: 8d0caedb7596 ("can: bcm/raw/isotp: use per module netdevice notifier")
Signed-off-by: Minhong He <heminhong@kylinos.cn>
Link: https://patch.msgid.link/20260729085656.134523-1-heminhong@kylinos.cn
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/isotp.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 1f11c66b343c..155530aedce2 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -2050,13 +2050,18 @@ static __init int isotp_module_init(void)
 
 	pr_info("can: isotp protocol (max_pdu_size %d)\n", max_pdu_size);
 
-	err = can_proto_register(&isotp_can_proto);
-	if (err < 0)
-		pr_err("can: registration of isotp protocol failed %pe\n", ERR_PTR(err));
-	else
-		register_netdevice_notifier(&canisotp_notifier);
+	err = register_netdevice_notifier(&canisotp_notifier);
+	if (err)
+		return err;
 
-	return err;
+	err = can_proto_register(&isotp_can_proto);
+	if (err < 0) {
+		pr_err("can: registration of isotp protocol failed %pe\n", ERR_PTR(err));
+		unregister_netdevice_notifier(&canisotp_notifier);
+		return err;
+	}
+
+	return 0;
 }
 
 static __exit void isotp_module_exit(void)
-- 
2.53.0

