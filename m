Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD0743BDB0;
	Wed, 29 Jul 2026 08:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785315428; cv=none; b=OG8MWs4qBrbYyFI3M5Jnm4v7kFiO2fbJZ+op86m73YMQ5hoVKctxiRrJeGkBytuQwE+H5i7ePctOlJRNYc0AfigDMnQhSVU9UoMtwoaJxMLavjbYPPohfsdh9JupdH59Hkah2P4lTUdZkaB6lvCU5O89GoDnKKQIqX1pWsptiPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785315428; c=relaxed/simple;
	bh=cB719aQZrWGUbpDhxg36hzddvD7CtpJ44b+1pAIs7Rc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ffCJ+oWz9d9ZC/A5lk5h93mbFMBzJQ/rTRghvqCXnh7kiNygZrv4ig+TkopAlDqG/+QWqrgaJwBNc5UHEXBDkJvCDEmitp9uuGoADTZtzp1SFf61eXBJBwoEu8V6i5iUeTR4RRPDeXaZKcqBSJTTvNOFskvw44yaYTj7fKqXe7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 765c56aa8b2b11f1aa26b74ffac11d73-20260729
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:35c5dac7-a32a-48db-9f87-f86df5473c77,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:e7bac3a,CLOUDID:e182afb98840bf88461fdb53427e86fa,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|136|850|865|898,TC:nil,Content
	:0|15|50,EDM:5,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 765c56aa8b2b11f1aa26b74ffac11d73-20260729
X-User: heminhong@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <heminhong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 194701256; Wed, 29 Jul 2026 16:57:01 +0800
From: Minhong He <heminhong@kylinos.cn>
To: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	linux-can@vger.kernel.org
Cc: Kirill Tkhai <tkhai@ya.ru>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] can: isotp: check register_netdevice_notifier() error in module init
Date: Wed, 29 Jul 2026 16:56:56 +0800
Message-Id: <20260729085656.134523-1-heminhong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260728031038.76524-1-heminhong@kylinos.cn>
References: <20260728031038.76524-1-heminhong@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Register the netdevice notifier before can_proto_register() and check the
return value. If protocol registration fails, unregister the notifier
before returning the error.

Align isotp_module_init() with the reordering already done for raw.c
(commit c28b3bffe49e ("can: raw: process optimization in raw_init()")) and
bcm.c (commit edd1a7e42f1d ("can: bcm: registration process optimization
in bcm_module_init()")).

Fixes: 8d0caedb7596 ("can: bcm/raw/isotp: use per module netdevice notifier")

Signed-off-by: Minhong He <heminhong@kylinos.cn>
---
v2:
- Register the notifier before can_proto_register(), matching raw/bcm
- Reference the raw.c and bcm.c reordering commits as requested
v1: https://lore.kernel.org/all/20260728031038.76524-1-heminhong@kylinos.cn/

 net/can/isotp.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1907,13 +1907,18 @@
 
 	pr_info("can: isotp protocol (max_pdu_size %d)\n", max_pdu_size);
 
+	err = register_netdevice_notifier(&canisotp_notifier);
+	if (err)
+		return err;
+
 	err = can_proto_register(&isotp_can_proto);
-	if (err < 0)
+	if (err < 0) {
 		pr_err("can: registration of isotp protocol failed %pe\n", ERR_PTR(err));
-	else
-		register_netdevice_notifier(&canisotp_notifier);
+		unregister_netdevice_notifier(&canisotp_notifier);
+		return err;
+	}
 
-	return err;
+	return 0;
 }
 
 static __exit void isotp_module_exit(void)
-- 
2.25.1
