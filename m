Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EA34E3ED9;
	Fri,  9 Oct 2026 13:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553423; cv=pass; b=rvdsg+Yc8yfcZo5lGkdtzw9nXUWGoB3a7f9BlmHKQRWqxy5RHhoe2q6YXh+uT1tw8tDyKnWcM0w2zeRlqNCjXrI6tjzRdXaZKJXS8WqeKNSJHgSuSNf+x0Vs+2RlfHp7sgOmPs3Wbcymqu/4BL3EwE/VdoV6S6G73gkuUMOEba8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553423; c=relaxed/simple;
	bh=L4b77WGngEL/FWpF9iRAHfE9+k/sNz06Qmqdpp6bneI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kkczvhEcDfnJnBXxp/FBHaqYgl0dmeFcw2+p+3DEs/HOcES6+sohLnPQ3zpN4X0E47LmYI2phKFWc6ZVNAPi+MKeEe/FjpXfXMRiz2d4X7aj/EP6xoau9itsqGzAyH90RupObyij599a+FGadTiVPKaNoN7C+65DNBAk3ZIXniM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=RMG+7Tcb; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="RMG+7Tcb"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id EC33C202622;
	Fri, 09 Oct 2026 15:43:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791553415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d4HNy9wJpg90Hhz9sk2AWur8gvwMQKYnAUoHhj+Xys8=;
	b=RMG+7TcbWZsIt8n9tV0S+tcdJl9NQ1ZpHi5g2oj44rZtTdEVuWJsftv28dR+ytGSrsQLNH
	FRQWat7IbQSbwb6AqeTtRuzKUWzxfEk6LSOn4Ls6XPg6cQQDFtLbiqWfCJmGHs5zLUR2UA
	BNHigozj84AnucVmHI5uNU5bA3pwpBPaXoyYiIXy9In/5BQRXD6oCp1B9upJxWvZn4GdxJ
	odzJxvyq0Tb9PpeyssVAOp+jPXBmF7rXw4r9hns/urJEwQvmfoaKydTz4EDAoizGbhy6/1
	7+BoekaE1kJJvmwpk9SznRfqVWX+mYBaUILyiR4TCcBujmYrcZsGkKyr+nVWhA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791553415; a=rsa-sha256;
	cv=none;
	b=Dpupu6ldRV6k73k01723Tf5BG93xkvIyya4ETAwXk/jwCn2h6xrKX25zPGEERcSpC64Ktv
	d6UvWrOnQu66QlHAtpo25spAyNmh6iziPFc7yDJl9uPfpeZZgc8FiQDkLUnu73YuCL31cv
	Wm5gvstcB4VSmq8hWtxj083VmAAV4kf6i1xyvOlsGUgbWaH/Gy18yqC2FYSFrAGnqF6XeJ
	FMvt9SPiKyGa5afM3SVx4XZ1/dFEgFFy6ZI+wtpYGDZJ3aSBhMyH7V/EMxMSUAB4ECF17I
	HMgDhSyQOrO1rgX0vjsoKiEjXSc8gws33JL9YAnzpwaqfJmm6Q+3bmat1koF8A==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791553415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d4HNy9wJpg90Hhz9sk2AWur8gvwMQKYnAUoHhj+Xys8=;
	b=czu5rY/gysdPHVMZYNH7GPx9c4xl83QtQ85x+iDq+H1/264KfWWx/HYAIW+adfoJWKdePi
	1TNi8xVhl6GybmuQIZlEsEesoi+O7GMxli7jaAZd5Z6o+zOXQqwGttsABrQHLBAuCfX9Dc
	PaHCzaLY5LT/2YnbQn1eniN23NRn1gGrFIzVvtd/Q9ncamYwiY3+IG03mYQhNvM8TFQROu
	CeG128dBWdmXeVb7L7fQZzEOlsqaJjaMr6xkKj52wHp87J8sbJDNAKAK1A6DQpxWHL4Wgk
	lkZBiEgFlUc/dXxq3iQXEK+yKlcopx4t2iN2eav6E86Tg/OdCD3o5Gie+3kpuQ==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xFAsp-0053SS-2l;
	Fri, 09 Oct 2026 15:43:35 +0200
Received: from blackshift.org (90-182-211-1.rcp.o2.cz [90.182.211.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 6BA9E5BD8BB;
	Fri, 09 Oct 2026 13:43:35 +0000 (UTC)
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
Subject: [PATCH net-next 15/37] can: rcar_canfd: Add support for Renesas RZ/G3S
Date: Fri,  9 Oct 2026 15:27:47 +0200
Message-ID: <20261009134323.64064-16-mkl@pengutronix.de>
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

Add support for Renesas RZ/G3S

The Renesas RZ/G3S CAN-FD controller is largely compatible with the
variant found on the Renesas RZ/G3E. The main differences are:
- the RZ/G3S provides 16 AFL pages
- the RZ/G3S supports only two channels
- the RZ/G3S supports only CAN-FD operation and does not implement the
  bits used to select between classical CAN-only and CAN FD-only modes.
- the RZ/G3S includes an internal divider that allows the peripheral
  clock to be used as the CAN FD clock source.

Add support for the Renesas RZ/G3S.

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20260902141544.565763-6-claudiu.beznea+renesas@tuxon.dev
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rcar/rcar_canfd.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index ac5d5959d8e4..74c3c3f20991 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -661,6 +661,26 @@ static const struct rcar_canfd_hw_info rzg2l_hw_info = {
 	.fixed_canfd = 0,
 };
 
+static const struct rcar_canfd_hw_info r9a08g045_hw_info = {
+	.nom_bittiming = &rcar_canfd_gen4_nom_bittiming_const,
+	.data_bittiming = &rcar_canfd_gen4_data_bittiming_const,
+	.tdc_const = &rcar_canfd_gen4_tdc_const,
+	.regs = &rcar_gen4_regs,
+	.sh = &rcar_gen4_shift_data,
+	.rnc_field_width = 16,
+	.max_aflpn = 15,
+	.max_cftml = 31,
+	.max_channels = 2,
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
@@ -2383,6 +2403,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(rcar_canfd_pm_ops, rcar_canfd_suspend,
 
 static const __maybe_unused struct of_device_id rcar_canfd_of_table[] = {
 	{ .compatible = "renesas,r8a779a0-canfd", .data = &rcar_gen4_hw_info },
+	{ .compatible = "renesas,r9a08g045-canfd", .data = &r9a08g045_hw_info },
 	{ .compatible = "renesas,r9a09g047-canfd", .data = &r9a09g047_hw_info },
 	{ .compatible = "renesas,r9a09g077-canfd", .data = &r9a09g077_hw_info },
 	{ .compatible = "renesas,rcar-gen3-canfd", .data = &rcar_gen3_hw_info },
-- 
2.53.0

