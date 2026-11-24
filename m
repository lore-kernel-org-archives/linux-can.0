Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.165
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795510944;
	b=Tu/LLe0OLoXCMAGPbaRXoLLcoAdTqJBIov0O0Rhm50Aa+jXh5jiuSz9ab90AWrxZS6zD
	 rcBBLCHvoLig02XSnWir2lxPAJ16ftz/Cf0u9Zxy0oN1VW9MtyHANMOSroDJXAH3MQWVQ
	 ueZiVHRkrImLpQ/S5GNQkCPQ6/EqCdV2Zs9J9Hzjd8PydkZWrxokcQ7X/xD5RWcs9oSoj
	 MtijxGt862bFxC12esnlWeRK+OPUTQYAVFWLjSss1CGK58AHh5UOpH8lqYNakafVpE+mO
	 eKySR8Yo5QVF+Ntydpe8BrV934mnjH3O3y2zYxX1bjsx4o4M3sR6rnrYhU1MZpwbULQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795510944;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=froBWFNxotg13gHAo0nQlQ1+sP5Qlbsf6lbVRWAZEh0=;
	b=N7VTJP/vhe5IboS5E+FVrMGrH8AUux3UbPRLRQ7PT1EICM5hMBZzHAbI78i/fs7+gaOI
	 eKgILfLPU+bPmFiMwrVWRXfp5H9cOq3+agoXadjHTIc4ualOGsT0rphWN8rwYx04llvAi
	 ezYcvemIj1YgpNo0JS7OaCymgMEy4mX1+cnsK1+mYFT1fApWruZNkImq190RQ49/MXH8h
	 DmSaW4ukiDr0OzAlanEhUiqbGl6aRaD7Iwll07MxKTUv4s4+UkrXypBZNmiJEkFjevbPM
	 kMrb3fHB1PBBy6K7l9A+NZRqpfYLkdR3J8ga95KnSVmye5FlshPM9HEMoIEHFUlluNA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=gE+bu9F0;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=aM+DSD6j;
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.165
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F71606A32A
	for <linux-can@vger.kernel.org>; Tue, 24 Nov 2026 09:02:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9F71606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=gE+bu9F0;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=aM+DSD6j
ARC-Seal: i=1; a=rsa-sha256; t=1795510936; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=M0wouQoidGL+kAYuCK3XJHQlRtRtk2Zs5Ju2OO2fl29lZbYjWPd9JYWMoY75/IXDBO
    1bX0adFvQRzeq0Ay02IzlpZVd7I5w0ve5O1nB8V8H6UsmNXijMw1TcdGxD3OSOHtOSNX
    FcKncb5n1DQCVMvfeRAN7JG9qeh3Kgc0wSPRwjAgaa/cAotTw4/403NSHHCW1fKORkzN
    edUmD5h9s5B46RnLBbyJZV1OzjTCPYclgBtIxK9h3BsJryugsPht1N3yv2qGD6IHS1ua
    qj64WcijSzoiz6yYlw6A+eFVkuA7YsEoqwGXt/q7QEqyMtcyYF+xMsd+60CRyoW0Rey8
    XlRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795510936;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=froBWFNxotg13gHAo0nQlQ1+sP5Qlbsf6lbVRWAZEh0=;
    b=kkJK23fKTRHyAgSTsz4UecvM7Lvq97sXPwK7ZxV57BDmjGBJ3VecFlSFJ8i96NSyL5
    aD/JTnEiYZgfEi2VA4rMKazEBwUFEres+739DgyIj2Man5xlqXtq7UEsVnZJtrYN8n7l
    RTw8ZHUL1GWH51XGxSgCKtCNpPk0P4ZVSzgFhbkEQjq0CfQTO17E0qeWEwXiYlXBXmot
    4XXyIcqhz9+24y3gBBDCnWt64cAcFlSx+a0OLdToNX0ZLZhjC8H2NAzu/2/baLHA8BL+
    KYru977mMrMrorXng/rv9LQMDB+wL+C9ll2kQvJG6aWTIIeK9ZuuF3GVQmjJHvvdg/wD
    K0xA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795510936;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=froBWFNxotg13gHAo0nQlQ1+sP5Qlbsf6lbVRWAZEh0=;
    b=gE+bu9F06NszBceDW3WirPe53hc0B88WuJZ/tIrr6vsa/UIEQ9hTWQZLYZwBFtewZT
    NWGsQkaSXFLB05A6IP2zdeSFfOgElg9O4rDwmBpyzxsLGH2pLztIy8vM6bjcTVp7jN05
    ulc0jbSbdAi5pP4PZjUn9QMnD+KLW64aGOPpQcwnui/K8vlMAyoMyHX1AkgQ5fKgX/ho
    EaAAkX58UmS9q3JqDjAO3vqkr8axCU+0OCAq516RGLoZ64Mb7pnXF8+YgdWjXtcOHATy
    lZyjYE1oehkzymGQWvilX3Jp210LXZjzEhByQe82hKmd/nrKMpJfX8BcoxFzUyRptry1
    GgnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795510936;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=froBWFNxotg13gHAo0nQlQ1+sP5Qlbsf6lbVRWAZEh0=;
    b=aM+DSD6jPESFvClQRKUXThIYg9ci/klRoi2WWRkhiwKwWX4BiEld2w79apUEVICZcJ
    KoLItE3ajraSiDNzLABg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AO92GgV7
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 24 Nov 2026 10:02:16 +0100 (CET)
Message-ID: <18f6ec3f-d781-46c4-a0dd-068a9394a87d@hartkopp.net>
Date: Tue, 24 Nov 2026 10:02:15 +0100
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
Subject: Re: [PATCH net 0/11] pull-request: can 2026-11-17
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de
References: <20261117220818.1142581-1-mkl@pengutronix.de>
 <f29308ea-4493-4146-bb28-506522040ce8@hartkopp.net>
 <20261119-gifted-tapir-of-courtesy-408880-mkl@pengutronix.de>
 <f0270895-8e97-4d6a-b5cb-6da6ab5c1ac5@hartkopp.net>
 <20261124-armored-mindful-kingfisher-b20baf-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20261124-armored-mindful-kingfisher-b20baf-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 24.11.26 09:56, Marc Kleine-Budde wrote:
> On 24.11.2026 09:54:08, Oliver Hartkopp wrote:
>>> make it so
>>>
>> If it works for you, I would appreciate it if you could send the updated
>> pull request today, so that I can address the feedback expected from the
>> sashiko-bot.
> 
> tags/linux-can-fixes-for-7.4-20261124 is already pushed, just writing
> the summary.

Excellent!

Many thanks!

Best regards,
Oliver

> 
>> My updated patches have been already reviewed and answered here:
>>
>> https://lore.kernel.org/linux-can/20261120-can-bcmlock-memcg-v7-0-f6b84f5257b1@hartkopp.net/
> 
> Marc
> 

