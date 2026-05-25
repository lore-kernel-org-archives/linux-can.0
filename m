Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9528630C17D;
	Mon, 25 May 2026 13:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779717395; cv=none; b=vE3NqAF+x5YAorVxJD9kUHh5+DJEmOAR4gY1Y51jNjb9Sc8P1vZq8XmZCqWCtN95UNDvFV42kDA8haYQVcESpOn4whsAlNe19/Q8nzKIReLUmbKN7pDHCsZvo/FmAfLYxmVypO+GWTpEPKkEAbgZtQTm4njhQseIS9KL9uAiA1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779717395; c=relaxed/simple;
	bh=EfUr9uCGCmPOLnehFc311fCDgv8SrqSmzEyy5roOq9U=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=qC2DKPsub2HJSnTtxn7fH6cvGKCHRxwkh6NXKvwT5mXVF83hXc3Q4dbedsH0KNAuGqa6Ijbn16DisfSQSYvygExzcQxG99QMtt/F4ZpnZkLotGVKzwnwE9rWcAd9iwPhGwLzwgfMXAVDJs/cYvfnznV9x3P44b7IwHd00EkM8SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=XAMp6s1r; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="XAMp6s1r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1779717387; bh=YEkfMxSScFsmhGAmPctxSi/yFxHav6QeGuLGKtPFzAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XAMp6s1rJD0uqgwXlqgy0qxyd4ArD2pVBc5Ywm6uQWCKVv77gXDJ8hzTnSAiust2N
	 Gm7WJ2saOHTKmJip8OALaZ1ljy456eonf316zXR2z+R6xW5HrCiKI95hvKXZ6QqPZ/
	 Fjx4a/4Ycmd3wFAegtWldYHMAtKPz5PQH53Y6ghE=
Received: from lxu-ped-host.. ([111.198.231.89])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id E188D68E; Mon, 25 May 2026 21:56:24 +0800
X-QQ-mid: xmsmtpt1779717384tr9x5nh8o
Message-ID: <tencent_C56D5496D4E8FEEFDECCB07AEE6FC42C450A@qq.com>
X-QQ-XMAILINFO: OYTBn1rNHH7tdUsk7R0LIAObZumKsMuKdpqAzhT+XMbSPDr4/SLevDjMGRFvMl
	 Fo8sQb14k6Io8EMtcjBZnaQU+a86OwJ7VrpInMH5XsRE1lELa25XbByqLT6ukiGeGWJtyKZlrmG+
	 dj32W6XDeTdaCaxIct77QlLaNLWx6CtTHscpoBvSN/uOWJy4lKfCDUh75Kl7KkY60ANkrEwkScrM
	 /TNd6BuuKtnCiIVfMBM/wWKyJ5XPSiB3Z2FvNRId5x8QgudF3gOi8WdX9Ab4ASLs1NZ1IEi+CxUw
	 nVOWy+3mJmQqDMzYXUymnDY+8JsDT/WXKe2/+rrAq3vYY57F8w+1hq5eSVxAykj0ldGpMLkggLDY
	 MFddogdLKX16XCvJ4gF8HPNdq7Qq3G99tYegZcb+g7hDe6PXJc8mOB3AIbaIacANBpi1ShbyH6Y7
	 jWYIRFfS4Sp73g1UDs8cbgJDQSQF5fr60lfTADeUoEk6Yw1/lVc4uGYZMQdW/kfi0H5z9tSWyUC2
	 XAKWiXVbe6afniTG1DVvoI56N8smikejQZherGUnucZV+jefKeUvt18HAG7b5tz4HN+JhK4hrX7V
	 yxoyQIzdfpTACfyacTsdXB4NaQ4oMfkXHTKs2ryhOMN3EQvUUVp59+Y/lR05FjF1rmFXNraIVfI5
	 eWNq1Buh2atC/XmvL5mY4EHoL7Weys8fWD4/0GZFM9jRAyKoSD5kPea0DmdzQ6EClpPn1t4BML/I
	 iiRRJjM6DGWwlyLbBL1Fblu9oJD1bWiFOWuNjCKDtXu7in1BuZheEkmnKl+2A1Z1teJQnKSZU14z
	 hWLNL44jF5Ba56Q1iE/JBBkmHXO5FstXhmGcEJvsubqFPV2qfYH9n0tgmeA8fCPMSi74pkpIiFv7
	 OpBF6+AL1oRRv9sMmORMFDoCgurD4r0KFslE8kFyhsdGN//CxtqIUa0Yx/lOPw/xuATkT0KnVGI2
	 LQ7j/SiuJp+wayjoda8QD6poERNHM/vAXkoG7QERfdWRFroNJ4IBPFsWx8vuOpMqhhf6X6SiiDFo
	 zqM59yPOgegN2vs+153rhgDqhS2KhwxDLPXdCi/g==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+8ed98cbd0161632bce95@syzkaller.appspotmail.com
Cc: linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mkl@pengutronix.de,
	socketcan@hartkopp.net,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] can: af_can: reject can rx unregister if dev is not can
Date: Mon, 25 May 2026 21:56:24 +0800
X-OQ-MSGID: <20260525135623.152677-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6a124882.050a0220.30ba69.0009.GAE@google.com>
References: <6a124882.050a0220.30ba69.0009.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a user binds a non-CAN device to a socket, the vulnerability reported
in [1] is triggered during the socket's closure and release phase, due to
the inability to find the expected receive list.

Added checks for Mid-layer private and type during the rx unregistration
process.

[1]
KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
pc : can_rx_unregister+0x124/0x560 net/can/af_can.c:537
Call trace:
 can_rx_unregister+0x124/0x560 net/can/af_can.c:531 (P)
 isotp_release+0x500/0x9d8 net/can/isotp.c:1232
 __sock_release+0xa0/0x1d4 net/socket.c:722
 sock_close+0x24/0x38 net/socket.c:1514

Fixes: bdfb5765e45b ("can: af_can: remove NULL-ptr checks from users of can_dev_rcv_lists_find()")
Reported-by: syzbot+8ed98cbd0161632bce95@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=8ed98cbd0161632bce95
Tested-by: syzbot+8ed98cbd0161632bce95@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 net/can/af_can.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/can/af_can.c b/net/can/af_can.c
index 7bc86b176b4d..72831b4e0776 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -519,7 +519,7 @@ void can_rx_unregister(struct net *net, struct net_device *dev, canid_t can_id,
 	struct can_rcv_lists_stats *rcv_lists_stats = net->can.rcv_lists_stats;
 	struct can_dev_rcv_lists *dev_rcv_lists;
 
-	if (dev && dev->type != ARPHRD_CAN)
+	if (dev && (dev->type != ARPHRD_CAN || !can_get_ml_priv(dev)))
 		return;
 
 	if (dev && !net_eq(net, dev_net(dev)))
-- 
2.43.0

