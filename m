Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792571741;
	b=i9qrr29xM+GRq5I7EdOzsXhyVhPyFsOcQIXQugGD8OQRUQW8QSPPIV3Zi3R24H5AxwgT
	 PHHJvsHgo3ty5fhADMjHE16jo/o/zodEfkCQ4ZYgwflGGnkx0JBiP8Iv33c2yB7ZRpXP3
	 EYr0Z6sE/dRQ+EFypoP+paz5kdw7U6M4iJKd/c6Sv4tiwVt+GjiBzeLJUijbitod1Cczf
	 M0JQvbFs2Mgm4t1vlKUiYrsuHFuUfOoo+RZDMm252Cy+pFbLUCFPv5CaxiYdrH+rdrWhJ
	 /xwkoJ6HFEASBUuEfa5SvZcc2n3gEluI0nHStZbPw+wOu8Hgrs4fK5cgOt7UBcg8VIA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792571741;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=lEoPiK6XgidAUbBXfkV+ZmNXPhTD47mekdfMq2q1pPE=;
	b=xft8tlvzeP3qTIG4p4a9qvmMkXkiesPtoZW+hhYWchFPSbIyPQRTpdkwuy90ffdnw/Dg
	 llKKAjVHGaiYEjDxPSzn5xHXptTqx7mf2mHh1UNdVFNSGBRVrZLrUc29KOo+uDJCQaGhL
	 0mvNKsE5/ABLVLrZSUT41t952qm3fSLmbuosUMF+7JQqfzGyx3YKSTpJDeN2gHEXT964Q
	 Keyss2kKe2T3NIFEo9eqymZonvlm7rNUGGp2aJlkz8q2cDwQyzJwpgSVYd95/DYbfNlsf
	 /XUQkZztnLUmcP4qyB3gdgGpwPKjAM3K6BjZhBqB6c/iafVNgprXQxqJHnowCPxVw8Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=h5YpwCoA;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=rY2u36BQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.53
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3AC606A319
	for <linux-can@vger.kernel.org>; Wed, 21 Oct 2026 08:35:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A3AC606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=h5YpwCoA;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=rY2u36BQ
ARC-Seal: i=1; a=rsa-sha256; t=1792571731; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=go2bcjvh4S3jOiC3c+F7CyzouIO45pytLvDhrmalqHLlv70W9q+h/7aVkWmh3z3fr0
    tuX7ULr//MBmMrdFQFrCVJVb8FX0IU669n6IRFcririzZAspf0VPWwhCSs8QnjDPwzoU
    n/wgKvMuVW8KjeF7ysSlO2HwhX28h9cxRF+D3domHlrj70MtA2j5RBdnbv+2gSRXkoMB
    BcawHmomHI2VPLV6UOp84iHY82HzeDQRqQy/ITYpwUdz9q33ZumCdDJ2V5E1Dq+I9bW0
    +3b0JG84elESn2AFTXTjQmc0z+dI9A4DTgkD7K3sqZvfMQjXgpg2P9SElq2lCGSyblAk
    n7qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792571731;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=lEoPiK6XgidAUbBXfkV+ZmNXPhTD47mekdfMq2q1pPE=;
    b=ai+QRFaQoQE1YeK/PGMWjlARgSDEoD5xJ+LQ6XgLwInRuxL8C5TpjkilYDAVZJXE/K
    cAX/k8K4lxCVB8rQAo9z6YrdBFxFWVlIGV8uRuB99do6yvIkGUY6QcDyopnYT6ET2eHP
    MF/mXmv5QmTPNjwr+6lboGRzoxqrgfE6V4tt3oOt7dFpI2w5bPVRum1zJ/KnPtUvpwIl
    b2U7Dnz0IRpt4gXixjO1lXt+IwI7DceZOuxtcywgiR3axPG/VriuNqy3LRmmL5DlQ4rA
    5aM0ML/51z4uzyUr4dbMQ6TYThTjqI4/2aWEvQD5brgKWzMh/e0ADBiADJUGlHUjUkFI
    PoDQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792571731;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=lEoPiK6XgidAUbBXfkV+ZmNXPhTD47mekdfMq2q1pPE=;
    b=h5YpwCoAeeIE9et8+FFlpcqWAc+PwJgjMAZmTNUQGUKTiheH8hWI2lCev/BEb9IR4J
    WhRsJKsFeHSAffPuD98CoO1xMKLpiB5BHI0O16HBGpcynug4uON9+OQbLZ7gi1jjmt71
    tYNKIiUP9a544XfH4I8dGNM1Y5jWVucejRjejG9kPO7Fl7qWKJU/CfsIhl/6IJUO4BFo
    aLBxPTHdhWWWkVon7PuOLQIXE0KTxO9BSWu6yFVc6OU1DZzoOwmiirIIdUEq7RTouSUD
    bMjZ+CHNKP82F2m0Pm+i0ngGd88NQgvy/e5bYoQlO6zYQbjWs0+Bw6Qzg96TUPMZvbYU
    GKJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792571731;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=lEoPiK6XgidAUbBXfkV+ZmNXPhTD47mekdfMq2q1pPE=;
    b=rY2u36BQgxvmcoKRxzxEoaI0Ej1FufcLJgp3TgvCICx32oHB17EI/2KC384YVK0tEP
    Grzez86DssUVZZWUVdDw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29L8ZVg7F
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 21 Oct 2026 10:35:31 +0200 (CEST)
Message-ID: <f57ebd74-4a96-4954-bf03-b54f2a46ecdd@hartkopp.net>
Date: Wed, 21 Oct 2026 10:35:31 +0200
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
Subject: Re: [PATCH can-next v3 0/3] Introduce diag support for CAN
To: Filippo Storniolo <fstornio@redhat.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
 Robin van der Gracht <robin@protonic.nl>,
 Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
 Urs Thuermann <urs.thuermann@volkswagen.de>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-can@vger.kernel.org, Davide Caratti <dcaratti@redhat.com>
