Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023AD372EE2
	for <linux-can@vger.kernel.org>; Sat, 10 Oct 2026 13:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791639840; cv=none; b=eLo9UScIgFlEGFlfwFXWizzF90x11t1mUSJoQ1BHpYTafZsJV3ZdeZ395RXe8vUUHfV8ItnX3Mfi4CM8wJCMoA29TZYp1RKGuw1FZUxme7mDHr4/1q98moXVnxNYeD3UvxHlNmhrnEc7tc/lEF3Tyb/qEImU0GeRZlvk+h+1RUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791639840; c=relaxed/simple;
	bh=B0ssl/JwQRRVGzCQVd9sZLqbh5cBQsg8cPg0bHribSI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Z07JHsteWWTXt5xG98JvCSNSu60/8+Lt937dtDi+FdENdL78xJohV+rhYAawepq4lxvohN3s0oLm1He2Lz+ubYy5iI+QymEtDCycYp8CvtGUGYcrdxhodnwo+kpxUHYEAxBNeza4k0kFY+eQ576jc22+UW+UgwPZNbSmstHMJl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MR+vNvYh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MR+vNvYh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 474EF1F00893;
	Sat, 10 Oct 2026 13:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791639838;
	bh=92nD4XZqZ5YrNzoemJVInCvs0/555ntcPjbCSawH1kg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MR+vNvYhbCZr21i2vcPDsm+GYDmn6k9WQnUAvR1OsL5a2B2Bsk5y6PoEzz19IBLtO
	 l2vxX+ELDOsNsjQqGZg8uyR0epZvD7qKfqyztot3QiMolrLASaP6o2DFEJ4xBhXtjP
	 0+GAY0p/uXTiTBnum/oUN3b9lB80u4Nqp20PDFp6WDvuntAz6MYTjHDc3C341PIRYx
	 re0aNxY9NszRUX3X2Ouzoz07sb8jnXwjrRTWv1TQ2VuEQHcHyOcJ4x7DespMRmO4Gd
	 tOJQQAOeUXyW+oL3SpdaVfx76dR23poz2Qy9mbgfpGJHDU2kwvgGY6fX7tx45Ej31t
	 I0YPa0jWF0G+g==
Message-ID: <sashiko-outbox-166606@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 16/37] dt-bindings: can: renesas,rcar-canfd:
 Document RZ/G3L SoC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>
In-Reply-To: <20261009134323.64064-17-mkl@pengutronix.de>
References: <20261009134323.64064-1-mkl@pengutronix.de>
 <20261009134323.64064-17-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 13:43:57 +0000
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] dt-bindings: missing resets requirement for renesas,r9a08g046-ca=
nfd
- [Low] dt-bindings: can: missing maxItems constraint for r9a08g046-canfd i=
nterrupts
--

commit 36441ccce0b87ca8f2e74ff4324b679b4b9479d1
Author: Biju Das <biju.das.jz@bp.renesas.com>

dt-bindings: can: renesas,rcar-canfd: Document RZ/G3L SoC

This commit documents the RZ/G3L (R9A08G046) SoC support. It specifies the
new compatible string along with its unique hardware constraints, including
limits for interrupts and CANFD channels.

Link: https://patch.msgid.link/20261001075742.21961-2-biju.das.jz@bp.renesa=
s.com

> diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd=
.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> index bbaaef8f4282e..cef20f0403715 100644
> --- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> +++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml

[ ... ]

> @@ -292,6 +293,25 @@ allOf:
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
> +
> +        interrupt-names:
> +          minItems: 11
> +

[Severity: Low]
Does this block also need maxItems: 11 for interrupts and interrupt-names?

The root schema defines a list of up to 20 interrupt items. Without an
explicit maxItems constraint in this conditional block, it appears device
trees could define up to 20 interrupts and still pass validation, missing
the enforcement of the 11-interrupt hardware limit.

> +        resets:
> +          minItems: 2
> +

[Severity: Medium]
Since this variant specifies resets constraints, should
renesas,r9a08g046-canfd also be added to the existing allOf block that
enforces resets and reset-names as required properties?

There is an existing conditional block in this file that requires these
properties for related variants:

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

Omitting the new variant from this shared block means device tree nodes for
the RZ/G3L variant missing the mandatory resets and reset-names properties
will silently pass schema validation.

> +      patternProperties:
> +        "^channel[3-7]$": false

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009134323.6406=
4-1-mkl@pengutronix.de?part=3D16
