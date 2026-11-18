Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794997719;
	b=nuJzu+ml7z3kwNZTRdasYcTgLVtk5BNhjQ0iNd7vYRsAa6yps1VWV6E72QH/sFCXv2yt
	 HojzhsKD+6nmZsFRVleSDkH76Ur8/SfSDiQMttVTZ6ObbAasPuZQspNJEcSxdbdldRjYI
	 bISDin5kpvhLs4uH6xdW+itsOeHZOiMPvSdGCZR3Pan0lyAR26b6z1guBLyD+D64o0v98
	 SUKaj6RssnoiZiwFGx3iceJYKnMqU4ebNOsjTWoFBhTtQFK3HCSoid3/0lSQskxLIwIQ7
	 86QeNrlseI/y0I0wKcXQU+1VC0IvzuMwVXzTfLBy7NgECdRtks5PDYFK0SevIKLozow==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794997719;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=7g6QQxsHo/KD2ZuYZ/qNr5ltEL4M5F15oOG71dYxc3s=;
	b=veiU6knkZGSSR/0wyLJmXhSSIcTxAbJsLRze9rr0PlXh164ItAdDA6Q5Fslz1FQnCHHu
	 MwWznC7TNyKHPWs5icSbV2DHDan6nutxNnpvSVOp535nAJigtCvGusaAs1M8OBaP/F9hd
	 7Qm1zsLZdXEiDoGIe7lEnvfmxNewvikyWia+MJfDhrF/eihNefkFtbE5tTqkYIeoUSNEM
	 oJAXM6ZQqiBCbiJJ++CwNxRcK8weSFv4T72hzHMzvOqWd9Rgkyizn2j0AXyyXankd/CPg
	 7cLhApRa/1r2D1khd6R7T0ReFCenzyNOaBGjoi95C8JGTjp2UGoFNS/3XJFJNeBZ9/g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=lDG9J8mG;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=222K0LPy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.50
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46F2606A334;
	Wed, 18 Nov 2026 10:28:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C46F2606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=lDG9J8mG;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=222K0LPy
ARC-Seal: i=1; a=rsa-sha256; t=1794997714; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=T0oG06Hasto73lK69x61uGBrhtqGnNFBa+C1mkaqvH11Y/vXWbEahYixMEI4R0zV45
    To1NjurFZhBhaCc3cNM47sySnIhQykA5mOPVdaMcN+38lr+KCwKFPgU8GNtlakH7zWRe
    +eySaMuQ4HAVW0W6iNV9TPT3cHa/2dgkhcnpQP+Pj8P9A2mZX4dzkXLG9Nh6+DdtrTmB
    nOdU8XymawSiPh1vArtxUbltKV9/MbdbsHHGJZl9bxE5/eHT3Conn6JwvnXaHsREInHL
    1PVnVRpmEbs0IUaPkqar3QBdUy3lXqYGWFxwQpPDZDqh/mUvZQcsGVaBqxju9NJ313ov
    39fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794997714;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=7g6QQxsHo/KD2ZuYZ/qNr5ltEL4M5F15oOG71dYxc3s=;
    b=bb2ueOovuYxjLdsBZIYMu82QszoGh6PLGKUCOa6w8/v8iPGPwgtpF5trGKtS8h8ZbN
    qAzSGUAsdWvnWPrw9zzsYbbRI0E2HLtlGjwCKISdi1qlPWNNkyys0+A8iUtXxuncG84c
    IA2vm3w1yDqZytqJ27E+TQ/hPastQTvY+2L/UWfoyXOnX2cTwr9WISWJfqAwfomNCJbq
    KfPrtg5lwVMTRD2jnaIUFcsE2W16SIcJJMPkOxvVPi/HVs4sNB2llBp3A1/yMLi8qlaf
    WzzaS32q6FFox5eAQHM1MTxk5mN778tqsLjAZLOdpC7jLQ2e5gHWoLg5hBfEOKBQfgj0
    aXSw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794997714;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=7g6QQxsHo/KD2ZuYZ/qNr5ltEL4M5F15oOG71dYxc3s=;
    b=lDG9J8mG9/fgAF3U6xqk1cDW5Fr2J9m7gOeFDbMWw/FKR1U24O/bRBdCDam5378j6+
    O/8nJl24sjX3IkEj63oYVrFcHGlXMjjOM8iOSsHF1vxoucXUCdBPSauLUD18+7altBmb
    zmHdvTTx+ikM4jns2lRqKg8wLleRieua7v9+7OuJ/wQyR+pdjEcQm3k9DWZZn/dpzAnG
    SNOeLjW63zMQwKB/b+jeZ8wpVMQ4id7AlSwwwPw0+dxMx7ZwKqSQ9XLMtdW6lBciVuCR
    NkicXY3WldO7NMWiolTUYeQSmwTi5Av34B0YsGIqAf3WjD0i5A/NDG3rB5fJqgiNTOaM
    CKhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794997714;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=7g6QQxsHo/KD2ZuYZ/qNr5ltEL4M5F15oOG71dYxc3s=;
    b=222K0LPyRcXb5rR5wPa448LSKh9eOkw8Tls2plCXCsq/hEGmR7tQre9PkcdanGWgSE
    DusmpnyK8vbh8EdKHSCA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AIASYFIt
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 18 Nov 2026 11:28:34 +0100 (CET)
Message-ID: <5884daae-c820-4e2b-b5d1-7ac2dfb6013a@hartkopp.net>
Date: Wed, 18 Nov 2026 11:28:29 +0100
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
Subject: Re: [PATCH can-next v2] can: bcm: Document cyclic transmission
 failures
