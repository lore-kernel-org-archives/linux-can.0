Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC67C4DC54C
	for <linux-can@vger.kernel.org>; Thu,  6 Aug 2026 20:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786049739; cv=none; b=M1Shis+llBgHWr9nu+rU6Y7S3RIzufMUgFi1UhBrTOzt1Ivoa/0FN+buxQGGYmBPdNFe5FKAqDhcq+80ZsftOl6PPvtkjlcXOo+y7OwIjGITMupC7NxV8qlX2ufsE8e2K42aZQVk2aiWQCNBPlNpNl7GWhfMC9DICTtmYfYTauM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786049739; c=relaxed/simple;
	bh=P6A6gRYctyC6vAa/lhR20N5ig+v1K0MDVS3vZXHQHwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PdeAhDv4OZBlWB3ncKcAHz09LUyOXbfbmmSwMHRY2sQltJdC726WshO4NxCTF774/SmuI05CI3961BVS4nGSEQ62jMiK8tDX/Xc1zc9bFMSj8FjanZOQ5ohVelxpzxZuL1lugdq182Owxs8FFj3JzRzonJA99+jRGIXWJGCnvu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=btH7mK86; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btH7mK86"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B0D51F000E9;
	Thu,  6 Aug 2026 20:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786049731;
	bh=FDXhoIxTVevL6sK4+6z6evLHMuJkoF+80Cc1dGkeRq4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=btH7mK86mENcl6jssr/m1fkZPv7BIq6JOQIHidt9dk9TD+BJEykmMYXtL7yVcwint
	 0E4Rvl2+7HlGDBe5s3fyTnNRsaeWNgSYJail7YeOVkTMoIM3qglpobnqoPIjVq+uqC
	 hy8HCzR/HPw4157XptiJLrFb6lzi5pU18SVf4Z8S3d342MitRACQ9NdjERRw4CgXCG
	 9HbQBxHZTeWQK9AwBRXPSWCoMBpuXQuW76rwSC5tfaS1SdidfUGpWcgIPSUaBSuS8r
	 gER0TdqJ0DoGHC3lwnCR4348wwPgzVcc6DmppKZp34AXcT5Inbmq+3hFRMynqxMtII
	 Bwajoantw0YRw==
Message-ID: <40d8a352-2bfa-417a-bb20-5d28df90069a@kernel.org>
Date: Thu, 6 Aug 2026 22:55:28 +0200
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
In-Reply-To: <d045b536-efd0-40a6-8357-e04c9db9236b@hartkopp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/08/2026 at 14:01, Oliver Hartkopp wrote:> On 05.08.26 23:06,
Vincent Mailhol wrote:
>> On 05/08/2026 at 18:17, Oliver Hartkopp wrote:
> 
>>> IMO it's the right approach that alloc_candev_mqs() sets the IFF_ECHO
>>> flag and the default queue len.
>>
>> For IFF_ECHO, this is exactly what this series does!
> 
> I just wanted to second you. This does not mean that I fully support the
> way it is implemented.
> 
>> For the default queue len, why not. I have not study this particular
>> topic. But I think the IFF_ECHO and the queue len should be in separate
>> series.
> 
> My patch does not even compile. I just wanted to lead the dicsussion
> into a direction to find a more versatile solution that covers virtual
> CAN interfaces, non-echo CAN interfaces and full featured (echo'ing) CAn
> interfaces.
> 
>>> What puzzles me is that the slcan driver is something in between which
>>> is neither a real CAN hardware nor a virtual CAN interface.
>>
>> My understanding it that devices which do not have a TX completion
>> handler (like slcan or can327) have no benefits to implement the
>> echo_skb framework and can instead simply rely on the PF_CAN core.
> 
> Right.
> 
>>> My idea would be to use alloc_candev() (-> alloc_candev_mqs()) only for
>>> real CAN hardware devices and open code slcan and the virtual CAN
>>> drivers ... which goes into the direction below.
>>>
>>> Any thoughts?
>>
>> The logic I tried to follow in this series is that alloc_candev{,_mqs}()
>> has two arguments:
>>
>>    1. one for the priv structure
>>
>>    2. one for the number of echo_skb
>>
>> But then, when 2. is zero:
>>
>>    alloc_candev{,_mqs}(..., 0)
>>
>> means to me: give me all the features expect from the echo_skb.
>>
>> With the above, there is no anomalies to see the slcan do:
>>
>>    dev = alloc_candev(sizeof(*sl), 0);
>>
>> So I don't see the point to open code the allocations in slcan. After
>> patch #1 which corrects the echo skb count, the code describes correctly
>> the behaviour.
> 
> To me ", 0);" is a silent switch which does not make clear that slcan
> and can327 do something different here.
> 
> We have 4 features:
> 
> - support of IFF_ECHO mode using echo_skb's
> - support setting of bitrates via netlink
> - support setting of whatever via ethtool
> - use of TX queues (tx_queue_len != 0)
> 
> And I would like these features to be separately selected to be
> transparent about what the CAN driver needs and supports.
> 
> E.g. by defining a wrapper/define
> 
> dev = alloc_non_echo_candev(sizeof(*sl));
> 
> which calls
> 
> dev = alloc_candev(sizeof(*sl), 0);

Going this way, it should be the other way around. Have:

  alloc_candev(sizeof(*foo));

which just does the basic things and then:

  alloc_candev_echo_skb(sizeof(*bar), 0);

which allocate the echo skbs on top of the basic things.

To me, the alloc_non_echo_candev() feels a bit like my previous

  dev->flags &= ~IFF_ECHO;

in the sense that it is not additive but subtractive.

> And the same applies to the other features.

But then, you reach a problem. If you do the Cartesian product of all
the 4 features, you end up with 2^4 = 16 combinations.

Of course, some of the combinations will not be used.

But I definitely prefer a smaller set of functions which can adjust
their behaviour based on their parameters value rather than multiply the
number of functions. I would rather have one function with four
parameters rather than starting to add one function per combination we need.

Back to the echo skb, the prototype is:

  struct net_device * alloc_candev(int sizeof_priv,
                                   unsigned int echo_skb_max);

So:

  alloc_candev(sizeof(*sl), 0);

literally means that we are allocating a candev with a private scruture
of sizeof(*sl) and with zero echo skb.

I really fail to understand your point that setting echo_skb_max to zero
is not transparent but that alloc_non_echo_candev() is.

*echo_skb_max = 0* and *non_echo* are perfect synonymous to me, except
that the first one allows for a more compact implementation.


Yours sincerely,
Vincent Mailhol
