Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794490784;
	b=vopfMsx/qAso3XXJtiyRO9UuN9Qy/Ht6GnwWuszxly9Uqt3QOp4A6nJLiLWyTAljwu4E
	 p982dp6+m8d7GGRJ1k6KHoIt+yYk5Msns+tZMBheBc7qyKZkWs52cP7MEItCnlLiPmSFZ
	 Tc4j8E1qzFuaXPAcMQphFqTdOP1Qpue6Ds0AtVLUOIKj9B+S6WHmJPYHOxBtA/JRpKYoj
	 O4MYfm9wsJ27ywTPIJBtW0wphSRNVfFn+SNH6SVsRKeomlW2FgFKM1M5FSsrkMifnosIF
	 W8jR+fqc2fRAfOlIezuMrbkXw68OttkkA0lrUEWdag0oZnnWzB4zrMJT1RTJUmLUBrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794490784;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=v2RDXyRKlu8YgCg3hXrjnzaY8toU8EVa/lRmWnLFezM=;
	b=cVMXC4IGscmlb5Jd9+Jut6/PBZM62/5Np69ydSkhFVuNuoJFEpOWg5CIfIKnNdimBRkE
	 y6WJOTPeAM21Hsz56pcUeEq/zHiZIrmk7wj1wRiFdEBL7cb/7wzaYj04iqNWYS/m6KGCr
	 1x4a9By7I76vDQTYiyT9MSVdsXFuO78WMkX4qT9GGe8060ldSUGdjTcCPrUKIaBwrfItC
	 Ipx6EV0GAMdL4Uyo1Z1B5gmjEUbDqs791+8pFU2phOKvFfYTAK1aA0yZLlgcHVCjk7quE
	 RHOlLINhtBUTdvkQ64SMk5jkU+dBDA+H6amLeQOIHNNnDIQpDv/0xbkJJxqUP3R4O4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tuxon.dev;
	spf=pass smtp.mailfrom=tuxon.dev;
	dkim=pass header.d=tuxon.dev header.i=@tuxon.dev header.a=rsa-sha256 header.s=google header.b=TfAPXEZf;
	arc=none smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACC9606A339
	for <linux-can@vger.kernel.org>; Thu, 12 Nov 2026 13:39:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4ACC9606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tuxon.dev header.i=@tuxon.dev header.a=rsa-sha256 header.s=google header.b=TfAPXEZf
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c45551fa84eso654775466b.3
        for <linux-can@vger.kernel.org>; Thu, 12 Nov 2026 05:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1794490782; x=1795095582; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v2RDXyRKlu8YgCg3hXrjnzaY8toU8EVa/lRmWnLFezM=;
        b=TfAPXEZfYdGS4nyKKQ9186EaI0rvQhYBFPMR8QyhKUKBCr1+buGAgHTCrDc8MVGpv/
         qqr5CHJuGjy9jyVGqcg5lXGP3ZOxs8SRLLBOv86duKHKy74IUilBd+hboQcnODmg5YP5
         lHQaQlF+22MFhytGhqw+q9v7x3/m9fOF617NG9Qq/rX05gT8l9MdBRuOFILysy44uPiJ
         cmnwkG9LDqcak7jdtXCiuxtPsTOFV2pfuAI4unmOvPEi6EYh1DBc/UWqoZliJttWACt8
         +xixG4esyEHdqDr4uW0ieA0m/I4u8seBPet6HAUY/aIwR3/Jro0+CsAp4rHvBJct1qGk
         jqSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794490782; x=1795095582;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v2RDXyRKlu8YgCg3hXrjnzaY8toU8EVa/lRmWnLFezM=;
        b=dA742Xc7ibXzT5nssfd8q2wkKpqgClGpCJZKrZGZJi74/oh2wCLNrMRvseFXcur0f6
         w98DVXGpB3/8Yn8q75mZ/wGkU5qUPZxdpzxP7/TLEN5aiNBJivUxAp/SgQSG4drpiF3r
         RsX4/RNnpPYQv2TM8uWrHP+HWxBQZHLTcQddCS2CQpi0nVRZnUTXvtidALUkQc8WZ0p6
         757EdPhEwWyoMfPH9ltgHl3l3sNF7hqfkzBIb4XO6yJDW5KjlYV8EJ8jzmqB9bZRTp0m
         qCOCVVCBu3q04YR95bO6ay7iAIzT64X6NMwJU0xc2wCfgRKKx+eBuq+EwChLNZQwqm3l
         JgSQ==
