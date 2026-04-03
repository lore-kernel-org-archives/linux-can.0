Received: from out30-70.freemail.mail.aliyun.com (out30-70.freemail.mail.aliyun.com [115.124.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548A15477E;
	Fri,  3 Apr 2026 01:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775180218; cv=none; b=Of9VXOgo3luGkYsmyXS6agAjNiX1szj4c3dbK1RJ9d6xST/yNmdjok+NTK/27TFeeRFtXLNX76O5oljOnolwzGhNCQzcnwjGxggZYHTWZab9US9EsCxpuAHa1NkdKEqfd3xZLO6gIbe3glDPYCzDkMinARZySdzB3oOXS1GzUpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775180218; c=relaxed/simple;
	bh=VIhw0HCDA/c0KTUe7LhunFZ95IB6FITXo8yko09bBbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gl/9xMZBFcnWv2PvsMUOwar1xFL0Csq5SHb2GvDVkTqZ2DXbEcmORs8pMfEGZfCZ3SssUSEu8//9bO/uE09uALYG8qLehSu5jf4kqZXAYjC3a3dZoZx4n6oo3a1+BlO00O7LDvyYinpu1ivr9GTH3AJ1gZ8svnbZ2pkxkA36HKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aliyun.com; spf=pass smtp.mailfrom=aliyun.com; dkim=pass (1024-bit key) header.d=aliyun.com header.i=@aliyun.com header.b=g9TR2vvX; arc=none smtp.client-ip=115.124.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aliyun.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliyun.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliyun.com header.i=@aliyun.com header.b="g9TR2vvX"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=aliyun.com; s=s1024;
	t=1775180214; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=lZc4BD+uiI4/WI9aq4csZmCKiq7hzj27gmEcmhPKW4I=;
	b=g9TR2vvXOBxS1fGCORSQnkCyv9s4Vf4XIskg/hoRoN2yLKdBmoBg/4UZmkpwJQDbxg2KgV/eG3zelu/c57qv7C3igyCqLzT6Nab4R4w0/aR80q34xcDyJnZU0fKPmQ4uv4dEOH542WgPMCYq64+KDOSH60J9hMxVl2e3iVlyjXQ=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07713097|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0176279-0.000944149-0.981428;FP=9894823531508417194|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=ruohanlan@aliyun.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---0X0IU04n_1775180212;
Received: from Ubuntu24(mailfrom:ruohanlan@aliyun.com fp:SMTPD_---0X0IU04n_1775180212 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 03 Apr 2026 09:36:53 +0800
From: Ruohan Lan <ruohanlan@aliyun.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: mkl@pengutronix.de,
	linux-can@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Ruohan Lan <ruohanlan@aliyun.com>
Subject: [PATCH 5.15.y v2 3/3] can: gs_usb: gs_usb_receive_bulk_callback(): fix error message
Date: Fri,  3 Apr 2026 09:36:15 +0800
Message-ID: <20260403013615.4641-4-ruohanlan@aliyun.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260403013615.4641-1-ruohanlan@aliyun.com>
References: <20260403013615.4641-1-ruohanlan@aliyun.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marc Kleine-Budde <mkl@pengutronix.de>

[ Upstream commit 494fc029f662c331e06b7c2031deff3c64200eed ]

Sinc commit 79a6d1bfe114 ("can: gs_usb: gs_usb_receive_bulk_callback():
unanchor URL on usb_submit_urb() error") a failing resubmit URB will print
an info message.

In the case of a short read where netdev has not yet been assigned,
initialize as NULL to avoid dereferencing an undefined value. Also report
the error value of the failed resubmit.

Fixes: 79a6d1bfe114 ("can: gs_usb: gs_usb_receive_bulk_callback(): unanchor URL on usb_submit_urb() error")
Reported-by: Jakub Kicinski <kuba@kernel.org>
Closes: https://lore.kernel.org/all/20260119181904.1209979-1-kuba@kernel.org/
Link: https://patch.msgid.link/20260120-gs_usb-fix-error-message-v1-1-6be04de572bc@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Ruohan Lan <ruohanlan@aliyun.com>
---
 drivers/net/can/usb/gs_usb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 134f830508d9..fd9a06850c95 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -297,7 +297,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 {
 	struct gs_usb *usbcan = urb->context;
 	struct gs_can *dev;
-	struct net_device *netdev;
+	struct net_device *netdev = NULL;
 	int rc;
 	struct net_device_stats *stats;
 	struct gs_host_frame *hf = urb->transfer_buffer;
@@ -419,7 +419,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 		}
 	} else if (rc != -ESHUTDOWN && net_ratelimit()) {
 		netdev_info(netdev, "failed to re-submit IN URB: %pe\n",
-			    ERR_PTR(urb->status));
+			    ERR_PTR(rc));
 	}
 }
 
-- 
2.43.0

