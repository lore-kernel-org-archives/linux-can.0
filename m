Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67493537C4;
	Thu, 17 Sep 2026 02:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789613953; cv=none; b=WcdcSPfCaCknJsS4L4+oNVx387VDyMdcqWmPwJRjmhUuSyp5KA6ekCR1uJjtYq6WUPyw5pJrmlZuo+3FjugWt4sQ5jDWX/iJvEnLl3f6f19GzokjM3IIXXSfUXBHNWQHp4tSoG3bUJl681rXSmfOuLb5KVQOAUHRQ2z2wbA8uz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789613953; c=relaxed/simple;
	bh=loSfsaSo2z6GCqWYlZHpUUn9M9Lz798g4gUKQUmFWTQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WbHOsN6PKU/B2418tpy6svohGd8q+J5kpex4SFk9tNGDGUFNiqJtTITVvQBKaqGp3MJmz7pgOe7sPx8Wtu8OC2DgRg4U/zNHQ3GJiqtFulVJuLYDPlhmvqYuEUh57Pq/ItoPUI6ngFgchFDIfHyD8HL+YNouaHGUK2ZtCsUvF3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QalsnYhV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QalsnYhV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F6DB1F000FF;
	Thu, 17 Sep 2026 02:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789613944;
	bh=SUlUNogsCAp1s6TNzxD2nbnikTabLl16pZ9rfap3+uY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QalsnYhVB5tJ+uDxj+e/mFUx3dPpDyu6zieC8cVauPOdN9Az6CUz/Htq5+Bj+2Qz0
	 iwGLXX/7f/7Bhm0AdRtJI+dpYQpYqIWCC5fLa8LJ92xl97m3m1xJiTP1JSh2mWkVfr
	 t2+yxcQ9oNt+4JCCpSKPoS3bJKQgGb08YOshKEkeynrhdJTRNOb3pXWrbR/LSwolVe
	 kgHzUIh2DOJr+Ys7CJgAMkFQOtFzTPTBUxG5EsdQ68VC0hackzYJa0wCCU1Z62BPq8
	 A4xl/t99zC8jZPRKDiKg6F8waWPJQcPKULKnULfa/v8oD50TVioH4NyilyGlZbLLwv
	 U++i+shPa9DUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] arm64: dts: imx95: Add support for Data Modul
 i.MX95 eDM SBC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marek Vasut" <marex@nabladev.com>
Cc: conor+dt@kernel.org, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org, devicetree@vger.kernel.org, Frank.Li@kernel.org, robh@kernel.org, imx@lists.linux.dev
In-Reply-To: <20260917024805.517030-3-marex@nabladev.com>
References: <20260917024805.517030-1-marex@nabladev.com>
 <20260917024805.517030-3-marex@nabladev.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 02:59:03 +0000
Message-Id: <20260917025903.8F6DB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] net: incorrect Ethernet PHY reset polarity permanently holds PHYs =
in reset
- [High] gpio: PCAL6524 interrupt polarity mismatch causes interrupt storm
- [Medium] regulator: reg_panel_vcc missing enable-active-high property inv=
erts enable logic
--

commit 89d12be71b001da7aa525de48a7d723a37bc3741
Author: Marek Vasut <marex@nabladev.com>

arm64: dts: imx95: Add support for Data Modul i.MX95 eDM SBC

Add support for Data Modul i.MX95 eDM SBC board. This is an
evaluation board for various custom display units. Currently
supported are serial console, ethernet, eMMC, SD, SPI NOR,
USB host and PCIe.

> diff --git a/arch/arm64/boot/dts/freescale/imx95-data-modul-edm-sbc.dts b=
/arch/arm64/boot/dts/freescale/imx95-data-modul-edm-sbc.dts
> new file mode 100644
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx95-data-modul-edm-sbc.dts

[ ... ]

> +	reg_panel_vcc: regulator-panel-vcc {
> +		compatible =3D "regulator-fixed";
> +		regulator-min-microvolt =3D <3300000>;
> +		regulator-max-microvolt =3D <3300000>;
> +		regulator-name =3D "PANEL_VCC";
> +		gpio =3D <&i2c2_gpio_expander_20 17 0>;
> +		/* Disabled by default, unless display board plugged in. */
> +		status =3D "disabled";
> +	};

