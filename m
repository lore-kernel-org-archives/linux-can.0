Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795373340;
	b=uyZvBF0Kakd0GB8d6AqunCsGHMctBs7JF4TgCgIjRFqbrZ2liMiTDUmo3sSvCnBwvpPT
	 B/9EOGXBxSGywguBKs0cbKBTobndlNxULX5tVXE7MF/Vuw4VrMSuRxsVmbfM5eUzOeRxm
	 E7y6IVggw9geCKA13DAHS7r7iEhZsdncVGtEsfUsDJDZOTlntgfjOOU9rccp5GAbUnUHg
	 k4r5+8Yn5GoOFJvx8FzHwDE4UUeVV8Rg9JRg6jR2z4gV5Qb1PUwWke/izKgHXGinuEvqC
	 7acC4GvNtQiLYLKwRO6QcqC0pfmFftS2wVnR/R3BFSUYY6TZ6PGWPUurN7cjNfaNpiw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795373340;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=+CECho7LDOBk17ITDm3WBfm3ZviyJPvPc+sPtqztvos=;
	b=iBPvsIAWYpQYv8CvcIAE8e5O05hGhdCPqJC8ZtZtQRH4uRGfzneu6jC669/6ZJuqGjxd
	 YCa+zXKw/Cxb2iFfKyiradzjZ+kMcnMxXDG8izQ5GHmGukpJqUT5WlrM4cX4M7gKewHIQ
	 VVU567IwiG+R0Sxml01JHMDaIN98KBZfdMuhHHjQbGofPExpWeMXkZ40/6KdWFc719VqA
	 8kud+9XTT6fzr89XQ1bt3OgmBOHxeBg1Bry9FwRn/NahaaE9TRA+SV8UKt6My4iMUBm06
	 j9Lov1vIuMtVNiK+XvYCa+u2XpyBUwljMM8rUCPXCeX24U762PgPilmWprpSQnU7Xmw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=aPdqJVvu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7513606A686
	for <linux-can@vger.kernel.org>; Sun, 22 Nov 2026 18:48:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7513606A686
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=aPdqJVvu
Received: from hardanger.blackshift.org (p20030102af17cb0015d71b554e0d6387.dip0.t-ipconnect.de [IPv6:2003:102:af17:cb00:15d7:1b55:4e0d:6387])
	(Authenticated sender: mkl@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 9160D205B37;
	Sun, 22 Nov 2026 19:48:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795373330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+CECho7LDOBk17ITDm3WBfm3ZviyJPvPc+sPtqztvos=;
	b=aPdqJVvuM262gqHIRKcWOnuQvYCSOLie5MUvPeYy26eZzkJrXE8ECEqZHd8QUwbuMkXKK4
	flcz0Q+ot8MSq1LkWw1SlVagXIvXeRemGt9yuHHr+YfmE+DriLpPU5OXqsew+jMBXcP8sc
	POiMGdbPkyzvbJs+sSXPer0CSPyeRMi/MyVZnaIGIwo1voJ4ll8yWLhQUO53lT9LKLWshT
	yv0vVYGBEgXJwVqF3vsFp45DgJk3igKIPmE6qZa76/iIvx7C1a7QSBnHrVBaQz3MjZjCsQ
	5abQscc3XqxxifmzELBrifpVrNpCAu2mE+28itllJLMehNxY3RMYiVaXKYbulQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795373330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+CECho7LDOBk17ITDm3WBfm3ZviyJPvPc+sPtqztvos=;
	b=SR03gaFxFXiPpw6eOpg4Ey64/cevoaSADoqMtvBBWJp2J4M9yxr/CrZU9qfm3tHgEKbi8c
	xrTqjNxiIWpWIP/b0wUZQSotwuTgzl6giARu0V5xVMPbwY5Ypp/5MteaydsjRfOvnj0hmk
	F25ptodYhVEnV4L1becxtftuyW3499lwdlcnY/lNV4wfGnkQiGtLzjzLsHLtQ9gyoMVr43
	C9K3Rz38Bf9mvOy7gdEJKpCUQU8YE6v7e1nPVX5+T/WA6UiboqZDK6LADBp5gBcVkWD6Dh
	UU34pILWVnE1aqd2zAerxyDrnuC3sih5X20lq9/0RfPnyuv0TxJ/pMaa9NJJLw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795373330; a=rsa-sha256;
	cv=none;
	b=ShqXKl+8fyG8SRuNyCGaMskJ0PrEZIiGCBc1EG5hKMVaa0hk4Ow/QcRYihnLUufsXorw+c
	sub/WxdUVYGb8/lKsViHpX571BOAnlReLUS/0UWRaF/6EAOIZkAiLCPron+F0O28YekvPS
	1IC7vM5/MH/dnspAYFPjfusKNjs5oE1pGx8OL/3yOZ4SZzs+3Je300ngCv1BI5nHCI13T1
	G0t2WR0BiYhQU7WWDx2ZXqNVVneshSUHmOjOJfH+buVMcJDP796noUuw3hCCfUgwbghEWc
	zajauRC80hO1A3vCp8Py7bOSEfD1rrVa+UF33mBJKxBnxbGHu5/uJ9ejxIfDmQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=mkl@pengutronix.de smtp.mailfrom=mkl@pengutronix.de
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sun, 22 Nov 2026 19:48:33 +0100
Subject: [PATCH can-next v10 09/14] can: gs_usb: gs_usb_get_gs_can():
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
Message-Id: <20261122-gs_usb-fixes-v10-9-7c165c35d04a@pengutronix.de>
References: <20261122-gs_usb-fixes-v10-0-7c165c35d04a@pengutronix.de>
In-Reply-To: <20261122-gs_usb-fixes-v10-0-7c165c35d04a@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, Peter Fink <pfink@christ-es.de>, 
 Eric Evenchick <eric@evenchick.com>, 
 Maximilian Schneider <max@schneidersoft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.17-dev-1b309
X-Developer-Signature: v=1; a=openpgp-sha256; l=3275; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=TtIxwgIcjHHiNN/3zQDrRn17TjkL3z3OEEnXJVtDHYg=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYshmtuQ80yYgmSx7enotR67c7oJuyeeVFjzFUsHJn6f7C
 TPprKzvKGVhEONikBVTZFn644SiQKBDae/LhEkwc1iZQIYwcHEKwET+32T4n+XZ3cs5/fJDyUu3
 N/y85lvMyfrj5vU3dzZu6diw8MLU4DyGfwpcPh3FSuz3TvNdXzdjUjxbXN/KDUaztlwsbRfSE+x
 dyAMA
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
index 75adec495e65..9078460aebca 100644
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

