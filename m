Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235D943B3EF;
	Wed, 23 Sep 2026 09:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790155160; cv=none; b=MxNfoiv8kr3iHBmdcBRfydcNdHsgLgdjoesPC5xWbdxZ/cS6eyZgIdgjrN3s/THamlRs7td9UYhB4Cd2SNHWSo27uvAuUswxZCLVuhnvLmIggsHHu8UtZajj+zVPzkruecW0oXNhb2Q4+tNK2WGmuJ2dE+twokj/29nrms/FMBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790155160; c=relaxed/simple;
	bh=rOESnTj6de0+8+7HiDhW01UEI4WTbvYswOJyY7XI3Gs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JnN+Gg9a4+bVRhF+9SWI/hjc1YEEvKZiOoygFh1oDXt4jlSN+xSEWOYuZ7NwRwTebJ1vUzyxMnZWhVoShcrwDaMnM5vEZo7Y6vBRVK9BDQGg2z9vY8yxpO8YPiFCGfwsnsm87LuoXe9+tCw03SRU+XRw39u+gZkPrk4Tzf4UMX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=P9uF8UgJ; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="P9uF8UgJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1790155146; x=1790759946; i=wahrenst@gmx.net;
	bh=rOESnTj6de0+8+7HiDhW01UEI4WTbvYswOJyY7XI3Gs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=P9uF8UgJHg7zIsYxvQtw0/mZM3vdvHYfBplRrfvnBO04eshQLhzObgpB3lImshdO
	 PnyCwMp9G9udiOe7gJHHTkV2EdbYdCoKtAqUZqHOumO1b1SzwRiyy2bdflFQSai22
	 YNs8zdZkHsXn+N9VQ3mT3LhM0+QSADw1P47ShiW9CbtBjczO3Fftm8GMS9ajcrURs
	 KqjOOr1+tmUbrN8XplrLOp42VALv+AC4L2T5ImBoZAQ7yOXNiPqtGo8UoMXmq8jXx
	 X0fIMwjeEJ6oAZqDThuaUd5VLwnBxq8JNC4lOHcmF8mB09h+sTJUlUhY0vP0Cvivd
	 cHAPMtH3eBuezCTfyg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mzhj9-1wmwlH2kXh-00xonz; Wed, 23
 Sep 2026 11:19:06 +0200
Message-ID: <1a7c722b-a4ff-45d5-a590-0910ac47b541@gmx.net>
Date: Wed, 23 Sep 2026 11:19:04 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 0/4] arm64: dts: freescale: Add chargebyte Charge
 Control Y
To: Frank Li <Frank.li@oss.nxp.com>, Vinod Koul <vkoul@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>, Christoph Stoidner <c.stoidner@phytec.de>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Fabio Estevam
 <festevam@gmail.com>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>, devicetree@vger.kernel.org,
 linux-can@vger.kernel.org, linux-phy@lists.infradead.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 Rob Herring <robh@kernel.org>, Vincent Mailhol <mailhol@kernel.org>,
 Aswath Govindraju <a-govindraju@ti.com>
References: <20260907150420.18787-1-wahrenst@gmx.net>
 <9cb548d3-f3cf-4757-a9ff-5f878479c7d7@gmx.net> <arFDUby0v52HSNnU@SMW015318>
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
In-Reply-To: <arFDUby0v52HSNnU@SMW015318>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Dne6sE0ZdNpL+4oglW1vpvrt8vZaGOscC92U6Ce8JYV1qIzHCpv
 vg4RF747H0c8fWGnVYF1/7aU9xpYrtEnSqUOu+8H84PkavLaAJcgxlhl03dryTH1DjGDAPQ
 LCWitwG/hPxGv8OVJLJCDSZcsMb4uEiWqasvumxglZY37++nVc7hJWrBuFtVcgNhw4Njagj
 rKbNUIBVbMe6AdQB4ILAg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:78QyhefrPlM=;4dh0eWosRMXh4o+mzxtpGbE9h1V
 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
 28KU

Hi Frank,
hi Vinod,

Am 21.09.26 um 16:46 schrieb Frank Li:
> On Mon, Sep 21, 2026 at 03:09:23PM +0200, Stefan Wahren wrote:
>> Hi Frank,
>>
>> Am 07.09.26 um 17:04 schrieb Stefan Wahren:
>>> This series adds support for the chargebyte Charge Control Y, which is
>>> an Electrical Vehicle Supply Equipment (EVSE) for MCS (Megawatt
>>> Charging System) charging stations.
>>>
>>> sashiko reported in the first version of the series [1] that X_nRST_LA=
N
>>> is available via GPIO line names, but there is no reset mechanismn in =
the
>>> device tree. This finding is valid. Since the reset line feature isn't
>>> implemented for LAN8651 driver yet, I like to proceed with the current
>>> version. The LAN8651 handles reset via SPI commands and in rare cases
>>> we still have the possibility to control the reset from userspace.
>>> Btw the pin has a pull resistor in hardware, so it's not floating.
>>>
>>> sashiko complained in the fourth version of the series [2] about the
>>> reset polarity of ethphy2 and the different drive strength across the
>>> data lines. Both is intended.
>>>
>>> [1] - https://lore.kernel.org/linux-devicetree/20260818093147.E556C1F0=
00E9@smtp.kernel.org/
>>> [2] - https://lore.kernel.org/linux-devicetree/20260903082122.A777C1F0=
00E9@smtp.kernel.org/
>>>
>>> Changes in V5:
>>> - fix delete-node for pinctrl_leds (reported by sashiko)
>>> - add Krzysztof's Reviewed-by
>> I didn't received any feedback for V5 yet. Do you have any comments or =
could
>> it be merged?
> Wait for vinod pick phy binding part.
@Vinod are you fine with both PHY bindings?

@Frank I noticed that this patch has a conflict with the Makefile in=20
linux-next. Should I rebase or do you resolve the conflict?

Best regards
>
> Frank
>
>> Best regards
>>

