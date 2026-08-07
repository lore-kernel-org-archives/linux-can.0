Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BD542F70C
	for <linux-can@vger.kernel.org>; Fri,  7 Aug 2026 10:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.161
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786100205; cv=pass; b=faIX9l4EhwuHCHbIQphTq4j55JPOymx/kQxEe7b9IGihraEpiKCUSZhpAHGgailXizHE+CpbINyE2p9CVHMbiwJIBzLrsuDWaNGKV6VP1GZZ5kHKWn8PGAsZogydZKv4GRZRhIAdD8/0IKKP3Opp9WRuvh9ou1fihOEin3XxBgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786100205; c=relaxed/simple;
	bh=HOk9g90/IqFb0SmOOviapqvEyF9zqsjGrHYSBrOxW0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G7DNTaCLzrjkK1oabff0nKPUQeHbvFVve91BBjA/E8bhe5JlngR/D9INPsRO74WUUxu9/p9dEG4d80vUzNZuOCIbCXWyYoK8zs6QZ1uJlGrsg4nTEDIB6ybdbi6cDg6GLhmxtaC3+NgK6gr/tF0f1OBeD+GDX5ttqADgbBe6rx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=kOhMnFcE; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=LwNrCo3a; arc=pass smtp.client-ip=81.169.146.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="kOhMnFcE";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="LwNrCo3a"
