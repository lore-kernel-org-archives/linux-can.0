Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794486451;
	b=XRgJD29gN2lsgi1JTGk1uNXrFCgTgX9kpgZNzZexl71brYAF09PDtD1kwbfx+7vLhOvJ
	 zwEmokOFtOWuWbGfnAO1cxbuayRTx81TlBZRz6TDTSxcXQlH3zslxtOkL3WzdZg5PVdx2
	 Y7pIVOo22D0YMfQyd8A6SdoyVtgZZR0L6AAIm7N6ei//QOi3NEcGlgC9S5V3+bq2Zic95
	 W2ydeBr9BE6Zb5+8j+48L63fOfaE6O100TbX7k5oC4kQxHqDCA/1cvTdGIcvGdCbe09oe
	 MST9znam0QKZwV1UD0qqBaFsHgCaBlvRuIgcLn9dyUsO30qYcsh8xZI5i3fBB7ial/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794486451;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport;
	bh=S7yfW8a4jOm9PquT7mm+dF7gxrK1OkdAmj4fgTK6ApE=;
	b=gBLNZPEHWTrNjjZKXNQnFAP6YVxcu9zzGm/ggZzGixReUakB2XNo2vCB6dtePcHFAiRC
	 LR8WNejm8hc5/Xph983BjA/qJqmRBYVGB456acgc9Ii+Iecb1TLauZwtoXZK7bcvxp1jU
	 0s9CppXuX4dMLHoxCGySzEfyFFC60pSW8cYb8NFFbnaE+A4F0RnUnarQo7tvD1jkbubRy
	 H7C9K692s+84l+1ZLJM7kOOqaCv+5ty1OhXTqTdQiCCrgk3fBfbdj02TAwaDwjRraByOq
	 wRmuxoGlx3lftU+dkyhA0P5xo5QQYylreYXBUDX/L9JZ973Viv/BUyG8Ewvuu5hgC6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.net;
	spf=pass smtp.mailfrom=gmx.net;
	dkim=pass header.d=gmx.net header.i=wahrenst@gmx.net header.a=rsa-sha256 header.s=s31663417 header.b=naFcrTKW;
	arc=none smtp.remote-ip=212.227.15.19
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEDE606A31C
	for <linux-can@vger.kernel.org>; Thu, 12 Nov 2026 12:27:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDEDE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.a=rsa-sha256 header.s=s31663417 header.b=naFcrTKW
DKIM2-Signature:  i=1; m=1; t=1794486448;
 mf=PHdhaHJlbnN0QGdteC5uZXQ+;
 rt=PGxpbnV4LWNhbkB2Z2VyLmtlcm5lbC5vcmc+;
 d=gmx.net;
 s=s31663417:rsa-sha256:Tkh2qTE4f4QSyJd6osPfy5h/t+x2
   YvErb3S3UnSWMCKfC4RXyQ4djLMi0SW9QiinvO18NY/syifykoh2MC3vfWAwIuLzePOMv6DpOCU
   zEN+EvVvMsdEsSNm15p1M03I8PQNSK8zV0Z76BrNgrpTjKEumD7Gw+0/5a3CL1jjtFhGtqTZqt+
   rzcd815tUmcCF4oM2e48M1lrH+uFRA4znVklUkum87YxWeYrA9zeKd4GAje05XHpVWD4c1t4Iz9
   CGqG/o/Ud28kYdcWLWdcZlyVg+Y3txjVpBegzKhiW0/haBwLDr5vpcKAenVm0/fOVQJl+jeBnwC
   o3I70Ybtp20c/A==;
