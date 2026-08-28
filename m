Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D94371076
	for <linux-can@vger.kernel.org>; Fri, 28 Aug 2026 17:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.220
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787939889; cv=pass; b=g+gln+A44Y/TcII4NvRj8cWKie8fhLNssrvEavSDo4s9D1s3P/KCEh7znR0rGXOxc38vPYKQ5g1fl5HFxjydH9txfogIrUL6rU6v2FfnbsCJypuqxzJRycWZTKF056MZKbxP9IFZET3Cuog67nJcP+FQmc1lQyRURDD3VctDTcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787939889; c=relaxed/simple;
	bh=Gx9hpN8EegttVV7XEPKVfZghG6a43LRlYdP47Fhr57U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JzVMMwR6eeuPCpaHI7Qs/M4UKsWL2oErUZd7bZ13nnAOuw2+eKbFeI20v+ochFEWyd9JNG1eqplArDnVGgkxBtdpiRwg/oK/5J/oRDO2q/qi6LbdUgszo4cmat1ShfmNUDiaZyqDKw2tqYX0XxSYzPoWE36MD6G1PXd/XpHrh0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Q511Lk01; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=enQ2/XgH; arc=pass smtp.client-ip=81.169.146.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Q511Lk01";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="enQ2/XgH"
ARC-Seal: i=1; a=rsa-sha256; t=1787939885; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=WnxUn2lasRhqTfVBtAPtuhxzpVzVpQGvk7pFok3LElzpeHSa5dczvsyl8EPpdimZEu
    EFJirst/QSfQ43yKbIpa0HfJf3c+ETqcSsNJXrnWdyAzSvcDeQzv/ff7oc6fuOM49cQx
    EXRBzxbTfWLbd1zXZcBJIRf/HKAT3cf34k9QnMYHx+5FEUT4rDtSEetclHQ7PVBNiVge
    3o25y8M4xwxA8fyBfm6qCSVcpkuEtNbjN69nxeNeMoYdlQXWn1fa+eK3neny4wmYhM2B
    oDNRhWGoyKxynqGuI4HbtOuhdRHHirTLpobhrxHZYuKY2r++8KsCd1ktI2Oe4L7JDtal
    4BHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1787939885;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=j5mUMTaUVBFntIQLb+xa79EmpZvkHQfxbWGSjFPvL0E=;
    b=h3ygm08HBpbo9d6PcCSPc6wpTtP559U7Jc4Z203N2xyFXHmKpw6m6tWnHyO8wiCMSJ
    wJQJRB2kivNrVjhfozcMbowGvooS8IWg7jHD4wUKgry+J6yNN4fUgL7VFJ+rit106Khg
    Amt6c7nVYTOSp/ycMdEwmCzDi7ZY4bQ2lqkLZdHwBPao+UIgwhmWp5lVmf2T6kaMcwzN
    trOLKgAfIUECUUr7NPBl7DiIt+01V7Ajaq1Q4Z0ick1xKn98raZEgPXXONzRmTXGfSgX
    WqZMfCBUJFGfMZpSTKeOcHtBzzPvPtTjiH+r4bMnhvTIg8VsN6btYNyD4xKA3LMzy+F1
    wM7Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1787939885;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=j5mUMTaUVBFntIQLb+xa79EmpZvkHQfxbWGSjFPvL0E=;
    b=Q511Lk01pnkV+qd7siC3Zuix7uhDCNvZWSSw/pOlBRamXFM+8YmGVccj2YbipMS0Xi
    fPzy8G+QRqtYci76bzELtsQdroKBE7OU2lCZKPsrcDLQJTnUJHLpswlu3DJ/SASPWulf
    5DqB9PyP8AfSh/hsrFt9ngyepv3daLSRj1OK19U7jbrB7eybyRdE6nROzOSrckiP3q3M
    yERm3F/p30W7jzqhlWjdQaSwQN5GlYgimU29NPdU1TkjTASBvgUx3K4hEKNnZYL4/c6y
    dbyp7qbpVhbFoaoNs9SWMEFWyy9Paf9nex27cqXXFfOrxCu7RRr/9efccB2zKiEjKZSG
    PX5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1787939885;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=j5mUMTaUVBFntIQLb+xa79EmpZvkHQfxbWGSjFPvL0E=;
    b=enQ2/XgHk1ecl6irNb2F1QG42w2lKeKffIrsUTqWtiYG62EO7vCdRoaHKgzyUj7uJq
    o2S7mSg3tOYM82LzrYCQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTRoMrpo2Pns16vpAmsoU3b36JePbQdxLV17iz30DG9myEfZ52Ao="
