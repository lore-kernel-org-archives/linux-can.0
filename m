Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795373340;
	b=QSN+BgYSSP+EDmOiN6aqg0gZavjHNk1ZwDux/79aWE7NLkRZsaZBDo4UZl7GQeM4RNJj
	 7blZyUheSJKfoh05wXfVYEcuVuqgbhWT1fN9Z5c8PP5VBGuswcLPvddCUx528HRE+s106
	 OI91PHrRlFaruf59dVKmuh0SckFDbJVTNskQ2tNaIWmqJImFanNy1ejhXpArqzXioUZ5i
	 ONb40EEwhrjvXhnxDdzFyA60LohjVf1AKHnByeLlMGD4hF7pTeTlMNwNMoI72T8/dMSYG
	 CTNHNG9ZkGtK0rztP/NtyjSg+WxOdHRdoCwU2Ja5+x7yDkhHQJR6imYGdzB2rLEn37w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795373340;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=wyhi44QQ9BLwppQT6vRBrf8bUAPP3HwXPUDCgPtnQCY=;
	b=JXDwD9iMsoQWAk2mHDoiHH09IB+BXQhowBx5opd9LXxzBOy+TSgYhelTixptSMqoiWmm
	 reAd+IjQLFk/Xsyam82dITsYmxAyuupXqivtX05HgLyVrlN15Zbxf5+dt2PS6QxCxUY0j
	 TGtPCuKbAfqzsGb+1RjrByv8J4ZrEIbLFx3uiBHsIwpBUw8TudgxRRr5rhUGCQ2nrHGeK
	 x7VAOBmIlw607nkyhlwTNiko4hzeMizsucBrApYdI+AK7ceylMP2FO2YMt5xuuWCxCZib
	 eJcsvq+FnyBgYaDFK2EWS5noDxvNLbB+Jidtkoq3FzB4Us5yzdx0sNNyM3QR3+nM0EA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=gw3j9wPZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76E2606A68A
	for <linux-can@vger.kernel.org>; Sun, 22 Nov 2026 18:48:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C76E2606A68A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=gw3j9wPZ
