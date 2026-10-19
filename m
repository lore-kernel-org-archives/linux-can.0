Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FAE40D578
	for <linux-can@vger.kernel.org>; Mon, 19 Oct 2026 08:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792396922; cv=none; b=lkK2fLtV8mc8BlbwCoY3i2RNVzOtWZbx2VvvgfSpf80mLVU+QDid1rWuiROOM84yFcnxulecIvo1nKPbboMrOomr0Ufn+83GQXJLZx7tdUIinoBwCCIQZeUzNw0xlczMsHpAYfi4sVhOsfQWCGqzare5b593P0EGYjVHg30Iiys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792396922; c=relaxed/simple;
	bh=hP4wF+WPnK0B2Q1KKFEnxgTNrut6FSSKnsRv3RZJ50A=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fX6l3duVjk/kcnaXIUsCYgebch0Mt2CMjLxijvX9zHEObMHg9uW0v+yP7Nswbul1jgwqItz+PSW9dLtdcAjDIQToLpbhYgHZY5duGbdklVhiUAYr7RLeU4+8v/7Sfo+AYEuPA2EiNqqPWue39z6I+tcGDl50qkQkTevNlQAQR0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Utao0K7C; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Utao0K7C"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a1cef0439aso18920195e9.0
        for <linux-can@vger.kernel.org>; Mon, 19 Oct 2026 01:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1792396918; x=1793001718; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ocLaY0WHvEptQ8Kwyj8wyj7j+7F9Bumbj27CCmpTaLg=;
        b=Utao0K7C7jQ9lwDr4a7gcLnou4U7qG2PjAv9asy6+1mPFi6GMYif9fql1+GfMQGy6p
         hBAn+pE2NPY4kaNBhbe/z9zudJ/tEWMnoI0sR7Di5srb1EVmNZBp39e1SScBwk0oYrT9
         BYH2/p6XpwzY4HRiU/A9dqZpEJCOLkGwWTWThJu67FLa3YgXs/r8ipJId+3tRd3+dVCk
         al+M9AtdW60/Z9/cPA9S5BpK3x4KalRzcmvP6CAT6ozFXUHDL5WDlmEZPQgb1q/AvK7T
         TMykXJKHI+xn/NPT8V9Ri00pO+0KNQJo9FaTGE+YAaSZt4MuBU16xMTY4QZowNnzHUIH
         42ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792396918; x=1793001718;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ocLaY0WHvEptQ8Kwyj8wyj7j+7F9Bumbj27CCmpTaLg=;
        b=WGi37z2B2P9RNL8n6pKo2vlJM1uAEOaDW2uXnuLxjelkbVnCqlTzmjJrVyoionh414
         4TcU5SCgPIKrSzzDGqIO9Lxg/xTRMKhacmnI2CzWt7jYq4MYByJEjXjfwez63nf/X/K9
         WD6OyFVNit5VhYo5wuOtoPMGvWg2+bnA5Ssy4V+mIxHx6E9VRoiwCGAAn1+evFzcG0Va
         sLD/S+5AwYfUU+U0cbYxLCyyWztPmMxz/PCp7yAIzdEw8coc5olsRUjEpoVGnUIt6Ssz
         sY4i48+3Q8AHlU2BvbUEtPdOMxQiQ/WuFIqtaBhUpUFUJ5nObY3taDdxWlZ7PblGZ0yd
         aE2g==
X-Forwarded-Encrypted: i=1; AKwUvByBBkqU3NTQcBoDVXlUFe+JLo1LAP5205zU2HFvjQd2JP74v/Ds80VtCzNVKE3oLDvTSLQgaRXBkrM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ3XTJLVTvPag1Oa4FBGgy8VcCDdgAVk+eetzESlQ27cLCrC638
	2KUAAwkkyS3r2VpoNclADeN5Q0mcc7eUhv02nn/2n3IoH4DOFgLkhLGF4SwL59GBLks=
