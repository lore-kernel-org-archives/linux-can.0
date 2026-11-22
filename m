Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795373340;
	b=E0Kt3tdAVnjtDyuXRX3t7li8QvxiYJ6m+D7gL0bwKiHJKx5Fthd9ok7Ael334IbAE5Zq
	 BgMrpYQm4zzGWMhEcdCdY77XG5pEumW5rrvA6MkcMEHQREYHhxchREvcIl12Mqn3oignI
	 skjqA07cCeRzQWB17kOuWDtrC+n0Q0Rlt5y/egDybB9zJZTPp+DRDZjnUzd4M0kyMzKiW
	 c+2gY4/A/H9mgVRPGiDAb6zOMnuBQ77Mc//OQFgsF/3BNhm2nG/voE1esMKscP/NSO75h
	 yW9MjXPOHbDwBTV6nc4/zE94+wvhJOcAoIQEnChOZxu4RYJTUedVg6SgjlufWaQ50xg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795373340;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Ejr3uQ9Ze9PJNeVDQ58XrzPSCK+bxa6GSj1fcrpAbfA=;
	b=P2sW/xBt7XXNo5pvDDHUHLPn8CiNh8Y5b92WUrpTMsoBh6hhg+6oft4tGcB4AomelwFs
	 H1ocfakWwqxabVeZHaa0ecejv/oISMHw0WPM6SUWvefwAzTmr/j1JUUI1Xh986BMw9dcJ
	 7MorlpcgbzDdlLlJg9BHwi80FMceEeS5OCzm/bDJcIWB3BohoHPDeb1CWEEe3N/YHlq94
	 kzXL3/DK4VM0gDjoVLvIjNWCd8EIDxQOB6bL5UuU+ZvhPbEPCK6NkJGMSqyPIac52kl1T
	 11hoD+YIue5ooNt42VcHnotUMTXImhDg+2ElFEa1iPIhyq0bfD+69WxGgN7YzBeYXiQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=G4QI+lBS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF05B606A32A
	for <linux-can@vger.kernel.org>; Sun, 22 Nov 2026 18:48:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF05B606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=G4QI+lBS
Received: from hardanger.blackshift.org (p20030102af17cb0015d71b554e0d6387.dip0.t-ipconnect.de [IPv6:2003:102:af17:cb00:15d7:1b55:4e0d:6387])
	(Authenticated sender: mkl@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id EDC47205B42;
	Sun, 22 Nov 2026 19:48:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795373331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ejr3uQ9Ze9PJNeVDQ58XrzPSCK+bxa6GSj1fcrpAbfA=;
	b=G4QI+lBSnd7eDqQQMkRt7QaAvrLLMUWmgXlgAXD1jjFa3DukgNjXN6VjZzXxNMVqA33zxE
	rASLjalkzYRlEHOTgFMRYUZWZ44xSxPP+UAEYqsQ/pvnYxWyCNYHVLhtc5c5O+xyz8LIVh
	iG5f1hp+Nji8OCJtmZUOXl7qacZ268wCbtyAqbj0/CViTEkV7rQDFhDvRCRDuZE+BFlraZ
	gtJamemjHd3FMBs4vPrnP6ixZyz3qtDVJ9/LmO0k8YBA0c1ckGl0+lNdCERDCbBILCTHFq
	EybB4EWKDGj4DoMGrBFBAyS+hHNDmA53xguAcX1fSLPZXZZdz5BjqF9OaSf46g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795373331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ejr3uQ9Ze9PJNeVDQ58XrzPSCK+bxa6GSj1fcrpAbfA=;
	b=UUX9OLTOK8IvdA1WIgC1KQtSfbgp3SJMnERVXTQTGcx0L7IPBr0gIG1PjEgaCRYpGNRdlK
	r+79afvm2xXLIVgnT0LUcJ+aBdsTJCEvMK9AHGfEXX31JQsLR8Z2L5SpKKOYPgffOzXj2U
	L3kTBq8aZaXhSltP2upc7KBhg6QsIy8nDgDOTkJYEHcSprxkUmIlwj2+4GgQ9ZlPbZrHeY
	Z/0vYeLjUrYsMzu1yjl87Vi+Vgws5jvAOGztlNw137ncaMe8+N/neFF3rSiMlb6YPlz4sd
	RcowVSoot+LP4qL/O/xOFK8DUbdHZZ2n+Apq7U9M55vVMXJI1pqqhAidYx20rA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795373331; a=rsa-sha256;
	cv=none;
	b=OwAoT3tdmZ50eBPDtkFuLCplFdhPcCxdBaJJDeuIu+/m6fmnPtL+iMENg0Td/MV5ru2vyu
	DvugcaoKci0vTzj1f/F0UfCL7s0MUPbWT01kGpLsLhfBnb4NS3WAU2BEkb05esKMWkEOz2
	hHbxOjXwTsym1HyRP2mOReevey9MeNioz0gsWz2DFEDM9TROfElK3PI+HzCz6BOo/vTQM0
	g3EpjkD3v+/7wR+K3NL3Mm5TsPd1ZeBUHS8nv6jEL/B/ZlyuDnlOoP4tbHiJIpDQSaaHu5
	JOv9iSBH+u99/BJs5mOHI2Rw8SHeu6uL8ZilkLa3x6S5x+7EwXl6UUIhoYrWYA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=mkl@pengutronix.de smtp.mailfrom=mkl@pengutronix.de
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sun, 22 Nov 2026 19:48:35 +0100
Subject: [PATCH can-next v10 11/14] can: gs_usb:
 gs_usb_get_rx_data_length(): new function to consolidate validation of
 host frame
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
Message-Id: <20261122-gs_usb-fixes-v10-11-7c165c35d04a@pengutronix.de>
References: <20261122-gs_usb-fixes-v10-0-7c165c35d04a@pengutronix.de>
In-Reply-To: <20261122-gs_usb-fixes-v10-0-7c165c35d04a@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, Peter Fink <pfink@christ-es.de>, 
 Eric Evenchick <eric@evenchick.com>, 
 Maximilian Schneider <max@schneidersoft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.17-dev-1b309
X-Developer-Signature: v=1; a=openpgp-sha256; l=4254; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=otMJK5LYP1gvudSOthdAV/JGhfBnbGZRu7L8rmKomJM=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYshmtuQOu7npRH3Z0eIDZmoH1uhKZ9241rNyi2/Tp0Uyn
 X5tKyMbO0pZGMS4GGTFFFmW/jihKBDoUNr7MmESzBxWJpAhDFycAjCR2MMM/6NPPNwUFmLeVGhz
 bzdn6gmp4oNOIp819oaF5k5m0ZhfYMLwP8J9BesunTUtLi+latct1YtlX7Bp86uHr0MeJ5SsvnH
 oLC8A
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
index df5ea6cb0cf2..4aa674c743f6 100644
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

