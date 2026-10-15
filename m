Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7D53839A0;
	Thu, 15 Oct 2026 01:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792029232; cv=pass; b=WX2Ac59S9mJVtVEjheH5l1K7NhEqLA0yvA2zsFxwDeHfO9EU/7i+5EbOnUXY3+lmEyH3f20EmKT2x4Zl8/+M6PtEU6RsBqVIaO8jwArjeEXnHqcKZa+ZE1dfM1ZJ6+l3fVfqE0J8yOHiwXZSIp8engZeI6jn85dVELFnCd4s/Ok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792029232; c=relaxed/simple;
	bh=r4kDyHvzW3UIJfF8H/oapxl1C0+GikXGIA/XeF/vd8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QajeiDOnFZRw0RWoD+xuL87h9pj3T+VTBJccWs4gkJt6uscmij4H5gPM3pWqJkLfKomdnbYo1XFhkCxC6Rc2EOsxvm8IXD2Dj0ju7wUG1Q7mPfUnkfZ8dDR0HDEPuRJaYCOfMhJPugXPYu6hfOkKaK/ih3il/sfTk+9zGPy6xKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=eaLliW8t; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="eaLliW8t"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id C5FC62027DA;
	Thu, 15 Oct 2026 03:53:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792029220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hmb8mrgH5Akez/V29LYYKKc2sJv193Jb9sw338t88Jc=;
	b=eaLliW8tVCg8UvZhIf4ZOa6RpfmQtZMtiDN1/i+EzAa7IF9L0MxZbfEVvJCJWoqRibAN0b
	c5xGm86+tHlPp+7wZAVgHTzdvsvETMH7UJCJedNQnA4HzdaeQLlF6aAgZUVv6oi3To5UHX
	zAfFCx75UL8EkhEa0UqSZGUKmJNx8ITNfMIEJTpBOEQVBI2dQ9GBFTeGT0JbZkqUpuUd/J
	mRgNTSKvO9F3wWG7hhtRp9OUvIL9r01tdFaoEqua51OdPV3h3AFp+VbgVcwBlgRHuz99md
	BbXVRlqKof0v72r4IStej4Z+A+LSusv6eKuzxCp/rq3OdVIFmmV/w25E3oSL9w==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792029220; a=rsa-sha256;
	cv=none;
	b=FVNvX8ukdsVNVw/xY1kVEg/jEE5HmrszUJ1KTq+HrE5l3hCqV0dKpyPlbTpR6XW/D4xtMs
	n7lV/c4lnRGNOpZo7dzdBmO8Zd3YlzzzuuztW+IM4FVWgSm97dgkEXck3jpwcP2j7Jlayl
	2DtgyPvGv30l9AVC/2gSXiRIAloLpFffTG2mwtk5flo9GKSnioELRpP1tjOlz85kJn3c/e
	ilrYmlWVEXjUwTDz/DtiaXFO261wjDF97lOUlzUYJjChCH1nsvKc7Gw68GrL/4AeQkV3S8
	7kO+M1fxt1551e3jpyJ2eThGJ57qLfVC43J6adP41onVjKCTmffW2gO/R/V7BA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792029220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hmb8mrgH5Akez/V29LYYKKc2sJv193Jb9sw338t88Jc=;
	b=Pv7AZTtg9as72PlYGWFnCO890tcVq4/Q46wRYVBwvL6UsH2cpyasbqHZbpHt2q/GsqsOdk
	HtPP5IGySuCVYyUqwxBXDMTW/WyU3zKvxbaGJQH9JXJS+8HcYY0qI5flOwdIuHGBqdpk9d
	XZ9564TNshBpgUqsz/aKOVq20EdsoUUmhgjKL/uZFVYwmhlL+xJH1NTuqm60AsDznUprXq
	B/x/dDIsw/uP5kOuIYHO4DCWU0Qag8eTt5pYHxqHCIzk2CYbWjf0Otz5rJh7TbwrnlCO2S
	JGMz4oOeKROpO5C1WMi+7htAhpOLXy1TNrd4q9LTCJiTfbKYjrbhXoJmb9zyww==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xHAf6-005wqa-2F;
	Thu, 15 Oct 2026 03:53:40 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 6683A5C4783;
	Thu, 15 Oct 2026 01:53:40 +0000 (UTC)
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
Subject: [PATCH net-next 16/37] can: rcar_canfd: Do not set registers selecting the CAN mode
Date: Thu, 15 Oct 2026 03:40:14 +0200
Message-ID: <20261015015336.816543-17-mkl@pengutronix.de>
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