X-Gm-Gg: AYBFou3uLVAHPfpxEvsTBRAho7rOMlylzGxJRHtsgy/ic0DcFr6MuRIaV+FblDxY8Z+
	a3zIFZNSCS3kPdx22u05lTDqPe4ainMqJC0L7kvhzvKWosBusdjzbMDJfEFYM/tL9dZf1TpE7Qc
	h3g8pwIiGGyOXKiYcNc20NvNCLxkL1SuqAwRXjFbcf7XnfpiULHBeNkewgpauGehbHlCRJTEqA8
	49R6daVhkXo2SkhN9xoTT6j2bSIuO2N7OVFM249/4hvCIH01pMDPinQJp1aNabLKInup9wCASUh
	o9GEVSdAoGbvEpLerQB9wFQGXKIorZ1w76sB72dHrc1F9t0cRvMYvVd/RUvc4A2x03L7rWUmHaK
	SDLa8NIdtZBsRK+5T1Z2gojA9divfVUuKiaOz7xnAWiswUO+condRDKCtmej+M6zErogFcQm2zv
	yED8ot0T3JeZ2OqGLJ9j2Fbo5zTJF+R3RXvrCkSMoJsMLWjJeiM1dr5W+okRb2mOwjb006loC0U
	ssgjr73dIILoFspRw==
X-Received: by 2002:a05:600c:8709:b0:4a1:7b05:3a6d with SMTP id 5b1f17b1804b1-4a1d75e6fa6mr126442275e9.8.1792396917972;
        Mon, 19 Oct 2026 01:01:57 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.221])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1dea678cdsm174349695e9.1.2026.10.19.01.01.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 01:01:57 -0700 (PDT)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu Beznea <claudiu.beznea+renesas@tuxon.dev>
Message-ID: <3ac7b72a-3468-49f6-b4d3-6b33e252ffc6@tuxon.dev>
Date: Mon, 19 Oct 2026 11:01:55 +0300
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/7] dt-bindings: can: renesas,rcar-canfd: Document
 RZ/G3S SoC
To: Biju Das <biju.das.jz@bp.renesas.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "mailhol@kernel.org" <mailhol@kernel.org>,
 "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "geert+renesas@glider.be" <geert+renesas@glider.be>,
 "magnus.damm" <magnus.damm@gmail.com>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 "Claudiu.Beznea" <claudiu.beznea@tuxon.dev>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20260902141544.565763-1-claudiu.beznea+renesas@tuxon.dev>
 <20260902141544.565763-2-claudiu.beznea+renesas@tuxon.dev>
 <20261016-elite-feathered-rook-5dcf2b-mkl@pengutronix.de>
 <TY3PR01MB1134682A7E8AEDB860F02752D86982@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <TY3PR01MB1134682A7E8AEDB860F02752D86982@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi, Biju,

