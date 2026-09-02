Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65F6353A72;
	Wed,  2 Sep 2026 14:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788358553; cv=none; b=OgsfVC1PFhthsrHn6LgdTgr+JBajNH4+wrhnI53oZmpJqFeOu+pu9Oi4E9jx+h48txZ6jLMFvyx5+elUig3VUIIEtP4nPImw1JKF9PhoO+66DlYLVzJwNGi3NR9jYVN4AWrpFJWJ5jlOuy7gKmtwqPxw9g3uKym8TzFsECL4wOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788358553; c=relaxed/simple;
	bh=9uwyIoafWmTBh7WAeYvtNgKZDHIM9jQDiG0P7YAztX0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DKcmFJT7Zr2ZgHIisULgARmmGd/h2FSRSQE/2DVYDNfTpPyu5aMu6OrWvaSYT84ET99RI8Ee5MZGBfWRtGq70bjCQzdTs6fBVi2XBh1o9wPGjN0B3NmM1u6g0BEjAginO+8i4aO3/8b+3U+/tpMRpT16F0UeAIfWKYXGPsH4fTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03A3F1F00A3A;
	Wed,  2 Sep 2026 14:15:47 +0000 (UTC)
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
Subject: [PATCH v4 0/7] can: rcar_canfd: Add support for Renesas RZ/G3S
Date: Wed,  2 Sep 2026 17:15:37 +0300
Message-ID: <20260902141544.565763-1-claudiu.beznea+renesas@tuxon.dev>
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

Merge strategy:
- patches 1-5/7 should go though the CAN tree
- patches 6-7/7 should go though Renesas tree

Thank you,
Claudiu

Changes in v4:
- dropped patch "clk: r9a08g045-cpg: Add clocks and resets for CAN-FD"
  since it was applied
- collected tags
- s/mode_select_na/fixed_canfd in patch 4/7
- used TCAN1046 compatible in patch 7/7 and adjusted the standby-gpios
  property

Changes in v3:
- addressed sashiko review comments

Changes in v2:
- collected tags
- addressed sashiko review comments

Claudiu Beznea (7):
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
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi  | 45 +++++++++++++
 drivers/net/can/rcar/rcar_canfd.c             | 65 +++++++++++++++----
 5 files changed, 168 insertions(+), 13 deletions(-)

-- 
2.43.0

