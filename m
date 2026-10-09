Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07094D4871;
	Fri,  9 Oct 2026 13:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553419; cv=pass; b=Z3SCo7hA0mofD8jlCSY/f+I6F9G2p0FRpJXUo8lj90QKCYgJd7mqh0t2csWI5MT1uAOiAiSw8moQZeU3ZCzGAn0I4rCcviAY8KCEK/yzK29nMyM4QS+sO2hw7FhxV6O15aL/UkgrrzXCr2aMCIowwCN7yW331aXeLNq8WVjdugs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553419; c=relaxed/simple;
	bh=AbxJxoTVIhvCpWJsLf6tZMM9u2wYpJiWkTyXJGA1TNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KIruIKFf13RhtYW5hEggngGnDXa6Dxn/WIs00ysgOB+BxelkGE3wddn4z4KnB7GP7A8PmKbvew2ErlrJYY9CrVipTQCKNTDwxo3TVgjFEjjGk8BbUfljcVwBfAM2QOd1MzhWVAL6I9Z6BeOT+X8iZly54zcOGrZQ+JyfdAHPzsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=OTVjVDbY; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="OTVjVDbY"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 0573D20261E;
	Fri, 09 Oct 2026 15:43:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791553414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lCs3jym0XNFnfrLFXL0S112gkjhJSSwjd7o96tiFaSM=;
	b=OTVjVDbYdECqBhFvDN8J6Mt7XYhkIg5nj8imrAYtsqpSXAzRQgfufYOYNlDHYc3Z7rNkc7
	NPqGKGMU6mYL1qSbtpolcM/jGXaAwm+fVKxIv3LxKekIAB4pn2R2TswAqx4Muzz70gc8DV
	aVYdYCYZqCQbMnYJ5kONl4VVP8BvWLvGP6EsLdXw/n3dRJrdS8ixxVrM7bTv1NfRagorOg
	OBUxxahmpkMKQdtbry3qHGB0LUq+ri0C91Dwjhhd0ODVTcGFQZh7jipTOnO5Nik+plPEKk
	KvBxGyXffRQWx5QCoA/S67nGJfvyrsPWLaIQuK74UggBz2O0X99JV/piGWY+Ew==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791553414; a=rsa-sha256;
	cv=none;
	b=JrmJafzZmAlLdLuz7LeQzEM5MQ9NSiQ5EObGUSy4p8sS80xYMeM6ZbW66Fi7Yaea4nGwXs
	ymOMG539Q6Pqyho/tNtVPHf9Hr1Cx+HVwqcj/CTP7r9GxqJRNv8iJr1iEmnHJBtTW7x1Ua
	bbou+ZA/wxlfA0qDMGr4JD5ZMo9aGvarUCMj1IYMiba7JfZiuqdhQHJtU3LmMwYKIrk6GC
	JLVY+ytjyKrhFXjoNo1rj0DWcZ7uPsjg1ufg3pztSEAYvTABG6x2+vhGrW71qQoZaNFfiI
	VVdJc0hMNT3arBhAO6zqdNZ9Aqx5Nh6Hs4bDiA4dKz/2WzD0HBs1EBK8D7W2+g==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791553414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lCs3jym0XNFnfrLFXL0S112gkjhJSSwjd7o96tiFaSM=;
	b=f11+HhYH3ChdLZ7MMlmFuS+wuYCweLF9gQlEek6AXLaWBCjQU8WvFtJaBGYqzZS6V9e4Y/
	hBuJCewvoCLJ3dnbjTzuOcRwdoTYXdvzPQMbYpGZbNNp+fCvpbTA5ityY/jSESA2j7u7n4
	/B+l57GQ6z4Miczu7wgTJbEI2U81G1aX9GBM+DFtVNU9o9LPse05qp4j/83JLHJoXd64UU
	TzbWF3xI+GyIEGU+et3EccDxslsREEIm0mnVGFnNINVJa0KqiBb4HN/2qvJV71J+5lJ3XI
	J+tR+4jl2vISAEF6sq2jeOTCFGH1qbaCFhW87FiMrLuCnSAZqKxjTaqh8j7I9A==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xFAsn-0053S4-2y;
	Fri, 09 Oct 2026 15:43:33 +0200
Received: from blackshift.org (90-182-211-1.rcp.o2.cz [90.182.211.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 774315BD8AA;
	Fri, 09 Oct 2026 13:43:33 +0000 (UTC)
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
Subject: [PATCH net-next 09/37] can: rcar_canfd: Fix typos in macro names
Date: Fri,  9 Oct 2026 15:27:41 +0200
Message-ID: <20261009134323.64064-10-mkl@pengutronix.de>
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

