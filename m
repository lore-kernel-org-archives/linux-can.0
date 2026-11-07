Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.84
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794058539;
	b=i4dxE1XdWClHRG8Q/A26RKuD34IeyoZkhBu6rHIPh83t/lghTmcsIiOGdccuGTNFhUfa
	 ddP8cLq3Qvb8vNgsVyURyhGciMfiu/+N1K3CBlk9xTNQqv31EzJ0I74b2/V8tg+NByv31
	 +HSre/YrejXVS2e7WX++vcWWnkWsJh31xgABnCObk2G27OmWgMeDV8uRJpQ5bPkbm7foM
	 2h2jSgrYZrMZj20vwMCdIU4A93aPuEopU1mAGYRR/L40UdiJARaB6zTnZJL0Bp4tZELYI
	 qEGXtqzdzeDVaN+yKP0DzuzlDelB6D3JFqfostSXG+mNF27Fot2PVYGn0XO8bnOKMZQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794058539;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Nd2V970ES+tX4+b+oJGHEQJJnaPwOoAYE9iq10xN4Yk=;
	b=S8Ywm9QftLoVsrfhTpdhr5ny72O33VY655nNQ4VHwVFXKTLLKLyko/ax+iFpuG5dqsOG
	 8YrHcpLZW6uGYe5P7l7wTvGLgqJSlrfDHymniX/yPXAnjnubhQkdEDyeYtG0NWBLokFq4
	 He4Rcn3BWMQcSFulycsQsJMbntVBIeIdyTmxPHgrBTSeUlyeKPV68oIgeMtcNKZIUKNxP
	 kb9VcpqSmmACgmlh30W/DQj0RPpZq+ghSJlA2e5YukyhtDKX6gj8p7Iiaa6C2ya/Son+z
	 EIwjgHBoZSHvUznFCzo9HwpLlfAhDGqP2OQfN/ra32fMc1iEzR3HFiwh96r8MLVH4nA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=gT767F8w;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=nFmdnXyI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.84
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4194606A326
	for <linux-can@vger.kernel.org>; Sat,  7 Nov 2026 13:35:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4194606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=gT767F8w;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=nFmdnXyI
ARC-Seal: i=1; a=rsa-sha256; t=1794058521; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=l4h/MMOP+r9SnTI1zEXplpwyb/c5sxuC44YAjj6330y4hrF2VQVXQIaIXgNQDePBxp
    rIrSh20dO/USHe6j+B0peovjQIvDfwtHr2t4KZKSqTNSSSH6AeBUmQF3RTvOQhKscBHy
    DphhdvRWnSrV3VlCWglJ79PivTbq+1e4nOy3yzuUHnle+jLKrr0c+tEP9EM9I7rRLdId
    woCwjujTKH6Bh6tdpGUAi3fy4A43lHrMg1Q1fwyyc/YPHAlEBobFvSbBtTTYqHO6/gko
    aAUszsK5qnpdVNYpfhz+TYU+JYMo5HkP/FmH1HETg4kvYyaECEZhhsfj6Rnxm9gUXRSi
    SYbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794058521;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Nd2V970ES+tX4+b+oJGHEQJJnaPwOoAYE9iq10xN4Yk=;
    b=U42qV0CFltJd/GC7kqesH9TIfQIVJsJ4z/OobGWUtn7d/k+AC+IOTQ9w3HRv5+6WEU
    2GA8u/62xJf0MuBXKtQskNNA+CjmzncKIDWM2LOg1cUUxfpvYdjEqoxHVpEu8P8hBxhl
    8nvbWXlGo7xHqkvbzhAP5tzFBFGBE7agfE9Ex+eTb4d3tnFkC7XyxDhsSHTLYaDtXZ01
    8rUgORUV+GCwLAWGl1/f4UN83MrtjMl5aCKgPnLnszItMKiL1U+/BdSDzK2kXWGKYH4r
    YJ7fg1d0npjXUpkVL4YOwzDlume3XKy6bBPr279rQEyt1J78MCwIh8rpBGm0UYuP6AlF
    l31w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794058521;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Nd2V970ES+tX4+b+oJGHEQJJnaPwOoAYE9iq10xN4Yk=;
    b=gT767F8w9iWxHZKX/ytXR+g2Tu2GH83WWHlfUbqh0q4MegIBLzIJ3NreUhoa6xCoVk
    A+aD1TZad2cERA+fWG3lX8dlIM/UvMbb/qMVZ6IVlst7oKwNetChYtlq7GxR4nONR6s0
    LvcB4iXUGEc/jbJue9K9fInVEeooZYg52k3qZIzmB1TTTESQEjANFNl5wjb4+Lr6vbhO
    NAXZsalDXMev7947xQWA6Sr7SxZuQCjUGmF4AUgbTZZgAPrXV4FWW9DO2vq5aCHspy6C
    C9kJKvDbAwn16c3Rj560d7G5j6ZI5oBUHm/r6OrB3OOtp8Q2JJ5KWHy+zkIRurLAupGx
    JcTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794058521;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Nd2V970ES+tX4+b+oJGHEQJJnaPwOoAYE9iq10xN4Yk=;
    b=nFmdnXyIpY6OW0WbHQyGjOjOIa01+ftvCr3Z7eR1dlITcNIpSiYUxC5IVJJYevEH9p
    6Y2xju8V4aQylnKq7dDQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2A7DZLlRs
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 7 Nov 2026 14:35:21 +0100 (CET)
Message-ID: <86c9e6d5-911b-4329-81b7-bb611a9f333a@hartkopp.net>
Date: Sat, 7 Nov 2026 14:35:20 +0100
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] can: enable memcg accounting for user triggered
 allocations
