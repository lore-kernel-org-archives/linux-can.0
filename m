Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EBE305665
	for <linux-can@vger.kernel.org>; Thu, 27 Aug 2026 12:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787834523; cv=pass; b=EKGP9AbWN9FR3Jmh5K5jiUPIHY7CLb9j3n8McTYN7eqGToqU6B4D4mcOEHezmj+dBg/fJlRU/Zo+cgY1Q9Ej14hERLJbD5KVzWqTzs3cAWGq3e0jBQRKM2Q7ntkYYiTibiKkgMypfuI++RWM09jN8epWowi2N3EC9oF1loVZkck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787834523; c=relaxed/simple;
	bh=d8RMf7P+oetRdU/wcSv5Mc1tyswaEInp6kq11mxn6ho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iHu5WegLa9hrTU4Y1aFhh7yT+V1Ljo+ZstPogovyOoceZTy8LusQlppdZHSY5kcSt/ITlI4Ja8MWuUcQEDuDWi3tzisMrqe9WPI7WICU3wL5L0YiP/hrq683p0eEAt7j1wV5OvUF8/DAeyYXZpH+RFIoRCGSnDAg7KNWzbhf0Bk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Nxh0GVDD; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=41+qXHfm; arc=pass smtp.client-ip=85.215.255.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Nxh0GVDD";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="41+qXHfm"
ARC-Seal: i=1; a=rsa-sha256; t=1787834510; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=gRjF6oUlrzKKLr0GSZFjakadwd6/AYQ+wtFFy+xyk3MOO1XIg28YGRiB4q7n0eUqj9
    kip2FR9xFmlr/Pf7D9KhBmY9KXkGk0MXpruXR2NNSEhx44Z7ezV1Ri98Q9cVehM6I0PA
    ZgVcZ5np/WujtUXlnBqun+ITNTV1uj3jz3WE1QXlK0tp4/IIcdASv9pctYdTpl8anBfP
    5PshQUuyeSk6Yz5p2Dawgjfh/B5Mbx1GUGYhxsFJkmBI4lCY/yXXFJyJYNOo0F5q0S5t
    fzUHoAudKRh0a6NZblDrQ96l6i6XfFCTmapS9TwPEEmkKahXv3aTUO9vzvAB4+7B62U/
    9EjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1787834510;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=hq0MddlqMVPMP9Ni7F39xn90k6avYwm2zB4x5ugIGoo=;
    b=gCPNZRHvAyexuilMSNdt2axv7juCkgwlK7ecOUwMolz7tOU5oDrcXLZ0pBS8yilbvS
    DNZwcmhXmlPRUFzVPjdVsF13Nc+5I/B6LUAOBzWA8a99E0G1c8HFPpzWznRPZFkkjMTH
    PLLAZNpQDhLzQtLC+Nn1XmkfDEnNn5TfA05j5I06sSxJPFlDxHGlgugzvzIL+FOEId/v
    7wnzjC3g0YArfquH+KsfbrDfSiXWVANit1P1sqHM/at15OdbXJDPlGoGWXGjjd1boGXK
    E82/KPAAw9NzDWvPIvcvzorkdFBhVfdAdFWtHdVqDTY3F1mDcQ3x/0rw5MzG86By8mlh
    Wcmw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1787834510;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=hq0MddlqMVPMP9Ni7F39xn90k6avYwm2zB4x5ugIGoo=;
    b=Nxh0GVDD7Jo+VRDbCQRqvXpMU+HRbEJL42Gy5AMWBuVqPE0oATPR3HD7N4YgICQikc
    bT89uXJWZ5PB/f6RerC+HfvKHRUpWUq//vnqydA89elxoDSEhnwxV5NHE6FLpjMKR4lq
    UIYTjoAHcAgcevUyCuay9oqVRlLmqNWaI8AP5+NygZPNI4Ovjpx7i6hWbvZcKhwe8M1+
    trI4pbY+0LqLa0+aJ4f92OU1F/NZt7x8K1TxNk8wso/PMSfXraCcAhaf3cG7YqLjAfN5
    4g3jT494teXGNlWyPnjeFAkg+WMSYrnApfVOeKbYQmsU1evlmkWuVe1437H2btyhIPcL
    EwDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1787834510;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=hq0MddlqMVPMP9Ni7F39xn90k6avYwm2zB4x5ugIGoo=;
    b=41+qXHfm9U2jORUD74JLEUPx7nnOyS1HhWAf2nWRWlSzUEJs5zudYmG7rVApcqxudU
    0PvpuzVZisow9kGCY4BA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4Kp38="
