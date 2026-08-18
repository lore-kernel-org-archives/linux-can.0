Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6143C0A18;
	Tue, 18 Aug 2026 09:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787045510; cv=none; b=bXS6bbJ5IvDSoGifPKVnlZ8TSHRAldbkQr0M6b8EjVCYnfBCsJ4MZu3FqYKZtvY6LO/xiR3ftgZBarRk4N4CT03bzuSMxsZ9e36sSOQVPSUPa183gRlNBHodkzniMWaTs8t8jQDY7trW4iWFU5gf/OS3bnz3QZB5qaC3so+w5lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787045510; c=relaxed/simple;
	bh=O4PfENbvgkJUOnLkwHfdpUsWpgjIC9sTq8qJ32I/HuA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IVUeTF8ZrlxPLWUgyAgFfQBn5BOFU/NLZ2YP7bLoEo8CijPdvDeV/kKGDxK2XtS+d/6jkmWjKB4a6RnX172Tw5X2LrH0o6BWyA1WNUaIN+ymOWvts/7cQFrELk9Pyep5vtSQmpOBY5OYuXIg3oklkTTKi8gFKc+UoNSvjdR3LYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bVP9IDgW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVP9IDgW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E556C1F000E9;
	Tue, 18 Aug 2026 09:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787045508;
	bh=/osMCfdFU5SEjl+FL2UCRvm7Kij1P5u1jx3B9DLMi9M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bVP9IDgWirqxwIpjvPxGaqIdVHx+zWYeYaX/54Aaw9rGmnbGsgPmA6p6QssZqbgNA
	 NyrrW7uwFrBO9Sa5Xf92E3PNVjrs+YFlea7n9fkknA9iZT0f+KKLvMfQa7oQazoYCW
	 I6pGmzo4sg26bRziwQtYXAecVJN+ht5Eygv9Y3/JKPE9Q7oLm0NAOS8pCWSOV04pyA
	 uG/G1dncygvLt74/toMGIpgtfWYJsv3LGs684uCsftjT6iXueaw8ljnAKCiVqZydZp
	 50m9Gnb7ymVVL+bblgv7qSyIJpcK0YulM0pgEotPZXKB88zNlzNVJb4QNFwywj5DL/
	 q8DRdyQk3n5Tw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 4/4] arm64: dts: freescale: Add chargebyte Charge
 Control Y
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Wahren" <wahrenst@gmx.net>
Cc: imx@lists.linux.dev, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, vkoul@kernel.org, olteanv@gmail.com, devicetree@vger.kernel.org, conor+dt@kernel.org, Frank.Li@kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, linux-can@vger.kernel.org, neil.armstrong@linaro.org, "Vincent
 Mailhol" <mailhol@kernel.org>, robh@kernel.org, linux-phy@lists.infradead.org
In-Reply-To: <20260818091701.6441-5-wahrenst@gmx.net>
References: <20260818091701.6441-1-wahrenst@gmx.net>
 <20260818091701.6441-5-wahrenst@gmx.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 09:31:47 +0000
Message-Id: <20260818093147.E556C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] The LAN8651 ethernet device is missing its hardware reset config=
uration, leaving the `X_nRST_LAN` pin unmanaged.
- [Medium] The SD card slot power/reset pin (`SD2_nRESET`) is named in `gpi=
o-line-names` but is not associated with any regulator or reset control.
- [Low] The GPIO label `X_LAN_nCS` is incorrectly placed at index 0 of `&gp=
io2`'s `gpio-line-names` array, but the `lan8651` chip select is actually w=
ired to index 8.
- [Low] The `ti,leds-polarity` property used in both Ethernet PHY nodes is =
undocumented, invalid, and will cause `dtbs_check` validation errors.
--

--- Patch [4]: [PATCH RFC 4/4] arm64: dts: freescale: Add chargebyte Charge=
 Control Y ---
commit a177a5e0acba62156876ea6dc84457789786bfb8
Author: Stefan Wahren <wahrenst@gmx.net>

arm64: dts: freescale: Add chargebyte Charge Control Y

This commit adds support for the chargebyte Charge Control Y, an EVSE
for MCS charging stations based on the phyCORE-i.MX 93 ARM SoM. It
adds the devicetree for the board, including ethernet interfaces, CAN,
SPI, and SD card configurations.

> diff --git a/arch/arm64/boot/dts/freescale/imx93-charge-control-y.dts b/a=
rch/arm64/boot/dts/freescale/imx93-charge-control-y.dts
> new file mode 100644
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx93-charge-control-y.dts
> @@ -0,0 +1,387 @@
[ ... ]
> +/* Ethernet 1 PHY */
> +&ethphy1 {
> +	ti,leds-polarity =3D <1>; // active-high
> +};

[Severity: Low]
Is ti,leds-polarity supported by the devicetree bindings? It does not
appear to be documented in the schema and might cause dtbs_check validation
errors.

[ ... ]
> +&gpio2 {
> +	gpio-line-names =3D "X_LAN_nCS", "", "", "", "",
> +			  "", "", "X_LAN_nIRQ", "", "",

[Severity: Low]
Should the X_LAN_nCS label be placed at index 8 instead of index 0? The
lpspi3 node below configures the cs-gpios using index 8 on this bank.

[ ... ]
> +/* MCS Ethernet SPI */
> +&lpspi3 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_lpspi3>;
> +	num-cs =3D <1>;
> +	cs-gpios =3D <&gpio2 8 GPIO_ACTIVE_LOW>;
> +	status =3D "okay";
> +
> +	lan8651: ethernet@0 {
> +		compatible =3D "microchip,lan8651", "microchip,lan8650";
> +		reg =3D <0>;
> +		interrupt-parent =3D <&gpio2>;
> +		interrupts =3D <7 IRQ_TYPE_LEVEL_LOW>;
> +		spi-max-frequency =3D <25000000>;
> +
> +		nvmem-cells =3D <&eth2_mac_address 0>;
> +		nvmem-cell-names =3D "mac-address";
> +	};
> +};

[Severity: Medium]
The pin X_nRST_LAN is labeled in the gpio1 node, but this ethernet node
doesn't seem to configure a reset mechanism. Does the LAN8651 need a reset
control or gpio-hog to ensure the pin is driven and not left floating?

[ ... ]
> +/* Ethernet 2 PHY */
> +&mdio {
> +	ethphy2: ethernet-phy@2 {
> +		reg =3D <2>;
> +		compatible =3D "ethernet-phy-id2000.a140";
> +		clocks =3D <&clk IMX93_CLK_ENET_REF_PHY>;
> +		reset-gpios =3D <&gpio4 13 GPIO_ACTIVE_HIGH>;
> +		reset-assert-us =3D <30>;
> +		reset-deassert-us =3D <50000>;
> +		ti,leds-polarity =3D <1>; // active-high
> +	};
> +};

[Severity: Low]
Similar to the ethernet 1 PHY above, is this ti,leds-polarity property
supported by the devicetree bindings?

> +
> +/* SD */
> +&usdhc2 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_usdhc2_default>, <&pinctrl_usdhc2_cd>;
> +	cd-gpios =3D <&gpio3 00 GPIO_ACTIVE_LOW>;
> +	bus-width =3D <4>;
> +	disable-wp;
> +	no-sdio;
> +	no-mmc;
> +	no-1-8-v;
> +	status =3D "okay";
> +};

[Severity: Medium]
The SD2_nRESET pin is labeled in the gpio3 node, but does this usdhc2 node
need a vmmc-supply using that pin as a fixed regulator to ensure the SD
card slot is reliably powered?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818091701.6441=
-1-wahrenst@gmx.net?part=3D4
