Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DE64E3EF6;
	Fri,  9 Oct 2026 13:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553424; cv=pass; b=eaDiP9REo9WznYaAsgN1lh4O80r5TJoYYlfVrDDFpW/9j/gZlC9Wv++wzhrO1xQ3/kw8Z+2/fcEMFkfnHgvHODJca3TP4LfRryS93RjZpdbjDFpAOpDMqGHzzZlKe9WWe5oOSke0ZqBFJEVpmfa/eYahWNnsEP3Lt1OAD8BO/rc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553424; c=relaxed/simple;
	bh=zo1NA1nvn4M+xvhuS8yWLWtNX/gO9UWlZoWoaWC/PVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iOBOPR799weZID0ux+yx7q65263BySO6oCINjJUkHIEx4eY5UozOyVNlIUBpNJbg8xEEf3D1jkI8Em2Oy6jbqxmRX1TYSYKHzxCmJrOKJEHuaPouAetY5Tgx+AKnmmi3uy4ViyFI7ZiitbEanqREU2fvVIfUc7uUJQB5MUfKQOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=gSyUQXVl; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="gSyUQXVl"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 7D6FB200926;
	Fri, 09 Oct 2026 15:43:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791553416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u37pV0NcI1X3RF1Tg1EqbEjSY6Bl7bPlmaLvLyV2u3I=;
	b=gSyUQXVl+EYQR7ma2bedQrMl9ga1IbyeTb0MzJnv9CoXLflZG10xHXHj+jF2l0Vz3nimtX
	4f/9QBEh3uGYaH6q4E0ACDeEAgajGZCmGGbL7Ld63SY8GAz4oL0Q4H03RYjovI/YPQpiqM
	eJLbyYVDR8aHNCwxIFRHSihsMVpxrDx2wRtY9OJTaDE7dARo116IkxlNIsWMpsU7l8yTJs
	ESxxFXcxwEsw8K7r5lPbPMGzUoige9RJJcLNtxRfmGcv7QlwUq6WUQ2reGNGNyVxR9SvEu
	mJtJJbsa0DxQWrvNdAeqJpzWQ9L0y/sP6AcZvpas1OZGnE5k8Sl036bDhtB/lg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791553416; a=rsa-sha256;
	cv=none;
	b=OhEdhhxBrJshl2V1wyQl4MJ/BjEQh1HcwvNMLb9OEVgZhwwu/X7+UKycJVbkFoVhxhWJqf
	iBqklXzMyQf9uDRFVJ/1jl+NNvz6R2OfR0Rouqx80UOxcoN4lrHcEVJoQOofhm5UnRrQML
	BIkRlD+VHRyxl1AQdMolFWqICLo4KygpV8Yt7+V5MF4NkuaySdv0rB+gWCI0lKhgxD/toN
	yPwJG91ru25xP06mdfZ6gwx7JpMpCof8sX0QuKRVvES5aUTPVc91NiuOQWSv3w2EiPrlmx
	GIgzx2O58e3PnU5ilz4FDD7ghEZHqoRFQq2Ek/u/wS/IxnfV/kF/vdocmlzkdA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791553416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u37pV0NcI1X3RF1Tg1EqbEjSY6Bl7bPlmaLvLyV2u3I=;
	b=M+to/VvOBQmcKYUZvO/toNRrP1gotlOd71GEh5JNUv74UgRxINSOU+os4w+4mIv+22YYs7
	WN8T56SYFL0bh0+vOWobOHQe9mn2yLsqYRqH+8WNQrxUUsaB3tSGfr1u3VJIsT26iwnSDn
	uY8EQYjWxJADhoyjPqPQzE1cLYWMPgGtYI86kpMLQ56fcY5DU7ZuGsDBR7zMMx0P88oFS1
	tdRSKf4+RhAMR6rL4toEyWw3YPdyCZ8e96F7Z+UydGHqVfdWwzOVJMt3zpkqshfo7tiGCn
	llFnc2R65omY0qbHEM4EEY812oMtxaOGa2HTtJxd+EdG2xvj/2yjY/ybyRaFsQ==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xFAsq-0053Sa-1K;
	Fri, 09 Oct 2026 15:43:36 +0200
Received: from blackshift.org (90-182-211-1.rcp.o2.cz [90.182.211.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 004A85BD8C2;
	Fri, 09 Oct 2026 13:43:35 +0000 (UTC)
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
Subject: [PATCH net-next 17/37] can: rcar_canfd: Derive max_channels from the device tree
Date: Fri,  9 Oct 2026 15:27:49 +0200
Message-ID: <20261009134323.64064-18-mkl@pengutronix.de>
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

