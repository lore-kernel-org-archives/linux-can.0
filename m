Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDEB4D3BC5
	for <linux-can@vger.kernel.org>; Mon, 19 Oct 2026 14:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.163
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792421195; cv=pass; b=j4O13HXuxYYGrOVbKrQU6CBItWtMVtmYBcfQ0fcRnjGw1iGIKwyTWslM64jgjSfU899Eb1ZXaSGRKJ/FLSuKx9sAi63D84vtXLf1TNebwOC5xDIiQKpfD1dUDcyrO0Gv05bz3Ax//5pF3z91M1xqf2X4KiFPR7qT0kDULw0u97o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792421195; c=relaxed/simple;
	bh=slohJxCTtGHTMgIypC/e2xmVQYt/HtaNxlY9IyHaNvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sAzqk6w5ParbdzxkLl07gKiAbrj82vuBz4O7egFAIfeYb5BQn5ur4N77Ym0o7WtPXn6flaXA2ndh+v1juyOfOD4XGuxe8/Q5Tks+aBglZhRUAh73AI61YLDfNd9quK30Gjs0X9Wx3clfx61AA6qDFGeJRgBhTKUy+xPYxUy2dyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=RvdudvLO; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=B7V6+MIj; arc=pass smtp.client-ip=81.169.146.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="RvdudvLO";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="B7V6+MIj"
ARC-Seal: i=1; a=rsa-sha256; t=1792421184; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=cMazlwGFyJpb898JTgs5zQQ+X/eWeaq3pfm7dRR2wv890bq5A7ktHrZkGOqdKt9JEh
    qNVG0JSjk82MiL/kc27Zb1zGrhfc4rP8XDSxO4WI290WqihHpTUQrGLYv27QPtAD02PV
    mYxdOmNS7mGb6ZuhJkNyZO/R2AbBMUwHTtj2AZDjDKDgbtXczCocUlxK87W3jitOk6a+
    1sJRhgXgoeHPanSLmwjbRnYNH80LC+PHymNqi64usrrz42v7QBHrmucL6Ji1CsAPfw3s
    H+ckOM7TsF1s5T0C6ag5A4MXqXkOKEF1FIXptYv1oJKQlsjD4AThKrq22zxLpS21Kmwh
    h0RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792421184;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=LFUy9mxPiCYxU4NBGVFfXTXWKxCquXiVt8mIoSeB8zw=;
    b=QIna6WribuaC9amvM60MRk/eUQXq+TpiKSFQSPzhzpiiMYcCdqEmRSKHYBbXoXjAB2
    O8JCKT9VM+u+WuC4qxR+OuC8XKWIWjlxRGIAPrgCIyneDNo4ugtV7eVHwFanaLJjomXm
    84a7OTchVWEoJYLTNqytLUZCptkM3Qs7tOoGaPlihZaN+P31Bin9H8a488VgVKN7LnnQ
    4sgYyAMQNeJpx0/a8NldVrIoVdy08/S2P6w/0q/DYHjD1mx1/demEFd61o/yFhEDYPwt
    NXFZJKJYZDHRfR1ocV62z86VcMnnpmDHzQtB/vl/yS1rwtmKAXV4I9JHLFYQDPfpvSD9
    aYvQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792421184;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=LFUy9mxPiCYxU4NBGVFfXTXWKxCquXiVt8mIoSeB8zw=;
    b=RvdudvLOp9ZsrfsaLcQH6wbjowZ0T6nNRTbyMol4x+ukeO54rkmzd4XlucczWhER3a
    JzfspP1v7kxr/ZYw/C3hvOdx48u6lpGjWmHm0g4MPvHoIc5ckHmJes24uzHMxe7c9Ffd
    HCmNGEEo1JRqOvCpvJeIyFAAg1kLLCjiZinPhIM4cVHVfYGL5vzQp5RXskyXVYprwJQl
    U70IRiGJWQtHhcrqKJaggd6FTUSThRtHIEfvruFixsHRQ0Y0DVR5ZCkSL4I5b2W0MoI+
    U4rWyo8gqQb9Dh6UBseH4K3l9LymW3BhHgeLO7L+kEdYBL4mOXWgDPDPjtFyrRugIg8y
    3oDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792421184;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=LFUy9mxPiCYxU4NBGVFfXTXWKxCquXiVt8mIoSeB8zw=;
    b=B7V6+MIjraLPXBWbw96m9g+bpa4Yr/Pla6bLPlJe83wUDenD7DCzeQQ9Lc20rXucP6
    01sjzsUZ/REAoyvhE8Dw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29JEkOXN4
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 19 Oct 2026 16:46:24 +0200 (CEST)
Message-ID: <4c81a8e3-431b-4d18-814b-e09cdcff0b18@hartkopp.net>
Date: Mon, 19 Oct 2026 16:46:20 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH can-next v3 0/4] can: protect the receive lists with a
 per-device lock
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org
References: <20261019074244.50391-1-socketcan@hartkopp.net>
 <20261019-premium-anaconda-of-education-723479-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20261019-premium-anaconda-of-education-723479-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 19.10.26 16:12, Marc Kleine-Budde wrote:
> On 19.10.2026 09:42:39, Oliver Hartkopp wrote:
>> This series fixes a use-after-free in CAN_ISOTP and CAN_BCM that can be
>> triggered when a CAN device is moved to another network namespace while
>> a socket bound to this device is released [1].
>>
>> Only patch 4 is new. Patches 1-3 are already on their way to net-next

As these three patches "1-3" are not in your current tree anymore you 
can simply apply this complete series as-is.

And on top if this series you can also apply this

https://lore.kernel.org/linux-can/20261019115231.93550-1-socketcan@hartkopp.net/

to fix this sashiko-bot remark:

https://lore.kernel.org/linux-can/sashiko-outbox-176764@kernel.org/

Best regards,
Oliver

>> with the linux-can-next pull request [2]. They are included unchanged
>> only to provide a sequence that applies on top of mainline, so that the
>> sashiko bot is able to build and review patch 4. Please do not apply
>> patches 1-3 from this series.
> 
> This doesn't work for me.
> 
> Please post a single v5 with all of your patches based on
> linux-can-next/testing.
> 
> regards,
> Marc
> 

