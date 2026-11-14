Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794689420;
	b=jByfqiXIhtwoTk+CvD4yr9JFv/MDzibP9QFEhxVJ7Vr/fQ0MEb33Qmwv91bFqANk9K9/
	 vNV4gMyV4bvUkcPcrtaX6jSQnJ9XeC+xVkwrPGminTTeLpc+v3H8C4rIm0K+WkR7bRAhx
	 eGNKBKEAFqtokN0Hi88ai9HY3FHUqgPli0TwSH5xCAsNyD7w5G4qfeoyPr7iKF8/wYlQ6
	 ZyP2Z5cXcelCnV0p49yTlJM90vHktZVn+eRC8+3DZ1zcDgIpQIWJqZNA9UxuOsETdXTF9
	 /oHiesqicVmvC1ZarRifjKyoOC9VYqL865X6usXDPm+et97n+MgToqv3y30Pfs2UERw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794689420;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=vOFmc4Yeo0fWErswjdyTtjgP5ZLHBMpR7ZanfIGc/eM=;
	b=C+0qA5osvPPB2uBxWpAndeV3PSdpOpJNpgkrbM2BpwK0Ps+7t7LQgKsr/ObRRzOFEMjf
	 s1aarAsS/Ys9+OQDNzYqgeaXsq8nSs7sGtt7WfKTfvGanFVKR0/QvjRasSPWzzWn5yHCt
	 9757ub2YsPFsp4wcqwWqWgdzoi3fh2dOB+5XZ9/gvYT6udVX4lOkW2r8z1vYMx9+6CoVC
	 ee9Aax7NnzvPXe2AIYqraxlCEV0mQRGCGqFglg7GnG92TGmROyfS0syRwOCMxJMEEeJYB
	 f6yf5f3B2ZjruNsbI2DynCSJsAiE/9A9vTufj73/5u0g0FO2k3gWPyMc28PLZSggnIQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Cyxij1EK;
	arc=fail smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA4F606A339
	for <linux-can@vger.kernel.org>; Sat, 14 Nov 2026 20:50:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CA4F606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Cyxij1EK
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 91FAC202437;
	Sat, 14 Nov 2026 21:50:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794689415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vOFmc4Yeo0fWErswjdyTtjgP5ZLHBMpR7ZanfIGc/eM=;
	b=Cyxij1EKMy4uIObdFZm3mOr4RuH+n7xdW89fgZTNBOczttLwfDvxXaJNOKafaY9n9R52li
	0axG6FztKJYZViD4U4t5+QC/LJu0YYHYBwlw0vAgzDblbky11VowSNbKf4ZGtLr8lubD3o
	Q3b0fF5fVCF/NswfqH/9CXv5RfSWN6PGl2dbt8CnEJW08r1NjPVzMRyNHtTEs9/bK6lJHA
	HbjN+pzX5mcgyK76e1tz6jxZFYq7MnchemkKXRRiQVGsYYwkGEdVB7gSnY3D/NLZW2KDqF
	WZdhQ9ZYdYUtZNmwvLNGQ8fO3lVle8DKTttuX59tPPYsZR6VN4NEfhJGVlpirQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794689415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vOFmc4Yeo0fWErswjdyTtjgP5ZLHBMpR7ZanfIGc/eM=;
	b=cFjLacoeojykCFEec188AOCJmtQs5nGZHK0CCHYpPAQHPXAkLW+e+2AzbXynC1ZuQ8CDC0
	Rvnd1qfcXPnt9mudtqzk401LikIhrzXeYZ01F/oKaKllniHHBYlJmmus+LWTlEcSnxWDWy
	ZevRO5Vos/52manS+Q6TlmQtKwTGmXCiN0JAOvRHtuK2JXms1mKxvBQ5G1L/aB5o8p3Epv
	WXkKBUsgvW2JVTc9S6MWfbpAiRplah0YTsi/E3WD9fynuxpySv8aYA+7aj/pS57fOLCkPZ
	C16yQqOT/+MrNB7hiYKpoM5EVr1znAwTGHSPfxQR4JCPq7DpCHGGzFu3NrbOCQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794689415; a=rsa-sha256;
	cv=none;
	b=O7LuhFTZWhk9Jp4JZwLmP3M9/Wgn2d20jhPJgaRu6twxrG1/sk2KTOeFO1laL/Cqos0dIL
	yl+AeJG3An9PmCYpLfL48gkm9Xuwm0B2DOK6Fr4sqsKvRREdvlcmBNZyWdqc8dPCgWUEJ2
	3mojw7i96eyEgOjperQMFQhzE05lkxesa3UOdEZUiwcfFhmmN3THxW/9e9eXbmuNiibNfS
	zw07iwC35xnybxhbrdB8QCvVErhM2vMRHZ7KMRKIZQ5v6f7NMCyo82rJPMg3zILaF0Myhj
	SWmvXy0pRjZrk4fNQFIffGAWECand9vhPB6gMvmxu7KCV1cZTomihbFGBVA2vQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xSKhT-004BfR-1Z;
	Sat, 14 Nov 2026 21:50:15 +0100
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 3BDA85EBD74;
	Sat, 14 Nov 2026 20:50:15 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sat, 14 Nov 2026 21:50:00 +0100
