Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794689420;
	b=kjgSZRbaFpU5rv1JsgUfCtgI1gC7/9Ve5rCuKrTtnQFUegkpGky6UskKEyU7kjZkJtGX
	 XEX06hLeQGNoJVTazpYqpsD8qK/tOWkiE9KLKGM1XVSgGRFhsF8epHP4U8G9YYrSdkeSy
	 imHUZs2eqNtv+ooPyth1H1JmFm2Qtj44o+BEvoKKwcpG1Dzsv+lQadntlgzoeOLmqwVWX
	 uQGrKvWeAev3fmfozqLLjdlXN1hBjPpzkRMGsIB5moaTEqBOBLb9LqT437wJb52XkqNy8
	 VjGr0D/GDelcKzfIAiI7irWwWLPpL8oUap7Bi4ot1ScV0KBUSbS6eVOCn7C1n2+R21Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794689420;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=5EBtSXIOnA6Lk+GR0MvzbQQYFcPAsIBwlV4OI7BVdj0=;
	b=YZRF+/wfb97oSzXkFQ60zs7+X+dGt56WmUDy7FWbHr5nVwH0ohaBxGi4HQYNWYRY2FgX
	 5XGUD+JdbytIg6Ux/QGSG8Oogafny+Y6HO2g2ngvIHVAH0UzS2/V8Q4MhWbvHWqKzhXD1
	 4PP8YcDTruQxzs2Cm5SosVsePSxAMbr8W10obrY/xKe/kC9NHNjWJnTpd0IGRDYlp+nG6
	 5eVkCZ3Juo2swc7syOL17duRJcAom9s6V4Cnm0TJWQshEcRWDcpiXJFvzul5Ejt569r2/
	 +8o2releOfvFp9+R5OkX8lDIIZu9DCQzY2lF8vKOlMTDeXBH4aKYvME7pZpJ5SEnPAQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Lw1tYLbA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FEE606A33A
	for <linux-can@vger.kernel.org>; Sat, 14 Nov 2026 20:50:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39FEE606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Lw1tYLbA
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 9B7EC20261F;
	Sat, 14 Nov 2026 21:50:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794689415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5EBtSXIOnA6Lk+GR0MvzbQQYFcPAsIBwlV4OI7BVdj0=;
	b=Lw1tYLbAnVjtbgUSbfwZiOD+5WOy1RstB1G4aTb5VGd0C7SSjzw78Ib2yEHRUDO0WnagvQ
	VL+tfSAaTue3K8n1aBfctKNcWPY37rDerpkwAq+j0K4MEMczCJwFTZiLnyBzC8JD//Q8x4
	ArehyYoQigkjPKOyXEISUKTPWJcO4VD8fl1UFnDvqYdEQLWHKRQLF3V2acWY5V/BD1VnU+
	x/3WuTlli9gX+anV6k69iY33dxi8cZcpHFjlY7RMvPzmio2YNyDztkKgcgFPUWpH9GVoFr
	jLidTZlr1UHBCZREkbARL1X30/mJLBIM4dz1DKnUECLyHy4QEXW983ZrFzpasg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794689415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5EBtSXIOnA6Lk+GR0MvzbQQYFcPAsIBwlV4OI7BVdj0=;
	b=Bybk0Jy3B9mx/cuxXQ16jZZ8Duh6JMMH8KW+YDrD5kSoiXc1II1Q/NaPzi39dNOrnBYZeg
	OOttWbuJ6opPOGwNWlHm9zYEnY3sJhHKqQjNuVaKgTex4YO4v2bZk8cuE/YO0JQ9JcqSEi
	btmm8kKIQhB3Pz7iSpvMvVLeIKWy8ORUtK6q3t4HdUiT4ryk9RhRmf4VsxJeF4INMfy1C7
	27mX1N6jT0zE+64C3/HnU7i7IpjS4AB09Y6F7RFjnceCJI+QYbmVMrD7ajTfspGCddx+gx
	5IA4PBqeKu1FFlGqPYWNUYUFij+gSRyIrqwZcClD3hxZxqgM3Sdpl0AcEfI2oQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794689415; a=rsa-sha256;
	cv=none;
	b=MWC5SBT+4RgQjcj3bVBuMje9pt/1748FhbdGJBU4sfCjvuBmMmoSNhRI6weu3zPv/fUH5a
	AGNNttoz75EsgrL94PgZnggkg8x27UGBTsYIoO37BBqnE/G0QmRTwrqac6gOsj6pKQNXdP
	7ZjAbYzFpcPgk+wVeBayov0Wb2Gijbwnb/qIfpuH0lwESPFQ5j+DEI17N0iBCvcB3Nmb6C
	As4HuDV1/xA6sNqVBBLasr9mAuRLOs4F0dR29XtKPsrwGOz9BXYpJUgwWW0RVkDHkc7Tq/
	VrJ6XxnPXpMAZAUuvOoBVIw2HzOcDik3vhIv6eJONFoEv1hl26fNsNmw/q8SvQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xSKhT-004BfU-1e;
	Sat, 14 Nov 2026 21:50:15 +0100
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 44E1F5EBD75;
	Sat, 14 Nov 2026 20:50:15 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sat, 14 Nov 2026 21:50:01 +0100
