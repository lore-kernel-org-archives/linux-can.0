Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC394418E6
	for <linux-can@vger.kernel.org>; Fri, 28 Aug 2026 14:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787925862; cv=none; b=AUsfZ/4pl7gxJcvwsGqRHu1MZx7NGcDIiqg2bbF3+4zGtrdAvq2DLrXd6HBdut7KiQ4cFASZgbmHNxq8lFe7xAw8RD6CaHj83US18+isFAT0Dz4pF7Bbi+vvSCOgaxk+x49kx5G9+iHg873u33/HX74iqkFmDdniqpHm42CqDQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787925862; c=relaxed/simple;
	bh=q3tU0zV8nyiy/YhsDfoXnwlTvgeLZN6LYiPK2Y4Aok0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jBDmIWY40IN59YiFS/HJl/ADlDUoHu1pF/XzTxl8trdOa78vLvtYN4q6ENcHRtiyFNOI0J2elkXUaJiDPRoqK1gkx7nH3YzfGLWiEEtjCRkCqHQJS0R6+wM0dT8ixb2YGBeQ95V8Qis0ehYAO0YqVyEhksGJK6KhBzblqT1ddDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mEVWaXi9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mEVWaXi9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2238B1F000E9;
	Fri, 28 Aug 2026 14:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787925860;
	bh=mxv2g8avUd16h29kxU0DcosNkt2HFy3c4P/KB5JAUFY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=mEVWaXi9XR1hmvWW0YwvaImK9Bnj+cE5aBcGE9/MVpjlCwk3/V/RP1lMHrwaw0P22
	 Hjg6+Q+LHZt4A8HeRNqDzqPGf1/nepoYDfzYfiNeJ4MdIgCPq86J7MhcdTc/wK6k50
	 W0NzSQXS4u3Juj5nhIxXQFZ4q6xqZJtrpwVxOOjYYDRM43Epng24h8p3/+ECOLbRh3
	 GbuOdAOkG/lAOmkJTl2Vdq0KGIi/w19/uDFnwKcPVb/tTUL3V8qqBTkq5Hn4iqScoZ
	 ZSH73FKOVP/erzWA5nJQWBzoou9kj0rv1wVjyqvCtp3vqtfKHIm2zaRlG/GGky5hkc
	 0v4WGzmVes1mA==
Message-ID: <1f59b3e6-36fc-490c-bd9f-24ad0c65d80b@kernel.org>
Date: Fri, 28 Aug 2026 16:04:18 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] can: automate IFF_ECHO flag for generic echo skbs
To: Oliver Hartkopp <socketcan@hartkopp.net>,
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
From: Vincent Mailhol <mailhol@kernel.org>
Content-Language: en-US
Autocrypt: addr=mailhol@kernel.org; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 JFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbEBrZXJuZWwub3JnPsKZBBMWCgBBFiEE7Y9wBXTm
 fyDldOjiq1/riG27mcIFAmdfB/kCGwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcC
 F4AACgkQq1/riG27mcKBHgEAygbvORJOfMHGlq5lQhZkDnaUXbpZhxirxkAHwTypHr4A/joI
 2wLjgTCm5I2Z3zB8hqJu+OeFPXZFWGTuk0e2wT4JzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrb
 YZzu0JG5w8gxE6EtQe6LmxKMqP6EyR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDl
 dOjiq1/riG27mcIFAmceMvMCGwwFCQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8V
 zsZwr/S44HCzcz5+jkxnVVQ5LZ4BANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <1b0806a1-c21e-44e8-91f6-9db16f3e8bd3@hartkopp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 28/08/2026 at 14:56, Oliver Hartkopp wrote:
> On 28.08.26 11:22, Vincent Mailhol wrote:
>> On 14/08/2026 at 15:27, Oliver Hartkopp wrote:
>>> On 12.08.26 22:23, Vincent Mailhol wrote:
>>>> On 10/08/2026 at 20:07, Oliver Hartkopp wrote:
>>>
>>>>
>>>> I am still not convinced. If the goal is transparency, I would
>>>> rather do
>>>> it through explicit comments.
>>>>
>>>> In can327 and slcan:
>>>>
>>>>     /* No echo skb: the device has no TX completion handler. Rely on
>>>> the
>>>>      * PF_CAN core for the echo */
>>>>     alloc_candev(sizeof(..), 0);
>>>>
>>>> In grcan and janz-ican3:
>>>>
>>>>     /* The device has it own echo skb mechanism, don't use the
>>>> framework
>>>>      * echo skb. */
>>>>     alloc_candev(sizeof(..), 0);
>>>>     dev->flags |= IFF_ECHO;
>>>>
>>>> And that is what I would call transparent.
>>>
>>> No. This is modifying bit values where you don't know where any why they
>>> have been set. We need some top level function naming that makes
>>> transparent what's going on.
>>
>> But this is exactly my point: IFF_ECHO should be set next to where the
>> echo mechanism is set up, so that we know why the flag is set.
> 
> The grcan example above shows that alloc_candev(sizeof(..), 0) is
> underspecified when you want to "automate" things that can not be
> automated based on the echo skb number.