Subject: [PATCH can-next v8 6/7] can: gs_usb: properly shut down timestamp
 worker
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
Message-Id: <20261114-gs_usb-fixes-v8-6-f615502b005b@pengutronix.de>
References: <20261114-gs_usb-fixes-v8-0-f615502b005b@pengutronix.de>
In-Reply-To: <20261114-gs_usb-fixes-v8-0-f615502b005b@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, Peter Fink <pfink@christ-es.de>, 
 Eric Evenchick <eric@evenchick.com>, 
 Maximilian Schneider <max@schneidersoft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.17-dev-d7211
X-Developer-Signature: v=1; a=openpgp-sha256; l=1372; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=/W4Z0HgeZa4B9KVhQrgrK+cMWaku0exJ8zQEKkBxLgw=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsj6cbI5a7PtqWWTJDpy9sz05DOt/X36/e89Ueb/n4Ypp
 n1zXLSsraOUhUGMi0FWTJFl6Y8TigKBDqW9LxMmwcxhZQIZwsDFKQAT+STEyDD3gtx26cbuK7mW
 m9zXPL6wt/UU99+LMqXPKzSOBflnmIsyMpyust4n4hlw8oOfh+rr3qzDt3f842Q9tUaJXf5Sufg
 FO24A
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

To avoid self-rescheduling of the timestamp worker, shut it down using
disable_delayed_work_sync() instead of cancel_delayed_work_sync().

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 6b65f4d9e8f9..aea29a33ea1e 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -495,6 +495,7 @@ static void gs_usb_timestamp_init(struct gs_usb *parent)
 	spin_lock_init(&parent->tc_lock);
 
 	INIT_DELAYED_WORK(&parent->timestamp, gs_usb_timestamp_work);
+	disable_delayed_work(&parent->timestamp);
 
 	parent->flags |= GS_USB_PARENT_FLAGS_HW_TIMESTAMP;
 }
@@ -522,6 +523,7 @@ static int gs_usb_timestamp_start(struct gs_usb *parent)
 		cc->read = gs_usb_timestamp_read;
 	}
 
+	enable_delayed_work(&parent->timestamp);
 	schedule_delayed_work(&parent->timestamp,
 			      GS_USB_TIMESTAMP_WORK_DELAY_SEC * HZ);
 
@@ -530,7 +532,7 @@ static int gs_usb_timestamp_start(struct gs_usb *parent)
 
 static void gs_usb_timestamp_stop(struct gs_usb *parent)
 {
-	cancel_delayed_work_sync(&parent->timestamp);
+	disable_delayed_work_sync(&parent->timestamp);
 }
 
 static void gs_update_state(struct gs_can *dev, struct can_frame *cf)

-- 
2.53.0

