Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21E747011C;
	Mon, 21 Sep 2026 16:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790008657; cv=none; b=aUIVt94fQbtErr5kuTjfU4mYDCiflk2VskzIiEdk18nXELNaIaDW/74XjwhmWDQ0Ct4Gx/lJp2o0THkUJCdMgkRiLNtU1Hq1npQ1oaIXX+2mTbGe09i67wUeVtjZZFEnozY+pJJY2Y5bYxZPH8Y8X0qqbL0h9g1YpFAgmNsCrVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790008657; c=relaxed/simple;
	bh=pfMMFLzrf7xwf/iBtRjemDaxbSTua8hFpUWh/lC21+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZDUiMRBzk74eN4uHnXEUhCEJoB5j4lEglR/JL1vo2feSEmS82kkQmi7UtfIrHdEEicgz07y1gdKQLw3NSnX+9lD8zhleuL29G31tfzTtYsTvm2R+//ThxS8iKRh+A/yZ5zdhiV/doPrike/qeowhnwbPeQQHmiBvNGSUbB+EaNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=Kp6GDN7t; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="Kp6GDN7t"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C95BE105226;
	Mon, 21 Sep 2026 18:37:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1790008649;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=k3hjzlA3nHbiFTIPBCYbDWlL16pCll7Sd3I/tqo5frI=;
	b=Kp6GDN7tuOmVrAxh8eUZf5INOiIeIN4tdSkVR49XWBB4owi3iYpud+AmAtUPoEg9vIuBPo
	Ni5dFhBh138nisIj7qzvg58ibQBOeqwGe+cJ9kUsDqoAUtgB/9pJWO5lBZ4rQgO20mXjIZ
	uoj2KhhSLS6MDsaw45Ci7Tmfl4p+5FmDDggJ6kt7YRJzhLqL8VjHgLyER2KNW2Zma1IApF
	b9AlzUyhEpadtP5/FFibvkfN5bW3GoMPOL+m0VhJcyjPa982Nurp3Y+zggYwi4bZLQ+alW
	oLPXd6T9Lqk6GknNSHk0xYaNxiGJGy19k5z5c1pvkF9I/gD736xk7PoFll4S2w==
Message-ID: <c43d3f57-8268-45f2-a654-a11ee4adb72d@nabladev.com>
Date: Mon, 21 Sep 2026 18:37:26 +0200
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
 <bca6ea91-297b-4316-b5db-74636593b084@nabladev.com>
 <arFaPA6aeFey9WlI@SMW015318>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <arFaPA6aeFey9WlI@SMW015318>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 9/21/26 6:24 PM, Frank Li wrote:

Hello Frank,

>>> But why DTO need update regulator-panel-vcc's gpio informaiton. I suppose
>>> it is fixed when board design.
>>
>> It is just a GPIO, it can have either polarity depending on the regulator
>> that it controls.
> 
> Understand, But the problem is why polarity change after board design?
> 
> If reg_panel_vcc is on added on boards,  should it be in dtso file also to
> match your hardware design correctly?

We want to avoid duplication in the DTOs files, do we not ?

Hence, base common stuff in the base DT, stuff that changes in the DTOs.
