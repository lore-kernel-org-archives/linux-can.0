Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792571533;
	b=TFUYAy1jKpEfqUKI2/E42bCJe9RifA/G5IVRKDVAgH+YIjCbKIuXO1hG2lNy0pTnyJ8L
	 afugRI9+TXPE/fVczT1lG/8DM7bdIooNmTS6BiVhoWjwKbAbASeQhay/I8LhVpeKZd1+C
	 vAcxTRBtsSvpyykPcbVlPkwVt6aeHMtPV1WUvbRaVB3oHnOkcvj2XWHRofQiTTHsVerVU
	 CwIyQ6JmAs+z0kzbki1Kfa25bDo/NZ22NFtvohuyqMFcEfvgTmKiwm5C7eW6wECMPG95F
	 ayc7jyD97M/N/c/FIvLdlUsKrV7qaY2nbbWrdGRRYaEfRzK4u4z2jWD2s7m3vTGYilQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792571533;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=E9qEf0UbcRJY+bJhc+G+4o5adeArJnR2v1vDZogjWd8=;
	b=dvH31SZs/Jv0ZtPg7stENUqcl5/jq/RE3yV7Opr75jztA70RGMamW4DEeneurEXiPJcn
	 A3X4yT3ba+X/MWxGoD/KSiCVXDpbgIkTLcGD2dvXGjg9EsO/IB6nSGKXGeXEpi4TIZCH2
	 SJCQ/KM/huyGULtbKy1A7xCHtGQmJkBw4c0JoRwzST5uWioiFtqtZM3BVZ5YsrDOc2D/1
	 jWwp3u3dRS++MRNFQkbWX6jqz2PZAjpG69QWfN4pEgGrbvoXd7/1w622r3uO3b86vDoYT
	 x+ZpfbnzKkqM0l+Y5WRW4VLNd+PRGvQJCkKfLPS50bGcmi8d/xKlwExT6q5O+7itohA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WGFF3bMt;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4B8606A32A
	for <linux-can@vger.kernel.org>; Wed, 21 Oct 2026 08:32:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D4B8606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WGFF3bMt
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a1e3098ee2so4653045e9.3
        for <linux-can@vger.kernel.org>; Wed, 21 Oct 2026 01:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792571531; x=1793176331; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E9qEf0UbcRJY+bJhc+G+4o5adeArJnR2v1vDZogjWd8=;
        b=WGFF3bMtm3L2MCSgwqcPw1tNav2ZALn+Bngjm7GzzU4hX4q4RFGq5Gh3EsljyRJhJa
         gtEWV6CgGhtpoiTgz9qTowDGguEKIa+2tayYDkpS90FzRRrZSJvCOFEudeBClvsy5lt7
         2JB/aFBbGlRaPK8x9nVwMz2H238wFAY7uPHdHELygn2b/dTFpTIKWA3fLZowaUi++RKg
         XCulAINhyz2YcU+IGGuldgjZ7HjlEqrRuiLpptIGFApm4NrWr7E4iB9wgmoAEvEMnN7w
         L59y/D3AOS+o54FnC0I8vh1c8PN4ebggO1cczYXpMOM94PAS/h6vBk1gXPImOb/2+5Tq
         d0zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792571531; x=1793176331;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E9qEf0UbcRJY+bJhc+G+4o5adeArJnR2v1vDZogjWd8=;
        b=kedE56KaubfHMTbBWESzj1U6XN+J2CJdMzO2FsdXdfVdi1MvDiXOrSur1vBRiacNi0
         pppBwXzarAAZsNGKHcBZ8V3dZNP3vtxvJEQUPquN0vboygahqIXDysISw1ymt4w1gk9Y
         JzJgOwIMH3n5foalrdgFM1qbCTb7DRh1X/A0Su2W4fQj1Uj6Xx88jXcS84Z+WRvebERT
         0c2ksbHXb6hHZLOWjK8ZdTl/z2N1ID97Dq218rtR5+sw2SW7SBW4ah+wPbAY4HPM9C8N
         1ggE3X0HlvxYt5kXLokYbNE/c341zgP4gz28kGKZn4mdT/lIhAC40w1iLYFE/ZW2s7lx
         bwdg==
X-Gm-Message-State: AFq9FYJm8cB/LSkI4b2PCAcCWOXelFD2HY1HqhPLQjj5eYlFrKlfqjfJ
	Z7MTD4IY1gCmdMXFGo2nHS2/vHTV48nuT8hohithjomR9DZqIqYwzNiz
