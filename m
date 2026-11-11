Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.20
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794383722;
	b=g13+7oz5ZyIx7cpF9LyG4wdZO3lx33lkYMVteiQLCDGkW++XoCupiiEKHdoiJHDwOdP5
	 csNyRLB9UdBPD+gZkQEgK79g+hpV3HNv35HyC59o5Tz1rcD/85ZkxaTo7IY12YzqImIbM
	 oKoLtOmGKMSXrRd4We9qpX3k4LNGWflxVNk9xx1zAENMNcrlLzd3s1siY6tIHjjnLy2A+
	 x2XrnBOzwoodIMjbu5pOE7EjKInwLTBVe4HkIoEpW7dtgnt7D5bcHOn1OxISTEoLYtAbr
	 DqfgDfRRLY+2MNQuqotE8MrZEYeFsa8yXQ3XIoXTLXExqv8v0pGx2AkgF+YtBMgV4Sw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794383722;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=slaQOwRsetkGk36DC1Cw60lFZumwKuraQqlt3b4pMFI=;
	b=zIsktl1t+w1f1XHA3YLqDhIIfORiRMccFILb5CtvGeBGSXyYWYIkNHLA4cw9xL/26k0J
	 6Iyjm1NYfLvFwrdc+xQtmQqW+vyiIfd9/VdxpgNzn7QcCnRWfydlATIZvMzc6lG4AixSP
	 /RlXN33ZAmBqt0sVsdbz9Dfp0RjiHNEpr7wqQA2WEJ63oU4U28Y40kZgpuHEDG15HF9Bo
	 GPPJ4e2CDWJqwdqXLlBjQRaOb+QZipsbfmz/Sdfzcx/+FqRu9MhGhG3KsHGHWG9Pvzg0i
	 5Mi7xTGq1K6o1ow6c8KkXDxEKr/uw0DeCWkkJD9eGfJ2t2MLL7akh3dMGCp9Q7M5qVw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=MTN2uFgQ;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=ogpXQP+2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.20
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F23606A31C
	for <linux-can@vger.kernel.org>; Wed, 11 Nov 2026 07:55:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47F23606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=MTN2uFgQ;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=ogpXQP+2
ARC-Seal: i=1; a=rsa-sha256; t=1794383701; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=T/w5+aJjB659cVKUsqJbp6bahEHw8tPmLaet5w9/WYjEQ8BFwy0WkbwhZaBEqWZ+bN
    tZRNmjI+gFgqJ0XMtHo3oZBAzDgAcqQM8NkdrilaCCitB+SWL4Xw6zPmqIsLFzFvM6nk
    pxvzNt+ejkt8A6ya42Nbrf7Kd9I4HFYG6evCuAsc+bcWdBe2/Tpqxg9fXLI/BebkqEAp
    BHxtd01hZohlLqKAWXLZ+Dtqh2+mN8JY8WVFU4dLFhYjevdx+8flAieWmeAQXpiFhvFq
    rHnGXsBYQMDeM6kJAQqyxeVRwcx9ZzpK+7cQA5wuhHndUBBbarXg15QdqbQsSw7Xvqhy
    f7Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794383701;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=slaQOwRsetkGk36DC1Cw60lFZumwKuraQqlt3b4pMFI=;
    b=C9CpZpyZb7V2tG+jm9LppwtTCBBHXhasVJJQJjQbdPCr2oZsVepCBhIF3lnfitjgnQ
    qTLIhNs3NB1x6tBWvdj2UQhJTNDDWAlV+sSo1BQnASsbY6WmjIb15vkqm0mqmlS+rp0y
    7LrfyGhbpBFgp/vW1Opj3oYt+IAs/TRZsUKacGUJhep1UshA1BjhEGLFRG6jWjF6JOPY
    sfPPmozDrBMNbdFTxUpNpfcsLKFZfJEjj7dICiiAw0JVDm4Tkx8XQBvGVxFUrtePA0a0
    8+cs4tBb+2pG9ruxzkKEitCeFJQydsQpAYZk1VPsTKnJBCWO8ri8oc3eooojUacXudK8
    49fw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794383701;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=slaQOwRsetkGk36DC1Cw60lFZumwKuraQqlt3b4pMFI=;
    b=MTN2uFgQNbaHD1ng+7VLFQtByPP6xT5S7/HeyKnlKRyn3uZv7HD6h9HLkuDAx1Hgnj
    r9l2pODSdIK7GDnFF+ODV39mn/D2VkFgQ/NYYqg/lyOfieQfpQEoP+ztHJ8IYl/LQAAk
    1S3mSMufnxqfDVySFVdgfumKjADcY0oQmQKXTfud32qQG0xNpXF9plhnPEQ0HKXUHh+x
    LkPVbICvD26ecPYmYwN2mifljWKFEVeTwzdvrureY8YmLehgeVukE5d/uLlMWTDSymX5
    scljbyE0mQbLFripb3vgrAqvPklTiB47bldIU7+FuqAwYHavb96b3iih0X3gL7S9Lsuy
    nj0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794383701;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=slaQOwRsetkGk36DC1Cw60lFZumwKuraQqlt3b4pMFI=;
    b=ogpXQP+2GOAiInmpJEmUg1JA9/mag421S1byCxX6TMhDgd40gPqhbOt0S0+uz2mGfy
    XowL5+iXl2l3V+6cx4DQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AB7t03O4
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 11 Nov 2026 08:55:00 +0100 (CET)
Message-ID: <79548879-7305-40cf-9602-966f5684eb8a@hartkopp.net>
Date: Wed, 11 Nov 2026 08:54:56 +0100
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
Subject: Re: [PATCH] can: gw: avoid losing statistics updates on concurrent
 receive
