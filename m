Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C267D474263;
	Mon, 12 Oct 2026 12:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791809898; cv=pass; b=ouj7aQfZMKr9mahIbsEOiGPaSWyTPhHemFhb9LEOwnrvVa/smIOgSW5AYqidE16ieqzbbFD7qU+Tj+R6/z8AbvaDoItpL/QUmDnoXwg3GhWtBvXlzCaStmv7OZTn3dOWCZE9he6NWQONHuR1b4vNJ+otpttGbFdDBzqm9nuWFV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791809898; c=relaxed/simple;
	bh=9jC+P3NBlJwkAq+v2IomGY01Ya7ERa3ydeouImI7yzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iwriMnn/KauHPML9T00kpG29BS7oXIQai2EcVl5tCgwBRnHHBHo49pYk3CCfhI7x5w+gXjfK5t0sUkDiMylpGb9j8IuxjiPeEggxF2iyS9bwkAIqx7DRVRMe5qLHxiB+sbYs3yjsOR/PoMp9t1FLopKW0chsbCXdHEFGhScrmGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=ZxwIYin2; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=PoCFo/g1; arc=pass smtp.client-ip=85.215.255.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="ZxwIYin2";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="PoCFo/g1"
ARC-Seal: i=1; a=rsa-sha256; t=1791809890; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=LUBsmdyjF0d6rA7JDdZ9D6hzL6fjE/LAp+8KRq2IOv/NwOmzbvivtLMzVDEsFCH52d
    N5G1pFBSKD2f3r59hQ5inOswhPoCEvKXo2yNJm5Pkl62C0/RtpZj/jeVHtFygXicHSY3
    EpQ+8aaBjGnSgaFImF4wGWwu5GWSkDAN3Be+Kn+abUSpdP++9Vr58ILUNDNo37qG5L8t
    +2UdkCxEMrwGLoMMBL62Yh4AWpn7NZxZRMkzIQYcLSGjXH4Zlo7S6RD0w9ALfceNdF83
    MOrSAAfI9ogc+vI+Pdhjt6m9Fpw+MfZ9iz85vtIaZOimEcwQYXvwyyvVbW6LGflDQRxh
    hS2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1791809890;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=CLCqiJ+0HxKhv2RnfwueahpaidnFjAPtbHOKMcsbnK8=;
    b=EGzFTb+03aePSuJCwDUuDsZcq9xumVn/sAM8cJpFBcjsa4reBKDQLbUsQ62bqbz/MU
    BA5Simm0fZKu2BFtuooSuOoag4sYQAr22KZDjZL/r7SD9RjRiVg28bC+rQjTR0zObolt
    LTv3TwPS7tVxfKewN4ULhnQwlYNui8bfL++d+U+ah2UjuLoDibPTSQQORhynwL5Gnfag
    6gwAv+36wlwmvxac/tnZlmqecP5vpkIxi6taypd8FuZOQ+OBUFiGWyLtK2tN3NICY0pb
    yYUWDHQqq748kaQ2KW99PRw9VDiO2jpQxlF32VlDh47PgFijJAQZaLLgdeFmyBXe1Mom
    LD6A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1791809890;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=CLCqiJ+0HxKhv2RnfwueahpaidnFjAPtbHOKMcsbnK8=;
    b=ZxwIYin2DI16LxpvRyok3HjZvrIatZeL7tU8nc7qTUYd/Ca1NbHCSiLThjbWbgsV20
    NQ/PIN2czXAUHed1tel5LGeqNgVYO/DBb7xKKLP+gMmRJ1S7c/50OlypyveQvGazqM1a
    sxVDXWQJt3cFOnxhudwD9+v55rBs854JhzeWC8BS7HYoRqG0NhHEYpfYrkqFVrhvySKf
    0+NHFrR5iMJkq8WtFsES9Tx8RW456leowiALQnMT6udjQFq0CHlOtD4yl/AdFp9YdScd
    I3WleBqvrjlown89abyfe/vrMOmBWoHkMjllyhgtBQT1Fk7A1V4BG5jlLYBXlDoNdNgH
    uAzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1791809890;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=CLCqiJ+0HxKhv2RnfwueahpaidnFjAPtbHOKMcsbnK8=;
    b=PoCFo/g1ECbFyRIesMKYDl3YnMsjOcB877HfqeLXVdvtd97oMviOmNq69tBacSqEMR
    EAfb4/Kl4uyxVVQrjoCA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id K04b9a29CCw9gGR
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 12 Oct 2026 14:58:09 +0200 (CEST)
Message-ID: <135a3c74-078a-48eb-9c2a-ef1abe55cb5a@hartkopp.net>
Date: Mon, 12 Oct 2026 14:58:09 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 03/37] can: convert unreliable ARPHRD_CAN type
 checks to robust can_get_ml_priv()
To: netdev-bot+sashiko@kernel.org, mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, hemanth.selam@gmail.com
References: <20261009134323.64064-4-mkl@pengutronix.de>
 <179164096840.434549.11863787117718202775@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <179164096840.434549.11863787117718202775@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10.10.26 16:02, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in case
