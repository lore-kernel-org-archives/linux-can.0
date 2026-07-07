Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55703E1D16;
	Tue,  7 Jul 2026 10:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783419867; cv=none; b=eds2G0iQf/cUylGVZfKWxGdg0RU22/60qG1F8pub75CZqD9mJQcRFoT8vGUepXTSuInD83p/lAdwOadp+VsRFbY9C5FCpLl/bfP6UHvfcDDRS+BuT3vDNhAstvhvZzYtOaUJyoBbN89/d3AGOjaJ7zkeUAICytP3T9isOh/NhtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783419867; c=relaxed/simple;
	bh=rfQA24pNBdai4SXVx7SQMIib5Yam9+s344kX1w9crpU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JggoGJdM8rwOFU9naWxuRFgGtwDJ4DBS7GLofk9GVmFYAQYMT1kB7h7GcYzAje7K4lczd7wchCX81zAWZElr4DdtIwiOrC5nEWs+4bw042bHXwozhikKrdJ8Na3q31r8F0dQPtm3sQPGtJlw7TVWU2u/3mEdm1u9O2CTg5RE2tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A6431F000E9;
	Tue,  7 Jul 2026 10:24:21 +0000 (UTC)
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
	tu.nguyen.xg@renesas.com,
	fabrizio.castro.jz@renesas.com
Cc: claudiu.beznea@tuxon.dev,
	linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 0/8] can: rcar_canfd: Add support for Renesas RZ/G3S
Date: Tue,  7 Jul 2026 13:24:10 +0300
Message-ID: <20260707102418.1646159-1-claudiu.beznea+renesas@tuxon.dev>
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

Claudiu Beznea (8):
  clk: r9a08g045-cpg: Add clocks and resets for CAN-FD
  dt-bindings: can: renesas,rcar-canfd: Document RZ/G3S SoC
  can: rcar_canfd: Fix typos in macro names
  can: rcar_canfd: Allow the CAN FD clock to be sourced from fck
  can: rcar_canfd: Do not set registers selecting the CAN mode
  can: rcar_canfd: Add support for Renesas RZ/G3S
  arm64: dts: renesas: r9a08g045: Add CAN-FD node
  arm64: dts: renesas: rzg3s-smarc: Enable CAN-FD

 .../bindings/net/can/renesas,rcar-canfd.yaml  | 17 +++++-
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    | 39 +++++++++++++
 .../boot/dts/renesas/rzg3s-smarc-switches.h   | 12 ++++
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi  | 46 +++++++++++++++
 drivers/clk/renesas/r9a08g045-cpg.c           | 10 ++++
 drivers/net/can/rcar/rcar_canfd.c             | 56 ++++++++++++++++---
 6 files changed, 170 insertions(+), 10 deletions(-)

-- 
2.43.0

