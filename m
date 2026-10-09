Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31254DBD75;
	Fri,  9 Oct 2026 13:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553420; cv=pass; b=I1uIQDKFh1bAwGQsgcm2jJ8ZMd9YqZH/NPjPAK6AUUHiVZ0Tgz83eGp0Si8y9EiuZr0idmPESSee8HFttu02Eep+kjLTyVVA/3UEccWOpSGtgAjIfpl56NL3fqORJ4CYz6iIkYyv3AhNxME8NU7I3OvV58OrHl4TZapc+fNzcG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553420; c=relaxed/simple;
	bh=QDA22K5MHvsxu3CEFiNsEX12Eu7hlcDqJ/tm5qtqfvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JGFnZqOj3VTK3/27gWdOxBsCOoy5h09y2utTIgXoPiePZR9WgqkcCGAWVud8ileNXPE/Up7AioZgsTkElqnMtDyBdJYCEpOV075gEnXkjnAugpadug5FaKlhK8EWFdj8WAVznaOomAPxl385eF54nJPOTwdR3YSfkYUpaoxxgNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=NpT5h3MH; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="NpT5h3MH"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id C41F9202620;
	Fri, 09 Oct 2026 15:43:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791553414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HeKQzPg/aVpLDedaTA7bbIaAs6J6oT+5PKGC9Pd/Vlg=;
	b=NpT5h3MH9iIJmS1e+TmMZBOpdZzNiWn8Mqpp5hxemd1b8J/jslQVlNX1mCGyy+KLHkmLPv
	8fH6emnMDyF+BIjwCVq30/GCcZhSD8dglJg42HS0oGiwuk5Lk17nFDcCtNGsizw7Vm3h4A
	uGTc5z65nFLvZUeKDIbDTsUoo1+JhMLs4PPDNbDwSJp32TM1hUAZST/tvrLVCYFf7zuocF
	6ZvdEDuHyphniAnD34O+R71YXHojNDs0z1LVr74qJDZGyUlc9sxHOmgBpJaW2nvb+/MPs7
	Lt34LwjgZgZv4XefYVINiiQ+Cjo97ztvp2YfPz/hEP3nEK0SbM+RrORwNHGEKA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791553414; a=rsa-sha256;
	cv=none;
	b=gv6EgeSFz4N968vrTnTbZkwOdyrHK9ofbeSqlSJyZ9zOMfJmIg0TdEiKLrLyGcx1uK/ubm
	jwMElwMZ4sUmubsxCH5EwuGYdh9V9py3X+C5XMY+Nq5RELk8SxXseY0UicOiKXWcxrBabg
	pv/H1Rnh2c70cnf7L01qzJEiOv9BmZmGuuZ3emmaSEND4i/ee7nAQd6YmacUCPkC2ibquw
	wGSWP4e/uyk6DzLb6gqMs+lQaMBgqYL584AfVn+gQp3jZJATXBJ0/jWdC7Y8L7O3rurAPB
	JqzckKLz8q+X7mppUvsxFksW3KDzDHNwkEivbabBC3PYVNjKndCBF7NW7YyMnw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791553414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HeKQzPg/aVpLDedaTA7bbIaAs6J6oT+5PKGC9Pd/Vlg=;
	b=CrM9XrffMtG+5HB1EcklhN3wb/OC77rm+9IrabpcktAu1ptpJSD83WoIvfRcOZQD5pRVAh
	9SzNVVEmP9Wagrbmy86Vy6LbQ02JcDGSpCu27/fx/PTu47kWjA0Px8Q3b0TWb3GTREi0Cb
	6ClWgFSXxG4qZLeray6/BpCXB3m+kEp7Bq+jbmhj6c/91uXQeMBTKHfnQK/qh7KG2DHJTO
	UipJjSymHDfH4IrpSRm34c9aT51mOcqgESS1mhBQ1hSNf+R0L8Erp1rC/LPiTVbN0w/VZL
	H1SKrScn3PCbCZ3tm5cxDXendhTb0Ipumud5lXoEtklaZrfdMI93vkwfl85wcw==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xFAso-0053SC-2F;
	Fri, 09 Oct 2026 15:43:34 +0200
Received: from blackshift.org (90-182-211-1.rcp.o2.cz [90.182.211.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 3E1635BD8B0;
	Fri, 09 Oct 2026 13:43:34 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 11/37] can: rcar_canfd: Allow the CAN FD clock to be sourced from fck
Date: Fri,  9 Oct 2026 15:27:43 +0200
Message-ID: <20261009134323.64064-12-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009134323.64064-1-mkl@pengutronix.de>
References: <20261009134323.64064-1-mkl@pengutronix.de>
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

