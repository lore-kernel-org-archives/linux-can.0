Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446623D1713
	for <linux-can@vger.kernel.org>; Thu,  6 Aug 2026 12:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.217
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786017868; cv=pass; b=V9kdCaNf1qnIfrptOJYALmUexGGTZCReu224cCFluxP+w8SCIXReE4q36LHCVb+Wyf7fjT/qMdNh7u4IqRRn5UfukKijknKt4c+sRLN4Uy6T9QALmmqUHaiDrgBHDYImlNydkwqx1dbD4DOMGLDJDM8a2AJ/3TyMSREUezOtQJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786017868; c=relaxed/simple;
	bh=55ad15/bWn+WMXLkiY/Ou7Fu8v4YrDObpeOxmnYT9EY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tZHQCKF/6hIa+nVFhrp7X2rEUkmT4EkcRfaeb3alnMX5ex3TihGskW5Tv2Ez6Qgl/Vv7FdfBPP/W0zfCevbzWVYyfH8iR8+O8i827TjMwGApIGy29M9X025l/5CNaauXDpaewNCIBeIKd/rhnEgx5UQ5G2XFpD0rPWMoLN8pJvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=oWOwFwux; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=MEpbT0Nc; arc=pass smtp.client-ip=81.169.146.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="oWOwFwux";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="MEpbT0Nc"
ARC-Seal: i=1; a=rsa-sha256; t=1786017676; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=CwjKEIGsDp0j7cX4ckjNygETwT5JS/mNVUjOtEcmE8TL4TR+0j0FPtNWGNKpJbSsG7
    TjQjWhYZSN7VOIN8UMzHfoJIpV+kFbPkCrIGt2nLvPATLs49+9lUeGgmJ1EDtmzBk+93
    LO790O5gwAbYwnbsSvKNZKATanfYSCWxdj7NRHrTTOZOVPhk/Aae03pon7zmcvpdR6LT
    zkDX4Qa88HiG1rn8+WeNbESmKzyhSxMzyPiaFVlSz55nNs4tyN7p1QBXO+rqR5E6ew1y
    4vl8X1ttBby3cN4MGJrMpOfu9J26eU5coPbeF+c4RjOjKVkxugsFTRW/FtC36cEcByVB
    SvBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1786017676;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=dOV3Nu3pXvl/JhRakvKKJv6NLaSOim+lS+BiCsxdO50=;
    b=R/4lBtWNRRMqUvPNldxYrj4JW3+xh2Ekl/X+3xKq4n/iHoASh5FPg46mzUjuqbE2VM
    BZbjRlJaY63ABV1nqIGMIbvhm0FB2mMhjLO6+8ztHUvNMIIknarJsEL2AU+xynIFNjcI
    1K7y7+QFOnCSFWjO+FkTdjKOX3KJUuSCaVFIzFedqRnKl+UpVK/fOaMoXJszdQfWrjVt
    paoFlHYbWciLj/FksoOscYGwz7IAJv0hBGcS+FqqLhJ5tYxDYIfivtUstJW4ENLaOHNR
    7tdUAL4s9cZzgAEcnLzUug/NEHbL3SHcbExp/ldFGwxO5nk9zEPoDK0o2YvqcIIFdxcl
    qpnw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1786017676;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=dOV3Nu3pXvl/JhRakvKKJv6NLaSOim+lS+BiCsxdO50=;
    b=oWOwFwuxkrRjRJU+6P9WYB1Q2MQGNtdC3Uaa1ztO6E2o6g/yRi+y2tBQ9EMJtHHM1c
    CwPMA2k7QiyePbsCV6nx9KLdj3gQ7/XDY4BPMpDU9SKAfaiEwktu0rgb07RV3hYL5avr
    NAcV2k3pdr/7hfWsqLJp0rvc9IGIE1Zulw3beVDCHMiteSH9f2IYuB9E1472FK+YRAeQ
    3k7q2TDafqLZrNDxueGObhHUjJOJifaHdSuYnTUaijIrrZkVEbWJx4ir453WyHgStD+B
    mEhDAUojS3BrJd92RZYm3XEyrsHCyqayV7vfaDW7g37egVQBpuCnEKECwuItO5O1JT5f
    oCOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1786017676;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=dOV3Nu3pXvl/JhRakvKKJv6NLaSOim+lS+BiCsxdO50=;
    b=MEpbT0Ncm7RUNf1l4cZoJ/wIzBj0DL8aO+4AOcd85EzB4HDPpobqOB9U1t3VccUq9r
    8FB2GJEBvn5wGOz0BzDA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from [192.168.20.231]
    by smtp.strato.de (RZmta 55.5.6 DYNA|AUTH)
    with ESMTPSA id K52819276C1FAGa
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 6 Aug 2026 14:01:15 +0200 (CEST)
Message-ID: <d045b536-efd0-40a6-8357-e04c9db9236b@hartkopp.net>
Date: Thu, 6 Aug 2026 14:01:11 +0200
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
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <95290e92-68c4-4ce7-8a1a-7d23b0a268d5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

-CC linux-kernel@vger.kernel.org

On 05.08.26 23:06, Vincent Mailhol wrote:
> On 05/08/2026 at 18:17, Oliver Hartkopp wrote:

>> IMO it's the right approach that alloc_candev_mqs() sets the IFF_ECHO
>> flag and the default queue len.
> 
> For IFF_ECHO, this is exactly what this series does!

I just wanted to second you. This does not mean that I fully support the 
way it is implemented.

> For the default queue len, why not. I have not study this particular
> topic. But I think the IFF_ECHO and the queue len should be in separate
> series.

