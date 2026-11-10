Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794311480;
	b=UJXA9p57yi+tUp+xjHlyjSr5utXIZe95dBIWJvH+fo8fgmJMxkabPkrlFcJyzygLUla4
	 k606JTuiKHKKAWqDIjo38X/uImLH918cfbljRXyd67/77t7wkgd5N8rD2UrA/H+D5ybct
	 bGhhWZAcjDgx+gr1j/0H5J9Erq+jXyjhTXcMycst7zR1f4InhID7XMyXz8dhnrKAsoNmo
	 USgVV9M+G7f3BNYoLxvtMeBT45ouVucK+E1Xcx+c0DGvYPrGmCSvvWzqPGxzmrwqNYmsQ
	 vU9ZgVeRIUe5SI23UPzi02cQwTu1l2IqMryjtAnrrSJuqlG9XcEF2HryN3jaHvl8nQQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311480;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HeKQzPg/aVpLDedaTA7bbIaAs6J6oT+5PKGC9Pd/Vlg=;
	b=Yx6stf28rUkJQgkRXztqUxd5v42pLJbJvIEyFAi1FiahKWv/uhNHw6t4yLstvkqYdFrV
	 Bv2vgzwKCA4itMfhH06TFwkDYKsBZ8S59dBKCjAbu/HZ613m4/sAS7wywpw6b0JmfuM6J
	 NuFe9w1rRJ6VnEUjrLlmRHTQPp9oee1hgGdNsUL+BZ+WglBOBWdpBY0VQG1wH4NJnkKhB
	 vZuBMHNg+FmWuDAOw9sR69XlyZ5nt1a3eV0wktlFqlvFYRtatJfm5TKlW6M96DBiWaSJk
	 dp0yjmnhvT8e9NGvp4gx08jhg7VBfIw1RIxvPbmh5cvFwvFK2rYTo/DMDLF9+GzoqfA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b="bL/T0/yg";
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975C560A2616;
	Tue, 10 Nov 2026 11:51:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 975C560A2616
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=bL/T0/yg
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id C2426202334;
	Tue, 10 Nov 2026 12:51:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794311476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HeKQzPg/aVpLDedaTA7bbIaAs6J6oT+5PKGC9Pd/Vlg=;
	b=bL/T0/ygNbN2qoSp2eZVu43Kdz0e7DVpU3dkVY6v7yyrDo/9UeVLcjsh9bMi+s0GwE/ORQ
	4lWTQNRf0UI3yy0cV+yXj64ov5KrPDsmVKcIcyIaVjlgvS3+MPUf9Y9bIE7f9OrWjz0Oly
	RJB7K1ZqacopYTlnwDcIumkWiW31JMwkYENIaQk0IVhdkh3o+TaSmQI0ljYtPqgcjTAYv4
	5A67BV3geNROvvMmrEjS92oCpvtt0gQZ6+We+KOuYP3VnmSRBEkgcY+GO8eb/SANAYjPg4
	6sZ17cQccOtNoLraSy23fc5JX+oaSMMIugoCO0G4/zmxb+4h5lFmwFwKPI3xjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794311476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HeKQzPg/aVpLDedaTA7bbIaAs6J6oT+5PKGC9Pd/Vlg=;
	b=T4CyOjZdSFJU1WWbbXqZg3yN1MUc2ks3UkMvOXVF4zpSDRbR3ZcNPypx8cHkQh+AJAZvue
	jTxuOUMTFBh/o/H3VnRk5rY3rJJLsUK/o7Wx+2l7wYHLGS/GdrtcyntCUpKslhYY/mo0y5
	nBB9ebmh/ETlT0F5mUGNJab4c2pkf85t5Wj4GkdGAiNUi4KkVnxviysNz0r/x9O+m6rX7Z
	0iCGvy417lCWyzusoORr73TmJDB8QV2qOr9uQBLlrQ3j0JHjez+tqqtwnlM1zso74am9/c
	iRpQ9/0B8f9H+DDX0ODsOnHkHA/EsKg+JEnwt7MNLaThuA5jnAfrM1ToqGnJbQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794311476; a=rsa-sha256;
	cv=none;
	b=KP2nukajYB+3Q5hw67pMMH9Ic4mmcNKuktjEgrY2n/u2nbEzOW++lwvr7zwh1JqLtPp6kV
	EX/izrfWvdhS9ozkQ/gI1QdJoPTFO8zKBGj+1ZZrpVvuu5x+mA3l0MSiqF4wWTt28wfUzk
	+FYtVN4cVHA1pLGxe5hKvtGgDWCz3pfZ0Us+j/bMMk6jaXvYd9zYrhRo1NMu/hG1obYYD3
	WaHbg+xAds9zDBVrrNFVd39evhotT4VABWtif9z5Y26Js1HpW/x4xIDNXJFDJkvyysucDs
	hJnQZO5/YGt8Frli+FDNnBEZrwXc4rK1LoDD5L0ulnchdIut6jlJBwn/LsCX9Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xQkNg-003UEp-2H;
	Tue, 10 Nov 2026 12:51:16 +0100
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 6D1A85E688C;
	Tue, 10 Nov 2026 11:51:16 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 03/12] can: rcar_canfd: Allow the CAN FD clock to be sourced from fck
