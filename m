Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AB62D7DEA;
	Mon, 14 Sep 2026 01:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789349985; cv=none; b=ozCBxLvTxp9Y3SRh0uVy9oAkCvpFl+w+Vzwlx4rBOlIGx13ryv4V7Hba2tS34yzQr2bA8HErXBeqVFUIxlc71svRjcLCvkVFaT48nrsR1X5Fw0p+Xc1TNpCzL3A1IPTVH8alZlk4lWSm+xOrXS6c2KshDXn8ogKjA1D8RgdPKQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789349985; c=relaxed/simple;
	bh=6VJ+vJST6YIAIEzImd/v7GKX92KtVouyHF5m4Gg78HI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X5DdBulvJTKyCWjBsyrLeNJOa2aeyxVeBRtwhF80pNKRJXEAqGx+GL1LABtsinLerPeNfHQi+qF6GVzW1Ri79NotuJkIVW6yDqLdnrB3rwjA090ruiZuxEYLv/piE3hJAGLkIOdRj7By226Pk7XHYhgw76UyCg3HMohUodfgmSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2veLJnh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2veLJnh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAFD81F000FF;
	Mon, 14 Sep 2026 01:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789349984;
	bh=xjA7VHxfZ5Xgosn1zN+pG4Gpue9lni7K182In4vQe6s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B2veLJnhtqKMwOElmZvN1LQD6m7bGl4QqgKPKiestOD8mmZ3386yC64h/Wb0xCNxn
	 mIFdq1zB/Ccr46kbjpi/DJYcE7u2D372Y9OMW/PucpG5hi0uH1YW8sBD/yu0cmOW+S
	 Ee1kz/Zu1jue2B7/RUtmCdJ7pszubFZbyqO62n5HP1SrUQOVC2PYXYBbXJlJpLjv7f
	 P3pP/cvJ60aR601Thy9zIRnHPT0w8FqVe1v3MoQdqNGlKIUghSskbsGN/sJI6csx6v
	 fr+/5JLnrXBVwY0QoOEkxsvEQybBoAnyJmfSdrUo5EZ9E7pwyCCONsIzj09oZr870q
	 IRI8APIF8T82A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dt-bindings: net: can: convert ifi_canfd to DT schema
Reply-To: sashiko-reviews@lists.linux.dev
To: Quchaosheng <quchaosheng000406@163.com>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, robh@kernel.org, devicetree@vger.kernel.org, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, conor+dt@kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, linux-can@vger.kernel.org
In-Reply-To: <20260914013138.392969-1-quchaosheng000406@163.com>
References: <20260914013138.392969-1-quchaosheng000406@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 01:39:43 +0000
Message-Id: <20260914013943.EAFD81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Incorrect use of `additionalProperties: false` with an `allOf` `$re=
f` breaks schema inheritance from `can-controller.yaml`.
--

commit fca96562b6a6638d3bb9a003f449b39969264629
Author: Quchaosheng <quchaosheng000406@163.com>

dt-bindings: net: can: convert ifi_canfd to DT schema

This commit converts the IFI CAN-FD controller binding from a free-form text
file to a YAML device tree schema and references the common
can-controller.yaml schema.

> diff --git a/Documentation/devicetree/bindings/net/can/ifi,canfd.yaml b/D=
ocumentation/devicetree/bindings/net/can/ifi,canfd.yaml
> new file mode 100644
> index 0000000000000..72f2b934c727b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/can/ifi,canfd.yaml

[ ... ]

> +allOf:
> +  - $ref: can-controller.yaml#
> +
> +properties:
> +  compatible:
> +    const: ifi,canfd-1.0

[ ... ]

> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +additionalProperties: false

[Severity: Low]
Does using additionalProperties: false here break the schema inheritance fr=
om
can-controller.yaml?

Under JSON schema rules, additionalProperties: false only evaluates
properties explicitly defined in the local schema file. It ignores those
evaluated via an allOf reference, meaning any standard CAN properties
inherited from can-controller.yaml will cause device tree validation to fai=
l.

Should this be unevaluatedProperties: false instead?

> +
> +examples:
> +  - |

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914013138.3929=
69-1-quchaosheng000406@163.com?part=3D1
