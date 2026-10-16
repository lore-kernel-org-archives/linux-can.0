Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D906145EF49
	for <linux-can@vger.kernel.org>; Fri, 16 Oct 2026 18:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792174035; cv=none; b=peMaqE6Ttkx8uWDhiwzB1ukrjzsIqQJs8atbZfeEZVF6yUemd3BejsJaAA983GYBLtozvHWtJ3glItUK22vbWwqnyKKh7AiFn+GXULPAHa+yrkm+FyN7+5rG3mNRc06wnq+kBFZFbyj/+Ed0WQjWVINeAuNCDthN6F01/7vasAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792174035; c=relaxed/simple;
	bh=eiUiQoopFUDmGr3UYzTNNVOWWiP061mHHX8TFI39C1E=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=f61LZsssaHFIhcBe7sNz3HVTJ/ufiaHNuyHQU/SU5LldUzE6dwkTLp66SF+POGv5u5ae2FKUPZwghtNv3kUmD4Chi73qzRVm8pkqvBtR4xQD+Jk92FG4isuQDkLzB/M366WJNXFLqyJdg0UROXdrSgkWvzx7LI8HFqqdNCKUJtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=n9W2csVA; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="n9W2csVA"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a022fee0caso2048345e9.1
        for <linux-can@vger.kernel.org>; Fri, 16 Oct 2026 11:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1792174030; x=1792778830; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kwqs7mz873M28LjIKl95AhngO7J7OiavOqidLa4FRNc=;
        b=n9W2csVAyuaKikh+vFpNLESUTmENQTssuKfmrIM+YSorZ1ZkkF5CMXJA8WDhb/T5MW
         fxCUR5v3YRDv0gExwQijst1t38gDNULmLv9drqfSoyC8+ezQ+3klEGLnlVd65Mkfz1+W
         Dj5QgGAj4UgRTVRdnVsWj/6GyuSO2MSIa/uaunLvqG0mSmTo6JpEkPtwA22CY3LD0iIj
         3vg7L0qFpoLviFWL7Sm9bUILhSkcXsKRptFhlEFG862xfNHn1mbb+rnF+zYKDVOT5n9h
         jp9HxbAocXwILVeAdA2rUpD4MEZSmTDIOU1d0zKWfkvtpgoY1xySyluU8/NzdWf6vK1U
         BWdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792174030; x=1792778830;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kwqs7mz873M28LjIKl95AhngO7J7OiavOqidLa4FRNc=;
        b=NzqIzeKVojf96ErgI4258qMZ5qlvtPBPLBs8sJG77pAIxtjKti4md9O04i/strSYn/
         S+zUarl5Hqqtomqfmmz1ATmOhEkEuy+DwMPC/gaIBVDb3rX59Tea/KTEbLY63Ue1A01X
         0DuaU+gghW/2pxaRedefVf+/c2w+K7zlKoBBQWQIO7iJqz73odx22sIlufeLFDJWEgPs
         srAIdvWWmWbsZytcqa9iGGkSwKd1WQuHxvhRWNUAt9v70eDbJBPAqb3kByTxe5pEHMRs
         NvuMVT3svsobEAclUQvDL5Hg4nzwBYQ9oI9hI0b/KtLLkoszeEQa7M9PGruVNvU+Q3IB
         yHFw==
X-Forwarded-Encrypted: i=1; AKwUvBzJXsKtk+3b6RXQTJGFSEKPLB76NbBPxzMNrK6GTP4JiancPcyIwpJ6r+M0aJwxvqLnERJ8cWnoAck=@vger.kernel.org
X-Gm-Message-State: AFq9FYIO5WUBOsRM0lttCk3tIK6/gFMOVRbWdCujZmlgXAmyLpxpVJ11
	DNxO5YDOkrAW9X1fMZRjQrfsis6VlKSSDrAVhy5Ff8YPk8pUtoe9kX3aipoUnE8sXh4=