Date: Tue, 10 Nov 2026 12:41:26 +0100
Message-ID: <20261110115112.3807247-4-mkl@pengutronix.de>
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

On the Renesas RZ/G3S, the CAN FD clock can be sourced either from fck
(the peripheral clock) or from an external clock (can_clk). When fck is
used, it is divided internally by the CAN FD controller.

Adjust the existing canfd clock handling code to support the RZ/G3S CAN.

The existing struct rcar_canfd_hw_info instances were updated to address
the request in the Link discussion.

Link: https://lore.kernel.org/all/1d9719e3-10ff-4cd8-b729-55fea93c37ce@wanadoo.fr
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20260902141544.565763-4-claudiu.beznea+renesas@tuxon.dev
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rcar/rcar_canfd.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index b7c4fe3477ac..f9173774387f 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -444,6 +444,7 @@ struct rcar_canfd_hw_info {
 	unsigned ch_interface_mode:1;	/* Has channel interface mode */
 	unsigned shared_can_regs:1;	/* Has shared classical can registers */
 	unsigned external_clk:1;	/* Has external clock */
+	unsigned fcan_pclk:1;		/* Has fcan sourced from pclk. */
 };
 
 /* Channel priv data */
@@ -617,6 +618,7 @@ static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
 	.ch_interface_mode = 0,
 	.shared_can_regs = 0,
 	.external_clk = 1,
+	.fcan_pclk = 0,
 };
 
 static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
@@ -634,6 +636,7 @@ static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
 	.ch_interface_mode = 1,
 	.shared_can_regs = 1,
 	.external_clk = 1,
+	.fcan_pclk = 0,
 };
 
 static const struct rcar_canfd_hw_info rzg2l_hw_info = {
@@ -651,6 +654,7 @@ static const struct rcar_canfd_hw_info rzg2l_hw_info = {
 	.ch_interface_mode = 0,
 	.shared_can_regs = 0,
 	.external_clk = 1,
+	.fcan_pclk = 0,
 };
 
 static const struct rcar_canfd_hw_info r9a09g047_hw_info = {
@@ -668,6 +672,7 @@ static const struct rcar_canfd_hw_info r9a09g047_hw_info = {
 	.ch_interface_mode = 1,
 	.shared_can_regs = 1,
 	.external_clk = 0,
+	.fcan_pclk = 0,
 };
 
 static const struct rcar_canfd_hw_info r9a09g077_hw_info = {
@@ -685,6 +690,7 @@ static const struct rcar_canfd_hw_info r9a09g077_hw_info = {
 	.ch_interface_mode = 1,
 	.shared_can_regs = 1,
 	.external_clk = 1,
+	.fcan_pclk = 0,
 };
 
 /* Helper functions */
@@ -2190,13 +2196,20 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 	 */
 	gpriv->can_clk = devm_clk_get(dev, "can_clk");
 	if (IS_ERR(gpriv->can_clk) || (clk_get_rate(gpriv->can_clk) == 0)) {
-		gpriv->can_clk = devm_clk_get(dev, "canfd");
-		if (IS_ERR(gpriv->can_clk))
-			return dev_err_probe(dev, PTR_ERR(gpriv->can_clk),
-					     "cannot get canfd clock\n");
+		if (info->fcan_pclk) {
+			fcan_freq = clk_get_rate(gpriv->clkp);
+			gpriv->can_clk = NULL;
+		} else {
+			gpriv->can_clk = devm_clk_get(dev, "canfd");
+			if (IS_ERR(gpriv->can_clk))
+				return dev_err_probe(dev, PTR_ERR(gpriv->can_clk),
+						     "cannot get canfd clock\n");
+
+			fcan_freq = clk_get_rate(gpriv->can_clk);
+		}
 
 		/* CANFD clock may be further divided within the IP */
-		fcan_freq = clk_get_rate(gpriv->can_clk) / info->postdiv;
+		fcan_freq /= info->postdiv;
 	} else {
 		fcan_freq = clk_get_rate(gpriv->can_clk);
 		gpriv->extclk = gpriv->info->external_clk;
-- 
2.53.0

