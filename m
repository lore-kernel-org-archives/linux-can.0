Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65325515968;
	Thu, 17 Sep 2026 17:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789665602; cv=none; b=YBZsd1HQfQUiAqSZiskxF9AlUrkm/SProx5NmiXJQvN76tFdQrwa/dCUb6raz5Zo3Otm83d53pWf6/dPFoPQcxSbjtim2ITq1vSswFcl2Wo4unk5gEoj+rDX/ZvB3oDxaH7VRFpkHEktjjzGpc+zccERnD3nhz2bupq85DYZhLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789665602; c=relaxed/simple;
	bh=R0ONL2o/LfPVOJgZsq7tuYgG+fCoHJMI9T5qkwLX+Rs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iyCq6BSOOVgTKPSvA/2LSb0XPg/MhJeT0XZx8Y45ZNpkYtIrrHU+KCjIbxd2Na0PRbflDto2gRBZb48YS5tnwuCYFn6khTAJxP7I2bmusRaUpi/qzZ2rmMYSqmaInzj+qYUeaD/6Ab3o4xCT8EzAWuhEtU3SJWcaFRT2KOyS4sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=hbAntrdX; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="hbAntrdX"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 788A5104A72;
	Thu, 17 Sep 2026 19:19:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1789665593;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=JbJfZ7HWZXoGV1NUUiVeTQ0E9qnkrZvs/phdAislXR4=;
	b=hbAntrdXnD7oLB6gg92LCJ86k5Wbk2Tq0YhOe0Mj0XEO0QIBLEg46AO4Zl0Kw0K5AC5Y13
	m3sIKrLY9wwgQuZhYlUeQYxmKb0QN0xDt3k5ybE7n7QAnrFqWio/o1v4XoZ6OyyYCmf8OC
	GFEewNIN5aRokImMMrykhdcxaNh1wQI1MYPikq61ZKsBWgmK6Y5Pa1chFj/7vAIpbB/+mt
	EAGH7Xu79KZniXbwy+NNiOcfILW/3DDwK3TY8lgT09qNDk7rzYIyrGVzx9rSTKVC7krpYi
	6apakmOj6GhXoSUmnasoUcaBbMLBUOAsueov8jQQlqWhGaVL6fw6pBOW4I3Ldg==
Message-ID: <384c5f71-d5ab-4990-9567-027605457439@nabladev.com>
Date: Thu, 17 Sep 2026 19:19:51 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] arm64: dts: imx95: Add support for Data Modul
 i.MX95 eDM SBC
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, robh@kernel.org,
 Frank.Li@kernel.org, imx@lists.linux.dev, conor+dt@kernel.org,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Oleksij Rempel <o.rempel@pengutronix.de>, linux-can@vger.kernel.org,
 Vincent Mailhol <mailhol@kernel.org>, devicetree@vger.kernel.org
References: <20260917062543.534416-1-marex@nabladev.com>
 <20260917062543.534416-3-marex@nabladev.com>
 <20260917063512.C71F51F000FF@smtp.kernel.org> <aqwbBQUSfd60nVeI@SMW015318>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <aqwbBQUSfd60nVeI@SMW015318>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 9/17/26 6:53 PM, Frank Li wrote:

Hello Frank,

> On Thu, Sep 17, 2026 at 06:35:12AM +0000, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 6 potential issue(s) to consider:
>> - [High] dts: pcal6524 interrupt polarity is incorrectly set to LEVEL_HIGH
>> - [Medium] dts: Ethernet PHY reset-gpios configured with wrong polarity
>> - [Medium] dts: eMMC reset GPIO defined but unused in usdhc1
>> - [Medium] dts: reg_panel_vcc regulator missing enable-active-high property
>> - [Medium] dts: M.2 Key-E (usdhc3) slot missing power regulator
>> - [Low] dts: tas2552 codec uses deprecated enable-gpio instead of enable-gpios

[...]

>>> +	reg_panel_vcc: regulator-panel-vcc {
>>> +		compatible = "regulator-fixed";
>>> +		regulator-min-microvolt = <3300000>;
>>> +		regulator-max-microvolt = <3300000>;
>>> +		regulator-name = "PANEL_VCC";
>>> +		gpios = <&i2c2_gpio_expander_20 17 0>;
> 
> gpio third arg 0, means GPIO_ACTIVE_HIGH
> 
> 	so need enable-active-high
> 
> if your boards have invertor should use GPIO_ACTIVE_LOW

I already went through all that, please see "Re: [PATCH 3/3] arm64: dts: 
imx95: Add support for Data Modul i.MX95 eDM SBC" .

[...]

>>> +	tas2552: audio-codec@40 {
>>> +		compatible = "ti,tas2552";
>>> +		reg = <0x40>;
>>> +		#sound-dai-cells = <0>;
>>> +		avdd-supply = <&reg_1p8v>;
>>> +		iovdd-supply = <&reg_3p3v>;
>>> +		vbat-supply = <&reg_5p0v>;
>>> +		enable-gpio = <&i2c2_gpio_expander_20 23 GPIO_ACTIVE_HIGH>;
>>
>> [Severity: Low]
>> This isn't a bug, but should tas2552 be using the enable-gpios property name
>> instead of the deprecated enable-gpio? The patch changelog mentions replacing
>> gpio with gpios DT properties.
> 
> Please fix this one.

No, this is correct, see

Documentation/devicetree/bindings/sound/ti,tas2552.yaml:  enable-gpio:

[...]
