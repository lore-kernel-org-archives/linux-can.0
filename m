Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793952240;
	b=zD/v0Cf11VDn/PirHKKtF7yd6lrTK4nyoQv3eL7zgXgLRO7Gr6hbzU9tMerLU28NJVgQ
	 1MsfFMiKT8ffmlqQsJn+1ApSfuDMeZxlTtUUGhmuw5Hy7WF2G/otVqO9B+omNdmplyTy7
	 Bdi4LJKgMeoS0fGKaBqPrC+wlQ0cqRgCBwws1gEhMR2/twN6798AMERaAlhdi+uK3nIkf
	 hCvsYeIfXB6ri5ubsy/NT494xfl/hlFEctGvdHe4IRB0eiX0v55PJVIlfffyMQP5rwO71
	 CCbpatNFpyOAFiOhuQschu1l9sj1yrZdg7/1Yf3gWRl5ID8TR5PyOALM60LY2N9TCDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793952240;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=k3uHALvzjtptIMCjCni4Os1DaEQGVzPkp8ccI+3SeBQ=;
	b=iCkGM14HOTfPEnriRroJDl3873BggREyk86MdmNKJbbgII0BvpMX/AK6L3m7cEHgLsSD
	 9+bb5kb1YSeaqCyS1pUwRTTGX6rXm/vxijd+2QvPPAswdyiCo0NxC/CeiLlUE8KKIubVU
	 fqA/5XpB5mGlXEOdZShB6wwod9wVOesIzT5mWbSVFKyYrsd79ifuLqg1YyLGB5iImCpHl
	 PgQCPk18SuUI49uKFrJhN4pjgGXyeX9+iBzvOed3InnX1mIA5j5JS6Fw+XXGXKGBko8jx
	 skQCLrPgql5ALKoWRqRbq6GP+r/VdOyxqXx5zpGaOtYn8jb+bo2X1J9E/6MaP0QRehA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tuxon.dev;
	spf=pass smtp.mailfrom=tuxon.dev;
	dkim=pass header.d=tuxon.dev header.i=@tuxon.dev header.a=rsa-sha256 header.s=google header.b=k2vjgbNv;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E9B606A328
	for <linux-can@vger.kernel.org>; Fri,  6 Nov 2026 08:03:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83E9B606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tuxon.dev header.i=@tuxon.dev header.a=rsa-sha256 header.s=google header.b=k2vjgbNv
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4ac95761c85so1896265e9.2
        for <linux-can@vger.kernel.org>; Fri, 06 Nov 2026 00:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1793952238; x=1794557038; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k3uHALvzjtptIMCjCni4Os1DaEQGVzPkp8ccI+3SeBQ=;
        b=k2vjgbNvN06sZzQr7ly4gExj48be0hhFCTg3HdoFnt22kAKYQVYTrUkmQsvYn9Igty
         6zO08AkzRzRm+RaLIdOlx1oWUIt1Oa9vm5bNEDijfCN7oxuL9WmLbQ3zW0KPfuRSPBiW
         8+7y3aBsvtdMOiWSpd5cLYpjZhmD3IJwoUqPeiQMT0+mkz+CDfR0zn/gph0K4DxFWN2c
         joH+fvYKWIeyqoWyb7ZC+vLwJKNXFaffBrLL9cEkw9W7GtsP2VLrYKwCCv9EzAbyuLf9
         fbNpEVG/tcWzEdqUCtUE32u6+FzwbgSjRRMxBLQ+aCGWu64H+wXSV47h1wM6MrRENrtn
         a7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793952238; x=1794557038;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k3uHALvzjtptIMCjCni4Os1DaEQGVzPkp8ccI+3SeBQ=;
        b=Duv4Qkao62X7eLDaZ105bpAUnrCGAAcv/jdN7X6YgweLlJa6Rimhq6Do60iLGp0MnV
         uwjVXqRIdctPrKoIALvLHpA8dBspMZfrLjLCi4orCc9Ovb4BczqaQFrLafCl6/Psx9Ih
         JX/zbxpOHxyA6WUUFQjhyMpIq5XXOZE/fFBMUOanXp0YiYSyhdJ5CvPsMB6IJQDcrGS9
         qXi492CWp5JLjjRfjxf3eQtsW/43w9PB8eGON/8R7L3Udy8J/27npD1jbQmuoaNJbE06
         /4svH9BbnQ78aFpjLgK6wIUneSOT0Vxrl2l6tOW/bA6PL4+kxjTGGK5A4Ed08Rn3quJj
         2GcA==
