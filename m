Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6C742A792;
	Thu,  3 Sep 2026 08:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788423688; cv=none; b=FeaszroxvMBCEm9dGhKpirb+dBc94ylZXoy/dWsiddfjsI9OT5iIwzaWfUwZfyeDhvvtGNOGK9w+0p2OZIlDtVyXqEqbjEnM64/8yDE9g7/lND5TjJKFw/CRbE46Kq51dJcpRTVrLr0HpByeeXGgQm1Y2b6B79xlKCtTExbD7V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788423688; c=relaxed/simple;
	bh=kajeAGdoWkgV89zinwd1Ru8wPQWZW7H5K4eMkT6sI3g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LC8DaBrcyZTDQ7o8bINbAGJftV5+28RH2T6Dtl7AmZRjgGwGEDWrtN2dAR8dH8RjtyjubJbSDz4RQB/mlLiuydR20VGvFCEYvx+gKo2RLXTVbjRA2bfnqqUwuxSOxcbKBP1hwWw0Jw0O7rUpAL0jXOzZHPWVcvioi0VISp7AmS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mOKOn26p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mOKOn26p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A777C1F000E9;
	Thu,  3 Sep 2026 08:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788423683;
	bh=GDoTGdygZN9md3euE+c9LSWt2cQjxDq0+S+S2g4wB6A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mOKOn26pMRRAOuFyMAX547S0Ddak8/F7AbzM2BN28luHcQLfYvuzZrpy8jDMv2IgH
	 HQu7vvJsXBi0xFCKtd6EFRZb+NTAc/JTZ1ql0s+a3ukwIkbINgcnlDIUT6k/zdlzIf
	 CGKweq82eD8leyvFQPqCUreICD3YhnxPFAkumuDrItSLO0vnpN1EiNDXBD/n8e5FI2
	 vTjCzmpR0MVNsvKaS3EbgPad9v/gJXsdsSf1NqBeb4o67mru7s96yQoYJjuzGVvd7H
	 SF0sr6cTKXZIKrsGr3OLAC1/xYd92tG1uAnyRUm58iZTNa5cgvWYI0nQUrHyDte07T
	 wMytlvt0aAu5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V4 4/4] arm64: dts: freescale: Add chargebyte Charge
 Control Y
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Wahren" <wahrenst@gmx.net>
Cc: robh@kernel.org, devicetree@vger.kernel.org, imx@lists.linux.dev, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, neil.armstrong@linaro.org, conor+dt@kernel.org, linux-can@vger.kernel.org, Frank.Li@kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, olteanv@gmail.com, linux-phy@lists.infradead.org, vkoul@kernel.org
In-Reply-To: <20260903080427.6103-5-wahrenst@gmx.net>
References: <20260903080427.6103-1-wahrenst@gmx.net>
 <20260903080427.6103-5-wahrenst@gmx.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 08:21:22 +0000
Message-Id: <20260903082122.A777C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Mismatched drive strengths on USDHC2 data lines within the same =
interface speed mode.
- [Medium] The reset GPIO polarity for the Ethernet PHY (DP83825) is config=
ured as active-high, but the PHY natively requires an active-low reset.
- [Low] Incorrect node name used in `/delete-node/` for heartbeat LED pinct=
rl.
--

commit 228da9fe4e969182ceef8105169e14b5de5949a5
Author: Stefan Wahren <wahrenst@gmx.net>

arm64: dts: freescale: Add chargebyte Charge Control Y

This adds device tree support for the chargebyte Charge Control Y, an
Electrical Vehicle Supply Equipment (EVSE) based on the phyCORE-i.MX 93
SOM.

