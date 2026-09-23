Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DCF497B93;
	Wed, 23 Sep 2026 16:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790179934; cv=none; b=kL207iKmw4KdRSK6A7YfmK/6/ABghDq+XWH48iMYQEwvaOuyMLPV55PI6khFFgGM2dXP9qnNdVIr1vyl9liLdeUryOguzIy+qDA8nW/2fPHu5NE8GgLUSaq9vBZuIYWZf+lcv8WQ2CcYCvq/OipgPLPV6k3vcGzxbzYPZIs3DNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790179934; c=relaxed/simple;
	bh=h1Y/hT7xJXPbkLPA41aY5ChwM3UIyGiYAsbPxBDVqGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rWThAeMHIz8j0myGSffebHwPag9iNT0/eQ9uqbrHz0NIxg7I2ZeuhVCOGBgYq5g56qUrky3gO3HP6xB+YHWVcKnSypGbmI12suhXmfNQM53e36tUWmfL1/YVpEmX8xUZ/ou7MilgjTTUsj7xLiHaNcQ9TWs8RJXi2Xa/DbgIQpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=Pr/4fD9a; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="Pr/4fD9a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1790179910; x=1790784710; i=wahrenst@gmx.net;
	bh=T7Fo3OIKO8mR6PYK0T66Jl1e/sJx4Ryl9JKTCCQhd3c=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Pr/4fD9a/5s1YsTM/ej5Q882PZlp54NBJcWw/O/jXACBSog5SYt3j1/zjfM6cB41
	 D/290ie63AXZ4mS7HJTKdRWPZhNG1QR6OoUQcY00SxEbOikxj9pmOf3sTpEPteYjY
	 V85Cy5c6p8XVClcOpRHNVBDVaLK6DNfM1PEuWAq5Lw53VqJdSC0xCe3N8EmRaac75
	 wtHYyjGkJy35PexVGVIjJCo1gXWHxFKzHwkDVh6y/+YlVFfIlxZOicYqBfT6rF9Wg
	 GjWHDF3qPIRUkkqAQxab/+lztgFBkW9WFnxViHde11TXq5hhHfYh40C0tXbJYNGk8
	 UWxQii4PM+a1YhKkYQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N9dwj-1wfBcR10Sr-012PuX; Wed, 23
 Sep 2026 18:11:50 +0200
Message-ID: <72033c48-5219-4ed4-94fd-1b7d8ef8017c@gmx.net>
Date: Wed, 23 Sep 2026 18:11:48 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH V5 0/4] arm64: dts: freescale: Add chargebyte
 Charge Control Y
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@nxp.com>
Cc: Christoph Stoidner <c.stoidner@phytec.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 linux-kernel@vger.kernel.org, Aswath Govindraju <a-govindraju@ti.com>,
 Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
 Marc Kleine-Budde <mkl@pengutronix.de>, Conor Dooley <conor+dt@kernel.org>,
 linux-can@vger.kernel.org, linux-phy@lists.infradead.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 Vincent Mailhol <mailhol@kernel.org>,
 Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20260907150420.18787-1-wahrenst@gmx.net>
 <179016749941.155868.1810345055482953110.b4-ty@kernel.org>
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
In-Reply-To: <179016749941.155868.1810345055482953110.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:RdPUK6v2MMsm5yM3xIhRnBZrjYZDWmc9aRdhJLRiBX0/3QdfrvW
 ipzNJWVQrs1gEpPhrsSFwDgHcjKb11we6CrpfI5ZPR8PsDewdve0w3hzTAflB9N1taZJPnX
 AwdYe9akRJ03GOuEnaYN84/bTiScFHtejk6FcR5rm3wb5lCSCtcObWshQmlF/WjRjrtCk3u
 Da9uP1wLJDQUWtbgX4/+g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0wO6cW7mlRk=;NVfLgiepIRrcHMjVY7kHtGmZbPc
 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

Hi Vinod,

Am 23.09.26 um 14:44 schrieb Vinod Koul:
> On Mon, 07 Sep 2026 17:04:16 +0200, Stefan Wahren wrote:
>> This series adds support for the chargebyte Charge Control Y, which is
>> an Electrical Vehicle Supply Equipment (EVSE) for MCS (Megawatt
>> Charging System) charging stations.
>>
>> sashiko reported in the first version of the series [1] that X_nRST_LAN
>> is available via GPIO line names, but there is no reset mechanismn in the
>> device tree. This finding is valid. Since the reset line feature isn't
>> implemented for LAN8651 driver yet, I like to proceed with the current
>> version. The LAN8651 handles reset via SPI commands and in rare cases
>> we still have the possibility to control the reset from userspace.
>> Btw the pin has a pull resistor in hardware, so it's not floating.
>>
>> [...]
> Applied, thanks!
>
> [1/4] dt-bindings: phy: ti,tcan104x-can: Fix property constrains
>        commit: c7f2322431cb6d108b18fb4154606b49e2bc50f7
thanks, but what about

[3/4] dt-bindings: phy: ti,tcan104x-can: Document Microchip MCP2542

Best regards
>
> Best regards,

