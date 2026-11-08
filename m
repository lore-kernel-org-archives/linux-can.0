Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794139897;
	b=dilR7BXl6jFCkNNrts0HTd95MpbnGnK+2Ew3+8jvEHrazFICp3mKWcqilCex4FK6i2cD
	 n+8+N+v1IQYS218RjW35PwVFxcHBeh7029qp9akJkbfYoi5+96xsx/4Mex9MRSegx1+Sr
	 hb2eG+rFYlPrWKZJmVz+Os2IbtIaeC3HuCeZLRfUWXEJdEyPQ0/Z2fd9OemZal6MLJQ1G
	 aHxR/0VpnCsbeiFvFKuUWPO86XPn9MxWA7pRjkIyBxQdPnCB8bk6mlIbb1xVyid38juYK
	 dybpdB9VRRErpNaWmf0wbYmeZCrY66CQI8+4n/0uX8XOTCtQw+nYuYvxSscx2ot48FA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794139897;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=S53t+YVv3ElnijbCvjTcj9y1Ev0v2nk/Dmj5oB/Gyio=;
	b=AniSZKZ+5FdolvprXdKCZcnT70wFlYULuWO4BFNwnA1KztDdtZ1llJGkmYmfvsp3IXZu
	 SWcvrgQuETVu8ct3HxjBJG9iTY4BY/ASqwG2KbZ4UJZFaeYRYmT9/bFh3fMfIJG5WdYOk
	 SZLYFWXvn9ZfhgseLkXtT57YccX4oBwd8IR5RicO2c/OuoOrViHYUErXNNuLP6Rvre35H
	 29Nhwt6aA+eaHLDZ14LtpkZnBQYUAwyWOG6kUMlffz12x22txDBstHIfq07IV0nyOouzi
	 lFuzUdwh1aJy0bd0h/aDmV0piIF7y/n675qmcYXr0Ys93Jh/J6qlscNjdDDYfFGDgeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nR5kpjUT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0E6606A31C;
	Sun,  8 Nov 2026 12:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nR5kpjUT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB93E1F0089F;
	Sun,  8 Nov 2026 12:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794139897;
	bh=S53t+YVv3ElnijbCvjTcj9y1Ev0v2nk/Dmj5oB/Gyio=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nR5kpjUT4Wz2G43xQ1mhvZSmnOy/blyN/ZgcgtUTv0fvfpnkeB9l1bihpYRrBnqIN
	 USRotrf/P2EZ3gn3upJextTqLcr4Wgen45hlWDHi9gqqQfRX6TqZUwR68EofUTEupk
	 X1+mJMyXXU3+sB5szdefkIEjWMK8Fsxa3AA+3oA6lPAdo0/iEfedMfoBQgPiTZdN+o
	 RNnVsvYw24rZWP0Rh59U2g/LuiT7umvllk0MVqLqC5JIGwPS9Qedi30L4hhTYdXT5U
	 9AA/kiYT3LrD7CYre4bv9aB/M0WsYYWnWY8wvUzS9k+uxXRmHTktzYpKQiRyp4yjhH
	 8wl9nRbpc1WiQ==
Subject: Re: [PATCH 5/5] ARM: mxs: add EVAchargeSE board support
From: netdev-bot+sashiko@kernel.org
To: wahrenst@gmx.net
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linusw@kernel.org, brgl@kernel.org, Frank.Li@nxp.com, vkoul@kernel.org,
 mkl@pengutronix.de, neil.armstrong@linaro.org, mailhol@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
 mani@kernel.org, devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
 linux-can@vger.kernel.org, linux-phy@lists.infradead.org, kuba@kernel.org
