Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795704388;
	b=E9b5kAFvn9StAPlGSIHx2kHzFsfYVlzSlDSS6vsnsvgV20xUhYZqMsZOQH5mVtA9Y+Ad
	 slD2Ubb75lFUT0My3md9QAtipVXM7pfTLgai4HwYMbiCac4E7V7Ndc3of1LzbwZ0tmfCz
	 B0EyH5xe5dueye3maTdBnp0ortXpkSQv9qibG3xooD7QByJWP4uxzf4qG0je5Ff89fSGg
	 OGvcULloRltleGmedGx+94qPhA6cTR7RRUyI2zJqymR4Y6UfyTM7tsA3ev5aYTmBvFV6c
	 nQkx0IaKJuXoMvFUhtLNnhL1X+QnWXF/+um3ySDGALpB6qH+2nfJHz+kZpwXVSaj6OQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795704388;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qC6rj5S7Q7TATrY0TWVFp0gI6vN7ujv0v4i1Z6BdcM0=;
	b=YGIidxFRmAv4Ex5FGkwrVUq0QTpBIrCdff5PoIRyPY/s9nK2j/ejxyzya27OwIdoq+46
	 ni4nqXaA5hlzu5uKBOdPPC/UyxPqZkcUHaYciRQJpVVaVeUsA3rkTu2n+Nj7q67a1usZs
	 WNdcqfUzDJwcgcryh1DCk1A7q3+cxfElTD3Z1aDd3W0qdGfX3cLi4oHWiR27UtXXNy7yU
	 TzZImDJlB4dsto3wpIaoRC7AWn8KDimP4go9CoMxS4rPvsh8vmlU7UWP7X+32CWRgzhJa
	 B96QNEllLUiq8a8mfeU9IhSvmTamSarIDg9CydAFb65j+opSisaypOjpmIr/XL6IJ7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OiiJwCAU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F0B606A31E;
	Thu, 26 Nov 2026 14:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OiiJwCAU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D9731F000CA;
	Thu, 26 Nov 2026 14:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795704388;
	bh=qC6rj5S7Q7TATrY0TWVFp0gI6vN7ujv0v4i1Z6BdcM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OiiJwCAUx1RkME334eeTiYThRW54z1kQEaTn22Nb+LTx2gNRZK/afpLZtczBSdEEh
	 gQE5UC2WbgN9p+kJPm32ANY3tTzGideBh27h+BFlrZ/+bmX9WnF1Vg02i/XX0204kp
	 Inu/c6pJ9mE+pAnUZbYmz5bKwulJJH54ByCr5pJ4L9VdWmOxg/xon5fi9EaBg7HOQx
	 eDNyibjuGm2wa1kvJ9PHQrW/Qj6fG7PYWR2K8kRzks0KYpqF3krLuNc1/RS0kvM6nu
	 doWa1oXQ5cSC49NpqhplGptlIIZojQ8eGnv16Hb2TDzYVNz9qa6OJStwzxkuieQ+Ib
	 mQQxYBhbSlYrA==
From: Geert Uytterhoeven <geert@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 3/4] can: rcar_canfd: Make clkp local
Date: Thu, 26 Nov 2026 15:46:08 +0100
Message-ID: <72de009af38868a4c72c0af674e2f527035a2927.1795703576.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1795703576.git.geert+renesas@glider.be>
References: <cover.1795703576.git.geert+renesas@glider.be>
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geert Uytterhoeven <geert+renesas@glider.be>

The peripheral clock is only used in rcar_canfd_probe(), so convert clkp
to a local variable.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2:
  - Add Reviewed-by,
  - Update new user.
---
 drivers/net/can/rcar/rcar_canfd.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index c57c5252e38572df..ce1d6629c1922fe3 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -469,7 +469,6 @@ struct rcar_canfd_global {
 	void __iomem *base;		/* Register base address */
 	struct rcar_canfd_f_c __iomem *fcbase;
 	struct platform_device *pdev;	/* Respective platform device */
-	struct clk *clkp;		/* Peripheral clock */
 	struct clk *can_clk;		/* fCAN clock */
 	struct clk *clk_ram;		/* Clock RAM */
 	unsigned long channels_mask;	/* Enabled channels mask */
@@ -2166,6 +2165,7 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 	bool fdmode = true;			/* CAN FD only mode - default */
 	char name[9] = "channelX";
 	u32 ch, fcan_freq;
+	struct clk *clkp;
 	int i;
 
 	info = of_device_get_match_data(dev);
@@ -2236,9 +2236,9 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 				     "failed to get rstc_n\n");
 
 	/* Peripheral clock */
-	gpriv->clkp = devm_clk_get(dev, "fck");
-	if (IS_ERR(gpriv->clkp))
-		return dev_err_probe(dev, PTR_ERR(gpriv->clkp),
+	clkp = devm_clk_get(dev, "fck");
+	if (IS_ERR(clkp))
+		return dev_err_probe(dev, PTR_ERR(clkp),
 				     "cannot get peripheral clock\n");
 
 	/* fCAN clock: Pick External clock. If not available or its rate is
@@ -2250,7 +2250,7 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 
 	if (!gpriv->can_clk || (clk_get_rate(gpriv->can_clk) == 0)) {
 		if (info->fcan_pclk) {
-			fcan_freq = clk_get_rate(gpriv->clkp);
+			fcan_freq = clk_get_rate(clkp);
 			gpriv->can_clk = NULL;
 		} else {
 			gpriv->can_clk = devm_clk_get(dev, "canfd");
-- 
2.43.0

