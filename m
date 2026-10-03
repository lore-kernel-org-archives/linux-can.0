Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234273B895A;
	Sat,  3 Oct 2026 22:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791068038; cv=pass; b=gVF97IKRK0dg0bBEyOenF5Rfe5il/gcnX333qHVXfSOAuxstv0myCP+W1zsnmAz6lmoi8ngPv55tPn2bXo9fc1ZIWPBkpRLWVAHbYvVDXrLAlnFtqw8+Bwufqqbx0OupID6KZYDKwYKo8VwyN6YarmYy0oY9OOBg0yeYSUptWOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791068038; c=relaxed/simple;
	bh=EThT5N/RJJZAjGJbqci6ds2A48n69zbguyd5b/wY0xg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r0lnx6OHqbxZeBIhIdtni/qIK95H5Mid36Mm6Xh46tRyFICHRCXuutNdV8V4V3tmRfEtx+enbEEAhGyiIZRodVFXDFQvnhhxK3IPuEeOxL0zJ2qtaJjT3QelL6z/3RqG26XT7ScyjWy1SAtYR7YlQeaUHZwIcQX6jMs82t3OVRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=Ki1bicx8; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="Ki1bicx8"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 51C42202348;
	Sun, 04 Oct 2026 00:53:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791068024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oUMixj+FYDQKkOqcZ8DGPIaaMoCj59BQw+lK3hrBXQ0=;
	b=Ki1bicx8R2Vp8RoRwRaJSs4Tvd086SgnIyk4qNSgb0+noB8NIJYJb1asJHuKRpsVpUD/4D
	vm/XyOVmb7Pj5qres38cVoTwsyI4PG1bTu6W4Ah3vXUbmzF2RNSQM6dIjsc00pz9EcKpB0
	cv1txLI1cW/pe7lZZ0xvSr1sT/3LENjqU8IMGVV8O64sLjiPgMc8x9+kCVttrphH3x0R77
	Wc82JGRa997wa5NY00Dx2fY+RuPfuBTZ1s5h/IkDZGdDCfrmIY/BbhS1l8JZhtYZ3ZfLar
	xl4NQpGDW0/AQDq5lqkJLGAYkD5ndjNfHWgOqBUZdrWEj7ryKqAOGdgjU8vKDQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791068024; a=rsa-sha256;
	cv=none;
	b=bq/D32z4VomcbPHKN0HciwZ08DDikcvduX+TacgLZ09q6B2ppouGJThtKlkI1oZWlpoOLB
	R3cQytCh8yw0Fe22Gv9vtP7p9d1Ijadnxj5itmH95W4MGZfwtgvXAk0bC8bNtm5r/IGle0
	1d2eDshFKNGUFaINOHgZYLEW1d01No4HiMHiiCHGTu/vcvj/NKNd5DsmhwS9fikkpjEUxv
	xDorBEYTuYpPDpxElks6wgHuqHaxb4JjQmh4E/LJtafwbOZcHKBvugXXShlhSZqQuiHGSD
	JdUDWPJDmUDr46YqRQWGQ55Bep1HAMpDJifX0YMICYixmCdqXVxg3LiEUgcN/w==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791068024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oUMixj+FYDQKkOqcZ8DGPIaaMoCj59BQw+lK3hrBXQ0=;
	b=Q4EAiUgkxwHc1AjjRuggYT28ZdvS9fvNLBMSNi4+t/ZamZBI9rP/LhbDX15ai0EuAPY1mz
	k2fvXxe8QxA5ikzrgSrBZ2YBfNRdUVDciUPngLPapYxWcdsG0Mqmcgq8K6o2ye1er1Nuc3
	iquCgAtBXo7a7L8BjzobpQQVFPyfiiIlRQvdNAK3ny1YcqaAH7AXircycufUJkSohGQSP6
	2nuRaGDuxdKbe2kCGfT+euGwWloDwLq+HOHCxqgR1fZbQIOzGf8J2G27y58hsmN0JJ+0WD
	5w642flT55WV4+SMocohfGM6ZXv157BM6sFda9PmpWWbd+FddqyC3wD4xocwBg==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xD8bw-0047mq-0L;
	Sun, 04 Oct 2026 00:53:44 +0200
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C864C5B93AB;
	Sat, 03 Oct 2026 22:53:43 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sun, 04 Oct 2026 00:53:18 +0200
Subject: [PATCH can-next 09/10] can: gs_usb:
 gs_usb_receive_bulk_callback(): no need to assign CAN_ERR_DLC
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261004-gs_usb-cleanups-and-fixes-v1-9-7b4b06244a77@pengutronix.de>
References: <20261004-gs_usb-cleanups-and-fixes-v1-0-7b4b06244a77@pengutronix.de>
In-Reply-To: <20261004-gs_usb-cleanups-and-fixes-v1-0-7b4b06244a77@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=806; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=EThT5N/RJJZAjGJbqci6ds2A48n69zbguyd5b/wY0xg=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsg62F5qvbEy2jA/7nhE8xSV5jVnVhwXkrzoE7l5woH5b
 rrRpgXZHaUsDGJcDLJiiixLf5xQFAh0KO19mTAJZg4rE8gQBi5OAbhILMM/e+Nn7alzevVqUjtZ
 705acFPk/4/tv3JkQrZ4BD8ykarfw8jQMs1ONXqOzI8HV5tPtddWZ7QftPQuimKZ0RggwmWXNo0
 HAA==
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

There's no need to assign CAN_ERR_DLC to the length of CAN error frames
allocated with alloc_can_err_skb(), this function already sets the length.

Remove unneeded assignment of the CAN error frame's len.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 190cd3701202..3c0464edb5d3 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -735,7 +735,6 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 			goto can_rx_offload_irq_finish;
 
 		cf->can_id |= CAN_ERR_CRTL;
-		cf->len = CAN_ERR_DLC;
 		cf->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
 
 		gs_usb_rx_offload(dev, skb, hf);

-- 
2.53.0

