Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C153876B3;
	Thu,  9 Jul 2026 18:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783621421; cv=none; b=kNyBtR27dFsfvO5PYeVplAoMy57NWkxHwP9G1QMtpMNzicV2TyarS4bPL7lDy2xfOr09jQ2vX5kXQYKU6aS5k6BB5XQnIFg+zrZB1tFsJ7W1Qwf/hZi3BUmZl2X+fPMd8RiGiGzgmvzdwrSF2qelsxwNMNgY6ZNKyHDTAjwrjcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783621421; c=relaxed/simple;
	bh=4e/MIi3W1yerU8MpEdCHYx1zGCbn9dCaY/CDYCNnZc8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p78Snx0UUetuXWVJ+4TmZmNzeOzKxcceXB7PSuI4BRRsz0AIzGce3FsCbDNaZcwdCLnj2Yj9oD0rq5XMyMP7MV2Rsvv1BViVgx7QWRelwmCuCSRwr+mx/J5CRo7Xd7I4sflYqa14NfY0zdoI7uL2gyGjNTpg0GX96SF3NL1Aqxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B32E1F000E9;
	Thu,  9 Jul 2026 18:23:35 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea+renesas@tuxon.dev>
To: mkl@pengutronix.de,
	mailhol@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	bmasney@redhat.com,
	biju.das.jz@bp.renesas.com,
	claudiu.beznea.uj@bp.renesas.com,
	fabrizio.castro.jz@renesas.com
Cc: claudiu.beznea@tuxon.dev,
	linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: [PATCH v2 0/8] can: rcar_canfd: Add support for Renesas RZ/G3S
Date: Thu,  9 Jul 2026 21:23:24 +0300
Message-ID: <20260709182332.876408-1-claudiu.beznea+renesas@tuxon.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series adds CAN support for the Renesas RZ/G3S SoC. Along with it a typo
fix patch was added on the CAN driver.

Thank you,
Claudiu

Changes in v2:
- collected tags
- addressed sashiko review comments

Claudiu Beznea (8):
  clk: r9a08g045-cpg: Add clocks and resets for CAN-FD
  dt-bindings: can: renesas,rcar-canfd: Document RZ/G3S SoC
  can: rcar_canfd: Fix typos in macro names
  can: rcar_canfd: Allow the CAN FD clock to be sourced from fck
  can: rcar_canfd: Do not set registers selecting the CAN mode
  can: rcar_canfd: Add support for Renesas RZ/G3S
  arm64: dts: renesas: r9a08g045: Add CAN-FD node
  arm64: dts: renesas: rzg3s-smarc: Enable CAN-FD

 .../bindings/net/can/renesas,rcar-canfd.yaml  | 20 +++++-
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    | 39 +++++++++++
 .../boot/dts/renesas/rzg3s-smarc-switches.h   | 12 ++++
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi  | 46 +++++++++++++
 drivers/clk/renesas/r9a08g045-cpg.c           |  9 +++
 drivers/net/can/rcar/rcar_canfd.c             | 64 +++++++++++++++----
 6 files changed, 177 insertions(+), 13 deletions(-)

-- 
2.43.0

