Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC623BF677
	for <linux-can@vger.kernel.org>; Wed, 19 Aug 2026 17:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787159171; cv=pass; b=Ehh1mjB85MPtBXjRjPaN2JykTlPbkEON112eqxntVe+2fd4KKtggfMI9HqrYi/zgPg4wVqTnqKlwQGnI+gYG3+drJfBLmh4v/DycFelcIxqa5Zqv4IIVa/i8kzV9UeZ6bAmCw5Q8T8y6dLN9Dr8mYBPWbbW8OoXlFu0aOfBbj/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787159171; c=relaxed/simple;
	bh=XZKDG5oRID/PK9mkYKTUI0I6iYxS7XDXpjoDeuHAFC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pRzIXSxjzcwBWbNFplRoKNYxCMvUFM+8AxhJtdiCkTd3APx9Cb0VdE7HzDvRe+vnZvfE8ZYdEYRy9YmJ1QZS3EHCe5TIfvuSaJ5HXRON1RMuThYL7SNr3sYMBeFQBHHPoqvj/ko+EvUWcZ0yuS3OQOEUvYoC4fps0MUWoKbXpiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=klJxMM6o; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=zoIjzOai; arc=pass smtp.client-ip=85.215.255.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="klJxMM6o";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="zoIjzOai"
ARC-Seal: i=1; a=rsa-sha256; t=1787159150; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=pLpFwDJQhmteyu6JBvBlORGODRkRCPctPQSFi07HQd8XxJ/6zkz8Z/cNmmLQEWeUHg
    lUYnk41NqISmc7BpvGiZxzWMD+MM31CI98CmvvnuVfu1HgtaK3UyO9dcORfyAKkktG19
    DSKtg/i0SVKmPeiaZiU4VnZn8/dDAIlXZ8psLp5/NqyFlIOhce70S9TQ9wyusnEsUYKC
    6DPfbet/vPJpLx2SDX39uCaOYXM2eXlGTsaSL5S2nnoEBgSWjp1yP2djcbjXZpzsDf89
    43uVjzG7BVs6c4tmjSz9tmY0Egn3GZalYr6vDjXD8XlYOSQKZvwl6T04dZK33iIg66aq
    yWjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1787159150;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=2/C/k4fm6iI42koNfQq1rvPva+OpRt+uiPHdqxxkqfo=;
    b=TSBHECkMCsoMqr7AuQsnp0iV55tgISJvv4KT+j9EIPcdTPDE+KoXjuHfsyavabH9KT
    ZIDFCnbCGIA4Bkbj90CH/QtNkzIn6r06cYX7DTQKbvOt/a9b9d9gSZ0I+aV/wuA3B6X9
    qGz5BcUIKOYZN0JHkXnKREXCn96H4Vg4BdrvGoZInWXtKDlJ8wvekr80kyYlelzNGPtS
    qMMf7gS8nM3ctjSOaoR0BPiKqSc1vRr1/INqGyX+s51I/DfXGIsoF6IK/4KIvmY9NNE2
    aMv2JnWjSJmigdvwb6shEn5O0IXGin7EoQapyMuXaAd2zaYThVFpvatGnnyOneKbek60
    2GFA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1787159150;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=2/C/k4fm6iI42koNfQq1rvPva+OpRt+uiPHdqxxkqfo=;
    b=klJxMM6oQ7MetJwQ5n/jZBHDuosiDdsQzFrmjrGlTh4nvFsmUT4bLqB+/2Nc4YK86K
    t3W0+JhTaY218pJbbBR3w9mv9ljW+zKSZI/8hnao7ZjbSDXtANJ73ZLdi1Q3BCVF7ki/
    Eq9UpBn2rBLPcRpzJfLHUuFAffPZrfLgsb4b+tnHTYYp0cfDyRR6hQt9S0ezRsA8weiy
    9i6X8wEyp27FNSoyBd1oa35IPZyXNs5x9zGLFek4QphJqR1TzPJPc0ti+vBvTOmhKu06
    c92aRXj+ClKnhHJ+vpzvQ6Yx38u+AMlEr5wQRC/STTTtIKJI3EZ64IgW+6u0D7qc0yv5
    qeCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1787159150;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=2/C/k4fm6iI42koNfQq1rvPva+OpRt+uiPHdqxxkqfo=;
    b=zoIjzOaiU4bCNXQm66KFYB4T50NC9at8+afHjYJuwJKL++5JLJPf4g8wFOKG+T2C5V
    sD2q0CO7QxIMHwuHcICg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id K171b727JH5nMgH
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 19 Aug 2026 19:05:49 +0200 (CEST)
Message-ID: <140b6ce8-d920-46c4-a83c-0d52b8f1c653@hartkopp.net>
Date: Wed, 19 Aug 2026 19:05:44 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: convert unreliable ARPHRD_CAN type checks to robust
 can_get_ml_priv()
To: sashiko-reviews@lists.linux.dev
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
 Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
 Vincent Mailhol <mailhol@kernel.org>
References: <20260819160822.8256-1-socketcan@hartkopp.net>
 <20260819162609.2EF0E1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260819162609.2EF0E1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 19.08.26 18:26, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Data modification of shared/cloned SKBs in `can_send()` causes payload corruption for concurrent users.
> --
> 
> --- Patch [1]: [PATCH] can: convert unreliable ARPHRD_CAN type checks to robust can_get_ml_priv() ---
> commit 57320b2cc995d1852816aaacf79460f42c05858d
> Author: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> can: convert unreliable ARPHRD_CAN type checks to robust can_get_ml_priv()
> 
> This commit updates the CAN subsystem to use can_get_ml_priv() for
> identifying valid CAN devices instead of relying on ARPHRD_CAN. This
> prevents issues with TUN/TAP devices that might overwrite their hardware
> type without properly initializing the midlayer private data.
> 
> Cc: stable@kernel.org
> Cc: Oleksij Rempel <o.rempel@pengutronix.de>
> 
>> diff --git a/net/can/af_can.c b/net/can/af_can.c
>> index 7bc86b176b4de..ef435f22ac933 100644
>> --- a/net/can/af_can.c
>> +++ b/net/can/af_can.c
>> @@ -226,7 +226,7 @@ int can_send(struct sk_buff *skb, int loop)
>>   		goto inval_skb;
>>   	}
>>   
> 
> [Severity: High]
> This is a pre-existing issue, but can modifying the SKB payload here cause
> data corruption for concurrent receivers?
> 
> Earlier in can_send(), the SKB data is directly modified without checking if
> it is shared:
> 
> 	} else if (can_is_canfd_skb(skb)) {
> 		struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
> 
> 		skb->protocol = htons(ETH_P_CANFD);
> 
> 		/* set CAN FD flag for CAN FD frames by default */
> 		cfd->flags |= CANFD_FDF;
> 
> When routing frames without data modifications, can_can_gw_rcv() creates
> a cloned SKB using skb_clone() and passes it to can_send():
> 
> net/can/gw.c:can_can_gw_rcv() {
> 	...
> 	nskb = skb_clone(skb, GFP_ATOMIC);
> 	...
> 	can_send(nskb, gwj->limit_hops);
> }
> 
> Since skb_clone() shares the underlying data buffer, wouldn't modifying
> cfd->flags directly in can_send() corrupt the payload for other concurrent
> users of the original SKB?
> 

This is a common remark from Sashiko-bot when looking at this code.

No problem here.

>> -	if (unlikely(skb->dev->type != ARPHRD_CAN)) {
>> +	if (unlikely(!can_get_ml_priv(skb->dev))) {
>>   		err = -EPERM;
>>   		goto inval_skb;
>>   	}
> 

