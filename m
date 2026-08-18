Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD829269D18;
	Tue, 18 Aug 2026 13:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787060437; cv=none; b=OelY/90S4rzyqcefec6TiFO9t9uCyKgQo/g4LWzcv8bgcU16TWQhVdBNuFEhnzowRF8S5DdlwPmYOKSzQLOgI1kII0deDmEfcs63NlN38WVyp+MeUFpifq0A9tAjJrxLBskz4numLVsSjTV8G8mXWVffIzCVC382++fHiu9fVr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787060437; c=relaxed/simple;
	bh=q1HXmxsYw3VPMyVIgkegbGgbnVld/tTh8+CcTOjEedc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lL01lTxkyXzTKe7CqZHy+x10USJeAGgw4ky3x4wC1qq6ICIm3kSLz7LMMxrUhmptTQ3id6rNGTWK5rdKo+2MF2003eNYCIF/Q9m8dFHF1GTMJUZGfJA1gdv+f5WAUyIeyPjb8SDrJEZSTi0K25N3XfA6EQ3Y5pE3bFH2NSRIutU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=MpT/8HBo; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="MpT/8HBo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1787060425; x=1787665225; i=wahrenst@gmx.net;
	bh=uBLreJoAatdAgd4F7c2jyWDMu6Rakjhu50UtWsOq9H4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=MpT/8HBoHPNUEy3v9N2U0cyvtEfxmHKRgGIBLddJg9NDT9n7h/AThoAxathMeaDm
	 Zvcurittw1NHaHDR4fcJIKEbkiylFiA4VUKt88YNsib+V1lCIDhYv1OLkV/y4iw6Y
	 RLj77GuhQzbhXzFXdA4t9/rf+ZRyrIspUX4hX1rHTu/Ks6tmyx3EoFv15qkaXlMhc
	 YVzlpBmwCGQGiYgRjzbdlhL5yyi1X0CXDs8yDGftjA5jEnetyWer0YbBg75gkz7eO
	 MnmntsVfjeAG2+zHNyXPgOMLGPJQm/mMwCTNtP4pKvIEAFz6fIdBj2zyO/hUEM76R
	 OcYusplUcKJCGky6Yw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MmlXA-1wVU1n0dOw-00q83l; Tue, 18
 Aug 2026 15:40:25 +0200
Message-ID: <89573332-94a0-4fc9-b4b4-be100a97de6e@gmx.net>
Date: Tue, 18 Aug 2026 15:40:22 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 4/4] arm64: dts: freescale: Add chargebyte Charge
 Control Y
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
 Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>,
 Ciprian Regus <ciprian.regus@analog.com>
Cc: imx@lists.linux.dev, Oliver Hartkopp <socketcan@hartkopp.net>,
 Oleksij Rempel <o.rempel@pengutronix.de>, vkoul@kernel.org,
 olteanv@gmail.com, devicetree@vger.kernel.org, conor+dt@kernel.org,
 Frank.Li@kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
 linux-can@vger.kernel.org, neil.armstrong@linaro.org,
 Vincent Mailhol <mailhol@kernel.org>, robh@kernel.org,
 linux-phy@lists.infradead.org, sashiko-reviews@lists.linux.dev
References: <20260818091701.6441-1-wahrenst@gmx.net>
 <20260818091701.6441-5-wahrenst@gmx.net>
 <20260818093147.E556C1F000E9@smtp.kernel.org>
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
In-Reply-To: <20260818093147.E556C1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:H3DTMWZb7NOjk4zU96aE3+k+FecZQhiHsAiy4S5GXrRAIQnuT98
 c1AMdD4z0yvTj0A3+52l4i2+Y3Q9i8imBCbguXVUxU9OmVRweiVhgoapb3tL5nouN0GT0kn
 GkECzEzn+fRhaC4GErgxduPUqXr4ttylsLFw+vnUsUgaqGKZ7ULIFSsUp9K/MUJA9/Xziri
 xcYJxza8yO5WZGV+Br2nQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jDO1OcUKN0g=;9+m18WZp6vP0Xu+7knNwz7QqihC
 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

Hi Parthiban,
hi Selvamani,
hi Ciprian,

Am 18.08.26 um 11:31 schrieb sashiko-bot@kernel.org:
> Thank you for your contribution! Sashiko AI review found 4 potential iss=
ue(s) to consider:
> - [Medium] The LAN8651 ethernet device is missing its hardware reset con=
figuration, leaving the `X_nRST_LAN` pin unmanaged.
> - [Medium] The SD card slot power/reset pin (`SD2_nRESET`) is named in `=
gpio-line-names` but is not associated with any regulator or reset control=
.
> - [Low] The GPIO label `X_LAN_nCS` is incorrectly placed at index 0 of `=
&gpio2`'s `gpio-line-names` array, but the `lan8651` chip select is actual=
ly wired to index 8.
> - [Low] The `ti,leds-polarity` property used in both Ethernet PHY nodes =
is undocumented, invalid, and will cause `dtbs_check` validation errors.
> --
>
> --- Patch [4]: [PATCH RFC 4/4] arm64: dts: freescale: Add chargebyte Cha=
rge Control Y ---
> commit a177a5e0acba62156876ea6dc84457789786bfb8
> Author: Stefan Wahren <wahrenst@gmx.net>
...
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
> [Severity: Medium]
> The pin X_nRST_LAN is labeled in the gpio1 node, but this ethernet node
> doesn't seem to configure a reset mechanism. Does the LAN8651 need a res=
et
> control or gpio-hog to ensure the pin is driven and not left floating?
according to the current DT binding of LAN8651 there is no reset=20
control, but the chip has a reset line and its wired on our board.

Are there any plans to implement reset control for OA TC6 or LAN8651?

Best regards
