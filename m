Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208A146DFEB;
	Fri, 16 Oct 2026 10:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792144961; cv=pass; b=KiWa5am0b/VATl0IE3C8Z20FtkPOeAxhJc/l8DDbXvlhZs3/Bek2EnxQUc/AU7xmcN3nT1xl1mcsw3Ndgq6cPCf3zHMKSqyxxz97cOonnoS+l9aD4JO2dklvSG+vSlMuzDCy/xIUkHFuibB1TYPhd7bBFdW/IxYe7mcnId4gEG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792144961; c=relaxed/simple;
	bh=pi9nK/MNaWYOAKNlyBL5BQuj1IHCffBviMdybNooTo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jIz7hTbUWI4/0zdzwmZE+rjUIrE2DXbQQ+4vDDE519Fsshxx1IkdeHLUaZHGaFfS5ORXtPGD+MkZQgLeO0ffV34B+2AJ6LWfcbUj/Eo+1TEzONToJrNR6umXXva5iwQEJxzC58KdrmUc2sSoEita3dypQk4Q59HkVwHa1385D/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=sJ/P4/Gz; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=NfEY67ZI; arc=pass smtp.client-ip=85.215.255.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="sJ/P4/Gz";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="NfEY67ZI"
ARC-Seal: i=1; a=rsa-sha256; t=1792144827; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=EltZDIY/4TZGnNm96jlHaDUK42yuGXh9a5VnvfOTfvCDxo+1R7KTGf6dhbVisNnKaj
    HmUU8NAR4VlIW4jNoI1XY3IqWvHYf7Zx+YwLYdCk2OG5OshWytNofq77Dfs/2Q6cgFRc
    X83nfUovahDgZDujsd5/aEfKLlzMsmvfdjBCXUKH/pqigMTPo+dvh+dwSr/lo+Z4H9ip
    AByIC5pcAWqgnBRCSGpKzAsK1+UeZsmWxtwxedfJsnSkAbRqH3znmTjwLGydV9y3mcrs
    OxLHdWxbtNWzGgEGYM7poZmCZf+JmRoH4cO5xtpEeFo/3wEktOP3Ck1iVRamm/taFL9R
    pUHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792144827;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=EsFMWx6TM+4++YBZxhcYUc/mq8GrlD0u+Gnm4oHvEk0=;
    b=B/bD4abqomuJL8ez6GSn56gOud4GVg8HBC4THjfjuJLJdZY3OH2ZqnX2x4mZXtMTyV
    WIibKwBsfNdWpGIqRhj7t0LHeIZa1jsCWURXAxOPcJnrEXie+c4EmXGQvbPgFm4p6Fy7
    P4IX9p7AcDw0NUME1LUvasa37vM+5Ob8T6MkiF3NzRyrf3On/ScbLLs0v988MH93Ngwv
    LFZPO6Q3OrzPdTtoK50X5atl/ifjNSz1K4xEAwtIr5OxYhGxU/WFFfG+WNr625zZwdbF
    AfaNF3M65OFc53C5nm7esmUt6UFV9Rqdl2+Fl/b2Z1dZYGxl4TzZzN5zooEDGBZrQHvk
    HnQw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792144827;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=EsFMWx6TM+4++YBZxhcYUc/mq8GrlD0u+Gnm4oHvEk0=;
    b=sJ/P4/GzLcchQypX+wft+Cz1BQX6f8cETF+0tdxb2DZTRq2n+mImSMltiJttu/6ozr
    UOS8tVu+IBJjFQZK7XgaSIENn3MMp0Syq4ArVDhnELUtFWuSqXSMJ86H8bZW7bsXVSdq
    2dIv7/tNdPE5YprgPfkZsBquXVQpot23K6of+FTZ7wIRhYEHDzvW/8HPOrDH3OkbcvZp
    19AHislrPL7eWgw6e/JqtMTbp/fDQ2bT+VYgcJ8eT27cK2tgSm5dTLEGfYishb5v1e0v
    0DH0Dn/VeQRHKdin+Nl6jzoKUiZHgbdJo/o21EAgZW3mJRZNp63UTqFaKt3rQPvuo42q
    nQbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792144827;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=EsFMWx6TM+4++YBZxhcYUc/mq8GrlD0u+Gnm4oHvEk0=;
    b=NfEY67ZIgMkQzKrOlgNtA6URZPnFhHqpyJiA//BoyKZ3C4MJvYAk0FR8fGB8yOJESq
    dMT2NpysmiJDe1SLwwCw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29GA0QLZs
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 16 Oct 2026 12:00:26 +0200 (CEST)
Message-ID: <f1c3a00a-a3f2-4880-b1af-dd150ca807f7@hartkopp.net>
Date: Fri, 16 Oct 2026 12:00:26 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 03/37] can: replace ARPHRD_CAN type checks with
 can_get_ml_priv()
