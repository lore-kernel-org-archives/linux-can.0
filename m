Received: from out30-84.freemail.mail.aliyun.com (out30-84.freemail.mail.aliyun.com [115.124.30.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7777A2BEFE7;
	Fri, 20 Mar 2026 07:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773993300; cv=none; b=Z4z6Dj+ntgut3PHhuUuUi3SVMAQv9yiTNNLiy1JjTjKKTg8icemqZwaatAqDGWhXOGMIfUdAqcP1Pkfnu2oCwKtYCH7tfetN+HaUalpCwnaa3pxu41NHh+q2WY32tTfJPVU19Vhi+Y/KYAk54bXheqYY7mho3RnyNPmBdQHhzjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773993300; c=relaxed/simple;
	bh=C1qHtZnhg+mg1nZ+ZLrqNMOVGXld1K1Z3HJOJh3+DTw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jl1xlU6XT4QH2g5GgBGNJ6SCKzXPDIPB1LnnjbxtqAjgwGn7kzFyfBVrNCHFN0SObNjiBOhuL0ipxhOeqh4ui2EwpATbnSenbWuxhD2li61cqDFcVbKebyCrWecdDJ4gEmlVoc3IT3L4ZMdZ0XmL0tS0JN1DLR2vwK/4jzx7Opc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aliyun.com; spf=pass smtp.mailfrom=aliyun.com; dkim=pass (1024-bit key) header.d=aliyun.com header.i=@aliyun.com header.b=Jx5b/w/t; arc=none smtp.client-ip=115.124.30.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aliyun.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliyun.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliyun.com header.i=@aliyun.com header.b="Jx5b/w/t"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=aliyun.com; s=s1024;
	t=1773993290; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ZloVO8pl8FMj2kyV9MZkRGIkbosa4s+VBHILa1oS+Aw=;
	b=Jx5b/w/tPvObUxOzM1jM9Yrl1edB4ebeQEjuUc1KB8vxqhuj8cXDs9tHp9xardP8GQVH+vXJbU2thqGJLepxObYg/wrAeMMDw/6cY04nq6vBVDiJDJ4KMIXns2weIgJhoKqRDDjHFGQYwd4mkzZMcxw8JXoQNy7fsuIOg/OZ4EI=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.08044301|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00632094-0.00149435-0.992185;FP=14518606513632574388|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=ruohanlan@aliyun.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---0X.LBC6y_1773993279;
Received: from ubuntu24(mailfrom:ruohanlan@aliyun.com fp:SMTPD_---0X.LBC6y_1773993279 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 20 Mar 2026 15:54:49 +0800
From: Ruohan Lan <ruohanlan@aliyun.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: linux-can@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Ruohan Lan <ruohanlan@aliyun.com>
Subject: [PATCH 5.15.y] can: gs_usb: gs_usb_receive_bulk_callback(): fix URB memory leak
Date: Fri, 20 Mar 2026 15:54:31 +0800
Message-ID: <20260320075431.5695-1-ruohanlan@aliyun.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marc Kleine-Budde <mkl@pengutronix.de>

[ Upstream commit 7352e1d5932a0e777e39fa4b619801191f57e603 ]

In gs_can_open(), the URBs for USB-in transfers are allocated, added to the
parent->rx_submitted anchor and submitted. In the complete callback
gs_usb_receive_bulk_callback(), the URB is processed and resubmitted. In
gs_can_close() the URBs are freed by calling
usb_kill_anchored_urbs(parent->rx_submitted).

However, this does not take into account that the USB framework unanchors
the URB before the complete function is called. This means that once an
in-URB has been completed, it is no longer anchored and is ultimately not
released in gs_can_close().

Fix the memory leak by anchoring the URB in the
gs_usb_receive_bulk_callback() to the parent->rx_submitted anchor.

Fixes: d08e973a77d1 ("can: gs_usb: Added support for the GS_USB CAN devices")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260105-gs_usb-fix-memory-leak-v2-1-cc6ed6438034@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
[ The variable usbcan was renamed to parent in
commit b6980ad3a90c ("can: gs_usb: uniformly use "parent" as variable name for struct gs_usb")
introduced in v6.6. To backport to v5.15, replace parent with usbcan. ]
Signed-off-by: Ruohan Lan <ruohanlan@aliyun.com>
---
 drivers/net/can/usb/gs_usb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index ffa2a4d92d01..acffe11a0ae1 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -402,6 +402,8 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 			  usbcan
 			  );
 
+	usb_anchor_urb(urb, &usbcan->rx_submitted);
+
 	rc = usb_submit_urb(urb, GFP_ATOMIC);
 
 	/* USB failure take down all interfaces */
-- 
2.43.0