Received: from hardanger.blackshift.org (p20030102af17cb0015d71b554e0d6387.dip0.t-ipconnect.de [IPv6:2003:102:af17:cb00:15d7:1b55:4e0d:6387])
	(Authenticated sender: mkl@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 631D9205B35;
	Sun, 22 Nov 2026 19:48:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795373330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wyhi44QQ9BLwppQT6vRBrf8bUAPP3HwXPUDCgPtnQCY=;
	b=gw3j9wPZgwGTEIRNSsg6xvXteF6+V9i+vDUxo1JnpKnqFFT21ZEqYAVt5gJYbeEU8kGpnI
	Bs5prKxGGdxu4UZmx+XmnZleCItpDcTnd70jNR8LP1U5NbMUMT9GvisHmPPDXvDGNXlMgM
	jYKqjbGVfaS9uiyJHOylks+rQNsWUjCWghNwXdesx8WCasx2OYwHmTRSkphG0RDhEXBH5Z
	5vC+4I7yKJUP69y+TQxD4ej0xPYvhkaj9XL6qq9kGQ4dm7RCh84hgRurHLOxerM15Pg27g
	5u6WjN4yA7KmSnd+94MjmXYb8n2Od8LsPHZ6QyC8BJmQxIFVUGvW/azrp7Pywg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795373330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wyhi44QQ9BLwppQT6vRBrf8bUAPP3HwXPUDCgPtnQCY=;
	b=gsT67AKN8pHXmVn/E/9vkq8mC+22IWzf3N2zCScxBi6hxkKN+gzuzOgnwxA05JhDV6o/mL
	bXVx7caqa0Ts5kTiA+Jx9W98q7LH8Ox9bRNrA62aEAL4tJ8j8Jw3t1hxB2fFmbfJUAgVKE
	dBEm7KmvkA6g22zS0l2IIvRM1RwCw9+Rmy9ddzHIghyD6hbJuaopECMFFnC2qjqnWpdVef
	+2e8AXwVq1tCRf/5HwnS1+KA0UTZunRTaNrOsCJUhCEI5nI7ER3dSc8LWzU2Uku0M/QbrZ
	0X7MxUKs7n4A8TCkxVWGeBcmh68fkdDzNra79ivdeu05jBP0x42gW7vYTOtz8Q==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795373330; a=rsa-sha256;
	cv=none;
	b=E9uIcySahAxNTiJ4ZGNyEJXs8NENMtJWR//THAN26GUWRhaqvFYtV1CR+FtQSE80fNVGYC
	oTRmiBR0PR1nHMJFGtVHVU/xQq72RuGXyj3MkjsW/S7lBWsxwH4JPT+dK/wuAnCSZdmBER
	iTtrnhUCiUY7/vl5ra/clgn+0b60S4/XCgdTMZfr9kWExllMjv4qLtnOsrlFtgntcOYt14
	RmBKIGtSXgW8GgAddBsxp8zEXBnF9Vh6w14W/KsAgP64NHK0+sz8Ct5kWkTnU6uhCXLDzR
	i7MDzUFl/FA/th63i4S1WXZU8RxZ431SBf4El5Q1kwt9vy7ACxgv0E0tyAb3Gw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=mkl@pengutronix.de smtp.mailfrom=mkl@pengutronix.de
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sun, 22 Nov 2026 19:48:32 +0100
Subject: [PATCH can-next v10 08/14] can: gs_usb:
 gs_usb_receive_bulk_callback(): use dev_info() to print re-submit info
 messages
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
Message-Id: <20261122-gs_usb-fixes-v10-8-7c165c35d04a@pengutronix.de>
References: <20261122-gs_usb-fixes-v10-0-7c165c35d04a@pengutronix.de>
In-Reply-To: <20261122-gs_usb-fixes-v10-0-7c165c35d04a@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, Peter Fink <pfink@christ-es.de>, 
 Eric Evenchick <eric@evenchick.com>, 
 Maximilian Schneider <max@schneidersoft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.17-dev-1b309
X-Developer-Signature: v=1; a=openpgp-sha256; l=1890; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=+AGwZ/pdAhRpXFESCgQ4UcYq8/Ar3rnL+fMR0UX3n9g=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYshmtuRoZNzZtrFbNv7qgbZlt+yylHyd1vmfWHkuIqIyf
 Oqkrbf7OkpZGMS4GGTFFFmW/jihKBDoUNr7MmESzBxWJpAhDFycAjARiWyGf9qv87qc5Z5s3t+4
 w5Bv4bM86biMqlN3pjHLs8p/OujxX4Dhv+959evz93zJeTJz/aWQAreLt/MurrlexCD6dpGV8XG
 jwwwA
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

If an URB is retransmitted (due to an error) before the network device can
be identified, and if this retransmission fails, netdev_info() operates
with a NULL pointer for the network device. Although this does not cause a
system crash, it does not provide any information about which device is
affected.

Replace netdev_info() with dev_info_ratelimited() to output the affected
USB device, and also rate limit the number of messages to prevent log
flooding.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260729102802.505168-1-mkl@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 308daa2645ad..75adec495e65 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -655,11 +655,11 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 {
 	struct gs_usb *parent = urb->context;
 	struct gs_can *dev;
-	struct net_device *netdev = NULL;
 	int rc;
 	struct net_device_stats *stats;
 	struct gs_host_frame *hf = urb->transfer_buffer;
 	unsigned int minimum_length, data_length;
+	struct net_device *netdev;
 	struct gs_tx_context *txc;
 	struct can_frame *cf;
 	struct canfd_frame *cfd;
@@ -819,9 +819,10 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 			if (parent->canch[rc])
 				netif_device_detach(parent->canch[rc]->netdev);
 		}
-	} else if (rc != -ESHUTDOWN && net_ratelimit()) {
-		netdev_info(netdev, "failed to re-submit IN URB: %pe\n",
-			    ERR_PTR(rc));
+	} else if (rc != -ESHUTDOWN) {
+		dev_info_ratelimited(&parent->udev->dev,
+				     "failed to re-submit IN URB: %pe\n",
+				     ERR_PTR(rc));
 	}
 }
 

-- 
2.53.0