ARC-Seal: i=1; a=rsa-sha256; t=1786100194; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=EN8R4v6oOcxOqeyUlwGyRMYzFpAOV/DfRZs7Z+T8e+UMWW4n1PGs58YuLs/RNz63UU
    bj91VqLXdEcUX3KOcg3nYZtLD4iobzCZZ5JC96VKJFS3359SDTYQcuiEAcbbSvG4k6p2
    cwzUMisxwirsI0fE7QKCY7XZf8/v2X0ou+9BojxGsDjZARV8KbMxB6yQNQpjbUJJ43Qf
    KgTQrkuk/O867Ov62m8kcda+HxYekSi7MB4ZoD/qf/v9SNTw1ZKhJasFJzoT8I5DVaFZ
    jne3njvnR2Ky2zRfVlThgsZ5l+U9OXpx2/4g5ImNdAAKqXM9vGIl3gFwyEiDth8n3NMj
    G7aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1786100194;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=2np/63KQzhV0uwam5LmAD4ffIPNfM2RtqW8jq4a2Dds=;
    b=lpQ9GFbdtie9ZZymPPdOpuzhWfwVN2qdB1eOpt0K6AgQ1FTBuqv79zgU4Pq/pwf96g
    XP5S9aPQAMR9394tliC0eNIaBZPYROrP4lYV1U3JPiKUoxjoMUxKoXh39sZ1FunKNXar
    sRSjWbWDbx8KAn7SfFBGFQ1SVD5IzX3EXg5xmHQn4L02C2iJ6hE7xzgrjtS9xx+9CG0h
    qaqgB4dsXpSHik5jA7GtopIGyJFUFhM85LttZgd12JRHdMyNYAYoIN5a9iK277v2cKu+
    1w+4jOOUcxYQUnF40C2LngGi8qXXIGrhMayykB565ZTtkFHgLQyk/GQ42WVRR3DebXp0
    5dgA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1786100194;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=2np/63KQzhV0uwam5LmAD4ffIPNfM2RtqW8jq4a2Dds=;
    b=kOhMnFcEjZPIGYyJEcLk7JoBgsmNj+Z2g09UNQ0J+zw1HMlWKe5yLlXrjvxnQy54ty
    Oz4fTCBZRKHEv69khcavcH5WBpZXJGwU8MwdNNvLJCadoFxo1PwV20EqiczGsW2zNkO7
    ynSfwts84TalBim7vg7EfgD9Ksu/VQI83+Q7AjFS8WOpB32IAGgeqk0hnNIoa6skYRqQ
    dOQnlu0ILsOn6Wv8Ua48m4DyC+lAk4fULmTTVYbQz7RS0nlfkMgMTp/iwOTq0tZeVUvk
    x+x7fcN5fKC9lclVberQWlZiMA16SOfvy7FMVldyxHr2/JEZoJlOaulxU9tLVyg+2qYJ
    mNjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1786100194;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=2np/63KQzhV0uwam5LmAD4ffIPNfM2RtqW8jq4a2Dds=;
    b=LwNrCo3aCSQramAFgfZNhqWXRqXiwRs/JeAZOYA104gJbQ3ptJTq7YpC4bBC317kPq
    BrqFT1UBXlctw2bAEHDw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from [192.168.20.111]
    by smtp.strato.de (RZmta 55.5.6 DYNA|AUTH)
    with ESMTPSA id K52819277AuYGxX
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 7 Aug 2026 12:56:34 +0200 (CEST)
Message-ID: <721fe2dd-9f42-41e2-a040-3575fb65613e@hartkopp.net>
Date: Fri, 7 Aug 2026 12:56:25 +0200
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
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <40d8a352-2bfa-417a-bb20-5d28df90069a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 06.08.26 22:55, Vincent Mailhol wrote:
> On 06/08/2026 at 14:01, Oliver Hartkopp wrote:> On 05.08.26 23:06,
> Vincent Mailhol wrote:
>>> On 05/08/2026 at 18:17, Oliver Hartkopp wrote:
>>
>>>> IMO it's the right approach that alloc_candev_mqs() sets the IFF_ECHO
>>>> flag and the default queue len.
>>>
>>> For IFF_ECHO, this is exactly what this series does!
>>
>> I just wanted to second you. This does not mean that I fully support the
>> way it is implemented.
>>
>>> For the default queue len, why not. I have not study this particular
>>> topic. But I think the IFF_ECHO and the queue len should be in separate
>>> series.
>>
>> My patch does not even compile. I just wanted to lead the dicsussion
>> into a direction to find a more versatile solution that covers virtual
>> CAN interfaces, non-echo CAN interfaces and full featured (echo'ing) CAn
>> interfaces.
>>
>>>> What puzzles me is that the slcan driver is something in between which
>>>> is neither a real CAN hardware nor a virtual CAN interface.
>>>
>>> My understanding it that devices which do not have a TX completion
>>> handler (like slcan or can327) have no benefits to implement the
>>> echo_skb framework and can instead simply rely on the PF_CAN core.
>>
>> Right.
>>
>>>> My idea would be to use alloc_candev() (-> alloc_candev_mqs()) only for
>>>> real CAN hardware devices and open code slcan and the virtual CAN
>>>> drivers ... which goes into the direction below.
>>>>
>>>> Any thoughts?
>>>
>>> The logic I tried to follow in this series is that alloc_candev{,_mqs}()
>>> has two arguments:
>>>
>>>     1. one for the priv structure
>>>
>>>     2. one for the number of echo_skb
>>>
>>> But then, when 2. is zero:
>>>
>>>     alloc_candev{,_mqs}(..., 0)
>>>
>>> means to me: give me all the features expect from the echo_skb.
>>>
>>> With the above, there is no anomalies to see the slcan do:
>>>
>>>     dev = alloc_candev(sizeof(*sl), 0);
>>>
>>> So I don't see the point to open code the allocations in slcan. After
>>> patch #1 which corrects the echo skb count, the code describes correctly
>>> the behaviour.
>>
>> To me ", 0);" is a silent switch which does not make clear that slcan
>> and can327 do something different here.
>>
>> We have 4 features:
>>
>> - support of IFF_ECHO mode using echo_skb's
>> - support setting of bitrates via netlink
>> - support setting of whatever via ethtool
>> - use of TX queues (tx_queue_len != 0)
>>
>> And I would like these features to be separately selected to be
>> transparent about what the CAN driver needs and supports.
>>
>> E.g. by defining a wrapper/define
>>
>> dev = alloc_non_echo_candev(sizeof(*sl));
>>
>> which calls
>>
>> dev = alloc_candev(sizeof(*sl), 0);
> 
> Going this way, it should be the other way around. Have:
> 
>    alloc_candev(sizeof(*foo));
> 
> which just does the basic things and then:
> 
>    alloc_candev_echo_skb(sizeof(*bar), 0);
> 
> which allocate the echo skbs on top of the basic things.
> 
> To me, the alloc_non_echo_candev() feels a bit like my previous
> 
>    dev->flags &= ~IFF_ECHO;
> 
> in the sense that it is not additive but subtractive.
> 
>> And the same applies to the other features.
> 
> But then, you reach a problem. If you do the Cartesian product of all
> the 4 features, you end up with 2^4 = 16 combinations.
> 
> Of course, some of the combinations will not be used.

You likely got me wrong.

We still have only about 3 cases that use those 4+ features:

- support of IFF_ECHO mode using echo_skb's
- support setting of bitrates via netlink
- support setting of whatever via ethtool
- use of TX queues (tx_queue_len != 0)

My idea would be to have different functions to make clear what each of 
these drivers use. And not hide flags based on the number of echo skbs 
or shrink the number of helper functions by adding parameters.

E.g.

vcan calls:

/* sizeof(struct can_ml_priv) is defined in vcan_link_ops */
can_set_ml_priv(dev, netdev_priv(dev));
can_setup(dev, (echo)?IFF_ECHO:0);
vcan_set_mtu_info(dev);
vcan_set_cap_info(dev);
dev->tx_queue_len = 0;

slcan calls:

dev = alloc_candev(sizeof(struct slcan_priv));
can_setup(dev, 0);
slcan_set_mtu_info(dev);
slcan_set_cap_info(dev);
dev->tx_queue_len = CAN_TX_QUEUE_LEN;


m_can calls:

dev = alloc_candev_echo_skb(sizeof(struct m_can_priv), 4);
can_setup(dev, IFF_ECHO);
m_can_set_mtu_info(dev);
m_can_set_cap_info(dev);
dev->tx_queue_len = CAN_TX_QUEUE_LEN;


This is what I meant with transparency and code deduplication.
E.g. where can_setup() has an extra_flags parameter which is simply 
or'ed to IFF_NOARP.

That code needs to be invoked in all those cases anyway but I would like 
to make it visible and transparent which features and flags are enabled 
for which reason.

Maybe _set_mtu_info(dev) and _set_cap_info(dev) could be merged.

Best regards,
Oliver


