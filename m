Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795300585;
	b=FJY7mr8AwbrLrIu0vvoul/QpfAx+YnRFbcbnwVdFbOWNZOgQHRf8QliPmZ4fQ3bCk5DO
	 0pwrf2cJLXAdHzpbUNkoibgamFQpwW6rfB7cvRB+dGZB/cL5DSFPgLTI17aU/ZHe/HICg
	 f5Mgu74GfSwvtsE5aUMm8LH0z2Z6UnvLMqE8SInLyOi2V+4wga2Fpks92BU/MwSR1Xxdb
	 StT9eJXzSBDTZtMf6hh3ySKraIWE2dhwdP+dGgPOW+LifXBiCOAtcZW9k+iw9jEcKxhua
	 YyobzOJFwcX9p6qz++Jt7Qiw3UUtiIW+qNxgZndMClrIVmlmBwrHlmnFF/qVh4HNsCA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795300585;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=sXi/Fa4eCFKmOEHorsNpqjR7CROjNY2HMP6M08/m8xc=;
	b=e5nkDrgSKX08ioysAUlTiao3NCgXBscdMeeBNteanLGM79rgOoR0PXbxuCG3KGeSTjAq
	 opj7ywTSOzjwMxol7Xv29b/CIWqiiU38cnNxiX6eAlgyCGz0uQ3sk9/VjVpCQ8dTS8Mq1
	 Q5A4kLJHxEmHOl60X7oc3eWsv914u2cNRJNuT+3LgEnHXDVqqxVF6jlI94jvRsJJLjfiz
	 NydJFcnI6FzC8MHAslC9TJTfLwZVimWKkPItn4ibjocFK8lI/TtKFIp6IaUz/wsJYUsiX
	 govAhgENYRa2oYkxApngNXofwqcThpwc5lq8mTPu8Q3fkGeUXsdMTotYkPD4DrspsSg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=T0+PwYdP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91837606A331
	for <linux-can@vger.kernel.org>; Sat, 21 Nov 2026 22:36:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91837606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=T0+PwYdP
Received: from hardanger.blackshift.org (p20030102af17cb00849b19770537dbc5.dip0.t-ipconnect.de [IPv6:2003:102:af17:cb00:849b:1977:537:dbc5])
	(Authenticated sender: mkl@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id D245A205A26;
	Sat, 21 Nov 2026 23:36:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795300581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sXi/Fa4eCFKmOEHorsNpqjR7CROjNY2HMP6M08/m8xc=;
	b=T0+PwYdPzJvYyM36DE35xZYZM0Sz75o1zMUWx1FN4xkdg9Ytb2qZG/L41XKouy8ZhEqWL4
	bJwGMB+EYYr+OLX+cQ94zNaZgf9i1WlO9W1BMoAwlsOxVPcgHbMrL6iXFVzkmLNWz2OBWC
	xdkIRPyCgLF8Yb0MvMlusJG2DyE9ybCr3cN/vpJg0HiQzosKEugx92HU3J3yIFsTY5azRF
	2Qyo84G4VW0fDBUOMGCtdGwejWYEAWd5lEbPYARCla0diE4ypsm4JGmsv35rujo7ejBZDR
	J8LWWrJrcxSjx57onnXjCDOrHS/ZJkfuYKQd6yAEquicvScF37v3aGKbBhFfgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795300580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sXi/Fa4eCFKmOEHorsNpqjR7CROjNY2HMP6M08/m8xc=;
	b=Cxkbd1i0+AXmx7S2v7U4XrAGpBEbZQP4J6N6bi1Ej547hpTYXKlu2ECPV09IfYUKFAmnXG
	EmpmqoJ0e3USofCYF1vEy5euwOTRm4rpltaSpGUvQyEBwjgXW9JffIVLr/d1d0mVpRBTKF
	kjgFEbVpNrnycJbsAHIu4kKHBnifvDkp9Nl4JA3aP/AVDowG0uhev1tB/SQIloaVcAZgE1
	+s0pxrS+D3/dU0+h39zx/o39PZbvVvzZMsZqPDAq+fyFOi4sTeTLzWy0KZuyEHKW51+Iot
	H+ZLfi6/2YD9KuxTXrMPlSfrvMmS2wtdUcFsQ3Gr9R8CDptjTCTG4Ar22gVF3A==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795300581; a=rsa-sha256;
	cv=none;
	b=RpbWp4M8cI+RVfyz1qwlZRf58hafmlnTEBJU9TpJXmRAAqakNVxdNb3YLGfyfZgZDIO5vD
	JZFhK8yfa8KuYOIwpICUYPaSFv6pwAftkRGRFbLZ04oTuWyqAkl8xvHRIk5GHC8TxHhs40
	F4t3eb0/j1QMPuSXcu31mCh3nsbcpv0IjbbO9pnmt000PbINQpijEUD5YR+R0NNtZ7Ppb5
	4d4CKJe70si9Z4Kk7746AbYNpJWMKPLHqu5i5GNKdHU0z411VoBsNlk+NzML2otsOfzorc
	pzpO2Ln2F2O71cA7PFt5yFiXYS72F/2Urh9Vm+rrxMt+4ht2RNGeL7lkFx0Jxw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=mkl@pengutronix.de smtp.mailfrom=mkl@pengutronix.de
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sat, 21 Nov 2026 23:36:04 +0100
Subject: [PATCH can-next v9 06/13] can: gs_usb: add support for context
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
Message-Id: <20261121-gs_usb-fixes-v9-6-db121d488945@pengutronix.de>
References: <20261121-gs_usb-fixes-v9-0-db121d488945@pengutronix.de>
In-Reply-To: <20261121-gs_usb-fixes-v9-0-db121d488945@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, Peter Fink <pfink@christ-es.de>, 
 Eric Evenchick <eric@evenchick.com>, 
 Maximilian Schneider <max@schneidersoft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Donnefort <vdonnefort@google.com>
X-Mailer: b4 0.17-dev-1b309
X-Developer-Signature: v=1; a=openpgp-sha256; l=3070; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=mAdyHonM59cUIWo+tDvo4XZ0V1yhzIA5h+qJhNZk2N8=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYshmkrmpeYjjrWd2+Ns62b8FN25feX/n6imdMyIrl+zbc
 iZfIMNkdUcpC4MYF4OsmCLL0h8nFAUCHUp7XyZMgpnDygQyhIGLUwAmIreCkWES576/y2qa26cy
 x/6dGvLgyW6zq1NOd/Xl/HrzIvXCwhX2DP/LrS8ekbMu7Nr/hq0uJX+j/qyJlTOSsuO/Za2y44+
 b3ssCAA==
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
 drivers/net/can/usb/gs_usb.c | 13 ++++++++-----
 2 files changed, 10 insertions(+), 5 deletions(-)

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
index 30bcb734c5df..ab82dc07f3f5 100644
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
@@ -1037,7 +1040,7 @@ static int gs_can_open(struct net_device *netdev)
 		if (parent->flags & GS_USB_PARENT_FLAGS_HW_TIMESTAMP) {
 			rc = gs_usb_timestamp_start(parent);
 			if (rc) {
-				if (rc == -ENODEV) {
+				if (rc == -ENODEV)
 					netif_device_detach(netdev);
 
 				goto out_can_rx_offload_disable;

-- 
2.53.0

