Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9044B9201
	for <linux-can@vger.kernel.org>; Mon, 19 Oct 2026 09:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792403910; cv=none; b=OLOTsn6i3GE14lMI4QOm9eTe9FEZAzD7c4Q9rXVlZqfpjbAuOS4IqBL3aFuqdYHYXgKzm0FwM7S/Bf7+nAOlIyaZsj4fl+NpRd+pK+QLXUooTJIannpCtaqh0ElkHA1JnbP/9pElcM1If9rJiYBNuzrFthlDTt74tBPvEl6FEl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792403910; c=relaxed/simple;
	bh=eGAF2rlwQq8vrlYsNjNO5wZQgv0NDo73dHPMv/EUZMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FDsIsmicvBABsX0pSBMuvR8gnoX3jUQM5JRSz11zJKRkPmwAHT7+/Gsb19UTTPUSxfmKj+WbmL2x324FVWPzZpx7dpJ2UFq+4ChjK4vDC4gpsbJFzAT/YHEXsiuD/wT0uOdC9Tr4WqWYaikUDG0r9tZAYKjZfp+BqATl+J3ar40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=ESeQ7N44; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="ESeQ7N44"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49d0da752ffso15175655e9.3
        for <linux-can@vger.kernel.org>; Mon, 19 Oct 2026 02:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1792403906; x=1793008706; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fFxY6AoLFrbUivYUuQNWjKVo2lafGDyB/yJV4/e5rAo=;
        b=ESeQ7N44rAVadcdww7HKi34BCvlPvJ/WBrGpGgngLuTG42gBx+5SPVgNliJCBwVa4O
         89pbHujG+82jsPLRW7e6r5be8yk46hvYDk0tv1axYFUA1ZZY+BApLEC48R9folA95uyD
         p4wQk7ELbE6xscICda7ygBfuARyOq2F9qA9BYJF6BiBYhHDZMXGOdb0kTu7GG7vA1aQP
         xgB+LlgcxdDTyfWqcGIvoYBxbvy3tNrcuEuYIPJXlzvXQNt5ESBkbfzAeuuJvINFNO6L
         oHzHLx8+PNECXfQpuyaHL6zgnSdnKq5axW9zGDie8Cs5UqIzV8e0F3M0ab5pySmr/nVE
         WiDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792403906; x=1793008706;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fFxY6AoLFrbUivYUuQNWjKVo2lafGDyB/yJV4/e5rAo=;
        b=XWB39UUpmELDqgfa4MJWsLt9/skJaAwd7nJ5bk5+8/5cxAZM7NSjBDo+fYWb/OwKhr
         m0QY4LX+WynrAT8P6SrkAKC1izG6tNcKNOLmn8j58AOn3iQ69aBXNjEV/NXiCd+vyg8R
         izQT5dEOxYWzz06pbc5fuoBJchCOYFVsLb10glfu6MdQM9Y31XiB8am5/yfm7xHu2MPo
         Zb0005gD0hoRhVhOdx11Y2JY4AU/68Km4qdUsXr73622eb0ZR/onUKjreu1UQ91+4Fiz
         6Wp9P5kFdrYdWjpK93xfZ8hk1Zqsced1WLMMbOUJbQ6RJ50Rd6z1MQKp8xy2dgXjf2m1
         oMuw==
X-Forwarded-Encrypted: i=1; AKwUvBxeC+MW24iOxzanSFVhONbcCF+rsECL3u20rMmNbJxYg5HM9xC/Stw02v6+VSd+pNGHUCqawA4EWWI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKJ0HNcLkfEPQE2TAofFTmVyRrgdwYzNjO+ZyQRaXFiXSQocMWU
	lkDc9p5iqmitN0Tt/EvjV4J4zIE2u6ttOJIUVFWug2ER4tYsk8WlGEspM2TJVMp8wzw=
X-Gm-Gg: AYBFou3fc1uNSGHSjEAryMxxNBG0ynaWjST8mlBk8j2cLmz6TGJTdQwx5x3fmgCbiea
	j/efUczIyweYJaOBPFCkKW3ctlULYEoY2urn1wM3djq3Sh82ZoyaytLzCxlhzD4V67aAVD4fhNM
	oWLZUTAuCb6BT371dEWo+PbQZqfQsTBK2peh0NktH+yW5RjlUAYISdScI8LN+IHWdKHwVklFcbO
	0FzIG8R3V8rTRX8YQRP1G4nukPzrHpbAri+Bq2DNSipnAsRmvveDjrFAgGCgoZByuMM0InpqbZ+
	uZdhGXhQ4vlZdGXrdx9AFNPI0MyUZTXGgq4FoiFTBpJmaItUGBshMnfO7AAkF+Dzi6tnDaS4OXx
	CPnDgJ+xbtmkipoxxSyjx2eVGi9WKsEhuV5n9qoLysZtGNLFrnP40ipQDPGzzKzKHTWiptxU8Xv
	TGFP5/TvyxMrVTbpnhDIXLLQIEj9gWD6naJYSy/LRXjJEO2nPxbPM65HPGKAFguX6HLiIBsazZM
	Itpx4o=