References: <20260904-feat-can-diag-v3-0-bdcebf07b373@redhat.com>
 <20261020-funky-buffalo-of-progress-fa4bf9-mkl@pengutronix.de>
 <d23196e0-6307-458b-ba31-15f54ef46b73@hartkopp.net>
 <atfFeR_OEaWrcQSS@storniolo-redhat>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <atfFeR_OEaWrcQSS@storniolo-redhat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 21.10.26 10:26, Filippo Storniolo wrote:
> On Tue, Oct 20, 2026 at 06:20:22PM +0200, Oliver Hartkopp wrote:
>>
>>
>> On 20.10.26 17:50, Marc Kleine-Budde wrote:
>>> On 04.09.2026 16:12:54, Filippo Storniolo wrote:
>>>> An example of the output given by ss -cpe:
>>>>
>>>> Netid                     Recv-Q                 Send- 
>>>> Q                                 Local 
>>>> Address:Port                                   Peer 
>>>> Address:Port                 Process
>>>> CAN_ISOTP                 0                      
>>>> 0                                              
>>>> vcan1:1110                                          
>>>> vcan1:291                   uid:1001 ino:50324 sk:0 users: 
>>>> (("can2",pid=9210,fd=4))
>>>> CAN_ISOTP                 0                      
>>>> 0                                              
>>>> vcan1:291                                           
>>>> vcan1:1110                  uid:1001 ino:50323 sk:0 users: 
>>>> (("can2",pid=9210,fd=3))
>>
> 
> Hi Oliver
> 
>> The fact that the inode number of the socket is visible fits great to 
>> the upcoming CAN procfs output:
>>
>> https://lore.kernel.org/linux-can/20261018164417.1540449-8- 
>> mkl@pengutronix.de/
>>
>> But I'm not sure about "Local Address:Port" being "vcan1:1110".
>>
> 
> You are right and probably the example in the cover letter does not
> fit the best use for the netlink message.
> 
> This is just how ss show numbers. I used this tool as proof of
> concept during development and I didn't put too much effort on it.
> 
>> A CAN-ID together with a CAN interface is a unique "content address" 
>> to identify the content which is in the CAN frames data.
>>
>> I assume "1110" to be the decimal representation of an 11 bit SFF CAN 
>> ID 0x456, right?
> 
> Yes, it comes from 0x456. During development, I was using some C
> program to just create CAN sockets. The socket configuration for the
> shown example was the following:
> 
> `
> addr_send.can_family = addr_recv.can_family = AF_CAN;
> addr_send.can_ifindex = addr_recv.can_ifindex = if_nametoindex("vcan1");
> addr_send.can_addr.tp.tx_id = addr_recv.can_addr.tp.rx_id = 0x123;
> addr_send.can_addr.tp.rx_id = addr_recv.can_addr.tp.tx_id = 0x456;
> `
> 
>>
>> Having a CAN ID in decimal representation is generally unusual - 
>> especially in Linux. Additionally you can have 29 bit EFF CAN IDs 
>> which does not fit into a 16 bit port value.
>>
>> And 29 bit IDs have to be marked as you can have the value 0x456 in 11 
>> bit and 29 bit CAN IDs. We usually do this with 456 and 00000456 to 
>> indicate 11/29 bit IDs.
>>
>> So the "Local Address:Port" output does not really fit to CAN here ...
>>
> 
> I can update the ss example in the cover letter with something
> that better fits a real case scenario if you want.

The example does not solve the question about the port number having 
only 16 bit.

If someone uses 'ss' as you propose will there be a specific support for 
CAN? And what happens to older 'ss' binaries when used together with the 
CAN diag support?

Best regards,
Oliver

