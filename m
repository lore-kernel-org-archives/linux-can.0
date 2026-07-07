Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2089B3DF011
	for <linux-can@vger.kernel.org>; Tue,  7 Jul 2026 11:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.221
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783422705; cv=pass; b=MCdFXcjwgal/D5Iesr15Hs/ziaEBE17gWNWUePslvXCQ0+kbgwOcDsjh0Z4EbZzFbUiv8kQmnmLmVhQEGhdjlEqpg0oxvZHJR3fP9RchEKzfy3LxKIDy3QY0GAD2rPDWPTa+npPeKivW+leLk1iP8iG9cWrTCEkjavKNkV2aheA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783422705; c=relaxed/simple;
	bh=s41HghcnHi4c5YTGFCPnSqs66JPWUA0z+WCelqnPDfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TmDVYOYdvkf2WYbKlutiH6gUcKWyhEkuHcE2+wTXbL8qdvV44DkN8x05uQ8ehMMEmeDFs3e5sjN5wSdaTL+00zIIKEvD495NmxS8aBPWH42HMK9H7qME9fKY376YJlLn4Lrutr4IKU9txr4mbqONKK6HixFLJx4K02QxICWWhFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=TAhH/S2M; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=SJfV5zgu; arc=pass smtp.client-ip=81.169.146.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="TAhH/S2M";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="SJfV5zgu"
ARC-Seal: i=1; a=rsa-sha256; t=1783422700; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=GJCx6Yqvb+W6bDpPLA0cge7hyActFdkjbCZVH0pLPF/0/mYpXW+KXecimpyHLS7JoS
    Um9TPjSnidf6n/n8XKHmq4I62eD5bM/tL0ItF24iKVHbGwNNAqLG51lj5dFBGGVKgj+T
    MC6fdjy0Ai/SViqsJungfIw8oH1pNWLnyv+TPdIbI7OCedveIhV0sXd8BYSUqnkym3mC
    GkfdpLfR2SI1KjXoa1RMW7TC3I5V+jOUbums7Ep/ltQQtylNzstNgM/8PT6IC3wDDzaN
    KrOMg9YvJbU0qhWjjKY48YewxalQG0rNPW7DGQuNGvAxjucguJMMUOW8I/M4BKULwr/H
    xwYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1783422700;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=YAaraEuu8CLtkbpdlw91sRwvlgxAzF6bI+nkt+vanPc=;
    b=ULLkVJySTww1VGkRYEwszfsmYaSWfU81a+We/lSwdvKx4zCvh2+4sJlaW/GG3z5BdN
    J/hRHXmIFYfYIGioNyJWOZp/elKSeIO2dqAWu2w+U7ZGw8x85J9FelnxZZlf+BWGzswB
    Ey1XYznNCNc18AmhopaeXul9POI/qqptdpPblyD/tsZtuGwozvjZMQxeoo3RoezqEbhl
    GRDjJ7MihuoF6kPJM4JCt7LZEDSrLLp6xbCK2odwiH18f5Oz8oVFNt+7AogLDqMh7CCI
    sB8J6WYW3T0eAW1GCAu9u4cWjHyBHoWgnved6gePOiyQS/ng79LytxY3xNjpjPjYZKSw
    yDjA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1783422700;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=YAaraEuu8CLtkbpdlw91sRwvlgxAzF6bI+nkt+vanPc=;
    b=TAhH/S2M52QD+zjIwOJpA1Yy0mivkdLonQy9HTaOrRXKp4y1HNIk2HGG4nQ5s245iU
    YzeDeRlLJeVARq1VNPtkYm6KZktwmRZpZ3EeZ4ZHHfsXkiz0vQMIHigPTR1eZYiwhOu7
    VZ49UX0EHEOkgilmVEwrj8KvqjfloYjuRq8HyFar0xT8+h+CkHPxZJl4oXwf+OgwqfHy
    73OMHKs748db92UCDlxSIUq5k4WpUCyoro8Knc77KmD1QrOJprv0RC77+y07KSMithrE
    vapEqLxpybGI7oKZuVmUL1bjm9HGipSHnj9viqjC9M4xng1tIyTZqwiIMFcMLWrI3ren
    1ouw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1783422700;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=YAaraEuu8CLtkbpdlw91sRwvlgxAzF6bI+nkt+vanPc=;
    b=SJfV5zguRy2Q6V/FLO7qJWxJSs83njyDIYSjOiNQc7B4X6R7b0hct9hARETPgivfwp
    0OEEk8oMnOpMSqE0acBg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from [192.168.20.154]
    by smtp.strato.de (RZmta 55.5.6 DYNA|AUTH)
    with ESMTPSA id Ka9fdb267BBeSiY
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 7 Jul 2026 13:11:40 +0200 (CEST)
Message-ID: <1dbdd497-4407-4620-890a-ad34b81ba6f6@hartkopp.net>
Date: Tue, 7 Jul 2026 13:11:35 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] can: bcm: defer rx_op deallocation to workqueue to
 fix thrtimer UAF