X-Received: by 2002:a05:600c:540f:b0:4a1:97c6:d2e8 with SMTP id 5b1f17b1804b1-4a1d7633b35mr152802705e9.32.1792403906248;
        Mon, 19 Oct 2026 02:58:26 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.221])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1cdf2f0d1sm156663265e9.2.2026.10.19.02.58.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 02:58:25 -0700 (PDT)
Message-ID: <4a9e32a8-8a2e-4b70-8057-2d51e6d38b98@tuxon.dev>
Date: Mon, 19 Oct 2026 12:58:24 +0300
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
 linux-can@vger.kernel.org, devicetree@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20260902141544.565763-1-claudiu.beznea+renesas@tuxon.dev>
 <20260902141544.565763-4-claudiu.beznea+renesas@tuxon.dev>
 <20261016-durable-meticulous-owl-7a9eed-mkl@pengutronix.de>
 <69826962-0c21-4616-9cd8-6eb0478a422b@tuxon.dev>
 <20261017-weightless-poetic-mayfly-bbdf75-mkl@pengutronix.de>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20261017-weightless-poetic-mayfly-bbdf75-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, Mark,

On 10/17/26 23:01, Marc Kleine-Budde wrote:
>>>>    /* Helper functions */
>>>> @@ -2190,13 +2196,20 @@ static int rcar_canfd_probe(struct platform_device *pdev)
>>>>    	 */
>>>>    	gpriv->can_clk = devm_clk_get(dev, "can_clk");
>>>>    	if (IS_ERR(gpriv->can_clk) || (clk_get_rate(gpriv->can_clk) == 0)) {
>>>               ^^^^^^^^^^^^^^^^^^^^^
>>>
>>> As sashiko.dev [1] pointed out here's no check for -EPROBE_DEFER.
>> This looks to me a pre-existing issue.
>>
>> The newly added support does:
>>
>> fcan_freq = clk_get_rate(gpriv->clkp);
>>
>> At the time this is executed the clkp was already checked against any errors
>                                     ^^^^
>> (above) including -EPROBE_DEFER.
> It's not about "clkp".
> 
> What's missing is, that "gpriv->can_clk" is checked against IS_ERR():
> 
>>>>    	gpriv->can_clk = devm_clk_get(dev, "can_clk");
>>>>    	if (IS_ERR(gpriv->can_clk) || (clk_get_rate(gpriv->can_clk) == 0)) {
> but if it's a -EPROBE_DEFER, IS_ERR() returns true. I think in this case
> you want to return with dev_err_probe().
> 
> There's also a difference between "can_clk" not found (e.g. not
> configured in DT), and there was a problem with "can_clk". I don't know
> if this is important for this driver, but if you want to distinguish
> between those, you can use devm_clk_get_optional(). I will return NULL
> if the clock is not found, -EPROBE_DEFER if not available yet, the clock
> or, in case of an error -errno.
> 
> Thinking about it: if "can_clk" is not available, I would consider it
> intentional, so the driver should use the other clock. If the clock has
> an error, the driver should not fallback to a probably untested clock
> configuration.

         /* fCAN clock: Pick External clock. If not available fallback to
          * CANFD clock
          */
         gpriv->can_clk = devm_clk_get(dev, "can_clk");
         if (IS_ERR(gpriv->can_clk) || (clk_get_rate(gpriv->can_clk) == 0)) {

Based on the comment on this code "If not available fallback to CANFD clock"
I think the intention with IS_ERR() is to allow probing go forward, falling back 
to CANFD clock, in case of any error of devm_clk_get().

The device trees that I've checked sets the can_clk to a fixed clock with rate = 
0 or have the clock provided directly by the SoC clock provider. I think the 
intention with IS_ERR() was not only for -ENOENT but for any other kind of 
errors. We can return in case of -EPROBE_DEFER, to ensure the expected clock is 
used, when it's available and sane.

I'll switch to something like:

  gpriv->can_clk = devm_clk_get(&pdev->dev, "can_clk");
+if (ERR_PTR(gpriv->can_clk) == -EPROBE_DEFER)
+	return dev_err_ptr(dev, ...);

The devm_clk_get_optional() would involve changing more lines:

-       gpriv->can_clk = devm_clk_get(dev, "can_clk");
-       if (IS_ERR(gpriv->can_clk) || (clk_get_rate(gpriv->can_clk) == 0)) {
+       gpriv->can_clk = devm_clk_get_optional(dev, "can_clk");
+       if (ERR_PTR(gpriv->can_clk) == -EPROBE_DEFER)
+               return dev_err_probe(dev, -EPROBE_DEFER, "cannot get can_clk");
+
+       if (IS_ERR_OR_NULL(gpriv->can_clk) || (clk_get_rate(gpriv->can_clk) == 0)) {
                 gpriv->can_clk = devm_clk_get(dev, "canfd");
                 if (IS_ERR(gpriv->can_clk))
                         return dev_err_probe(dev, PTR_ERR(gpriv->can_clk),

Please let me know otherwise.

Thank you,
Claudiu