To: Marc Kleine-Budde <mkl@pengutronix.de>, netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, kurt.van.dijck@eia.be
References: <20261015015336.816543-4-mkl@pengutronix.de>
 <179211822219.434549.7841003426566715206@kernel.org>
 <179214016466.1225518.8931119252169589153.b4-reply@b4>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <179214016466.1225518.8931119252169589153.b4-reply@b4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 16.10.26 10:42, Marc Kleine-Budde wrote:
> On 2026-10-16 02:37 +0000, netdev-bot+sashiko@kernel.org wrote:
>> can: replace ARPHRD_CAN type checks with can_get_ml_priv()
>>
>> This patch replaces the remaining dev->type == ARPHRD_CAN checks in
>> af_can, bcm, gw, isotp and raw with can_get_ml_priv(). The goal is to
>> keep TUN/TAP devices that were retyped to ARPHRD_CAN via TUNSETLINK away
>> from CAN code that dereferences a NULL dev->ml_priv.
>>
>> Link: https://patch.msgid.link/20261012164802.94113-1-socketcan@hartkopp.net
>>
>>> The TUNSETLINK ioctl allows a down TUN/TAP device to set its hardware
>>> type to ARPHRD_CAN while dev->ml_priv remains NULL. Such a repurposed
>>> netdevice passes the ARPHRD_CAN checks and triggers a NULL pointer
>>> dereference when CAN filters are created and when they are removed,
>>> e.g. by the CAN protocols' netdevice notifier handlers.
>>
>> [Severity: Low]
>> Is the "when CAN filters are created" part accurate for this tree?
>>
>> Before this patch, can_rx_register() already rejected such a device:
>>
>> net/can/af_can.c:can_rx_register() {
>>      ...
>> 	if (dev && (dev->type != ARPHRD_CAN || !can_get_ml_priv(dev)))
>> 		return -ENODEV;
>>      ...
>> }
>>
>> can_rcv(), canfd_rcv() and canxl_rcv() also already tested
>> !can_get_ml_priv(dev). That makes those four af_can.c hunks look like
>> simplifications that don't change behavior. This holds for kernels
>> that already carry commit 8aa59e3559494.
> 
> The anslysis looks correct to me. Oliver, can you re-spin this patch
> with an updated description?

Done

https://lore.kernel.org/linux-can/20261016093525.327367-1-socketcan@hartkopp.net/

> 
> pw-bot: cr
> 
>> [ ... 26 lines skipped ... ]
> 
>> The code change itself looks complete. No ARPHRD_CAN checks remain in
>> net/can/ after this patch.
>>
>>> diff --git a/net/can/isotp.c b/net/can/isotp.c
>>> index f5dc9d04bd68..6c28802c0605 100644
>>> --- a/net/can/isotp.c
>>> +++ b/net/can/isotp.c
>>
>> [ ... ]
>>
>>> @@ -1610,7 +1611,7 @@ static int isotp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int l
>>>   		err = -ENODEV;
>>>   		goto out;
>>>   	}
>>> -	if (dev->type != ARPHRD_CAN) {
>>> +	if (!can_get_ml_priv(dev)) {
>>>   		err = -ENODEV;
>>>   		goto out_put_dev;
>>>   	}
>>
>> [Severity: Medium]
>> This issue was not introduced by this patch. Further down in
>> isotp_bind(), the return values of both can_rx_register() calls are
>> thrown away, and the socket is marked bound anyway:
>>
>> 	if (isotp_register_rxid(so))
>> 		can_rx_register(net, dev, rx_id, SINGLE_MASK(rx_id),
>> 				isotp_rcv, sk, "isotp", sk);
>> 	...
>> 	can_rx_register(net, dev, tx_id, SINGLE_MASK(tx_id),
>> 			isotp_rcv_echo, sk, "isotpe", sk);
>>
>> 	/* switch to new settings */
>> 	...
>> 	so->bound = 1;
> 
> Oliver, can you add error handling for can_rx_register() to isotp?
> 

No. I'm really getting pissed about being urged by sahiko-bot changing 
commit messages because "those four af_can.c hunks look like 
simplifications that don't change behavior". Really? Every normal 
reviewer would see that and created this fact in his mind automatically.

When this patch is applied isotp_bind() can only fail with -ENOMEM and 
nothing breaks. The socket just becomes unusable. And if we have -ENOMEM 
we have a big problem anyway.

If I would provide such a patch the proc pointer removal patch would 
break next.

I have ~20 patches for isotp and its CAN XL support. I will add the 
isotp_bind() error handling there when these current (can-next) fixes 
are in mainline.

Best regards,
Oliver




