Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795704385;
	b=mYVplE2hXBM/EKmWkeqU9EsoLz+U7uDmM3ffCkLKJqpWyZY02mG0UGil5OG+BXrTlksL
	 msFqnBd+X8SFp9tXLLG2TCZYZgsQbD3Aut/XgtUUdpyrooGu5wmjw9/0B8qlPdwBNmCVN
	 lTFaEZGhMgFMfFwJti9HsA+2NeaOA7dEmi5fhfBEVOEzLavx7vQp9xs7YkJvjKKTZnjTQ
	 Czz2pX/I5RpiGFla+U61tlZ/DdWNsHYbOaBa5ws0QWlUbM1xmaeOdJZnodU76KjXTL51y
	 p9MRd6z6n7chC/X8zPi9f29miezuTqbDo7WzkLkSbtF/LOCGCy5Lh2x4wXWcT6xakBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795704385;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=43DT+0N/KHuXPvPZTfHEASKIKf7hWu21oag5oHhyoOk=;
	b=kP4Xhtu+xyZgYY7jskpyhtriregStFsgcP2bUjFOW0AH+PbLdS32THaYTaYL5UfQSyZX
	 k6ahaoGL8k0GUsRLNcsP5abh6EA+fZoaQoxxHs0X/TnHx9GlJLqgh7PgCvQ+q37K2gyUE
	 6cFugjqp4NOgsvmvSrn9oRykQfqgP+SDpaCyxRUOJ8pWh6UiSOmQBrr1Pi0TiY4a7q9A+
	 qM9EJ7NieA2e18iShTcaiqRMfNSlEZwFenaRs+OPypR8xpUfSvNfzQhWbv+tHV6Nc56in
	 nT9FI9TN126hJ7chbdpT/0105ghfeGedspgdL/Ktm9dU5wRxcL7XOMsx8htbgexYuWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EGCGQ5Sc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C22606A32D;
	Thu, 26 Nov 2026 14:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EGCGQ5Sc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C881F000CF;
	Thu, 26 Nov 2026 14:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795704384;
	bh=43DT+0N/KHuXPvPZTfHEASKIKf7hWu21oag5oHhyoOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EGCGQ5ScCVdNB5z3+0xzzA/v+ct3jbi9ETJEQUj/cL0L9d64uql1mOtZiWJqjcS8a
	 wKjO12rNMwnMIhPSDnuUPXzAkXv9LVdZU/cAqoTQ/nuatk1iI0tk5LSknDw0zVj9Qq
	 XZhseBV4IPh2bGhyR4F1nSIR+xpRJatOjd5hiXUQhAab26bM0gISrB0emIjiK2uLVT
	 Q5C6VAOqjgVvx0Sqq/RBHccXNvBh5zPpoiceU5adZhCHVKOfCypIDyt5o1+hxYw4bY
	 mbpTxReuC2hmQJwxvdocKKp9Vui1l4f73venXnj9u+wcj3Iy/gmfwePjuibNHliRBi
	 1SzYqs1JZcU9g==
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
Subject: [PATCH v2 2/4] can: rcar_canfd: Add Runtime PM support
Date: Thu, 26 Nov 2026 15:46:07 +0100
Message-ID: <557fa8a4776e0ee7d6c566b825771075db46b276.1795703576.git.geert+renesas@glider.be>
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

On R-Car X5H, the CAN-FD module is part of a power domain.  This means
Runtime PM must be used to make sure the domain is powered when needed.
The CAN-FD module is part of a Clock Domain on all supported SoCs.
Hence remove explicit management of the functional clock, as this is
handled automatically by Runtime PM.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2:
  - Add Reviewed-by.
---
 drivers/net/can/rcar/rcar_canfd.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 1040803936f56cea..c57c5252e38572df 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -37,6 +37,7 @@
 #include <linux/of.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/reset.h>
 #include <linux/types.h>
 
@@ -2059,9 +2060,9 @@ static int rcar_canfd_global_init(struct rcar_canfd_global *gpriv)
 	int err;
 
 	/* Enable peripheral clock for register access */
-	err = clk_prepare_enable(gpriv->clkp);
+	err = pm_runtime_resume_and_get(dev);
 	if (err) {
-		dev_err(dev, "failed to enable peripheral clock: %pe\n",
+		dev_err(dev, "pm_runtime_resume_and_get() failed: %pe\n",
 			ERR_PTR(err));
 		return err;
 	}
@@ -2071,7 +2072,7 @@ static int rcar_canfd_global_init(struct rcar_canfd_global *gpriv)
 	if (err) {
 		dev_err(dev,
 			"failed to enable RAM clock, error %d\n", err);
-		goto fail_clk;
+		goto fail_rpm;
 	}
 
 	err = reset_control_reset(gpriv->rstc1);
@@ -2129,8 +2130,8 @@ static int rcar_canfd_global_init(struct rcar_canfd_global *gpriv)
 	reset_control_assert(gpriv->rstc1);
 fail_ram_clk:
 	clk_disable_unprepare(gpriv->clk_ram);
-fail_clk:
-	clk_disable_unprepare(gpriv->clkp);
+fail_rpm:
+	pm_runtime_put(dev);
 	return err;
 }
 
@@ -2148,7 +2149,7 @@ static void rcar_canfd_global_deinit(struct rcar_canfd_global *gpriv, bool full)
 	reset_control_assert(gpriv->rstc2);
 	reset_control_assert(gpriv->rstc1);
 	clk_disable_unprepare(gpriv->clk_ram);
-	clk_disable_unprepare(gpriv->clkp);
+	pm_runtime_put(&gpriv->pdev->dev);
 }
 
 static int rcar_canfd_probe(struct platform_device *pdev)
@@ -2319,6 +2320,10 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 		}
 	}
 
+	err = devm_pm_runtime_enable(dev);
+	if (err)
+		goto fail_dev;
+
 	err = rcar_canfd_global_init(gpriv);
 	if (err)
 		goto fail_mode;
-- 
2.43.0

