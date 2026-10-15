Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C413839BD;
	Thu, 15 Oct 2026 01:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792029231; cv=pass; b=PEkMw5G0QSS/fkblQEaIZtHrvRLt4yLjKPI1Vp/Pqc13vyVFh7kvhdUH4L8d7vQnoJsy13v4p4FGYqRuL6mPY+3AKJ2k8jmHZ8CEm4moc0t/Mqs4JfrK9L0mruWmso7aPWhx0FbCgUU1jfQiINnVlW8CJqBs6+WxBamoeTb2F80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792029231; c=relaxed/simple;
	bh=zo1NA1nvn4M+xvhuS8yWLWtNX/gO9UWlZoWoaWC/PVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FG2WYF9TsCtvIdbeSRIB20MQpThAtW/zlBpeSwZQesiamsAGZqiyLYzkZNyO83/n3rxhcT740WrA1d29bs6gtohrkf2zS3ptj5qDak08HRHKEeASF0WRqhCM0QU1iBRulrqIwW6MiD4ti48uwHY22fhV9A/73h46JU4R5cshjgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=VMfYCTxV; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="VMfYCTxV"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 53E812027DF;
	Thu, 15 Oct 2026 03:53:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792029221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u37pV0NcI1X3RF1Tg1EqbEjSY6Bl7bPlmaLvLyV2u3I=;
	b=VMfYCTxVOe83O0yiBikxgc8u5uPoGobuDmumtkUqoxDVQHrT201NzENtnhbwIaLLoHbppU
	rbjEju4469o8gVQxRWTgPl/eFhPMtMf/fKob/eNrD9tC626mvuTAZyyjwVOWuoUHI+nxSJ
	VKsD2xTh5DbE+SGrlT22TbwJsjMh2xH7ESHBSBS+CzJmbt8PQhw8G7CPo/azxPVG/z6fnY
	5dEfXOjLsKNrTHI1ZoIuIRCgWya6V2qI04tqZgcnuzfLKWXax3LstzN3XQ01DZn4IKZhrO
	QfktudjurUo0/KAH0okJ8pldoWTS7YlVBbE86PeHky2z6PXnw2Y1KXCKl9etmw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792029221; a=rsa-sha256;
	cv=none;
	b=JiXI1HnTktzGcj+nkCx9wWR5a0k8Iff18p9AmOwNoUP/jXBtQmw4R6JUb5bjr78+ReJ9kt
	NGuGNKkZ+tBG8uwcjtIaxKC1R76ZwQd1NyU4YUeZpCBFD5Pk/kw6p69Su1l2ubnYhv7T+8
	UPj4lt1z8+bjzgFz8DY6y1b/2j+lDb8K+cZ80bSWXrPHf7ZIgi4bAQ76OoRNmf5vRahemL
	LvEEephiEWQFhqGXuHOWqR+kicgJJhLbCf/W0I/BuPxeJNkCCj25JeQMe2cNPkOOrA3JWT
	5f+OaaGBEH+cIN6Zozo+VY+mJPolUpoOhA7wObTMRZYliUC5n1bg76TNhLtRMQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792029221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u37pV0NcI1X3RF1Tg1EqbEjSY6Bl7bPlmaLvLyV2u3I=;
	b=ZJc/xTKjPF1Mx0QnkFLxb01lb6Nnj8UeJgem/OJfxgWSVU1cKml+Ki15n45tABANyDIWUb
	uxtjDPeJy/rynrKt6DGhhKbFx0wnsDXzcrG5KAGLGwWfdKdBizIp9aFtjfwWpCraA3fBBY
	HKBnOZlEEae3G+NzCTfFZ5WMTI9FBjT/9Me46zIILNC50QC9sEiivuh2esTLxdeKgH1Le0
	NZoIyqh+eerPfj6TNav0sW/h8a/b7rDLKeu6cpoGjMs+axDJtTWFXj3p7lnjkpZi1GbfJH
	mOGggpd3ex4WWcSDAer4nhvwH41dTksHTTCkaL6f3xdS6yKF4KWZV8kblU/Nxg==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xHAf7-005wqw-0i;
	Thu, 15 Oct 2026 03:53:41 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id F02F85C478B;
	Thu, 15 Oct 2026 01:53:40 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 20/37] can: rcar_canfd: Derive max_channels from the device tree
Date: Thu, 15 Oct 2026 03:40:18 +0200
Message-ID: <20261015015336.816543-21-mkl@pengutronix.de>
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

From: Biju Das <biju.das.jz@bp.renesas.com>

