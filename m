Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795373340;
	b=gtd5xeWm5jujvVp3UFKTCJBSeRq9Nb30dncYZfsEADUv3qlluqSIZHvfYy1JZi5ErjKi
	 Fcc+wMyPhZi9+ghk8gEIQnMZYHK2S3T5lEB91eA30MiqNHgMdvB4vm0D8q7Wcg1+O/2G3
	 DxlvhRwBbB2b7h6NkJgAUgZytn7OCG0AICCe4F+EAKAgl7dhgOmbg440KMBzBb3OzNOpE
	 ySidbx8EjQGXuq69iraIwR1uStNNw3XUe71Nkb17jz7CkKJFl597y3g/y1jGJyAZOrFib
	 2V0/BiPdYM8suq7/UMTd1lizaBHkCRV2J5MV+5U6V2kVD9ujG3F2ckToaq2GX0Bd4ww==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795373340;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=RxoN3Ar4ajNLXBB/QR5Bu5Ks5okFDxUhPBhNm/0IiVc=;
	b=wQl1/BuemSro0Vz0MAQF7AEj1ZQjawJmCjM/3O990oELEIKlMg9bdgIah2PzRiUUTcc5
	 5DAJbpFEsEwugXRt4H/OOdlHxFKRCI/vGMLRdJXA7mc2lkvAZfnS8ZrY9/Nw7Ri8VwElS
	 2SDsmdkWstTscsPHVtd9MX7u7/b+hhEmfyVTJsWeUzm3Idg2nrN+/AFGd43/Yb04a2HGU
	 Ss48KkoQEjUzaGbXL0QfTChd5JOUzwaPtdGJ5MLVJQz6r9HO5xKo5HV0y4FUA+herZQWG
	 Fs6rTUgO4by5LA3macnPHc2kLWPgEapp57FFB5Ze42KOeuoqMzz6CErzziH2FsqKzkQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=SXsNZ6JY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73F1606A684
	for <linux-can@vger.kernel.org>; Sun, 22 Nov 2026 18:48:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C73F1606A684
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=SXsNZ6JY
Received: from hardanger.blackshift.org (p20030102af17cb0015d71b554e0d6387.dip0.t-ipconnect.de [IPv6:2003:102:af17:cb00:15d7:1b55:4e0d:6387])
	(Authenticated sender: mkl@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id F3836205B32;
	Sun, 22 Nov 2026 19:48:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795373330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RxoN3Ar4ajNLXBB/QR5Bu5Ks5okFDxUhPBhNm/0IiVc=;
	b=SXsNZ6JYrHIBfDGkiEtRX4T8sz5sXFY3SRe5Nd2C66oSkjgyD1VnimyU22mHbFxqwy/H09
	q2Ajs0eRMF4TR4NmCEqaFv4q3t4iqCEwriZZnGXY+ZFsk82GiFRq+WrNw2QwCDw53kUPu1
	VXQRvu8xGPt6+FfRM4h6MsfrP5Uor5+maoekA7+FkDo7LYwRwLlk0hvRYzkd2IbSdVzZSx
	raEWS743akY9mVwb4n1IYqf9ovxbA2O1r4nN2uIJM5Hfjy/iiltaJ71yFhsMTtUeYH3+j9
	W0UokOrjRnmE9TSkIp232rBKpnKXbUS1DIcoVL39PE+fZTR6CRTWpRS8lrV/sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795373330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RxoN3Ar4ajNLXBB/QR5Bu5Ks5okFDxUhPBhNm/0IiVc=;
	b=JL00qxqhR+2krEjOeAi3pgoINvYlAljEitqELw2AccBPm4lGrK8hhEjWoNXRRVneGWa9A1
	QMsY4a5RFxuTj16cuzs6gVrQnjZqY0jupTcYyRtATYwr33J5DIgBiTiuYh5mXAjgUQfFdr
	oDbBXD0FE+czPniaLmll+EC4mjJU8aDG2oPzHMePlWEC/0yzMJoOWQdy+hFeEtds0k9oGf
	EQLWAQPOJzHhCLf8vlFCshzbME2HlpxoH0uGE3FRfhMTltKy/kYmCHHJgU5BjJiG55XLuO
	qNS/XIPTz2OS3s14dbhxuhzt5++guKiy2TL3tSnYl2HJnSDm3AJhzrPtA5ZOCA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795373330; a=rsa-sha256;
	cv=none;
	b=U+M0OFRjiAj7e2/eYvun2Yqn4q5OT+JnkAEb4+hTxyA+MWm2dB/4sqr+02F+AX7VHtJ/gC
	lwGzyCyq2wfCT8xXcOkBh6eOLCHqEES/kSounK+8kGgZ1XqRCG0vpzd97SXxnl8jrapGuU
	2peGFgbg3EIwqkRDjZ0uyaKL+kUlDyikm3uKc/eHxgi2A8En1ZsBVn6WANOhy/f3ErjWti
	GOexfsQhdSHlBRiyku7hJl7CDrhD9fQhW3Xfoghngynr/NgJB5hvFul4ArC1vTw6ACBele
	yx9ExHiYqOkEWmBYpMTkxC5Ys6ToQRkTn3P6NyAkoRNd04ohW/LwqW7NR1bEhw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=mkl@pengutronix.de smtp.mailfrom=mkl@pengutronix.de
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sun, 22 Nov 2026 19:48:30 +0100
Subject: [PATCH can-next v10 06/14] can: gs_usb: add support for context
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
Message-Id: <20261122-gs_usb-fixes-v10-6-7c165c35d04a@pengutronix.de>
References: <20261122-gs_usb-fixes-v10-0-7c165c35d04a@pengutronix.de>
In-Reply-To: <20261122-gs_usb-fixes-v10-0-7c165c35d04a@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, Peter Fink <pfink@christ-es.de>, 
 Eric Evenchick <eric@evenchick.com>, 
 Maximilian Schneider <max@schneidersoft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Donnefort <vdonnefort@google.com>
X-Mailer: b4 0.17-dev-1b309
X-Developer-Signature: v=1; a=openpgp-sha256; l=2747; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=3SELfmqj3XhEW7MRsv5fnye38YydHXQGRKunQmdbDVw=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYshmtmSLX/FbUm3z5drzr1avPMtzzY9ZyTiut/LRbvOto
 WnPvy827yhlYRDjYpAVU2RZ+uOEokCgQ2nvy4RJMHNYmUCGMHBxCsBEbosxMswwab18mVE1JODn
 VC3d9B2Sf/v8F1+9aPFthXIrx5S3G38x/E/PuPuZ3SLYcNe0n5FvOirmWr8NX8jx6HxyeAznx1v
 bPfgB
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

Enable context analysis for the gs_usb driver.

Tag the hardware timestamp counter infrastructure in struct gs_usb as
guarded by the tc_lock. Fix the existing annotation for
gs_usb_timestamp_read(), add context analysis annotation regarding the
tc_lock to the low level timestamp reading functions.

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
index e1a10e39313d..ab82dc07f3f5 100644
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
 	unsigned long tc_lock_flags;
 	struct delayed_work timestamp;
@@ -412,6 +412,7 @@ static int gs_cmd_reset(struct gs_can *dev)
 
 static inline int gs_usb_get_timestamp(const struct gs_usb *parent,
 				       u32 *timestamp_p)
+	__must_not_hold(&parent->tc_lock)
 {
 	__le32 timestamp;
 	int rc;
@@ -431,13 +432,15 @@ static inline int gs_usb_get_timestamp(const struct gs_usb *parent,
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

