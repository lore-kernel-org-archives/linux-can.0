Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86F04E5334;
	Mon, 19 Oct 2026 12:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792412043; cv=none; b=KESO3RS4Gh3G1LYf7WA8Kp9qJzoL9T/+1bvglHQcvvvmaHQ+9bpTxMP3KrZWsUPLhE3n1qfD2hjNin5quN2xMoNP4rg0D9GbJusiwNpt/0R5LvZ80HYuxdAUnxlRcwyCfDQtGNBKMQlMCzXgZt/1k2T+FNLv/EK4UBjfPVpxgyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792412043; c=relaxed/simple;
	bh=AYRSMic3LaoLZ/qdbv+3inxM1mzKMpieZZq3I6RfW5U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NB1jgs5ojzT+hTRC+MjusXsH+6+jktZXd0afIyyndqvfWZbwoKe98tSNlaa4yY4ZdtvuZ9zormRjqQ3MowgfGNHXk9INeF2guVL1p0ycO5qm9hLdoRqOW7d+3pz6G/cquvAQ9z4Y2+aXeOklS7QWkXaGqAS9hmfLQp37g0R/uiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4Iz/vCD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4Iz/vCD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 204381F000C4;
	Mon, 19 Oct 2026 12:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792412042;
	bh=yWTI9pJXuL8mjNlBexYwiNzXFCGapO59WeYYXPZiovk=;
	h=From:To:Cc:Subject:Date;
	b=H4Iz/vCDw5y7vKTtJUjx/6Qi9xMWGCOq1peQltvu8iNe13K5gu7DBLaX21IbURTrs
	 4aNVLPYkY87Ap0rtuqogx3CCi6o6gDGb3UNlQhB5CY2P8czSODmKmKDMxtcf012x+2
	 6HARDxSiyixYjNdnfL9GksxqoW9T4a1WGVbpMYLd1+48K+BGK8WP6PEY4TjS6WwWJA
	 ZH5HLFsFqUgNINfX2Qr6pipX95zieoWn2KTicTS8KJW4jrMaqE2k3ZKJmSAjRzFnZp
	 OZMxdxSDwW7q2bSXrnKdhQ0eimQfliEueEV4F5BEtXvzGxEmwlKay4cSaclCLWr35N
	 6fFNNSO2Peh2A==
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
Subject: [PATCH 0/2] can: rcar_canfd: Follow-up patches for RZ/G3S
Date: Mon, 19 Oct 2026 15:13:54 +0300
Message-ID: <20261019121356.2421761-1-claudiu.beznea@kernel.org>
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

Series addresses issues pointed by sashiko. The dt-bindings concerns
will be addressed by Biju as discussed [1].

Thank you,
Claudiu

[1] https://lore.kernel.org/all/TY3PR01MB11346BB7B48E311542BD7226A86982@TY3PR01MB11346.jpnprd01.prod.outlook.com

Claudiu Beznea (2):
  can: rcar_canfd: Check can_clk request for errors
  can: rcar_canfd: Use DT clock names in the probe message

 drivers/net/can/rcar/rcar_canfd.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

-- 
2.43.0

