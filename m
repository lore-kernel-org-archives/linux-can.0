Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A194E535A;
	Mon, 19 Oct 2026 12:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792412049; cv=none; b=QKEXNJDERDrSaGj0YE6/AJJaVpdAoI1R4Q/KAvTk3sos9aASYjnKhSUuH+cV3TuGhPI8Xw4LiISVYidAcOUw/vXSRs7QQXxculbu1PRqK73Cc//Fk3oYD28huJjWTPqmNu6N17R+JHMMLIbbBS3UNKXJNOoAYvno4gtKsQFxyho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792412049; c=relaxed/simple;
	bh=nOE4hbRvtXLh4mpItQg10eEhc7nhQLi21HzpXDfa1MY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XcQGI0lJLtlql/Ou7difjXdLuf1Y/LIpsEwhVIiEZrQ+go+fUsa5V1mFLCuJIuyXKWjniYQ2GSC1v6CRMVsxNrOQI+QI+PGnexYT8m8PsF1ly9JbD1yf7ouqsztiuzDOhFo63PZl4uBxm3f53J3dnoTLbeEDFHW9FqYx+uE60tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kFujewNv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kFujewNv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E261B1F000C6;
	Mon, 19 Oct 2026 12:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792412045;
	bh=Mp1MjvYNSiMazg3J3t2uaa1/HZac8fuqtGiyiGLK5JQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kFujewNvM2vCZVHnzhoEkYlE7YMri0OEDvU+gbfICjzfuk1No0V6wvHcRRr+yIeQb
	 B+ONfWzXWvYzlcacU504tv1AkdVBSkdA9S41oBZazf0edYq8hJSmQwHgio4BoIbcKe
	 r6SgZwvpsyNwGLNByZ/oNFzpV7cigfsYOBYT8KJWI2z6zLobb8nj7+6BuiZQlStgUk
	 2FFauKvqhr30I3dWN/yJpvXQ7fGnG4r4dmA0FZmfwJ0f7hYeWv2c1WZPm00O7AgRTb
	 aFuFx20vXdFo9/teonAXbDs1asAmHNqdTKvkYia5gypq1JGacy7x/E0fzCVmZCTcpd
	 9hj8yxu4i4i5g==
From: Claudiu Beznea <claudiu.beznea@kernel.org>
To: mkl@pengutronix.de,
	mailhol@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	biju.das.jz@bp.renesas.com
Cc: claudiu.beznea@tuxon.dev,
	linux-can@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 1/2] can: rcar_canfd: Check can_clk request for errors
Date: Mon, 19 Oct 2026 15:13:55 +0300
Message-ID: <20261019121356.2421761-2-claudiu.beznea@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019121356.2421761-1-claudiu.beznea@kernel.org>
References: <20261019121356.2421761-1-claudiu.beznea@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

If the provider of can_clk is not yet probed, devm_clk_get() returns
-EPROBE_DEFER. The driver treats any error as can_clk being absent and
falls back to the other clocking options, so the wrong clock may be
selected instead of deferring the probe.

Request can_clk with devm_clk_get_optional() and propagate its errors.
While at it, add a comment mentioning that the canfd or fck clocks are
used as a fallbacks when the external clock is not available or it is
described in device tree with a rate of 0.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 74c3c3f20991..bb2d03b75142 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -2220,11 +2220,14 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(gpriv->clkp),
 				     "cannot get peripheral clock\n");
 
-	/* fCAN clock: Pick External clock. If not available fallback to
-	 * CANFD clock
+	/* fCAN clock: Pick External clock. If not available or its rate is
+	 * zero fallback to CANFD clock or fck (when info->fcan_pclk = 1).
 	 */
-	gpriv->can_clk = devm_clk_get(dev, "can_clk");
-	if (IS_ERR(gpriv->can_clk) || (clk_get_rate(gpriv->can_clk) == 0)) {
+	gpriv->can_clk = devm_clk_get_optional(dev, "can_clk");
+	if (IS_ERR(gpriv->can_clk))
+		return dev_err_probe(dev, PTR_ERR(gpriv->can_clk), "cannot get can_clk");
+
+	if (!gpriv->can_clk || (clk_get_rate(gpriv->can_clk) == 0)) {
 		if (info->fcan_pclk) {
 			fcan_freq = clk_get_rate(gpriv->clkp);
 			gpriv->can_clk = NULL;
-- 
2.43.0

