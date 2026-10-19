Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE214E4C58;
	Mon, 19 Oct 2026 12:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792412049; cv=none; b=JoSIdGX6aiyqUkk5ZfOIf4JP3yukaoOnw4rM3WfkCD9Ubzl04xPxGPcBVyNgNbmDM5LocutgJ/zivnW07ZZ/7mRkVzsWE2ZmfdhOU/KhbdoP9a+diZYYCKYqB3V8pqtBPHnRHnAt3NgbQ3RggkzSXW4W9f4UPiFlFxPvOB7rXfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792412049; c=relaxed/simple;
	bh=z6VYVYtJ7DGTpANzgqME6wb3UEs7bYt6qRjgOT5mwaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lUhD38RpLRRJvDePOgCSmRcFETO6wfhKTVJV2IvSW7gRdTZieyffApzWkvkNXPk78po795aYuV5Tbm1K0oILeCkH9oD9319gOCg7yHfgJ1SWKeAfgeCkXIlgrtpTSU4Fuh5VoNwIdgUspyZbZLsPUAYxyzPaot7qK3yJrrBesAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MgQekndF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MgQekndF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B18851F000C4;
	Mon, 19 Oct 2026 12:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792412048;
	bh=D/lxAYFuniFyO2Ez9Lx7i4SBkY/wpX3Pwioyqfb4gZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MgQekndFi5DaBJHWrBQs7EJ/oVA8/BrRMZLddZ5/Y1SkbjCFCYz9KWazCTM1BXJ69
	 3Q6tTv63GJs9HWP5LLaDS1RvmSphFiIWzw8MEp3YtSA9t0gspLuK1OORKyBzGZuoGz
	 Z31NtxaOVRH3nrSIwrf811mku53TN+hmnmgnCqsO21+1EucrknU9MzFhZ3N86AecT5
	 McgKCWNo+k6o5OqODKgoZ/ZqXP3WIaqYGulnee4YyNg0ajDOgxfOmjkKIpHIWVL+Ym
	 4pBXyOTI83zxRL8GRcg1e7sgZWKlukLMeSwGZZJa4fnFh7OaDqaa1UrncR8LRq/2M/
	 REo8p7OG8K58g==
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
Subject: [PATCH 2/2] can: rcar_canfd: Use DT clock names in the probe message
Date: Mon, 19 Oct 2026 15:13:56 +0300
Message-ID: <20261019121356.2421761-3-claudiu.beznea@kernel.org>
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

Print the DT binding clock names when reporting the selected clock at the
end of probe. These names are part of the DT ABI, so they are stable and
match what users see in the device tree.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index bb2d03b75142..4f5cdfa8211d 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -2312,7 +2312,7 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, gpriv);
 	dev_info(dev, "global operational state (%s clk, %s mode)\n",
-		 gpriv->extclk ? "ext" : "canfd",
+		 gpriv->extclk ? "can_clk" : (info->fcan_pclk ? "fck" : "canfd"),
 		 gpriv->fdmode ? (gpriv->fd_only_mode ? "fd-only" : "fd") : "classical");
 	return 0;
 
-- 
2.43.0

