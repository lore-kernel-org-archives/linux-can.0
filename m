Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1505D393DF5;
	Sat,  3 Oct 2026 22:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791068029; cv=pass; b=NPmGJvKGnvmtCDWQ20zTbYVoPNcI0h2SzIic+sa68wVpKIe918pzc3PQHuaGlK3sO7JkhyLR2sszoMMzr+i+WaQsgyRTatsjHyH4XoXtRYWUZba9vUQDm17xgXYBFLzr4KZWgNY6pb2ozPxsKp73hp24/wUS1Yshs/rjFrb6CYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791068029; c=relaxed/simple;
	bh=rHQMhjjSeffT7Dkb7fOsgXqZA4QivpgztymoHABklNA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RlG/hbEC5uCW/v8MebJQjLROMXE0+MpZF9+a1Eg3+VH/YqKq1tq7sybm2zT0Ue+tAZONqJyoWn0cyl5XZ+cyiEBpQKeAfeYjy3leAMZOUvWvwo2+vY0ttTMoB/0as3H6m9vZmFn+0mDaqMP/5JHeL/HKUdZdkkHoKkcWpAgHPBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=JLe4FVMv; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="JLe4FVMv"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 17A1E201CE0;
	Sun, 04 Oct 2026 00:53:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791068024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RoPsADX88W5eHjqzWs3q+Mdu9J/2S//qfUii7bhhwss=;
	b=JLe4FVMvzye4/IJ+OyZQqy/R92EIeBKoAf3DjpEq+6OC2bp5gm7SJl2bjsdsYyTpanJppV
	/NwZmmIjCfWGUifiywG1jq4JYyaGtZbHkkA0jFNHH5JouUjvotkCUj4lDasqaBxzVIJfY8
	Hi8gGrN6AWh7rPDL4jhuasXewJt3R19bsCBs8Lg/fQ14rZoyDCP39Kqvd9Oq/njLKBEL6O
	pQoCN6P+Ixk+YM+BggZz4IX/52IbqHYauZ8fkdlrtr3KGb7HJ/q2YCyREj11408Q7JKXLL
	HHrB3Odl4/2Tl+c+1NNXT73AUr7At9Nt1LBZHZuW5DScaeZez/CscK29juWECQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791068024; a=rsa-sha256;
	cv=none;
	b=REj9MuyP7lcYVj27AhyhBU3HBxReP7a0B+DDOPqHi4SP3X7Vhxmmf64auEVtKvac5wm55u
	gPL9pu7DYb71drswvE/7Zz3Q2N+rXwAnMZkJ8d7n5S/Nwxq8jgkO+2y5RxIsPJhL7eXCxi
	0uvwupo0ESeaLHwNX/xk3k7mbTV+UypRcUnTHLxVY+pTdW7vEqCv2kpTpTBXR+SX1iOs7h
	TFKGaPPp1lCffBdp9oXGBEFoe5AQiXjsmGs69Ykd3OeDrCv0aIx+0cE2/mAM70XavCsBU3
	djrtUUW/NBDjRZoVPTQVuL/mSlAvNGXzvBiGGuQqQWMjGlr+/uLNiO6OIlnJ/g==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791068024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RoPsADX88W5eHjqzWs3q+Mdu9J/2S//qfUii7bhhwss=;
	b=asHFTv+5e0waoOHzNg6qLzMItVLNM+YAB3ghsRzL8kg4cArjEHkRVpRQl5i7uc3Grw47Ke
	WbTsKe9bla3O9zNNC+VZRzee7yg0h0UtKtIXlv7QeSlimbLG48BSKO/J5HHpNUU81jo6dy
	8eRT62vfIdn/m2astCFc5etW18Qhkzn32ZOE69N+grp1Ob+nafRW0QDjQCi39csW5aWzyt
	s5RIiim4cpKGQfqdJpv8aXAGtLGqwKCVg54NRsUZPA80JXbPpn8ouHA3XshgI7sUDetvSR
	TXiFJrXmpo4Kmu2kOJ0bBDpapUspOX8IiSi9Rd/Y7bsgjfPrSD+0hQeRU1G3RA==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xD8bv-0047me-2p;
	Sun, 04 Oct 2026 00:53:43 +0200
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 98EC65B93A4;
	Sat, 03 Oct 2026 22:53:43 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sun, 04 Oct 2026 00:53:11 +0200
