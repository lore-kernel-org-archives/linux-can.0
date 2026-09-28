Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94DE35C1A9;
	Mon, 28 Sep 2026 21:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790629490; cv=none; b=UZCMREN08JHbTbDAZWjflzlggshC1eMA4yW0invcqD6UvAQrcAEsX/RGg6aHLyJ/uMUG7dcp8muY7/Uo9tNBT/yNzNoHtV8vw3PJoXEyIktX1Z2nHHYPrJj3vmXv5NpUNKQE0VJqZdLfK8xPyG4bWAqrNDUu8w9mSJDJFb2oaiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790629490; c=relaxed/simple;
	bh=4WfkTemOrC8BBo5bBRSx0nAks/yfqsLlJHoK1NSB8Hs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LrFAfQ/9Da30Umxfm8Ul8f+N/+Pkk2KFFkJAH9JpDXOKWyQKYovdNrB6RtDAbIcXIWxpNEki0NoR+DMuiZ7ATeQyxhi/UA4bjz0VulchnSWjH3ZtnfWePKDp1mLH0nkx5yCfnBzfeSbny8adzFtcXy67VxNmb3ak5s1xLonVd34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JPnegzC+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPnegzC+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 471851F000FF;
	Mon, 28 Sep 2026 21:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790629488;
	bh=tRgOEtQUjPQPcuPzvM42ONw2yxNbpimwrxls9RJW2y0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JPnegzC+PCeW5pwSWYZAJYlgXPLsCtrhYe6U68ORArI8M+g/Xi0Ooj2Tjvg9vDIx+
	 lTQXc4U8zmKIVgJm92cdZ6Fj/aNfjZhE2T56/gqo1vgmGaNnsFuelEYhvKRqKgM+iS
	 AwS4VpR2+N6jKl7qgHiFyvi70Mswwj6M7l0cUSuMChJt/wZDG9MYn38PAY7E12yj3F
	 blA8aDqaP7OANVgm5rE0tFien1cTcWlvNqm/kP1V5UuiDEMnfepxBHLPWCaQdfUyx9
	 DNEk6/2G/cp11j9a/2Q/i2M/DjzQDpjCY4HpQBi5IFSki9DDxfzEndCFdZ5Or/F5VP
	 A11SSv4ne6IOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/3] arm64: dts: imx95: Add support for Data Modul
 i.MX95 eDM SBC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marek Vasut" <marex@nabladev.com>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, Frank.Li@kernel.org, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, imx@lists.linux.dev, conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, "Vincent
 Mailhol" <mailhol@kernel.org>
In-Reply-To: <20260928204741.175754-3-marex@nabladev.com>
References: <20260928204741.175754-1-marex@nabladev.com>
 <20260928204741.175754-3-marex@nabladev.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 21:04:47 +0000
Message-Id: <20260928210448.471851F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] dt: imx95-data-modul: PCAL6524 expander interrupts cause IRQ storm=
 due to active-high polarity
- [High] dt: imx95-data-modul: KSZ9131 Ethernet PHYs permanently held in re=
set due to active-high polarity
- [Medium] dt: imx95-data-modul: reg_panel_vcc defaults to active-low, brea=
king panel power
- [Medium] dt: imx95-data-modul: M.2 Key-E slot unpowered due to missing re=
gulator for VDD_3V3_M2-E_EN
--

commit 88cbe063476bce8eddcc6ed5fd22c93a72c1ced5
Author: Marek Vasut <marex@nabladev.com>

arm64: dts: imx95: Add support for Data Modul i.MX95 eDM SBC

Add support for Data Modul i.MX95 eDM SBC board. This is an evaluation board
for various custom display units.

> diff --git a/arch/arm64/boot/dts/freescale/imx95-data-modul-edm-sbc.dts b=
/arch/arm64/boot/dts/freescale/imx95-data-modul-edm-sbc.dts
> new file mode 100644
> index 0000000000000..0181262eb8a98
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx95-data-modul-edm-sbc.dts

[ ... ]

> +	reg_panel_vcc: regulator-panel-vcc {
> +		compatible =3D "regulator-fixed";
> +		regulator-min-microvolt =3D <3300000>;
> +		regulator-max-microvolt =3D <3300000>;
> +		regulator-name =3D "PANEL_VCC";
> +		gpios =3D <&i2c2_gpio_expander_20 17 0>;
> +		/* Disabled by default, unless display board plugged in. */
> +		status =3D "disabled";
> +	};