Message-Instance:  m=1;
 h=sha256:
   BaBtObVm/yxyJnvi9tY1xwptib9aLxnFryMi4swngv0=:
   92uUB+F8awM+lk/iBkvVd+uBcwGd9xZHDk1vnh2Mons=,
  sha512:
   VcnEPFvgkXaubwOm+yb7uFe8VcnjM2hooT/eR7k5TY1AMjaluG1UtF8ZehzQP+TKv5mZ5Oq8vmshJcKWWrR70Q==:
   sole+cM0SIF50QMH6VC7cX7ZvOlFIVnppob53Clu9z0BaJeaqErUw+R6+ZeKSFMJilTfcJPPWABOxW/FidKD8A==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1794486431; x=1795091231; i=wahrenst@gmx.net;
	bh=S7yfW8a4jOm9PquT7mm+dF7gxrK1OkdAmj4fgTK6ApE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=naFcrTKWB1AzwZbbq07So8g1W1lqXq0KqBMUkHFVQFgQI+qRAnN/IGZkWjhoZaPw
	 JHvbNA36qfGIju6GbuL2tgczVhwgirT9QHHIhwkStOsC3NqYJxtcZS0rsNdCsWzxW
	 Cng4Hg7GqmfRU4Dzihu1hwsQ+gtWCKxV3jjIY/8q9u95VCF4dGEgmG4qqdvcsONX/
	 SpY6N6s7nSAXGEvvCWbb+0NC3NR9hzLNgRwYuC3sTvU5xqWlYdWq5oTlHpSlSKvRh
	 Fk8D1oFwraY9fURkq699VaO0eVkE/bJ78B5z2F3+WXTikEk3WRyjrgxJONkhLbLDC
	 t+MEVq7pPTk8v4bafw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mq2nA-1wfRld15F4-00lzXG; Thu, 12
 Nov 2026 13:27:11 +0100
Message-ID: <11a2e182-b41f-4d61-aef9-50e8e599b359@gmx.net>
Date: Thu, 12 Nov 2026 13:27:08 +0100
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] ARM: mxs: add EVAchargeSE board support
To: netdev-bot+sashiko@kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linusw@kernel.org, brgl@kernel.org, Frank.Li@nxp.com, vkoul@kernel.org,
 mkl@pengutronix.de, neil.armstrong@linaro.org, mailhol@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
 mani@kernel.org, devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
 linux-can@vger.kernel.org, linux-phy@lists.infradead.org, kuba@kernel.org
References: <20261106230746.21954-6-wahrenst@gmx.net>
 <179413989528.488853.11075194967877927671@kernel.org>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <179413989528.488853.11075194967877927671@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:msuzoZoYDhUxsHRxMDEbuk3Th+91/WmhR6OJrIS7c6ZJ9y5O8lG
 U24dUx/fvJ87+FP6++mTCqkHzjih24RUctISdFdODeryHp3gbnxIES6BuJ2NbHr6dRL4Zx9
 fHh/+4uIDNfr5eL33JPZ3UrUl1mMyJV+sO3iBxAKDIlI4DvA/V4nuj90k8IL5osSvjs1oaz
 9zy8fX+uc040GHcdrkDVQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pqDLMgbG9MA=;vhSN3G/UU/5XQR49sBzuYNJPcuW
 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
 Rf+nofhuTuKYmHKeU0jPzmb9h

