Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794661041;
	b=FHr6qLcix20xjf+E9DGsINViOrubsp0x/mSmQFwKoDU+2I8Ee9h/y0XbjLasOFmplSI2
	 aEhpdahz+rD7pFfE85InYedaCL9MNnO/Hy3dowpt1RKOUG6yuo/LROiyEMgcArmeBhStU
	 m9E9ZiyOADUqPafeDX1gSFrtkpDQ1F0rMakxKiJcuERn/Y+A2Tlh4jvgx42avQbwmpo7W
	 jKGFAOErl35BWOZ1vAxCYRlgqokV+9l8sjYwmpEivPoWYw0pRe6R8U+jRwBmyKmGvUv/+
	 npkBuZFGl6SBEeL5o/5OnVv3T8xXLQxMTDnNVzYz+PsdrbrN+T2K+MWfvqWDx5LZVwg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794661041;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=HxSisoivI5TlFI4z/juRf21tjtS6x9EqwvdGSd+qfGQ=;
	b=NbVhnXCasENEhhQ9EFM9umuOSo/awTqcLnWUj7Ir3WHwwMjLMIPJTOmmEoqsL/Ozxin6
	 j1qS4c4aH5vxL9nM8v+mtHdyAlPmJMLXxXInwDRsEYORA4TS2ClFh+WUQUayFtQXrKXOR
	 qHYg2gsWclWmosMB5P81JEccQgY2VW/1JkPIfqWa7muOIsMfsJAUnNOiOuQtBd2xYAX+R
	 q+l/IwAQc5zTMGu+cLmUhexH1330MIMvHnfkFNsyuMZtB0idoi3boIRDe+/wZNtDUzmA1
	 VnpmYAXguP8qX/hCfqubx3x+Ob2u97vXcynHs9erAS1DEZtEAvXsgHlu/oroaNewr+g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=ToWeG7Cl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FC6606A323;
	Sat, 14 Nov 2026 12:57:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7FC6606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=ToWeG7Cl
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id EFC8E20233F;
	Sat, 14 Nov 2026 13:57:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794661037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HxSisoivI5TlFI4z/juRf21tjtS6x9EqwvdGSd+qfGQ=;
	b=ToWeG7Cl5QvWbnVQAhaupDApGNCZFU5mdjC/gy9Pn1h2r+ikkeukbTVYcyAdYEB8vACJZt
	gKFCBrZnF4voa/MAhYSowtBOkcm871g9ngQwF+kYF5HFb+lbDLsDPpCpBBHW0XoFgawB+m
	EkRUDRzD+VRQPD+Ad2RsrmAwhhpbHdpbdi5trcqIUyzNNV840JW661OVnOeVVDy2stb7Ol
	FsJ8j5FzBdhO5xSIrMuFYRvKdMs5rqRSm/pHPBb1TyMabaFgqDScZVUg7k1U/g+9h8OFtU
	PJdQMtHK5RHib83g3nptJUen9/Dx/CBTsKcySe0RCheqUudg+ZiywMmTsRl6sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794661037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HxSisoivI5TlFI4z/juRf21tjtS6x9EqwvdGSd+qfGQ=;
	b=aW/wOAbdYb1t9yMHq51KJLYHhROIJeoWra05g7EmyONJ2KIBan73v/cMtfVp+NZfDupib3
	tmDOh2//B/EnHGuTvnE6aqANE/j/4zefSFdL7RAQChc8UZBVRPtkpp3UIOMPg7UgVXhrXk
	DXWRjEn5EyFhqo3JZPCbMWkfrWV5FCYVmyhHdBAu30NF3fQ0XT9VOUWb9/Vafa1e2xKdHx
	EktfGU69F68mxqGmIrRABX2ouNv8JwFZfgIXvyFj+XVdXV5n3EB8b0qDf9y/oPzL41dvu0
	RtJgzrLzUT26/x73HXaGdeNfQsji4xyYLYPNBqSxqVeMnQ3vDX27QrOO24oi6g==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794661037; a=rsa-sha256;
	cv=none;
	b=Uis+tfytRoDHgsVgsIatCrCwad0AYBMEcbGcBaqpp1xa87Y59iMOAG6wpREu44zdo07mr+
	K/2NBOTO7humIM1lDYl3ObuwRywLaXRzC54Z5PtIhaqt5njHru8RyEbEy5tJ/knBvyWYln
	eB63jGErnvIVJ9DRq6P/r6Aaywp7/PS1FqWXU2uoTxJKG4KG2mxH9MjOoATBAjnEULq/Rt
	7SUv9Ap23+tOtpZywd2KvIJ7f3G1AGbRMQc7m6WYOS1mZpBgtCbu0nMJ86VqEaMB8Y+fJ/
	ucs3wndOV6vF4C3q7Uxn3uIDYc6WIsdy+o0096JmGbLq+aa/7DN7gLKF9GHCTQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xSDJl-0048pW-2P;
	Sat, 14 Nov 2026 13:57:17 +0100
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 9A4165EB9AE;
	Sat, 14 Nov 2026 12:56:23 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sat, 14 Nov 2026 13:56:17 +0100
Subject: [PATCH can 4/4] can: rcar_canfd: rcar_canfd_probe(): reject
 devices without match data
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
Message-Id: <20261114-fix-device_get_match_data-v1-4-2d82025e9646@pengutronix.de>
References: <20261114-fix-device_get_match_data-v1-0-2d82025e9646@pengutronix.de>
In-Reply-To: <20261114-fix-device_get_match_data-v1-0-2d82025e9646@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>, 
 Harini T <harini.t@amd.com>, Michal Simek <michal.simek@amd.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-renesas-soc@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.17-dev-d7211
X-Developer-Signature: v=1; a=openpgp-sha256; l=898; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=3iAgGk0Jo3GmyGbkpHqH1FzdNo7ko3o9hbReVSOW0Y4=;
 b=kA0DAAoWzDpk+q6ZrdIByyZiAGr4WnWg+jsDpc6Flau3YI2l9fSmk/KTyN/nNSdH3tkYgRsnv
 Yh1BAAWCgAdFiEEpfjIIRBRQHWN6WCSzDpk+q6ZrdIFAmr4WnUACgkQzDpk+q6ZrdKd7QEAnS/n
 Tvf0oEYT2d7RuRXM0y7CSHrEt4/Ftdw5hdsxTeEBANQK5pNe/GG7jazkeUc1sws7K6cVlWMPGxn
 kuMLVt3UD
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

A device bound through driver_override need not match an entry in
of_match_table. In that case device_get_match_data() returns NULL, but
rcar_canfd_probe() dereferences the result.

Reject devices without match data before continuing probe.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rcar/rcar_canfd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 000a6433f46d..9d463a9c1766 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -2113,6 +2113,8 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 	int i;
 
 	info = of_device_get_match_data(dev);
+	if (!info)
+		return -ENODEV;
 
 	if (of_property_read_bool(dev->of_node, "renesas,no-can-fd"))
 		fdmode = false;			/* Classical CAN only mode */

-- 
2.53.0