[Severity: Medium]
Does this regulator invert the panel power logic?

Because this fixed regulator omits the enable-active-high boolean
property, the gpiolib-of quirk implementation specifically ignores the phan=
dle
polarity flag (0 / GPIO_ACTIVE_HIGH) and forces the polarity to active-low.
This results in inverted enable logic for the display panel when it should =
be
on or off.

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
Does this interrupt configuration cause an immediate IRQ storm?

The NXP PCAL6524 INT output is an open-drain, active-low signal, and
the expanders share the same gpio5 11 line. By configuring the interrupt
with IRQ_TYPE_LEVEL_HIGH, the GPIO interrupt controller continuously
perceives the natural high idle state (maintained by a pull-up) as an
active interrupt, rendering all the GPIO expanders inoperable.

> +		vcc-supply =3D <&reg_3p3v>;
> +		/*
> +		 * reset-gpios cannot be used because the reset
> +		 * line is shared by multiple PCAL6524 consumers.
> +		 */
> +		gpio-line-names =3D
> +			/* Port 0 */
> +			"UART8_RS232-485_MODE0", "UART8_RS232-485_MODE1",
> +			"UART8_RS232-485_Term_TX", "UART8_RS232-485_Term_RX",
> +			"UART8_RS232-485_EN", "VDD_3V3_M2-E_EN",

[Severity: Medium]
Will the M.2 Key-E slot remain unpowered?

The board features a dedicated power enable pin for the Key-E slot
("VDD_3V3_M2-E_EN" here on the PCAL6524 expander). However, unlike the Key-B
and Key-M PCIe slots, there is no fixed regulator defined for this pin, and
the usdhc3 node has no vmmc-supply. Since the expander powers up in input
mode, the enable pin is never actively driven high, leaving the slot unpowe=
red
and any SDIO device failing to initialize.

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
This is a second instance of the active-high interrupt polarity issue on the
PCAL6524 INT pin, which will also contribute to an IRQ storm on gpio5 11.

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
This is a third instance of the active-high interrupt polarity issue on the
PCAL6524 INT pin, continuing to cause an IRQ storm on the shared line.

[ ... ]

> +	ethphy0: ethernet-phy@1 {	/* KSZ9131RNXI U20 */
> +		compatible =3D "ethernet-phy-id0022.1640";
> +		reg =3D <1>;
> +		interrupts-extended =3D <&gpio1 10 IRQ_TYPE_LEVEL_LOW>;
> +		reset-assert-us =3D <1000>;
> +		/* RESET_N signal rise time ~100ms */
> +		reset-deassert-us =3D <120000>;
> +		reset-gpios =3D <&i2c2_gpio_expander_22 4 GPIO_ACTIVE_HIGH>;
> +	};

[Severity: High]
Are the KSZ9131 Ethernet PHYs permanently held in reset?

The KSZ9131 PHY requires an active-low reset signal (RESET_N). By
specifying GPIO_ACTIVE_HIGH here for reset-gpios, the PHY framework will
drive the line high to assert reset, and low during normal operation, exact=
ly
opposite of what the hardware expects, permanently holding the PHY in reset.

> +
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
This is the second instance of the reset-gpios polarity issue on the ethern=
et
PHY, also holding it permanently in reset.

[ ... ]

> +&usdhc3 {	/* M.2 Key-E */
> +	pinctrl-names =3D "default", "state_100mhz", "state_200mhz", "sleep";
> +	pinctrl-0 =3D <&pinctrl_usdhc3>;
> +	pinctrl-1 =3D <&pinctrl_usdhc3_100mhz>;
> +	pinctrl-2 =3D <&pinctrl_usdhc3_200mhz>;
> +	pinctrl-3 =3D <&pinctrl_usdhc3>;
> +	bus-width =3D <4>;
> +	status =3D "okay";
> +};

[Severity: Medium]
As mentioned earlier regarding the missing regulator for VDD_3V3_M2-E_EN,
usdhc3 misses a vmmc-supply to control the slot's power, leaving the
M.2 Key-E slot unpowered.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928204741.1757=
54-1-marex@nabladev.com?part=3D3
