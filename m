Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.165
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792957925;
	b=Y7jBSKnbrzdH6Calzu5mum2HWd016lUCXIrRrCMaoPbP9GyUeuGvc0WAvY00yZu9Hl00
	 UBv1nJosGJkR57jfmj1pR9FbNBKqQqa7a/FSQzd7Rov3SvhPfOWIqvzefsTmLRM5fwsEA
	 3kFtqgoytKjyGIylnkkHSDeUdk5ZKBmaYZhuGjkjwvk8LUKh7aen21yhIuGPIGJEgxVex
	 x6w1V6YurB6ZaOql/fGiPQ/AErqxxd9d1HpqNhYIAE2mYgSIQXP8vzXOt1vbBmA/+5VXu
	 kC0PGhMRyMUL33zuOtqmahsZcVwMpYHItsesOwLWKP4sGRfZW9Bx/IYklgK6N8P34ng==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792957925;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=vuewZKJsHYc8qWzoNjgdMU2lcttQpXm1LlJhICyBRiM=;
	b=X8SLKsaZg48pNwDqjGaYsYCZNzsHpFHxZRCCrV5SsccPO+aR9e/12Ez2FLV6P4QPssET
	 RQTnu2YZTW/6nLST+JeOjLe26JY7WvH0lJwnMMyMUp0+BPlryFO2Z/PzRuCMKKVLBHlAj
	 O8/tWjaUV1LuIt6TXkBdN8XRIQ/JjwWrx3ILk98O5b6SOOmt3v/6NGHWohhauWKutQ+Tg
	 si5n4lb9v7UolzCkbVt1T5WGcH9Xk2PYKPEntf71Tt3UTNcQm043OmsR8WfvVoeLdYrTT
	 qZzz2Yz37HQH0hIZp18NPjcXi+plp9w2u8no54DXPxwzEhL8p15QpTTs1Ro67+YLjRw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=tfQ6dw+N;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=fYrZVDHK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.165
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA34B606A322
	for <linux-can@vger.kernel.org>; Sun, 25 Oct 2026 19:52:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA34B606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=tfQ6dw+N;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=fYrZVDHK
ARC-Seal: i=1; a=rsa-sha256; t=1792957916; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=HsYS8d4n3qQnbAUltrO/eneQdF0K5DT/asoaU7Hu1ZyngyGDsVwuY/U88YzIb+IZxv
    v0Yet+9SLotE/ECeiQbCXfyaSlYyVtIhYQvDcrCuClV9fg90v7U+tnLYzWTaSl8N9B86
    lDb+jB00EUFjdKcYas35iIWLNdHlb3KpadTvc4RXj5+h4ame5zP5sCM8YHpprXdCoFMA
    9spikfjxDUtExeLK6i+u7x/Xu/lsvaRIbsHBidpT8qN2r+UD6UvlyAZyz812zSH7Ysql
    yZJjQIMfPsP263HPDsP+2QMV7UzXbYe+kG5WTCOUt70L0zvOkVPEl7rC247ApVK446vd
    17lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792957916;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=vuewZKJsHYc8qWzoNjgdMU2lcttQpXm1LlJhICyBRiM=;
    b=gZEgSHd8w3sa1VwbY7u7nbwb2GPwzgMj6Re3Jp97r14A8T6u3CjJMXGSBrW7+PXfln
    GzqcwaFA6e1Tu8xMCpAJ0f9RF/nD0aTFbzGi23Ma0XnjMI8FA2IqJbXGaXc/Pkq/iImp
    Kv3pBPZ8O/0QEw/QkinetYYycB6ZJxwKQWfcaqEu3IdNczVApRPC8boNRqbGUhFcxFeH
    iOp3IuBY2q8b6NTdKkQbw2Xdc/+cvA5S+ItTLc36BsiCL5QHi0zzFvVNAvRRCQU/oi2o
    sZfx/2FVSHBdW0LwtCs7HeNfK8sen1a3+6Tfpt4KzcrmPRsytOvNG+W54g0VT+sVagLp
    ykgg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792957916;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=vuewZKJsHYc8qWzoNjgdMU2lcttQpXm1LlJhICyBRiM=;
    b=tfQ6dw+Nfqy+VlLzsmKHIBtEbi/UhZQIMzxMwV6o4qbuujvT0/rE1FnHg7H12FDUgE
    ouJi0YQ8GbdqGiqjaF39xUI+IU3WkIiu7IIQXlPMINcSbX9uoeUOj/b4k/+B1yI/jsJr
    +M4YCjNTdCPXRB8LrmPmI8uwVmnfHVCG7tm+dvCDL5vfp2GLCdHVhz5tTxvh9nzH6nlQ
    wLv19KRe0P5fz1P8393dY104hbpKu+VfrlG4yZHRcGdCya8JbF8gx+U+Ct9YT2SpHoE/
    l0Z9tqKz8upWV9D8NR8eBtputdYm2wXVGzn/ZnIcPTVTXHpNKDm9tXlI1EW8LIYC7ONy
    TjXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792957916;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=vuewZKJsHYc8qWzoNjgdMU2lcttQpXm1LlJhICyBRiM=;
    b=fYrZVDHKOysf6IrYKyNCr9DjHPzVghP1joFSRiQjyqaQBPsJ/AgOtpUJtaIg5ECHzM
    Uv3XqlIYf44e3tTKr0CA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29PJpuz0r
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 25 Oct 2026 20:51:56 +0100 (CET)
Message-ID: <7e91a6f7-7922-4964-9f96-c8e9b9f2f5f3@hartkopp.net>
Date: Sun, 25 Oct 2026 20:51:56 +0100
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
 <4dd68aae-41e8-4b9b-b520-4f281c9a93c2@hartkopp.net>
 <20261025-eccentric-sweet-hedgehog-ff4c6b-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20261025-eccentric-sweet-hedgehog-ff4c6b-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 25.10.26 20:43, Marc Kleine-Budde wrote:
> On 25.10.2026 20:22:30, Oliver Hartkopp wrote:
>>>> base-commit: linux-can-next/main
>>                  ^^^^^^^^^^^^^^^^^^^
>> My question was about the tree!
> 
> linux-can-next/main is an older version of net-next/main, so this
> doesn't matter. Both don't have "can: raw: remove redundant NULL check
> before netdev_hold()" applied.
So it has to be

base-commit: linux-can-next/testing
message-id: <20260831052031.902699-1-ekffu200098@gmail.com>

??

My current idea would be letting b4 fork the branch for my patches in 
linux-can-next/testing at commit 0c35fa862dab ("can: proc: remove 
pointers from CAN specific proc output") where "can: replace ARPHRD_CAN 
type checks with can_get_ml_priv()" would be the next commit (and the 
start of my diverting patch set).

Would this work?

Best regards,
Oliver
