Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018A543551C
	for <linux-can@vger.kernel.org>; Mon, 10 Aug 2026 18:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.163
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786385278; cv=pass; b=Kat345k4Psvjhu+eOg2X8d+hRKsgR502y6VR8llRJdI180g707dyBIAUyLqBdcg9q4O0LVLmuUynubjeAibvKXUR5b8DjsZeGCELuJ/XjB7+n/WEiJcNdbmGXhqO+2SD4d4xXPoTbtCEiQzodXTNYo6DxKpbgqIUxh3bm7QC1WY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786385278; c=relaxed/simple;
	bh=XghfawYM4W3PKULCTv3uyDDCr8JmrMLrJUNFvHV16s8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EVn+dNZWwde+M/BUbRLvWAtFshX7FNnhJVRyYbfnvToOlCa7JPB0Dn9UzoOUvkYKcpybqmMbsG2gB38RHjRLbWKl/uXUgU4VEvRkSG5vecdyaBgmBDQLdqWtuhU+bGFgSzsAiyqE0v1FN7dni7jjGBdzCiG9QL3geLBON1uyXf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=dwnqyNrn; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=4iW87oGb; arc=pass smtp.client-ip=81.169.146.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="dwnqyNrn";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="4iW87oGb"
ARC-Seal: i=1; a=rsa-sha256; t=1786385266; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=e+ovicy/0VHqFRHBhv1j2auHzqpn4lvZovZzo5iAcPvCJ8X7EdALHqQz0rrLhIV5tM
    ltLAyy7C0KsLOIFvacsFDaGrBhOaVC5qo9ciqU9TYD9PWzGFgfFWKYpgk3OrD6odBI2V
    qpxrA4EHReKL0nX06lJTcQIQEkgw/4l+0cjJsQkkpCpRfQTzQxoznuWS6/fZ7gfSN6vQ
    /1M2HqH790iBsaXB57Q41Z15KuufYXLOEsAlomb1dy7+A++SaYalYeJBSpkKDMy9Ebu7
    bR4XqJvdwWOywLdIg5mrIJDQjBgUDyEPpEsirrckD8OxkZ4rtXKUxzOxBtBE/Mx0xFrw
    yNaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1786385266;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ol1n0+dinZ4Ukal+cXdmp0belnwDcjSUiAe1YlyCQYo=;
    b=Ccf3Fwt5oY+3MFnlPZY10P8VM8rEQf6uad8Z+jjOIwZuxjFvp/y2u2o69b1B0jRqtT
    GsWx041b23CxFl8eCXqYPIT6CXe76adcPvh8PQmah5oDux+3fsc8JmY4YEObGqQDCzvp
    fNqyA208ev0ffVAtW6Ps3LeIip+ge+sW2qovmhkGYX1A0b6Y3p/dbQzTOFk0Hm3ZNoYB
    PaSYrfl15J99qaGJTHFmJ54vDU9RuIykrIWAf+JKy00QbhRXFam+hgo1IDr2de6Wm+TD
    7bk3ZSsn5PokOH4ANtkmt/WA0xE2ylpD0A2wki0ZNirPy98TGCl4EU8BW2pOm6/KtTL/
    Rz+Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1786385266;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ol1n0+dinZ4Ukal+cXdmp0belnwDcjSUiAe1YlyCQYo=;
    b=dwnqyNrnXLG6AeHupTjipyp9FKiqNL5nJ+nzpFSDPEbaXyz9TJEBwURaL5Wj/GUcaX
    JaBW8G+6BbywafiCpI2/o/yDZNP9qSBP9E9oDmGm1yYeFyFZSvDM4qbc9H1tUx2usoQZ
    fW+Dhegtbf2innam4woj8IYIUVKGxiH0xzAfJjqlT6WqHs0E+2BhsAkFvpXK85oc3EOc
    6OXLabzAk51xF1jmYjhXegfHOgAoHQrHnQzYCJVWRfYLVarq9fbhmH70/keW4QPYfGf6
    eLa9u96isPna7fTV5soNc5ChxHc6h8C+OjM/T2kySvMqHXukWcEwSqpH8X9TpF+TqdVa
    PRqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1786385266;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ol1n0+dinZ4Ukal+cXdmp0belnwDcjSUiAe1YlyCQYo=;
    b=4iW87oGb165iQ6fpxRJu2CfeNpA/xMmYqzXzhqyPOExHNyGMEOZX+7nRx9g2lGFi13
    vGyA4ZoQuAZVoMc5JGCg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.5.6 AUTH)
    with ESMTPSA id K5281927AI7kTT8
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 10 Aug 2026 20:07:46 +0200 (CEST)
Message-ID: <607de787-e0f2-4872-8021-05431b0e106c@hartkopp.net>
Date: Mon, 10 Aug 2026 20:07:40 +0200
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
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <854c0428-b317-429a-9054-67d467a3d817@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 07.08.26 13:52, Vincent Mailhol wrote:
> On 07/08/2026 at 12:56, Oliver Hartkopp wrote:
>> On 06.08.26 22:55, Vincent Mailhol wrote:
>>> On 06/08/2026 at 14:01, Oliver Hartkopp wrote:> On 05.08.26 23:06,
>>> Vincent Mailhol wrote:
>>>>> On 05/08/2026 at 18:17, Oliver Hartkopp wrote:
>>>>
>>>>>> IMO it's the right approach that alloc_candev_mqs() sets the IFF_ECHO
>>>>>> flag and the default queue len.
>>>>>
>>>>> For IFF_ECHO, this is exactly what this series does!
>>>>
>>>> I just wanted to second you. This does not mean that I fully support the
>>>> way it is implemented.
>>>>
>>>>> For the default queue len, why not. I have not study this particular
>>>>> topic. But I think the IFF_ECHO and the queue len should be in separate
>>>>> series.
>>>>
>>>> My patch does not even compile. I just wanted to lead the dicsussion
>>>> into a direction to find a more versatile solution that covers virtual
>>>> CAN interfaces, non-echo CAN interfaces and full featured (echo'ing) CAn
>>>> interfaces.
>>>>
>>>>>> What puzzles me is that the slcan driver is something in between which
>>>>>> is neither a real CAN hardware nor a virtual CAN interface.
>>>>>
>>>>> My understanding it that devices which do not have a TX completion
>>>>> handler (like slcan or can327) have no benefits to implement the
>>>>> echo_skb framework and can instead simply rely on the PF_CAN core.
>>>>
>>>> Right.
>>>>
>>>>>> My idea would be to use alloc_candev() (-> alloc_candev_mqs()) only
>>>>>> for
>>>>>> real CAN hardware devices and open code slcan and the virtual CAN
>>>>>> drivers ... which goes into the direction below.
>>>>>>
>>>>>> Any thoughts?
>>>>>
>>>>> The logic I tried to follow in this series is that
>>>>> alloc_candev{,_mqs}()
>>>>> has two arguments:
>>>>>
>>>>>      1. one for the priv structure
>>>>>
>>>>>      2. one for the number of echo_skb
>>>>>
>>>>> But then, when 2. is zero:
>>>>>
>>>>>      alloc_candev{,_mqs}(..., 0)
>>>>>
>>>>> means to me: give me all the features expect from the echo_skb.
>>>>>
>>>>> With the above, there is no anomalies to see the slcan do:
>>>>>
>>>>>      dev = alloc_candev(sizeof(*sl), 0);
>>>>>
>>>>> So I don't see the point to open code the allocations in slcan. After
>>>>> patch #1 which corrects the echo skb count, the code describes
>>>>> correctly
>>>>> the behaviour.
>>>>
>>>> To me ", 0);" is a silent switch which does not make clear that slcan
>>>> and can327 do something different here.
>>>>
>>>> We have 4 features:
>>>>
>>>> - support of IFF_ECHO mode using echo_skb's
>>>> - support setting of bitrates via netlink
>>>> - support setting of whatever via ethtool
>>>> - use of TX queues (tx_queue_len != 0)
>>>>
>>>> And I would like these features to be separately selected to be
>>>> transparent about what the CAN driver needs and supports.
>>>>
>>>> E.g. by defining a wrapper/define
>>>>
>>>> dev = alloc_non_echo_candev(sizeof(*sl));
>>>>
>>>> which calls
>>>>
>>>> dev = alloc_candev(sizeof(*sl), 0);
>>>
>>> Going this way, it should be the other way around. Have:
>>>
>>>     alloc_candev(sizeof(*foo));
>>>
>>> which just does the basic things and then:
>>>
>>>     alloc_candev_echo_skb(sizeof(*bar), 0);
>>>
>>> which allocate the echo skbs on top of the basic things.
>>>
>>> To me, the alloc_non_echo_candev() feels a bit like my previous
>>>
>>>     dev->flags &= ~IFF_ECHO;
>>>
>>> in the sense that it is not additive but subtractive.
>>>
>>>> And the same applies to the other features.
>>>
>>> But then, you reach a problem. If you do the Cartesian product of all
>>> the 4 features, you end up with 2^4 = 16 combinations.
>>>
>>> Of course, some of the combinations will not be used.
>>
>> You likely got me wrong.
>>
>> We still have only about 3 cases that use those 4+ features:
>>
>> - support of IFF_ECHO mode using echo_skb's
>> - support setting of bitrates via netlink
>> - support setting of whatever via ethtool
>> - use of TX queues (tx_queue_len != 0)
>>
>> My idea would be to have different functions to make clear what each of
>> these drivers use. And not hide flags based on the number of echo skbs
>> or shrink the number of helper functions by adding parameters.
>>
>> E.g.
>>
>> vcan calls:
>>
>> /* sizeof(struct can_ml_priv) is defined in vcan_link_ops */
>> can_set_ml_priv(dev, netdev_priv(dev));
>> can_setup(dev, (echo)?IFF_ECHO:0);
>> vcan_set_mtu_info(dev);
>> vcan_set_cap_info(dev);
>> dev->tx_queue_len = 0;
>>
>> slcan calls:
>>
>> dev = alloc_candev(sizeof(struct slcan_priv));
>> can_setup(dev, 0);
>> slcan_set_mtu_info(dev);
>> slcan_set_cap_info(dev);
>> dev->tx_queue_len = CAN_TX_QUEUE_LEN;
>>
>>
>> m_can calls:
>>
>> dev = alloc_candev_echo_skb(sizeof(struct m_can_priv), 4);
>> can_setup(dev, IFF_ECHO);
>> m_can_set_mtu_info(dev);
>> m_can_set_cap_info(dev);
>> dev->tx_queue_len = CAN_TX_QUEUE_LEN;
>>
>>
>> This is what I meant with transparency and code deduplication.
>> E.g. where can_setup() has an extra_flags parameter which is simply
>> or'ed to IFF_NOARP.
> 
> Now I understand. But I don't like the idea. If I understand correctly,
> for the average driver, we will replace one call to:
> 
>    alloc_candev_echo_skb()
> 
> into roughly four calls.
> 
> My goal in this series was to reduce boiler plate while making the
> framework more robust. Your proposal increases the boilerplate and
> reduces the robustest. Forgetting any one of these setup function is
> also a potential security issue.
> 
> As a concrete example, this already occurred in the past with several
> drivers which forget to populate their MTU, for example: commit
> 17c8d794527f ("can: mcba_usb: populate ndo_change_mtu() to prevent
> buffer overflow").
> 
> I modified the framework so that the MTU is now correctly set by default
> in commit 23049938605b ("can: populate the minimum and maximum MTU
> values") so that today, it is now impossible for a driver to incorrectly
> set its MTU.
> 
> Introducing a m_can_set_mtu_info() would be going backward to me. We
> would open back the gate for a kind of bug which is today closed.
> 
> And yes, the v(x)can remains special case which need to open code the
> MTU, which is fine as these are really special. But for the majority, it
> is a winning choice to "hide" it in the framework rather than take the
> risk to trust the drivers to do the right thing.

Yes. I understand.

So having

- alloc_candev_echo_skb()
- alloc_candev()

or maybe even better

- alloc_candev(sizeof(..), num_skbs)
- alloc_candev_no_echo(sizeof(..)) /* for slcan / can327 */

make sense.

And with these different names the EFF_ECHO setting is not really hidden 
anymore, which was my concern.

Btw. although v(x)can are different I would be interested in some 
can_setup() function that sets the some common CAN device specific 
values (like IFF_NOARP, default MTUs, etc) that are shared between all 
kinds of CAN interfaces.

And the reason to have it in dev.h was that this would not trigger some 
additional code compilation for v(x)can (beyond today's usage).

Best regards,
Oliver

> 
> And so, my though for IFF_ECHO is exactly the same. If it is open coded,
> this is a risk (ok, it is less critical than the MTU, but still can lead
> to unexpected behaviour). And so, my wish is for IFF_ECHO to follow the
> same path as what was done last year for the MTU: handle it in the
> framework and forgot this class of bug for the vast majority of the drivers.
> 
>> That code needs to be invoked in all those cases anyway but I would like
>> to make it visible and transparent which features and flags are enabled
>> for which reason.
> 
> 
> Yours sincerely,
> Vincent Mailhol
> 