[Severity: Medium]
Will this configuration cause the generic GPIO framework to force an
active-low polarity on the V_LCD_EN signal?

The gpio property omits enable-active-high. The gpiolib framework
(of_gpio_quirk_polarity in drivers/gpio/gpiolib-of.c) enforces an active-low
polarity for regulator-fixed if enable-active-high isn't explicitly set.
This seems like it could drive the panel VCC regulator low when it should be
enabled.

[ ... ]

> +	i2c2_gpio_expander_20: gpio@20 {	/* U12 */
> +		compatible =3D "nxp,pcal6524";
> +		reg =3D <0x20>;
> +		#gpio-cells =3D <2>;
> +		gpio-controller;
> +		#interrupt-cells =3D <2>;
> +		interrupt-controller;
> +		interrupts-extended =3D <&gpio5 11 IRQ_TYPE_LEVEL_HIGH>;

[Severity: High]
Will configuring the shared PCAL6524 interrupt line with IRQ_TYPE_LEVEL_HIGH
result in an interrupt storm?

The PCAL6524 features an open-drain, active-low interrupt output pin that
rests at a high logic level. Since the interrupt controller is configured to
trigger on the high level, won't it continuously trigger on the idle state?

[ ... ]

> +	i2c2_gpio_expander_21: gpio@21 {	/* U14 */
> +		compatible =3D "nxp,pcal6524";
> +		reg =3D <0x21>;
> +		#gpio-cells =3D <2>;
> +		gpio-controller;
> +		#interrupt-cells =3D <2>;
> +		interrupt-controller;
> +		interrupts-extended =3D <&gpio5 11 IRQ_TYPE_LEVEL_HIGH>;

[Severity: High]
Does this expander have the same active-low interrupt output pin behavior,
and should this also avoid IRQ_TYPE_LEVEL_HIGH?

[ ... ]

> +	i2c2_gpio_expander_22: gpio@22 {	/* U13 */
> +		compatible =3D "nxp,pcal6524";
> +		reg =3D <0x22>;
> +		#gpio-cells =3D <2>;
> +		gpio-controller;
> +		#interrupt-cells =3D <2>;
> +		interrupt-controller;
> +		interrupts-extended =3D <&gpio5 11 IRQ_TYPE_LEVEL_HIGH>;

[Severity: High]
Does this expander also need to be updated to match the active-low interrupt
output?

[ ... ]

> +&netc_emdio {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_emdio>;
> +	status =3D "okay";
> +
> +	ethphy0: ethernet-phy@1 {	/* KSZ9131RNXI U20 */
> +		compatible =3D "ethernet-phy-id0022.1640";
> +		reg =3D <1>;
> +		interrupts-extended =3D <&gpio1 10 IRQ_TYPE_LEVEL_LOW>;
> +		reset-assert-us =3D <1000>;
> +		/* RESET_N signal rise time ~100ms */
> +		reset-deassert-us =3D <120000>;
> +		reset-gpios =3D <&i2c2_gpio_expander_22 4 GPIO_ACTIVE_HIGH>;

[Severity: High]
Is GPIO_ACTIVE_HIGH the correct polarity for the KSZ9131RNXI PHY reset?

The PHY uses an active-low physical reset pin. Because the framework drives
the active-low pin low during deassertion, configuring this as
GPIO_ACTIVE_HIGH appears to permanently trap the ethphy0 interface in reset.

[ ... ]

> +	ethphy1: ethernet-phy@2 {	/* KSZ9131RNXI U22 */
> +		compatible =3D "ethernet-phy-id0022.1640";
> +		reg =3D <2>;
> +		interrupts-extended =3D <&gpio1 10 IRQ_TYPE_LEVEL_LOW>;
> +		reset-assert-us =3D <1000>;
> +		/* RESET_N signal rise time ~100ms */
> +		reset-deassert-us =3D <120000>;
> +		reset-gpios =3D <&i2c2_gpio_expander_22 5 GPIO_ACTIVE_HIGH>;
> +	};

[Severity: High]
Should this reset-gpios polarity also be updated to active-low to properly
deassert reset for the ethphy1 interface?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917024805.5170=
30-1-marex@nabladev.com?part=3D3