X-Forwarded-Encrypted: i=1; AKwUvBxvRafIY8dtAfRw7aRNykMmkJfK6h157ZCbWTjN7ylPitkCc6efLxK18fVIFb92qXfl1e1qChO4nJA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9EhhDGryw+YvCyuljmtD5l/8JMjvZUk7xK4Ze9GdeULiMs4ZlS
	BeIuBRUTRseQdCz2Af7nPAeVJART2BhOWVW31qZH9XO1+pNWEoBOVk5M1e1/nd85GDc=
X-Gm-Gg: AYBFou0Xyogftph/3sgkvzu/hrQDw4LjGl7+7MnoHoLeG2pWMtS4KXZ5RUrKa522+sB
	ACFZzQIWxFgwxbdqEXvNToQG9xZDXGXdO5VK863GBtO0pI/YPnXBKCrxo7FoxQzjGnSG16pEPra
	Qm9N9Us9O4jUGBGvPO4Zh1b6vbR44/1V5FWNn5+XaXiUJCA+XDM2eB8gBAOilIkk4ffPbNO/Gtj
	rDzRGrvSZXJpe7sSx1eZC/DPsb6jNOesqhFkjQoL/e92DgjlFzT7blGcWWQe8hTlkP/aePdFTGJ
	pCnkg+qs5AQZpa9/0yQxiRY/PPw7z24TOpJqw1CtJ9NrwtGfiy557BuDsJrBGokbBbOOCS6Y2U0
	FolEvTtWgD3eo0fw02j5dfxqP+Bt/794spUZW5n3aLcofd5e5WOnQJ2ZKIn277PylDXq3N7JQCF
	/AZKJ2f07U7Bdza8qwOWC6WgtGHD/ZeBWfRBqJYtP16BqYEowRnVCl5+LtU0RfN6jDnYh93egih
	a1bhvmFqNqUhqj8RHHmkAkaI7Zpsu8P7R9VXpG0lwhNBcfHGcY0sTgcFy6q83ZaDMFX6ja7qOgj
	tajmtiKgbcrHiCgy/zz7YJRdZvXEZ8ruG9o=
X-Received: by 2002:a05:600c:8b28:b0:4a1:a2c0:7b73 with SMTP id 5b1f17b1804b1-4b6dfba8628mr21279205e9.30.1793952237431;
        Fri, 06 Nov 2026 00:03:57 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.49])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b6ed5b8159sm34920515e9.2.2026.11.06.00.03.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 00:03:56 -0800 (PST)
Message-ID: <096754b1-6362-4f44-992a-989a1ccdec22@tuxon.dev>
Date: Fri, 6 Nov 2026 10:03:55 +0200
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
 <4a9e32a8-8a2e-4b70-8057-2d51e6d38b98@tuxon.dev>
 <69f0c77d-8c23-4949-bbb3-0a07da506b7a@tuxon.dev>
 <20261019-precise-auburn-bison-8b0d0a-mkl@pengutronix.de>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20261019-precise-auburn-bison-8b0d0a-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi, Marc,

On 10/19/26 13:42, Marc Kleine-Budde wrote:
> On 19.10.2026 13:36:49, claudiu beznea wrote:
>>> Based on the comment on this code "If not available fallback to CANFD clock"
>>> I think the intention with IS_ERR() is to allow probing go forward,
>>> falling back to CANFD clock, in case of any error of devm_clk_get().
>>>
>>> The device trees that I've checked sets the can_clk to a fixed clock
>>> with rate = 0 or have the clock provided directly by the SoC clock
>>> provider. I think the intention with IS_ERR() was not only for -ENOENT
>>> but for any other kind of errors. We can return in case of
>>> -EPROBE_DEFER, to ensure the expected clock is used, when it's available
>>> and sane.
>>>
>>> I'll switch to something like:
>>>
>>>    gpriv->can_clk = devm_clk_get(&pdev->dev, "can_clk");
>>> +if (ERR_PTR(gpriv->can_clk) == -EPROBE_DEFER)
>>> +    return dev_err_ptr(dev, ...);
>>
>> On the other hand, returning -EPROBE_DEFER here means the driver may never
>> probe if the can_clk provider fails to probe, even though the fallback clock
>> is available. That would go against what I understand to be the intent of
>> the IS_ERR() check: letting the probe continue when can_clk can't be
>> obtained.
>>
>> Please let me know how you would like me to proceed.
> 
> If the clock continuously fails with the error -EPROBE_DEFER, your
> .config/DT/system is broken. I don't think it's a good idea to ignore
> these errors.
I've addressed the concerns raised in this discussion at [1]. Could you please 
let me know if there is anything else to address for this series and [1] to go 
forward?

Thank you,
Claudiu

[1] https://lore.kernel.org/all/20261019121356.2421761-1-claudiu.beznea@kernel.org