Subject: [PATCH can-next v8 7/7] can: gs_usb: add support for context
 analysis
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
Message-Id: <20261114-gs_usb-fixes-v8-7-f615502b005b@pengutronix.de>
References: <20261114-gs_usb-fixes-v8-0-f615502b005b@pengutronix.de>
In-Reply-To: <20261114-gs_usb-fixes-v8-0-f615502b005b@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, Peter Fink <pfink@christ-es.de>, 
 Eric Evenchick <eric@evenchick.com>, 
 Maximilian Schneider <max@schneidersoft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Donnefort <vdonnefort@google.com>
X-Mailer: b4 0.17-dev-d7211
X-Developer-Signature: v=1; a=openpgp-sha256; l=2656; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=bnSXbC0XQvNXl7F8OxlFceyqlo3LhvsiDdg2DEbn3cM=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsj6cbKltDXs5M4Fd/OFuF6I33iu2egwpdHwg4/98Zkeo
 tX2t5dldJSyMIhxMciKKbIs/XFCUSDQobT3ZcIkmDmsTCBDGLg4BWAih9oY/hnlsL7zmBFrOGfn
 u40/jv1xCOqPXWngVczy8sLiwoNxfkqMDC9PhStUurxLivVIdzrJI3qRWWTx9+UhEz8wRq1knLM
 ikxkA
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

Enable context analysis for the gs_usb driver.

Tag the hardware timestamp counter infrastructure in struct gs_usb as
guarded by the tc_lock. Add context analysis markers regarding the tc_lock
to the low level timestamp reading functions.

This has been tested on Debian testing with clang-23 and clang-24.

| Debian clang version 23.1.5 (2)
| Debian clang version 24.0.0 (++20261025103442+7e3c57157096-1~exp1)

Cc: Vincent Donnefort <vdonnefort@google.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/Makefile |  2 ++
 drivers/net/can/usb/gs_usb.c | 11 +++++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/usb/Makefile b/drivers/net/can/usb/Makefile
index fcafb1ac262e..b2e1539f1d52 100644
--- a/drivers/net/can/usb/Makefile
+++ b/drivers/net/can/usb/Makefile
@@ -3,6 +3,8 @@
 #  Makefile for the Linux Controller Area Network USB drivers.
 #
 
+CONTEXT_ANALYSIS_gs_usb.o := y
+
 obj-$(CONFIG_CAN_8DEV_USB) += usb_8dev.o
 obj-$(CONFIG_CAN_EMS_USB) += ems_usb.o
 obj-$(CONFIG_CAN_ESD_USB) += esd_usb.o
diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index aea29a33ea1e..7f847d474c9b 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -334,9 +334,9 @@ struct gs_usb {
 	struct usb_device *udev;
 
 	/* time counter for hardware timestamps */
-	struct cyclecounter cc;
-	struct timecounter tc;
-	u32 timestamp_initial;
+	struct cyclecounter cc __guarded_by(&tc_lock);
+	struct timecounter tc __guarded_by(&tc_lock);
+	u32 timestamp_initial __guarded_by(&tc_lock);
 	spinlock_t tc_lock; /* spinlock to guard access cc, tc, timestamp_initial */
 	struct delayed_work timestamp;
 
@@ -411,6 +411,7 @@ static int gs_cmd_reset(struct gs_can *dev)
 
 static inline int gs_usb_get_timestamp(const struct gs_usb *parent,
 				       u32 *timestamp_p)
+	__must_not_hold(parent->tc_lock)
 {
 	__le32 timestamp;
 	int rc;
@@ -430,13 +431,15 @@ static inline int gs_usb_get_timestamp(const struct gs_usb *parent,
 }
 
 static u64 gs_usb_timestamp_read_initial(struct cyclecounter *cc)
+	__must_hold(&container_of(cc, struct gs_usb, cc)->tc_lock)
 {
 	const struct gs_usb *parent = container_of(cc, struct gs_usb, cc);
 
 	return parent->timestamp_initial;
 }
 
-static u64 gs_usb_timestamp_read(struct cyclecounter *cc) __must_hold(&dev->tc_lock)
+static u64 gs_usb_timestamp_read(struct cyclecounter *cc)
+	__must_hold(&container_of(cc, struct gs_usb, cc)->tc_lock)
 {
 	struct gs_usb *parent = container_of(cc, struct gs_usb, cc);
 	u32 timestamp = 0;

-- 
2.53.0