To: raoxu <raoxu@uniontech.com>
Cc: mkl@pengutronix.de, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net, horms@kernel.org,
 skhan@linuxfoundation.org, rdunlap@infradead.org, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <75785AF83A9D9B09+20261118091938.3365557-1-raoxu@uniontech.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <75785AF83A9D9B09+20261118091938.3365557-1-raoxu@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 18.11.26 10:19, raoxu wrote:
> From: Xu Rao <raoxu@uniontech.com>
> 
> The CAN broadcast manager continues its configured cyclic transmission
> schedule even when a CAN frame cannot be passed to the configured
> network interface.
> 
> Such failures are not reported to user space. The failed transmission
> is not retried by the broadcast manager, the timing remains unchanged,
> and a non-zero count is decremented.
> 
> As a result, a TX_EXPIRED notification requested with TX_COUNTEVT
> indicates that the configured transmissions at ival1 have been
> processed, not that they were successfully sent.
> 
> Document this behavior to prevent applications from treating TX_EXPIRED
> as confirmation of successful transmission.
> 
> Suggested-by: Oliver Hartkopp <socketcan@hartkopp.net>
> Signed-off-by: Xu Rao <raoxu@uniontech.com>

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

Many thanks,
Oliver

> ---
> Changes in v2:
> - Target can-next as requested by Oliver Hartkopp.
> - Adopt Oliver's suggested wording describing transmission failures
>    from the user's perspective.
> - Clarify the TX_EXPIRED notification semantics and scope the lack of
>    retries to the broadcast manager.
> - Remove implementation details and redundant descriptions.
> 
> This documentation-only update follows the review of v1. The earlier
> proposal to change BCM transmission accounting was dropped.
> 
>   Documentation/networking/can.rst | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/networking/can.rst b/Documentation/networking/can.rst
> index 51bc70748f75..ae47f40bf456 100644
> --- a/Documentation/networking/can.rst
> +++ b/Documentation/networking/can.rst
> @@ -892,6 +892,14 @@ only one timer is needed 'count' is set to zero and only 'ival2' is used.
>   When SET_TIMER and START_TIMER flag were set the timers are activated.
>   The timer values can be altered at runtime when only SET_TIMER is set.
> 
> +If a CAN frame cannot be passed to the configured CAN network interface
> +(e.g. due to a full transmit queue or the interface being down), this
> +failure is not reported to user space. The transmission sequence
> +continues as configured: the frame is not retried by the broadcast
> +manager, the timing remains unchanged, and a non-zero ``count`` is
> +decremented anyway. Therefore, a ``TX_EXPIRED`` notification (requested
> +with ``TX_COUNTEVT``) only indicates that the ``count`` transmissions
> +at ``ival1`` have been processed, not that they were successfully sent.
> 
>   Broadcast Manager message sequence transmission
>   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> --
> 2.50.1
> 