Subject: [PATCH can-next 02/10] can: gs_usb: replace all GS_CAN_MODE_* by
 GS_CAN_FEATURE_*
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261004-gs_usb-cleanups-and-fixes-v1-2-7b4b06244a77@pengutronix.de>
References: <20261004-gs_usb-cleanups-and-fixes-v1-0-7b4b06244a77@pengutronix.de>
In-Reply-To: <20261004-gs_usb-cleanups-and-fixes-v1-0-7b4b06244a77@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2779; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=rHQMhjjSeffT7Dkb7fOsgXqZA4QivpgztymoHABklNA=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsg62J67bJ3/rcUTD93rPnT+SWzflgWNzpqq0wwe/cxhe
 l0dYB2R31HKwiDGxSArpsiy9McJRYFAh9LelwmTYOawMoEMYeDiFICJOLYxMqw2WLjVU9zYpLNU
 Mf7RnLgVL10zjLUW61d7N7EcvfOndRMjw/2Fr1+xvnO65d0mwnCkOvL/m5ULzt7S2nngQaBRmtm
 0/1wA
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

The values for the defines GS_CAN_MODE_* and GS_CAN_FEATURE_* are
intentionally identical.

The device signals its capabilities with GS_CAN_FEATURE_* in struct
gs_device_bt_const::feature and the driver activates them with
GS_CAN_MODE_* in struct gs_device_mode::flags.

Standardize on GS_CAN_FEATURE_* to eliminate redundant macro definitions
and align the driver with the candlelight firmware implementation (commit
cdadf34281c7 ("gs_usb: replace all GS_CAN_MODE_xxx by GS_CAN_FEATURE_xxx").

Link: https://github.com/candle-usb/candleLight_fw/commit/cdadf34281c777740229b152ce928ca9a819d727
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 29 +++++++----------------------
 1 file changed, 7 insertions(+), 22 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index bfb3780e1163..5e96c1a7e5cc 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -127,21 +127,6 @@ struct gs_device_config {
 	__le32 hw_version;
 } __packed;
 
-#define GS_CAN_MODE_LISTEN_ONLY BIT(0)
-#define GS_CAN_MODE_LOOP_BACK BIT(1)
-#define GS_CAN_MODE_TRIPLE_SAMPLE BIT(2)
-#define GS_CAN_MODE_ONE_SHOT BIT(3)
-#define GS_CAN_MODE_HW_TIMESTAMP BIT(4)
-/* GS_CAN_FEATURE_IDENTIFY BIT(5) */
-/* GS_CAN_FEATURE_USER_ID BIT(6) */
-#define GS_CAN_MODE_PAD_PKTS_TO_MAX_PKT_SIZE BIT(7)
-#define GS_CAN_MODE_FD BIT(8)
-/* GS_CAN_FEATURE_REQ_USB_QUIRK_LPC546XX BIT(9) */
-/* GS_CAN_FEATURE_BT_CONST_EXT BIT(10) */
-/* GS_CAN_FEATURE_TERMINATION BIT(11) */
-#define GS_CAN_MODE_BERR_REPORTING BIT(12)
-/* GS_CAN_FEATURE_GET_STATE BIT(13) */
-
 struct gs_device_mode {
 	__le32 mode;
 	__le32 flags;
@@ -1033,26 +1018,26 @@ static int gs_can_open(struct net_device *netdev)
 
 	/* flags */
 	if (ctrlmode & CAN_CTRLMODE_LOOPBACK)
-		flags |= GS_CAN_MODE_LOOP_BACK;
+		flags |= GS_CAN_FEATURE_LOOP_BACK;
 
 	if (ctrlmode & CAN_CTRLMODE_LISTENONLY)
-		flags |= GS_CAN_MODE_LISTEN_ONLY;
+		flags |= GS_CAN_FEATURE_LISTEN_ONLY;
 
 	if (ctrlmode & CAN_CTRLMODE_3_SAMPLES)
-		flags |= GS_CAN_MODE_TRIPLE_SAMPLE;
+		flags |= GS_CAN_FEATURE_TRIPLE_SAMPLE;
 
 	if (ctrlmode & CAN_CTRLMODE_ONE_SHOT)
-		flags |= GS_CAN_MODE_ONE_SHOT;
+		flags |= GS_CAN_FEATURE_ONE_SHOT;
 
 	if (ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
-		flags |= GS_CAN_MODE_BERR_REPORTING;
+		flags |= GS_CAN_FEATURE_BERR_REPORTING;
 
 	if (ctrlmode & CAN_CTRLMODE_FD)
-		flags |= GS_CAN_MODE_FD;
+		flags |= GS_CAN_FEATURE_FD;
 
 	/* if hardware supports timestamps, enable it */
 	if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
-		flags |= GS_CAN_MODE_HW_TIMESTAMP;
+		flags |= GS_CAN_FEATURE_HW_TIMESTAMP;
 
 	rc = gs_usb_set_bittiming(dev);
 	if (rc) {

-- 
2.53.0

