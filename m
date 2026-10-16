Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35CE3515DA
	for <linux-can@vger.kernel.org>; Fri, 16 Oct 2026 01:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792115645; cv=none; b=QGxmh+8Z1zXG/qtR0nAh2GiWyfUtd4sKT9N0a4sdOLv8Ch+sX7BQzWPSdM6A7qqKeYHSOIvNuJ4MXw8lqg3pNkYLO29V69OBG6vgnlePzOHnkgRCRI0eNOeIC1J5KDeuf/SF07LwpBkYGXpopRL1SkDri7CFtuMBYB60S9wlSwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792115645; c=relaxed/simple;
	bh=P6+TBLapCuFvxNwJhEumYKMmmXE0UFuxCVhSfevKJFQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=tDrGpWhDsJtAXZD9aR0lFeRDGPKUbgg4u+v5GuoHHQwprvQxuxamZu0M+/GfsjmCaZLPdUQJ+QIrBxzfeFLFeAdS07yi1hEHw9aV/iCbwncYRaqp/N7dhthnKfnnqRDZieFRZsv/UhvIrKqg9htfcBQwhxOSlCZM9ot56KCuTzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+J1gQ7z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+J1gQ7z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A527E1F000C4;
	Fri, 16 Oct 2026 01:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792115644;
	bh=hdge6Cy2whD6vKB3xY1n/iQ+pKQI3yqIn9wfFUCBWIQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V+J1gQ7zr71ACK0TYCgVwIPB14nfb5gv95xa5X4wnDRbhPaun/RS8XQW/xYe2BimK
	 m4HpyVbcDnyJZmEjGdRs4QNAO13wGeo48pShjQpdhFQF+xpD0WpXEi+Vaq41HhwhyY
	 yOyx9hQp4yZS4yzqQ774pNa2c0h5WCWIaP1v0xuDBtT+Ia3P46u4GjNAQxXcfPyarT
	 WaxOYUYMQV6L278n7yMnoK3MjRmaYJep0rBjvbQ/opgEKtb6jV0U5o0ILbM+DNnBRn
	 1GE2ATq3BNfETHziaB+B60C4T8Em0JhkYPQquCK5P/yPz4QJEbZucCiVwwYh/skH2H
	 hQJ6jv2Wo+qFA==
Message-ID: <sashiko-outbox-173581@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 19/37] dt-bindings: can: renesas,rcar-canfd:
 Document RZ/G3L SoC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261015015336.816543-20-mkl@pengutronix.de>
References: <20261015015336.816543-1-mkl@pengutronix.de>
 <20261015015336.816543-20-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 01:54:03 +0000
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] dt-bindings: missing required resets and reset-names for RZ/G3L
- [Medium] dt-bindings: missing maxItems constraint for RZ/G3L interrupts
--

commit 58ac9c18cd2ddefc0f54df00f420c9a823c995ac
Author: Biju Das <biju.das.jz@bp.renesas.com>

dt-bindings: can: renesas,rcar-canfd: Document RZ/G3L SoC

Document the RZ/G3L (R9A08G046) SoC support. RZ/G3L has 11 interrupts and
3 CANFD channels compared to 8 interrupts and 2 CANFD channels on RZ/G3S.
RZ/G3L has 288 buffers in total compared to 192 buffers in RZ/G3S.

Link: https://patch.msgid.link/20261001075742.21961-2-biju.das.jz@bp.renesa=
s.com

> diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd=
.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> index 1a7a9ce45e977..4b94bc8d911be 100644
> --- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> +++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml

[ ... ]

> @@ -294,6 +295,25 @@ allOf:
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

[Severity: Medium]
Does this block also need a maxItems constraint?

The top-level schema permits up to 20 interrupts by default. While this
block correctly specifies minItems: 11, it omits maxItems: 11.

Could a devicetree node providing between 12 and 20 interrupts silently
pass schema validation instead of being properly rejected?

> +
> +        interrupt-names:
> +          minItems: 11
> +
> +        resets:
> +          minItems: 2

[Severity: Medium]
Should the new compatible string be added to the shared required properties=
 block?

This block indicates the hardware requires 2 resets. However, the new
compatible string was not added to the existing shared if-then block that
enforces resets and reset-names as required properties:

  - if:
      properties:
        compatible:
          contains:
            enum:
              - renesas,r9a08g045-canfd
              - renesas,r9a09g047-canfd
              - renesas,rzg2l-canfd
    then:
      required:
        - resets
        - reset-names

Could a devicetree node missing the mandatory resets and reset-names
properties for RZ/G3L silently pass schema validation, allowing incomplete
hardware descriptions?

> +
> +      patternProperties:
> +        "^channel[3-7]$": false

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015015336.8165=
43-1-mkl@pengutronix.de?part=3D19
