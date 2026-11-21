Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795300585;
	b=YYIG+13W0KLSPpLdcEDvgzaUBXImnDEeTJcq6JtEFqPjrs4yQt3kZQaC6v/ZdPfKqqMS
	 Gi/ynhYtbdfHHEB6QBpDW1ZcWW7N1/Ba4e3dE2kDlDjyCKjG7XUH3dPmPQQ6r3I+nMOzZ
	 AGs7c6lLMIjnMfE37YX/J3RPtfDq6pf9idGecnUK+BEXwaLT4pwecpP2uv1XnMmoe0MWf
	 hiXejfP/jYFy+aS/wI5jeEOhXxFsGS+ErYIJ0Uug+clKX9l6Mj2IzW5E9W6MT2flGOaix
	 xjas4r2E3LRcqFUG1XmBCISgUY24wFDHe80Id0CMlEsoa21HSL5OABfZmMslZMQgxrA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795300585;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=JXLvo1WAR+Al9W4Kw6S2AuG+Sa3ego5jp4oFH6LebEM=;
	b=xiA4vkCcYuNiZ2+JR8wwCS+0OYJfFRBulPs9QCnYqhfk+C74nQ5LJHFD6sloo1iivSnN
	 RG+/FBDDu7yfcBBqVd689jWgRCMAtWPkuJnRS6E3kEtY87Oli3B4oaBbxd9EPfc70khaB
	 rleLm+PAQoQn1Ma9DGDsr61xvbhEU+a46FLBLnjLjVfjN2ZMOWAsUs6uGbsScOBy+YtmA
	 zspaVBIjRijl7SK8juzuTZf57BUVPtY474hUUGDZhg+DLfTpMft3RjojC6S+HzzX9vmEq
	 CHNOHiDdMsRVYl3s9DVeRK2E6K1qpuSB4CZ4uKgRfbmFmmvaKy5gGPagc67JAwYnCXw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Fpx6J0tX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FFF606A333
	for <linux-can@vger.kernel.org>; Sat, 21 Nov 2026 22:36:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78FFF606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Fpx6J0tX
Received: from hardanger.blackshift.org (p20030102af17cb00849b19770537dbc5.dip0.t-ipconnect.de [IPv6:2003:102:af17:cb00:849b:1977:537:dbc5])
	(Authenticated sender: mkl@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 40BFE205A2E;
	Sat, 21 Nov 2026 23:36:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795300581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JXLvo1WAR+Al9W4Kw6S2AuG+Sa3ego5jp4oFH6LebEM=;
	b=Fpx6J0tXzSxbijfLFKMiiskn5WvEou3Eemf3rHkOtambvf/1hF1jnDKMAnijfi/zkb9vnW
	lUa1M4U8caHkFI35IOJQXpoUPpObdepe4bD7sSvanesthkOdm3bugeZdseb5rtZhdrmaih
	3BQ/YI5Rz4gL2+Oljc+1fbXqjMfLtRn39gDJ8IMTi+WYGkttDg2psJMkQUsz8gohA3Vw7e
	Fr1etQHeQM2qS7v/iRyHDVxbGuxu4rlc2+58LiXDS6m2xFmzmQQt0dkFvkqJl05cwLs9gE
	h8ERB7jIgIl+D4hUB28y36oybpOVeopb40Rmo5/f340Eugy6g8dWOFjv3UmPkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795300581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JXLvo1WAR+Al9W4Kw6S2AuG+Sa3ego5jp4oFH6LebEM=;
	b=I8IZXEQLyrmN9UgSDyrWIIHiPP5D76K7MyjxnNQMeW7y77e1nM8++JkReAGO+lEsUl2xwE
	UXK2vp5i32YngCMulwdTdnSc9Dfj5a7wDRY/rzJ88/sAEAJG1Ih+ZB51V1jruO+PkEemxT
	3ZBWxLE3Yb4lOsZDmMlTHne2fkKTa2Cg2mrqftWexlquLkT7TvOCI+HqCA6/zzrVqpcrTR
	Kwpd8SebTRRXG3JhDjqXCIvT7W6o3iShtHVPpgb+RViVpBxRc38BZhxh08rdYb5LhuJLCR
	Y1tNA2mSQn9oJWZ53q+wIkI5xraq0heHLbu+hsq+3OPkzQZwGqkJq9PNscMnXg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795300581; a=rsa-sha256;
	cv=none;
	b=AdurExMWDpWxEzYVwSfF7UHU16H7BVni1x7yfZY+y5aVjqwTDGKLGkZ5WU+pqoliK8bz2l
	Kt3mZ0aw+AvhZr1f43NrDVp1WrL4cugQ5wXp6KmTDrg44lERx/mqqaasqFHnSZ0MYqarQ7
	KqtrKt8pFoDx6uEK/QRscCeLI2ZmqtUVYzv+gEnGAnMg/Ei/cxybfI0vWv06pSCQTjPbXo
	RLnyJtl0eAKK93JBSPegwTPdXPe2JTFRBCYPtpjbkHml5HEv18hnywwe6qHXxxnDmqDJve
	zp+oS5lKs9ipso2b3z/F1LSVmbJdlcB45UQ4QN5DTX2a0sLujdtsV+cSssgSNw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=mkl@pengutronix.de smtp.mailfrom=mkl@pengutronix.de
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sat, 21 Nov 2026 23:36:06 +0100
Subject: [PATCH can-next v9 08/13] can: gs_usb:
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
Message-Id: <20261121-gs_usb-fixes-v9-8-db121d488945@pengutronix.de>
References: <20261121-gs_usb-fixes-v9-0-db121d488945@pengutronix.de>
In-Reply-To: <20261121-gs_usb-fixes-v9-0-db121d488945@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, Peter Fink <pfink@christ-es.de>, 
 Eric Evenchick <eric@evenchick.com>, 
 Maximilian Schneider <max@schneidersoft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.17-dev-1b309
X-Developer-Signature: v=1; a=openpgp-sha256; l=1825; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=Rvmcn+1BQDVgRN1BIKgxy0KuWZGC8c/3stN8gWoZZWk=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYshmkrnNwXeWKVo26lgu45LjPt9f38lmrfTd4xEV+3oOQ
 zqf4pcjHaUsDGJcDLJiiixLf5xQFAh0KO19mTAJZg4rE8gQBi5OAZjI9BRGho+f9LXZ8lWitr57
 83Wt1xN+8d3c76759fZ9XH1t39Gq8vcM/yOtu8P27bQvdV1YIfDg58ujYXxXs7MDbabaLt3qvdh
 KkRsA
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
 drivers/net/can/usb/gs_usb.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 308daa2645ad..f49179cbd787 100644
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
@@ -820,8 +820,9 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 				netif_device_detach(parent->canch[rc]->netdev);
 		}
 	} else if (rc != -ESHUTDOWN && net_ratelimit()) {
-		netdev_info(netdev, "failed to re-submit IN URB: %pe\n",
-			    ERR_PTR(rc));
+		dev_info_ratelimited(&parent->udev->dev,
+				     "failed to re-submit IN URB: %pe\n",
+				     ERR_PTR(rc));
 	}
 }
 

-- 
2.53.0