X-Gm-Message-State: APuU4Z8D+9/6AzPBCGtaop/8xqiQhPdjDDYEazM/0BCJLPo4nlW1MXx+
	XivCjzjB19tBVb19G7k0ovGcBPdMAno35cBfFLMPoHJQXJdWVLcpwqhrgIvdJzpFQo4=
X-Gm-Gg: AYBFou3meufARwnXMTE1qUaA4vOCiLv+3DrCnKdIm+rsW0OEEXVU1X+5Kjv7el8FSLj
	xz6aehpqSfKRbtxQHVgBR0JqaJXXv0VEZxlZ2tg1LUylKPQvTpgyh9Gzv4W/b4PPeFIKBVMdo9A
	w3ew35GL+WbENm07qnCAbMojsARcnD72EBaYO53k0HlnkYgV4QXZGKE6EmUz3Ifyo3f4M+ZLrPI
	aTVXiQwvedjtbazqgJqe9/gvvqimKciQfUrpl2QsnCiA6x+gZm9hkvMGjUqyI9juFbFQlB/9Sdb
	CyEfO3y52Iu8bFKf3S63QvjWfLPWF5i1LtZW11QbkNzMTj0tKFEpxXtWWLqZkiUnQHTS+Z9s0xt
	k/G9pCHvdWCmBEDyZI1llCQwWbrG7HxCxqU3D9pAvP7NariTcL+sVM4DLjK8p/4blQ/auqov/Ne
	XGpRwFbTwEYidZ32gdLgQhhNTQqrMOwQlb/B/lvsBvNIWcZULHqLrMzMSwL9iIt8unuxZ1nd3Ut
	YqGdkbJHIQgbVU93fKHcw2hcICzEcdiqadLgNKm1+2Xe0GejD+cMbtpEqQYNoAa8NJkWYNVDGFb
	nJIJYFaE/L93p0QqtNgalMNEAq1vE8n2ZdrynA==
X-Received: by 2002:a17:907:3e10:b0:c40:6ed9:b962 with SMTP id a640c23a62f3a-c5066b43140mr466325766b.26.1794490781537;
        Thu, 12 Nov 2026 05:39:41 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.244])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a3a6bc5sm354373766b.3.2026.11.12.05.39.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 05:39:41 -0800 (PST)
Message-ID: <7c5f9cc9-8e3a-4f3d-b9a5-b5b0462833af@tuxon.dev>
Date: Thu, 12 Nov 2026 15:39:39 +0200
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 07/12] can: rcar_canfd: Use DT clock names in the
 probe message
To: Marc Kleine-Budde <mkl@pengutronix.de>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, netdev@vger.kernel.org
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de
References: <20261110115112.3807247-1-mkl@pengutronix.de>
 <20261110115112.3807247-8-mkl@pengutronix.de>
 <20261111-wise-graceful-avocet-27fa57-mkl@pengutronix.de>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20261111-wise-graceful-avocet-27fa57-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi, Marc,

On 11/11/26 14:01, Marc Kleine-Budde wrote:
> On 10.11.2026 12:41:30, Marc Kleine-Budde wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Print the DT binding clock names when reporting the selected clock at the
>> end of probe. These names are part of the DT ABI, so they are stable and
>> match what users see in the device tree.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> Link: https://patch.msgid.link/20261019121356.2421761-3-claudiu.beznea@kernel.org
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> 
> 
> The netdev sashiko/clashiko found a medium issue. Can you comment on it?
> 
> If you re-spin the series, take a look at the low issues, too:
> 
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261110115112.3807247-1-mkl@pengutronix.de
> 
> regards,
> Marc
> 
> --- Patch [7]: [PATCH net-next 07/12] can: rcar_canfd: Use DT clock names in the probe message ---
> commit d7a69a85fec4c0746ff8cbfad2799f58cd2059c3
> Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> can: rcar_canfd: Use DT clock names in the probe message
> 
> This commit changes the clock name in the final dev_info() of
> rcar_canfd_probe(). It now prints DT binding clock names ("can_clk",
> "fck" or "canfd") instead of "ext" or "canfd".
> 
> Link: https://patch.msgid.link/20261019121356.2421761-3-claudiu.beznea@kernel.org
> 
>> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
>> index bb2d03b75142a..4f5cdfa8211da 100644
>> --- a/drivers/net/can/rcar/rcar_canfd.c
>> +++ b/drivers/net/can/rcar/rcar_canfd.c
>> @@ -2312,7 +2312,7 @@ static int rcar_canfd_probe(struct platform_device *pdev)
>>
>>   	platform_set_drvdata(pdev, gpriv);
>>   	dev_info(dev, "global operational state (%s clk, %s mode)\n",
>> -		 gpriv->extclk ? "ext" : "canfd",
>> +		 gpriv->extclk ? "can_clk" : (info->fcan_pclk ? "fck" : "canfd"),
> 
> Is the right name printed when can_clk is in use on hardware where
> external_clk is 0?
> 
> gpriv->extclk does not record which DT clock was picked. In the branch
> that uses "can_clk", it is copied from the hw_info flag that controls
> the GCFG DCS bit:
> 
> drivers/net/can/rcar/rcar_canfd.c:rcar_canfd_probe() {
>      ...
> 	} else {
> 		fcan_freq = clk_get_rate(gpriv->can_clk);
> 		gpriv->extclk = gpriv->info->external_clk;
> 	}
>      ...
> }
> 
> r9a09g047_hw_info has:
> 
> 	.external_clk = 0,
> 	.fcan_pclk = 0,
> 
> RZ/G3E uses this hw_info, and so do RZ/V2N and RZ/V2H through the
> r9a09g047 fallback compatible. Their device trees (r9a09g047.dtsi,
> r9a09g056.dtsi and r9a09g057.dtsi) only list:
> 
> 	clock-names = "fck", "ram_clk", "can_clk";
> 
> On these SoCs, devm_clk_get_optional(dev, "can_clk") returns a clock
> with a non-zero rate, so the else branch runs. extclk then ends up
> false, and the message prints "canfd clk".
> 
> None of those device trees has a "canfd" clock, so a successful probe on
> these SoCs can only have used "can_clk".

