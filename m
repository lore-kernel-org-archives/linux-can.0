Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A584A8FCE;
	Mon,  7 Sep 2026 12:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788784642; cv=none; b=G2H61eNrFEzPi/JjDf6vExEJ/GvT1wJDWxDZ+hj4wpIzlpWy0Er+O+Ouk1eg2ljGzh0ZIAtCeg3R+rzXlP/6s9TowYSDDDN0hx5BAYVoRDXr2ylTRYwrjD183hsdkCL4yqmmkOCHXXm4NAzhax2n8VS15jpzPT/NGaTpnh57j7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788784642; c=relaxed/simple;
	bh=5NMRuVSjJthwtEjHOgcQtgnqigYjdXxeIsLMTayi5b4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=REuQtMC0RafiOajbSp3sRZmnTIP3SMAYN+GJ51lDHGBOPt4TUGSuafCyA7nPZ7E7YJADmI9Q6ZKJLLASG9FlV2RPordCsmNq9iaxsNF6rljcekvmWvmyMN48hdfgUM25u3Cz1Rt9R/8kwD+TIbQ1aCHjxWDQ8cKFWQLrhVyBBSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B04601F00A3A;
	Mon,  7 Sep 2026 12:37:18 +0000 (UTC)
Message-ID: <4d329d53-eb85-4377-9315-aba0a3183258@tuxon.dev>
Date: Mon, 7 Sep 2026 15:37:17 +0300
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] can: rcar_canfd: Do not set registers selecting
 the CAN mode
To: sashiko-reviews@lists.linux.dev
Cc: conor+dt@kernel.org, robh@kernel.org,
 Oleksij Rempel <o.rempel@pengutronix.de>, linux-can@vger.kernel.org,
 Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
 <mailhol@kernel.org>, wsa+renesas@sang-engineering.com,
 devicetree@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>
References: <20260902141544.565763-1-claudiu.beznea+renesas@tuxon.dev>
 <20260902141544.565763-5-claudiu.beznea+renesas@tuxon.dev>
 <20260902142912.97F9A1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea+renesas@tuxon.dev>
In-Reply-To: <20260902142912.97F9A1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/2/26 17:29, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [High] Software state diverges from fixed hardware capabilities due to unvalidated device tree overrides, causing silent data corruption and CAN protocol violations.
> 
> Pre-existing issues:
> - [High] Race condition on write-0-to-clear status register causes lost TX completion interrupts and permanently frozen TX queues.
> --
> 
> commit f5c5dd93cfcd4bdec86a8b0c4bc20cba21d7f4dc
> Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> can: rcar_canfd: Do not set registers selecting the CAN mode
> 
> This commit adds a fixed_canfd flag to struct rcar_canfd_hw_info to handle
> hardware like the Renesas RZ/G3S SoC that only supports CAN-FD mode. It skips
> writing to unavailable CAN mode configuration bits during the reset controller
> sequence.
> 
> Link: https://lore.kernel.org/all/1d9719e3-10ff-4cd8-b729-55fea93c37ce@wanadoo.fr
> 
>> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
>> index 2e84dc5dfa34d..bed7cde1aa01b 100644
>> --- a/drivers/net/can/rcar/rcar_canfd.c
>> +++ b/drivers/net/can/rcar/rcar_canfd.c
> 
> [ ... ]
> 
>> @@ -846,6 +852,9 @@ static int rcar_canfd_reset_controller(struct rcar_canfd_global *gpriv)
>>   		}
>>   
>>   		/* Set the controller into appropriate mode */
>> +		if (gpriv->info->fixed_canfd)
>> +			continue;
>> +
> 
> [Severity: High]
> Does bypassing the hardware mode setup here create a state mismatch if
> the software interface is forced into Classical CAN mode?
> 
> If the device tree contains the "renesas,no-can-fd" property, the probe
> function sets fdmode = false in rcar_canfd_probe():

It is the same thing here. The "renesas-no-can-fd" was forbidden for RZ/G3S.