To: sashiko-reviews@lists.linux.dev
Cc: Vincent Mailhol <mailhol@kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Oleksij Rempel <o.rempel@pengutronix.de>, linux-can@vger.kernel.org
References: <20260707-bcm_fixes-v3-0-84600ca6d889@hartkopp.net>
 <20260707-bcm_fixes-v3-1-84600ca6d889@hartkopp.net>
 <20260707102752.8DF871F000E9@smtp.kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260707102752.8DF871F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 07.07.26 12:27, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Missing list_add_rcu and list_for_each_entry_rcu for BCM operations lists.
> --

Fixed in Patch 5:
https://lore.kernel.org/linux-can/20260707-bcm_fixes-v3-5-84600ca6d889@hartkopp.net/

> 
> --- Patch [1]: [PATCH v3 1/7] can: bcm: defer rx_op deallocation to workqueue to fix thrtimer UAF ---
> commit 3bf6c2fae3452e20dc5bcc0bb3d49f9026358964
> Author: Lee Jones <lee@kernel.org>
> 
> can: bcm: defer rx_op deallocation to workqueue to fix thrtimer UAF
> 
> This commit replaces direct hrtimer cancellation in softirq context with
> a deferred workqueue approach for BCM rx_op deallocation. It queues a work
> item from the RCU callback and holds a socket reference until timers are
> fully cancelled to avoid a sleep-in-atomic panic.
> 
>> diff --git a/net/can/bcm.c b/net/can/bcm.c
>> index a4bef2c48a559..bdf53241bd7b3 100644
>> --- a/net/can/bcm.c
>> +++ b/net/can/bcm.c
> 
> [ ... ]
> 
>> @@ -1060,6 +1081,7 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
>>   
>>   		/* bcm_can_tx / bcm_tx_timeout_handler needs this */
>>   		op->sk = sk;
>> +		sock_hold(sk);
>>   		op->ifindex = ifindex;
>>   
>>   		/* initialize uninitialized (kzalloc) structure */
> 
> [Severity: High]
> This is a pre-existing issue, but since this patch modifies the BCM op
> initialization, I noticed a potential race condition with lockless readers.
> 
> Later in bcm_tx_setup() and bcm_rx_setup(), the code adds the newly
> initialized op to the socket's operation lists using the standard list API:
> 
>      list_add(&op->list, &bo->tx_ops);
> 
> Similarly, bcm_proc_show() iterates over bo->tx_ops locklessly using the
> standard list_for_each_entry() macro:
> 
>      list_for_each_entry(op, &bo->tx_ops, list) {
> 
> Because list_add() does not provide smp_store_release() semantics, could a
> CPU reorder the initialization of the op's fields or its next pointer?
> 
> If this happens, could a concurrent reader in bcm_proc_show() observe a NULL
> next pointer or uninitialized object data, potentially causing a crash when
> the procfs file is read?
> 
> Would it be safer to use list_add_rcu() here and list_for_each_entry_rcu()
> for the lockless readers to ensure correct dependency barriers?
> 