RZ/G3E, RZ/V2H, RZ/V2N have input clocks named in the HW manual as pclk, clk_ram 
and canfd. These are described in [1] page 3365, [2] page 3286, [3] page 3160.

All these have external_clk = 0, fcan_pclk = 0 and the patch here will print 
"canfd clk" for them, as it is actually defined in HW, and as the previous code did.

It is true the commit message mentions it uses DT binding clock names. Maybe 
that should be amended.

With the current binding names and various usage of it across different SoCs I'm 
not sure we can use binding names for all the cases.

Please let me know how would you like me to proceed.

Thank you,
Claudiu


[1] 
https://renesasweb.s3.us-west-2.amazonaws.com/prod/docs/X014/X0142913/r01uh1032ej0140-rzv2h.pdf?response-content-disposition=inline%3B%20filename%3D%22r01uh1032ej0140-rzv2h.pdf%22&response-content-type=application%2Fpdf&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIA3WXFIBJWSDVTHJX3%2F20261112%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20261112T131439Z&X-Amz-SignedHeaders=host&X-Amz-Expires=86700&X-Amz-Signature=495c3e56e8d6cefcdbb3bd6703f5a14e9ad3307c07bdc43510195a230ee39e64

[2] 
https://renesasweb.s3.us-west-2.amazonaws.com/prod/docs/X014/X0148808/r01uh1071ej0130-rzv2n.pdf?response-content-disposition=inline%3B%20filename%3D%22r01uh1071ej0130-rzv2n.pdf%22&response-content-type=application%2Fpdf&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIA3WXFIBJWSDVTHJX3%2F20261112%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20261112T131341Z&X-Amz-SignedHeaders=host&X-Amz-Expires=86700&X-Amz-Signature=5701c16170569ac6e6f206e3dc8644a45da7c6eb78e9d52ed2f1e7c9b08d3773

[3] 
https://renesasweb.s3.us-west-2.amazonaws.com/prod/docs/X015/X0151384/r01uh1069ej0120-rzg3e.pdf?response-content-disposition=inline%3B%20filename%3D%22r01uh1069ej0120-rzg3e.pdf%22&response-content-type=application%2Fpdf&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIA3WXFIBJWSDVTHJX3%2F20261112%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20261112T131308Z&X-Amz-SignedHeaders=host&X-Amz-Expires=86700&X-Amz-Signature=644c54d7cc84b5b32cb6cbe6a678ad53305a30be6d986baf3aed5e4038f18c21

> 
> The commit message says the names "match what users see in the device
> tree". That does not seem to hold on these platforms. The same ternary
> is also still there at the end of the series.
> 
> Could each branch that gets the clock set a const char * clock name
> instead, rather than working it out from extclk and fcan_pclk?
> 
>>   		 gpriv->fdmode ? (gpriv->fd_only_mode ? "fd-only" : "fd") : "classical");
>>   	return 0;
> 
> --
> Pengutronix e.K.                 | Marc Kleine-Budde          |
> Embedded Linux                   | https://www.pengutronix.de |
> Vertretung Nürnberg              | Phone: +49-5121-206917-129 |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

