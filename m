Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B4E4E0B78;
	Mon, 21 Sep 2026 18:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790016224; cv=none; b=j5kZZ6PZ5Z/A2Hg8VLZOE2wbmeG48XkRvH03DNjp9nQb5lABPTrqdWY7OG1MEE0de9x/t+Oup/dpVW1ItasLsDhtPqF3oAd1phDgNGHHM8J96WDWuq8cPfBlREKNBqyU4DmvazHQBw/H6i1yADVOxOYdOmEdU/LTLkXiiijJKAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790016224; c=relaxed/simple;
	bh=79Td6Ow26+fiN1SQqDAZSqIZfz1xoZOl3K2f9eaBKG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UJRyoVXwhlybTKKlnh1UXyl4Hz+mOLSmav4IPPWfPiVvhyn0D3Lo3x0YA8u8ACGZP5cLJhmzPisSyYHmz26B70kSXQi55h/jQFRBhSJ9sR5kPKHhagJH4CkNsXvyO9k+CRDx0YZMsi6WA0dMpld5HHKEYBWDQTCtY3euArZnYQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=aN2nhgCo; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="aN2nhgCo"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 352B51054BC;
	Mon, 21 Sep 2026 20:43:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1790016216;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=Tx0BYBtzpR8M6ka00ktkwTGv2KodO45+NTWRQQO4iZo=;
	b=aN2nhgCoSHJcpEueADAneHbrnmsARAzMi9G22VnUtge0hhR3S1J+imwNCdMWEd2j96t1g8
	LgvDr9b42AFmm/5vXdcB7T0VgeoFKUaoWrL2G3lJ2bhlgcHjYcCLmHDXrZNXIlDGDrGR2o
	unBTqt0yh4+JtRAH7I8cIk3DtdECBcOCk+OlNKYavJBaTvKGo7eClKXI5GXl3YeE0Gshca
	3/3Rw4mcm65n1tJkv20nMCfwlKod3HTc9DX3SMwhdTa7CVyfZw1DwP8IyRk+uFE0nwXSln
	Bq6D9kp2MkFwbnBNGtro2GiRdIBfeoRY4bs5FZKaTZ0VEF/N8mD3umDtYoKfFw==
Message-ID: <abd334fb-22d4-4b71-9d44-4aa3c2789b79@nabladev.com>
Date: Mon, 21 Sep 2026 20:43:35 +0200
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
References: <20260917062543.534416-3-marex@nabladev.com>
 <20260917063512.C71F51F000FF@smtp.kernel.org> <aqwbBQUSfd60nVeI@SMW015318>
 <384c5f71-d5ab-4990-9567-027605457439@nabladev.com>
 <aqw1agBrSjYoy71_@SMW015318>
 <c1197d8e-add5-48b7-b0ba-a5a91379ab04@nabladev.com>
 <aq1DnBkxgF49QLwa@SMW015318>
 <bca6ea91-297b-4316-b5db-74636593b084@nabladev.com>
 <arFaPA6aeFey9WlI@SMW015318>
 <c43d3f57-8268-45f2-a654-a11ee4adb72d@nabladev.com>
 <arFlScBqnMDmJi2O@SMW015318>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <arFlScBqnMDmJi2O@SMW015318>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 9/21/26 7:11 PM, Frank Li wrote:

Hello Frank,

>>>>> But why DTO need update regulator-panel-vcc's gpio informaiton. I suppose
>>>>> it is fixed when board design.
>>>>
>>>> It is just a GPIO, it can have either polarity depending on the regulator
>>>> that it controls.
>>>
>>> Understand, But the problem is why polarity change after board design?
>>>
>>> If reg_panel_vcc is on added on boards,  should it be in dtso file also to
>>> match your hardware design correctly?
>>
>> We want to avoid duplication in the DTOs files, do we not ?
> 
> Yes, but there are not dtso file yet, I don't know how to share it yet.

Yes, there is no DTSO, because there is no DPU support for MX95, so 
display support in upstream is missing (check with Victor Liu, they 
might know more about the current state).

>> Hence, base common stuff in the base DT, stuff that changes in the DTOs.
> 
> Idea is good, but avoid hack stuff. Can you show me what's plan use
> reg_panel_vcc in dtso and how to share it.
See above, currently I cannot really use the regulator, because of the 
missing DPU support. The only DTO I temporarily have in tree (used with 
my DPU patchset) is for the RPi 7" display 2, which does not use this 
regulator.

The plan is to use it the same way as on the MX8MM/MX8MP eDM SBC in the DTO:

&reg_panel_vcc {
   gpios = <&i2c2_gpio_expander_20 17 GPIO_ACTIVE_HIGH>;
   enable-active-high;
   status = "okay";
};

or

&reg_panel_vcc {
   gpios = <&i2c2_gpio_expander_20 17 GPIO_ACTIVE_LOW>;
   status = "okay";
};