Am 08.11.26 um 13:11 schrieb netdev-bot+sashiko@kernel.org:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwo=
rk
> know by including "pw-bot: cr" as a separate line at the end of your rep=
ly
> (one such reply per series is enough).
>
> - [Medium] The ethernet-phy@0 node in
>    arch/arm/boot/dts/nxp/mxs/imx28-evachargese.dts (an SMSC LAN87xx-clas=
s=E2=80=A6
> - [Low] The patch only adds
>    arch/arm/boot/dts/nxp/mxs/imx28-evachargese.dts and a dtb entry in=E2=
=80=A6
>
> --
>
> ARM: mxs: add EVAchargeSE board support
>
> This adds a devicetree for the chargebyte EVAcharge SE. It is an i.MX28
> based ISO 15118 controller for EV charging stations. The DTS enables eMM=
C,
> the debug UART, Ethernet, USB host, QCA7000 powerline over SPI, CAN and =
the
> board LEDs.
>
> Link: https://chargebyte.com/products/controllers-modules/evse-controlle=
rs/evacharge-se
>
>> ARM: mxs: add EVAchargeSE board support
> [Severity: Low]
> This isn't a bug, but the patch only touches arch/arm/boot/dts/nxp/mxs/.
> Should the subject use the dts prefix, for example "ARM: dts: mxs: Add
> chargebyte EVAcharge SE board"? The previous patch in this series, "ARM:
> dts: imx28: add alternative pinmux for CAN1", already uses that form.
>
> The product name is also spelled three different ways:
>
>    subject:    "EVAchargeSE"
>    body:       "EVACharge SE is a ISO 15118 compliant controller ..."
>    DTS model:  model =3D "chargebyte EVAcharge SE";
>
> The dt-bindings patch "dt-bindings: arm: fsl: support chargebyte EVAchar=
ge
> SE" uses "EVAcharge SE". Could the spelling be the same everywhere?
>
>> diff --git a/arch/arm/boot/dts/nxp/mxs/imx28-evachargese.dts b/arch/arm=
/boot/dts/nxp/mxs/imx28-evachargese.dts
>> new file mode 100644
>> index 0000000000000..75ddde2264936
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/nxp/mxs/imx28-evachargese.dts
>> @@ -0,0 +1,294 @@
> [ ... ]
>
>> +&mac0 {
>> +	phy-handle =3D <&ethphy>;
>> +	phy-mode =3D "rmii";
>> +	phy-supply =3D <&reg_3p3v>;
>> +	pinctrl-0 =3D <&mac0_pins_a &mac0_phy_reset_pin>;
>> +	pinctrl-names =3D "default";
>> +
>> +	status =3D "okay";
>> +
>> +	mdio {
>> +		#address-cells =3D <1>;
>> +		#size-cells =3D <0>;
>> +
>> +		ethphy: ethernet-phy@0 {
>> +			compatible =3D "ethernet-phy-ieee802.3-c22";
>> +			reg =3D <0>;
>> +			clocks =3D <&clks 64>; /* enet_out */
>> +			interrupt-parent =3D <&gpio4>;
>> +			interrupts =3D <5 IRQ_TYPE_EDGE_FALLING>;
>> +			max-speed =3D <100>;
>> +			pinctrl-0 =3D <&mac0_phy_int_pin>;
>> +			pinctrl-names =3D "default";
>> +			reset-assert-us =3D <500>;
>> +			reset-deassert-us =3D <500>;
>> +			reset-gpios =3D <&gpio4 13 GPIO_ACTIVE_LOW>;
>> +			smsc,disable-energy-detect;
> [Severity: Medium]
> Can the PHY ID be read here while the PHY is still held in reset?
>
> This node only has the generic c22 compatible, with no
> ethernet-phy-idXXXX.XXXX entry. So fwnode_mdiobus_register_phy() reads t=
he
> ID over MDIO before phylib has requested the reset GPIO:
>
> drivers/net/mdio/fwnode_mdio.c:fwnode_mdiobus_register_phy() {
>      ...
> 	if (is_c45 || fwnode_get_phy_id(child, &phy_id))
> 		phy =3D get_phy_device(bus, addr, is_c45);
> 	else
> 		phy =3D phy_device_create(bus, addr, phy_id, 0, NULL);
>      ...
> }
>
> The reset-gpios line is requested only after that, through this path:
>
> phy_device_register()
>    mdiobus_register_device()
>      mdio_device_register_reset()
>
> The reset is deasserted later still, in phy_probe().
>
> If nRST is low during the scan, the ID reads as all ones and
> get_phy_device() returns -ENODEV. __of_mdiobus_parse_phys() then just
> prints "MDIO device at address 0 is missing". The phy-handle in mac0 poi=
nts
> at a PHY that was never registered, so Ethernet doesn't come up.
>
> One way to hit this is to unbind and rebind the FEC driver, or to reload=
 a
> modular fec. On removal, phy_remove() and phy_device_remove() assert the
> reset before the GPIO is released:
>
> drivers/net/phy/phy_device.c:phy_device_remove() {
>      ...
> 	/* Assert the reset signal */
> 	phy_device_reset(phydev, 1);
>
> 	mdiobus_unregister_device(&phydev->mdio);
>      ...
> }
>
> mdio_device_unregister_reset() then calls gpiod_put(), but the pin keeps
> driving low. The next scan finds the PHY still in reset.
>
> The same failure could happen at first boot if the bootloader leaves
> GPIO4_13 low. This DTS muxes that pad as GPIO with MXS_PULL_DISABLE.
>
> Documentation/devicetree/bindings/net/ethernet-phy.yaml covers this case=
.
> It says that if a PHY needs a particular reset sequence before its ID
> registers can be read, the compatible list "must contain an entry with t=
he
> correct PHY ID".
>
> imx28-btt3.dtsi also has a LAN8720 with reset-gpios, and it does this:
>
> 	/* LAN8720Ai - PHY ID */
> 	compatible =3D "ethernet-phy-id0007.c0f0","ethernet-phy-ieee802.3-c22";
>
> Could this node get an explicit ethernet-phy-id compatible too? The
> smsc,disable-energy-detect property suggests an SMSC PHY, and the ID wou=
ld
> need to match the part fitted on this board.

That's a good advice, I will adapt my series.

Best regards

pw-bot: cr

