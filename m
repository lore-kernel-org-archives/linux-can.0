Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.167
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792667965;
	b=NheWSnAsqZAlFIFIAF5HX7sCvIPYBBBCNcrOrlaPkNmT87DipML0QXuq5d+x1bELbBaW
	 5t/DPYBhy2Dy4z6f5/RLZnayjh8i62yzXSr92f/nHQ0CdMnjdFbytRyL8l3xeLMuoEO15
	 ZwOliRW556hz+QPSZ7ldYsl4j9JI2cLrPfumwCMVwBrzw1Gy1m0HlGlItOksGuCnuTKSL
	 OMR6f0NCC1igsL3At2eV3NbIqwSY5Ci7q4CMz5IdHAnXw7Z6TlvCLC/aZn5HF3I5VylFK
	 wMbJKV+1t92spou5i9vdvUFPoGPmlkJCMAjAlkdenLCsdyE55z78PASBP5PBT95u2FA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792667965;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=QgZ0jOzTA3j8lsPkqLnQSh5uin8BlG/xtueUHJGlDQ4=;
	b=ItECNtYE+4fLt1xfh5RKGqiCPBwzqmhJY2e9M+qSVq5L5nePYYIHxxfJlMeihr97BNsG
	 UQ6YpkInqb+zebhMY4gqDdWMM9cw+Y4oqEgZT1w9q3HzSGaOD0YSh0fc+CFlYzpmeazDC
	 781cxdTf2KB/ep3KJUqWNbqilda+VlspnH611yAuVrVDn61mSvUCy9wim4mBxr+LG5PMp
	 oBMMcUXVZbF3Vxxqa+IVMeXoS5lcrp9wNOHMUUFRXhUWkVUF8nRf0jCiTPVcTEcz1a+Vj
	 FYstfGB3c0NmmodR+64qc0hMyor9a0d4OJMkEzcHSYzeZGLzETSHVswBMZAEUgzWwpQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=PVLTEleG;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=e5MjWzla;
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.167
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD61606A319;
	Thu, 22 Oct 2026 11:19:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFD61606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=PVLTEleG;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=e5MjWzla
ARC-Seal: i=1; a=rsa-sha256; t=1792667954; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=MHkyChibbg0VPI/DDcBk0da/NH3CuSRC1fcqfwMiqwwtOUoOsBPsAhcYWgNmIYQCol
    bzC04CO2Ctb+dXGknq+pbo/flpWf16n053MIcmeZxrGvAv37jFdbpEHxESfacprFrdYD
    XJnkmFUqSCaeuM8Nz/jnkSrBgi+MhgNCr/r7lzeCxncqFxmUFtiF4tl/4GvsynqE/91H
    OJdxA5/UI1ESnKsmJz8OnIB50Xhqr8vja2GQjLnBcfLDuNSPh/baEDxrDddZG7hMwgA6
    lyGtxJiNizVQNF2geoyDmUomvb4kIsl5ufBinMrFzXqjaEnrhVId74Vghfe5H2mtcmVu
    eYiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792667954;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=QgZ0jOzTA3j8lsPkqLnQSh5uin8BlG/xtueUHJGlDQ4=;
    b=AVKJRvK9PCM2m8rcvWWhYHWICe7QouygEZYqYZ9hr+W50CCsrC7tIbo9suPsMInl6q
    MPPnHCNTCPQKL2VYJ9aMLTVPbvmxhj+PNwbRLbqhhJki7+4/D0RTB2foVjtdLAu2a+az
    BSs+FEHoEvOy3BhfpWT7YSOiBZUJ2L9u/NljX5W74dS14iyYTGaHsU4dIEsgkDM4FeEW
    +bH1xos2BF4J0kk8/RCVuLAhhgmTwLZAdLb6c/7tnMgj/gd/mMbuS32BAjNxstbiZbAK
    sUqyrrhHSJJOmYcv23fhJ7BlTZ9+CerreCqUHH6NXJE5RBVciBoJYZKw9pRUkaeAhGOz
    DhnQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792667954;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=QgZ0jOzTA3j8lsPkqLnQSh5uin8BlG/xtueUHJGlDQ4=;
    b=PVLTEleGd6pvtHTZguzaPW5SNYG0SUsgRg3+xwJZJX9vLUmkSZxOTtU8yticVlscJh
    8CviqbhsOecA5xDi3HQVNuxCBAVV42LalHqWugHOs1ERm8kAXR27/46rb9iLHDB07Os+
    SLpMmEudiRPhIQWXwJiVK32oN0TxHauociCpxfSbNzG698vHA4UblK7swFORWRjRME8i
    QN/CsIk04XospxHuPIw2IJ5KyHeB/ZAkfZjIlHq0tfJn3AciG6bCXJUduHikFTBL1iWI
    yrz71rZ/iLcockenUuFgvOnDWlQ3NUfZUggTnWfMbzsHi1xM05YQhDWKKNynX5GweNzH
    W9qg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792667954;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=QgZ0jOzTA3j8lsPkqLnQSh5uin8BlG/xtueUHJGlDQ4=;
    b=e5MjWzla49EaPeIDcCHOZG5f0DrrmjGJ8S0Y+w8VnPsn1XWKnMp5rokBYQjrD7bE2E
    2JSewEXoynwatHZ/pQCA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29MBJDnx0
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 22 Oct 2026 13:19:13 +0200 (CEST)
Message-ID: <5fdffd4b-7f80-471b-93b3-706c00cb51da@hartkopp.net>
Date: Thu, 22 Oct 2026 13:19:08 +0200
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
Subject: Re: [PATCH net-next 0/11] pull-request: can-next 2026-10-22
To: Paolo Abeni <pabeni@redhat.com>, Marc Kleine-Budde <mkl@pengutronix.de>,
 netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
 kernel@pengutronix.de
