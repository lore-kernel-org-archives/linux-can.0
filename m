Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794397896;
	b=V15LJSGW18FP1rf1qkGnt7aaoABqk2TQF1+/3mNxjepcF5crdkX2TKLk4FZe21dSRN/M
	 Q8t5sWlpQXg54RegLBf3x9fyDmm8SLxLinMSOJZCpp0xGsMaypS1u1dAy/5+6C2yq4ERe
	 o3K2pjD2AFPWfZT191StHpY+hpaaGtmYvXEMIG/HFw35EwlQRh/5bssOq0GmgGnHHTXPN
	 Pa149mnXN2IhWZh54Ygz70IynpHL6TUONHyflfDWVqMjhFyyslMKFM9E1HRh2ctcZxZQQ
	 wGCY6CZ+zIBOoIm9wgMnyRHlZ4miMJmaDd29oo46d6heq3MDSLFkg3SIESUcNNg48sA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794397896;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BA5xKpEyM+wV2CJ+5Hyc6QTfJhokxNDs7kB38q2FA80=;
	b=QoDEgCzcqohuzy3xYcQZ6jypbfKJB3/k1+7h12CrSsC4tMSajxbykZdQrEwqPv7L87y9
	 SchR/ID8C9jV2pDbvnVVFU/yKkxvYXR/p/HqyUgBlfv3fjtnsny+ijXhyYdpP2zK6q22p
	 0lFFGvgHdrQ5yt9zdB9ITrKKyP8xMPcvaTqaninO7kmwimUPEj56QrcG92RWKCySP9noU
	 L/73xCX/DQDrnBxpnjXTXU8XWeGJkPEq4IltUYVCA17C2Xk4RlQ05t/JueFf9atcnPHdL
	 4J1aX3NnyltaI2Stn61d0hPcQwQKavXkvjUzUfVcIXSKBBlF+Und64wwBI7jrsYt57w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f1JwPoWY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9004D606A31C
	for <linux-can@vger.kernel.org>; Wed, 11 Nov 2026 11:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f1JwPoWY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0374F1F00A05;
	Wed, 11 Nov 2026 11:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794397896;
	bh=BA5xKpEyM+wV2CJ+5Hyc6QTfJhokxNDs7kB38q2FA80=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f1JwPoWY30TL8KZ5RIlCDD2t+/izdXnYENHXJp4BJbHGhGnNqsAVKXBKHrw264Ese
	 LYzYMh4prhWGz70E+vFJKA2wiHvr4OJ3Xiqz4JAdwfo6rT7Izwyv2r89u4aO35+9wy
	 ZjvyEOupFaWTdF7/rupqvpWBac9hSxiWaEry7WpYyi5G4WA5m8g+bYdvle/2085/DP
	 7mCJwLjc7z+5fbWIBUI+RWsPMvn9Ohqzym9OyqaOKce70xb7GU78mTVb1mjzqshEre
	 PVwS1WuNJw+8xam1+ydmD74pMwlb0HVjuFj8FgVFk9qXFAJXeCvRCO0oU/CheCCEH+
	 dKc1Ire6CK1Vg==
Message-ID: <sashiko-outbox-208913@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 11/12] dt-bindings: can: renesas,rcar-canfd:
 Document RZ/G3L SoC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261110115112.3807247-12-mkl@pengutronix.de>
References: <20261110115112.3807247-1-mkl@pengutronix.de>
 <20261110115112.3807247-12-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 11:51:35 +0000
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

commit b004ab68b21e93b39df6164d000c1b8ef430f90c
Author: Biju Das <biju.das.au@gmail.com>

dt-bindings: can: renesas,rcar-canfd: Document RZ/G3L SoC

This commit documents the Renesas RZ/G3L (R9A08G046) SoC in the
renesas,rcar-canfd device tree binding schema.

Link: https://patch.msgid.link/20261021-canfd_rzg3l-v6-3-b4abfdba8e70@bp.re=
nesas.com

> diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd=
.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> index 81674ea4bef47..dc74377021207 100644
> --- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> +++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml

[ ... ]

> @@ -292,6 +293,27 @@ allOf:
>        patternProperties:
>          "^channel[6-7]$": false
> =20
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: renesas,r9a08g046-canfd
> +    then:
> +      properties:
> +        interrupts:
> +          minItems: 11
> +          maxItems: 11
> +
> +        interrupt-names:
> +          minItems: 11
> +          maxItems: 11
> +
> +        resets:
> +          minItems: 2
> +
> +      patternProperties:
> +        "^channel[3-7]$": false
> +
>    - if:
>        properties:
>          compatible:
> @@ -332,6 +354,7 @@ allOf:
>            contains:
>              enum:
>                - renesas,r9a08g045-canfd
> +              - renesas,r9a08g046-canfd
>                - renesas,r9a09g047-canfd
>                - renesas,rzg2l-canfd
>      then:
> @@ -356,7 +379,9 @@ allOf:
>        properties:
>          compatible:
>            contains:
> -            const: renesas,r9a08g045-canfd
> +            enum:
> +              - renesas,r9a08g045-canfd
> +              - renesas,r9a08g046-canfd
>      then:
>        properties:
>          renesas,no-can-fd: false

[Severity: Low]
This isn't a bug, but allOf now has 15 if-then conditional blocks to handle
differences in interrupt counts, channel counts, resets, clocks, and CAN
modes across R-Car and RZ variants, with constraints for
renesas,r9a08g046-canfd split across three separate conditionals.  Would it
make sense to split the binding into separate schema documents instead of
adding more per-compatible conditionals to this file?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110115112.3807=
247-1-mkl@pengutronix.de?part=3D11
