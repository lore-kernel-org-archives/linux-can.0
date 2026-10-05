Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C190E47886E;
	Mon,  5 Oct 2026 10:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791196863; cv=pass; b=oTVTspZ2DTTffNKbbkdrmayLYOjfv/vzkQUgtQa9Bd+PJ3/YNFFj0G1jbT5fybFFO1ssCOiM24+SsQwzN7B2OP+4kTsonMFHMqTloGjabOV8deHiDFQAii7B7giA5NGY/hlL6A99Y+9f3BLlbPido3j9qFttbmCoiiGho+zrwFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791196863; c=relaxed/simple;
	bh=Zfg8fHFMf1VFhB2E4FDTxiOO3DTmQeLycFOScucBhVg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PA6Q50qKs77k9MUNV11UB3QruYPJSEvnFCXVGhJb1CICafSPP8xAVSB1LC9MT1lseY0F6/PGEsPaj0dZRKlYB8/2f+cXK2qoWQYpywwuaoe1QBdfp3wff/1MTB61XmiEDgInUawgozYoue0dp2i576sqkQ1VRZQ3ZCuJzBQaKxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=GrCnOQy1; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="GrCnOQy1"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 9C414200467;
	Mon, 05 Oct 2026 12:40:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791196858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=B1uONVtSX29bcbv/UYeeqCKLslwEuxu6EwMUDscQMNA=;
	b=GrCnOQy13bFGWCfhyBVYtA917pvdQ5YZM7HgRraQyZ4WZlOyKjJfV3fUJIy3p4s3GMVfMv
	/VaU9CuLaYLTEBJIKoNVlp2Y/MU1Bbfqd/b1Vltvtsq4U0bgrVfEyfsvPHMYfsQw1clmHT
	ParqvXVzbn/lXVYr5mu2TDs+vgLlf2iBeXSKcv12Gba3Ps4mOC2dhsUGe1NaJO6oZKk9un
	UXGBYZ0rVJ3pJ3vMysUDXCVHeEBY7ZU0wakMPd7ftvSD59Yu/fi40lyxBGHIkHWjIpGvm5
	sD70mhjGrjEYQuKeN61CVeYJ+ExSTjSiLn4WTH4Fk3VyfjaYhWPzzs7Dejo1AQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791196858; a=rsa-sha256;
	cv=none;
	b=dqAnfiuTypYk0q4t8slIZQ3ETyJD+ouIwmrzS7zljl7o4VbTSa54NqqQuQ0GAhcN936n8x
	aLROwoXdwmFfJRstYEvDJgUrhpwruJZXs7H6EXErrpbnce1xOePnExGUruV7LxW9zgk6Tu
	Qx5ZDDLoVsBbtmSVr0yGU+BBLhTJ2mgELmyaxZOUlMcyHtmeGPwtc8NdfU/Tuf2i7+unRK
	9qrPKwnnmT1V1qEosAxSA7xYC21pWuLc1MjqWJU0KVzPFa56mN/lP68QaSflZIXatALjoL
	oxJpLWDm7gFV51f3DGprx6EiRsAUU4d73+zgEsR09zJvB2ADAozS3vDX3zoXRg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791196858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=B1uONVtSX29bcbv/UYeeqCKLslwEuxu6EwMUDscQMNA=;
	b=YhVAChbmyC55Cse/txSO0/ZmXOecUt9PiaWHr9a1fn5hS/A9lUMNV9cNjymi1FKxLB8LBP
	ESkuYpohyRRjckN1UxV/PvmN+0KhawnpHi3zR37ZICg/T0VjwOuqJ1NTlK+QYWHSdnYPrU
	/7i0NneWtwv4bU8fzbfDcpYIrWvGBPJ1PrCcR5LUuZM2FzYAgrBVIInmG6GIqF8UQ5uLpS
	wwlDk87IaHRDaYtnAdzidQRZQUth4PvwYsrK1FIFuthc7VKvhhLPbBoeNCWw/goKc8jzoj
	GUCpleVspIKpVGbRtvEnaKBQGFi1wutEBqrYgX4FNwmrY/G8pG3w5ParzmK6ZQ==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xDg7u-004Mx4-1e;
	Mon, 05 Oct 2026 12:40:58 +0200
Received: from hardanger.blackshift.org (90-182-211-1.rcp.o2.cz [90.182.211.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 184E45BA0DC;
	Mon, 05 Oct 2026 10:40:58 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH RFC 0/2] can: rx-offload:
 can_rx_offload_threaded_irq_flush(): partly flush skb_irq_queue
Date: Mon, 05 Oct 2026 12:40:23 +0200
Message-Id: <20261005-upstream-can-rx-offload-batching-alternative-v1-0-4c08ccb516ec@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNQQrCMBAAv1L27EJSsYhXwQd4FQ+bZNOu1KQka
 SmU/t2ox5nDzAaZk3CGS7NB4kWyxFBBHxqwA4WeUVxlaFXbaaU0zlMuiemNlgKmFaP3YySHhoo
 dJPRIY+EUqMjCaFvSTpnziboj1OSU2Mv62z3gfrvC8y/zbF5sy3cE+/4BnLHqAJUAAAA=
X-Change-ID: 20261001-upstream-can-rx-offload-batching-alternative-c2a1d0b85a63
To: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Thomas Kopp <thomas.kopp@microchip.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1099; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=Zfg8fHFMf1VFhB2E4FDTxiOO3DTmQeLycFOScucBhVg=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsg6XLdp3pX+1ntflyizO8VGTTgbFvmka1F+t+jGr4pMu
 6fp/L+6s6OUhUGMi0FWTJFl6Y8TigKBDqW9LxMmwcxhZQIZwsDFKQATmebOyNDn9tO2961IW97q
 qoUvmBcdYPePTH+0wUbhQvhscYYHn1Yx/K+ZMGH6C5WkKY+EXnbI9t99sDT83b3F9gGfJWyOzvu
 5LoYNAA==
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

This is a proof of conecpt series to partly flush the skb_irq_queue. It
should avoid issues pointed out by the netdev sashiko bot in Ciprian
Costea's series.

When the system is under heavy load, flushing is required to prevent an RX
starvation.

Partial flushing is required to prevent out of order RX errors when
combining multiple RX FIFOs.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Marc Kleine-Budde (2):
      can: rx-offload: can_rx_offload_threaded_irq_flush(): add newfunction to be called from within loop of threaded interrupt handlers
      can: mcp251xfd: mcp251xfd_irq(): add call to can_rx_offload_threaded_irq_flush()

 drivers/net/can/dev/rx-offload.c               | 88 ++++++++++++++++++++++++++
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c |  1 +
 include/linux/can/rx-offload.h                 |  4 ++
 3 files changed, 93 insertions(+)
---
base-commit: cfb7793d1bc0f7d90571611979654cf1b3886b29
change-id: 20261001-upstream-can-rx-offload-batching-alternative-c2a1d0b85a63

Best regards,
--  
Marc Kleine-Budde <mkl@pengutronix.de>