X-Gm-Gg: AYBFou3doCNpYuRn4zsFTia1VgwD0pIDofjd2cFu8+Vvuyk0lbXRF0EiE0fVEYGDjRS
	XXSvhKHgrF8ibIr0Iti8X1k9wOMTfl4IVYXHON5wO/OHMPIrwtulQRGjp+BEqvcJTLumG5Df0+b
	QRGyEikkaijqyHIYBRNgSVMkohHNe8fREn/u7ADDvIUNpi69UmIMnD8Lbsdl5I5aMxXT3SFn+2e
	n3ctoFdkgedWWg6QtFZoApp+ltvRSfwYnnDFlV0D8cS59LqyRubHG7MU6344hCvLQrN67RlIp89
	Rwsx4LQa4TrYrE2XuqPzVPWTIYmIj4D1fwm+sumPyXJ9OAfA+AXT85mf2wXyAVYp+xG9zXH+ffQ
	Bpwsz3WqvoN5uKTobvTj1Uv8Z8I+iHY7ZwF6h3KAcgMrCcfL0tJimI4xasm9gcyy6V/kAKE8kzu
	gszTh0CW+L/g6Ne/yE8UqfDAHsx8cBfFcvPddEj67WzFIRptr0mOmsyHuCuWgrTPYq12rsh0uJ2
	LHZDykOhwGwjjNrPg==
X-Received: by 2002:a05:600c:6215:b0:4a1:d41b:5060 with SMTP id 5b1f17b1804b1-4a1d762b705mr10663215e9.22.1792174029743;
        Fri, 16 Oct 2026 11:07:09 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.221])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1d3e2e602sm40486255e9.5.2026.10.16.11.07.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 11:07:09 -0700 (PDT)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu Beznea <claudiu.beznea+renesas@tuxon.dev>
Message-ID: <69826962-0c21-4616-9cd8-6eb0478a422b@tuxon.dev>
Date: Fri, 16 Oct 2026 21:07:07 +0300
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/7] can: rcar_canfd: Allow the CAN FD clock to be
 sourced from fck
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: mailhol@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, geert+renesas@glider.be, magnus.damm@gmail.com,
 biju.das.jz@bp.renesas.com, fabrizio.castro.jz@renesas.com,
 claudiu.beznea@tuxon.dev, linux-can@vger.kernel.org,
 devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20260902141544.565763-1-claudiu.beznea+renesas@tuxon.dev>
 <20260902141544.565763-4-claudiu.beznea+renesas@tuxon.dev>
 <20261016-durable-meticulous-owl-7a9eed-mkl@pengutronix.de>
