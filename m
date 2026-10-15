Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D9C379C22;
	Thu, 15 Oct 2026 01:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792029227; cv=pass; b=Gsdgb1zF/I2sbK1ntFY4nxqnqpiOAemsmWzSmklUfBnGLYOl9BcwxIJ9apBR806yCqBb5P42GTuNorlcFTHegSEvpmC2iWaskvOygnbfldmvvXStLpQ/Rraq1NBhXkbZ9+0pMRQgsKTI5qNdUUNeYU/3GbrTGwAizS3rfEjPc1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792029227; c=relaxed/simple;
	bh=AbxJxoTVIhvCpWJsLf6tZMM9u2wYpJiWkTyXJGA1TNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h7yWeBmbs0jRu8QyqkJ7kMkgbmdjF+aQp7ZkhFNVZyefXGY4ihGpPemW8f9JbbQrqN384bEXMJqwq7/r3JJI0DXWIpBkgomy+VPDp36DRp+dCpyM11FGEr+Hlf81TbR2jCGJL/92qmrqNJz4FASdqQ5ExnuhtVvl22yLKXHi0uU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=V24f7jjT; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="V24f7jjT"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 8C6802027D4;
	Thu, 15 Oct 2026 03:53:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792029220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lCs3jym0XNFnfrLFXL0S112gkjhJSSwjd7o96tiFaSM=;
	b=V24f7jjTHLzmVOMKUYYQsd9TKDXypcvMQCu9LrbhILbGuYyP6f0BKq/t2broibY+tWCHye
	hGvKx6gbgRZuf4HGNbP4216Z7lQSFbe1jfx6bVhbnERzjYfSoJfpE/58ioItlRQz19mSDE
	hxjDNqi9jzieSARY5dzAoc7wYIjWnvHulzcUBlnwSs2rtzYE4bO75kZbDCAyI3QMs4WYpi
	ir5k/geFvkpfuuvnOBwth8qUTBaVBZG+QGIie0y4bOfS0toaZ/Ivdb08VI1RAFOOUTS8i9
	tykpH141nO9CWYphr56UjhcyJays8k4kACQa8JCpMoRaho2AoUopXWBN5xZlig==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792029220; a=rsa-sha256;
	cv=none;
	b=ESTaOP99cEvAhTOuf6/jjd2u/Dhy7NkKRsfCrfCHyt+dAxmjd17KF86RYOmXjt9YXrtVjy
	Z9cBuQQTA2VCBpPWzZKO+n7dKIdCDON9SbtEhSnrKDyqM2uyWp9HMHzJyqT4xAp2rZWSx8
	XaACEZwBZh5j2Z95UrjHthGes9hMHUc4aiffiEfwx+X7XB58J9psxQJTAsYGpdcMMN8J7+
	wTAln0Og6/9aMI/5cU0g5lRlVSX8pL9DP6h/W+qTW6mkP6VNMfCPZCTcxA4FXTg2fUKLeJ
	9a45h/6Z8o0cUC3xLH3rXjzxTpVtQMLfl2WMgp9RJ8OmZw/dsfdjMhZhuutzAA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792029220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lCs3jym0XNFnfrLFXL0S112gkjhJSSwjd7o96tiFaSM=;
	b=Wo828AyAxkmbdUxdDXGyPkz0LTxP9sZrn8vhgc7ncNrlI090VyGPI64haJFRAmExEp1Amw
	xqE9St8ecXXpseRcdBUx0V/+E5Yd/k/nuB0LafRaOm1ipYjXLZbobQBDlnGNctmXpT4VWo
	DW7JJcwbOzwWDfxMBQDLeQsfPlFAwtXKQhJUwTbHyf/I+pSLvaUlPmMl1a/UdDoOJbHw5e
	NHYGEQpWtyywYn34ir9usq/oJSWwR/d8UEhzCJ1IQa4u55l5EEFM075aKkgn3xfFycsXvh
	hnLbmAw+TlKJwYhPAxxLH1OiVTKMJKm50pNDgSHbsrOlnCkI/ILWWCmUi+oPeg==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xHAf6-005wqQ-1X;
	Thu, 15 Oct 2026 03:53:40 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 3A9265C4780;
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
Subject: [PATCH net-next 13/37] can: rcar_canfd: Fix typos in macro names
Date: Thu, 15 Oct 2026 03:40:11 +0200
Message-ID: <20261015015336.816543-14-mkl@pengutronix.de>
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

The bits 1..0 of the Channel n Control Register are named CHMDC (Channel
Mode select). Fix typos in macro names by replacing DMC with MDC.

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20260902141544.565763-3-claudiu.beznea+renesas@tuxon.dev
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rcar/rcar_canfd.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index fcc37b73ed43..b7c4fe3477ac 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -132,9 +132,9 @@
 #define RCANFD_CCTR_BEIE		BIT(8)
 #define RCANFD_CCTR_CSLPR		BIT(2)
 #define RCANFD_CCTR_CHMDC_MASK		(0x3)
-#define RCANFD_CCTR_CHDMC_COPM		(0x0)
-#define RCANFD_CCTR_CHDMC_CRESET	(0x1)
-#define RCANFD_CCTR_CHDMC_CHLT		(0x2)
+#define RCANFD_CCTR_CHMDC_COPM		(0x0)
+#define RCANFD_CCTR_CHMDC_CRESET	(0x1)
+#define RCANFD_CCTR_CHMDC_CHLT		(0x2)
 
 /* RSCFDnCFDCmSTS / RSCFDnCmSTS */
 #define RCANFD_CSTS_COMSTS		BIT(7)
@@ -828,7 +828,7 @@ static int rcar_canfd_reset_controller(struct rcar_canfd_global *gpriv)
 
 		rcar_canfd_update_bit(gpriv->base, RCANFD_CCTR(ch),
 				      RCANFD_CCTR_CHMDC_MASK,
-				      RCANFD_CCTR_CHDMC_CRESET);
+				      RCANFD_CCTR_CHMDC_CRESET);
 
 		/* Ensure Channel reset mode */
 		err = readl_poll_timeout((gpriv->base + RCANFD_CSTS(ch)), sts,
@@ -1504,7 +1504,7 @@ static int rcar_canfd_start(struct net_device *ndev)
 
 	/* Set channel to Operational mode */
 	rcar_canfd_update_bit(priv->base, RCANFD_CCTR(ch),
-			      RCANFD_CCTR_CHMDC_MASK, RCANFD_CCTR_CHDMC_COPM);
+			      RCANFD_CCTR_CHMDC_MASK, RCANFD_CCTR_CHMDC_COPM);
 
 	/* Verify channel mode change */
 	err = readl_poll_timeout((priv->base + RCANFD_CSTS(ch)), sts,
@@ -1578,7 +1578,7 @@ static void rcar_canfd_stop(struct net_device *ndev)
 
 	/* Transition to channel reset mode  */
 	rcar_canfd_update_bit(priv->base, RCANFD_CCTR(ch),
-			      RCANFD_CCTR_CHMDC_MASK, RCANFD_CCTR_CHDMC_CRESET);
+			      RCANFD_CCTR_CHMDC_MASK, RCANFD_CCTR_CHMDC_CRESET);
 
 	/* Check Channel reset mode */
 	err = readl_poll_timeout((priv->base + RCANFD_CSTS(ch)), sts,
-- 
2.53.0