On 10/19/26 10:24, Biju Das wrote:
> Hi Claudiu,
> 
>> -----Original Message-----
>> From: Marc Kleine-Budde <mkl@pengutronix.de>
>> Sent: 16 October 2026 14:34
>> Subject: Re: [PATCH v4 1/7] dt-bindings: can: renesas,rcar-canfd: Document RZ/G3S SoC
>>
>> On 02.09.2026 17:15:38, Claudiu Beznea wrote:
>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>
>>> The CAN FD controller found on the Renesas RZ/G3S SoC is largely
>>> compatible with the variant present on the RZ/G3E SoC. The main differences are:
>>> - the RZ/G3S provides only two CAN FD channels
>>> - the RZ/G3S supports only CAN FD operation; the Channel n CAN FD
>>>    Configuration Register does not implement the bits used to select
>>>    classical CAN-only mode (bit 30) or CAN FD-only mode (bit 28);
>>>    consequently, bit 31 (CAN FD Frame Distinction Enable) of the same
>>>    register is also not implemented
>>> - some bits in several registers (mainly reserved or status bits) are
>>>    read-write on the RZ/G3S but read-only on the RZ/G3E; their behavior is
>>>    otherwise identical: the bits read back as 0 on both SoCs and software
>>>    is allowed to write only 0 to them on the RZ/G3S
>>> - the RZ/G3S provides 256 acceptance filters, compared to 768 on the
>>>    RZ/G3E
>>> - the RZ/G3S can use PCLK clock as the CAN FD clock source through an
>>>    internal clock divider, while also supporting an external CAN FD clock
>>>    source
>>>
>>> Since:
>>> - the SoC clock generator provides to the CAN IP only the peripheral and
>>>    the RAM clocks
>>> - when sourced from the peripheral clock, the CAN-FD clock is obtained
>>>    inside the IP itself by dividing the peripheral clock
>>> - the assigned-clocks and assigned-clock-rates properties are specific to
>>>    the CAN-FD clock
>>> the assigned-clocks and assigned-clock-rates properties were dropped
>>> from the required properties list of the Renesas RZ/G3S SoC.
>>>
>>> Add documentation for the Renesas RZ/G3S SoC.
>>>
>>> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
>>> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> the netdev review bot has found a nitpick, it's about the comment in "rcar_canfd.c". Can you fix it, if
>> you re-spin the series.
>>
>> regards,
>> Marc
>>
>> pw-bot: cr
>>
>> --- Patch [11]: [PATCH net-next 11/37] dt-bindings: can: renesas,rcar-canfd: Document RZ/G3S SoC ---
>> commit 69b4e37d18e5229e1c800b45a5df061af8a98eb9
>> Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> dt-bindings: can: renesas,rcar-canfd: Document RZ/G3S SoC
>>
>> This adds the renesas,r9a08g045-canfd compatible for the RZ/G3S CAN FD controller. It adds the compatible
>> to the existing conditional blocks. It also forbids renesas,no-can-fd and renesas,fd-only on RZ/G3S, and
>> makes assigned-clocks and assigned-clock-rates required only for the other SoCs.
>>
>> Link: https://patch.msgid.link/20260902141544.565763-2-claudiu.beznea+renesas@tuxon.dev
>>
>>> diff --git
>>> a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
>>> b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
>>> index b9d9dd7a7967..bbaaef8f4282 100644
>>> ---
>>> a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
>>> +++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yam
>>> +++ l
>>
>> [ ... ]
>>
>>> @@ -350,6 +352,20 @@ allOf:
>>>         properties:
>>>           reset-names: false
>>>
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            const: renesas,r9a08g045-canfd
>>> +    then:
>>> +      properties:
>>> +        renesas,no-can-fd: false
>>
>> Discovered by: opus-5-5 · Missed by: fable-5-1, gpt-6-astra, sashiko-gemini · Confirmed by: fable-5-1
>> This isn't a bug, but should the renesas,no-can-fd description be updated to match this new constraint?
>>
>> The property description in the same binding still says that every controller can run in Classical CAN
>> mode:
>>
>>    renesas,no-can-fd:
>>      $ref: /schemas/types.yaml#/definitions/flag
>>      description:
>>        The controller can operate in either CAN-FD mode (default) or FD-Only
>>        mode (RZ/{G2L,G3E} and R-Car Gen4) or Classical CAN mode. Specify this
>>        property to put the controller in Classical CAN mode.
>>
>> With this patch the property is forbidden for renesas,r9a08g045-canfd, because RZ/G3S does not have the
>> mode select bits.
>>
>> The header comment in drivers/net/can/rcar/rcar_canfd.c says the same
>> thing:
>>
>>   * To switch the controller to Classical CAN (CAN 2.0) only mode, add
>>   * "renesas,no-can-fd" optional property to the device tree node. A h/w reset is
>>   * also required to switch modes.
>>
>> Neither text is changed later in the series. Both now contradict the schema for RZ/G3S, and for RZ/G3L
>> once it is added the same way.
>>
>> Could the description exclude the SoCs that only support CAN FD mode?
> 
> 
> Do you plan to update description of renesas,no-canfd in bindings/driver exempting Classical CAN mode
> for RZ/G3S? Or do you want me to update?

I intend to send follow up patches today. If you already have something prepared 
for this, please send it.

Thank you,
Claudiu

