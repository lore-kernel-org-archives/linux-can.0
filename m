Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D89A43F081
	for <linux-can@vger.kernel.org>; Fri,  7 Aug 2026 11:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786103594; cv=none; b=rfI4qhISdWeMqZ4Xe1RbUaAbS0pEeeqHHaUZhmxy7DFISk0ciqdVvFxbs/bDoU+2sstE/vO51D+YVZ8saEUH1UxXDRdG2wwMjmEdkbXBImU864Ev1cYgi5QMYgmeFq+TGOM2P7Ic/4eggb1daK8CesZi8/HbJMaleSb/jUlVLSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786103594; c=relaxed/simple;
	bh=A68rLyb5IbHApItkCf4vuJOjmsLwxkyAKDpP7U91apw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XBWc96pp9GUw1Z9CF1/wPYvAkKMC5Vi5luTgleDWCG1tusIXNSK9ZSb8dqSWZIO8s+w/XvL6h+Y8VtC5gpXOHtIqAXzaEkNEwxRjZGoijNB/CWRtv28WOgQO9UI71kSdB94MaqQsonEnPD3RbmFk8Vx8yoTtOC9a1hJDqOubmS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1ocWjPf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1ocWjPf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 409A71F000E9;
	Fri,  7 Aug 2026 11:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786103579;
	bh=77p/pmAXXh6NfpiC/A9V3fay6KvwfaVSoJ7/lXQ0FNc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=O1ocWjPfEipV5atsujIzjlG0EcsIRMQ1LBhdgevU5/7d3AS1Mo1jCRYMF7g3ZKKlA
	 itVa8H2R+YU6czASH8dUrnrXq8Pnn/FRY2Ssi9ZvOnJXbYNALiHqSyvUvm55ZBIc+n
	 1sMtrv/y5IXYWRdn83f9H38Qu9NXJu0/kYOOp4kb4pzQaSDPy2uf/B1H/1EXSO/6bB
	 QsRlGtu98e40FLIWSCjS2YcL/Sv54wozthwMOcv93mQImWBurLQKeD6sfUuIcOtrhJ
	 e8FGsrfphcb7cfuN9kkYA68X4o4rEQn7Uv9c/A1gxfTTwswpfkeHV7JS0Tt+lq8WFj
	 EwqvgNUFTPUyQ==
