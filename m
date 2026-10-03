Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1511039A4A0;
	Sat,  3 Oct 2026 22:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791068029; cv=pass; b=jvZwM94a85aIBkv4oSv+yIT955Tzs0Upd4SCJkg/kOQfkW5KsgCLEIuofOXn29uL2nfJu8Xwt3jXn14voxRZ71IjmJGg5eu0xhIlrqm6xvPs7n0qwG5CZijb7CEtSW8+eQvwdUkX9Ppnf86V52UEHi4GxXW7AEs8fxi31qURC/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791068029; c=relaxed/simple;
	bh=LcUvnvxrbu2my4RNhR/Kmhs6iAlD6Qy7TEgJ8QDCpJc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DY2ZvTU08x1ac6uPfYqrZinXGFbyJ+NZFST4mK6vp4lgFv9tIeJZhnIJe9Mzkf7Rb88d3Z1uO3nKHL9wvldo9qDwaxI2NLRSQruQHZAhA8IitOH3xU61m+gE27wYoMsE8+0VHuhix2EVMUS6JMdbWLyxizeMetT6z+zMx5wJidw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=VCv3bV2n; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="VCv3bV2n"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 239CC2022EC;
	Sun, 04 Oct 2026 00:53:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791068024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jIccs15glYTHlClekOm976D0HxHBQoiJDjvSzGkMQOA=;
	b=VCv3bV2nQNQ3P8h3sr2h16qXw4NyuHJHgkH4xQBpAt1rYzIh7WjxfG+phndFRBuP88+nV6
	OZIyfL5aRLQFlFArUlWZfh3sbsSUSuxX96VrzKzP1dJudoBSwygHigdz45Q4RN5R6F7aJB
	QNQPxj2pbLlZlV2RkkfcZCvbnogKw2ppGXWu5vcBX7HFaanmieKcvm28lAVFkaTB20fhzq
	igUPd7n4KxpcIrz/dsZVGV1sVHJZ+q6EzywkLMb+avcXTIF+QweTX8mQ7yB7VdXU/Bj8+9
	aaM4cEGZ7tJuFDzgxUZNwLBrkRubqW0RmlqFOWg3x92WHu3tCQH0vfMsGiMjyg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791068024; a=rsa-sha256;
	cv=none;
	b=Rl8dZ+3XHYSP461d/cAIbwkMtuZNEzyUnZ5QRm/oQ8YFkX7FwgSD6+U9YQ1u/5SDVQb10o
	xINr2I+ErTcS8oNrl8K1ltYIuTL+14HMFtpqDxzxkh2h1qfgqQxVpnn48rmtpTav1n6ICl
	9s9bqo+J6yCxCxye1pYJFDS8CziXVu/a5VKnpxSdxG9kyBg5Xv/3w93xAlziuTZTj3NpxF
	4uJJ1HkHfuXrJxFGOogLAr1pwG6XzV2FbhTFTiYRsHHbDrVQ7SEsi4Vx1G4iSVgSSk59rx
	k/M+OXhySoCW3LEhRHPfCVUP7/OuMm3sM7Pi10gDesI8SqmSNaTkoimwlKy/fA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791068024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jIccs15glYTHlClekOm976D0HxHBQoiJDjvSzGkMQOA=;
	b=T2HSlv0Xi/2xF7B3+smaRKwlWIgNzO8Njr55nd45oOJSQAnnExiXvzqnBlUEc1Me3QWYux
	oSNvNfAul3iyQeYhbOzj2s+cK9IC+PuYKPDYImLz+BE3nfDhJMoWCYOkbLuqd/NV22qwwN
	pucKc/MA/ssOgLhm88JQnw8Rhd8kzG4GYRwaOUQgch80vYG8HL9162iQzky4ljmpWtq7F+
	UM+JTX1OEWIgeaFDX7ctKyeHIe5Yy1G7TPzhI9uBqynyPwV1SjQo1jBUXthMqa3Ij1Sgoc
	ZZGZWYhbe0fLUONyqBxflHdoseimW/oDR1XYRZ0eZPh2V4phXez30BAxjFVgUw==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xD8bv-0047mf-2z;
	Sun, 04 Oct 2026 00:53:43 +0200
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 9FE645B93A5;
	Sat, 03 Oct 2026 22:53:43 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sun, 04 Oct 2026 00:53:12 +0200
Subject: [PATCH can-next 03/10] can: gs_usb: gs_make_candev(): reduce scope
 of variable bt_const_extended
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261004-gs_usb-cleanups-and-fixes-v1-3-7b4b06244a77@pengutronix.de>
References: <20261004-gs_usb-cleanups-and-fixes-v1-0-7b4b06244a77@pengutronix.de>
In-Reply-To: <20261004-gs_usb-cleanups-and-fixes-v1-0-7b4b06244a77@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1097; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=LcUvnvxrbu2my4RNhR/Kmhs6iAlD6Qy7TEgJ8QDCpJc=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsg62J63Qv9d+ie7vg2RL7b5zuqu6VlzYjnP9mVzi9Zyr
 9oRa6W0qqOUhUGMi0FWTJFl6Y8TigKBDqW9LxMmwcxhZQIZwsDFKQATmTaB4Q//mQ8a7v9qLdm8
 Uq+um/XjH4f60X2cquvVXzWVrHz1KaaT4a9c6aub/bEs1s8r6ncUL7h6XqxvQ/87xmvdDZ6tE02
 fN/EAAA==
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

To improve readability of the code, reduce the scope of the variable
bt_const_extended.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 5e96c1a7e5cc..b0e7202f0fc0 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -1305,7 +1305,6 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 	struct gs_can *dev;
 	struct net_device *netdev;
 	int rc;
-	struct gs_device_bt_const_extended bt_const_extended;
 	struct gs_device_bt_const bt_const;
 	u32 feature;
 
@@ -1445,6 +1444,8 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 	 */
 	if (feature & GS_CAN_FEATURE_FD &&
 	    feature & GS_CAN_FEATURE_BT_CONST_EXT) {
+		struct gs_device_bt_const_extended bt_const_extended;
+
 		rc = usb_control_msg_recv(interface_to_usbdev(intf), 0,
 					  GS_USB_BREQ_BT_CONST_EXT,
 					  USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_INTERFACE,

-- 
2.53.0