X-Gm-Gg: AYBFou2xUR/B3I2LXP/4nc0n1dMWxyx6J4dK1xrQC59gzRXZOV3Li7xoC7fT+chEisl
	a886FTPo6kznkQUb87G/mMrxa5vC8XD/Xt0ll2PlNKfESwJjl1EQgvamqGrSrdozrZ/xbaQ1Nnm
	BaPZmPEKKlEb/gxWDc3Lwvg+hgpGZBi3Xn/xtx0VJQvdhrIcrPc5XES4pdbGQ2YNBEKZzBq+FwC
	8N5bg3EXjUK71808RkhEORGCzmGGWEJ5XlTkOX8rb4DCuKrIHyZ8wNz9IsEP8jZuHT3HFQKX2It
	z4gJmnbItgeWaZ8AStBOz28nZU7F8jjrnj2YeH0JmM4WkBT/2RyGVzTfR/dkxOgh4otpfTKFRix
	AdBQYz/bhetm5neJlrV/Ah+fNdOaBHqeyHarv0VstXQqboNs9a6dRymD63agxSN4E2tsip00qnw
	D+whXpSAJCyIu58l2Z7wT7ZlUqDqZyHZjZkaEpSe29k/4m/h+BwVsXK/dJwlJD/TuOaHYwgbYgm
	fRaO+fmogWUpYAsYkQcHCpj+q+Ten7nYSRUvqiD8jhyrQYtaNmXQFtsHNbHlzvqwfm2j+eIGpaO
	bgtPBSTqFyAaxTGzHTLYEOCMbn+hb1n4T3P7kCZ/Ybr3
X-Received: by 2002:a05:600c:a08:b0:4a2:1cc:6551 with SMTP id 5b1f17b1804b1-4a201cc6bf3mr744085e9.35.1792571530863;
        Wed, 21 Oct 2026 01:32:10 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:23c4:a702:d301:39f4:e118:e272:79d8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fcd2eff9sm36250145e9.4.2026.10.21.01.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 01:32:10 -0700 (PDT)
From: Biju Das <biju.das.au@gmail.com>
X-Google-Original-From: Biju Das <biju.das.jz@bp.renesas.com>
Date: Wed, 21 Oct 2026 09:32:01 +0100
Subject: [PATCH v6 1/4] dt-bindings: can: renesas,rcar-canfd: Simplify
 renesas,no-can-fd description
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-canfd_rzg3l-v6-1-b4abfdba8e70@bp.renesas.com>
References: <20261021-canfd_rzg3l-v6-0-b4abfdba8e70@bp.renesas.com>
In-Reply-To: <20261021-canfd_rzg3l-v6-0-b4abfdba8e70@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, 
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc: linux-can@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Biju Das <biju.das.jz@bp.renesas.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792571528; l=1656;
 i=biju.das.jz@bp.renesas.com; s=20261020; h=from:subject:message-id;
 bh=bfMkHO6jG7ziyusENgghR+SzKGm1uT2oifSo7PJ+O9Y=;
 b=DR8TBLyVCK+H8wHymBT4C1B4+LTr7fsl5n2fceAH5tJAmlGsaw+sKf91GRt2XbvtV/5/OMa3H
 W80PWXcyrgPDfy2c1Dpe52/N9O1lj5l+Dm3X1ujbTjxfStsZMFqRQyp
X-Developer-Key: i=biju.das.jz@bp.renesas.com; a=ed25519;
 pk=yzD2T1OLS3lEYflbk64xhLlxhk75lZ+NoOtkTOqrlVw=

The description of renesas,no-can-fd lists the operating modes
(CAN-FD, FD-Only and Classical CAN) and which SoCs support each one.
This is not accurate for every supported SoC, for example RZ/G3S, whose
CAN-FD controller has no Classical CAN mode.

Drop the mode list and keep only the statement of what the property
does, so the description no longer implies that all SoCs can operate in
Classical CAN mode.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v5->v6:
 * Updated commit header and description
 * Simplified renesas,no-can-fd description by removing the mode list and
   keep only the statement of what the property does.
v5:
 * New patch.
---
 Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
index 1a7a9ce45e97..81674ea4bef4 100644
--- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
+++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
@@ -145,9 +145,7 @@ properties:
   renesas,no-can-fd:
     $ref: /schemas/types.yaml#/definitions/flag
     description:
-      The controller can operate in either CAN-FD mode (default) or FD-Only
-      mode (RZ/{G2L,G3E} and R-Car Gen4) or Classical CAN mode. Specify this
-      property to put the controller in Classical CAN mode.
+      Specify this property to put the controller in Classical CAN mode.
 
   renesas,fd-only:
     $ref: /schemas/types.yaml#/definitions/flag

-- 
2.43.0

