Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CD933064D;
	Mon, 14 Sep 2026 03:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789355400; cv=none; b=l4f4/cYtdTnpAql3IoVt+dl8jt3iDknLUATlElNJnFYjpy0U8iadZMIJZm6COyXNV8NRD7i85EkB7rNyH9O438NL7Bg7fLpMPwaRdc1PcXEbvZQNeUPYkBqsq2G0h3zC9COUXadBfRh3WA7qVXw698SKcnOdLQwyWk8GR/1BNu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789355400; c=relaxed/simple;
	bh=E38+ONzJA8KOp82T4Sk9BxAyKUep766g0CU1bnHUkSE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aLKNQdTNJNO+NE3yMCGbkpA8hZSC86eCbFJjvsB+4wO0/wEDqOa1FOU3BWeaZv7f/iF8LYwb6kssmrdPcPQ0hdxYeSX7uDf6O7T6QlHBtQ0xPh9IDjOLVZqWiTUbA8l6OdWZIxhT83WOkRm4dn982nV6zCTzDtMlMC91jauSkr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oiZkXQGH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oiZkXQGH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85EF31F000FF;
	Mon, 14 Sep 2026 03:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789355395;
	bh=atyCgMvkkfN3Z1WAqVD6F5klWeSOeqjOXh5bSjoVR0c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oiZkXQGHOyLiwHphFiWEDrMRDtxLu+Nb/6Y8Rjn/S2wFOgM+ua8biWRMeWQj+Tc4f
	 pqlnLCFo5K0UcdlNMl9sRzWnx374bT/qEFj0rz1C+K8FeTXivUM4ch1SM7YH4/psBw
	 jZ49SVQbOGm/eTyRb0tqZiswJjfU+IZ1YQqK4vSXT1+LXpDZhQusTj61MBABLCt2rw
	 HoNpTbQsLESolheCYJHacCAnS/pP+mrdxIpJaTLmRP0zKq5Gmi3UV2q0GK5UGgMo2E
	 YMKTyKwnt2Oyp2bXhoDm7aTCNagOCIhXO1h8EjZvFHPssUWm1+wZ6mZ2tGefxAMFQs
	 mC0pdy3sb8/+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dt-bindings: net: can: bosch,cc770: Convert to DT
 schema
Reply-To: sashiko-reviews@lists.linux.dev
To: Quchaosheng <quchaosheng000406@163.com>
Cc: conor+dt@kernel.org, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>, devicetree@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, robh@kernel.org, "Oliver Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org
In-Reply-To: <20260914030215.437602-1-quchaosheng000406@163.com>
References: <20260914030215.437602-1-quchaosheng000406@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 03:09:54 +0000
Message-Id: <20260914030954.85EF31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] platform_get_irq() error code is shadowed.
- [High] Incorrect check of uninitialized field priv->cpu_interface instead=
 of pdata->cir.
--

commit 534a229fcad73012a922f469773dd3f6d658bb9e
Author: Quchaosheng <quchaosheng000406@163.com>

dt-bindings: net: can: bosch,cc770: Convert to DT schema

This commit converts the Bosch CC770 and Intel AN82527 controller binding f=
rom
free-form text to DT schema. It also references the common can-controller.y=
aml
schema and documents additional properties used by the driver.

> diff --git a/Documentation/devicetree/bindings/net/can/bosch,cc770.yaml b=
/Documentation/devicetree/bindings/net/can/bosch,cc770.yaml
> new file mode 100644
> index 0000000000000..448d5b4f74b57
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/can/bosch,cc770.yaml
> @@ -0,0 +1,109 @@
[ ... ]
> +properties:
> +  compatible:
> +    enum:
> +      - bosch,cc770
> +      - intc,82527

[Severity: High]
This is a pre-existing issue, but while looking at the platform data
initialization for this controller, I noticed that the clock divider logic
seems to check an uninitialized field.

In drivers/net/can/cc770/cc770_platform.c:cc770_get_platform_data():

	priv->can.clock.freq =3D pdata->osc_freq;
	if (priv->cpu_interface & CPUIF_DSC)
		priv->can.clock.freq /=3D 2;
	priv->clkout =3D pdata->cor;
	priv->bus_config =3D pdata->bcr;
	priv->cpu_interface =3D pdata->cir;

Since priv->cpu_interface is assigned pdata->cir after the check, is
priv->cpu_interface unconditionally 0 here due to the zero-initialization
during allocation? If so, will this prevent the frequency from being correc=
tly
halved when CPUIF_DSC is set in the platform data?

[ ... ]
> +  reg:
> +    description:
> +      Register window of the controller. On a PowerPC system the control=
ler
> +      sits on the local bus and the property describes the chip select, =
the
> +      address offset and the size, the size usually being 0x80.
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing the interrupt
handling property, I noticed the driver shadows the error code during probe.

In drivers/net/can/cc770/cc770_platform.c:cc770_platform_probe():

	irq =3D platform_get_irq(pdev, 0);
	if (!mem || irq <=3D 0)
		return -ENODEV;

If platform_get_irq() returns a negative error code such as -EPROBE_DEFER,
the function unconditionally returns -ENODEV instead of the actual error.
Could this permanently prevent the device from probing if its interrupt
controller is initialized after the CC770 driver?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914030215.4376=
02-1-quchaosheng000406@163.com?part=3D1
