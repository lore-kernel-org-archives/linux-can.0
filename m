Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794397892;
	b=J5fOPBuT3z/Dm2DjkBC8Yq403NDfdbwByX6i46QgFJuQdPxK8IlCS2Cxp1CjJD94AU8n
	 /EQIdUWE84IeBt2WkTwvSS5LGmfFItDAbEL5YiP918SSaIfyTEY+7cGbNNw4LtlweqHHG
	 uaau7xyRMIogEWk1i23fsEdnoRGJZSu4oklh+Bji5FnIhANptm2NHPlPpqToKCw3+5qpW
	 0ytOonE/n/PqEPpqGo1g0XlFrKSgVGIY6MpfQ6mVgVT3oUGl3XuplUC6UmwVxfJLM/ivp
	 weSDCAzJVIu4yUM2IFzPY9ud20DsGAq7aomCyXqBGA+5ohawGp6I+99B4f0KHos02qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794397892;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xcNGcLzP7gRi2GTstTJvGvQ9ZWuPAPIlvJ50jcQNH/Y=;
	b=pOU0F3zWUJIYDhH1+6q19HDggUKhDI2ByQ5bzf6rZEkwdq2pDt6i2is+eBHJibDWKqYw
	 ZiJoTujaQWILlTLi97ab5bBJJ0l25jRSxHuZtBlSfX5sxyWuOcSLLOji94Noc+y3Xj4oj
	 vPwgvGxou8u/+gLoelzkRSflJgn12ojtsCbS1hTNFoerDwrQ+/dHxoibIbTtfVeZlb8b5
	 79Fh9SOhpvg/kmi55zOTPVvbB2j55R7nwc6eSCLUz79S77qFiulM99iEO0CvlwHsx4fxk
	 LQgndWaZ61WBNnuEKiYU58J8sQC8h0YrIRkk3N8YrYAsMv/DhkgpcMy/1HkK86iWaVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ksonBc15;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A703C606A31C
	for <linux-can@vger.kernel.org>; Wed, 11 Nov 2026 11:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ksonBc15
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F29DB1F00A05;
	Wed, 11 Nov 2026 11:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794397892;
	bh=xcNGcLzP7gRi2GTstTJvGvQ9ZWuPAPIlvJ50jcQNH/Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ksonBc15V4tVX6u2wOA4tqJy0sGY5NRs6Qdw2lJf6Yj2ltLrFIVLN3FdIhC2aC+yy
	 LQls2b3OJeu3xphGcKb1T2fPOzdwHrcDjrBmWKXzAEgoPmpv/JqarWGzjt4nDLycRS
	 ILeeUKrO23jIUsdaX+GG+kZo3MUioU1U74pl2sTM7njRJWoXiYQYtp4poV/Nt3Vk9E
	 aIg0GclKdhbgKiaYtNjaUS2z8/ttgHZ82TvyGwblayMU8BUZ+Y2sJvDhrsQaARFGwQ
	 +rodQnDR2XEtfvLcqfizWCyf3n+H95mvmSKuZz2dsGRuEwMnWUGsk1aKJSQ1gcty/N
	 NyraQg0ADqNVw==
Message-ID: <sashiko-outbox-208903@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 01/12] dt-bindings: can: renesas,rcar-canfd:
 Document RZ/G3S SoC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261110115112.3807247-2-mkl@pengutronix.de>
References: <20261110115112.3807247-1-mkl@pengutronix.de>
 <20261110115112.3807247-2-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 11:51:31 +0000
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] dt-bindings: can: renesas,rcar-canfd: unwieldy per-compatible
  conditionals
--

commit 5428d12c7ddcccf614fa8a3231cb0f54fd8f9de0
Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

dt-bindings: can: renesas,rcar-canfd: Document RZ/G3S SoC

This commit adds the renesas,r9a08g045-canfd compatible string for the
Renesas RZ/G3S SoC and updates the conditional schema constraints for its
channel, reset, operating mode, and clock differences.

Link: https://patch.msgid.link/20260902141544.565763-2-claudiu.beznea+renes=
as@tuxon.dev

> diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd=
.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> index b9d9dd7a79676..bbaaef8f4282e 100644
> --- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> +++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml

[ ... ]

> @@ -185,8 +186,6 @@ required:
>    - clocks
>    - clock-names
>    - power-domains
> -  - assigned-clocks
> -  - assigned-clock-rates
>    - channel0
>    - channel1
> =20
> @@ -198,6 +197,7 @@ allOf:
>          compatible:
>            contains:
>              enum:
> +              - renesas,r9a08g045-canfd
>                - renesas,rzg2l-canfd
>      then:
>        properties:
> @@ -266,6 +266,7 @@ allOf:
>          compatible:
>            contains:
>              enum:
> +              - renesas,r9a08g045-canfd
>                - renesas,r9a09g077-canfd
>                - renesas,rcar-gen3-canfd
>                - renesas,rzg2l-canfd
> @@ -330,6 +331,7 @@ allOf:
>          compatible:
>            contains:
>              enum:
> +              - renesas,r9a08g045-canfd
>                - renesas,r9a09g047-canfd
>                - renesas,rzg2l-canfd
>      then:
> @@ -350,6 +352,20 @@ allOf:
>        properties:
>          reset-names: false
> =20
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
> +
>  unevaluatedProperties: false
> =20
>  examples:

[Severity: Low]
This isn't a bug, but adding renesas,r9a08g045-canfd requires touching
three separate if-then blocks in allOf and adding a 14th conditional block
with an else branch to move assigned-clocks and assigned-clock-rates out of
the top-level required list.  With allOf now spanning 14 per-compatible
conditional blocks to toggle interrupts, resets, channels, operating modes,
and clock properties across variants, would it be cleaner to split the
diverging variants into a separate binding schema document instead of
adding more conditionals here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110115112.3807=
247-1-mkl@pengutronix.de?part=3D1
