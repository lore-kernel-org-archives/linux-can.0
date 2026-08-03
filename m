Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E7F4137AC;
	Mon,  3 Aug 2026 14:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785767514; cv=none; b=OFSxQKC1cmCCWAbZU3UxMMuf418NOdMFuXFOgNftPJm/3zZWIZXk/NPooK8Cq6ECEY+v2NVTftqEGA4mnmkHemyzUjzDwobRjY27qCVzS7AzzEGVTjpYEjCLPgN9vsXJQieaNbPn9WmGMGQqC39TCRB2i+rc0bCAOSNH9y5SpxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785767514; c=relaxed/simple;
	bh=n7CYJm5kdMQBFLrv52/k0etICMbhcf0XfZdwy5lc2Hg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pyBjLaL0S5wDjC24JP8qO4KyVKqwwPyLK2rxXnRFc3c2NKmZ9+gDpCfgOb+6g8lJWDJoqI0OrDOwqQc4p+ZNdoyPlhRx6jSjjcAG6BkvqpkN7kucPBYwBnQLbWpTFIwoxyoD+VVqkulDYLIRpfpJAZIXzHfTM6aDy935eQQl3No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NAuC+RRQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAuC+RRQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24A121F000E9;
	Mon,  3 Aug 2026 14:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785767511;
	bh=W31cxZYCGxJOkvim9lq2QsMO3LwL9ztN41NLsPb4i+0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NAuC+RRQ86EHwAYekMih1ASmdqGS2SHXRiZ35yO6Q4FIEzo1KSxnnPMdGu8RmL2SN
	 PrL209fH/n0vBxAnuEWEGsRCCfCutpYRvQbLieipMI4THbmSYTJwnqj6tt872i79kI
	 yIgfJY4ZUXeqhdvM2XOQCJDhyVOK7kxButWW6q8OFU3SsI1B1om/AaJDxAS4Igz/ro
	 LUoNX+S8dUe/6teXXdUaN6P2r3xsGUsczh5L8Kg7kzN6wy/iboasRrxsdpk30sELWP
	 Ze2ZeASQEFFsCg3uhS7pBQKQBwoIfy9qD/v1/Y8bp69ngtkHF+zxuizfPmGILEqbVq
	 +OUbKxHHbsW9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: can: add arasan canfd controller
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jisheng Zhang" <jszhang@kernel.org>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, conor+dt@kernel.org, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, robh@kernel.org, "Vincent Mailhol" <mailhol@kernel.org>, devicetree@vger.kernel.org, "Oliver
 Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260803140531.12692-2-jszhang@kernel.org>
References: <20260803140531.12692-1-jszhang@kernel.org>
 <20260803140531.12692-2-jszhang@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 14:31:49 +0000
Message-Id: <20260803143151.24A121F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The schema uses `additionalProperties: false` instead of `uneval=
uatedProperties: false`, which breaks property inheritance from `can-contro=
ller.yaml`.
- [Medium] Missing `clock-names` and `reset-names` in the `required` list, =
and missing `minItems` constraints.
--

--- Patch [1]: [PATCH 1/2] dt-bindings: can: add arasan canfd controller ---
commit 282ace981cf63f65fd400dda84f1806d370fbc9b
Author: Jisheng Zhang <jszhang@kernel.org>

dt-bindings: can: add arasan canfd controller

This commit adds device tree binding documentation for the Arasan CAN-FD
controller.

> diff --git a/Documentation/devicetree/bindings/net/can/arasan,canfd.yaml =
b/Documentation/devicetree/bindings/net/can/arasan,canfd.yaml
> new file mode 100644
> index 0000000000000..a120c11ce3045
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/can/arasan,canfd.yaml
[ ... ]
> +allOf:
> +  - $ref: can-controller.yaml#
[ ... ]
> +  clocks:
> +    maxItems: 2
> +
> +  clock-names:
> +    items:
> +      - const: can
> +      - const: sys
> +
> +  resets:
> +    maxItems: 2
> +
> +  reset-names:
> +    items:
> +      - const: can
> +      - const: sys
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - resets

[Severity: Medium]
Should clock-names and reset-names be included in this required list? A dev=
ice
tree omitting these names might pass validation, but could cause the driver=
 to
fail during probe when requesting clocks or resets by name.

Also, should clocks and resets specify minItems: 2, since the definition
expects two distinct items for each?

> +
> +additionalProperties: false

[Severity: Medium]
Should this use unevaluatedProperties: false instead? Since the schema incl=
udes
can-controller.yaml via $ref earlier in the file, using additionalPropertie=
s:
false will prevent the inheritance of valid standard properties from the
included schema.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803140531.1269=
2-1-jszhang@kernel.org?part=3D1
