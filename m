Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28018768EA
	for <linux-can@vger.kernel.org>; Fri, 14 Aug 2026 13:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.220
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786714402; cv=pass; b=fVPm0FnhiGIotWFRY4QvIQbQ1/4jaPlqjpdBfFdVBchUur9vh5OMUlbijFTAZazJu4skUK13gPN1VDAu9KZVc5PUEZIQoClrJc23tCsUGP1Oi2cMwflaBh+2R8Xdl4bo0ozJmqK4vptLDh7v2BG2I3B9GQc0RkMIbZQeyD9avpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786714402; c=relaxed/simple;
	bh=7SdAidb5737B8FsweCuW3Ga50ilwNNRQ8LR/zNZXL1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VLqaBewoWQvWgWE4PqquVAiYdXI/qvPt8tTEpb8spFQeM4/q547AJqAuHLqbNijFHdXmBw4/hvLE/OvdgsYdqdoIyr05PFZkSL4e0t8UB+mMjDuZg/8+BE7M6zEa4wagPmDghaddJNmMHiPOaLbaB/CxcdIxB9qW3q5i/NqP8YY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=tGnQdwV1; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=BExJso4P; arc=pass smtp.client-ip=81.169.146.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="tGnQdwV1";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="BExJso4P"
ARC-Seal: i=1; a=rsa-sha256; t=1786714031; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=SjM4ULEYgZz9ug0wh8i27u2of/CT4JyFND6EYLngpFFykcOKHSMqWS5VlO7XuTT678
    zoXIrO6HxpwLsnKO7jJRE6RMz8vRPZtCMebXBEqrhnevzWUXiXIREN3H32/XLeNgLpSz
    sTrDOx5veqaANTJCeiyTAg+OIft6+vT/mvnWnQ9M8IfpsRVfTWmDxW7s7+jezmpsWCGi
    +aSUG2Ccy5uBrZsogtJMOhKk6+n5bKzNbGQRzoI6azE5vC5dqr/87adBfTHu1lutc1Ac
    nEvRZzh7nt0gnxzh6VmSFKDVpIZ9+B4l3sEt9LG4PlFGjovKSrPJYKsBTpaW5Q/8SK9A
    v+kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1786714031;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=3mkasH5WJ7lUxJmPED2LMZ+3dcthYGyczj/6ihMspVA=;
    b=g6aGEnyP94Jpz5625F4bNP7S3FQoxqoB8x4T+k94bVhwK3I/NlfqMfiLNa057tpRbw
    QzCc3gay2FEm1Wy2SA/llvVR8BtFUtVYkY6WUWRGkp+ErjswEvJMbf4ibYioJ8KQJC0S
    XCEwtq6wMx3HrxcftrS184YtLJJ8vIj6Tupd/qR1TOcJPtTIApp3M8tnftALozTeH+9R
    Gbk88X89eFjrbIr+UGJcDBFAvvVQGK5Mrw9BpzhIcYcBn7cIYKPCDVpul6+/oEqMWuSU
    6DNEQkMuVWjo98ZhxcA7rkn7fp7Ned17vfODXBskxmCIVFklOb0P7+BD7gfXnb63l5hb
    bVZQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1786714031;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=3mkasH5WJ7lUxJmPED2LMZ+3dcthYGyczj/6ihMspVA=;
    b=tGnQdwV1dYWp8Yb7Z0z+H+gKCYTKj9eTwvdrFoTE1iTqF/z9sSgiLtAljVlInZVCA/
    JWIOLBOO1D9x3ZQ9Xap9v6QdG3+DTNwHmXEpplW7Q89oPh+gtwNkKfpY7SjI+LDmKJw6
    8omvQET7maFCAPW5QAODHfGn/vvjSHLWzhiZebiY3RBNG5njXeqHddu1xuNrzNfN2w6g
    fdcydjALgX9lasywF56OeYEN0ktqCZFCyDOE1pUL2zkTaxFoNdnumIXFbMEufyIAmeEP
    cxkAPUQu72RuYghf/gQdh0aVbU2OWggIAA96ycm7ZF2dcEJJHMLGv3EOglw+NeYUjG+o
    GxhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1786714031;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=3mkasH5WJ7lUxJmPED2LMZ+3dcthYGyczj/6ihMspVA=;
    b=BExJso4PV+Lj7Gy2jGAF+ZB1xL4SKKwdrzmuhEAG10c4FUORUdjB7I6wDL7iXoAD/Z
    3qRCuLLtwXCSOR/jXOAQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id K171b727EDRA3OC
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 14 Aug 2026 15:27:10 +0200 (CEST)
Message-ID: <5c08e210-9982-4f0e-a213-058739da0134@hartkopp.net>
Date: Fri, 14 Aug 2026 15:27:10 +0200
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
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <5ff4d3ca-0c28-4c8b-8122-f7f6c782fb62@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12.08.26 22:23, Vincent Mailhol wrote:
> On 10/08/2026 at 20:07, Oliver Hartkopp wrote:

> 
> I am still not convinced. If the goal is transparency, I would rather do
> it through explicit comments.
> 
> In can327 and slcan:
> 
>    /* No echo skb: the device has no TX completion handler. Rely on the
>     * PF_CAN core for the echo */
>    alloc_candev(sizeof(..), 0);
> 
> In grcan and janz-ican3:
> 
>    /* The device has it own echo skb mechanism, don't use the framework
>     * echo skb. */
>    alloc_candev(sizeof(..), 0);
>    dev->flags |= IFF_ECHO;
> 
> And that is what I would call transparent.

No. This is modifying bit values where you don't know where any why they 
have been set. We need some top level function naming that makes 
transparent what's going on.

> The IFF_ECHO works in pair with the echo skb. Drivers should either take
> the full set or nothing.
> 
> Having a alloc_candev(sizeof(..), 0) share a different semantic than
> alloc_candev_no_echo(sizeof(..)) is the opposite of transparency. Where
> is it hinted in the name that one would set IFF_ECHO and not the other?
> 

What about:

#define NO_ECHO_SKB_ALLOC 0

alloc_candev_echo(sizeof(..), 4) // usual case

alloc_candev_echo(sizeof(..), NO_ECHO_SKB_ALLOC) // janz/grcan case

alloc_candev_no_echo(sizeof(..)) // slcan/can327 case

where

alloc_candev_no_echo(unsigned int privsize) {
    struct netdevice dev;

    dev = alloc_candev_echo(privsize, NO_ECHO_SKB_ALLOC)
    if (dev)
        dev->flags &= ~IFF_ECHO;

    return dev;
}

>> Btw. although v(x)can are different I would be interested in some
>> can_setup() function that sets the some common CAN device specific
>> values (like IFF_NOARP, default MTUs, etc) that are shared between all
>> kinds of CAN interfaces.
> 
> But that goes back to the previous problem: this increases the
> boilerplate for most of the drivers. I don't mind having some setup
> functions shared between the v(x)can, but adding one more call to
> can_setup() to the existing drivers is IMHO a step backward.
> 

Ok. v(x)can can stay completely open coded then.

Best regards,
Oliver