Received: from [IPV6:2003:d5:5703:e700:49e9:5410:25cc:de9c]
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id K171b727SHw59nL
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 28 Aug 2026 19:58:05 +0200 (CEST)
Message-ID: <11b5411b-5ea3-42f2-a870-5f3baf1b320d@hartkopp.net>
Date: Fri, 28 Aug 2026 19:57:59 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] can: automate IFF_ECHO flag for generic echo skbs
To: Vincent Mailhol <mailhol@kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org
References: <20260804-automate_iff_echo_flag-v1-0-26f06ff0f8bc@kernel.org>
 <395d9b68-2527-47d6-a6a0-74569d27b734@hartkopp.net>
 <6800934d-2da2-4eeb-8514-3978f4c7b307@kernel.org>
 <c487793e-df15-4b32-9cfd-dd72648a8af2@hartkopp.net>
 <95290e92-68c4-4ce7-8a1a-7d23b0a268d5@kernel.org>
 <d045b536-efd0-40a6-8357-e04c9db9236b@hartkopp.net>
 <40d8a352-2bfa-417a-bb20-5d28df90069a@kernel.org>
 <721fe2dd-9f42-41e2-a040-3575fb65613e@hartkopp.net>
 <854c0428-b317-429a-9054-67d467a3d817@kernel.org>
 <607de787-e0f2-4872-8021-05431b0e106c@hartkopp.net>
 <5ff4d3ca-0c28-4c8b-8122-f7f6c782fb62@kernel.org>
 <5c08e210-9982-4f0e-a213-058739da0134@hartkopp.net>
 <4ab6f83e-f28f-4882-981b-80ae51afa010@kernel.org>
 <1b0806a1-c21e-44e8-91f6-9db16f3e8bd3@hartkopp.net>
 <1f59b3e6-36fc-490c-bd9f-24ad0c65d80b@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <1f59b3e6-36fc-490c-bd9f-24ad0c65d80b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 28.08.26 16:04, Vincent Mailhol wrote:
> On 28/08/2026 at 14:56, Oliver Hartkopp wrote:
>> On 28.08.26 11:22, Vincent Mailhol wrote:
>>> On 14/08/2026 at 15:27, Oliver Hartkopp wrote:
>>>> On 12.08.26 22:23, Vincent Mailhol wrote:
>>>>> On 10/08/2026 at 20:07, Oliver Hartkopp wrote:
>>>>
>>>>>
>>>>> I am still not convinced. If the goal is transparency, I would
>>>>> rather do
>>>>> it through explicit comments.
>>>>>
>>>>> In can327 and slcan:
>>>>>
>>>>>      /* No echo skb: the device has no TX completion handler. Rely on
>>>>> the
>>>>>       * PF_CAN core for the echo */
>>>>>      alloc_candev(sizeof(..), 0);
>>>>>
>>>>> In grcan and janz-ican3:
>>>>>
>>>>>      /* The device has it own echo skb mechanism, don't use the
>>>>> framework
>>>>>       * echo skb. */
>>>>>      alloc_candev(sizeof(..), 0);
>>>>>      dev->flags |= IFF_ECHO;
>>>>>
>>>>> And that is what I would call transparent.
>>>>
>>>> No. This is modifying bit values where you don't know where any why they
>>>> have been set. We need some top level function naming that makes
>>>> transparent what's going on.
>>>
>>> But this is exactly my point: IFF_ECHO should be set next to where the
>>> echo mechanism is set up, so that we know why the flag is set.
>>
>> The grcan example above shows that alloc_candev(sizeof(..), 0) is
>> underspecified when you want to "automate" things that can not be
>> automated based on the echo skb number.
> 
> My point is precisely that grcan's echo handling can not be automated by
> alloc_candev(). It allocates its echo skb array manually in grcan_open():
> 
>    priv->echo_skb = kzalloc_objs(*priv->echo_skb, dma->tx.size);
> 
> So, because the echo skb setup can not be automated, let's automate
> *nothing*: neither the skb allocation nor IFF_ECHO.
> 
> The rule is simple: does the driver want the framework echo handling?
> 
>    - yes: we do everything
>    - no: we do nothing
> 

You wanted to have boilerplate code. And now you create a mix of 
boilerplate code and open coding that likely creates more confusion and 
errors.

>> And this "common" -vs- "special" case breaks the transparency and
>> cleanliness about what is to be configured under the hood of
>> alloc_candev().
>>
>> Maybe we simply need to extend alloc_candev():
>>
>> alloc_candev(int sizeof_priv, unsigned int echo_skb_max, bool echo_mode)
>>
>> This would make clear, what is enabled and allocated without dubious
>> implications nobody can follow easily.
> 
> This makes the individual arguments explicit, but it also makes invalid
> combinations possible. In particular,
> 
>    alloc_candev(sizeof_priv, n, false)
> 

First: We all review the newly contributed code - and this is a semantic 
problem that is easy to identify. In the conversion of the existing 
drivers there will be no problem, right?

Second: Where is the problem to return NULL in this invalid case? This 
is not a hot path. But IMO this kind of runtime paranoia checks are not 
needed as we make reviews ...

> with n non-zero is incorrect. This is the same class of issue we have
> today, where a driver can call:
> 
>    alloc_candev(sizeof_priv, n);
> 
> and forget to set IFF_ECHO. The extra boolean does not resolve the
> problem, it just moves it from one place to another.
> 
> We have tried several API shapes to cover the grcan and janz-ican3
> special case, and each of them had its own drawback. To me, this points
> in one direction: this edge case does not fit naturally in the common
> API and should remain explicit in the drivers.

When the "edge case does not fit naturally in the common API" your 
"common API" is just bad.

alloc_candev(int sizeof_priv, unsigned int echo_skb_max, bool echo_mode)

is very clear in the options and features it offers.

So every CAN driver *must* use it. And you can see exactly what it is 
doing for you when looking at the options. And you can also clearly see 
the edge cases where we also can add some comment that tells about the 
different setup.

That is MUCH better than pushing driver developers to open-code the priv 
allocation or other supported features just because they don't need the 
entire bundle.

Best regards,
Oliver

