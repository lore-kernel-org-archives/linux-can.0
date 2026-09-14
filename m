Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB811A7264;
	Mon, 14 Sep 2026 03:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789355532; cv=none; b=LLQuFJzEEt6g0X4KnA8kgwZ60N4FW/GqAZiWapTz2ylrE5q+ZN+9kSPaHhnPdpmxwhwebOTaybZquOP8mzZA+nwbZwnu23ZnF/msbLqHOQRvs2kfvXEvERIvoHlD8NWu1oPcXLOlSWJ1zL7aSYnJZtnO+CDSXVv5sk89dM+mrj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789355532; c=relaxed/simple;
	bh=JCpbPNJ4ufS+L3iuwQQs6flsB885qiGEXXWatxPYBIg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j0jbjvrP+OS1F2OKBsvS2MlaYqxtKnIsWHTNhD4Qokj+XlR50jeF3uTb6TuoPV8yfp6uZlkHlBaZPs1uMy3XT8vjevjEHa/3JWc7U99prE3yjHV5NDBNQ11LrROmK7TKoSG2CBVwGy3Ql72afEPQpkuAlp4R1S2zAfhxUo6vsfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ok+JEHKR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ok+JEHKR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9DDF1F000FF;
	Mon, 14 Sep 2026 03:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789355531;
	bh=j71IVeff/17cjyhcRu1Mr3KhWr+2RABFaR4FavkQJ7w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ok+JEHKRQlJXVvP5UUywAUze0/8Qkk+FP4iy1dp2EaZicO1tRBOzJM1wH0/QuApkj
	 xDt1ZgEzYO2uGYV4xn8ubUkCzGif+MCBDYZzYeZAk7fdmBQocjv4MVfzIG+xyTOwyS
	 Pg+2HmtDNEIo7qoIHYuvqEhsJIoFhllrUiGhm+gG3kejJbwe+P2khPKj4WLympIcI3
	 S6kBwLscUPacKl7rMDgPBKR8yGXDXwqXRLkJGqUpeZrDVE8fbUAeHdFJggCuJM7dKQ
	 qgHqgbdNypv2j8cdd1jgJkt4PARYlIbTv8cIqRvFRBprzMmXEcR2vYNQKuw7WxQ15X
	 RYxMBN4jCZyJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dt-bindings: net: can: fsl,mpc5xxx-mscan: Convert to DT
 schema
Reply-To: sashiko-reviews@lists.linux.dev
To: Quchaosheng <quchaosheng000406@163.com>
Cc: devicetree@vger.kernel.org, "Marc Kleine-Budde" <mkl@pengutronix.de>, robh@kernel.org, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>, conor+dt@kernel.org, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org
In-Reply-To: <20260914030215.437602-4-quchaosheng000406@163.com>
References: <20260914030215.437602-1-quchaosheng000406@163.com>
 <20260914030215.437602-4-quchaosheng000406@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 03:12:10 +0000
Message-Id: <20260914031210.B9DDF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The schema omits the `fsl,mpc5200b-mscan` fallback compatible st=
ring used in existing device trees, causing schema validation failures.
- [Medium] The schema is missing conditional `if-then` blocks, globally all=
owing properties that are invalid for MPC5200, and failing to mandate requi=
red properties for MPC5121.
--

commit dee9e6a0d172cc57e05eeda41cfef5b093d00d22
Author: Quchaosheng <quchaosheng000406@163.com>

dt-bindings: net: can: fsl,mpc5xxx-mscan: Convert to DT schema

Converts the Freescale MPC5xxx MSCAN controller binding from free-form text
to DT schema. It specifies compatible strings, clocks, clock names, and
mscan clock properties.

> diff --git a/Documentation/devicetree/bindings/net/can/fsl,mpc5xxx-mscan.=
yaml b/Documentation/devicetree/bindings/net/can/fsl,mpc5xxx-mscan.yaml
> new file mode 100644
> index 0000000000000..108f225f91963
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/can/fsl,mpc5xxx-mscan.yaml
> @@ -0,0 +1,87 @@
[ ... ]
> +properties:
> +  compatible:
> +    enum:
> +      - fsl,mpc5200-mscan
> +      - fsl,mpc5121-mscan

[Severity: Medium]
Will this strict enum cause validation failures for existing device trees?

Existing device trees, such as arch/powerpc/boot/dts/mpc5200b.dtsi, use a
fallback array pattern:

    compatible =3D "fsl,mpc5200b-mscan", "fsl,mpc5200-mscan";

Should the schema allow fsl,mpc5200b-mscan as well, perhaps using an items
list to support the fallback?

[ ... ]
> +  fsl,mscan-clock-source:
> +    description:
> +      Clock source used for the controller. Valid values are "ip" for th=
e IP
> +      bus clock, "ref" for the reference clock (XTAL) and "sys" for the
> +      system clock. "sys" is only available on MPC5121. When the propert=
y is
> +      absent, an optimal clock source based on the system clock is selec=
ted,
> +      falling back to the reference clock.
> +    enum: [ip, ref, sys]

[Severity: Medium]
Should the sys value be restricted to the MPC5121 variant?

The schema currently allows sys globally, even though it is invalid for
the MPC5200. An if-then block could be used to restrict this.

> +
> +  fsl,mscan-clock-divider:
> +    description:
> +      Additional clock divider for the reference and system clock source=
s.
> +      Defaults to 1 when not specified.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 1

[Severity: Medium]
Does this allow the fsl,mscan-clock-divider property on the MPC5200 variant
where it does not exist?

An if-then conditional block could also restrict this property to the MPC51=
21
variant to prevent it from silently passing validation on MPC5200 nodes.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts

[Severity: Medium]
Should clocks and clock-names be required for the MPC5121 variant?

The driver probe requires these clocks for MPC5121. Without an if-then block
requiring them, incomplete nodes will silently pass schema validation but f=
ail
at runtime.

> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    can@1300 {
> +        compatible =3D "fsl,mpc5121-mscan";
> +        reg =3D <0x1300 0x80>;
> +        interrupts =3D <12 IRQ_TYPE_LEVEL_LOW>;
> +        interrupt-parent =3D <&ipic>;
> +    };

[Severity: Medium]
Since the clocks and clock-names properties are strictly required by the
driver for MPC5121, does this example represent a functionally broken
configuration?

Because the schema does not strictly require the clock properties, this
example passes validation, which demonstrates that the schema accepts
invalid configurations.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914030215.4376=
02-4-quchaosheng000406@163.com?part=3D1
