Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EC34A49B2;
	Thu, 17 Sep 2026 23:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789687794; cv=none; b=WrEXTed+Rok3IpN0YI0hpbFbulCSbWFTxBOj7b8gZUaer4h3cQyYbDnBcKlwekTLNQ0dLVkidx1qqlM5PwC2/xn4pRvMRwo7T6fTH9k9HJCi69ikImFTGut6o+fHUaKq65XwmDiMP4AtYMWHrKvOld3RDReMPxOqO8MEe4Vytqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789687794; c=relaxed/simple;
	bh=+wThaceYaumvqrlLGJjmaCxwCmZqb2Yg8iLHvDJDlWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DUJ6CYa4EcDNbcYhjJ3Cdnjra1N4jfk/4ScF8DdzydaK24QL0jxrhKpG+zAC/VlUPbkGphfFPb/JihPvQM8SUJrDWzbK05VoLfRzlUKwm4rwaOuXH7QwccSidf6qxdGNemg52c/1ihEIWd8OMhChtiSL11h58RcP5dDq8PIqSH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=B5p+Xnzi; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="B5p+Xnzi"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B7772104FC5;
	Fri, 18 Sep 2026 01:29:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1789687779;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=jb9kTzrVW1dq0qOxk5XiOXPRymJIq91r5cgA7YkMm+E=;
	b=B5p+Xnzi4qADShABAWEd3PEzfS9gkwIDd+59N4VPaniiqPy/VFxBgd66qYcg6beuNcMME7
	BIcBBzPE0j/deTNpIB23YuOBllZDNcnCO1SD2MQjGzVcVSseOjaW9IdWKT2ff5HB8e165h
	e6SZe2d0WHus7klHCkcFDvc1fU7HI0iZPLB/hYeLYxvJAqs2/PZq6HRss3xDgjAECMBFB4
	1y7r6ot4gs83AX2A0CRRIbNLoPIjy8V2PM0AFpDEGBQikXbufe1YQ6AJ7kMFLyJ/EtCQ7C
	NttVKw4HqNRWRbThJQ5gyAv0Oe1Uu2QYOpjN5c+DCeHw5fBEto+WaznvKd3Rjg==
Message-ID: <c1197d8e-add5-48b7-b0ba-a5a91379ab04@nabladev.com>
Date: Thu, 17 Sep 2026 20:55:56 +0200
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
 <384c5f71-d5ab-4990-9567-027605457439@nabladev.com>
 <aqw1agBrSjYoy71_@SMW015318>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <aqw1agBrSjYoy71_@SMW015318>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 9/17/26 8:46 PM, Frank Li wrote:

Hello Frank,

[...]

>>>>> +	reg_panel_vcc: regulator-panel-vcc {
>>>>> +		compatible = "regulator-fixed";
>>>>> +		regulator-min-microvolt = <3300000>;
>>>>> +		regulator-max-microvolt = <3300000>;
>>>>> +		regulator-name = "PANEL_VCC";
>>>>> +		gpios = <&i2c2_gpio_expander_20 17 0>;
>>>
>>> gpio third arg 0, means GPIO_ACTIVE_HIGH
>>>
>>> 	so need enable-active-high
>>>
>>> if your boards have invertor should use GPIO_ACTIVE_LOW
>>
>> I already went through all that, please see "Re: [PATCH 3/3] arm64: dts:
>> imx95: Add support for Data Modul i.MX95 eDM SBC" .
> 
> at https://lore.kernel.org/imx/f4dbeaac-ab10-4980-9fc5-533907be223c@nabladev.com/
> 
> <&i2c2_gpio_expander_20 17 0>;
>                             ^
> 
> 0 should use predefine MACRO, after I check 0 means GPIO_ACTIVE_HIGH.
> 
> so need enable-active-high for regulator.

This is extended via a DTO, so no, I must not use a macro because I do 
not know the polarity of this signal, that is why there is 0 here.

The enable-active-high DT property must explicitly NOT be here, because 
the DTO can not remove properties from the base DT. Adding 
enable-active-high here would make the DTO unable to operate this signal 
as active-low .

>>>>> +	tas2552: audio-codec@40 {
>>>>> +		compatible = "ti,tas2552";
>>>>> +		reg = <0x40>;
>>>>> +		#sound-dai-cells = <0>;
>>>>> +		avdd-supply = <&reg_1p8v>;
>>>>> +		iovdd-supply = <&reg_3p3v>;
>>>>> +		vbat-supply = <&reg_5p0v>;
>>>>> +		enable-gpio = <&i2c2_gpio_expander_20 23 GPIO_ACTIVE_HIGH>;
>>>>
>>>> [Severity: Low]
>>>> This isn't a bug, but should tas2552 be using the enable-gpios property name
>>>> instead of the deprecated enable-gpio? The patch changelog mentions replacing
>>>> gpio with gpios DT properties.
>>>
>>> Please fix this one.
>>
>> No, this is correct, see
>>
>> Documentation/devicetree/bindings/sound/ti,tas2552.yaml:  enable-gpio:
> 
> It is fine now, I suggest update bindings to allow both. which convert
> by Rob at Jan 2026. I think Rob may miss it.
> 
> kernel hack code covert -gpio to -gpios
I'll add that into my todo, but that is a separate fix from this DT.
