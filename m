Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE354508E9
	for <linux-can@vger.kernel.org>; Fri, 16 Oct 2026 12:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792152739; cv=pass; b=W0KnQQ5PZ7gUu8xCt0KIg17P29g8M3QvLMHvKqtoZ0NTTxdjnoh+9rmVwOnGYMQXMeKL/eB9AZhP8YZh+9ll0IISUODCXFPAeg3VvtcCxvS62HYomLhygH3ROTW60qQ8VMCo9UCjeVk0y3nCZ7jL14Lc7oTr78kkOP/mUpt8kFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792152739; c=relaxed/simple;
	bh=0WKtCoogSm4qqsG01+jxCzBa69R4zHNIbHhNK+wpj4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tD9X20G8ul3DUOrbxI8cyCLlHbIKWOgkvGhLJvIrxEWLt0be41jmMmWSbMO+/YDSG6sYuDrRo5ov7C+ipufaYWraXMasCwdW2e4Y9W0OlySF5JpZP+zYjeYx3D1pCvlhS6p5v70Kq/9Usa1nF5D1yZcoLdCaOZmfraH0T9iOBdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=agK4aYFO; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=iQ6ILBa4; arc=pass smtp.client-ip=85.215.255.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="agK4aYFO";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="iQ6ILBa4"
ARC-Seal: i=1; a=rsa-sha256; t=1792152725; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=fRcbdRkjjTiL7Z5JQ1DcYCF10j4FRBWSBB8zwwAwOV60XePlVDjiHMdjHR/o0lU6vX
    hiUlIiREDHEi+bs02evZbAsjGJbecqWA1F6kbJVOZgVvaB20H+/KYy9O5zF4qKN0eaEb
    uz43xAvdvCsD/IGoxs9Gy26ZZjoPsk+GU5VPO9qU/JsPJATG7opyzIHmJiOoidgxOBzn
    1xJqJ2aB/zYFexqaMYftom3+kJ2AKpyyE0NFDPjeKXB8pMuKiPZnE2ikRGkHrgHJvWek
    4zDyvZvDH3ZvdLY4HrlDQzRYjXuKwHmeDlyMlnJnLil0mtojR0uFuRHH4EcApq4h39WJ
    awEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792152725;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=5k3l4U+QMxhR62Fwz7Nw42sHu7yHPuy03vgR3H4peCk=;
    b=i7ZKx21cdq4lPMrv5uJBoFhaA9nGs/feU6uDZ9F8PNfB36rmRofY0ZE1yVR9mOmR0M
    F7cSc2eFv7S96zYR/nc8IHbspv+PrcrjO/yw2MSGz81HpzH/s9RRaxFyrXQ93Pun86Ux
    63jG9et8HURlPR5zWjSpubffuRe7TtnUUZsl+EUqDFdjokQrj0OdbmROxeQ7csu6C7o2
    VbKRlLOokfo8sMQof+9uql4m60userAIvozRiIzNTIMh30f3fmL9QuSVyBeIAwghSfH7
    ihgvZCAFXLBJnMZ9s20psnSQwhk073u7w+MVeu0RUhayH8U25WByQUlE1TWy671+/p/d
    kSPg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792152725;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=5k3l4U+QMxhR62Fwz7Nw42sHu7yHPuy03vgR3H4peCk=;
    b=agK4aYFOaWLWylWXy1ansQigM7QobtQemmFLLDIepsmIJ3xfP4LLmWfw8Hvuewcquk
    YaNtLNFNI/wyGOykDMntvofVKGLBK513a8+soJE3k7amz+jXwRWOc0KsImMVVVlm4yTR
    imSbOxRKpdtNMXtVh1y4BXh4RqnJX2YiNVLa7Q9+4K7Rf5ahpYa3qoJWrPEtAB2TYsr9
    yKh/wnQdOuanKQ64CJzAhhkedeDE/JWiZXDNhggk92zAJ9b0V1SBeBrk6++R5wFvscCR
    WBbMx9Ggiv11vczKStElgBJhaGeinGlvS4EEwmKmfIpLHvJbTFZzwqjBua6oNTs2qwfT
    Tepg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792152725;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=5k3l4U+QMxhR62Fwz7Nw42sHu7yHPuy03vgR3H4peCk=;
    b=iQ6ILBa4pbw6obNgrRlKsanI5yoNhjlwBzUCd8gNE8AMV63aUnp9an6IAltYdTFP5r
    XOT/c9NUlLeCIC4vMZCg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29GCC5MF0
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 16 Oct 2026 14:12:05 +0200 (CEST)
Message-ID: <f2278719-d4a3-49dc-9780-271ae20085c6@hartkopp.net>
Date: Fri, 16 Oct 2026 14:12:04 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH can-next v2] can: replace ARPHRD_CAN type checks with
 can_get_ml_priv()
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, stable@kernel.org,
 Oleksij Rempel <o.rempel@pengutronix.de>
References: <20261016093525.327367-1-socketcan@hartkopp.net>
 <179215175423.1281414.11369167443665043648.b4-review@b4>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <179215175423.1281414.11369167443665043648.b4-review@b4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 16.10.26 13:55, Marc Kleine-Budde wrote:
>> Commit 4e096a18867a ("net: introduce CAN specific pointer in the struct
>> net_device") introduced an explicit way to assign the midlayer private
>> pointer (dev->ml_priv) to named users like ML_PRIV_CAN. A valid pointer
>> returned by can_get_ml_priv() therefore identifies a real CAN device.
>>
>> The referenced commit only converted the j1939 and proc code to this
>> check, while the other parts of the CAN subsystem still rely on
>> dev->type == ARPHRD_CAN.
>>
>> The TUNSETLINK ioctl allows a down TUN/TAP device to set its hardware
>> type to ARPHRD_CAN while dev->ml_priv remains NULL. Such a repurposed
>> netdevice passes the ARPHRD_CAN checks in the CAN subsystem, which can
>> lead to a NULL pointer dereference of the CAN specific ml_priv. This
>> only requires owning a TUN/TAP device or CAP_NET_ADMIN in an
>> unprivileged user namespace.
>>
>> can_rx_register() already rejects such a device since commit 8aa59e355949
>> ("can: af_can: prevent NULL pointer dereference in can_rx_register()"),
>> but can_rx_unregister() only checks dev->type and dereferences the NULL
>> ml_priv in can_dev_rcv_lists_find().
>>
>> This path is reachable via isotp: isotp_bind() only checked for
>> ARPHRD_CAN and ignored the -ENODEV from can_rx_register(), so the socket
>> was marked as bound to the TUN device. A later isotp_release() or
>> NETDEV_UNREGISTER notification then crashes in can_rx_unregister().
> 
> Let's hope the bots will be happy :)
The crash is fixed. The other stuff is no stable material.

;-)
