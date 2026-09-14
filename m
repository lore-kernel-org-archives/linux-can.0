Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94583334C05;
	Mon, 14 Sep 2026 03:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789355585; cv=none; b=A4vuVbkaYnd18nNRp95OxWeZ+pmewNfdNjrICj8C3M5VgVAw2p9BGg5mM1JqkFXfGb4bf7AZ1/Tmb+H6p5DcJuNbFGKW/OJB8mpPejdxc5BPQSK7hWTJiKda9bc0HRnyoLw03o7rcrzLOGu46+TDHnRpuS4DtDd+WnevVvlghs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789355585; c=relaxed/simple;
	bh=Ojfo/geujUkZvfa2rPnctIFifUQhCYPHlrdkA9xooRg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lVIzeDcfHyKt6OgXiGm3i3+UGNCDdid+YDkl1tiyu3fvoIz+i/MuW6s1eox3AjiD7p/7dwZbmc9SEUpO2kAvmjCfswqN5dftthHVmO1QeZPGF2ZDaHyXdYlq3cskeuw0SNEJ6J9lSwaRnFVRsMRLlBm9wXg9Kj1Ll7enJPjJJI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPNwEBrc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPNwEBrc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4E501F000FF;
	Mon, 14 Sep 2026 03:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789355577;
	bh=MbMjd3J+22HTtf4Aljh/JcNDWkAGF+sCL9UYeHltunY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fPNwEBrcsAUdVMwlb7DxCcGZ0THoHH/mrEZa52qsOkpIJz3UFtupTla0kT3ronfX4
	 7g0QEp7I+QzDugiDhGEeiRKtLIpckX8i8ppxLA6yvC071Nzn90ksCGyPH3FOqXCFUk
	 3MU/d5BeRYUYtQ4VCWazB8Vt5/H9d43f7hkD2dPXboavRsBPH4vNXICF4lfti4dRiq
	 Ev78yIfiOEw2FOqlwMaCN9NG5S/+gzgR/oCg9foTGj0xWH7QxTip29adXkjtbJmAhf
	 Fysw4wHuasZdv0a3M7o1CzHadalBm9h0XJRv14/FeXwcHbR/aQ8xTCZ7L2geseHJ3n
	 tebvKs/ZcHoVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dt-bindings: net: can: holt,hi3110: Convert to DT
 schema
Reply-To: sashiko-reviews@lists.linux.dev
To: Quchaosheng <quchaosheng000406@163.com>
Cc: linux-can@vger.kernel.org, "Oliver Hartkopp" <socketcan@hartkopp.net>, conor+dt@kernel.org, devicetree@vger.kernel.org, "Vincent
 Mailhol" <mailhol@kernel.org>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, robh@kernel.org
In-Reply-To: <20260914030215.437602-3-quchaosheng000406@163.com>
References: <20260914030215.437602-1-quchaosheng000406@163.com>
 <20260914030215.437602-3-quchaosheng000406@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 03:12:56 +0000
Message-Id: <20260914031256.D4E501F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] The schema omits a reference to the standard SPI peripheral propert=
ies schema, which will cause valid standard SPI properties (like `spi-max-f=
requency`) to be falsely rejected.
- [Low] The maximum supported clock frequency is documented in the schema t=
ext but not formally enforced as a JSON Schema constraint.
--

commit 708f7e5cdeffdf3f0881283fe507970525fe6ae2
Author: Quchaosheng <quchaosheng000406@163.com>

dt-bindings: net: can: holt,hi3110: Convert to DT schema

This commit converts the Holt HI-311X stand-alone CAN controller binding fr=
om
free-form text to a DT schema. It references the common can-controller sche=
ma
and explicitly models the alternative between a provided clock and a clock
frequency fallback.

> diff --git a/Documentation/devicetree/bindings/net/can/holt,hi311x.yaml b=
/Documentation/devicetree/bindings/net/can/holt,hi311x.yaml
> new file mode 100644
> index 0000000000000..8c433fcac4a5a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/can/holt,hi311x.yaml
> @@ -0,0 +1,80 @@
[ ... ]
> +description:
> +  The Holt HI-3110 is a stand-alone CAN controller with an SPI interface.
> +
> +allOf:
> +  - $ref: can-controller.yaml#

[Severity: Low]
Does this schema need a reference to /schemas/spi/spi-peripheral-props.yaml=
#?

Because unevaluatedProperties is set to false at the bottom of the schema,=
=20
and the SPI peripheral properties are not pulled in by can-controller.yaml,
valid SPI properties like spi-max-frequency will be treated as undocumented
and falsely rejected by dtbs_check.

> +
> +properties:
> +  compatible:
> +    const: holt,hi3110
[ ... ]
> +  clock-frequency:
> +    description:
> +      Frequency of the clock feeding the CAN controller, in Hz. Used when
> +      no clocks property is provided. The maximum supported frequency is
> +      40000000.
> +    $ref: /schemas/types.yaml#/definitions/uint32

[Severity: Low]
Should this property include a formal maximum: 40000000 constraint?

The description mentions the 40 MHz limit, but without the JSON Schema=20
constraint, device trees configuring a higher frequency will silently pass=
=20
schema validation even though the driver enforces the limit at runtime.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914030215.4376=
02-3-quchaosheng000406@163.com?part=3D1
