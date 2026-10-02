Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD204448B9B;
	Fri,  2 Oct 2026 08:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790928922; cv=pass; b=cdRFoX+K1EJr26TFJ1H6EFNC3KGypNzgGTryiUvd2yjbmuaiIbPPT0cVc9APluYSee3IcLVJLWanHWYd2/dhTQNrwv5H6zJB9/oHwYn7bRRPc3bAKHpicYjDIC9ogy4UGgZwJ3hZJJ6y7YscMqa+/3Y38x4N+nHI8jtDVHDzuXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790928922; c=relaxed/simple;
	bh=DuQn3j4aD/5jNGOAHgLJRWcIgKIHnpwH+esm8rkJG2c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nMWDQAOGFMmvLeJleb6i1ssuoUejDK6AdeqRxGj2pd5KEQW1QxHcHNBTzDWWt7JIbwr4GkbCUIilUDEj3pj/XvygY3HbJv0EiUinstgXk7AXEgwe00BFnNbfCPYg3B3lg/Pu9nj/3SsUurEzITUExQX9lEACmvptJzG/l1J8sWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=MJn6CR9V; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="MJn6CR9V"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 043F1201ADE;
	Fri, 02 Oct 2026 10:15:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790928911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j2gcccesHYnrmwQG5QPqWbFPSg8E1Rph4z9PUU0dF1A=;
	b=MJn6CR9V2vGES3wJfQwxpqPoTi+j0S8iaXN37zMP+ysf9IIZgt7C5u7Mby8nRJyFSODFle
	BVxnItX/wHScmXxJBDgdZMHPbYgYWQl8TAdpx5h7EbZQcCZUrCwMv+TcEvVkcEtgx47fUD
	BYd66WsG9njoFzgrJnQqdMoOG8x6ZZi1NQ+xhRVNY7z0OOxI6K4RL7zqT4bBC3mBXEPhkS
	lONETcDyeScmW6aAyJ0yWqDl6ndZzuANYtFUS7vp6WLd+EvNN73UgV2/9zBjY9JltxxYiF
	bq+yXZbjrmvUAoctBNa876yH/vDu8DFUPPh6CRZa3Ink/yw+mT/euEOspEnBtg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790928911; a=rsa-sha256;
	cv=none;
	b=IBSVDhj9qKHsY/xF1Atn1lQ8fNTB057M42K3s1kRAkQzDjFe8p3ewcE2iJmkfwg+SuoSyr
	UPJsivUU+m8RXLsT6ebhhYbDf5H4CERWn3sm+En6sEPLvY+Cls/UnEdO9IbWZpYObe2mdu
	vIPFZIFKXy1lXEzJjcGib1ArKhd2LfVU5IcjXeEuSFcsUo8Nsq5QaXXneGhRpHepzHhMid
	YlHbajd5oFAGkFvn8ucBUAL9pMNstwFdSgrCI1nAEjhtuf2H64eIPQKVoqmOrW22QnqjWO
	DlVKxjH8QqpWtluXuNNyeltrgErGiYEqBhZFoesl4SAK46DufesRFGPCBdxv8A==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790928911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j2gcccesHYnrmwQG5QPqWbFPSg8E1Rph4z9PUU0dF1A=;
	b=BMd0xMzH3EJYiznrKfUlt8FptX03RfkhBXn9cmW1TAeghFUkmsgfRb1VuBKAkwZW+Ysqhe
	P0lW+0cGjLi+xGhesFXtpM+mzHlNjPmKYlGbZ6JLPEtbr2Cz9uzuTjxP3emcPYz9byzdlv
	jKn0Qb+KCl8/IH0Hc/42x6PVIppf28U5FaF66+6s+1k8Xr6mU05AxgQNgrTBVJmRSKBYUq
	HyJhdIooW8sWfu6jeLSOb4a0PBVsSv7ZH+VkF5QQE1ITmMunUZ8bEA1i5FpWsLp6GoP6oU
	kG5ygwRCU1PdjUxzEkhiAKxskzDvhEcwOJUtTmUh58ah7nerOU86sxlWzBLjTA==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xCYQA-003rVR-2t;
	Fri, 02 Oct 2026 10:15:10 +0200
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 837CC5B8290;
	Fri, 02 Oct 2026 07:55:39 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Fri, 02 Oct 2026 09:55:14 +0200
