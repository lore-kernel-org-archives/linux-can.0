Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794311485;
	b=ePbWI3wJGVMjuLrNp0bWSvzGkxXu/l0cfNq+sT2g4LF7vjvyKw353smVXLkGnH2ZtVjP
	 QKZETGpKMBCuC2IuZ7OQBdWa4BgjPvcz9PEma/Hcwmj4Sp4cIP40MGcSSi+/L9soH6DP2
	 loIefqNdipvLk6hamn/88X+4kdCWuvEWmiOdNwpvOqgMFhT6pMuDphMn7TyHgrDX1MOlI
	 nTi8duv0UyyNFzkxYJxIV8pPsYtp5h/Nbw/l9vgFNya/aZSnBkhiuOGNXW2/EgxzINCHa
	 nHyPRSbPqfRJ7lLQWJypo4VoLqirD/B5d3npPwq0yybd0bO2OQiK5kNIGODw1ntXTdQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311485;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Qaez37EA1h/9lfqEagfmOyBj6Ve0cRF79rSyLilJUEU=;
	b=SM2xC8g7qRRQAnoJU++oDjMJRiHjUjufC0U/iDo7Q+GWY3fT799oL6+pG66xzlk8Dgn/
	 IWpkB9Gmc2xRIhWTKe/5BIIZkwXwo2MgYSym5pcYWeB4cM5VJspTU6tfWW3xKYRfI8C/j
	 TawM0YZB4f2YFdzPxiWbqf5kZOgW6IpfgufO04UGM/Ds6pjQZjEms6owLAsAIvZutDAV6
	 NXzd6kWwCr2uPrifWjA1YnDZuPUrx4XMbhGNmXxLSSOtMpOy8NPU8LIjLEOql7AMvVspp
	 s88zSxkTaz3DKu66SsnWHztezLODOkQtSJ+2TbdM/iIkWrg/Tj9ox4c1+CQPACKCCWA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=cqCZszJK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55A760A383D;
	Tue, 10 Nov 2026 11:51:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E55A760A383D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=cqCZszJK
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 63E3A20296B;
	Tue, 10 Nov 2026 12:51:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794311477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qaez37EA1h/9lfqEagfmOyBj6Ve0cRF79rSyLilJUEU=;
	b=cqCZszJKx3yhn8/bkqmzhsysCJ7ouxWAq0YeO1j6kVtlak6fDsZjEc9NdcP50TSZyeUBxj
	FV8xfG7x85V08pRxDAzYhUcZKJlm2e7Pvob3IcyF25A00J5TPjB6NU89GmoQUz7e9GseC5
	sEDwgNIh6lvmW5dCmRG/f/x1+3OwdEipNe/3MtYPN8PFmDK/cDkE0zlc5lL2+E2jy58/7P
	u5Pu9cJAdkF+0JNmytZi58PdeooXxV6UkxWjNv9uCm28KcjyTev0w7Oz7D7WHM1w3XqNiy
	nqRr2qC5+J73bS0k8U/ZldOQICHxDQKoNurnHB1ScS5dEJYuHY2a+vsyfBS6iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794311477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qaez37EA1h/9lfqEagfmOyBj6Ve0cRF79rSyLilJUEU=;
	b=dJVDxNYlkr4lcGTXpt560tFpFQWgyu1lo5wO+9R8/gFVwOrcTJf2BZkKSg+PUhACZ/xH+Y
	9f4ESwkxCJfNnMjqo9xE4Va2UXB/5ZzkfmbSGOS5NtIk5OeQ7g9wRr2r1TcB+rA2T4O/dG
	lGNm41ovPM0ZWDXA9zF93cc1xE9BEas7RCDxcPhz5U5tyMHTFnloD0SJQ2HWXk6z1vz7uU
	QBNymX735Ldt+QM6/vYKY05uxMggPgCqb6PAfs1EzjrqCSEBkKSlAw8S7Pjalxp+cZ9FNG
	mGfz/IsDElFx6k+Vg5Jra0aI4smONL+PyvDR3x4wtFNah86bOaLtZMRX7TgjMw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794311477; a=rsa-sha256;
	cv=none;
	b=LADLlr20of8D3iwSMgFo/hyOru7G4okDuHVeYZoZ0MNycQZ4zO/XkTrTflrqB2Cyujrrnk
	2hz8tvsxkrE9N8n0VAn3ZFdsVVh29z0jmsshPcwKMhJqce98gV/5Yn08t20RMGPwh1OZys
	ofNbxw3nmdK6nXVXk0q4gOqwyrQSs9NIq6jO065OrjspzgwSYlHY1JJiMAowPRSyKUGf03
	DPcvN9nj0m5EDg6f7H7zTDEkR/YXSul4c+1TbCaTwxqczoBNKlxHuMQB3yqznsbV4WlAva
	KHthH9YGQpK+/3X58NX80xOiqhNk06pDpi4T0lrjT4+zPIn5HfWbOAHw8sChnQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xQkNh-003UFJ-11;
	Tue, 10 Nov 2026 12:51:17 +0100
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 1443E5E6895;
	Tue, 10 Nov 2026 11:51:17 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Biju Das <biju.das.au@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 12/12] can: rcar_canfd: Add support for Renesas RZ/G3L
