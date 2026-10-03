Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0433B895E;
	Sat,  3 Oct 2026 22:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791068033; cv=pass; b=bXI5tTWNKwbjEtBpL/K02gDb3iAsGrtTvSmbwCPmMZ2VmPaMupslSkCC6JAaxpGphudVX5mrPQTCbn1LCiQzOX1NzAbo6hxzX6fSt5l6uZiBTi8md718ky+nP9wE3qXT0ajP1pBkDSv4tZ7uJybQlcvHnBZpFokJ3it55uvqXvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791068033; c=relaxed/simple;
	bh=F7SruzaUuAhZRfrDKAuYJEg+dodhhUq5ycIaN5ihbrE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HrZG0i75LDPGgxBpovjXCXbMvSrTtb/1wNOwgkp8yd4hzTkHuWbbfh584S/XfjwR3MChgZC3tRaF/KOytuk+992yvvBvosB+IR+SiE+IC+Ij93tTfD/6loup00k7B9+cAzLYbNk4XMNVmKKBK/1GvbH2/PDT9jIqDBikYlKgcWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=MiG/C/e3; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="MiG/C/e3"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 53D9520234C;
	Sun, 04 Oct 2026 00:53:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791068024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kBRvIlKHETfbnsEHST0nfFRIeZV6bMgWoZFi5GOzODE=;
	b=MiG/C/e3plk0AEpIgOKYH1scRbTnM+5n42rfhvXEpvPjjAoWfv+WxKfXQTg2Yb4VtNvi2L
	tJ+LdbseoCK36bHNWmYI1GnYV+uCnNQBA1QI6bVwjTBpV/Lknki2QNtdkYrRHMv6Ioxb/6
	poq3SEGUFATUSpksm+V9gH/DcULLBQGxVp8WCyR5AJVAKoMWjPz+KOJyGyNlr7d7ndXzvw
	4E0ImjvM8xGPqNt/NTR2A7nmH/+flHoAi8a/UC7kGRXgPP+o9WVTlmuJ0lcGXh+ZTGm3ag
	7C+43FvOsAed0TxGZD4Feyd3nulJNyZZGUycysDNUQlmTvd9cRxpB2VJ52hlOQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791068024; a=rsa-sha256;
	cv=none;
	b=MAvfyF4C3NqnWknLbd0pQnLSM35c4AlSOoTJv6ptKR8HhF1+HL3StUEVfl1eNEFXIx3tCe
	lwZuMh62xkrSXCtK9Gz9izOXx1aknIEvRgkzhlEAz5yRQF6MyTRWfVAas1iEN0gUNQEo6F
	nyiF12ihoMOb4zZqp5u/+FCip8u6x17TfbA23NtKFle8vKvqTNEEp80fwDmS71eRe0VCl/
	gMLidgoCOBjEtjXbOot8O/LHzhDY1l7M7qILTOwcTZ4U0Y+T8oIw5eGwYLJa2QC4Yx/RVj
	IaGmk5LoizKI7RO/PjmwU6WVHNnE5bhehCGIQKtXywZbJoCbaCi30qOhoJ4Jbw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791068024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kBRvIlKHETfbnsEHST0nfFRIeZV6bMgWoZFi5GOzODE=;
	b=L1F4l+oqnA3489li2vDllk0xGSz/z5QGV1MfK6NjX3KKSb4ZkDsvlwztdMVdR5Gjrciyy8
	Am8oIJVxE1G6kPjLFOlBXszFMSDxh6tAbjd64XmLKhsbgb9jLXU7ZVrN4jvudNH14crKFN
	TVcLLYDBnC2fDEwghTKj/yeC5hD4E0IWSk9291EvqdQ7mf9YUCHVgOaeCW3K6pWWsWbqsW
	Qxv4PiCIBXceE+IQMlUonqSqudaWejF4mRvXwz7USlYxJYUlmZv0jXiRSQi9A5SadMEASf
	hb3i0CAZGtAFNt0SS8t/nJuswdUjjZnVum3LUb0Z0KnxpEZecDIjHzArhODFig==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xD8bw-0047mp-0U;
	Sun, 04 Oct 2026 00:53:44 +0200
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C19425B93AA;
	Sat, 03 Oct 2026 22:53:43 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sun, 04 Oct 2026 00:53:17 +0200
Subject: [PATCH can-next 08/10] can: gs_usb:
 gs_usb_receive_bulk_callback(): reduce scope of several variables
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261004-gs_usb-cleanups-and-fixes-v1-8-7b4b06244a77@pengutronix.de>
References: <20261004-gs_usb-cleanups-and-fixes-v1-0-7b4b06244a77@pengutronix.de>
In-Reply-To: <20261004-gs_usb-cleanups-and-fixes-v1-0-7b4b06244a77@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1995; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=F7SruzaUuAhZRfrDKAuYJEg+dodhhUq5ycIaN5ihbrE=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsg62F7cMc9g1adr3KYXdeZypbUZuJvvCov6mx6+mUlTb
 k0Tv317RykLgxgXg6yYIsvSHycUBQIdSntfJkyCmcPKBDKEgYtTACZSLcTwP87hS/i9LYmfY1P7
 na9mL4vs39XH/ut8wca9O974zekJNmP4n/vaI+SyVsfc568bRL7lfhOTEm1+lWcQmb0jY07nHhZ
 nHgA=
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

To improve readability of the code, reduce the scope of the variables txc,
cf and cfd and skb.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 86f7cac093a1..190cd3701202 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -599,10 +599,6 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 	struct net_device_stats *stats;
 	struct gs_host_frame *hf = urb->transfer_buffer;
 	unsigned int minimum_length, data_length;
-	struct gs_tx_context *txc;
-	struct can_frame *cf;
-	struct canfd_frame *cfd;
-	struct sk_buff *skb;
 
 	BUG_ON(!parent);
 
@@ -660,7 +656,11 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 	}
 
 	if (hf->echo_id == GS_HOST_FRAME_ECHO_ID_RX) { /* normal rx */
+		struct sk_buff *skb;
+
 		if (hf->flags & GS_CAN_FLAG_FD) {
+			struct canfd_frame *cfd;
+
 			skb = alloc_canfd_skb(netdev, &cfd);
 			if (!skb)
 				goto check_overflow;
@@ -674,6 +674,8 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 
 			memcpy(cfd->data, hf->canfd->data, data_length);
 		} else {
+			struct can_frame *cf;
+
 			skb = alloc_can_skb(netdev, &cf);
 			if (!skb)
 				goto check_overflow;
@@ -690,6 +692,9 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 
 		gs_usb_rx_offload(dev, skb, hf);
 	} else { /* echo_id == hf->echo_id */
+		struct gs_tx_context *txc;
+		struct sk_buff *skb;
+
 		if (hf->echo_id >= GS_MAX_TX_URBS) {
 			netdev_err(netdev,
 				   "Unexpected out of range echo id %u\n",
@@ -719,6 +724,9 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 
 check_overflow:
 	if (hf->flags & GS_CAN_FLAG_OVERFLOW) {
+		struct can_frame *cf;
+		struct sk_buff *skb;
+
 		stats->rx_over_errors++;
 		stats->rx_errors++;
 

-- 
2.53.0

