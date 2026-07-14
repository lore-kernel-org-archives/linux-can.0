Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719AD3126B9;
	Tue, 14 Jul 2026 17:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784051675; cv=none; b=koWWaoHSlQflPeuX9L+mMd8ANOMkuZrcQqG/QgJYUodWaLvQJPKW5EI2on/V3JjhFrYWMcq9E4C6ObH+uRU96SoiS61epmtefLW1lZN6Pkb0yZlK3LXABoCveBAO5Mm0fctuStkfDS3+NgU7xLN/tfm/1V9sYdxnczDOdzbb0AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784051675; c=relaxed/simple;
	bh=Dx+e7T9cCahtkQxpXJNSLJzuwCfMpSxdd/xgu4/IuBs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hrL8Kehe4rTTHILOwNk3oAzn2FltLJnuSfhmJrTJljEIcUrj/IHUWnaDPVQIS3j6+CtXup6J2UPjk0oMBjlpb7VD/6RIZY2DRFjEBs+n7HoHnnOTPgS9hCv9wS0MOBP4lwRA66kEKrZikd0NCZ+mEMrMrgzkiETk0KUvJfL6kR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uw9eIzi3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uw9eIzi3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27DC51F000E9;
	Tue, 14 Jul 2026 17:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784051672;
	bh=XPewxuZRF9z4S+ro9YDZUHdmLCkNKtkTf8oxTucxc8U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Uw9eIzi3qXKLSMXlywsvS3mZ0ZjwluGvoOphnYVP0+Idc0Soj/LmVvInxYOiOJlxy
	 BdAZrHTpfHLA61JpfEylilG0IvOAfq/SPYtCJoUTNm+ut/RAaZZA3tUW51wsLMUzD+
	 cXQ6yQtMF5pAzrZvcPu6Gv7vSWR42/E+hXx8lcxWgIRF5JNLrmEmfcEgHsdJVRw7KE
	 kw33jNAxiECYByzTw2n0m+yHtXe1VgRZPv367pVdRThUyd68mD0EVACw5Y59S7y0qu
	 fm7602Q4gYPssarH6qxUJBF1C+6rIjVqN5dqGjOOmoDRdNOmKB/KehIAaMoUI53s7w
	 3/9g+vLq+9tmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 8/8] arm64: dts: renesas: rzg3s-smarc: Enable CAN-FD
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea+renesas@tuxon.dev>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oliver Hartkopp" <socketcan@hartkopp.net>, wsa+renesas@sang-engineering.com
In-Reply-To: <20260714173315.1981708-9-claudiu.beznea+renesas@tuxon.dev>
References: <20260714173315.1981708-1-claudiu.beznea+renesas@tuxon.dev>
 <20260714173315.1981708-9-claudiu.beznea+renesas@tuxon.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 17:54:31 +0000
Message-Id: <20260714175432.27DC51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] CAN-FD channels are enabled unconditionally despite their transc=
eivers being physically hardwired to standby mode by default.
--

--- Patch [8]: [PATCH v3 8/8] arm64: dts: renesas: rzg3s-smarc: Enable CAN-=
FD ---
commit 63f365e669fda8daca391467cd1aa1fe6a6efb02
Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

arm64: dts: renesas: rzg3s-smarc: Enable CAN-FD

This commit enables the two CAN FD channels available on the Renesas RZ/G3S
SoC, routing them through the SMARC Carrier II board. It adds nodes for the
transceivers and configures pinmuxing, noting that the standby pins share
GPIOs with PMOD interfaces via hardware switches.

> diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-switches.h b/arch/ar=
m64/boot/dts/renesas/rzg3s-smarc-switches.h
> --- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-switches.h
> +++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-switches.h

[ ... ]

> +/*
> + * SW_GPIO_CAN_PMOD[x] switches' states:
> + * @SW_GPIO_CAN_PMOD1:
> + *	SW_OFF - GPIO8 connected to CAN0_STB (position 1-2)
> + *	SW_ON  - GPIO8 connected to PMOD1 (position 2-3)
> + * @SW_GPIO_CAN_PMOD2:
> + *	SW_OFF - GPIO9 connected to CAN1_STB (position 4-5)
> + *	SW_ON  - GPIO9 connected to PMOD1 (position 5-6)
> + */
> +#define SW_GPIO_CAN_PMOD1	SW_ON
> +#define SW_GPIO_CAN_PMOD2	SW_ON
> +
>  #endif /* __RZG3S_SMARC_SWITCHES_H__ */

[ ... ]

> diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi b/arch/arm64/bo=
ot/dts/renesas/rzg3s-smarc.dtsi
> --- a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
> +++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi

[ ... ]

> +	can_transceiver0: can-phy0 {
> +		compatible =3D "ti,tcan1042";
> +		#phy-cells =3D <0>;
> +		max-bitrate =3D <8000000>;
> +#if SW_GPIO_CAN_PMOD1 =3D=3D SW_OFF
> +		standby-gpios =3D <&pinctrl RZG2L_GPIO(13, 0) GPIO_ACTIVE_HIGH>;
> +#endif
> +	};
> +
> +	can_transceiver1: can-phy1 {
> +		compatible =3D "ti,tcan1042";
> +		#phy-cells =3D <0>;
> +		max-bitrate =3D <8000000>;
> +#if SW_GPIO_CAN_PMOD2 =3D=3D SW_OFF
> +		standby-gpios =3D <&pinctrl RZG2L_GPIO(13, 1) GPIO_ACTIVE_HIGH>;
> +#endif
> +	};

[ ... ]

> +&canfd {
> +	pinctrl-0 =3D <&canfd_pins>;
> +	pinctrl-names =3D "default";
> +	status =3D "okay";
> +
> +	channel0 {
> +		phys =3D <&can_transceiver0>;
> +		status =3D "okay";
> +	};
> +
> +	channel1 {
> +		phys =3D <&can_transceiver1>;
> +		status =3D "okay";
> +	};
> +};

[Severity: Medium]
Since SW_GPIO_CAN_PMOD1 and SW_GPIO_CAN_PMOD2 default to SW_ON, the
standby-gpios nodes are omitted for the transceivers.

Does unconditionally setting status =3D "okay" here expose broken CAN inter=
faces
to userspace by default? If the transceivers fall back to internal pull-ups=
 and
enter standby mode, won't any transmission attempt blackhole and result in
immediate bus-off errors?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714173315.1981=
708-1-claudiu.beznea+renesas@tuxon.dev?part=3D8