Content-Language: en-US
In-Reply-To: <20261016-durable-meticulous-owl-7a9eed-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/16/26 16:39, Marc Kleine-Budde wrote:
> On 02.09.2026 17:15:40, Claudiu Beznea wrote:
>> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
>> index b7c4fe3477ac..f9173774387f 100644
>> --- a/drivers/net/can/rcar/rcar_canfd.c
>> +++ b/drivers/net/can/rcar/rcar_canfd.c
> 
> [...]
> 
>>
>>   /* Helper functions */
>> @@ -2190,13 +2196,20 @@ static int rcar_canfd_probe(struct platform_device *pdev)
>>   	 */
>>   	gpriv->can_clk = devm_clk_get(dev, "can_clk");
>>   	if (IS_ERR(gpriv->can_clk) || (clk_get_rate(gpriv->can_clk) == 0)) {
>              ^^^^^^^^^^^^^^^^^^^^^
> 
> As sashiko.dev [1] pointed out here's no check for -EPROBE_DEFER.

This looks to me a pre-existing issue.

The newly added support does:

fcan_freq = clk_get_rate(gpriv->clkp);

At the time this is executed the clkp was already checked against any errors 
(above) including -EPROBE_DEFER.

Please let me know what is the procedure now. Should I re-send the series and 
address the fixes? Should I send follow up patches?

> 
> [1] https://lore.kernel.org/all/sashiko-outbox-173569@kernel.org/
> 
> The netdev bot found more issues.
> pw-bot: cr
> 
> regards,
> Marc
> 
> --- Patch [15]: [PATCH net-next 15/37] can: rcar_canfd: Allow the CAN FD clock to be sourced from fck ---
> commit 4ef0042ccf34457229cdde398a008bebaab54e69
> Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> can: rcar_canfd: Allow the CAN FD clock to be sourced from fck
> 
> This commit adds an fcan_pclk hardware info flag. With it set, the fCAN
> clock falls back to the peripheral clock (fck) when the external can_clk
> is unavailable, the rate is divided by info->postdiv and can_clk is set
> to NULL. All existing rcar_canfd_hw_info instances now set fcan_pclk = 0
> explicitly.
> 
> Link: https://lore.kernel.org/all/1d9719e3-10ff-4cd8-b729-55fea93c37ce@wanadoo.fr
> Link: https://patch.msgid.link/20260902141544.565763-4-claudiu.beznea+renesas@tuxon.dev
> 
>> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
>> index b7c4fe3477ac..f9173774387f 100644
>> --- a/drivers/net/can/rcar/rcar_canfd.c
>> +++ b/drivers/net/can/rcar/rcar_canfd.c
> 
> [ ... ]
> 
>> @@ -2190,13 +2196,20 @@ static int rcar_canfd_probe(struct platform_device *pdev)
>>   	 */
>>   	gpriv->can_clk = devm_clk_get(dev, "can_clk");
>>   	if (IS_ERR(gpriv->can_clk) || (clk_get_rate(gpriv->can_clk) == 0)) {
>> -		gpriv->can_clk = devm_clk_get(dev, "canfd");
>> -		if (IS_ERR(gpriv->can_clk))
>> -			return dev_err_probe(dev, PTR_ERR(gpriv->can_clk),
>> -					     "cannot get canfd clock\n");
>> +		if (info->fcan_pclk) {
>> +			fcan_freq = clk_get_rate(gpriv->clkp);
>> +			gpriv->can_clk = NULL;
>> +		} else {
> 
> Discovered by: opus-5-5 · Missed by: gpt-6-astra, sashiko-gemini · Confirmed by: gpt-6-astra
> Should the clock comments and the probe banner be updated for this new
> fck source? 
> Several places still describe only the external and canfd
> clocks.
> 
> The comment just above this block in rcar_canfd_probe() still says:
> 
> 	/* fCAN clock: Pick External clock. If not available fallback to
> 	 * CANFD clock
> 	 */
> 
> With fcan_pclk set, the fallback is fck (gpriv->clkp), not the canfd
> clock.

We can update the comment as follows to comply with the clock name in the driver:

/* fCAN clock: Pick External clock. If not available fallback to
  * CANFD clock or peripheral clock in case fcan_pclk = 1
  */

or, to comply with the clock name in the bindings:

/* fCAN clock: Pick External clock. If not available fallback to
  * CANFD clock or fck in case fcan_pclk = 1
  */

Please let me know what is prefered.


> 
> In struct rcar_canfd_global, the field comments also don't cover this
> case. Here can_clk is NULL and the fCAN source is clkp:
> 
> 	struct clk *can_clk;		/* fCAN clock */
> 	...
> 	bool extclk;			/* CANFD or Ext clock */

There is already a pointer covering the clkp:

         struct clk *clkp;		/* Peripheral clock */

> 
> The banner at the end of rcar_canfd_probe() wasn't changed either:
> 
> 	dev_info(dev, "global operational state (%s clk, %s mode)\n",
> 		 gpriv->extclk ? "ext" : "canfd",
> 
> On this path extclk stays false. Won't the banner then say "canfd clk"
> for a controller that has no canfd clock and runs from fck / postdiv?

That could be updated with "clkp" to comply with the driver name or "fck" to 
comply with the bindings or with "peripheral". Please let me know what is 
preferred.

> 
> The later "can: rcar_canfd: Add support for Renesas RZ/G3S" patch sets
> .fcan_pclk = 1 in r9a08g045_hw_info. After that, an RZ/G3S board whose
> can_clk is missing or has a rate of 0 would print this label.
> 
> Also, the new bitfield comment calls this clock pclk:
> 
> 	unsigned fcan_pclk:1;		/* Has fcan sourced from pclk. */
> 
> The commit message and the code call it fck. 

The commit message mentions: ...the CAN FD clock can be sourced either from fck
(the peripheral clock) or from an external clock (can_clk).

The driver uses clkp (peripheral clock) to refer to the fck.

fck is the clock name used in the bindings. In bindings I kept the same clock 
name and provided the proper phandle in the device tree. I don't consider we 
should change the driver and the bindings for this thing. Please let me know 
otherwise.

The clock diagram is something like:

                         +----+
pclk (fck) -> 1/2 div ->|    |
                         | mux|---> fcan
ext  (can_clk)--------->|    |
                         ++++++

b/w () are the clock names in bindings.

The full HW block with the clocks involved can be found at 
https://github.com/claudiubeznea/logs/blob/master/canfd-clk.png

Please let me know what is the procedure for this. Should I re-spin the series? 
Should I send follow up patches?

Thank you,
Claudiu

