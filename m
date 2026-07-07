Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB30B3E0223;
	Tue,  7 Jul 2026 10:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783420244; cv=none; b=dvDbd1GzX0sejkM5xSlIlxvs+sZlEMuG9mR+pRRuyeDBcr3NdglLJtVBNJETyt8heSGoUk9B5hKHhb85fvmSm+kSn/vo3Zt312lT8qwu07O1BQIj8SmcVj5pU6o+yPW63Qk5gsbN1gWwcj/qyNd5rIEZbLvLQgpfPnuFMe5moZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783420244; c=relaxed/simple;
	bh=Fh2562xFR+b06IGSG+Y7DjNpBurAZZCDNxPIXMo1afY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gSgs5IIlnTBRcpLCDUEJa7DN1h5bcB0KEI1DlmdJhQcUEX964FqAM4c/AKpkBE3DZJSL88kcAh5xJLGA7OHa7otnYmG+LCC0TKUhHfxdQO7xmJiLigXDhtoG6EvM7Gyg2+YqsPEstvWhp30VHE+eDitArjK7C7QeXU5Ob5RubeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DIE7F4Bc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DIE7F4Bc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 021DE1F000E9;
	Tue,  7 Jul 2026 10:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783420240;
	bh=S1/77vz/t24hjbhg9+zyUG6PBcvJkSVfavbNXHyn8UY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DIE7F4Bcigvhkseol1CH+AicaEkLL4dURZLPET9MQYlNr2AtWwUlVYZTVQdnd/iif
	 brJwS/PVdyOo/hShtLx3sxSU7DIuyRZoUELfd3F60/0nnMtyLdaj4RxApFV1snWgh3
	 E56SCW6vdZAxPDEMydoXD9NiGjb8zC/MmUc1pTPCo6C0Mz9xoEx6afyCWaRWMiaBiX
	 EZROQM1E7OFVaTcyaMWfGSybPxuA3M1eItYC66jXW3yrOId1HbPGonWgL7SvZqHdLl
	 QInUhDRAz8npuvF/yBnoqj0VZzjyTThI3MnvGkwDnUNX6CY558opXi0YCCVj5lXuTY
	 ecnzyjnpfxc3g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/8] dt-bindings: can: renesas,rcar-canfd: Document
 RZ/G3S SoC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea+renesas@tuxon.dev>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, robh@kernel.org, conor+dt@kernel.org, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org, devicetree@vger.kernel.org, wsa+renesas@sang-engineering.com, "Oliver
 Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260707102418.1646159-3-claudiu.beznea+renesas@tuxon.dev>
References: <20260707102418.1646159-1-claudiu.beznea+renesas@tuxon.dev>
 <20260707102418.1646159-3-claudiu.beznea+renesas@tuxon.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 10:30:39 +0000
Message-Id: <20260707103040.021DE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The schema fails to forbid the `renesas,no-can-fd` and `renesas,=
fd-only` properties for the RZ/G3S (`renesas,r9a08g045-canfd`) SoC, allowin=
g unsupported hardware configurations to pass schema validation.
--

--- Patch [2]: [PATCH 2/8] dt-bindings: can: renesas,rcar-canfd: Document R=
Z/G3S SoC ---
commit fc07d92ff1acfa102fb8f08fa8b6ff1a0537c592
Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

dt-bindings: can: renesas,rcar-canfd: Document RZ/G3S SoC

This commit documents the CAN FD controller found on the Renesas RZ/G3S SoC.
It updates the bindings since the RZ/G3S provides only two channels, suppor=
ts
only CAN FD operation, and does not require assigned-clocks properties.

> diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd=
.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> index b9d9dd7a79676..f8b4d3dd54afc 100644
> --- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> +++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml

[ ... ]

> @@ -350,6 +352,17 @@ allOf:
>        properties:
>          reset-names: false
> =20
> +  - if:
> +      properties:
> +        compatible:
> +          not:
> +            contains:
> +              const: renesas,r9a08g045-canfd
> +    then:
> +      required:
> +        - assigned-clocks
> +        - assigned-clock-rates
> +

[Severity: Medium]
Since the commit message states that the RZ/G3S supports only CAN FD operat=
ion,
should the schema also explicitly forbid the renesas,no-can-fd and
renesas,fd-only properties for the renesas,r9a08g045-canfd compatible?

Without an if-then block restricting these properties to false, the schema
will incorrectly validate device trees that specify these unsupported modes.

>  unevaluatedProperties: false
> =20
>  examples:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707102418.1646=
159-1-claudiu.beznea+renesas@tuxon.dev?part=3D2