References: <20261021231130.2085690-1-mkl@pengutronix.de>
 <eb3b2eee-3460-4b03-a180-1d3806a7f8f7@redhat.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <eb3b2eee-3460-4b03-a180-1d3806a7f8f7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 22.10.26 10:37, Paolo Abeni wrote:
> On 10/22/26 01:07, Marc Kleine-Budde wrote:
>> Hello netdev-team,
>>
>> this is a pull request of 11 patches for net-next/main and obsoletes
>> pull-request: linux-can-next-for-7.4-20261021.
>>
>> The first patch is by Vincent Mailhol and drops CAN-XL frames on non
>> CAN-XL devices.
>>
>> A patch by Sang-Heon Jeon removes a redundant NULL check before
>> netdev_hold() in the CAN RAW protocol.
>>
>> A patch by Kaixuan Li for the CAN ISOTP protocol improves the check
>> for the correct CAN CC/FD frames.
>>
>> The next 3 patches are by Cunhao Lu and make CAN skb freeing safe in
>> any context in several CAN helper functions.
>>
>> A series by Oliver Hartkopp et al fixes several problems in the CAN
>> net-layer:
>>
>> 3 patches target the CAN procfs: A patch by Runyu Xiao resets the CAN
>> pkg_stats using atomics, a patch by Oliver Hartkopp fixes the stats
>> calculation after a statistics reset. Followed by a patch to remove
>> kernel pointers from the output.
>>
>> The last 2 patches are by Oliver Hartkopp as well, they convert the
>> unreliable ARPHRD_CAN type check to the robust can_get_ml_priv() and
>> protect the CAN receive lists with a per-device lock.
> I'm wrapping-up the net-next PR right now, and this will not make the
> cut. Still all the material here, after forwarding the trees post PR,
> looks like 'net' worthy. We could merge it afterwards.

Thanks Paolo!

Yes the patches are indeed mostly 'net' worthy fixes.

Unfortunately sashiko-bot complained about something new in my patch 
11/11 and suggests to move some release_sock() calls 4 lines down behind 
sk_error_report(sk) :-/

Would you like to have that re-spin PR to be named as "net" PR ?
And when would it be best to be sent?

Best regards,
Oliver

> Note that there is other net-next material in the same status.
> 
> Thanks,
> 
> Paolo
> 
> 

