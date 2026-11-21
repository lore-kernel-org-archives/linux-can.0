Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795300585;
	b=yLwe/s6pm7YO35hYut/vNjr43UQX4LKQfIZxgHO0wnmSLebD2RZEAjytZiVVt6mlhtrk
	 b3ecBM97Yp/n4bICs3IoEMZNO5buKLr7INuGsRsDBRsyI5xtAobraPXQNHKbLw5icUK8u
	 422f/zQNtSExPJmvtrEmQMfj/YfS1IyF2gH2ykUdVeA4EsmoRRrfEaMLhkhz9+IDawaEQ
	 PWIxI9HvfCYHwrM+7ZbQlqmj4fSVK2Ci90C2Vy8bU//Gq9xoBIhPB3ESi1cQ5RJ8vRFqh
	 QVLUQO0Kq/jY7E9D6cuLxVJM1w22QJvhgkUld8+K2CSwywdrdRsjjVoCJbpavAoC1Jw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795300585;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=L0HoMKyjwVknTO9egF7Na+Ej+HVES6FdmM3Ucgw9l+0=;
	b=1VAiTvPynBoPni3zKiqCeeB76qX8PnS8PoqgoY+IV5RiLmwIo+4cXhfYpcN/is/90IpC
	 hLV9zDDFTBV/heoZYDQlufVLWK/aWO/NEPa7nnZFy1se0z9sBK8knCnuGwOOluq40fFgI
	 AsnX8Qe9sa2nkulUB/ywdCeZ1TGSZu+zZafAY67ReTSnFU5ecQE7jiOL0J1+CiB1fAKe/
	 0lFihVMRvHHsZFr+cBtWsDVIih0iIkux1aAEtET1q9KbrWJKBevxqItbakoie8i85m47X
	 uj7av3b9Cix+rWnNWXaph9aPmq5RKd/mMqMbUvri7cU9s57oWhOd96VbqULoNrC0APg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Bhxotaj7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA53D606A339
	for <linux-can@vger.kernel.org>; Sat, 21 Nov 2026 22:36:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA53D606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Bhxotaj7
