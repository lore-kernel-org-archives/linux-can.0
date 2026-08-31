Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7403A71AD;
	Mon, 31 Aug 2026 09:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788167088; cv=none; b=MoKHVNoaEN9fh2sV90K+V3vvFt55bMJdOORnS0Go0rU18ovNsclYjjbtKNnmsaPWHLJiHvLd2aVnAk60z/zCr0tloKl+efgr0q1vaJKN5fQjIZGDWst83m8BOd3BxtxYF0ruxt8vtDPMexSdlP8jJHgiIxksSJewSLW9LIV/Pjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788167088; c=relaxed/simple;
	bh=7pAi7166XWQSyCVnLaFq5Oiknqj50joNBVNikhDtwcM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eHi3F8MmWEK1q7sQc3aOSbYL77f1GtEHteGzbnkNDACI06vuWWOTRecbRks3792WsrF/LQcTfykIBK/kKQ7c4ndEoFZlWH4wcl8eHZya1Fmf0C8A90/xpf9XxnB35idavIMiEz6JNoW9Cyn/LKOpY5+A0lgCm6CPNUMKJP/Y3hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ocqzPnxt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ocqzPnxt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F50B1F000E9;
	Mon, 31 Aug 2026 09:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788167086;
	bh=L0B9Ydyca33fzaC4BYotoHysBDOs35sZh0O/LAlxSk8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ocqzPnxtT+JcZOfireKyd6nupUJ4hDn+HUKWuQs6g/gc//2ro061YQuO+XACPqzmW
	 0kEciK3dRMb5y7dj0empXk/gfDx35HNXa01tHLqeWQBqc2VjAkQTW707/Aujz+XOAW
	 XR02PmbzxNNE0zSgCYypY7yU0TILHDLnwG94NbxHrNFFPg74AqZO/o3Qt6gppSmgCn
	 lEbkxhrKem5uDWcAYxuQ0QatB7UBh/fT/wDkPyPm96JX4GHjbKfaKFQUHvqlbwSZii
	 2wrTbeTN0QbNKI2f6+p4OAjO/jy7IEkWHidRTY8CfIyHH4XsgiCjM02+zarqTVlkbc
	 s7DWNNAAu5Vfw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V2 3/3] arm64: dts: freescale: Add chargebyte Charge
 Control Y
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Wahren" <wahrenst@gmx.net>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, conor+dt@kernel.org, olteanv@gmail.com, vkoul@kernel.org, devicetree@vger.kernel.org, linux-phy@lists.infradead.org, Frank.Li@kernel.org, robh@kernel.org, neil.armstrong@linaro.org, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org, imx@lists.linux.dev
In-Reply-To: <20260831083539.8287-4-wahrenst@gmx.net>
References: <20260831083539.8287-1-wahrenst@gmx.net>
 <20260831083539.8287-4-wahrenst@gmx.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 09:04:44 +0000
Message-Id: <20260831090445.0F50B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Missing GPIO initialization / Unused pin for X_nRST_LAN
- [Medium] Missing Pin Mux Configuration for USDHC2_VSELECT in default state
- [Low] DT Binding Violation: Undocumented compatible string 'microchip,mcp=
2542'
--

commit c595019b7dc419cc298a111c2b215904a12f65e1
Author: Stefan Wahren <wahrenst@gmx.net>
arm64: dts: freescale: Add chargebyte Charge Control Y

This commit introduces device tree support for the chargebyte Charge Contro=
l Y,
an Electrical Vehicle Supply Equipment for MCS charging stations based on t=
he
phyCORE-i.MX 93 ARM SoM. It defines necessary pin multiplexing, peripherals
like CAN and Ethernet, and device-specific layouts.

> diff --git a/arch/arm64/boot/dts/freescale/imx93-charge-control-y.dts b/a=
rch/arm64/boot/dts/freescale/imx93-charge-control-y.dts
> new file mode 100644
> index 0000000000000..0405098cc05c4
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx93-charge-control-y.dts

[ ... ]

> +	// Heartbeat LED of phyCore is not populated
> +	/delete-node/ leds;
> +
> +	flexcan1_tc: can-phy0 {
> +		compatible =3D "microchip,mcp2542", "ti,tcan1042";

[Severity: Low]
Is the "microchip,mcp2542" compatible string documented in any devicetree
binding schema?

Using an undocumented compatible string here might cause `make dtbs_check`
validation tooling to fail.

> +		#phy-cells =3D <0>;
> +		max-bitrate =3D <1000000>;
> +	};

[ ... ]

> +	pinctrl_flexcan1: flexcan1grp {
> +		fsl,pins =3D <
> +			MX93_PAD_PDM_BIT_STREAM0__CAN1_RX	0x139e
> +			MX93_PAD_PDM_CLK__CAN1_TX		0x1382
> +		>;
> +	};
> +
> +	pinctrl_gpio1: gpio1grp {
> +		fsl,pins =3D <
> +			MX93_PAD_I2C2_SDA__GPIO1_IO03		0x31e

[Severity: Medium]
Does the X_nRST_LAN reset pin (GPIO1_IO03) need a GPIO hog or a driver
consumer (e.g., via a reset-gpios property) in the device tree?

Since the upstream lan865x SPI kernel driver does not parse or manage
reset-gpios, leaving its functional state unmanaged here might result in the
hardware reset pin floating or being left in an indeterminate state.

Could this cause the LAN8651 Ethernet interface to fail to emerge from reset
and initialize properly on a cold boot?

> +			MX93_PAD_PDM_BIT_STREAM1__GPIO1_IO10	0x382
> +		>;
> +	};
> +
> +	pinctrl_gpio4: gpio4grp {

[ ... ]

> +	pinctrl_usdhc2_cd: usdhc2cdgrp {
> +		fsl,pins =3D <
> +			MX93_PAD_SD2_CD_B__GPIO3_IO00		0x31e
> +		>;
> +	};
> +
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
Should MX93_PAD_SD2_VSELECT__USDHC2_VSELECT be included in this default
state group?

The MMC core initially brings up the SD card in the default 3.3V state. Wit=
hout
the USDHC2_VSELECT pad configured here, the controller might not be able to
actively manage the IO voltage selection in its default state.

Could this absence lead to unpredictable external voltage regulator behavio=
r or
SD card initialization failures?

> +		>;
> +	};
> +
> +	/* need to config the SION for data and cmd pad, refer to ERR052021 */
> +	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831083539.8287=
-1-wahrenst@gmx.net?part=3D3
