Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFFA3128D7;
	Tue, 28 Jul 2026 03:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785208252; cv=none; b=D2uDHi2x+ZSwZ4LFKYXD6UQkqSjBEzvjQDUDppoEdIrGu0w3BfbK3ZUL60NXH5gfv1SLJZgk3gGPa4OiIBogtFpT1EQ59uoPvU9bvsYgKAm8JLi4iceUueXnAFAR5K6/8mgwW1QTFviPYiWx3Qv9s7gGAiZ1MY7uiK/dwdpTK8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785208252; c=relaxed/simple;
	bh=GrvOyWZXH6j3zNatfGrRNaGtQVxq6oXDLNZIA2vs6mE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U/oG6EqflOHQedicUCuKfqvkaoY2tVHzIpOvs3XMsmJkFKspXCSl8TKAYZuoWscKKz5BuwLXD363/4ZPnMGLlbEbJ6ONejkhaMq4vRYmwhyxECQ3FJvzExlDVrMQbFrddD/MKaMVeayXKawaWv/ClpalBj8EiRLMNES3SVqp768=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: eb7347be8a3111f1aa26b74ffac11d73-20260728
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:f1dbd471-6876-4327-a916-a04666259723,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:e7bac3a,CLOUDID:3212305963ef7f7d6be5fc5143bd89d7,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|850|865|898,TC:nil,Content:0|15|
	50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: eb7347be8a3111f1aa26b74ffac11d73-20260728
X-User: heminhong@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <heminhong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 377291399; Tue, 28 Jul 2026 11:10:43 +0800
From: Minhong He <heminhong@kylinos.cn>
To: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	linux-can@vger.kernel.org
Cc: Kirill Tkhai <tkhai@ya.ru>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] can: isotp: check register_netdevice_notifier() error in module init
Date: Tue, 28 Jul 2026 11:10:38 +0800
Message-Id: <20260728031038.76524-1-heminhong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check the return value of register_netdevice_notifier() after a successful
can_proto_register(). If notifier registration fails, unregister the CAN
protocol before returning the error.

Fixes: 8d0caedb7596 ("can: bcm/raw/isotp: use per module netdevice notifier")

Signed-off-by: Minhong He <heminhong@kylinos.cn>
---
 net/can/isotp.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 54becaf6898f..65e890cafd7a 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1908,12 +1908,18 @@ static __init int isotp_module_init(void)
 	pr_info("can: isotp protocol (max_pdu_size %d)\n", max_pdu_size);
 
 	err = can_proto_register(&isotp_can_proto);
-	if (err < 0)
+	if (err < 0) {
 		pr_err("can: registration of isotp protocol failed %pe\n", ERR_PTR(err));
-	else
-		register_netdevice_notifier(&canisotp_notifier);
+		return err;
+	}
 
-	return err;
+	err = register_netdevice_notifier(&canisotp_notifier);
+	if (err) {
+		can_proto_unregister(&isotp_can_proto);
+		return err;
+	}
+
+	return 0;
 }
 
 static __exit void isotp_module_exit(void)
-- 
2.25.1
