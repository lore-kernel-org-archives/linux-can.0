Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D57A3C9438;
	Thu,  9 Jul 2026 18:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783622403; cv=none; b=Fnx8Bn6ccdF4CWJoNOShvlJTuxp/XnNlGLpbCLoPAJIwf7JYK1/dmY4b5//XZyycxwSCPuoIVc+ShRvnzBg+J1km+1hqE6cPAQ8mvoTbDjBaQHEgIKfFmUgoKiPxIBytwz98zhCx+RFEd88iMDdegZ/AF7j1pXzWf6g8gG5sua0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783622403; c=relaxed/simple;
	bh=47kW3KA8Z8WwgY7ItruwKx3ssbZvBelindLXBM69bRY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sSWSMe/OBF9uWeS/BZ4bI9aW0VEZveT5gB7Z3pwvgu2hkvXvFR6SuFeowaYBhvkDjRGMRDhm56C670zajaHpLHye8CpxSltTcCXcxMhqhR4GjlQEhFviUE55LmdSRYICwnuDdksKaJLJZVKR9LAsgcjqqmyCfs2qeuYUF8RV8m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2JNXmS3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2JNXmS3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C14A1F00A3A;
	Thu,  9 Jul 2026 18:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783622402;
	bh=GVO0zbtTGzt0xO2bW0DTxnb5RTLWPS+35cwfdOaeaQ0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f2JNXmS329O2inghmd4K5oc9TMO47dyWZIWmTJ0XMaC6WpymOoDr0dTKVd/NLSddv
	 lI+A902kGGbhEqhZvGzG2adzBRc0L5d7sTgnHdqPiSeNa0kWzzLbXBulFvAu0R2Rbp
	 gb6PpZJOwuG4U3QI3pHuAylPs10C+3BsiTYiOB4L+pMG6eXe9z0Gv1TD/hv4XzvW2R
	 FwJCtkAwMQSDMcwAwEKR9rh7RJjUFjRKmwwf/V79bM5UjdD/xt669wR1tuRFzX+urT
	 f4ADcZZx5LXX/R5pJTl4FZpn6UV/mc7x8D2jvHgGeJ4kB/CHS8sYXEVmq0OsUGagn1
	 dxWtW+c4tjcFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 8/8] arm64: dts: renesas: rzg3s-smarc: Enable CAN-FD
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea+renesas@tuxon.dev>
Cc: wsa+renesas@sang-engineering.com, devicetree@vger.kernel.org, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, robh@kernel.org, "Oliver Hartkopp" <socketcan@hartkopp.net>, conor+dt@kernel.org, "Vincent
 Mailhol" <mailhol@kernel.org>, "Marc Kleine-Budde" <mkl@pengutronix.de>, linux-can@vger.kernel.org
In-Reply-To: <20260709182332.876408-9-claudiu.beznea+renesas@tuxon.dev>
References: <20260709182332.876408-1-claudiu.beznea+renesas@tuxon.dev>
 <20260709182332.876408-9-claudiu.beznea+renesas@tuxon.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 18:40:00 +0000
Message-Id: <20260709184001.9C14A1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] CAN channels are enabled unconditionally even when their transce=
iver standby pins are disconnected by hardware switches, rendering the CAN =
bus physically inoperable.
--

--- Patch [8]: [PATCH v2 8/8] arm64: dts: renesas: rzg3s-smarc: Enable CAN-=
FD ---
commit f8b012ec526a1699faa0dea73b3d5f10dc6c3d9d
Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

arm64: dts: renesas: rzg3s-smarc: Enable CAN-FD

This commit enables the CAN FD controller and its two channels on the
Renesas RZ/G3S SMARC Module. It conditionally sets up the standby GPIOs
for the CAN transceivers based on the states of the SW_GPIO_CAN_PMOD
switches.

> diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi b/arch/arm64/bo=
ot/dts/renesas/rzg3s-smarc.dtsi
> index 70af605168b07..2be684f559144 100644
> --- a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
> +++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
[ ... ]
> @@ -92,6 +110,22 @@ &audio_clk2 {
>  	clock-frequency =3D <12288000>;
>  };
> =20
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
Since SW_GPIO_CAN_PMOD1 and SW_GPIO_CAN_PMOD2 are SW_ON by default, the
transceiver standby pins are disconnected from the SoC GPIOs. Because the
TCAN1042 PHY has an internal pull-up on the STB pin, leaving it floating
forces the transceiver into standby mode.

Does setting status =3D "okay" here unconditionally expose inoperable CAN b=
us
interfaces to userspace? Should the channel status be guarded by the same
switch macros used for the standby-gpios properties?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709182332.8764=
08-1-claudiu.beznea+renesas@tuxon.dev?part=3D8
