Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6950F35C699;
	Thu, 17 Sep 2026 06:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789626666; cv=none; b=NimM57o8VR7WdnalAO+TKUEqmu9aB/b22nizFHf8dPoa67LhFEmXaX92RcVZGeMR05FDJjqZuwx2SK9SjtYqAdSZqW9QKJ/iWDyqtwMqsYlXbSuBQztlZtikkWSqRdMEfiiipEsZswnS3Soxcoe9HmJODQQzNVx/g+ry5g9Tg5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789626666; c=relaxed/simple;
	bh=tTVM1jLfRNY37fl5JvEzSfDoHNbkv1u/f/ZS0UGevr0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Tv7C4D8HkB8NMW0sfxDNlErd4w3lmjoqxZcukQhVxDWH5qPiisN8abRK7fof1eMrqys0lAnHrSA+ugL4+8V4pt8QoLmuJIIQtOZsWNTEsaBODHZ6J/cgAYnA6QbEECKGr1QL29C2B0sgbQZqHlNGCQvgE23Yvnsbs73stcYLKdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P7CoEPiG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7CoEPiG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B4C11F000FF;
	Thu, 17 Sep 2026 06:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789626665;
	bh=lZ0P7JoG/WX4jFFjip5SEmtVz8eifXIGiKCOcQKKBOc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P7CoEPiG2h+BsAnh1drpXOUaFrA7WVKnHJ74S/VavvrfPm7iZ2Ki1WqNXIjsWIe9g
	 UXRnnFOX/VyHwGnWN6aqZf1mY9jAyvsT2fW4dRt8wgrorT1hPQaDf3O8jmMZFw2SNg
	 Yys9kbQQu7NPjOfQxRA2dgTCSkmfkp2eqDuN0vEwGZHtx7X1bsTkcuTSsPwWXQu9vj
	 XBVbTzaU4UjIf7g0GwakPHfJxEVX+Y2DOKhO2WiSVHHYnAcvQgizbj4NATEuQ91bZm
	 ugWkepQ3nZYcZDI51dSDHMXnkkRUU3nzprVDwUxltnhvrN+NrlerWmOIKMvQDxkKRB
	 TiXe4ZZ7bw6Uw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: phy: ti,tcan104x-can: Document
 Microchip ATA6563
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marek Vasut" <marex@nabladev.com>
Cc: conor+dt@kernel.org, "Vincent Mailhol" <mailhol@kernel.org>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, linux-can@vger.kernel.org, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, robh@kernel.org, Frank.Li@kernel.org, imx@lists.linux.dev, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, devicetree@vger.kernel.org
In-Reply-To: <20260917062543.534416-1-marex@nabladev.com>
References: <20260917062543.534416-1-marex@nabladev.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 06:31:03 +0000
Message-Id: <20260917063104.7B4C11F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] dt-bindings: phy: incomplete schema validation for microchip,ata=
6563
--

commit e1e7d148b2a5e6742f485d13055f3692d10dbf6a
Author: Marek Vasut <marex@nabladev.com>

dt-bindings: phy: ti,tcan104x-can: Document Microchip ATA6563

Microchip ATA6563 is High-Speed CAN Transceiver with Standby Mode.
It is pin-compatible with TI TCAN1042 and has a compatible programming
model, therefore use ti,tcan1042 as fallback compatible.

> diff --git a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml b=
/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> index 9f5c37ca6496a..75c276548e122 100644
> --- a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> +++ b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> @@ -18,6 +18,7 @@ properties:
>        - items:
>            - enum:
>                - microchip,ata6561
> +              - microchip,ata6563
>                - ti,tcan1051
>            - const: ti,tcan1042

[Severity: Medium]
Will this compatible string bypass the constraints enforced in the allOf bl=
ock
below?

Since microchip,ata6563 is defined as an array item here, the compatible
property will be an array at runtime (e.g. ["microchip,ata6563",
"ti,tcan1042"]).

Looking at the allOf conditional block for ti,tcan1042:

allOf:
  - if:
      properties:
        compatible:
          enum:
            - nxp,tjr1443
            - ti,tcan1042
            - ti,tcan1043

This block uses an exact enum match. In JSON Schema, an array value will not
match this enum of single strings.=20

Does this need to use contains: enum or contains: const to properly apply
constraints (like #phy-cells: const: 0) when a fallback array is used?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917062543.5344=
16-1-marex@nabladev.com?part=3D1
