Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3684134E74B
	for <linux-can@vger.kernel.org>; Wed, 12 Aug 2026 20:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786566186; cv=none; b=tCTE9gM/m17eYOGJetMz5k33FB4ZAN9OJsgRX8enBFH+n6RyHcWXqrqOISh0fvBalumTvEF/910Km+ZvWxDun3t0vF76jMb09hTja8kJ0flQ0vis8Vf2iBI4ri5wHb4R6suvTck6PSVRWVJ7nHVZ6yGGmx/9d/7gtAUMhfI80vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786566186; c=relaxed/simple;
	bh=7QXTc6OOuX5B9/13ksacRMufoTCw9ULv5h7n1QLqDs0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YwukiJDB5AKjC9CJWDySSOCHA7fMmepybrg+cMOq6Qx4jW6wFDOcc0CySkJ/aHUyqH9dY+88kvC8kE2ILmg0QovJ6HkZ8zhRuugPr67VV1G7aU8HjRRCukLx///QasyJ6hvGP8OJ3hYVEBngH0kiQYoSDHNVcA1QjPXnWBItTdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jMh3G1OI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jMh3G1OI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C6381F000E9;
	Wed, 12 Aug 2026 20:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786566183;
	bh=HHFOld3gKdtBesEH7b8TvN6SS0xvzDOqz54/bveI+nM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=jMh3G1OIrAEu2drBYBhT73b2TlxcEq+nkeuI71ZyEz/b8aZkjHakCxV/X7kMpgrhE
	 PXpEXJ8Ec3tor1czjfmbSfaQps2vNNr2YjntZGZpKJu/gXkFfOE8hKES2LVSXxTpaa
	 KvQXNLJbjcoC5Wmct0lHaYyVpufYzU2G0qdEFNsfEr31/fSrWM37qCdwsIndPqP8tt
	 MrIS5tlDHbniV1KB5oW1rh4hUKeDPhIYNF/llvDQIwCZ4CaP6g2EQvAvLaH00vjPDN
	 xkP9+Ye7+TZe1d6/+LKi093zqBnvfxh4XWHNnruQJ6SgBeLXCHZu2OKzuPScHltIcv
	 CnCQMfiL0jndw==
