Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6B0217723;
	Tue,  6 Oct 2026 15:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791301293; cv=none; b=eHVDc6lcFW/BdokWoNpUhMFWe8ztUEEa/0J7mwxSMJlIGOpn5Ywl5ICp32TzZIIlgcWxgD418/KU4/tXtisJXeoZa5vVLk1ikwSjmemrI1HkUwqiV5ZegGCdaZmIavuCkYXZpaCZ74GJ9lzQh0JMwNmopPYdt8DKb/l+XpnHevI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791301293; c=relaxed/simple;
	bh=oF0AqtLKW1wMFXN3AtA1a7ftB0WwEz7YV+0y5nSnPfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZxQvdatnnSZ2h/VI3lgckAyRsTBB3CDG/+2/Trcp2LxL6D0F6TkYuViyWkIydClC3llGe7wsligkcIBHN8gmrazc9OL42YBRTYtY0IdQcy2IEbeqIQUIZBZwnBXk5yMPX54bkD0M+3FcC5fjMEtPFYbNJOQ0LY3DFFSSsyZtxuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=ImTEcsy1; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="ImTEcsy1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1791301273; x=1791906073; i=wahrenst@gmx.net;
	bh=oF0AqtLKW1wMFXN3AtA1a7ftB0WwEz7YV+0y5nSnPfE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ImTEcsy1bODjmMx2dhqCEUnxgO+ghTudCRBcUidoFiQKFeJnAkrIXSNgFbFOVbm2
	 cSISYdNgGsGRuzAR19Zf/fJrJTT35cu2+MXE2l90UKauYPzprtwmLfv4OW/Wp3k47
	 Er+lfEkOqY94OYNly+YLpZ90CvP8qQDVNtXH0Iw97ScAah/UyG9mORR0Lpge9JIU/
	 16Y/Tit1aHU03hOiJ+5V4QNaLrfxV8HEy0QXMl4+CwJ50IlCjLN3T9K6gxSnzhvie
	 HfAwagtDUayEJdOZDA5J0hsUTZV1u0I58G6pbcVNJl6N29XQDxyU/spRuQUexyDUD
	 f/2uSQkhYh+XrfPt5w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MxlzC-1wTYoB26Bi-00xIfd; Tue, 06
 Oct 2026 17:41:13 +0200
Message-ID: <03afbe60-4cb3-4777-b95b-3c144d5c7b4e@gmx.net>
Date: Tue, 6 Oct 2026 17:41:10 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 0/4] arm64: dts: freescale: Add chargebyte Charge
 Control Y
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Christoph Stoidner <c.stoidner@phytec.de>, Conor Dooley
 <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
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
 <1a7c722b-a4ff-45d5-a590-0910ac47b541@gmx.net>
 <7cc6e394-9895-4f42-a0c1-f1fbd7eafbfa@gmx.net> <ar_Wd3fF94XSj4mh@SMW015318>
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
In-Reply-To: <ar_Wd3fF94XSj4mh@SMW015318>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:brCR9kffWRhEWA7ANvQgIUDpRwgpZtemF3TAceeCDFv9rYYtpGN
 8EhEJ8hbLM9XWHtOZ5E6agNyCMZ4eqUEEhx7CO5WlASQOv1Ud2+v2gP6YQiv/bXmtgtxz9s
 OPF7j08kFko2s+l0ljvLsnrG0g+7EdQkad9/6sZ/hZNIPEmfnnS0gJKQSYr09RT9dBbe5eE
 gV4C0Hg7rBp8FAx+sRqgA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/bT4Y+9fsL4=;AYcZNta23FC4xA5L0CXkm41UmgM
 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
 ZZMlan5A==

Hello Frank,

Am 02.10.26 um 18:06 schrieb Frank Li:
> On Fri, Oct 02, 2026 at 05:31:23PM +0200, Stefan Wahren wrote:
>> Hi Frank,
>>
>> Am 23.09.26 um 11:19 schrieb Stefan Wahren:
>>> Hi Frank,
>>> hi Vinod,
>>>
>>> Am 21.09.26 um 16:46 schrieb Frank Li:
>>>> On Mon, Sep 21, 2026 at 03:09:23PM +0200, Stefan Wahren wrote:
>>>>> Hi Frank,
>>>>>
>>>>> Am 07.09.26 um 17:04 schrieb Stefan Wahren:
>>>>>> This series adds support for the chargebyte Charge Control Y, which=
 is
>>>>>> an Electrical Vehicle Supply Equipment (EVSE) for MCS (Megawatt
>>>>>> Charging System) charging stations.
>>>>>>
>>>>>> sashiko reported in the first version of the series [1] that
>>>>>> X_nRST_LAN
>>>>>> is available via GPIO line names, but there is no reset
>>>>>> mechanismn in the
>>>>>> device tree. This finding is valid. Since the reset line feature is=
n't
>>>>>> implemented for LAN8651 driver yet, I like to proceed with the curr=
ent
>>>>>> version. The LAN8651 handles reset via SPI commands and in rare cas=
es
>>>>>> we still have the possibility to control the reset from userspace.
>>>>>> Btw the pin has a pull resistor in hardware, so it's not floating.
>>>>>>
>>>>>> sashiko complained in the fourth version of the series [2] about th=
e
>>>>>> reset polarity of ethphy2 and the different drive strength across t=
he
>>>>>> data lines. Both is intended.
>>>>>>
>>>>>> [1] - https://lore.kernel.org/linux-devicetree/20260818093147.E556C=
1F000E9@smtp.kernel.org/
>>>>>> [2] - https://lore.kernel.org/linux-devicetree/20260903082122.A777C=
1F000E9@smtp.kernel.org/
>>>>>>
>>>>>> Changes in V5:
>>>>>> - fix delete-node for pinctrl_leds (reported by sashiko)
>>>>>> - add Krzysztof's Reviewed-by
>>>>> I didn't received any feedback for V5 yet. Do you have any
>>>>> comments or could
>>>>> it be merged?
>>>> Wait for vinod pick phy binding part.
>>> @Vinod are you fine with both PHY bindings?
>>>
>>> @Frank I noticed that this patch has a conflict with the Makefile in
>>> linux-next. Should I rebase or do you resolve the conflict?
>> would it be better if I rebase now and send a V6, I concerned that this
>> misses the cycle.
> Vinod missed pickup one of binding patch.
Now both PHY binding patches has applied. My question referred to the=20
conflict on the Makefile in Patch #4 against your current for-next.
Should I send a V6 or do you resolve the conflict?

Best refards
>
> Frank
>
>> Best regards
>>> Best regards
>>>> Frank
>>>>
>>>>> Best regards
>>>>>