Received: from hardanger.blackshift.org (p20030102af17cb00849b19770537dbc5.dip0.t-ipconnect.de [IPv6:2003:102:af17:cb00:849b:1977:537:dbc5])
	(Authenticated sender: mkl@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 0BB03205B35;
	Sat, 21 Nov 2026 23:36:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795300582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L0HoMKyjwVknTO9egF7Na+Ej+HVES6FdmM3Ucgw9l+0=;
	b=Bhxotaj7fJrNsb/hlS6pMMmDtVOSK1/k6Iks35DAhEL8tb/JUj60eNNt96R/045OGbnmMW
	92Db0bKj3RbJxNe5LqGdY+RGArEwj7yQxKigFR40Ve2CMod23HRRHho5G3YmrjkpeKFnwO
	lvvr8ni0qRr6eFvUlp9wh2UHFrc1Gl3iqsTj8/vIpnTizpcCBQB1Utn3gCJfZF45JjoVSH
	Ha1smBo+RGzpU9tMFm51wrYf9JReat9nvmPEK5dz5HN9JQPwYvm7diTH/QwE0hPYqCwf02
	gHVDgLkbHHxu8zohLSabVQGwbzgc9To7SSUHrg0QUlb8PMf7eeUJe8UaF9GmhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795300582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L0HoMKyjwVknTO9egF7Na+Ej+HVES6FdmM3Ucgw9l+0=;
	b=GEqDt35K0bTDNpRM21cuLi7xJ3kAyX8rI9nYRYpkx65jLcgj0J7oq5wl6CpQDuxqUFxzry
	GZZcy2lV5Lpech187dEdAJNosE8fJVNsV+P5NPvVfPYrXYjARFG8SPyIr6JXoEflQzb+Gw
	V/5hHuHJHME6ToWZCCZqfP+F7a0HSasvgwV7Gq2UCYP76rJjVloZLUiGW4+V4ui9jXjloQ
	6nIhescyz4NrHwCzcfm5dgLMJAs5vLaSEUUUlzouBI1t2P8WmHX9lNkgbughihA50q8e9s
	fWF8nuZL7fDQ3/oNMKdsX1P9vVv2LY6ruPnpdNPhfrZ1AYopqexK+nc4JVCy3Q==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795300582; a=rsa-sha256;
	cv=none;
	b=QWP+b+91GqJxAoLJAVk2jEl2QyFPBlh+2wZ9gZuJC/te10GvAS5nIoHlJZe1lGzqHadI4l
	N/7e093DnOx+s4onsL7puIwnafUNMnJ4u75IOq/8A83v1VgZrd4V4bivYR9hZIIY5S+GSH
	GI56WELpN/RddeLUsD07aVfmrWxvy5brPdInFZOXi7BrIwWHo7deNv86YwsHumOx0HQseI
	UvIUxYUAsjb8RKjQFyAyNyckgCUEp90ocQkn6fUiKEFlEZzBTr4A7RMdRkRJm108ws782O
	iKWpDR26xQcrmlzDiv/n+jGWaQdajuQx2gquocHmltOtnGy0y9H31C+Wg1N8mA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=mkl@pengutronix.de smtp.mailfrom=mkl@pengutronix.de
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sat, 21 Nov 2026 23:36:09 +0100
Subject: [PATCH can-next v9 11/13] can: gs_usb:
 gs_usb_get_rx_data_length(): introduce new function to consolidate
 validation of host frame
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
Message-Id: <20261121-gs_usb-fixes-v9-11-db121d488945@pengutronix.de>
References: <20261121-gs_usb-fixes-v9-0-db121d488945@pengutronix.de>
In-Reply-To: <20261121-gs_usb-fixes-v9-0-db121d488945@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, Peter Fink <pfink@christ-es.de>, 
 Eric Evenchick <eric@evenchick.com>, 
 Maximilian Schneider <max@schneidersoft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.17-dev-1b309
X-Developer-Signature: v=1; a=openpgp-sha256; l=4254; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=+3Bzk7NJ4D60sBzRXWVkjgSNW7ihoMvRZM/GwCVfu10=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYshmkrnf6mYra1bpll729LpR70SOjxZen/QDrZesWXfkA
 Qd7eypnRykLgxgXg6yYIsvSHycUBQIdSntfJkyCmcPKBDKEgYtTACayvIKR4fsSlhbZgkOOkgol
 Jsel107bXX3Tp/h3/IFtBV5xR6Q8XBgZpuf/TZJXOPYz5sT+Ql9pW413HhNOrLn9hT+rM3maxgF
 RHgA=
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

Add a new function: gs_usb_get_rx_data_length() to consolidate the
validation of the struct gs_host_frame from the received URB.

Return the length of data in the host frame on success, or a negative errno
on error.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 79 +++++++++++++++++++++++++++++++-------------
 1 file changed, 56 insertions(+), 23 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index aca4f4fdc796..e4e177aee48b 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -620,9 +620,31 @@ gs_usb_get_echo_skb(struct gs_can *dev, struct sk_buff *skb,
 	return len;
 }
 
-static unsigned int
+static bool gs_usb_host_frame_header_valid(const struct gs_can *dev,
+					   const struct gs_host_frame_header *header)
+{
+	struct net_device *netdev = dev->netdev;
+	struct net_device_stats *stats = &netdev->stats;
+	bool valid = true;
+
+	if (header->echo_id >= GS_MAX_TX_URBS &&
+	    header->echo_id < GS_HOST_FRAME_ECHO_ID_RX) {
+		stats->rx_errors++;
+
+		if (net_ratelimit())
+			netdev_err(netdev,
+				   "out of range Echo ID (echo_id=0x%08x, max_echo_id=0x%08x)\n",
+				   header->echo_id, GS_MAX_TX_URBS - 1);
+
+		valid = false;
+	}
+
+	return valid;
+}
+
+static int
 gs_usb_get_minimum_rx_length(const struct gs_can *dev, const struct gs_host_frame *hf,
-			     unsigned int *data_length_p)
+			     int *data_length_p)
 {
 	unsigned int minimum_length, data_length = 0;
 
@@ -651,6 +673,33 @@ gs_usb_get_minimum_rx_length(const struct gs_can *dev, const struct gs_host_fram
 	return minimum_length;
 }
 
+static int gs_usb_get_rx_data_length(const struct gs_can *dev,
+				     const struct gs_host_frame *hf,
+				     const u32 actual_length)
+{
+	struct net_device *netdev = dev->netdev;
+	struct net_device_stats *stats = &netdev->stats;
+	int minimum_length, data_length;
+
+	if (!gs_usb_host_frame_header_valid(dev, &hf->header))
+		return -EINVAL;
+
+	minimum_length = gs_usb_get_minimum_rx_length(dev, hf, &data_length);
+	if (actual_length < minimum_length) {
+		stats->rx_errors++;
+		stats->rx_length_errors++;
+
+		if (net_ratelimit())
+			netdev_err(netdev,
+				   "short read (actual_length=%u, minimum_length=%u)\n",
+				   actual_length, minimum_length);
+
+		return -EINVAL;
+	}
+
+	return data_length;
+}
+
 static struct gs_can *
 gs_usb_get_gs_can(const struct gs_usb *parent,
 		  const struct gs_host_frame_header *header, u32 actual_length,
@@ -698,13 +747,13 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 	int rc;
 	struct net_device_stats *stats;
 	struct gs_host_frame *hf = urb->transfer_buffer;
-	unsigned int minimum_length, data_length;
 	struct net_device *netdev;
 	struct gs_tx_context *txc;
 	struct can_frame *cf;
 	struct canfd_frame *cfd;
 	struct sk_buff *skb;
 	bool fatal = false;
+	int data_length;
 
 	BUG_ON(!parent);
 
@@ -727,22 +776,13 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 		goto resubmit_urb;
 	}
 
+	data_length = gs_usb_get_rx_data_length(dev, hf, urb->actual_length);
+	if (data_length < 0)
+		goto resubmit_urb;
+
 	netdev = dev->netdev;
 	stats = &netdev->stats;
 
-	minimum_length = gs_usb_get_minimum_rx_length(dev, hf, &data_length);
-	if (urb->actual_length < minimum_length) {
-		stats->rx_errors++;
-		stats->rx_length_errors++;
-
-		if (net_ratelimit())
-			netdev_err(netdev,
-				   "short read (actual_length=%u, minimum_length=%u)\n",
-				   urb->actual_length, minimum_length);
-
-		goto resubmit_urb;
-	}
-
 	if (hf->echo_id == GS_HOST_FRAME_ECHO_ID_RX) { /* normal rx */
 		if (hf->flags & GS_CAN_FLAG_FD) {
 			skb = alloc_canfd_skb(netdev, &cfd);
@@ -780,13 +820,6 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 
 		gs_usb_rx_offload(dev, skb, hf);
 	} else { /* echo_id == hf->echo_id */
-		if (hf->echo_id >= GS_MAX_TX_URBS) {
-			netdev_err(netdev,
-				   "Unexpected out of range echo id %u\n",
-				   hf->echo_id);
-			goto resubmit_urb;
-		}
-
 		txc = gs_get_tx_context(dev, hf->echo_id);
 
 		/* bad devices send bad echo_ids. */

-- 
2.53.0