> you want to address the nit picks below when you respin.
> 
> Low priority / nit picks for your consideration:
> 
> - [Low] The commit message calls the change a conversion of 'unreliable'
>    ARPHRD_CAN checks to 'robust' can_get_ml_priv() checks.
> 
> Pre-existing issues:
> - [Medium] This problem wasn't introduced by this patch, but isotp_bind()
>    in net/can/isotp.c ignores the return values of both can_rx_register()…
> 
> --
> 
> can: convert unreliable ARPHRD_CAN type checks to robust can_get_ml_priv()
> 
> This patch replaces the remaining dev->type != ARPHRD_CAN checks in
> af_can, bcm, gw, isotp and raw with can_get_ml_priv(). The reason given is
> that TUNSETLINK can switch a down TUN/TAP device to ARPHRD_CAN while its
> ml_priv stays NULL.
> 
> Link: https://patch.msgid.link/20261009121115.61012-1-socketcan@hartkopp.net
> 
>> diff --git a/net/can/af_can.c b/net/can/af_can.c
>> index 34fe3b28d576f..dc27ace43719d 100644
>> --- a/net/can/af_can.c
>> +++ b/net/can/af_can.c
> 
> [ ... ]
> 
>> @@ -519,7 +519,7 @@ void can_rx_unregister(struct net *net, struct net_device *dev, canid_t can_id,
>>   	struct can_rcv_lists_stats *rcv_lists_stats = net->can.rcv_lists_stats;
>>   	struct can_dev_rcv_lists *dev_rcv_lists;
>>   
>> -	if (dev && dev->type != ARPHRD_CAN)
>> +	if (dev && !can_get_ml_priv(dev))
>>   		return;
> 
> [Severity: Low]
> The commit message describes this change as replacing "unreliable" checks
> with "robust" ones. Should it also say that the change closes a NULL
> pointer dereference that a user can trigger?
> 
> Before this patch, the sequence looks like this:
> 
>    ioctl(TUNSETLINK, ARPHRD_CAN) on a down tun device
>      tun->dev->type = (int) arg;      /* ml_priv stays NULL */
>    isotp_bind()
>      old dev->type != ARPHRD_CAN check passes
>      can_rx_register() returns -ENODEV, return value ignored
>      so->bound = 1; so->dev = dev;
>    isotp_release() or isotp_notify()
>      can_rx_unregister(net, so->dev, ...)
>        old dev->type != ARPHRD_CAN guard passes
>        can_dev_rcv_lists_find()
>          can_ml = can_get_ml_priv(dev);   /* NULL */
>          return &can_ml->dev_rcv_lists;
>        hlist_for_each_entry_rcu() walks the near-NULL pointer
> 
> dev_rcv_lists sits at offset 0 of struct can_ml_priv, so the returned
> pointer is near-NULL and the list walk oopses.
> 
> Triggering this only requires owning a tun device, or CAP_NET_ADMIN inside
> an unprivileged user namespace.
> 
> The patch carries a Cc: stable tag. Could the message name the oops in
> can_rx_unregister() (reached through isotp_release() or isotp_notify()) and
> the privilege needed to trigger it?

Hi Marc,

do you want me to rephrase the commit message?

The referenced "Fixes" commit from Oleksij
4e096a18867a5a989b ("net: introduce CAN specific pointer in the struct 
net_device") was introduced in Linux 5.12 but is available in stable 5.10.

Best regards,
Oliver

> 
> [ ... ]
> 
>> diff --git a/net/can/isotp.c b/net/can/isotp.c
>> index f5dc9d04bd686..6c28802c0605f 100644
>> --- a/net/can/isotp.c
>> +++ b/net/can/isotp.c
> 
> [ ... ]
> 
>> @@ -1610,7 +1611,7 @@ static int isotp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int l
>>   		err = -ENODEV;
>>   		goto out;
>>   	}
>> -	if (dev->type != ARPHRD_CAN) {
>> +	if (!can_get_ml_priv(dev)) {
>>   		err = -ENODEV;
>>   		goto out_put_dev;
>>   	}
> 
> [Severity: Medium]
> This is a pre-existing issue, not one introduced by this patch. Further
> down, isotp_bind() still ignores the return values of both
> can_rx_register() calls:
> 
> 	if (isotp_register_rxid(so))
> 		can_rx_register(net, dev, rx_id, SINGLE_MASK(rx_id),
> 				isotp_rcv, sk, ...);
> 	...
> 	can_rx_register(net, dev, tx_id, SINGLE_MASK(tx_id),
> 			isotp_rcv_echo, sk, ...);
> 
> 	/* switch to new settings */
> 	...
> 	so->bound = 1;
> 
> The can_get_ml_priv() check above now rules out -ENODEV. Using
> dev_get_by_index(net, ...) also guarantees the netns matches. That leaves
> one possible failure: -ENOMEM from can_rx_register():
> 
> 	rcv = kmem_cache_alloc(rcv_cache, GFP_KERNEL);
> 	if (!rcv)
> 		return -ENOMEM;
> 
> If that allocation fails, bind() still returns 0. The socket then never
> receives flow control frames, or never receives its own TX echoes.
> 
> Transfers would stall until the hrtimers fire. Later, isotp_release() or
> isotp_notify() would hit the "receive list entry not found" warning in
> can_rx_unregister().
> 
> Should isotp_bind() check these return values, and unwind the first
> registration if the second one fails?
> 