My patch does not even compile. I just wanted to lead the dicsussion 
into a direction to find a more versatile solution that covers virtual 
CAN interfaces, non-echo CAN interfaces and full featured (echo'ing) CAn 
interfaces.

>> What puzzles me is that the slcan driver is something in between which
>> is neither a real CAN hardware nor a virtual CAN interface.
> 
> My understanding it that devices which do not have a TX completion
> handler (like slcan or can327) have no benefits to implement the
> echo_skb framework and can instead simply rely on the PF_CAN core.

Right.

>> My idea would be to use alloc_candev() (-> alloc_candev_mqs()) only for
>> real CAN hardware devices and open code slcan and the virtual CAN
>> drivers ... which goes into the direction below.
>>
>> Any thoughts?
> 
> The logic I tried to follow in this series is that alloc_candev{,_mqs}()
> has two arguments:
> 
>    1. one for the priv structure
> 
>    2. one for the number of echo_skb
> 
> But then, when 2. is zero:
> 
>    alloc_candev{,_mqs}(..., 0)
> 
> means to me: give me all the features expect from the echo_skb.
> 
> With the above, there is no anomalies to see the slcan do:
> 
>    dev = alloc_candev(sizeof(*sl), 0);
> 
> So I don't see the point to open code the allocations in slcan. After
> patch #1 which corrects the echo skb count, the code describes correctly
> the behaviour.

To me ", 0);" is a silent switch which does not make clear that slcan 
and can327 do something different here.

We have 4 features:

- support of IFF_ECHO mode using echo_skb's
- support setting of bitrates via netlink
- support setting of whatever via ethtool
- use of TX queues (tx_queue_len != 0)

And I would like these features to be separately selected to be 
transparent about what the CAN driver needs and supports.

E.g. by defining a wrapper/define

dev = alloc_non_echo_candev(sizeof(*sl));

which calls

dev = alloc_candev(sizeof(*sl), 0);

And the same applies to the other features.

>> +    dev->tx_queue_len = CAN_TX_QUEUE_LEN;
> 
> 
> 
>> +    dev->flags |= IFF_ECHO;
> 
> I really prefer to have the IFF_ECHO gated under the
> 
> 	if (echo_skb_max) {
> 
> because it is tightly linked to the echo skb framework.

Definitely not. This is not what I meant with transparency.

> And yes, there are a couple drivers here and there which set IFF_ECHO
> without using the echo skb framework. But these are the drivers which
> implements their own custom echo skb logic. So it makes sense to have
> them open code the IFF_ECHO because they are also open coding the rest
> of the echo skb logic.
> 
> This goes back to my previous point that:
> 
>    alloc_candev{,_mqs}(..., 0)
> 
> means that the drivers do not use the framework echo skb. Such drivers
> fall in two categories:
> 
>    - No echo skb at all (e.g. slcan or can327): no IFF_ECHO
> 
>    - custom echo skb (e.g. grcan, janz-ican3): everything is open coded
>      -> explicit IFF_ECHO flag
> 

And that's why I would like to split these things up - at least by 
naming them differently.

>>       if (echo_skb_max) {
>>           priv->echo_skb_max = echo_skb_max;
>>           priv->echo_skb = (void *)priv +
>>               (size - echo_skb_max * sizeof(struct sk_buff *));
>>       }
>> diff --git a/drivers/net/can/vcan.c b/drivers/net/can/vcan.c
>> index 76e6b7b5c6a1..70263813ec40 100644
>> --- a/drivers/net/can/vcan.c
>> +++ b/drivers/net/can/vcan.c
>> @@ -167,16 +167,15 @@ static const struct ethtool_ops vcan_ethtool_ops = {
>>       .get_ts_info = ethtool_op_get_ts_info,
>>   };
>>
>>   static void vcan_setup(struct net_device *dev)
>>   {
>> -    dev->type        = ARPHRD_CAN;
>> -    dev->mtu        = CANXL_MTU;
>> -    dev->hard_header_len    = 0;
>> -    dev->addr_len        = 0;
>> -    dev->tx_queue_len    = 0;
>> -    dev->flags        = IFF_NOARP;
>> +    can_setup(dev);
>> +    dev->tx_queue_len = 0;
>> +    dev->mtu = CANXL_MTU;
>> +    dev->min_mtu = CAN_MTU;
>> +    dev->max_mtu = CANXL_MTU;
>>       can_set_ml_priv(dev, netdev_priv(dev));
>>       vcan_set_cap_info(dev);
> 
> In such example, please don't add parasite white space changes. It makes
> it hard to grasp what you are actually modifying.

Agreed. As I wrote above - it does not even compile and was never 
intended to be used as upstream code.

(..)

>> -void can_setup(struct net_device *dev);
>> +void can_setup(struct net_device *dev)
>> +{
>> +    dev->type = ARPHRD_CAN;
>> +    dev->mtu = CAN_MTU;
>> +    dev->min_mtu = CAN_MTU;
>> +    dev->max_mtu = CAN_MTU;
>> +    dev->hard_header_len = 0;
>> +    dev->addr_len = 0;
>> +
>> +    /* New-style flags. */
>> +    dev->flags = IFF_NOARP;
>> +    dev->features = NETIF_F_HW_CSUM;
>> +}
> 
> It is strange to have a non static inline function in a header. What was
> the motivation for pulling this out of dev.c?

Yeah. My thought was that we might reduce code duplication when we 
provice more granularity in those helper functions.

I moved it to dev.h to avoid the building of dev.c for the virtual CAN 
interfaces.

Best regards,
Oliver

