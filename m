Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794311480;
	b=P3DxU+HygPKfIWeH+ppWDKVPLddCc/1LR6xqdUCVnabrQLkoq6hCnVUu0s7ftFGD81Xv
	 OKfhpk9LefwJYklvOzaZfzVD+tEPNDoUztop8YYgCyAnNf7MZSz1RJYRtWjJFCY6Caov0
	 zQ2AK3c6c2Xigv99H5QaGZ/NzptE5svMx10k7sjYJX2eBRFdAj3CBRiq6WrLywBn4mB4C
	 sKKwuFk7SvzjIOJkRE/daw+oFSmzCf3AO/wPdLGWT6KyZoiQzpR5C7TKa1GpcmtBzsfKr
	 GikYL8sWKpIPa/KbcZiVc+yAntfkTSHartGW46jX1J7ujtEYezMAi2TI2naoIKLC3zA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311480;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Hmb8mrgH5Akez/V29LYYKKc2sJv193Jb9sw338t88Jc=;
	b=BZzeQ88UzM8j+c+HeCv8nQpjFJroWFANva2nd5vRSGNxM8MMRbFPV+27JqVCTX5ZlLBa
	 4SG9E9GbuD2dHnE0VT+XO6J9T4bhwqL3GlrfzJdtMlAeHtCdutV9TfyV4jfRSyQSi8eF1
	 j2JOPjQSfKIziuGhpWqU3mfuQ+U/fDnYXVO45LxvE/40zUq5te26eSGAwNyT1FfZy9VCE
	 +71i//nVOo8WLLChq10nfkAQyDgvMU8iwmCmeyh7Vwlchqa45/L1ErcaQzCVA0ZVNiPOv
	 qDmLHqhIzqml9606dRq5MRPqFM1zSXkchktybG/Q3hf8DXF0bSNo38lCgLyiisdtD5w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=gGNNHtBq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A326060A261E;
	Tue, 10 Nov 2026 11:51:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A326060A261E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=gGNNHtBq
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 16361202335;
	Tue, 10 Nov 2026 12:51:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794311477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hmb8mrgH5Akez/V29LYYKKc2sJv193Jb9sw338t88Jc=;
	b=gGNNHtBqi8fp+DOEtFSEzmIYgQvJFz4UZ/0y21ag9xCfGQkSfvjzjmv6VBx/RjrMBh9oZv
	o/IdbZiKRTjwD+nDIzkLb2PnGFWTePcYpLOwryXzro//XldSC5kHBhE0IGdqHVaNo7YyH9
	zfxBSslt1gsgfa6C+ERm37j2d+HHYYDDWw4OwCjGb7iyUs5JJTESEh01L626cQNbezMfsz
	KPtG9STQC+cezGhqltOSY3eSTj3b1PtiCQG+h0Gu67iD3jJQANE4Co2iXignBU0l2UDZdm
	UcshkGrnEEqxOh76E6tlu0lvEQA32akQ62N0OuGaZ0LMUAZ8z3htP9jiN599ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794311477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hmb8mrgH5Akez/V29LYYKKc2sJv193Jb9sw338t88Jc=;
	b=QlR36pYQp/bNugK2D/OV3k7CIV4LaSUOIXH3UKZN9dssw6h/c5xwoA52jPZDjJViC0jSJd
	fihLKpq3agocKcTI40f95JrpPYp8AunZlciSf8OPTNf/XDD1FuAlgDoowA0BsTTvrD9J/c
	6W3M1qRQjm8qnqIMbK9T2sFzwrkC+dKUsfuK2F0zRcxK/2P8vQiNTtNTHXbEqNIvdpn5+W
	6xN4U9912DLtUMO0c6ko0ZTBTRZ8llAbx6ych+wtsOmPv78CiBgq4B+Q+EU62olfXmvdo3
	jlq4gYt6By29l4NZ7mt82zGnkhB+5yoV8eKJyc66OnbLkzUbwUYb85+arLs5Ew==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794311477; a=rsa-sha256;
	cv=none;
	b=SAX5RsVDibcaB23bH6U6PfbPNF/86eIiyl2XBnZLv8TwZJCF3FYy8+gJ3dVXqNdCWJL9SL
	jxm2H+6EXbjHjjkOZTIv2FZ8w3Kl2KRkNTzNVkP1l1/AE68CRexAduQ3g4KX21MpRdM+zc
	imZsb8hU3VWBvkpIX+Q6iPZfBb8i2Y5vnAn0Hmn/dg1QpGx3N6YezFOsM369GKRExSMzYn
	io38J0m04u49ikn0UV3dDie/wGjgtu6kyWzk//k+3J/xfxDYKTQeR+ZV17zvvF7k5ghFEu
	gWZ1AaCw+Uy5QtZfPHVQCbX7GRZQNwia5ZXxH6KhjqALgVLWis5m/iiWO0Haqw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xQkNg-003UEr-37;
	Tue, 10 Nov 2026 12:51:16 +0100
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 7871F5E688D;
	Tue, 10 Nov 2026 11:51:16 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 04/12] can: rcar_canfd: Do not set registers selecting the CAN mode
