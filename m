Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B81410D3D
	for <linux-can@vger.kernel.org>; Fri, 28 Aug 2026 12:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.220
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787921813; cv=pass; b=NwLodq2O8QOWUtOIQeHA9xZvKf8xioQsYqmgkjoVOvskPfscJDTTmpADkmZ02SnSDIIGeK5YxQCODVIq5o3d1fnG2tNGWn/J3fIUxjjknHgRESY/eHjZLhxwEGPfxE87wiX23NMla7o3unzobxG560RCgWbfcVrtRNQgWGHt0Ho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787921813; c=relaxed/simple;
	bh=ENiyKDbedjUy425M72mrcLmKACFHv75VQCTguPRGNOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bTWDj2lg9AY9I+dV4MTcTlHoLxPxFmtvcu2n6Kh1+Uyfb23TaN/YFHi1Thw4c4IakvdOMZqKMaU3Y0OBJ2yWcGypYs/n+PRy+7WmlV2lWt1DrXnDh6DWwoUMO3x37S8hY1UpCe/rkznJav1l/0XW6HFZiSsaJ0MDxv9oPUWQ5ho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=qYNs5lgQ; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=eKeB9foU; arc=pass smtp.client-ip=81.169.146.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="qYNs5lgQ";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="eKeB9foU"
ARC-Seal: i=1; a=rsa-sha256; t=1787921802; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=J5cEP1gO0BT8BD02tOwaoDELu5JPTA0ND6ThrSuMNDIPg3wPcvGERVvDXtOT/7Xgj3
    n16zQuGWnkk7nZQ4TDbshkN27XBIZiR4em3tREV6oFGOZhlClE8mA6/K3Pb7kZd/azoy
    7161aQ9RG8WxIA/zmmR+kH+bxfFpye+7sJ86lvpa0pEve7Vu+E/NtsOu2hC2EI9+W3Kd
    /4f1arRYtas5+RYEuBWSzqchoXYKrNAomRnTGsm+XZ+T7a/50kCVoDaA3d3RoStGvl7H
    OTMkNRI64/lG2xFjMAieFsENhIQvAHlYeaTE43LHZ49j6CcQhHhoUs2LqF1TkA7YSMcO
    sjzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1787921802;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=fH97U7jF4KHekRuUN2M5pJQME5Al3ElAh5Prt2qbC/o=;
    b=Vt+R4di4a3seZt5Lv+cPVheTWc2MuvWy3bNCD7MPmX5K6Jl19czhbUgiYIX/APq3+T
    Yg/8uKHZAerLjiMYkIympXCOw3iAuAXnCZPJeVvsOexBYPvtjCXSrG2k3QJJkfINxAfJ
    BNSCe2kCQgXEgn7EDRj1MM14NjnkS0ZCF8oxZ7bGZKV4WXG0a9cwQAIh3qy7caSSjMN8
    G34XvvoqbOcA3zVJU9a5yIwPTpwWG9SBf3weRkOku/EmupLuF2RpLtFTS7Abj8BrFSdg
    E5mYW1aVQKmHH8rqaAmKfl2iIwekUSIkpwBU7ZnAl05LYCTmhuRmRiX6v9fRWe21mCnG
    484A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1787921802;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=fH97U7jF4KHekRuUN2M5pJQME5Al3ElAh5Prt2qbC/o=;
    b=qYNs5lgQA+H2EdmgHgp4qdwXI52RT1s8GKV2FhGTFMceyrl9DaaEfJ6hpqXX48k2/7
    nfhFHEFxYXLUPgtsrOGvJNzDZjW7QwiqKE4Q2rLcwnfai3lEFyTfa744b52SvOvW/kHp
    d+r0f3i/Q4gj6afxL7Fm2P+qzdbWnGxYNgVZ1qb1vSBKyBX5WWecaTEb1Ux+aQ6DjIS+
    An2kQXXuaIuesCQXnjnjw+HHJlA/Gsk6mgkYu82xnSmPvCPIS3j/5K+6QR7B93gv+ths
    mUN1VgUeoiNhGCcf/pYMptoAhX5a4/DYhhHn9/Md1l8ZWLxLV8siceE89y61T1XAMJFL
    0QQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1787921802;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=fH97U7jF4KHekRuUN2M5pJQME5Al3ElAh5Prt2qbC/o=;
    b=eKeB9foUyYr27g9M9VlvYGLOTXlAYP6cBdCAv8qx5SesBicq8ZPSUlLLCEhgQh13uk
    3yB/fRQwdBnxuHOBu4CQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id K171b727SCug8Lx
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 28 Aug 2026 14:56:42 +0200 (CEST)
Message-ID: <1b0806a1-c21e-44e8-91f6-9db16f3e8bd3@hartkopp.net>
Date: Fri, 28 Aug 2026 14:56:37 +0200
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
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <4ab6f83e-f28f-4882-981b-80ae51afa010@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 28.08.26 11:22, Vincent Mailhol wrote:
> On 14/08/2026 at 15:27, Oliver Hartkopp wrote:
>> On 12.08.26 22:23, Vincent Mailhol wrote:
>>> On 10/08/2026 at 20:07, Oliver Hartkopp wrote:
>>
>>>
>>> I am still not convinced. If the goal is transparency, I would rather do
>>> it through explicit comments.
>>>
>>> In can327 and slcan:
>>>
>>>     /* No echo skb: the device has no TX completion handler. Rely on the
>>>      * PF_CAN core for the echo */
>>>     alloc_candev(sizeof(..), 0);
>>>
>>> In grcan and janz-ican3:
>>>
>>>     /* The device has it own echo skb mechanism, don't use the framework
>>>      * echo skb. */
>>>     alloc_candev(sizeof(..), 0);
>>>     dev->flags |= IFF_ECHO;
>>>
>>> And that is what I would call transparent.
>>
>> No. This is modifying bit values where you don't know where any why they
>> have been set. We need some top level function naming that makes
>> transparent what's going on.
> 
> But this is exactly my point: IFF_ECHO should be set next to where the
> echo mechanism is set up, so that we know why the flag is set.

