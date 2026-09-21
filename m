Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601035172C5;
	Mon, 21 Sep 2026 21:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790027177; cv=none; b=P6cUJDuyq2kvkjubYhd6i6k4FVCIQ7gfsKtD5Zv9pjC1oZSb5GUUhW5c84ynRYHLqPk0ejIvDALUemYGnZc30K2nOtpNdZWNIIvdvUTq3iw0C8ek8RGu4Nq9exFbYV6/cpa7rvaznFa3cs2uQ4N28jF4/l7PeILAyhEjxFsAdpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790027177; c=relaxed/simple;
	bh=S/FjZLw2JMnscIqs9SxURr83ipTNyq2rCWZhJbsUqzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sam9E2EbM4b25vAJccFbkbtMZjSF+iF2z5J5nk6Tg1+2GbPxUCzRF2i7/5guXFm5pkvzePmgYIEram261vf1eYZJ3mh6Tvz5JPqQ7Uer3ZXFyi1tsxbFbtMHoL9avlyi1VnK0Kj3MrKSvedAH6DGE1elkk+wXIUzKA12ZupSWO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=ehsrNji+; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="ehsrNji+"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CD7581054FF;
	Mon, 21 Sep 2026 23:46:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1790027169;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=EISBgpV1yDqoSVGQWE/qnkBSJ6XiedIy0SjO363fM/Y=;
	b=ehsrNji+fdOFOmvH09wSAEH0ipX3NZz2aGXPIaTICu/xtru1HbJYO/Oy9a4GnIgypf/1L2
	/4UrhDaoeNgXdmwx/lmyLWOv//2i9YJYiaLrrCnBiyacF/1OpvxVU1k8zODaeeDIQ0NaeH
	MVsvbEkYus25Ox9U9H6TF0AJShV3murBZr020KzgMGkDhc8CWRZU1fgvlbTiNVKTD8nyqF
	ZbqOdc6KNZkWGMfB5BF6Fn9JGk9hf/X1tepTyXf9Wxd4xq2uFfmxrafIf60Us9gwDlgBBP
	VaYlcGGJjYCf2y8GS4gKw/mBQqCiUITly6EepSqhzhERn3H1kSL14qIVc3MtAA==
Message-ID: <5c918ab8-94f3-4926-a969-9585c7d63e2f@nabladev.com>
Date: Mon, 21 Sep 2026 23:46:06 +0200
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
References: <aqwbBQUSfd60nVeI@SMW015318>
 <384c5f71-d5ab-4990-9567-027605457439@nabladev.com>
 <aqw1agBrSjYoy71_@SMW015318>
 <c1197d8e-add5-48b7-b0ba-a5a91379ab04@nabladev.com>
 <aq1DnBkxgF49QLwa@SMW015318>
 <bca6ea91-297b-4316-b5db-74636593b084@nabladev.com>
 <arFaPA6aeFey9WlI@SMW015318>
 <c43d3f57-8268-45f2-a654-a11ee4adb72d@nabladev.com>
 <arFlScBqnMDmJi2O@SMW015318>
 <abd334fb-22d4-4b71-9d44-4aa3c2789b79@nabladev.com>
 <arGETwtIZxP3yOP1@SMW015318>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <arGETwtIZxP3yOP1@SMW015318>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 9/21/26 9:23 PM, Frank Li wrote:

[...]

>>>> Hence, base common stuff in the base DT, stuff that changes in the DTOs.
>>>
>>> Idea is good, but avoid hack stuff. Can you show me what's plan use
>>> reg_panel_vcc in dtso and how to share it.
>> See above, currently I cannot really use the regulator, because of the
>> missing DPU support.
> 
> I suggest add it when it will be used.

The users can already use it with additional downstream patches, so 
having the base node in the DT is helpful to the users.

> Or Remove gpios = <&i2c2_gpio_expander_20 17 0>;

Having the GPIO described here is also helpful to the users, since they 
won't have to look up which GPIO is controlling this regulator in the 
schematic, and won't make mistakes.

> Suppose it will be overwrited by dtso future.

Only the polarity.

>> The only DTO I temporarily have in tree (used with my
>> DPU patchset) is for the RPi 7" display 2, which does not use this
>> regulator.
>>
>> The plan is to use it the same way as on the MX8MM/MX8MP eDM SBC in the DTO:
>>
>> &reg_panel_vcc {
>>    gpios = <&i2c2_gpio_expander_20 17 GPIO_ACTIVE_HIGH>;
>>    enable-active-high;
>>    status = "okay";
>> };
>>
>> or
>>
>> &reg_panel_vcc {
>>    gpios = <&i2c2_gpio_expander_20 17 GPIO_ACTIVE_LOW>;
>>    status = "okay";
>> };
> 
> In future, it should be nexus node for it and put reg_panel_vcc into dtso
> files, and looks like you use gpio controller add-on boards's regulator.
There is really no need for a nexus node, only for a polarity setting.