To: sashiko-reviews@lists.linux.dev, linux-can@vger.kernel.org,
 Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>
References: <20261107-can-bcmlock-memcg-v1-0-482d9f5be1fd@hartkopp.net>
 <20261107-can-bcmlock-memcg-v1-3-482d9f5be1fd@hartkopp.net>
 <sashiko-outbox-202902@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <sashiko-outbox-202902@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 07.11.26 14:14, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found no new issues
> in this patch, but noticed 1 related pre-existing issue it does not
> introduce:
> - [Medium] can: j1939: non-zero setsockopt return value in
>    j1939_sk_setsockopt_flag() [1]
> --
> 
> commit b3ee6688711331e68a7e275f9b72d5b3fa8b7ee5
> Author: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> can: enable memcg accounting for user triggered allocations
> 
> This commit enables memcg accounting via GFP_KERNEL_ACCOUNT and
> SLAB_ACCOUNT for user-triggered allocations in the CAN core, BCM, ISOTP,
> J1939, and RAW socket protocols.
> 
> Link: https://lore.kernel.org/linux-can/350df96b-5f69-490e-b39e-ed6e9bca4754@hartkopp.net/
> 
>> diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
>> index 50a598ef5fd4a..c832465876049 100644
>> --- a/net/can/j1939/socket.c
>> +++ b/net/can/j1939/socket.c
>> @@ -716,9 +716,14 @@ static int j1939_sk_setsockopt(struct socket *sock, int level, int optname,
>>   				return -EINVAL;
>>   
>>   			count = optlen / sizeof(*filters);
>> -			filters = memdup_sockptr(optval, optlen);
>> -			if (IS_ERR(filters))
>> -				return PTR_ERR(filters);
>> +			filters = kmalloc(optlen, GFP_KERNEL_ACCOUNT);
>> +			if (!filters)
>> +				return -ENOMEM;
>> +
>> +			if (copy_from_sockptr(filters, optval, optlen)) {
>> +				kfree(filters);
>> +				return -EFAULT;
>> +			}
>>   
>>   			for (f = filters, c = count; c; f++, c--) {
>>   				f->name &= f->name_mask;
> 
> [Severity: Medium]
> This problem wasn't introduced by this patch, but should
> j1939_sk_setsockopt_flag() return 0 instead of tmp [1]?

This might be a can-next topic and has nothing to do with this patch.

@Oleksij: Would you like to take this suggestion?

Best regards,
Oliver
> 
> net/can/j1939/socket.c:j1939_sk_setsockopt_flag() {
>      ...
> 	lock_sock(&jsk->sk);
> 	if (tmp)
> 		jsk->state |= flag;
> 	else
> 		jsk->state &= ~flag;
> 	release_sock(&jsk->sk);
> 	return tmp;
> }
> 
> When userspace enables SO_J1939_PROMISC or SO_J1939_ERRQUEUE with a
> non-zero value in j1939_sk_setsockopt(), that value is returned to
> userspace from setsockopt(), breaking callers that check for a 0 return on
> success.
> 
> [1] https://sashiko.dev/#/bug/linux-35e22274-4165-4b2b-985e-c5f5773b9ef9
> 