Received: from [192.168.20.237]
    by smtp.strato.de (RZmta 55.6.2 SBL|AUTH)
    with ESMTPSA id K171b727RCfo0Pm
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 27 Aug 2026 14:41:50 +0200 (CEST)
Message-ID: <9eb78fcb-49e4-458b-a280-c2a2748c3f61@hartkopp.net>
Date: Thu, 27 Aug 2026 14:41:45 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 02/14] can: convert unreliable ARPHRD_CAN type checks
 to robust can_get_ml_priv()
To: sashiko-reviews@lists.linux.dev, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>, linux-can@vger.kernel.org
References: <20260826121036.2706424-1-mkl@pengutronix.de>
 <20260826121036.2706424-3-mkl@pengutronix.de>
 <20260827121055.141C21F00A3A@smtp.kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260827121055.141C21F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 27.08.26 14:10, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Modifying cloned SKB data without unsharing causes data races and potential silent data corruption in shared CAN FD buffers.
> --
> 
> commit cd014a29d1194dd4eff54897a5d2062f2ec32a0c
> Author: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> can: convert unreliable ARPHRD_CAN type checks to robust can_get_ml_priv()
>      
> This patch converts unreliable ARPHRD_CAN type checks to use the robust
> can_get_ml_priv() function. This prevents TUN/TAP devices from spoofing
> their hardware type to bypass CAN device validation.
> 
> Link: https://patch.msgid.link/20260819160822.8256-1-socketcan@hartkopp.net
> 
>> diff --git a/net/can/af_can.c b/net/can/af_can.c
>> index 7bc86b176b4de..ef435f22ac933 100644
>> --- a/net/can/af_can.c
>> +++ b/net/can/af_can.c
>> @@ -226,7 +226,7 @@ int can_send(struct sk_buff *skb, int loop)
>>   		goto inval_skb;
>>   	}
>>   
>> -	if (unlikely(skb->dev->type != ARPHRD_CAN)) {
>> +	if (unlikely(!can_get_ml_priv(skb->dev))) {
> 
> [Severity: High]
> This is a pre-existing issue, but while reviewing the changes in can_send(),
> I noticed a potential data race when handling cloned SKBs.
> 
> When the CAN gateway forwards a frame without modification functions,
> can_can_gw_rcv() forwards a cloned SKB:
> 
> net/can/gw.c:can_can_gw_rcv() {
>      ...
>      nskb = skb_clone(skb, GFP_ATOMIC);
>      ...
>      can_send(nskb, gwj->limit_hops);
> }
> 
> Then in can_send() just above this diff hunk, the SKB data area is modified
> unconditionally for CAN FD frames:
> 
> net/can/af_can.c:can_send() {
>      ...
>      } else if (can_is_canfd_skb(skb)) {
>          struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
>          ...
>          /* set CAN FD flag for CAN FD frames by default */
>          cfd->flags |= CANFD_FDF;
>      }
>      ...
> }
> 
> Since skb_clone() shares the data area with the original SKB, does modifying
> cfd->flags without unsharing the SKB first cause a data race?
> 
> On architectures without atomic byte-store instructions, this performs a
> word-sized read-modify-write operation. If the original SKB is concurrently
> processed by other receivers, could this silently corrupt adjacent fields?
> Given that an unprivileged user with CAP_NET_ADMIN in a user namespace can
> set up a virtual CAN interface and trigger this path, is this safe?

Yes. Sashiko groundhog day ...

https://lore.kernel.org/linux-can/ac22b59e-129b-4883-b9c6-da5e69e4078d@hartkopp.net/


> 
>>   		err = -EPERM;
>>   		goto inval_skb;
>>   	}
> 
> [ ... ]
> 

