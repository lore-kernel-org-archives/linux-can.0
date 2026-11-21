Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795300585;
	b=jHQ1h1YBgdg+GkIZ+bi2RdzV2oZgujp8ikTiBRIDRjQbISC7Bv6m3ZaV+ynRZlrq26o+
	 xYAad/oOH9zr65pAlCdCsYJq/JCRfbwztG+0Q+NSGiQJQT4NP3sMJBO6QrrOwdp0KnEUB
	 ZdH2sPU0xT6CzbpQ0cwiiXX88T8lhqoXtLnIk27kJT5X9eIE5XH3bSrfEHPfjd/DdatB0
	 jCnGHkgmH64Qj4LCWQ/fDi8wcqyIOlS/ZXxutXY+TTfu0w7MU6qAvHWt4NhSV9OKQXeJA
	 DuHUArmCcEFjTM8PcKOcB2KcqZCu5Hj4SNHqbJyycqouwolFFCJNHap6BGWUu5JKhqQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795300585;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=XvkUam/iDPHkBGDjEvD/3HWvsdk2jf/FrCmiGdMz/0I=;
	b=uRBq8INCu93r0MS/ELb1UW7pIrUg7YZp6KbW06xtpU+pJewnh6RcBLL3BOJGfd7vicXR
	 URca+UwJp1/DKLBc4O/IQXcKfmIKKQieKx+9ZDpvp/a1dvX8K4hSoQWQYawF8TwDglORN
	 GXkQeiTL0RpVBO9K6xNmrQeN7pSMmTwLjT00AQlM6uZ59anScQfhphWUFWfuh5kOyuXyw
	 jfYB5k1NeppTcogsKkHpJH0+294wxuVzILNnDT0Xf/i7eMGyB7baPVM9AgKpMZes1PIvr
	 U5h0MmTP8kqs1qodkWN85hEkgCNj9SXemzdBVvFPXW4DeL5i9vQI9aPR5t2xfq1kORQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=QeJLibl+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9187E606A337
	for <linux-can@vger.kernel.org>; Sat, 21 Nov 2026 22:36:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9187E606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=QeJLibl+