The maximum number of channels is currently hardcoded per SoC in
struct rcar_canfd_hw_info. Since the DT describes the channels as
child nodes of the controller, the count can be obtained at probe time
with of_get_child_count() instead.

Drop max_channels from struct rcar_canfd_hw_info and store the value
in struct rcar_canfd_global, so it no longer needs to be maintained
for each SoC variant. Update all for_each_set_bit() users over
channels_mask to use gpriv->max_channels.

No functional change.

Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20261001075742.21961-3-biju.das.jz@bp.renesas.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rcar/rcar_canfd.c | 39 +++++++++++++++----------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 74c3c3f20991..41c395118949 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -436,7 +436,6 @@ struct rcar_canfd_hw_info {
 	u8 rnc_field_width;
 	u8 max_aflpn;
 	u8 max_cftml;
-	u8 max_channels;
 	u8 postdiv;
 	/* hardware features */
 	unsigned shared_global_irqs:1;	/* Has shared global irqs */
@@ -478,6 +477,7 @@ struct rcar_canfd_global {
 	struct reset_control *rstc1;
 	struct reset_control *rstc2;
 	const struct rcar_canfd_hw_info *info;
+	u8 max_channels;
 };
 
 /* CAN FD mode nominal rate constants */
@@ -613,7 +613,6 @@ static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
 	.rnc_field_width = 8,
 	.max_aflpn = 31,
 	.max_cftml = 15,
-	.max_channels = 2,
 	.postdiv = 2,
 	.shared_global_irqs = 1,
 	.ch_interface_mode = 0,
@@ -632,7 +631,6 @@ static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
 	.rnc_field_width = 16,
 	.max_aflpn = 127,
 	.max_cftml = 31,
-	.max_channels = 8,
 	.postdiv = 2,
 	.shared_global_irqs = 1,
 	.ch_interface_mode = 1,
@@ -651,7 +649,6 @@ static const struct rcar_canfd_hw_info rzg2l_hw_info = {
 	.rnc_field_width = 8,
 	.max_aflpn = 31,
 	.max_cftml = 15,
-	.max_channels = 2,
 	.postdiv = 1,
 	.multi_channel_irqs = 1,
 	.ch_interface_mode = 0,
@@ -670,7 +667,6 @@ static const struct rcar_canfd_hw_info r9a08g045_hw_info = {
 	.rnc_field_width = 16,
 	.max_aflpn = 15,
 	.max_cftml = 31,
-	.max_channels = 2,
 	.postdiv = 2,
 	.shared_global_irqs = 0,
 	.multi_channel_irqs = 1,
@@ -690,7 +686,6 @@ static const struct rcar_canfd_hw_info r9a09g047_hw_info = {
 	.rnc_field_width = 16,
 	.max_aflpn = 63,
 	.max_cftml = 31,
-	.max_channels = 6,
 	.postdiv = 1,
 	.multi_channel_irqs = 1,
 	.ch_interface_mode = 1,
@@ -709,7 +704,6 @@ static const struct rcar_canfd_hw_info r9a09g077_hw_info = {
 	.rnc_field_width = 16,
 	.max_aflpn = 15,
 	.max_cftml = 31,
-	.max_channels = 2,
 	.postdiv = 1,
 	.multi_channel_irqs = 1,
 	.ch_interface_mode = 1,
@@ -854,7 +848,7 @@ static int rcar_canfd_reset_controller(struct rcar_canfd_global *gpriv)
 	}
 
 	/* Transition all Channels to reset mode */
-	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->info->max_channels) {
+	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->max_channels) {
 		rcar_canfd_clear_bit(gpriv->base,
 				     RCANFD_CCTR(ch), RCANFD_CCTR_CSLPR);
 
@@ -922,7 +916,7 @@ static void rcar_canfd_configure_controller(struct rcar_canfd_global *gpriv)
 	rcar_canfd_set_bit(gpriv->base, RCANFD_GCFG, cfg);
 
 	/* Channel configuration settings */
-	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->info->max_channels) {
+	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->max_channels) {
 		rcar_canfd_set_bit(gpriv->base, RCANFD_CCTR(ch),
 				   RCANFD_CCTR_ERRD);
 		rcar_canfd_update_bit(gpriv->base, RCANFD_CCTR(ch),
@@ -1293,7 +1287,7 @@ static irqreturn_t rcar_canfd_global_err_interrupt(int irq, void *dev_id)
 	struct rcar_canfd_global *gpriv = dev_id;
 	u32 ch;
 
-	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->info->max_channels)
+	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->max_channels)
 		rcar_canfd_handle_global_err(gpriv, ch);
 
 	return IRQ_HANDLED;
@@ -1325,7 +1319,7 @@ static irqreturn_t rcar_canfd_global_receive_fifo_interrupt(int irq, void *dev_i
 	struct rcar_canfd_global *gpriv = dev_id;
 	u32 ch;
 
-	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->info->max_channels)
+	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->max_channels)
 		rcar_canfd_handle_global_receive(gpriv, ch);
 
 	return IRQ_HANDLED;
@@ -1339,7 +1333,7 @@ static irqreturn_t rcar_canfd_global_interrupt(int irq, void *dev_id)
 	/* Global error interrupts still indicate a condition specific
 	 * to a channel. RxFIFO interrupt is a global interrupt.
 	 */
-	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->info->max_channels) {
+	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->max_channels) {
 		rcar_canfd_handle_global_err(gpriv, ch);
 		rcar_canfd_handle_global_receive(gpriv, ch);
 	}
@@ -1435,7 +1429,7 @@ static irqreturn_t rcar_canfd_channel_interrupt(int irq, void *dev_id)
 	u32 ch;
 
 	/* Common FIFO is a per channel resource */
-	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->info->max_channels) {
+	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->max_channels) {
 		rcar_canfd_handle_channel_err(gpriv, ch);
 		rcar_canfd_handle_channel_tx(gpriv, ch);
 	}