Subject: [PATCH can-next 7/7] can: peak_usb: Add support of loopback mode
 to the PCAN-USB FD family
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261002-peak_usb_enhancements-v1-7-50e965755c06@pengutronix.de>
References: <20261002-peak_usb_enhancements-v1-0-50e965755c06@pengutronix.de>
In-Reply-To: <20261002-peak_usb_enhancements-v1-0-50e965755c06@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3195; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=p0/oRX309JaYF2hLrsEktXrWRELVLhjsz2qVf7hIo8s=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsjan1w1YUHe4S9Nqyd8l/aLXnxePL03L+Re4cxqYyubU
 JVPho+mdZSyMIhxMciKKbIs/XFCUSDQobT3ZcIkmDmsTCBDGLg4BWAi9bcY/hlHTl7gdv/+jHCr
 41X37fXufzt45OTq5dW6c5wvWLacO3ef4X/VO8f4g+8eb9c+lCGvknQ+frvkyu73xlf3edgtibO
 qaeYBAA==
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

From: Stéphane Grosjean <s.grosjean@peak-system.fr>

This commit adds loopback mode support for all PEAK-System USB-to-CAN FD
interfaces.

The implementation follows the same approach as the peak_pciefd driver.
The only difference is local echo handling: on USB devices, transmit
confirmations are provided through USB write acknowledgments rather than
through the reception of a controller-generated loopback frame.

Signed-off-by: Stéphane Grosjean <s.grosjean@peak-system.fr>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
index 9081f30e3d35..59debe009f92 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
@@ -934,6 +934,12 @@ static int pcan_usb_fd_encode_msg(struct peak_usb_device *dev,
 	if (dev->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT)
 		tx_msg_flags |= PUCAN_MSG_SINGLE_SHOT;
 
+	/* Request controller loopback and mark the frame as self-received,
+	 * matching the behavior of the peak_pciefd driver.
+	 */
+	if (dev->can.ctrlmode & CAN_CTRLMODE_LOOPBACK)
+		tx_msg_flags |= PUCAN_MSG_LOOPED_BACK | PUCAN_MSG_SELF_RECEIVE;
+
 	tx_msg->flags = cpu_to_le16(tx_msg_flags);
 	tx_msg->channel_dlc = PUCAN_MSG_CHANNEL_DLC(dev->ctrl_idx, dlc);
 	memcpy(tx_msg->d, cfd->data, cfd->len);
@@ -1263,7 +1269,8 @@ const struct peak_usb_adapter pcan_usb_fd = {
 	.name = "PCAN-USB FD",
 	.device_id = PCAN_USBFD_PRODUCT_ID,
 	.ctrl_count = PCAN_USBFD_CHANNEL_COUNT,
-	.ctrlmode_supported = CAN_CTRLMODE_LISTENONLY |
+	.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
+			      CAN_CTRLMODE_LISTENONLY |
 			      CAN_CTRLMODE_3_SAMPLES |
 			      CAN_CTRLMODE_ONE_SHOT |
 			      CAN_CTRLMODE_BERR_REPORTING |
@@ -1342,7 +1349,8 @@ const struct peak_usb_adapter pcan_usb_chip = {
 	.name = "PCAN-Chip USB",
 	.device_id = PCAN_USBCHIP_PRODUCT_ID,
 	.ctrl_count = PCAN_USBFD_CHANNEL_COUNT,
-	.ctrlmode_supported = CAN_CTRLMODE_LISTENONLY |
+	.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
+			      CAN_CTRLMODE_LISTENONLY |
 			      CAN_CTRLMODE_3_SAMPLES |
 			      CAN_CTRLMODE_ONE_SHOT |
 			      CAN_CTRLMODE_BERR_REPORTING |
@@ -1421,7 +1429,8 @@ const struct peak_usb_adapter pcan_usb_pro_fd = {
 	.name = "PCAN-USB Pro FD",
 	.device_id = PCAN_USBPROFD_PRODUCT_ID,
 	.ctrl_count = PCAN_USBPROFD_CHANNEL_COUNT,
-	.ctrlmode_supported = CAN_CTRLMODE_LISTENONLY |
+	.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
+			      CAN_CTRLMODE_LISTENONLY |
 			      CAN_CTRLMODE_3_SAMPLES |
 			      CAN_CTRLMODE_ONE_SHOT |
 			      CAN_CTRLMODE_BERR_REPORTING |
@@ -1500,7 +1509,8 @@ const struct peak_usb_adapter pcan_usb_x6 = {
 	.name = "PCAN-USB X6",
 	.device_id = PCAN_USBX6_PRODUCT_ID,
 	.ctrl_count = PCAN_USBPROFD_CHANNEL_COUNT,
-	.ctrlmode_supported = CAN_CTRLMODE_LISTENONLY |
+	.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
+			      CAN_CTRLMODE_LISTENONLY |
 			      CAN_CTRLMODE_3_SAMPLES |
 			      CAN_CTRLMODE_ONE_SHOT |
 			      CAN_CTRLMODE_BERR_REPORTING |

-- 
2.53.0

