Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795704378;
	b=h3oYKBNRi7KY0rJ+G+Tj69SqisYdR0KTNo44x0nRx7yfdarvoQj3EKD/Xu0A7rUUQpQ8
	 U+xzmSCpx0U2Bw1aAHW6yB+k+jzeEFMUMlGCKJuwATPFC3trgc2NhD9DRJzIJo2UEvmH5
	 +/gP2FEJrZpbwpJvHviR2ARELT5mRLhgTVGkmUdTA/XZ2GFPyw3ZHAuPJ2cCFhKq3hsdp
	 DLFNnmnA7tPcfe2FpcmuxfunHATwcAROIKGQTn229jg4snv4M3Am21kuKWehAAOXRrqO4
	 4zLBNQl7rVPCmDy+3Z43BD6gP1tO+jOFtCNpoYHjIdwv1Qhfa5FOq4Br6zLgEUeCdqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795704378;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=FQqYJqwtBrP6h9ufZuOBMWa2CJjZkqf6/Q6UP5ZZSYo=;
	b=kObkQoKBxT/e7x9gQujNKSJ/5Db2O3qQJX55pYynDsU5stHRL19GIKxB25+9Pb2epn+M
	 OTOIUInieis4/K6+wzToh5ggYT5Kp0DXt3FKKi5Cx1kfn2pixfJOYJr5wfrETJD9GxyGP
	 aGXjXGWg8aeE0g2haLFEuUqAeytZD8r72Ou6aZpnW/xq71SI87qyxKiZZUZ+XE881Ik6N
	 eH6+XB28i5UlwWsRzZb6I6Kj0Tuk3cAdcrpRgzpdnlmlBevmZo6yLwLVB8pNWdTGnMgcB
	 pH45Out/I651XMwnMdwE1aMya/ssgqB+Q0ooG+fFUeYfLKmIFtz7rRw41x8M4keiQlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W4lEEzGm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531C6606A321;
	Thu, 26 Nov 2026 14:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W4lEEzGm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390BB1F000C6;
	Thu, 26 Nov 2026 14:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795704378;
	bh=FQqYJqwtBrP6h9ufZuOBMWa2CJjZkqf6/Q6UP5ZZSYo=;
	h=From:To:Cc:Subject:Date;
	b=W4lEEzGmFvg7p7zf8qNUuB16MRSJ2bsA92X0kKu9U7Q6n5JA9cGJeEJs15r0MU118
	 wtYlscmBCGZZoWzhuN3fq0kzm7vS5QhCOXMlop5WXm3qgju08tGVRHf5tZwMgqCbVr
	 dVFqimnITuu6qXT2+BarE9LzO8hWiuUonvsp4V2P3biP+9wITMTWCu0R2MFwU77ZjB
	 akU4lxUZb1EbR0pEenQceDCSFV7OH+uhPKoVICghqafMwBr3nf39nB2q/q4TYMiIVP
	 722+uGX8iEucFmHo3iy6aJ+URvO19hh8cUUxg8B8NPpXmlvyjxox0JG1Tk2zYubYY8
	 a2dmD6i7QnLpw==
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
Subject: [PATCH v2 0/4] can: rcar_canfd: Add R-Car X5H support
Date: Thu, 26 Nov 2026 15:46:05 +0100
Message-ID: <cover.1795703576.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
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

	Hi all,

This patch series adds support for the CAN-FD interfaces on the Renesas
R-Car X5H SoC to the R-Car CAN-FD driver:
  1. The first RFC patch documents support for CAN-FD on R-Car X5H,
  2. Patches 2-4 add driver support for CAN-FD on R-Car X5H.

Changes compared to v1[1]:
  - Drop platform integration patches not intended for the CAN tree,
  - Improve RFC question,
  - Add Reviewed-by,
  - Update new user.

CAN-FD channels 1 to 6 and 12 to 15 have been tested on the Ironhide
development board using canfdtest and an oscilloscope.

Thanks for your comments!

[1] "[PATCH 0/9] arm64: renesas: r8a78000: Add PWM support"
                        (yeah, wrong component ^^^, sorry for that)
    https://lore.kernel.org/cover.1793278754.git.geert+renesas@glider.be

Geert Uytterhoeven (4):
  [RFC] dt-bindings: can: renesas,rcar-canfd: Document R-Car X5H support
  can: rcar_canfd: Add Runtime PM support
  can: rcar_canfd: Make clkp local
  can: rcar_canfd: Add support for R-Car Gen5

 .../bindings/net/can/renesas,rcar-canfd.yaml  | 84 +++++++++++++++++++
 drivers/net/can/rcar/rcar_canfd.c             | 47 ++++++++---
 2 files changed, 120 insertions(+), 11 deletions(-)

-- 
2.43.0

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
