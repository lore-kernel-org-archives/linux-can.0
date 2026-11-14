Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794616486;
	b=bfsdRQTEtW+VZa15fDgwDiIBb0eyRk9yPTcySx76hengLvVawSAtU+9W7xc8kY6Qm1jZ
	 VfPUWHBkEi7WpcixNuwxP2atH8z83MPoJGHSc0uz5ut7zCIWXkoIfUC+f2cHfWtEC1yZ7
	 YH6PRe+tF4lT8LT+pwQI3rt2GjPNsYBpW1SgIo3jUV10/Ekx0jg0SMr8mSGFSbIu5b2bY
	 ZuXmQHBAxsZUl9IP8jJwcuHimcAItY8ZhUPbvNp7Iuj3aC6Y8mVQ8P5mSErptU9JonEuu
	 LGuiwC4EzFfyt1DW6R5NfUeNauflBRoyRmnOOJq/RQVKN34+GEKba7epa3ReWbwW9xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794616486;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FpgEwmMzNnxajwtzHIwdlHqmmNh9zHN0T9NnKFNpv/Q=;
	b=ri60KFYZmzFqx5mmCIK2BMRU6yHIouCz0j1D8vtZl5r8jTTmt4aBoCv+hnBb2BLhYb+S
	 bVAZ75+oXU9EC2a3Q0wbjZIP9mD8/hdGmO/7l/SApbsdqkRCVjzxl/POyntMucI2kQme5
	 oFi5SJC8M7JHrTTBNXU5t2stdb10ezmrLG/F2JRQVCa5L79QmREjqNfOxbOrrZ2e7WHob
	 U2//9aFnMRsqM/m71adKBsFQ/YNuOM3ansMRSgwKOvGSqkRoPaL5OssVGhCcbhSDwVxU4
	 hUb/PZlR9nBSadHqnSx9PChZJIHhe7JQu0aEwv8CmD8UURJuvykgAfeZOvhPfAYM6NA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ggWAxiWG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5E9606A330;
	Sat, 14 Nov 2026 00:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ggWAxiWG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 199901F000C4;
	Sat, 14 Nov 2026 00:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794616485;
	bh=FpgEwmMzNnxajwtzHIwdlHqmmNh9zHN0T9NnKFNpv/Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ggWAxiWGWlOaCva97NAGYzUMZSKbK6+NDcbMjTKuFAac2f79Aecm5HmsUmsZd8+zc
	 LZFEtECVzH3nUzFdJgPDfFZojALGk/HL0BKVh43VOslux6oMZB3iofCSWA5u7ZIAy1
	 jr2m85/QKEIxJOlFPfVJCaXOoeposHPnKOW3v9aQ7GmPnPk86MHZ/1LMCsRfgg8Sin
	 np83a3ZT6/oCMowX9Y7TKA/ou1b45Tw4yb2qMDVK+Yyc/Njyp2L6YYmOeWtFLlHSPT
	 3PnES/NJxSs8DDlXjHpS8lD4zdGfYJCXUon/uCFBOPayqQVzKLB09aACc+i+2XYO3b
	 9PTHzuIBCVBjA==
Message-ID: <sashiko-outbox-213933@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/2] arm64: dts: imx95: Add support for Data Modul
 i.MX95 eDM SBC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marek Vasut" <marex@nabladev.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, linux-can@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, Frank.Li@kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261114001844.30606-2-marex@nabladev.com>
References: <20261114001844.30606-1-marex@nabladev.com>
 <20261114001844.30606-2-marex@nabladev.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 00:34:44 +0000
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] arm64: dts: imx95: missing pinmux for Ethernet PHY IRQ on
  GPIO1_IO10
- [Low] arm64: dts: imx95: unused backlight pinctrl node and header
  includes
--

commit 08308b97a054b075daa4e1d5655d37470b104a88
Author: Marek Vasut <marex@nabladev.com>

arm64: dts: imx95: Add support for Data Modul i.MX95 eDM SBC

This commit adds a device tree for the Data Modul i.MX95 eDM SBC board.

> diff --git a/arch/arm64/boot/dts/freescale/imx95-data-modul-edm-sbc.dts b=
/arch/arm64/boot/dts/freescale/imx95-data-modul-edm-sbc.dts
> new file mode 100644
> index 0000000000000..5ca26c6ab665f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx95-data-modul-edm-sbc.dts
> @@ -0,0 +1,1079 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (C) 2025-2026 Marek Vasut <marex@nabladev.com>
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/i3c/i3c.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/pwm/pwm.h>
> +#include <dt-bindings/usb/pd.h>
> +#include "imx95.dtsi"

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
> +	};
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
> +};

[ ... ]

> +&scmi_iomuxc {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_hog>;
> +
> +	pinctrl_hog: hoggrp {
> +		fsl,pins =3D <
> +			/* PCIe 0 PEWAKE */
> +			IMX95_PAD_GPIO_IO34__GPIO5_IO_BIT14			0x4000031e
> +			/* PCIe 1 PEWAKE */
> +			IMX95_PAD_GPIO_IO37__GPIO5_IO_BIT17			0x4000031e
> +			/* BOOT_MODE2 */
> +			IMX95_PAD_SAI1_TXFS__AONMIX_TOP_GPIO1_IO_BIT11		0x4000031e
> +			/* IO_XPNDR_RST_1V8 shared by multiple expanders */
> +			IMX95_PAD_XSPI1_SS0_B__GPIO5_IO_BIT10			0x40000b9e
> +			/* IO_XPNDR_INT_1V8 shared by multiple expanders */
> +			IMX95_PAD_XSPI1_SS1_B__GPIO5_IO_BIT11			0x40000b9e
> +		>;
> +	};
> +
> +	pinctrl_emdio: emdiogrp {
> +		fsl,pins =3D <
> +			IMX95_PAD_ENET2_MDC__NETCMIX_TOP_NETC_MDC		0x50e
> +			IMX95_PAD_ENET2_MDIO__NETCMIX_TOP_NETC_MDIO		0x90e
> +		>;
> +	};

[Severity: Medium]
Should pinctrl_hog or pinctrl_emdio mux
IMX95_PAD_PDM_BIT_STREAM1__AONMIX_TOP_GPIO1_IO_BIT10 for the shared PHY
interrupt line on <&gpio1 10>?

Both ethphy0 and ethphy1 use <&gpio1 10> as their interrupt, and
pinctrl-imx-scmi does not implement .gpio_request_enable, so requesting
the line as an interrupt will not switch the pad from its default
PDM_BIT_STREAM_BIT1 mux mode.  Unless firmware pre-configures this pad as
a GPIO, PHY interrupts will not reach gpio1.

[ ... ]

> +	pinctrl_panel_backlight_lvds: backlightlvdsgrp {
> +		fsl,pins =3D <
> +			IMX95_PAD_GPIO_IO27__GPIO2_IO_BIT27			0x31e
> +		>;
> +	};

[Severity: Low]
This isn't a bug, but pinctrl_panel_backlight_lvds is unreferenced now
that the backlight nodes have been removed.  Also, the dt-bindings/i3c/i3c.=
h,
dt-bindings/pwm/pwm.h, and dt-bindings/usb/pd.h includes at the top of the
file are unused.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114001844.3060=
6-1-marex@nabladev.com?part=3D2