Date: Tue, 10 Nov 2026 12:41:27 +0100
Message-ID: <20261110115112.3807247-5-mkl@pengutronix.de>
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

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The bits 30 (classical CAN-only mode) and 28 (FD-only enable) of the
Channel n CAN-FD Configuration Register of the Renesas RZ/G3S SoC are not
available. The IP supports only CAN-FD mode. RZ/G3S HW manual (revision
1.30) specify the bits are read as zero and the write value should always
be zero.

Add the fixed_canfd flag in struct rcar_canfd_hw_info to cover RZ/G3S
and avoid writing to unavailable bits.

The existing struct rcar_canfd_hw_info instances were updated to address
the request in the Link discussion.

Commit prepares for the addition of the Renesas RZ/G3S SoC.

Link: https://lore.kernel.org/all/1d9719e3-10ff-4cd8-b729-55fea93c37ce@wanadoo.fr
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20260902141544.565763-5-claudiu.beznea+renesas@tuxon.dev
[mkl: update flag name in patch description]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rcar/rcar_canfd.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index f9173774387f..ac5d5959d8e4 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -445,6 +445,7 @@ struct rcar_canfd_hw_info {
 	unsigned shared_can_regs:1;	/* Has shared classical can registers */
 	unsigned external_clk:1;	/* Has external clock */
 	unsigned fcan_pclk:1;		/* Has fcan sourced from pclk. */
+	unsigned fixed_canfd:1;		/* Has mode fixed to canfd. */
 };
 
 /* Channel priv data */
@@ -619,6 +620,7 @@ static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
 	.shared_can_regs = 0,
 	.external_clk = 1,
 	.fcan_pclk = 0,
+	.fixed_canfd = 0,
 };
 
 static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
@@ -637,6 +639,7 @@ static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
 	.shared_can_regs = 1,
 	.external_clk = 1,
 	.fcan_pclk = 0,
+	.fixed_canfd = 0,
 };
 
 static const struct rcar_canfd_hw_info rzg2l_hw_info = {
@@ -655,6 +658,7 @@ static const struct rcar_canfd_hw_info rzg2l_hw_info = {
 	.shared_can_regs = 0,
 	.external_clk = 1,
 	.fcan_pclk = 0,
+	.fixed_canfd = 0,
 };
 
 static const struct rcar_canfd_hw_info r9a09g047_hw_info = {
@@ -673,6 +677,7 @@ static const struct rcar_canfd_hw_info r9a09g047_hw_info = {
 	.shared_can_regs = 1,
 	.external_clk = 0,
 	.fcan_pclk = 0,
+	.fixed_canfd = 0,
 };
 
 static const struct rcar_canfd_hw_info r9a09g077_hw_info = {
@@ -691,6 +696,7 @@ static const struct rcar_canfd_hw_info r9a09g077_hw_info = {
 	.shared_can_regs = 1,
 	.external_clk = 1,
 	.fcan_pclk = 0,
+	.fixed_canfd = 0,
 };
 
 /* Helper functions */
@@ -846,6 +852,9 @@ static int rcar_canfd_reset_controller(struct rcar_canfd_global *gpriv)
 		}
 
 		/* Set the controller into appropriate mode */
+		if (gpriv->info->fixed_canfd)
+			continue;
+
 		if (gpriv->info->ch_interface_mode) {
 			/* Do not set CLOE and FDOE simultaneously */
 			if (!gpriv->fdmode) {
-- 
2.53.0