To: sashiko-reviews@lists.linux.dev, Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>
References: <20261111062907.16857-1-zhujun2@cmss.chinamobile.com>
 <sashiko-outbox-208446@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <sashiko-outbox-208446@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11.11.26 07:33, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found no new issues
> in this patch, but noticed 1 related pre-existing issue it does not
> introduce:
> - [High] can: data race modifying shared SKB in can_send() [1]
> --

No problem here.

Sashiko groundhog day ...

https://lore.kernel.org/linux-can/ac22b59e-129b-4883-b9c6-da5e69e4078d@hartkopp.net/


> 
> commit 10078742ee4a6687a5a77083fa056c99b8f26a52
> Author: Zhu Jun <zhujun2@cmss.chinamobile.com>
> 
> can: gw: avoid losing statistics updates on concurrent receive
> 
> This commit converts the frame statistics counters in struct cgw_job to
> atomic_t so concurrent receive paths and netlink dumps do not race on
> counter updates.
> 
>> diff --git a/net/can/gw.c b/net/can/gw.c
>> index 8a5327d8a00e8..a5233b4606dad 100644
>> --- a/net/can/gw.c
>> +++ b/net/can/gw.c
> 
> [ ... ]
> 
>> @@ -510,7 +511,7 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
>>   		nskb = skb_clone(skb, GFP_ATOMIC);
>>   
>>   	if (!nskb) {
>> -		gwj->dropped_frames++;
>> +		atomic_inc(&gwj->dropped_frames);
>>   		return;
>>   	}
> 
> [ ... ]
> 
>> @@ -571,9 +572,9 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
>>   
>>   	/* send to netdevice */
>>   	if (can_send(nskb, gwj->flags & CGW_FLAGS_CAN_ECHO))
>> -		gwj->dropped_frames++;
>> +		atomic_inc(&gwj->dropped_frames);
>>   	else
>> -		gwj->handled_frames++;
>> +		atomic_inc(&gwj->handled_frames);
>>   }
> 
> [Severity: High]
> This problem wasn't introduced by this patch, but can routing an unmodified
> CAN FD frame cause a data race [1] on the shared skb payload in
> can_send()?
> 
> When no modification functions are configured (!mod->modfunc[0]),
> can_can_gw_rcv() duplicates the incoming skb with skb_clone(), which shares
> skb->data with the original skb, and passes nskb to can_send():
> 
> net/can/af_can.c:can_send() {
> 	...
> 	} else if (can_is_canfd_skb(skb)) {
> 		struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
> 
> 		skb->protocol = htons(ETH_P_CANFD);
> 
> 		/* set CAN FD flag for CAN FD frames by default */
> 		cfd->flags |= CANFD_FDF;
> 	...
> }
> 
> can_send() modifies cfd->flags in place on the shared buffer while other
> receivers (such as raw sockets or packet sniffers) may be reading the
> original skb concurrently, causing a data race and corrupting the flags for
> concurrent readers.
> 
> [1] https://sashiko.dev/#/bug/linux-89b38ada-4acb-4bf7-afe0-3d8d244ba058
> 