Date: Tue, 10 Nov 2026 12:41:35 +0100
Message-ID: <20261110115112.3807247-13-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110115112.3807247-1-mkl@pengutronix.de>
References: <20261110115112.3807247-1-mkl@pengutronix.de>
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.au@gmail.com>

Add support for Renesas RZ/G3L CANFD IP. RZ/G3L has 3 channels and
11 interrupts, compared 2 channels and 8 interrupts on RZ/G3S.
RZ/G3L has 288 buffers compared to 192 buffers on RZ/G3S.

Like RZ/G3S, the controller supports only CAN-FD mode and update
the comments to note that Classical CAN mode is not available on
RZ/G3L either.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20261021-canfd_rzg3l-v6-4-b4abfdba8e70@bp.renesas.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rcar/rcar_canfd.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 072987316cc7..7333ee98aa92 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -6,7 +6,7 @@
 
 /* The R-Car CAN FD controller can operate in either one of the below two modes
  *  - CAN FD only mode
- *  - Classical CAN (CAN 2.0) only mode (Except RZ/G3S)
+ *  - Classical CAN (CAN 2.0) only mode (Except RZ/G3{L,S})
  *
  * This driver puts the controller in CAN FD only mode by default. In this
  * mode, the controller acts as a CAN FD node that can also interoperate with
@@ -247,10 +247,10 @@
 #define RCANFD_CFFDCSTS_CFBRS		BIT(1)
 #define RCANFD_CFFDCSTS_CFESI		BIT(0)
 
-/* This controller supports either Classical CAN only mode(Except RZ/G3S) or
- * CAN FD only mode. These modes are supported in two separate set of register
- * maps & names. However, some of the register offsets are common for both
- * modes. Those offsets are listed below as Common registers.
+/* This controller supports either Classical CAN only mode(Except RZ/G3{L,S})
+ * or CAN FD only mode. These modes are supported in two separate set of
+ * register maps & names. However, some of the register offsets are common for
+ * both modes. Those offsets are listed below as Common registers.
  *
  * The CAN FD only mode specific registers & Classical CAN only mode specific
  * registers are listed separately. Their register names starts with
@@ -681,6 +681,26 @@ static const struct rcar_canfd_hw_info r9a08g045_hw_info = {
 	.fixed_canfd = 1,
 };
 
+static const struct rcar_canfd_hw_info r9a08g046_hw_info = {
+	.nom_bittiming = &rcar_canfd_gen4_nom_bittiming_const,
+	.data_bittiming = &rcar_canfd_gen4_data_bittiming_const,
+	.tdc_const = &rcar_canfd_gen4_tdc_const,
+	.regs = &rcar_gen4_regs,
+	.sh = &rcar_gen4_shift_data,
+	.rnc_field_width = 16,
+	.max_aflpn = 15,
+	.max_cftml = 31,
+	.max_channels = 3,
+	.postdiv = 2,
+	.shared_global_irqs = 0,
+	.multi_channel_irqs = 1,
+	.ch_interface_mode = 1,
+	.shared_can_regs = 1,
+	.external_clk = 1,
+	.fcan_pclk = 1,
+	.fixed_canfd = 1,
+};
+
 static const struct rcar_canfd_hw_info r9a09g047_hw_info = {
 	.nom_bittiming = &rcar_canfd_gen4_nom_bittiming_const,
 	.data_bittiming = &rcar_canfd_gen4_data_bittiming_const,
@@ -2407,6 +2427,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(rcar_canfd_pm_ops, rcar_canfd_suspend,
 static const __maybe_unused struct of_device_id rcar_canfd_of_table[] = {
 	{ .compatible = "renesas,r8a779a0-canfd", .data = &rcar_gen4_hw_info },
 	{ .compatible = "renesas,r9a08g045-canfd", .data = &r9a08g045_hw_info },
+	{ .compatible = "renesas,r9a08g046-canfd", .data = &r9a08g046_hw_info },
 	{ .compatible = "renesas,r9a09g047-canfd", .data = &r9a09g047_hw_info },
 	{ .compatible = "renesas,r9a09g077-canfd", .data = &r9a09g077_hw_info },
 	{ .compatible = "renesas,rcar-gen3-canfd", .data = &rcar_gen3_hw_info },
-- 
2.53.0