Date: Sun, 08 Nov 2026 12:11:35 +0000
Message-ID: <179413989528.488853.11075194967877927671@kernel.org>
In-Reply-To: <20261106230746.21954-6-wahrenst@gmx.net>
References: <20261106230746.21954-6-wahrenst@gmx.net>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The ethernet-phy@0 node in
  arch/arm/boot/dts/nxp/mxs/imx28-evachargese.dts (an SMSC LAN87xx-class…
- [Low] The patch only adds
  arch/arm/boot/dts/nxp/mxs/imx28-evachargese.dts and a dtb entry in…

--

ARM: mxs: add EVAchargeSE board support

This adds a devicetree for the chargebyte EVAcharge SE. It is an i.MX28
based ISO 15118 controller for EV charging stations. The DTS enables eMMC,
the debug UART, Ethernet, USB host, QCA7000 powerline over SPI, CAN and the
board LEDs.

Link: https://chargebyte.com/products/controllers-modules/evse-controllers/evacharge-se

> ARM: mxs: add EVAchargeSE board support

[Severity: Low]
This isn't a bug, but the patch only touches arch/arm/boot/dts/nxp/mxs/.
Should the subject use the dts prefix, for example "ARM: dts: mxs: Add
chargebyte EVAcharge SE board"? The previous patch in this series, "ARM:
dts: imx28: add alternative pinmux for CAN1", already uses that form.

The product name is also spelled three different ways:

  subject:    "EVAchargeSE"
  body:       "EVACharge SE is a ISO 15118 compliant controller ..."
  DTS model:  model = "chargebyte EVAcharge SE";

The dt-bindings patch "dt-bindings: arm: fsl: support chargebyte EVAcharge
SE" uses "EVAcharge SE". Could the spelling be the same everywhere?

> diff --git a/arch/arm/boot/dts/nxp/mxs/imx28-evachargese.dts b/arch/arm/boot/dts/nxp/mxs/imx28-evachargese.dts
> new file mode 100644
> index 0000000000000..75ddde2264936
> --- /dev/null
> +++ b/arch/arm/boot/dts/nxp/mxs/imx28-evachargese.dts
> @@ -0,0 +1,294 @@

[ ... ]

> +&mac0 {
> +	phy-handle = <&ethphy>;
> +	phy-mode = "rmii";
> +	phy-supply = <&reg_3p3v>;
> +	pinctrl-0 = <&mac0_pins_a &mac0_phy_reset_pin>;
> +	pinctrl-names = "default";
> +
> +	status = "okay";
> +
> +	mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		ethphy: ethernet-phy@0 {
> +			compatible = "ethernet-phy-ieee802.3-c22";
> +			reg = <0>;
> +			clocks = <&clks 64>; /* enet_out */
> +			interrupt-parent = <&gpio4>;
> +			interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
> +			max-speed = <100>;
> +			pinctrl-0 = <&mac0_phy_int_pin>;
> +			pinctrl-names = "default";
> +			reset-assert-us = <500>;
> +			reset-deassert-us = <500>;
> +			reset-gpios = <&gpio4 13 GPIO_ACTIVE_LOW>;
> +			smsc,disable-energy-detect;

[Severity: Medium]
Can the PHY ID be read here while the PHY is still held in reset?

This node only has the generic c22 compatible, with no
ethernet-phy-idXXXX.XXXX entry. So fwnode_mdiobus_register_phy() reads the
ID over MDIO before phylib has requested the reset GPIO:

drivers/net/mdio/fwnode_mdio.c:fwnode_mdiobus_register_phy() {
    ...
	if (is_c45 || fwnode_get_phy_id(child, &phy_id))
		phy = get_phy_device(bus, addr, is_c45);
	else
		phy = phy_device_create(bus, addr, phy_id, 0, NULL);
    ...
}

The reset-gpios line is requested only after that, through this path:

phy_device_register()
  mdiobus_register_device()
    mdio_device_register_reset()

The reset is deasserted later still, in phy_probe().

If nRST is low during the scan, the ID reads as all ones and
get_phy_device() returns -ENODEV. __of_mdiobus_parse_phys() then just
prints "MDIO device at address 0 is missing". The phy-handle in mac0 points
at a PHY that was never registered, so Ethernet doesn't come up.

One way to hit this is to unbind and rebind the FEC driver, or to reload a
modular fec. On removal, phy_remove() and phy_device_remove() assert the
reset before the GPIO is released:

drivers/net/phy/phy_device.c:phy_device_remove() {
    ...
	/* Assert the reset signal */
	phy_device_reset(phydev, 1);

	mdiobus_unregister_device(&phydev->mdio);
    ...
}

mdio_device_unregister_reset() then calls gpiod_put(), but the pin keeps
driving low. The next scan finds the PHY still in reset.

The same failure could happen at first boot if the bootloader leaves
GPIO4_13 low. This DTS muxes that pad as GPIO with MXS_PULL_DISABLE.

Documentation/devicetree/bindings/net/ethernet-phy.yaml covers this case.
It says that if a PHY needs a particular reset sequence before its ID
registers can be read, the compatible list "must contain an entry with the
correct PHY ID".

imx28-btt3.dtsi also has a LAN8720 with reset-gpios, and it does this:

	/* LAN8720Ai - PHY ID */
	compatible = "ethernet-phy-id0007.c0f0","ethernet-phy-ieee802.3-c22";

Could this node get an explicit ethernet-phy-id compatible too? The
smsc,disable-energy-detect property suggests an SMSC PHY, and the ID would
need to match the part fitted on this board.

> +		};
> +	};
> +};

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106230746.21954-1-wahrenst%40gmx.net
