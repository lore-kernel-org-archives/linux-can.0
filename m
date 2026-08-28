Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3233739DBCB
	for <linux-can@vger.kernel.org>; Fri, 28 Aug 2026 09:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787908938; cv=none; b=dnoxHmvaeOXMZ3q1PhxCJwcstZwMa7mjOcy8atQV+NA1kp/AibQlhzRrxjh6ZplmqAzbJxVm73phzF55AvVd9BcOjV59Ftxvcz16Fzh5bEawQC/dz4wbFm0b4VIdDMpP4K/CISZPPrTwMQVjukz15bOuYEnB/of6PU8YCLMfGXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787908938; c=relaxed/simple;
	bh=Zv9EI3Cj3Zg5S/428Htcpz3ZsbDS5E6vEWLReT7oweI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AXh6vXAxr63TIzcMUlEB4R5+BM354eSKdyfsbb42Vs0XEPkEqxRk0huWuDGehWDQLnMnVsrZNnYVV3MNQnhjKZ3ZrSk8bn3nu+lR6w+ffWANtsXB7ELProfKhtuAJCf5BBkTu7sIr8wO4htSdzn66Yb1A/A4DYGjoj4PDaFEcXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=He/igp3F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="He/igp3F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 180BB1F000E9;
	Fri, 28 Aug 2026 09:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787908936;
	bh=rY4O7Dbyv3ju3ydqkiemGhn6oow6FvbvaD9jne/TrHs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=He/igp3Fq6R6Y3tTqEKWSt/S5Dyy46WkrKpzMOWJ/mZByKRdA1ufVb/u7IrDv4AaP
	 0LZ1JMxgiIgrzAUOFmoKncMP3YIsyq+i0t2ii2YDuo3K8LnClqOub46uaivfIegulb
	 IBeNNoY/heNAwZjqhMKe4HR1Biohs28vv/GocE59f1Z1I0jQYdYml9I3NcsVNVhc8N
	 s+fF3hd4me5cfGiOahx2bU0+owz+TScGtsgV5vH7GqVKhadqNbi9GGWeq1e/vG3JnK
	 V+qNeLk2+fo0SCDU5VI331gxvuOMqvTYfOKytkR6MqyO66bzE8WWknQ6OGKYE9G8k5
	 ciVKoaXhYwtVg==
Message-ID: <4ab6f83e-f28f-4882-981b-80ae51afa010@kernel.org>
Date: Fri, 28 Aug 2026 11:22:13 +0200
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
In-Reply-To: <5c08e210-9982-4f0e-a213-058739da0134@hartkopp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/08/2026 at 15:27, Oliver Hartkopp wrote:
> On 12.08.26 22:23, Vincent Mailhol wrote:
>> On 10/08/2026 at 20:07, Oliver Hartkopp wrote:
> 
>>
>> I am still not convinced. If the goal is transparency, I would rather do
>> it through explicit comments.
>>
>> In can327 and slcan:
>>
>>    /* No echo skb: the device has no TX completion handler. Rely on the
>>     * PF_CAN core for the echo */
>>    alloc_candev(sizeof(..), 0);
>>
>> In grcan and janz-ican3:
>>
>>    /* The device has it own echo skb mechanism, don't use the framework
>>     * echo skb. */
>>    alloc_candev(sizeof(..), 0);
>>    dev->flags |= IFF_ECHO;
>>
>> And that is what I would call transparent.
> 
> No. This is modifying bit values where you don't know where any why they
> have been set. We need some top level function naming that makes
> transparent what's going on.

But this is exactly my point: IFF_ECHO should be set next to where the
echo mechanism is set up, so that we know why the flag is set.

I just forgot in my previous message to mention that the custom echo skb
logic would directly follow (making maybe my argument less clear).

>> The IFF_ECHO works in pair with the echo skb. Drivers should either take
>> the full set or nothing.
>>
>> Having a alloc_candev(sizeof(..), 0) share a different semantic than
>> alloc_candev_no_echo(sizeof(..)) is the opposite of transparency. Where
>> is it hinted in the name that one would set IFF_ECHO and not the other?
>>
> 
> What about:
> 
> #define NO_ECHO_SKB_ALLOC 0
> 
> alloc_candev_echo(sizeof(..), 4) // usual case
> 
> alloc_candev_echo(sizeof(..), NO_ECHO_SKB_ALLOC) // janz/grcan case
> 
> alloc_candev_no_echo(sizeof(..)) // slcan/can327 case
> 
> where
> 
> alloc_candev_no_echo(unsigned int privsize) {
>    struct netdevice dev;
> 
>    dev = alloc_candev_echo(privsize, NO_ECHO_SKB_ALLOC)
>    if (dev)
>        dev->flags &= ~IFF_ECHO;
> 
>    return dev;
> }

I am still not convinced that IFF_ECHO should be exposed as an
independent policy outside of the echo skb handling.

In particular,

  alloc_candev_echo(sizeof(..), NO_ECHO_SKB_ALLOC)

remains ambiguous to me. The NO_ECHO_SKB_ALLOC argument says that no
echo skb is allocated by the framework (which the literal 0 already
conveys), but it does not convey that IFF_ECHO would still be set. And
even if we rename it to, for example:

  alloc_candev_echo(sizeof(..), ECHO_SKB_FLAG_ONLY)

we still have a semantic problem: echo_skb_max expects a scalar. What is
the meaning of having a maximum of ECHO_SKB_FLAG_ONLY skbs?

I do not think this makes the interface more explicit.

My main question remains: why should IFF_ECHO be decoupled from the code
which sets up the echo mechanism? Even the naming shows coupling:

  IFF_*ECHO*
  *echo*_skb
  alloc_candev_*echo*()

And why should we create a special case just for grcan and janz-ican3
edge case drivers?

The current series maintains the coupling: IFF_ECHO is set by the code
which owns the echo mechanism.

Finally, I would also prefer not to add another allocator name for a
distinction which does not really relate to memory allocation.


Yours sincerely,
Vincent Mailhol