Received: from hardanger.blackshift.org (p20030102af17cb00849b19770537dbc5.dip0.t-ipconnect.de [IPv6:2003:102:af17:cb00:849b:1977:537:dbc5])
	(Authenticated sender: mkl@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 71B69205B32;
	Sat, 21 Nov 2026 23:36:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795300581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XvkUam/iDPHkBGDjEvD/3HWvsdk2jf/FrCmiGdMz/0I=;
	b=QeJLibl+gJBBW5tA9DvyrxWIKIOv7aFSCvtOs3xaJFK77p9ATMhgGb4PQwPIAPpECWvLQx
	2S2qJubSXhWwWRnxh396zntYhSDMsl0RAGe0094QnYi3F4py57xm/8hvN77e65bWiZauxX
	8EgKvji2T6VasHUQq1K2PmTDYg4no8yO9B1X4O3q2rx/5PAronT4bkot2FF9pmG1nGqvqq
	zNJdiHGAXVw97QHDeCTn8mQud2Sz9DCQv49beyiBZECUrk5yBLuNcRRzn1oV46SLdY4Pi7
	WP6W40YC5N6YCGOQALOhs/fXO7SFXUxPor6yzuscsMy92/Bcmbx51aDJ22TAQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795300581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XvkUam/iDPHkBGDjEvD/3HWvsdk2jf/FrCmiGdMz/0I=;
	b=Kc+sgp9/M0wneiJJ2AGPPC1J7hrh+e1NAfTO2DK1wX57eoz/OnQbVo9OhssXt14/XuA22j
	s8PUqDtFhgcr8OHFZ0gTPpWzBpBIs8lZ8QuZaKUxoFrDGxo7ZSzNcK0/9AG3QKyF/hFfMx
	KldPTBG4tV0l5C7j4d0psemyty21ym7whm07Z1X5VNU3IgiDRISRm+JzZjkjYTrwj1jTd4
	QCU31/wfbHAzpGvt0TFGXaPBZpedfEiWprfyceHJY7cm17MSg28zs8pXm3Neu1Ebgc+UwP
	qaDAb3lP/JoRcqG1uGPucqJswmXsMMLABBWpeIDD963446HN+Geb5X7k4B5fcg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795300581; a=rsa-sha256;
	cv=none;
	b=S61R4JgWmHKJ9rI0+R/xCuVnplfKQJ8Roii+rdikYUD3CzqW+YedpAQ56P6rUadl6ws7x8
	xtO7Q+/M5E3Mezeg8FyDiYMCboDezHP2ujNZasG7RQDg1kGHAORJGuGVqwF+DLY1gXp7Nj
	jS9cKImaRIUxolIt8e1UUSzh1srJcUXavqmqr7V8lC/1pEswbI+cYCPD1arcc3WU0pgbdR
	vFk11oRpR2v/KS+Yyghc3y0TXAEehlurb9S1ANPGjnJCFPLt1OOs0MbA9ZaPrWyvnYQMNf
	ogyJDLa8nZqHz5XhFlsd5WiAweaEC6kUoZQb3NifaENVmX2GiDPBgCW49FAYUA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=mkl@pengutronix.de smtp.mailfrom=mkl@pengutronix.de
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sat, 21 Nov 2026 23:36:07 +0100
Subject: [PATCH can-next v9 09/13] can: gs_usb: gs_usb_get_gs_can():
 introduce new function to consolidate validation of struct gs_can
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
Message-Id: <20261121-gs_usb-fixes-v9-9-db121d488945@pengutronix.de>
References: <20261121-gs_usb-fixes-v9-0-db121d488945@pengutronix.de>
In-Reply-To: <20261121-gs_usb-fixes-v9-0-db121d488945@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, Peter Fink <pfink@christ-es.de>, 
 Eric Evenchick <eric@evenchick.com>, 
 Maximilian Schneider <max@schneidersoft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.17-dev-1b309
X-Developer-Signature: v=1; a=openpgp-sha256; l=3275; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=DSJIVI/POcspsckMwG6+bmNCQx+ZScsUmj8zmz8VkUA=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYshmkrnL2xKa9+CG9LMl5mvtKvP9s8WkOU7seRawguVpd
 dQCxSNnOkpZGMS4GGTFFFmW/jihKBDoUNr7MmESzBxWJpAhDFycAjCRBT8ZGSZ3uzk7HWNYPlFM
 QH6zx3q5rcvPflWwZM/8sVz1m1fII0VGhsNKRVfsvXY9/aOz9Nq6uA8Je9Z5vK+8v+7Kw1R23+9
 WGhwA
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

To improve code readability and structure consolidate the decoding and
validation of the struct gs_can from the host frame into a the new
function gs_usb_get_gs_can().

Let gs_usb_get_gs_can() only work on the actual header of the host frame,
return a struct gs_can pointer on success, or NULL on error. If fatal is
true, detach the device, otherwise re-submit the URB.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 61 +++++++++++++++++++++++++++++++-------------
 1 file changed, 43 insertions(+), 18 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index f49179cbd787..c392cf65d8a6 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -267,7 +267,7 @@ struct canfd_quirk {
 #define GS_HOST_FRAME_ECHO_ID_RX 0xffffffff
 
 struct gs_host_frame {
-	struct_group(header,
+	struct_group_tagged(gs_host_frame_header, header,
 		u32 echo_id;
 		__le32 can_id;
 
@@ -651,6 +651,43 @@ gs_usb_get_minimum_rx_length(const struct gs_can *dev, const struct gs_host_fram
 	return minimum_length;
 }
 
+static struct gs_can *
+gs_usb_get_gs_can(const struct gs_usb *parent,
+		  const struct gs_host_frame_header *header, u32 actual_length,
+		  bool *fatal)
+{
+	const u32 minimum_length = sizeof(*header);
+
+	if (actual_length < minimum_length) {
+		dev_err_ratelimited(&parent->udev->dev,
+				    "short read (actual_length=%u, minimum_length=%u)\n",
+				    actual_length, minimum_length);
+
+		return NULL;
+	}
+
+	/* device reports out of range channel id */
+	if (header->channel >= parent->channel_cnt) {
+		*fatal = true;
+
+		return NULL;
+	}
+
+	struct gs_can *dev = parent->canch[header->channel];
+	const struct net_device *netdev = dev->netdev;
+
+	if (!netif_device_present(netdev)) {
+		*fatal = true;
+
+		return NULL;
+	}
+
+	if (!netif_running(netdev))
+		return NULL;
+
+	return dev;
+}
+
 static void gs_usb_receive_bulk_callback(struct urb *urb)
 {
 	struct gs_usb *parent = urb->context;
@@ -664,6 +701,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 	struct can_frame *cf;
 	struct canfd_frame *cfd;
 	struct sk_buff *skb;
+	bool fatal = false;
 
 	BUG_ON(!parent);
 
@@ -678,30 +716,17 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 		return;
 	}
 
-	minimum_length = sizeof(hf->header);
-	if (urb->actual_length < minimum_length) {
-		dev_err_ratelimited(&parent->udev->dev,
-				    "short read (actual_length=%u, minimum_length=%u)\n",
-				    urb->actual_length, minimum_length);
+	dev = gs_usb_get_gs_can(parent, &hf->header, urb->actual_length, &fatal);
+	if (!dev) {
+		if (fatal)
+			goto device_detach;
 
 		goto resubmit_urb;
 	}
 
-	/* device reports out of range channel id */
-	if (hf->channel >= parent->channel_cnt)
-		goto device_detach;
-
-	dev = parent->canch[hf->channel];
-
 	netdev = dev->netdev;
 	stats = &netdev->stats;
 
-	if (!netif_device_present(netdev))
-		return;
-
-	if (!netif_running(netdev))
-		goto resubmit_urb;
-
 	minimum_length = gs_usb_get_minimum_rx_length(dev, hf, &data_length);
 	if (urb->actual_length < minimum_length) {
 		stats->rx_errors++;

-- 
2.53.0

