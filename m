Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFEA377EBF;
	Thu, 15 Oct 2026 01:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792029231; cv=pass; b=tYLa5EVUjF9e0Y8ZnfCN6SteAsKRY7MpAe11WXogLkb6LjYoYwn2z6fX9aAY/4US2ZrI4t1B/PTEhPiHe/1dBegnBA7y4u3tlmqzblyEY06/MyBnBTN+0379/5LQSWEh6Hd3oO7HwXkVO5/pwju/cIW2qgkHxtTvIMo6J+c7qeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792029231; c=relaxed/simple;
	bh=QDA22K5MHvsxu3CEFiNsEX12Eu7hlcDqJ/tm5qtqfvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j4PFzmxuNl68Cp6PnIJwNozf2aKaO1zQRn3bR3jXIa92Yf/GNDW5ksq1NJzFvb8LWyfTskWbrzzH2cdXlrzl4Kay7xouV6lkgJdYOtPGsswMuCOeddAg8HkkHIbBOWjdtn8BNJiRDJ/jK3Qe3ZAX7mJjfHVMg6WAJEMS0II57D4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=Pz8bGiV4; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="Pz8bGiV4"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id ABA7B2027D8;
	Thu, 15 Oct 2026 03:53:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792029220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HeKQzPg/aVpLDedaTA7bbIaAs6J6oT+5PKGC9Pd/Vlg=;
	b=Pz8bGiV4Bu6hXCVfVHgq2VhLev+BL/V7GMT/DmZ+XA9BaxW5jftvQngVYlXSMxtr/FqebJ
	zrFw1DAzfYH5VT+UP+d3NJDnoLQSJV3I8Qnyv5fyr5O61JQQc+Osc1raJMGyCtylsTfMbc
	3by7e/2YxAkP3fSajHcGW0C9+36z+Dl/pXXlzLFZPY/O51/6VlaLUImlP1jw45Enga/mG4
	L3ZNfQRHhJPPZnaGbJh+MPNkythwX3DUE0Fnto/phrcYg8oYW3QHbu/dSJ4eZkOBGWb/Wv
	TSn+n7sqeAV9zEjWhhT7LVQdkEwMFWhr5ZsMQrd/ydoZY9xW6WrNJAAml7eejw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792029220; a=rsa-sha256;
	cv=none;
	b=N18+IcoZKx+FzZqVfnbMJZ8E4r7Go7RnZCWRPvpCYQIWeeq6UEKVI4dvNF8CAz7CmWgv3h
	lXB3mFwBPz3ddBzVXQP/XNZWpN69wYZdUvhfrG9/GnzPpj5WSL31mI4rIu8z+Ehu+Hkp6C
	hpK+ONoiMZm9IR3LgPd9K4tr4l0X849v1REifbSmsgGzPXnDF+vAKPUZ525fuLptMkXof7
	51c9NHmhu7FY89Lgr4gABSILc4jYwgrLgwH+e0kQJEUOpz1nA64lnMGJZB+7+AA0h5KPW+
	dJQC+bo4+pT1+Wr8ql1ffavTBEL9W5+c8E9i8KKgy5SURv3vFZyOfS0dHvwB0A==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792029220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HeKQzPg/aVpLDedaTA7bbIaAs6J6oT+5PKGC9Pd/Vlg=;
	b=QUG+hvqKlYqdTb1wqjomeOXWT3NOyWYQb+cT/Mg9jpzJsJc1D7XwKRKBsHOWLr2EBS4dKl
	5Eb5icdqyhATW7llP5AnI4NSDdSAlEWKlgrZlMf/pYOsO8riZIWAVFZSF1k/ik7RB1+oOu
	TC0V+VnLoEQUJ6uJydXk13ytjCSRsjuy5Kwy98vtR0QxqweyWWGW99xG60fvo65ZUq7RDw
	jGMST6F+BZ2gJUeTdpKn23tHHoGYtxcRWJ2L6gt3RvN9MaG3Yx4/PXB3HBUeB0EUx4NAEl
	JBodUAilv7AF7OvM45W1Wz2cOKFmwBG6Mi3BgYu+Rpa9H7XCoYFQ/bG7wpsT7g==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xHAf6-005wqV-1u;
	Thu, 15 Oct 2026 03:53:40 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 586D25C4782;
	Thu, 15 Oct 2026 01:53:40 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 15/37] can: rcar_canfd: Allow the CAN FD clock to be sourced from fck
Date: Thu, 15 Oct 2026 03:40:13 +0200
Message-ID: <20261015015336.816543-16-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015015336.816543-1-mkl@pengutronix.de>
References: <20261015015336.816543-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
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

