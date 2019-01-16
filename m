From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: [PATCH 01/11] dt-bindings: Add vendor prefix for Silicon Linux.
Date: Wed, 16 Jan 2019 18:37:44 +0000
Message-ID: <1547663874-29411-2-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1547663874-29411-1-git-send-email-fabrizio.castro@bp.renesas.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1547663874-29411-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Cc: Biju Das <biju.das@bp.renesas.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert+renesas@glider.be>, Thierry Reding <treding@nvidia.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Kevin Hilman <khilman@baylibre.com>, Johan Hovold <johan@kernel.org>, Lukasz Majewski <lukma@denx.de>, Michal Simek <monstr@monstr.eu>, =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Ben Whitten <ben.whitten@gmail.com>, Fabrizio Castro <fabrizio.castro@bp.renesas.com>, Chris Paterson <Chris.Paterson2@renesas.com>, linux-renesas-soc@vger.kernel.org
List-Id: linux-can.vger.kernel.org

From: Biju Das <biju.das@bp.renesas.com>

Add Silicon Linux to the list of devicetree vendor prefixes.

Website: http://www.si-linux.co.jp

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 4b1a2a8..02a7037 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -344,6 +344,7 @@ sgx	SGX Sensortech
 sharp	Sharp Corporation
 shimafuji	Shimafuji Electric, Inc.
 si-en	Si-En Technology Ltd.
+si-linux	Silicon Linux Corporation
 sifive	SiFive, Inc.
 sigma	Sigma Designs, Inc.
 sii	Seiko Instruments, Inc.
-- 
2.7.4