@@ -2072,7 +2066,7 @@ static int rcar_canfd_global_init(struct rcar_canfd_global *gpriv)
 	rcar_canfd_configure_controller(gpriv);
 
 	/* Configure per channel attributes */
-	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->info->max_channels) {
+	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->max_channels) {
 		/* Configure Channel's Rx fifo */
 		rcar_canfd_configure_rx(gpriv, ch);
 
@@ -2145,14 +2139,18 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 	bool fdmode = true;			/* CAN FD only mode - default */
 	char name[9] = "channelX";
 	u32 ch, fcan_freq;
+	u8 max_channels;
 	int i;
 
 	info = of_device_get_match_data(dev);
+	max_channels = of_get_child_count(dev->of_node);
+	if (max_channels > RCANFD_NUM_CHANNELS)
+		return -EINVAL;
 
 	if (of_property_read_bool(dev->of_node, "renesas,no-can-fd"))
 		fdmode = false;			/* Classical CAN only mode */
 
-	for (i = 0; i < info->max_channels; ++i) {
+	for (i = 0; i < max_channels; ++i) {
 		name[7] = '0' + i;
 		of_child = of_get_available_child_by_name(dev->of_node, name);
 		if (of_child) {
@@ -2199,6 +2197,7 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 	gpriv->pdev = pdev;
 	gpriv->channels_mask = channels_mask;
 	gpriv->fdmode = fdmode;
+	gpriv->max_channels = max_channels;
 	gpriv->info = info;
 
 	if (of_property_read_bool(dev->of_node, "renesas,fd-only"))
@@ -2300,7 +2299,7 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 	if (err)
 		goto fail_mode;
 
-	for_each_set_bit(ch, &gpriv->channels_mask, info->max_channels) {
+	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->max_channels) {
 		err = rcar_canfd_channel_probe(gpriv, ch, fcan_freq,
 					       transceivers[ch]);
 		if (err)
@@ -2314,7 +2313,7 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 	return 0;
 
 fail_channel:
-	for_each_set_bit(ch, &gpriv->channels_mask, info->max_channels)
+	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->max_channels)
 		rcar_canfd_channel_remove(gpriv, ch);
 fail_mode:
 	rcar_canfd_global_deinit(gpriv, false);
@@ -2327,7 +2326,7 @@ static void rcar_canfd_remove(struct platform_device *pdev)
 	struct rcar_canfd_global *gpriv = platform_get_drvdata(pdev);
 	u32 ch;
 
-	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->info->max_channels) {
+	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->max_channels) {
 		rcar_canfd_disable_channel_interrupts(gpriv->ch[ch]);
 		rcar_canfd_channel_remove(gpriv, ch);
 	}
@@ -2341,7 +2340,7 @@ static int rcar_canfd_suspend(struct device *dev)
 	int err;
 	u32 ch;
 
-	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->info->max_channels) {
+	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->max_channels) {
 		struct rcar_canfd_channel *priv = gpriv->ch[ch];
 		struct net_device *ndev = priv->ndev;
 
@@ -2378,7 +2377,7 @@ static int rcar_canfd_resume(struct device *dev)
 		return err;
 	}
 
-	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->info->max_channels) {
+	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->max_channels) {
 		struct rcar_canfd_channel *priv = gpriv->ch[ch];
 		struct net_device *ndev = priv->ndev;
 
-- 
2.53.0

