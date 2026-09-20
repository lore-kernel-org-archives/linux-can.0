Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018C7456293;
	Sun, 20 Sep 2026 23:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789946014; cv=none; b=tislWwD3V7HRO4Tutc2MjEvneN9S1EoXCIbSlIcy/2Vfq2DqfRvvhzOs/N1DwdIDmWpTvrQ1E7CthFCITwe8CJ3d67DiNk2NwComEvEEc4c3uxwJkbJ7UUX8WuB6ouIWUdJkiYQdwHS+zVA46WJQv0IbOblXqgyPTCVbHf0BfM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789946014; c=relaxed/simple;
	bh=a4/UrZar8cPi57XJmDtnkA3Y2ToL8Y0OdGdavnIqOww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NRJf30S0SLIbkjgx6d+2AheazoYSnl6cLM6JsMDKC3bZklv12xFkq1fj/q3yaIFo+7fOUsT8wQPqz6PeKODp386E1gy3i1BhmzVx8+SZWo+nuyWHJb+OqCNBfZrrj8cQH9kkOByuZUaPjJ8eQ78h43n3MDnZBKLWMZO597cICeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=FSSH8Ul/; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="FSSH8Ul/"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A7FDE105209;
	Mon, 21 Sep 2026 01:13:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1789946001;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=l0nF7Y90i1a32N+Eh1IDD4CMXzDQOFfRkIgkTxsD3ZY=;
	b=FSSH8Ul/X0/nKhRZP9ikjxPyURHV7Bln+4XfjITgOjnXHFht+v2Fh4uzGH6GwHz+ZmYaiL
	jLmu5IjsAhO2fKUWMmIX2egVR62IdFpJTPitvH24K08/w2c87OsGRm7TGe7tsY4/aNguFT
	XfEl071Bdw5epFx7DhfQZ3XFqNJUUCFo1WDAb4BBj6gmKLcjCYSJObXglBKxjrkg/E++rB
	P8xTuogrmqNtPeTeglwDTIzg10WbX8OA9Xl+iuJENsADP7lieWriM3teUpt1anvEbdjS4z
	bi8ArjAKrQhZYl/99sewUsYj0r2nlHkKw3qFspYhg8uL1liqc5bqO/RSriRcwg==
Message-ID: <bca6ea91-297b-4316-b5db-74636593b084@nabladev.com>
Date: Sun, 20 Sep 2026 19:05:58 +0200
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
 <c1197d8e-add5-48b7-b0ba-a5a91379ab04@nabladev.com>
 <aq1DnBkxgF49QLwa@SMW015318>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <aq1DnBkxgF49QLwa@SMW015318>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 9/18/26 3:58 PM, Frank Li wrote:

Hello Frank,

>>>>>>> +	reg_panel_vcc: regulator-panel-vcc {
>>>>>>> +		compatible = "regulator-fixed";
>>>>>>> +		regulator-min-microvolt = <3300000>;
>>>>>>> +		regulator-max-microvolt = <3300000>;
>>>>>>> +		regulator-name = "PANEL_VCC";
>>>>>>> +		gpios = <&i2c2_gpio_expander_20 17 0>;
>>>>>
>>>>> gpio third arg 0, means GPIO_ACTIVE_HIGH
>>>>>
>>>>> 	so need enable-active-high
>>>>>
>>>>> if your boards have invertor should use GPIO_ACTIVE_LOW
>>>>
>>>> I already went through all that, please see "Re: [PATCH 3/3] arm64: dts:
>>>> imx95: Add support for Data Modul i.MX95 eDM SBC" .
>>>
>>> at https://lore.kernel.org/imx/f4dbeaac-ab10-4980-9fc5-533907be223c@nabladev.com/
>>>
>>> <&i2c2_gpio_expander_20 17 0>;
>>>                              ^
>>>
>>> 0 should use predefine MACRO, after I check 0 means GPIO_ACTIVE_HIGH.
>>>
>>> so need enable-active-high for regulator.
>>
>> This is extended via a DTO, so no, I must not use a macro because I do not
>> know the polarity of this signal, that is why there is 0 here.
>>
>> The enable-active-high DT property must explicitly NOT be here, because the
>> DTO can not remove properties from the base DT. Adding enable-active-high
>> here would make the DTO unable to operate this signal as active-low .
> 
> 
> But why DTO need update regulator-panel-vcc's gpio informaiton. I suppose
> it is fixed when board design.

It is just a GPIO, it can have either polarity depending on the 
regulator that it controls.

-- 
Best regards,
Marek Vasut
