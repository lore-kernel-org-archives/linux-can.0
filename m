Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DDC55C1C3;
	Mon, 31 Aug 2026 13:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788184059; cv=none; b=DqZAA92r7HTQ1EeFWjo8nnb+yvOTd4L5+gIEglPqq2uNMEaqFvOLDZ90KDiExpVAe0ChYNOU5WouZBBR/YiJYQZfHxAFFIE8awbzo0g07eMbRxt/dlaPYmDBJaakBAwJWxDaHC+7WayUwd5Y0ggl77NUJS+Yiym41UZL8L2YmuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788184059; c=relaxed/simple;
	bh=UDuyMhgLF/nf0HbmEB4+rxuZfZiTrL+TJII+mnXTyXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JMk0O+XNuuCs0lKwFihA/soh2U2d+gnhyJBRygrzncB/f4pUl8SCN5j2QClr7biPL7UlM3xZ5rU4Nn6ZOiYW4/Lx+CvmEqlUEkJXl56exsfgrSFuif0sVKx+SWGFemOSvislmHi+Ow5xUYbUXYtEY58a28d5UAQxwn7Ore3zTWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=GFfHNwvs; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="GFfHNwvs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1788184036; x=1788788836; i=wahrenst@gmx.net;
	bh=ePV4JES9XxvVoQVNoDHrh+vUhV2Gki6cm2F4F/fbt18=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=GFfHNwvsgnAQhjBcNcG5Zxet3c0HKaWN+a9LW/1OBElUw2Z619z6Il6ajAO36uQ6
	 h6C16LvBLCHdMzkd3ruR8JhSqVDyHZUPGsvscBrDzR/pY21HJasP1x0f80wYsJNBm
	 lJCRVh++hhYYCgagWHXSSjgLiEcwr4RQqXo+W6eV3Ml5aI2MIl5PNZjk26d23Bo/9
	 SlFHgCav+6KUE3pRg8BEcVStO87VS5jc3iB4mvGIfgFCaaMwEESKjNKQTmC5mzEn2
	 QzRqj+d0kPEnW2s+NoWyBFBYv1iwyiZVQPT1CMA8qUb+iNzYdPcaeQYnLaQ19Bac/
	 1KRLGY32Q+ob8eHoiA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJVHU-1xKuei30MC-00WgUH; Mon, 31
 Aug 2026 15:47:16 +0200
Message-ID: <ceccb248-8801-402b-b147-916eb9ed3883@gmx.net>
Date: Mon, 31 Aug 2026 15:47:15 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 3/3] arm64: dts: freescale: Add chargebyte Charge
 Control Y
To: sashiko-reviews@lists.linux.dev
Cc: Vincent Mailhol <mailhol@kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Oleksij Rempel <o.rempel@pengutronix.de>, conor+dt@kernel.org,
 olteanv@gmail.com, vkoul@kernel.org, devicetree@vger.kernel.org,
 linux-phy@lists.infradead.org, Frank.Li@kernel.org, robh@kernel.org,
 neil.armstrong@linaro.org, Oliver Hartkopp <socketcan@hartkopp.net>,
 linux-can@vger.kernel.org, imx@lists.linux.dev
References: <20260831083539.8287-1-wahrenst@gmx.net>
 <20260831083539.8287-4-wahrenst@gmx.net>
 <20260831090445.0F50B1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
Autocrypt: addr=wahrenst@gmx.net; keydata=
 xjMEZ1dOJBYJKwYBBAHaRw8BAQdA7H2MMG3q8FV7kAPko5vOAeaa4UA1I0hMgga1j5iYTTvN
 IFN0ZWZhbiBXYWhyZW4gPHdhaHJlbnN0QGdteC5uZXQ+wo8EExYIADcWIQT3FXg+ApsOhPDN
 NNFuwvLLwiAwigUCZ1dOJAUJB4TOAAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEG7C8svCIDCK
 JQ4BAP4Y9uuHAxbAhHSQf6UZ+hl5BDznsZVBJvH8cZe2dSZ6AQCNgoc1Lxw1tvPscuC1Jd1C
 TZomrGfQI47OiiJ3vGktBc44BGdXTiQSCisGAQQBl1UBBQEBB0B5M0B2E2XxySUQhU6emMYx
 f5QR/BrEK0hs3bLT6Hb9WgMBCAfCfgQYFggAJhYhBPcVeD4Cmw6E8M000W7C8svCIDCKBQJn
 V04kBQkHhM4AAhsMAAoJEG7C8svCIDCKJxoA/i+kqD5bphZEucrJHw77ujnOQbiKY2rLb0pE
 aHMQoiECAQDVbj827W1Yai/0XEABIr8Ci6a+/qZ8Vz6MZzL5GJosAA==
In-Reply-To: <20260831090445.0F50B1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NtiKhPWYDQzWNbjpTe7PtXswj1atYkIo1j4qDXe6ZWHHRzTDTpd
 JFx7ksROHOGknGVdp1IDFB/8VulloSQMJCvaIe/jBd9csmGb5wJGk6eAEK85GJGGjksYFeq
 LWyhsE+xY+hUFB7UwKsJLQyySu/acf/xW6aUdxWXjpV0Mfq5GqmkrNXL63ROX1P30DdnpFy
 OZBj3sY4tmDo8AMelr83A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lsYFMLeZhCU=;dUGm+OHITs3YVRPznO9bpH6SUAv
 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

