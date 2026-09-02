Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF44935C1B0;
	Wed,  2 Sep 2026 14:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788358561; cv=none; b=mxR9ZPXh9n1JSzxFWFSugTUFsWdM0GDnJ/7POD3jnJ4rsiICkhvpRZv2h8rGll/ORdeupLgQT+IBEPksJL8ROXJh+ixWhOMkXW4nym2QAJcX87pksOGL9ReOfyzWPFbj7JGV5VzBVx6yMVSuXGOSH5nfgXzrlwYGoR+PEwf+4Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788358561; c=relaxed/simple;
	bh=5hoI59QEZUdi/Kf4amycYi0zdwFkh4Xwlu51Hgvy0vg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DrX0d5RydF262OjzUjU6VigkfDSANGoY8Nde7o+Brpp3Sf2p+zvtFkuI0EhAgEuo6pIxHaWj8qeZTj1gX56JBCYuJG4qHr9bom52mzWfEYLBuBnnJBf0fc50j75T0ab3IHaFU65lIEfgpj9xs67Cma36PV9/odcZrPWDBFagBSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 165491F00A3A;
	Wed,  2 Sep 2026 14:15:55 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea+renesas@tuxon.dev>
To: mkl@pengutronix.de,
	mailhol@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	biju.das.jz@bp.renesas.com,
	fabrizio.castro.jz@renesas.com
Cc: claudiu.beznea@tuxon.dev,
	linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v4 2/7] can: rcar_canfd: Fix typos in macro names
Date: Wed,  2 Sep 2026 17:15:39 +0300
Message-ID: <20260902141544.565763-3-claudiu.beznea+renesas@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902141544.565763-1-claudiu.beznea+renesas@tuxon.dev>
References: <20260902141544.565763-1-claudiu.beznea+renesas@tuxon.dev>
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
---

Changes in v4:
- collected tags

Changes in v3:
- none

Changes in v2:
- collected tags

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
2.43.0

