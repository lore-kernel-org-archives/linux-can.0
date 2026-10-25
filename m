Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.24
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792956159;
	b=BHT5C8oJ8NKG7sPrhvd243JBOE6gA+vzHWiu7ItukzUKIOzOQgILwdPztGlTeR8K6Z7D
	 IQPz8nWk6tOoPYcyLPtGLRYVYQmE9ePKETf+GfhOdvXPDnqKUBM2iYQ2XBo9kz1pLBViN
	 9mlG/T5XopWs9VhY8x80ITW80NAskTw4QspajjPlFv6ML/ogEIyXybS0suSirpljImP3g
	 gmobHzKzRVf8QMfxc3pa0kZBXirL7gt/EeYg1Zba3CERKiVuLodGVCjt4IdhAWMXWFgjf
	 AKQf3OgyDvutwdOVgEHaPtS7qYfG7VukyBlv1yMCpyKj74CKALCxhTOHK9fBXCJEZdA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792956159;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=swmqj2hEmAmPXpOYl8ikee/dZbiUgr/KPtXA1aeJM6A=;
	b=muJJ59pZThdSqmk3i7WQN4Xz/vUK+FHXsqiTeJia+E6uCTQWgDvBP1w9xxTYK/I3GCI8
	 MA/gaKNFcf3bAbudGdcKbkCegdxsB+5CQDfyIlUYRGpufQCrpzb1ZZSY4ssfaynvFMomt
	 cpYdGzg6GJbOHzBL3J8Ym6yhG/JyVif8CuBCYFcbmO/Kd+O1ChewyMTfpvGrn5ujdEOwq
	 8Rk1dJHyuMRxVt3CYXDDeEfqRbUrGRIJ7jbxJiTRRZ2XXvkRFrsRSLjmn8gzQG+mrmygX
	 LVgrqgQ3iX7EkPCZGkkbFIq+q8jAxkYX5aelOA/12f9U7okBHWB6su523UpvaPgSdVA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=pZkS7dfj;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=NLHJa+qY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.24
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E5D606A320
	for <linux-can@vger.kernel.org>; Sun, 25 Oct 2026 19:22:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8E5D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=pZkS7dfj;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=NLHJa+qY
