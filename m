Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E373B8135;
	Sat,  3 Oct 2026 22:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791068032; cv=pass; b=X4G2zhYFwmzD0TAOIYOpEwH2ZvynSrhNvsJTU36TGaR/u1a2RC+DSRSg50kwq4Tami0OoDm32aDxk0Gscm2eTUnk1+oBJx06WMDFwRylibQmaCOX4iXVRxoYatkt4cqlhZEShR03XnbfqdXj6sjZXMUh2b3+AzC8OxdyC29pXKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791068032; c=relaxed/simple;
	bh=TUwho87mD+bXrfsY5pWUwopbS94fJ5s8o7MI7JiTbZw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lK75zULEs8QiBDkEPZ4ZByqQVxRjdFYN4fQd710NdIEPIe7FnG69xQL7OPJEIRUvHp1u1lBenSAAT2enSulTkdK1V6lBqN0kumIwyW9+gtIjxBW/J7C89rHUswXJN85/jbF2KUgFLykkuv1AAR6oCfXvqCXIjsjuGbeDMJ/Cgk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=Ea3IrJAu; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="Ea3IrJAu"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 401C7202304;
	Sun, 04 Oct 2026 00:53:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791068024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I7KN2cqCGVceUNYNRTAdJFfLTwwXF+GngmVAwGNrZgs=;
	b=Ea3IrJAutbQL6R8wjbuHA2UD22bpfZJxs9KdZ3x18/4vynXWa50LmxE0O388Ns7+0sKfLu
	oFMHOX0YLXOzxwcG2SVR5nWTiBSDOQxSXRSRjPVxV+g/uUTVQkkK/q3+BrwQNQWowGj0U4
	4tzAVeU5XlG8wDP3SZ5K5GuaA7FaWjVqOcfQHmrmYNE91tlra/ck0JaVXw+nroQGX/N3At
	m13i8uW2d3oWhPL8fcurUFXDmbwZnf6iKD7bj9dDYuvTSpHQ8nvpSni8f/6yIEPSFVI79d
	HW7olyfmWr7LG7/rP8nHmdgAwmMbuL36k/Pn85bEznIDZKsgDSVBslmeNi9kCg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791068024; a=rsa-sha256;
	cv=none;
	b=e+ktWbEVAQdKe+HBQBqx2zQWDHxUZLTtWxE0VBWibVmmkzFZkmycY33lnb084N8LxcWc6W
	Sq3fyAJb9KRXXrwf7VDppygVPOHbi/ZR9jiIRxDk2B9URUpDcTHdYTbHM+ekMXuVV2jl+S
	Pf8LZZDnVHAICNBtbeQJEP0/Q+PXp5M4G2wPK7uBiVQDnEyKqVhkKJdxz4xLLKwEZ79xI9
	9xBzmY9AsPe5rc5cUmUy/tnpIgnc5AOemp8bjRmjeqTWqGgrLLI+GSm42EiD/6BXqRR/LG
	LcR+G/4dEiVaHGcVQtlqN15cgOFj+mE/ZVei1DoiKZPNOyEYJBXGdBO90aslnQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791068024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I7KN2cqCGVceUNYNRTAdJFfLTwwXF+GngmVAwGNrZgs=;
	b=g5tHJ8I2ICAV8AMl7VO58woDYT3L8nEyaj+9pYvmpSpEo8/8i5vYMdsuXSomIJZIsNVweK
	LgmPdr0HHesYDdN1ny1YvgoEQ4FkHRVcsOa8lKSKMjTO2jzqfQjWwMwOjg9h4yx5CKydvX
	ul4ik/IVyKbEwkv9hIKRoWIc8Fw/Mj/7X8JI7CzeM+yQcOslKk7xJ9jfVbLDhjGfxEvCZN
	m15pnief0wRucPoynhN2U3Mw/JQVmCwZtoc5KnHs8DmCO7Fh0OU3YrtBPI4o4eE6nN1hYg
	9Frye3S+VUJb5FoQctybZAVpbVap2tpgZ9CNi5cSphv/iqlAxDQs3xc5hEl0Vw==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xD8bw-0047mn-0E;
	Sun, 04 Oct 2026 00:53:44 +0200
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id BB15B5B93A9;
	Sat, 03 Oct 2026 22:53:43 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sun, 04 Oct 2026 00:53:16 +0200
Subject: [PATCH can-next 07/10] can: gs_usb:
 gs_usb_receive_bulk_callback(): report channel number out of range error
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261004-gs_usb-cleanups-and-fixes-v1-7-7b4b06244a77@pengutronix.de>
References: <20261004-gs_usb-cleanups-and-fixes-v1-0-7b4b06244a77@pengutronix.de>
In-Reply-To: <20261004-gs_usb-cleanups-and-fixes-v1-0-7b4b06244a77@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=964; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=TUwho87mD+bXrfsY5pWUwopbS94fJ5s8o7MI7JiTbZw=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsg62F7UvuCIfpZpayVb69/KyL9Xrggtf36l+/XDrF9CM
 hat08u3dZSyMIhxMciKKbIs/XFCUSDQobT3ZcIkmDmsTCBDGLg4BWAiFhMZGRpCKxcYuzq+6Fp3
 c3eNy4uoP6fv84TNzL0781LhyoTNtg2MDHuNRW7I7y7vOsTtoVp5WaF08up6qVkbpu543eJk9DG
 lhhsA
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

If the USB device sends an invalid channel, the device should not be
silently detached; instead, the display an error message before detaching.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 848a84a05fd6..86f7cac093a1 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -627,8 +627,13 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 	}
 
 	/* device reports out of range channel id */
-	if (hf->channel >= parent->channel_cnt)
+	if (hf->channel >= parent->channel_cnt) {
+		dev_err_ratelimited(&parent->udev->dev,
+				    "channel number out of range (channel=%u, channel_cnt=%u)\n",
+				    hf->channel, parent->channel_cnt);
+
 		goto device_detach;
+	}
 
 	dev = parent->canch[hf->channel];
 

-- 
2.53.0