Message-ID: <854c0428-b317-429a-9054-67d467a3d817@kernel.org>
Date: Fri, 7 Aug 2026 13:52:56 +0200
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
In-Reply-To: <721fe2dd-9f42-41e2-a040-3575fb65613e@hartkopp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 07/08/2026 at 12:56, Oliver Hartkopp wrote:
> On 06.08.26 22:55, Vincent Mailhol wrote:
>> On 06/08/2026 at 14:01, Oliver Hartkopp wrote:> On 05.08.26 23:06,
>> Vincent Mailhol wrote:
>>>> On 05/08/2026 at 18:17, Oliver Hartkopp wrote:
>>>
>>>>> IMO it's the right approach that alloc_candev_mqs() sets the IFF_ECHO
>>>>> flag and the default queue len.
>>>>
>>>> For IFF_ECHO, this is exactly what this series does!
>>>
>>> I just wanted to second you. This does not mean that I fully support the
>>> way it is implemented.
>>>
>>>> For the default queue len, why not. I have not study this particular
>>>> topic. But I think the IFF_ECHO and the queue len should be in separate
>>>> series.
>>>
>>> My patch does not even compile. I just wanted to lead the dicsussion
>>> into a direction to find a more versatile solution that covers virtual
>>> CAN interfaces, non-echo CAN interfaces and full featured (echo'ing) CAn
>>> interfaces.
>>>
>>>>> What puzzles me is that the slcan driver is something in between which
>>>>> is neither a real CAN hardware nor a virtual CAN interface.
>>>>
>>>> My understanding it that devices which do not have a TX completion
>>>> handler (like slcan or can327) have no benefits to implement the
>>>> echo_skb framework and can instead simply rely on the PF_CAN core.
>>>
>>> Right.
>>>
>>>>> My idea would be to use alloc_candev() (-> alloc_candev_mqs()) only
>>>>> for
>>>>> real CAN hardware devices and open code slcan and the virtual CAN
>>>>> drivers ... which goes into the direction below.
>>>>>
>>>>> Any thoughts?
>>>>
>>>> The logic I tried to follow in this series is that
>>>> alloc_candev{,_mqs}()
>>>> has two arguments:
>>>>
>>>>     1. one for the priv structure
>>>>
>>>>     2. one for the number of echo_skb
>>>>
>>>> But then, when 2. is zero:
>>>>
>>>>     alloc_candev{,_mqs}(..., 0)
>>>>
>>>> means to me: give me all the features expect from the echo_skb.
>>>>
>>>> With the above, there is no anomalies to see the slcan do:
>>>>
>>>>     dev = alloc_candev(sizeof(*sl), 0);
>>>>
>>>> So I don't see the point to open code the allocations in slcan. After
>>>> patch #1 which corrects the echo skb count, the code describes
>>>> correctly
>>>> the behaviour.
>>>
>>> To me ", 0);" is a silent switch which does not make clear that slcan
>>> and can327 do something different here.
>>>
>>> We have 4 features:
>>>
>>> - support of IFF_ECHO mode using echo_skb's
>>> - support setting of bitrates via netlink
>>> - support setting of whatever via ethtool
>>> - use of TX queues (tx_queue_len != 0)
>>>
>>> And I would like these features to be separately selected to be
>>> transparent about what the CAN driver needs and supports.
>>>
>>> E.g. by defining a wrapper/define
>>>
>>> dev = alloc_non_echo_candev(sizeof(*sl));
>>>
>>> which calls
>>>
>>> dev = alloc_candev(sizeof(*sl), 0);
>>
>> Going this way, it should be the other way around. Have:
>>
>>    alloc_candev(sizeof(*foo));
>>
>> which just does the basic things and then:
>>
>>    alloc_candev_echo_skb(sizeof(*bar), 0);
>>
>> which allocate the echo skbs on top of the basic things.
>>
>> To me, the alloc_non_echo_candev() feels a bit like my previous
>>
>>    dev->flags &= ~IFF_ECHO;
>>
>> in the sense that it is not additive but subtractive.
>>
>>> And the same applies to the other features.
>>
>> But then, you reach a problem. If you do the Cartesian product of all
>> the 4 features, you end up with 2^4 = 16 combinations.
>>
>> Of course, some of the combinations will not be used.
> 
> You likely got me wrong.
> 
> We still have only about 3 cases that use those 4+ features:
> 
> - support of IFF_ECHO mode using echo_skb's
> - support setting of bitrates via netlink
> - support setting of whatever via ethtool
> - use of TX queues (tx_queue_len != 0)
> 
> My idea would be to have different functions to make clear what each of
> these drivers use. And not hide flags based on the number of echo skbs
> or shrink the number of helper functions by adding parameters.
> 
> E.g.
> 
> vcan calls:
> 
> /* sizeof(struct can_ml_priv) is defined in vcan_link_ops */
> can_set_ml_priv(dev, netdev_priv(dev));
> can_setup(dev, (echo)?IFF_ECHO:0);
> vcan_set_mtu_info(dev);
> vcan_set_cap_info(dev);
> dev->tx_queue_len = 0;
> 
> slcan calls:
> 
> dev = alloc_candev(sizeof(struct slcan_priv));
> can_setup(dev, 0);
> slcan_set_mtu_info(dev);
> slcan_set_cap_info(dev);
> dev->tx_queue_len = CAN_TX_QUEUE_LEN;
> 
> 
> m_can calls:
> 
> dev = alloc_candev_echo_skb(sizeof(struct m_can_priv), 4);
> can_setup(dev, IFF_ECHO);
> m_can_set_mtu_info(dev);
> m_can_set_cap_info(dev);
> dev->tx_queue_len = CAN_TX_QUEUE_LEN;
> 
> 
> This is what I meant with transparency and code deduplication.
> E.g. where can_setup() has an extra_flags parameter which is simply
> or'ed to IFF_NOARP.

Now I understand. But I don't like the idea. If I understand correctly,
for the average driver, we will replace one call to:

  alloc_candev_echo_skb()

into roughly four calls.

My goal in this series was to reduce boiler plate while making the
framework more robust. Your proposal increases the boilerplate and
reduces the robustest. Forgetting any one of these setup function is
also a potential security issue.

As a concrete example, this already occurred in the past with several
drivers which forget to populate their MTU, for example: commit
17c8d794527f ("can: mcba_usb: populate ndo_change_mtu() to prevent
buffer overflow").

I modified the framework so that the MTU is now correctly set by default
in commit 23049938605b ("can: populate the minimum and maximum MTU
values") so that today, it is now impossible for a driver to incorrectly
set its MTU.

Introducing a m_can_set_mtu_info() would be going backward to me. We
would open back the gate for a kind of bug which is today closed.

And yes, the v(x)can remains special case which need to open code the
MTU, which is fine as these are really special. But for the majority, it
is a winning choice to "hide" it in the framework rather than take the
risk to trust the drivers to do the right thing.

And so, my though for IFF_ECHO is exactly the same. If it is open coded,
this is a risk (ok, it is less critical than the MTU, but still can lead
to unexpected behaviour). And so, my wish is for IFF_ECHO to follow the
same path as what was done last year for the MTU: handle it in the
framework and forgot this class of bug for the vast majority of the drivers.

> That code needs to be invoked in all those cases anyway but I would like
> to make it visible and transparent which features and flags are enabled
> for which reason.


Yours sincerely,
Vincent Mailhol