Am 31.08.26 um 11:04 schrieb sashiko-bot@kernel.org:
> Thank you for your contribution! Sashiko AI review found 3 potential iss=
ue(s) to consider:
> - [Medium] Missing GPIO initialization / Unused pin for X_nRST_LAN
> - [Medium] Missing Pin Mux Configuration for USDHC2_VSELECT in default s=
tate
> - [Low] DT Binding Violation: Undocumented compatible string 'microchip,=
mcp2542'
> --
>
> commit c595019b7dc419cc298a111c2b215904a12f65e1
> Author: Stefan Wahren <wahrenst@gmx.net>
> arm64: dts: freescale: Add chargebyte Charge Control Y
>
> This commit introduces device tree support for the chargebyte Charge Con=
trol Y,
> an Electrical Vehicle Supply Equipment for MCS charging stations based o=
n the
> phyCORE-i.MX 93 ARM SoM. It defines necessary pin multiplexing, peripher=
als
> like CAN and Ethernet, and device-specific layouts.
>
>> diff --git a/arch/arm64/boot/dts/freescale/imx93-charge-control-y.dts b=
/arch/arm64/boot/dts/freescale/imx93-charge-control-y.dts
>> new file mode 100644
>> index 0000000000000..0405098cc05c4
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/freescale/imx93-charge-control-y.dts
> [ ... ]
>
>> +	// Heartbeat LED of phyCore is not populated
>> +	/delete-node/ leds;
>> +
>> +	flexcan1_tc: can-phy0 {
>> +		compatible =3D "microchip,mcp2542", "ti,tcan1042";
> [Severity: Low]
> Is the "microchip,mcp2542" compatible string documented in any devicetre=
e
> binding schema?
This is included in patch #2.
> Using an undocumented compatible string here might cause `make dtbs_chec=
k`
> validation tooling to fail.
I verified this patch series with "make dtbs_check". False positive?
>
>> +		#phy-cells =3D <0>;
>> +		max-bitrate =3D <1000000>;
>> +	};
> [ ... ]
>
>> +	pinctrl_flexcan1: flexcan1grp {
>> +		fsl,pins =3D <
>> +			MX93_PAD_PDM_BIT_STREAM0__CAN1_RX	0x139e
>> +			MX93_PAD_PDM_CLK__CAN1_TX		0x1382
>> +		>;
>> +	};
>> +
>> +	pinctrl_gpio1: gpio1grp {
>> +		fsl,pins =3D <
>> +			MX93_PAD_I2C2_SDA__GPIO1_IO03		0x31e
> [Severity: Medium]
> Does the X_nRST_LAN reset pin (GPIO1_IO03) need a GPIO hog or a driver
> consumer (e.g., via a reset-gpios property) in the device tree?
>
> Since the upstream lan865x SPI kernel driver does not parse or manage
> reset-gpios, leaving its functional state unmanaged here might result in=
 the
> hardware reset pin floating or being left in an indeterminate state.
>
> Could this cause the LAN8651 Ethernet interface to fail to emerge from r=
eset
> and initialize properly on a cold boot?
As already mentioned in the cover letter, I like to proceed with the=20
version until the reset management is implemented in LAN8651.
The pin is not floating because there is a pull resistor in hardware.

Should I move the explanation to the commit message of this patch or add=
=20
a comment in the DTS?
>
>> +			MX93_PAD_PDM_BIT_STREAM1__GPIO1_IO10	0x382
>> +		>;
>> +	};
>> +
>> +	pinctrl_gpio4: gpio4grp {
> [ ... ]
>
>> +	pinctrl_usdhc2_cd: usdhc2cdgrp {
>> +		fsl,pins =3D <
>> +			MX93_PAD_SD2_CD_B__GPIO3_IO00		0x31e
>> +		>;
>> +	};
>> +
>> +	/* need to config the SION for data and cmd pad, refer to ERR052021 *=
/
>> +	pinctrl_usdhc2_default: usdhc2grp {
>> +		fsl,pins =3D <
>> +			MX93_PAD_SD2_CLK__USDHC2_CLK		0x119e
>> +			MX93_PAD_SD2_CMD__USDHC2_CMD		0x4000139e
>> +			MX93_PAD_SD2_DATA0__USDHC2_DATA0	0x4000138e
>> +			MX93_PAD_SD2_DATA1__USDHC2_DATA1	0x4000138e
>> +			MX93_PAD_SD2_DATA2__USDHC2_DATA2	0x4000138e
>> +			MX93_PAD_SD2_DATA3__USDHC2_DATA3	0x4000139e
> [Severity: Medium]
> Should MX93_PAD_SD2_VSELECT__USDHC2_VSELECT be included in this default
> state group?
>
> The MMC core initially brings up the SD card in the default 3.3V state. =
Without
> the USDHC2_VSELECT pad configured here, the controller might not be able=
 to
> actively manage the IO voltage selection in its default state.
>
> Could this absence lead to unpredictable external voltage regulator beha=
vior or
> SD card initialization failures?
Nice catch, will fix it

Best regards
>
>> +		>;
>> +	};
>> +
>> +	/* need to config the SION for data and cmd pad, refer to ERR052021 *=
/
>> +	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {

