Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBEC17A300
	for <linux-can@vger.kernel.org>; Tue, 14 Jul 2026 10:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784025344; cv=pass; b=XZWeCJrxOCUemwfpWWyuY7y0UZGhc+w/HBlis2Mf1pi0W/7AnnrIri607be22B4PA3MTRTvVIE2n8heCgucnCcHqzRwD4cOr7ONFWCRDhmPEHnsBq5G2JdrRBml7LrhQayajg6qEAvTKPEuI8uUo5tMdxaBC0AJj8YQdaB9kOhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784025344; c=relaxed/simple;
	bh=ePRrv0FY7yycLP8HhtCnRyU/jJ2cqch3a+4YJqAa9aU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KKAHHkwlw+qiMeU9lSxu9X1XatCcTQmpNteuCZ9CJRtEzMWJhinviNzKP/19FX6Bl6zWUaENtE97eQOmXgMXwNMblNZ6ay6Xf3kIGBrCi0C3ZRn96MgC7yXikQ//ETWvKLZcSgVZg6EHiyZwYpSpUS570nM0R2jQV/KdDnTkgfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=UhBWP10I; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=8rwAa8af; arc=pass smtp.client-ip=85.215.255.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="UhBWP10I";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="8rwAa8af"
ARC-Seal: i=1; a=rsa-sha256; t=1784025334; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=LV8wKpP//JW77H+wnW7lUbljfK8Xxh2Jci4ozFGpJ0hACLw+/fBttkRQLn9EUV+Yph
    o/2mfbtaasH+QHEUvfCSVuFtNfQGVAo1LsZWCLtX7mBQR/YRmj0P9L6O5awHXFKLBppu
    pS5SGiTHdUUI9taCD7Lm2MHFa+C0N8ye/+ynUugZuPshoO+tWyD1l7GQ8vrirSZQzehm
    qZMx+e1EmsNLv+ttbfdcan0V1E1epm2YkKgArH3g4iNKaOzH9QmMUII+nVu/FOz4MQqN
    0bgQuIJIrBkYpETZ6hk+1sWX3vO1XQ15MwTnZOUA+Gk7XCzsisW07IogigWwqz971R96
    p9kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784025334;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=gux+pCpohnqL7jJTHmSQQkf/KuVxJCXcOgAXOyJamZ4=;
    b=QMnm4NtlM1M+5d4cPYAnVfgWue5zWMEjGvLB1X7PtPgsJ/JylxxnHypl/CIGSoznTD
    DMWHUlymAGQuKZcX1S499QjPOXY/PtRAt6K7jpklsZU3Mledwu0illKnrhL3Ml8hnPLN
    nj32xwNyLWNIS3nLMsNaajfyXymXdaLFOIwJCjsQMNWLa8euYUChwlV8sCfFvzmWlRwd
    OAsX1ScU54dXRdCiORQPd8F9c3zotxT3xpa9VWAfQSEzhhkxmB2uBFh1jC/AetUR1aSm
    kG7lsejby0WEFelJQZC64LqVbeZ6tFaJPqE0/k+ixFZSwsjma0eBdxaRwpyS8lvRRSef
    n1Zg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784025334;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=gux+pCpohnqL7jJTHmSQQkf/KuVxJCXcOgAXOyJamZ4=;
    b=UhBWP10IJwd88Yw9CqwPLfpgu3F4qkZJWYN6RWziidOhz8jUNpAOeRrSeoFWsAKYQz
    gk0ISWVj9tkc5Cn3eyXZwnVkJLTQsiMwKn4Td5MeCM7wYvGK6SOhcVBW/BrLzjMfJOQz
    uilzXlXQWAmMaa5YtXk8joOCU7pqyZxmNzRjk+nCFcjjVKo4kWT/oijcOCSvFgPME8GU
    /OATMAb1G9odWwhIZgEiBaxM8fSCa1a54dRyeaY1v5ezrX+AorxV+JlU3oly1rFFkRXz
    0oG2Nx8EdDH9cx/IDqF+37/02O1oac7UReWbs3H2MBlGYiGISOMSGtxiGJ+w1mXb1xl4
    iOIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784025334;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=gux+pCpohnqL7jJTHmSQQkf/KuVxJCXcOgAXOyJamZ4=;
    b=8rwAa8afxNN4feNkYFOHxdfuRQI3bam7hry7AVv13u8/hpJ4yDNqs+qu8byCN3ODEp
    2B4oPcfRTrZIoB/gCyDQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from [192.168.20.190]
    by smtp.strato.de (RZmta 55.5.6 DYNA|AUTH)
    with ESMTPSA id Ka9fdb26EAZYj45
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 14 Jul 2026 12:35:34 +0200 (CEST)
Message-ID: <b8c6e49f-388d-4b50-98cc-45475c5d4e3e@hartkopp.net>
Date: Tue, 14 Jul 2026 12:35:34 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 04/11] can: bcm: fix CAN frame rx/tx statistics
To: sashiko-reviews@lists.linux.dev
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org,
 Marc Kleine-Budde <mkl@pengutronix.de>
References: <20260714-bcm_fixes-v13-0-fd667c61099a@hartkopp.net>
 <20260714-bcm_fixes-v13-4-fd667c61099a@hartkopp.net>
 <20260714103300.8B6391F000E9@smtp.kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260714103300.8B6391F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14.07.26 12:33, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Missing RCU list primitives lead to potential NULL pointer dereference or memory corruption during lockless /proc/net/can-bcm/... traversal.
> --

Fixed in patch 5

> 
> --- Patch [4]: [PATCH v13 04/11] can: bcm: fix CAN frame rx/tx statistics ---
> commit acb95cd7e83f916c374a2a2f75ed2b971c9fa9d5
> Author: Oliver Hartkopp <socketcan@hartkopp.net>
> 
>      can: bcm: fix CAN frame rx/tx statistics
> 
> This commit fixes a data race detected by KCSAN when two CAN frames are
> simultaneously received and processed by different CPUs. It transitions
> the statistics counters to use atomic operations to prevent races.
> Additionally, it simplifies overflow checks and consolidates rx statistics
> updates into a single critical section.
> 
>> diff --git a/net/can/bcm.c b/net/can/bcm.c
>> index af4bb4182bc29..38c3f690c1cd0 100644
>> --- a/net/can/bcm.c
>> +++ b/net/can/bcm.c
>> @@ -229,10 +229,13 @@ static int bcm_proc_show(struct seq_file *m, void *v)
>>   
>>   	list_for_each_entry_rcu(op, &bo->rx_ops, list) {
>>   
>> -		unsigned long reduction;
>> +		long reduction, frames_filtered, frames_abs;
>> +
> 
> [ ... ]
> 
>> @@ -280,7 +283,8 @@ static int bcm_proc_show(struct seq_file *m, void *v)
>>   			seq_printf(m, "t2=%lld ",
>>   				   (long long)ktime_to_us(op->kt_ival2));
>>   
>> -		seq_printf(m, "# sent %ld\n", op->frames_abs);
>> +		seq_printf(m, "# sent %ld\n",
>> +			   atomic_long_read(&op->frames_abs));
>>   	}
> 
> [Severity: High]
> This is a pre-existing issue, but while reviewing this code we noticed a
> potential missing RCU primitive issue.
> 
> In bcm_proc_show(), the code traverses the bo->tx_ops list (which contains
> the loop printing the tx stats above) using list_for_each_entry() instead
> of list_for_each_entry_rcu(). This omits the READ_ONCE() dependency ordering
> required for safe lockless traversal under rcu_read_lock().
> 
> Additionally, when adding to these lists in bcm_tx_setup() and
> bcm_rx_setup(), the code uses the non-RCU list_add() primitive instead of
> list_add_rcu(), which omits the required smp_store_release() semantics.
> 
> Since a user can repeatedly read the procfs file for a CAN_BCM socket while
> another thread concurrently adds filters on the same socket, could this
> expose lockless readers to uninitialized memory and lead to memory corruption
> or wild pointer dereferences?
> 
>>   	seq_putc(m, '\n');
> 