Message-ID: <5ff4d3ca-0c28-4c8b-8122-f7f6c782fb62@kernel.org>
Date: Wed, 12 Aug 2026 22:23:00 +0200
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
In-Reply-To: <607de787-e0f2-4872-8021-05431b0e106c@hartkopp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/08/2026 at 20:07, Oliver Hartkopp wrote:
> On 07.08.26 13:52, Vincent Mailhol wrote:
>> On 07/08/2026 at 12:56, Oliver Hartkopp wrote:
>>> On 06.08.26 22:55, Vincent Mailhol wrote:
>>>> On 06/08/2026 at 14:01, Oliver Hartkopp wrote:> On 05.08.26 23:06,
>>>> Vincent Mailhol wrote:
>>>>>> On 05/08/2026 at 18:17, Oliver Hartkopp wrote:
>>>>>
>>>>>>> IMO it's the right approach that alloc_candev_mqs() sets the
>>>>>>> IFF_ECHO
>>>>>>> flag and the default queue len.
>>>>>>
>>>>>> For IFF_ECHO, this is exactly what this series does!
>>>>>
>>>>> I just wanted to second you. This does not mean that I fully
>>>>> support the
>>>>> way it is implemented.
>>>>>
>>>>>> For the default queue len, why not. I have not study this particular
>>>>>> topic. But I think the IFF_ECHO and the queue len should be in
>>>>>> separate
>>>>>> series.
>>>>>
>>>>> My patch does not even compile. I just wanted to lead the dicsussion
>>>>> into a direction to find a more versatile solution that covers virtual
>>>>> CAN interfaces, non-echo CAN interfaces and full featured
>>>>> (echo'ing) CAn
>>>>> interfaces.
>>>>>
>>>>>>> What puzzles me is that the slcan driver is something in between
>>>>>>> which
>>>>>>> is neither a real CAN hardware nor a virtual CAN interface.
>>>>>>
>>>>>> My understanding it that devices which do not have a TX completion
>>>>>> handler (like slcan or can327) have no benefits to implement the
>>>>>> echo_skb framework and can instead simply rely on the PF_CAN core.
>>>>>
>>>>> Right.
>>>>>
>>>>>>> My idea would be to use alloc_candev() (-> alloc_candev_mqs()) only
>>>>>>> for
>>>>>>> real CAN hardware devices and open code slcan and the virtual CAN
>>>>>>> drivers ... which goes into the direction below.
>>>>>>>
>>>>>>> Any thoughts?
>>>>>>
>>>>>> The logic I tried to follow in this series is that
>>>>>> alloc_candev{,_mqs}()
>>>>>> has two arguments:
>>>>>>
>>>>>>      1. one for the priv structure
>>>>>>
>>>>>>      2. one for the number of echo_skb
>>>>>>
>>>>>> But then, when 2. is zero:
>>>>>>
>>>>>>      alloc_candev{,_mqs}(..., 0)
>>>>>>
>>>>>> means to me: give me all the features expect from the echo_skb.
>>>>>>
>>>>>> With the above, there is no anomalies to see the slcan do:
>>>>>>
>>>>>>      dev = alloc_candev(sizeof(*sl), 0);
>>>>>>
>>>>>> So I don't see the point to open code the allocations in slcan. After
>>>>>> patch #1 which corrects the echo skb count, the code describes
>>>>>> correctly
>>>>>> the behaviour.
>>>>>
>>>>> To me ", 0);" is a silent switch which does not make clear that slcan
>>>>> and can327 do something different here.
>>>>>
>>>>> We have 4 features:
>>>>>
>>>>> - support of IFF_ECHO mode using echo_skb's
>>>>> - support setting of bitrates via netlink
>>>>> - support setting of whatever via ethtool
>>>>> - use of TX queues (tx_queue_len != 0)
>>>>>
>>>>> And I would like these features to be separately selected to be
>>>>> transparent about what the CAN driver needs and supports.
>>>>>
>>>>> E.g. by defining a wrapper/define
>>>>>
>>>>> dev = alloc_non_echo_candev(sizeof(*sl));
>>>>>
>>>>> which calls
>>>>>
>>>>> dev = alloc_candev(sizeof(*sl), 0);
>>>>
>>>> Going this way, it should be the other way around. Have:
>>>>
>>>>     alloc_candev(sizeof(*foo));
>>>>
>>>> which just does the basic things and then:
>>>>
>>>>     alloc_candev_echo_skb(sizeof(*bar), 0);
>>>>
>>>> which allocate the echo skbs on top of the basic things.
>>>>
>>>> To me, the alloc_non_echo_candev() feels a bit like my previous
>>>>
>>>>     dev->flags &= ~IFF_ECHO;
>>>>
>>>> in the sense that it is not additive but subtractive.
>>>>
>>>>> And the same applies to the other features.
>>>>
>>>> But then, you reach a problem. If you do the Cartesian product of all
>>>> the 4 features, you end up with 2^4 = 16 combinations.
>>>>
>>>> Of course, some of the combinations will not be used.
>>>
>>> You likely got me wrong.
>>>
>>> We still have only about 3 cases that use those 4+ features:
>>>
>>> - support of IFF_ECHO mode using echo_skb's
>>> - support setting of bitrates via netlink
>>> - support setting of whatever via ethtool
>>> - use of TX queues (tx_queue_len != 0)
>>>
>>> My idea would be to have different functions to make clear what each of
>>> these drivers use. And not hide flags based on the number of echo skbs
>>> or shrink the number of helper functions by adding parameters.
>>>
>>> E.g.
>>>
>>> vcan calls:
>>>
>>> /* sizeof(struct can_ml_priv) is defined in vcan_link_ops */
>>> can_set_ml_priv(dev, netdev_priv(dev));
>>> can_setup(dev, (echo)?IFF_ECHO:0);
>>> vcan_set_mtu_info(dev);
>>> vcan_set_cap_info(dev);
>>> dev->tx_queue_len = 0;
>>>
>>> slcan calls:
>>>
>>> dev = alloc_candev(sizeof(struct slcan_priv));
>>> can_setup(dev, 0);
>>> slcan_set_mtu_info(dev);
>>> slcan_set_cap_info(dev);
>>> dev->tx_queue_len = CAN_TX_QUEUE_LEN;
>>>
>>>
>>> m_can calls:
>>>
>>> dev = alloc_candev_echo_skb(sizeof(struct m_can_priv), 4);
>>> can_setup(dev, IFF_ECHO);
>>> m_can_set_mtu_info(dev);
>>> m_can_set_cap_info(dev);
>>> dev->tx_queue_len = CAN_TX_QUEUE_LEN;
>>>
>>>
>>> This is what I meant with transparency and code deduplication.
>>> E.g. where can_setup() has an extra_flags parameter which is simply
>>> or'ed to IFF_NOARP.
>>
>> Now I understand. But I don't like the idea. If I understand correctly,
>> for the average driver, we will replace one call to:
>>
>>    alloc_candev_echo_skb()
>>
>> into roughly four calls.
>>
>> My goal in this series was to reduce boiler plate while making the
>> framework more robust. Your proposal increases the boilerplate and
>> reduces the robustest. Forgetting any one of these setup function is
>> also a potential security issue.
>>
>> As a concrete example, this already occurred in the past with several
>> drivers which forget to populate their MTU, for example: commit
>> 17c8d794527f ("can: mcba_usb: populate ndo_change_mtu() to prevent
>> buffer overflow").
>>
>> I modified the framework so that the MTU is now correctly set by default
>> in commit 23049938605b ("can: populate the minimum and maximum MTU
>> values") so that today, it is now impossible for a driver to incorrectly
>> set its MTU.
>>
>> Introducing a m_can_set_mtu_info() would be going backward to me. We
>> would open back the gate for a kind of bug which is today closed.
>>
>> And yes, the v(x)can remains special case which need to open code the
>> MTU, which is fine as these are really special. But for the majority, it
>> is a winning choice to "hide" it in the framework rather than take the
>> risk to trust the drivers to do the right thing.
> 
> Yes. I understand.
> 
> So having
> 
> - alloc_candev_echo_skb()
> - alloc_candev()
> 
> or maybe even better
> 
> - alloc_candev(sizeof(..), num_skbs)
> - alloc_candev_no_echo(sizeof(..)) /* for slcan / can327 */
> 
> make sense.

But then, what do we do for the grcan and the janz-ican3 which rely on
the device for the echo skb handling and thus do not allocate any echo
skb through the framework?

Should these two call alloc_candev(sizeof(..), 0) or
alloc_candev_no_echo(sizeof(..))? And why?

> And with these different names the EFF_ECHO setting is not really hidden
> anymore, which was my concern.

I am still not convinced. If the goal is transparency, I would rather do
it through explicit comments.

In can327 and slcan:

  /* No echo skb: the device has no TX completion handler. Rely on the
   * PF_CAN core for the echo */
  alloc_candev(sizeof(..), 0);

In grcan and janz-ican3:

  /* The device has it own echo skb mechanism, don't use the framework
   * echo skb. */
  alloc_candev(sizeof(..), 0);
  dev->flags |= IFF_ECHO;

And that is what I would call transparent.

The IFF_ECHO works in pair with the echo skb. Drivers should either take
the full set or nothing.

Having a alloc_candev(sizeof(..), 0) share a different semantic than
alloc_candev_no_echo(sizeof(..)) is the opposite of transparency. Where
is it hinted in the name that one would set IFF_ECHO and not the other?

> Btw. although v(x)can are different I would be interested in some
> can_setup() function that sets the some common CAN device specific
> values (like IFF_NOARP, default MTUs, etc) that are shared between all
> kinds of CAN interfaces.

But that goes back to the previous problem: this increases the
boilerplate for most of the drivers. I don't mind having some setup
functions shared between the v(x)can, but adding one more call to
can_setup() to the existing drivers is IMHO a step backward.

> And the reason to have it in dev.h was that this would not trigger some
> additional code compilation for v(x)can (beyond today's usage).

Yours sincerely,
Vincent Mailhol

