Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648D54E9C2C
	for <linux-can@vger.kernel.org>; Mon, 19 Oct 2026 12:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792411349; cv=none; b=OJGz7MQNuKOXeNndyEXyQrwK9ta5w5Qpo30QhjvE+SkzmOGxTvpjHguNy0ajtemtV3nIV7IxnKtwo9VhlHpHFCm/XIS99SLIFoTlWQy+M4uyFFlWqeepNKgos5rOTWy3XnWzS+k9aDL3r7VwWNidfUGOB78+nq2Zn16s7m4rOno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792411349; c=relaxed/simple;
	bh=DZ2kdbVbYg1pkCIntf+4CYQabG4gloV37Aw1qUTBU/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ku/5zRpJFD+rVmUFcPsHXjQ5377lQIhe8HzdEX+9Lt8i/GM94RrzAfbrF5wSrpZWRGG3FrCeNTMOjBvH6yK9FKk5+iPAhmmMKvhKRJxZV6vCynbAifCDNNR+mQG15RTaa5N+rTVPHsHi6iOS45BL3xQiy99Qj+zedt9N17RIsuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TLvBW5Xs; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLvBW5Xs"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48de6a62a4cso1662494f8f.2
        for <linux-can@vger.kernel.org>; Mon, 19 Oct 2026 05:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792411347; x=1793016147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kXjXKm6gt0TwYUecPdJSnTOm2s6L4h99iDdc56AsF8Q=;
        b=TLvBW5Xs4IKC5mKW6dHnUlt5Ce7Z1M1rVv28tj+Trdzf+jq31ChqnkBeFvA1Le+9Nz
         V9otsN4oy5COrdffcE7x+zgYS0auqIktA9CS/eeCQ0x5n6QUnqdcmROyKeXul/E9Kqzq
         q6FQdLd675orwpTFZoKv5wndYWHD8QtaqzWRMOfVWLsUF+R5vYUAMY6M/EvqgU0tdfd5
         9hWsirQZ4WmqZy0idda96ApymLTOn0R7IyZZUevcO7d2ROeKMQ3wsQWvbi3rvf6C/fyF
         R/YVzYH3lqgcI1Y9DdhDV3mTQ9MlobKfbOH+l9aDyiJrviVX5G6BVp/ygBPol4dos7js
         UzCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792411347; x=1793016147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kXjXKm6gt0TwYUecPdJSnTOm2s6L4h99iDdc56AsF8Q=;
        b=1dBdvFqdWxf+0FW/WJYDMBNUyp+pjyEZen5YRKgNreWE00+MG+nEp1Y2/Qyjhd14Px
         lct8aNEWnooM3p/JFeDgPAZCzq0NFQAqDTXp+C15KHaQUwaqgC6SR8gG0BsrtM9hKTHJ
         JuHKafxq2f4s702SbKM+C+CTnFtDIXv7WAjB1D5C1d6hbYpD7Oyr6xtFvZPs8mQDvg4q
         GK+/z6HYf9AkE9LNlIXLPj+iu5zzL24rQGXcag3EIA8qP5ZQNauqCA7B1aBf0Gam2Qqm
         Xj2MbI4mYBZ9QQye/j2JVw3/klAoONydjcBp+FOYoyYJ/97LFmMViIpEnvX1x0DZ0FlK
         uN+g==
X-Forwarded-Encrypted: i=1; AKwUvByoarN14wHDdv+ZpKZXt3xbhhrO3P1URjUfFaQWA0zOx0/k44laisF4/uQbgkV79uDLRKs5Ypbyw1o=@vger.kernel.org
X-Gm-Message-State: AFq9FYJnWcdjdEbuTz/HywdkIaRT3aR2wgKlOdGPZGTdL4dgfDy/rhzZ
	R90BWKy0klqAXKps31B+PEDokF2pFs1QCfCvoy3W+jM0ZrlLR/deadI5
X-Gm-Gg: AYBFou22TrmhCdvMWQaeQDuXI8V+Zu9AmlkFDZqxnJTT/r/cJEnhQ1Rba6e1uxoyy7g
	H2Lf9vOLtFV2qhQITYlOdrMz+gC6O92dALCD/xQifQbKY/+QbuzpQMhiHs3PsAWqBbatn0hn1j2
	VCD/xnLBuIO0G+eZjssA+XSskl35jXejAzrpgO6vAv0QA4DIrj16yafWckPKMi3R99rUeDB6tJs
	fIrNXcfcZ/QDtwOMc22hh8C5DTIx42i6Gk6qsiZZt/B8mHSohGNwoBGyeTK+1HMg9GBACY1iuF8
	XoOS//bqwoR7dak2KZTVdsdG2XQeV0W0dkbiNl96x5egh28vLpLa+orlVnSJ6lEnHCDj8GLFM2J
	9dqVNhk88s+nDOfgRvqPrxZ1t2YWn0MuXmeeE10GmIHhedUYui8uILTH4hW/jFWSNw8OFjgRgsx
	fjNnvSaAyNh3UB+/C0nYc8j+yhEmSIxwxwiUolqXCWzyNDl0dk/NYzHYTX7LO0N4prMOBZ6Syjd
	cBv9VoTGtKOa4HEBW82aYUQ6xWCFwOe1x4RfUk3yIcLTUa4H8Ap5iw=
X-Received: by 2002:a05:6000:24ca:b0:48e:b32:9d1c with SMTP id ffacd0b85a97d-48e0b329f47mr14655865f8f.19.1792411346320;
        Mon, 19 Oct 2026 05:02:26 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:1439:c865:be43:6676])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfdc4eecasm22400720f8f.13.2026.10.19.05.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 05:02:25 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Biju Das <biju.das@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v5 1/4] dt-bindings: can: renesas,rcar-canfd: Document RZ/G3S has no Classical CAN mode
Date: Mon, 19 Oct 2026 13:02:13 +0100
Message-ID: <20261019120220.166163-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019120220.166163-1-biju.das.jz@bp.renesas.com>
References: <20261019120220.166163-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

The description of the property that selects Classical CAN mode implies
that every supported SoC can operate in that mode. This is not true for
RZ/G3S, whose CAN-FD controller supports only CAN-FD mode.

Update the description to say that Classical CAN mode is not available on
RZ/G3S, so the property is not mistakenly used for that SoC.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v5:
 * New patch.
---
 .../devicetree/bindings/net/can/renesas,rcar-canfd.yaml       | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
index 1a7a9ce45e97..7d3330f8fc1a 100644
--- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
+++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
@@ -146,8 +146,8 @@ properties:
     $ref: /schemas/types.yaml#/definitions/flag
     description:
       The controller can operate in either CAN-FD mode (default) or FD-Only
-      mode (RZ/{G2L,G3E} and R-Car Gen4) or Classical CAN mode. Specify this
-      property to put the controller in Classical CAN mode.
+      mode (RZ/{G2L,G3E} and R-Car Gen4) or Classical CAN mode(except RZ/G3S}.
+      Specify this property to put the controller in Classical CAN mode.
 
   renesas,fd-only:
     $ref: /schemas/types.yaml#/definitions/flag
-- 
2.43.0