The grcan example above shows that alloc_candev(sizeof(..), 0) is 
underspecified when you want to "automate" things that can not be 
automated based on the echo skb number.

And this "common" -vs- "special" case breaks the transparency and 
cleanliness about what is to be configured under the hood of 
alloc_candev().

Maybe we simply need to extend alloc_candev():

alloc_candev(int sizeof_priv, unsigned int echo_skb_max, bool echo_mode)

This would make clear, what is enabled and allocated without dubious 
implications nobody can follow easily.

Best regards,
Oliver


> 
> I just forgot in my previous message to mention that the custom echo skb
> logic would directly follow (making maybe my argument less clear).
> 
>>> The IFF_ECHO works in pair with the echo skb. Drivers should either take
>>> the full set or nothing.
>>>
>>> Having a alloc_candev(sizeof(..), 0) share a different semantic than
>>> alloc_candev_no_echo(sizeof(..)) is the opposite of transparency. Where
>>> is it hinted in the name that one would set IFF_ECHO and not the other?
>>>
>>
>> What about:
>>
>> #define NO_ECHO_SKB_ALLOC 0
>>
>> alloc_candev_echo(sizeof(..), 4) // usual case
>>
>> alloc_candev_echo(sizeof(..), NO_ECHO_SKB_ALLOC) // janz/grcan case
>>
>> alloc_candev_no_echo(sizeof(..)) // slcan/can327 case
>>
>> where
>>
>> alloc_candev_no_echo(unsigned int privsize) {
>>     struct netdevice dev;
>>
>>     dev = alloc_candev_echo(privsize, NO_ECHO_SKB_ALLOC)
>>     if (dev)
>>         dev->flags &= ~IFF_ECHO;
>>
>>     return dev;
>> }
> 
> I am still not convinced that IFF_ECHO should be exposed as an
> independent policy outside of the echo skb handling.
> 
> In particular,
> 
>    alloc_candev_echo(sizeof(..), NO_ECHO_SKB_ALLOC)
> 
> remains ambiguous to me. The NO_ECHO_SKB_ALLOC argument says that no
> echo skb is allocated by the framework (which the literal 0 already
> conveys), but it does not convey that IFF_ECHO would still be set. And
> even if we rename it to, for example:
> 
>    alloc_candev_echo(sizeof(..), ECHO_SKB_FLAG_ONLY)
> 
> we still have a semantic problem: echo_skb_max expects a scalar. What is
> the meaning of having a maximum of ECHO_SKB_FLAG_ONLY skbs?
> 
> I do not think this makes the interface more explicit.
> 
> My main question remains: why should IFF_ECHO be decoupled from the code
> which sets up the echo mechanism? Even the naming shows coupling:
> 
>    IFF_*ECHO*
>    *echo*_skb
>    alloc_candev_*echo*()
> 
> And why should we create a special case just for grcan and janz-ican3
> edge case drivers?
> 
> The current series maintains the coupling: IFF_ECHO is set by the code
> which owns the echo mechanism.
> 
> Finally, I would also prefer not to add another allocator name for a
> distinction which does not really relate to memory allocation.
> 
> 
> Yours sincerely,
> Vincent Mailhol