My point is precisely that grcan's echo handling can not be automated by
alloc_candev(). It allocates its echo skb array manually in grcan_open():

  priv->echo_skb = kzalloc_objs(*priv->echo_skb, dma->tx.size);

So, because the echo skb setup can not be automated, let's automate
*nothing*: neither the skb allocation nor IFF_ECHO.

The rule is simple: does the driver want the framework echo handling?

  - yes: we do everything
  - no: we do nothing

> And this "common" -vs- "special" case breaks the transparency and
> cleanliness about what is to be configured under the hood of
> alloc_candev().
> 
> Maybe we simply need to extend alloc_candev():
> 
> alloc_candev(int sizeof_priv, unsigned int echo_skb_max, bool echo_mode)
> 
> This would make clear, what is enabled and allocated without dubious
> implications nobody can follow easily.

This makes the individual arguments explicit, but it also makes invalid
combinations possible. In particular,

  alloc_candev(sizeof_priv, n, false)

with n non-zero is incorrect. This is the same class of issue we have
today, where a driver can call:

  alloc_candev(sizeof_priv, n);

and forget to set IFF_ECHO. The extra boolean does not resolve the
problem, it just moves it from one place to another.

We have tried several API shapes to cover the grcan and janz-ican3
special case, and each of them had its own drawback. To me, this points
in one direction: this edge case does not fit naturally in the common
API and should remain explicit in the drivers.

>> I just forgot in my previous message to mention that the custom echo skb
>> logic would directly follow (making maybe my argument less clear).
>>
>>>> The IFF_ECHO works in pair with the echo skb. Drivers should either
>>>> take
>>>> the full set or nothing.
>>>>
>>>> Having a alloc_candev(sizeof(..), 0) share a different semantic than
>>>> alloc_candev_no_echo(sizeof(..)) is the opposite of transparency. Where
>>>> is it hinted in the name that one would set IFF_ECHO and not the other?
>>>>
>>>
>>> What about:
>>>
>>> #define NO_ECHO_SKB_ALLOC 0
>>>
>>> alloc_candev_echo(sizeof(..), 4) // usual case
>>>
>>> alloc_candev_echo(sizeof(..), NO_ECHO_SKB_ALLOC) // janz/grcan case
>>>
>>> alloc_candev_no_echo(sizeof(..)) // slcan/can327 case
>>>
>>> where
>>>
>>> alloc_candev_no_echo(unsigned int privsize) {
>>>     struct netdevice dev;
>>>
>>>     dev = alloc_candev_echo(privsize, NO_ECHO_SKB_ALLOC)
>>>     if (dev)
>>>         dev->flags &= ~IFF_ECHO;
>>>
>>>     return dev;
>>> }
>>
>> I am still not convinced that IFF_ECHO should be exposed as an
>> independent policy outside of the echo skb handling.
>>
>> In particular,
>>
>>    alloc_candev_echo(sizeof(..), NO_ECHO_SKB_ALLOC)
>>
>> remains ambiguous to me. The NO_ECHO_SKB_ALLOC argument says that no
>> echo skb is allocated by the framework (which the literal 0 already
>> conveys), but it does not convey that IFF_ECHO would still be set. And
>> even if we rename it to, for example:
>>
>>    alloc_candev_echo(sizeof(..), ECHO_SKB_FLAG_ONLY)
>>
>> we still have a semantic problem: echo_skb_max expects a scalar. What is
>> the meaning of having a maximum of ECHO_SKB_FLAG_ONLY skbs?
>>
>> I do not think this makes the interface more explicit.
>>
>> My main question remains: why should IFF_ECHO be decoupled from the code
>> which sets up the echo mechanism? Even the naming shows coupling:
>>
>>    IFF_*ECHO*
>>    *echo*_skb
>>    alloc_candev_*echo*()
>>
>> And why should we create a special case just for grcan and janz-ican3
>> edge case drivers?
>>
>> The current series maintains the coupling: IFF_ECHO is set by the code
>> which owns the echo mechanism.
>>
>> Finally, I would also prefer not to add another allocator name for a
>> distinction which does not really relate to memory allocation.


Yours sincerely,
Vincent Mailhol