ARC-Seal: i=1; a=rsa-sha256; t=1792956150; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=GtuQflZW5HBrb4gIWgw6UpbWaNZ7Tu5YMGfScnXycG4Y1BCAR8/VdOl3E6HTuWhGYQ
    60bkKQsiHpRcSkbFt77kGuNNHnUbXyaki0DcOGF5XtOD/mQ1jvosVcO4Dt9pShc/SUiR
    eeLQZE6tyEw0MPn0bPJ7q9p+zh9sMfj1/1C+15ICnJsqWEV1TbiYYUdz/I+BQdNnZmBD
    rQD7SCc+Y0eWPtu1H8nTPMFXOUcSiwLdrnT9fdhi47+YvpxArv46erB1xpmkevDd45BR
    VJ2xkXmy01LkEBmuSwTHbeSjazf3k7z8ejlvyWCsl9PD6jUgcXpPt9gIIm6/y9CJYGIc
    oElQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792956150;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=swmqj2hEmAmPXpOYl8ikee/dZbiUgr/KPtXA1aeJM6A=;
    b=pTm27PsxSlLJ3UUZe7Z0otoWiK8nvToAqIcGQx3XONPU5VXxedgrhQvlPIWz6sFQ8Z
    CYXNbPcOJCOSROL4xNleULxTD9zlckF33vCsoBpn0+KfyINhwQOkowxcBK0Hf9UYt0fK
    7L+/Ma15ln7aulGiYrWcUL6PBM6YaUm+LCI+n1AWh/99ecnthqSMVOUZcjB9kxLaOKaC
    +L+Dc1dbSvLrjC0WwtH2djqXO+WZVd3ozkoxah0O6xQLbbsTGJV/VUNusQeUgyPbuoeS
    2RIM+wLPipqRHXXShjQDNF9BiK7+cXq5z5bFFhK+hHEWX0HfUk8I2NfJ0nY+GMWyiPge
    7z9A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792956150;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=swmqj2hEmAmPXpOYl8ikee/dZbiUgr/KPtXA1aeJM6A=;
    b=pZkS7dfjnd6B9HSc+CD8DP0w0ZzxwijDTJ3wzEUJ/OLgYiIODRKegmFWLtgR/8HYE6
    VWiq4qVm1I1ti4umIIv0KZ0mxpRv9sp/nzZOg68wv+ULvzAKP1R9IH/7PmqM9JPN4vLz
    irqQNNSvlUFsjDhu1QTn5tG3CKNoPQVi1mKkPHcadVrDMSNnCuW5vO+iOdKHqNA+Ny/K
    qVewE0O/9TZwv5SAf7giKQYmbX5nL1SRhcUWo/iHavoW0U6jQFyx8ouMGyLjpX14HBZv
    1yfiE2z9mCH1rCAsEcGQATWktxjcGNem3AFEACgkrbPMOLO3IKFDHQ88RU/vVw+BJ2uC
    tp0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792956150;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=swmqj2hEmAmPXpOYl8ikee/dZbiUgr/KPtXA1aeJM6A=;
    b=NLHJa+qY0wOKlBOJbGwZCZoaeGY6H9ckJfxu7gh5tbRib3sIsudqgz6wfLQJPlkzE3
    hR8YNJor1H6jf/hZfUBw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29PJMUyxT
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 25 Oct 2026 20:22:30 +0100 (CET)
Message-ID: <4dd68aae-41e8-4b9b-b520-4f281c9a93c2@hartkopp.net>
Date: Sun, 25 Oct 2026 20:22:30 +0100
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
Subject: Re: [PATCH v8 0/7] can: protect the receive lists with a per-device
 lock
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org
References: <20261023121801.3052075-1-socketcan@hartkopp.net>
 <20261025-pompous-mahogany-koala-f18498-mkl@pengutronix.de>
 <ee27f899-0ac1-4059-ac74-e4ddaab61b0c@hartkopp.net>
 <20261025-unstoppable-valiant-woodpecker-20c6dd-mkl@pengutronix.de>
 <6421fcb8-beb0-4d42-b94c-6c936af3d7cd@hartkopp.net>
 <20261025-vivid-inscrutable-poodle-cf558e-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20261025-vivid-inscrutable-poodle-cf558e-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 25.10.26 20:19, Marc Kleine-Budde wrote:
> On 25.10.2026 20:16:58, Oliver Hartkopp wrote:
>>
>>
>> On 25.10.26 20:06, Marc Kleine-Budde wrote:
>>> On 25.10.2026 19:55:11, Oliver Hartkopp wrote:
>>>>
>>>>
>>>> On 25.10.26 12:28, Marc Kleine-Budde wrote:
>>>>> On 23.10.2026 14:17:54, Oliver Hartkopp wrote:
>>>>>> This series fixes a use-after-free in CAN_ISOTP and CAN_BCM that can be
>>>>>> triggered when a CAN device is moved to another network namespace while
>>>>>> a socket bound to this device is released [1].
>>>>>
>>>>> This series doesn't apply to net-next/main, probably as it's based on
>>>>> https://lore.kernel.org/all/20260831052031.902699-1-ekffu200098@gmail.com/
>>>>> Sashiko fails and you'll get no review feedback.
>>>>>
>>>>> "b4" has a feature to track dependencies and put annotations into the
>>>>> series. Please consider switching to b4 and use "b4 prep --edit-deps" to
>>>>> track dependencies.
>>>>
>>>> Good idea. But it does not help for my current problem:
>>>>
>>>> https://lore.kernel.org/linux-can/bd31fd1b-1fe7-44a5-99ee-635262a1ed33@hartkopp.net/
>>>>
>>>> Against which tree should I post the patches?
>>>
>>> Does this work?
>>>
>>> base-commit: net-next/main
>>> message-id: <20260831052031.902699-1-ekffu200098@gmail.com>
>>
>> Ah, I see what you are aiming for.
>>
>> But net-next does not have the required "can: raw: remove redundant NULL
>> check before netdev_hold()" commit.
> 
> ACK
> 
>> Or did you intend
>>
>> base-commit: linux-can-next/main
                 ^^^^^^^^^^^^^^^^^^^
My question was about the tree!

I got the message id thing.
>> message-id: <20260831052031.902699-1-ekffu200098@gmail.com>
>                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> That is "can: raw: remove redundant NULL check before netdev_hold()" and
> should add it.
> 
> You can test with "b4 prep --check-deps".
> 
> Marc
> 

