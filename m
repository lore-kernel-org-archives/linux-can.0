Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794399618;
	b=AT6pkJ8DA3JaG2OgJEOXa+IJtcMiK9nQ6++PK7IobS0jJMdeb8g7kLd/k9/fGdxUh1wW
	 dpG5ZxqHQHK8GZk67CAyhB70vMOajU3DUQ3tckcwJTmWpQ1HNDqkwUlcbgHE9o/zn4GyL
	 G8FLLlGKSV+jZ96NU7BrfeQqZPgvPKUvgnGrkjsOvQ0h/SGhS22polpALKPZfCTFffqN4
	 1c1GKgh3+dDMjzAcdvS3poRQH16Vq1ezuXQBkKJ0Yu+2pcj+ZLrQcfu3nF8p/VD1dSiDm
	 ub0il12obU9WtPFjCfY+zRyaQ+DskDbOZbRHqQqBG4SMJhtMnHkmDP353TsX/Rl3Ayw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794399618;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=hWb41iZm0R0yNMhR+sLYT85PthxOfiiXrl7+TyvZ8Ws=;
	b=K5TN3D5YP5vQoD599rvkqlW0nx20TU5JP9Jk8od+0SS9rZ3NAG1Jqi1bQPuvhImc4HhK
	 Ttx8RwQHvz2VhojMpgN8EG3dQfZmbJ0de6hYpUeJ9Po/apZn6YfX4r+phmGYijvN+NJ3h
	 fdaPvrOWj1jBD/lxdiVa9tgDj/Kep5uw/50Ft/uhcAs3sc5Do0F/OUAab8KU9i/ArBiX6
	 mZrntBt+BdWCimy/8A+JGmBilJJfYF2AD4JrosSbB+bOsHLPr8A9R7mVmurUJK9az/rSB
	 3od3FS9+1rljd6NnREJ+lfgiJS9LJC+gFfmxuOoWRHTNWBVFoXhuGViiBX67mt9+Jhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PH+MMIFM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C501606A324;
	Wed, 11 Nov 2026 12:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PH+MMIFM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F8851F00A0A;
	Wed, 11 Nov 2026 12:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794399617;
	bh=hWb41iZm0R0yNMhR+sLYT85PthxOfiiXrl7+TyvZ8Ws=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PH+MMIFMmcPHKErf4C+zzI47QjpQwLz1C6t57pLcEpI0W7IHd4tdDu0LtDKvV0VZn
	 wIiEc4GFQntpE85LKtbUSTkYHZjAzzpM8mFTCj1WMHd2CKmg6k2Py9e9k0lkEcrSz+
	 hmRujoGfpg885TfrT8GzO/KkoAcR5StZvAyzKYPnDaHvmRFepognOdXIQfQ5E5Is4O
	 p4W+/EXE/ij34EYfuqMbcjMcWn6w4m/reojFrLmR05pFFmMaYhGimuGr+bwbxlEeUJ
	 njlZi9wvsUKqSD6Y0vnObhdTDXGq0ahgPyiLCYe99DNAKSH8GG+lta6iSLE4AFrEgY
	 lpa3qbGdN8NVg==
Subject: Re: [PATCH net-next 01/12] dt-bindings: can: renesas,rcar-canfd:
 Document RZ/G3S SoC
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de,
 claudiu.beznea.uj@bp.renesas.com, geert+renesas@glider.be
Date: Wed, 11 Nov 2026 12:20:16 +0000
Message-ID: <179439961681.2199510.4253042970495028693@kernel.org>
In-Reply-To: <20261110115112.3807247-2-mkl@pengutronix.de>
References: <20261110115112.3807247-2-mkl@pengutronix.de>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] In this patch's tree state, the binding documents
  `renesas,r9a08g045-canfd` as a standalone compatible with no fallback,…

Pre-existing issues:
- [Low] The concern says the RZ/G3S compatible `renesas,r9a08g045-canfd`
  gets the unchanged top-level `clocks`/`clock-names` schema, and that…

--

dt-bindings: can: renesas,rcar-canfd: Document RZ/G3S SoC

This adds the renesas,r9a08g045-canfd compatible for the RZ/G3S CAN FD
controller and adds it to the existing allOf conditional blocks. It also
moves the assigned-clocks/assigned-clock-rates requirement into a new
conditional that exempts RZ/G3S, and disallows renesas,no-can-fd and
renesas,fd-only for RZ/G3S.

Link: https://patch.msgid.link/20260902141544.565763-2-claudiu.beznea+renesas@tuxon.dev

> diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> index b9d9dd7a79676..bbaaef8f4282e 100644
> --- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> +++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> @@ -13,6 +13,7 @@ properties:
>    compatible:
>      oneOf:
>        - enum:
> +          - renesas,r9a08g045-canfd        # RZ/G3S
>            - renesas,r9a09g047-canfd        # RZ/G3E
>            - renesas,r9a09g077-canfd        # RZ/T2H

[Severity: Low]
At this point in the series, does anything bind to this compatible?

The patch adds it as a standalone string with no fallback. However,
rcar_canfd_of_table[] in drivers/net/can/rcar/rcar_canfd.c has no
renesas,r9a08g045-canfd entry yet. An RZ/G3S node that passes validation
would therefore not probe.

A later patch in the series, "can: rcar_canfd: Add support for Renesas
RZ/G3S", appears to fix this by adding:

    { .compatible = "renesas,r9a08g045-canfd", .data = &r9a08g045_hw_info },

[ ... ]

> @@ -350,6 +352,20 @@ allOf:
>        properties:
>          reset-names: false
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: renesas,r9a08g045-canfd
> +    then:
> +      properties:
> +        renesas,no-can-fd: false
> +        renesas,fd-only: false
> +    else:
> +      required:
> +        - assigned-clocks
> +        - assigned-clock-rates

[Severity: Low]
This is a pre-existing issue, but should this block also narrow
clock-names for RZ/G3S? The top-level clock-names still accepts both
forms:

  clock-names:
    oneOf:
      - items:
          - const: fck
          - const: canfd
          - const: can_clk
      - items:
          - const: fck
          - const: ram_clk
          - const: can_clk

No allOf entry picks one of these forms per compatible.

The RZ/G3S CPG only supplies the peripheral and RAM clocks. Even so, an
RZ/G3S node that uses the canfd form would still pass dt_binding_check.
The driver would then get a NULL clk_ram from devm_clk_get_optional(),
and the RAM clock would never be enabled.

The renesas,rzg2l-canfd and renesas,r9a09g047-canfd compatibles already
have the same gap.

Requiring the third can_clk entry looks fine, though. The internal
divider setup can be described with a 0 Hz can_clk fixed-clock, as in
r9a07g044.dtsi. The fck fallback that "can: rcar_canfd: Allow the CAN FD
clock to be sourced from fck" adds to rcar_canfd_probe() then handles
that case.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261110115112.3807247-2-mkl%40pengutronix.de