> diff --git a/arch/arm64/boot/dts/freescale/imx93-charge-control-y.dts b/a=
rch/arm64/boot/dts/freescale/imx93-charge-control-y.dts
> new file mode 100644
> index 0000000000000..ba240f528f9b9
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx93-charge-control-y.dts
[ ... ]
> +/* Ethernet 2 PHY */
> +&mdio {
> +	ethphy2: ethernet-phy@2 {
> +		reg =3D <2>;
> +		compatible =3D "ethernet-phy-id2000.a140";
> +		clocks =3D <&clk IMX93_CLK_ENET_REF_PHY>;
> +		reset-gpios =3D <&gpio4 13 GPIO_ACTIVE_HIGH>;

[Severity: Medium]
Will this hold the Ethernet PHY in reset? The DP83825 PHY natively expects
an active-low reset signal. By specifying GPIO_ACTIVE_HIGH here, the kernel
will assert reset by driving the GPIO high, and normal operation will drive
it low. This could potentially keep the PHY in reset permanently, preventing
Ethernet link establishment, unless there is a physical hardware inverter
between the GPIO and the PHY.

> +		reset-assert-us =3D <30>;
> +		reset-deassert-us =3D <50000>;
> +	};
> +};
[ ... ]
> +&iomuxc {
> +
> +	// Heartbeat LED of phyCore is not populated
> +	/delete-node/ pinctrl_leds;

[Severity: Low]
Will the device tree compiler process this delete-node directive correctly?
In imx93-phycore-som.dtsi, the node is defined with the name ledsgrp and
the label pinctrl_leds.

The delete-node syntax expects the exact node name, like:
	/delete-node/ ledsgrp;

Or alternatively, using the phandle label at the root level:
/delete-node/ &pinctrl_leds;

Using just the label name inside &iomuxc might result in a "Node not found"
compiler error or a silent failure that leaves unused pinmux data in the
binary.

> +
> +	pinctrl_eqos: eqosgrp {
[ ... ]
> +	/* need to config the SION for data and cmd pad, refer to ERR052021 */
> +	pinctrl_usdhc2_default: usdhc2grp {
> +		fsl,pins =3D <
> +			MX93_PAD_SD2_CLK__USDHC2_CLK		0x119e
> +			MX93_PAD_SD2_CMD__USDHC2_CMD		0x4000139e
> +			MX93_PAD_SD2_DATA0__USDHC2_DATA0	0x4000138e
> +			MX93_PAD_SD2_DATA1__USDHC2_DATA1	0x4000138e
> +			MX93_PAD_SD2_DATA2__USDHC2_DATA2	0x4000138e
> +			MX93_PAD_SD2_DATA3__USDHC2_DATA3	0x4000139e

[Severity: Medium]
Are these drive strength settings intended to be different across the data
lines?

In this default mode configuration, DATA0-2 use 0x4000138e (DSE bit 4 =3D 0=
),
while DATA3 uses 0x4000139e (DSE bit 4 =3D 1). Mismatched drive strengths on
the same SDIO bus can introduce signal skew and degrade signal integrity.

> +			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
> +		>;
> +	};
> +
> +	/* need to config the SION for data and cmd pad, refer to ERR052021 */
> +	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
> +		fsl,pins =3D <
> +			MX93_PAD_SD2_CLK__USDHC2_CLK		0x119e
> +			MX93_PAD_SD2_CMD__USDHC2_CMD		0x4000139e
> +			MX93_PAD_SD2_DATA0__USDHC2_DATA0	0x4000138e
> +			MX93_PAD_SD2_DATA1__USDHC2_DATA1	0x4000138e
> +			MX93_PAD_SD2_DATA2__USDHC2_DATA2	0x4000139e
> +			MX93_PAD_SD2_DATA3__USDHC2_DATA3	0x4000139e

[Severity: Medium]
Similarly, in the 100mhz configuration, DATA0-1 are set to 0x4000138e and
DATA2-3 are set to 0x4000139e. Could this mismatch cause high-frequency
enumeration or data corruption issues on the SD bus?

> +			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
> +		>;
> +	};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903080427.6103=
-1-wahrenst@gmx.net?part=3D4
