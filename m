Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.217
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793691802;
	b=j0V4dAz+ILcsoHuuPdox4HtishGaWtiMMSL07iz71mmAAvSIaMzWubrJH4T6cMkrBe6M
	 Z54svrCdrXEaw73iHgWnHl0VVar4Ml1UD0DlxelwFZ98+u7tYzlrTf+uZKpIWfs0ebrjS
	 U5+2Vw+KMlfA2LOD8RMr/nGc/5C8JvL/kSkvFqsJtl3tEI4F9xAjCDfLBftAipS69Q3Y0
	 R/s81VafPFZQdVyMlx5lzOhv108BOSkQgQXJg6Ulb47Jvh+GMAUgv9ZocjFaBRQAxINPR
	 yEXZEMwl4Km+L7GC3wKIAsL8KAmH3Hwx3WUBYo8sgQDdmu2T2DA3w7F0mlPhUMON+Iw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793691802;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=+MFcSou9h2h6vyodN+ZaY2OcvSQR6D/pUbmTJ70oqD8=;
	b=AyRq8o0M+QfxlzcQDPqGNhzrUXbfJE6ssjG3neMZ6ofO4ECfgXG0Y8msZcmCqOmCUnH7
	 f+dUglIbAjWWx0fK+9xHjKPRux9U7bb45O+qdDcOgBL/FhoI5dNVg2/upq0N3L5DZ32xu
	 ZW0U9O3XRZV90Vp6uzBchf13TuWLj79sxZ0zVUmi5muMkwhwtWLr8v8oV0mYpJP4urWXS
	 J1mRPUIsZCgL57XaJSiin9SHsKCv6FsHfi8p8/Dhn/BM8N0Bswm+2yD8TcYigj3X1VfZD
	 VNGz6VVZWH1IGrFCIOe0aM14vT94tGcSHQhj6LNoOkEcB26uLuhnnPC+FepIIUDTW1A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=temperror header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=aUQppODZ;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=9qwrC6xB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.217
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6C4606A329
	for <linux-can@vger.kernel.org>; Tue,  3 Nov 2026 07:43:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF6C4606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=aUQppODZ;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=9qwrC6xB
ARC-Seal: i=1; a=rsa-sha256; t=1793691794; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=AvctdzOSRnNE/02gikamcUynOkfGPWtBMtduD57yyEkJyiZu+6Q9Wa5ba0GU6RNtUB
    Io/AkuiWgyYuf2rmqXUkDpnjzfOpBdtkxEp+hsCXe7aX0KAOsMOuIQ7bKDbvWuUrYCN8
    tf6NosgKY1xaljACv9R2Lv2ohUSUZgLa/K5OCRcALvUZ5rut4cxfYt5ocCvukW5wPVQ/
    KkBxcdXjr19EdK+OskJnGK+chMb998fsfeQ4MO/hkq9sXpulcC+sXRwhceKv9y3xiGBT
    Rogn7lAwCVdf7bwcfx5opsbn/SGsNeJnNIVlnufDVS3mWf+94i52K5JHSR0EH4gzkE43
    fd0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1793691794;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=+MFcSou9h2h6vyodN+ZaY2OcvSQR6D/pUbmTJ70oqD8=;
    b=cCJtwUAV9BMBGHhkWkBVKNmXqL9HEi0oW/Ma6KCBxv/Q3VJst2GdyfaO/a2hnNgAlw
    6ZtVfVv4Iq90lchxcr97rgjG0csUG+ySNarjZ2Hbr46Ucg0vB5MBgix4BqlnsyWmgkim
    Qkl9pXC0wUiSea90O7GKsOhhh5P5cMriu+/xPIDYadp0vl9aXIRZJGNLLRwA3Fszq+NM
    U4gax1XkQiGcIdEgrEoBCdyUdHqV+EVGq08DGAdCiWDWNTIAv7fs+pXty4qcEKJnoNK7
    TKozt9TtWPMUPBHM/j1VECjwxvLPl0tjxUvNBqrpbwFUPVjAhMp54x3E8yeiEoUWvHqq
    svog==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1793691794;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=+MFcSou9h2h6vyodN+ZaY2OcvSQR6D/pUbmTJ70oqD8=;
    b=aUQppODZAbBOcoceQysdCwvt319CaGfxqKLz1yLhgbDPibpT/zW/HjEkRE7jZuxYMp
    yjmvjx88nEODLCvOLv0IBbv6BN3arJrkjHpmV69fBOpEbAfl8nu74XOSiNvpAwTlATNl
    +jdaFImsYoQJpEqP04f0yD6RAi24xIMoTK3Nvq5dQrwoEMBv3uLKc1aGG2ZekHoMWUKu
    PnRw38hS64s4b8VoLFJNa/djf0bH3/E4lfvG2jSaVrLp6mBb8I4cs4xvWy1sD1JYDHYB
    DxMGBNY76TyPs2WxF1zL+YvRN5BuU/nl4YDsUuDY/m476e8TAP/3l8cXjFwc1tRe5+V5
    efqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1793691794;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=+MFcSou9h2h6vyodN+ZaY2OcvSQR6D/pUbmTJ70oqD8=;
    b=9qwrC6xBGN+wUEUbE2ximHqw/0XCbmdSFHF+46t6nOMADWyDaXERmU6Jzz8iWg2AEE
    H3RUqKKEbsF/TACbDeCA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2A37hDnR0
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 3 Nov 2026 08:43:13 +0100 (CET)
Message-ID: <d28e6983-e1be-42fa-943f-6de6f7429b54@hartkopp.net>
Date: Tue, 3 Nov 2026 08:43:08 +0100
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
Subject: Re: [PATCH v12 0/7] can: protect the receive lists with a per-device
 lock
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org
References: <20261027-can-rx-lock-v12-0-eb5afc2d8b9b@hartkopp.net>
 <1e9a2768-e30e-4f2d-bc71-57550d210c0a@hartkopp.net>
 <20261028-miniature-smiling-leech-6d02ea-mkl@pengutronix.de>
 <ae276e09-2a2c-4887-836d-0ab0b7561f26@hartkopp.net>
 <20261028-positive-cornflower-partridge-3f822d-mkl@pengutronix.de>
 <d87ad286-dcf7-47b6-9612-e8c2c547805d@hartkopp.net>
 <20261102-cuscus-of-exotic-atheism-400de6-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20261102-cuscus-of-exotic-atheism-400de6-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 02.11.26 11:09, Marc Kleine-Budde wrote:
> On 02.11.2026 10:16:00, Oliver Hartkopp wrote:
>> On 28.10.26 22:31, Marc Kleine-Budde wrote:
>>> On 28.10.2026 21:55:02, Oliver Hartkopp wrote:
>>
>>>> To me it is not relevant. If you would prefer the cosmetical roll back I can
>>>> send a new series.
>>>>
>>>> Do you?
>>>
>>> no - it's only low, so fine with me.
>>>
>>
>> If we would like to meet this Thursdays netdev PR and want to answer the
>> sashiko feedback before, when do you plan to send a net PR including the
>> other patches then?
> 
> Hopefully I'll find time in my vacation (which is this week) to do so :)

I feel you as I'm quasi on vacation for two years now :-D

It would be good to get the PR out so that we can at least catch the 
-rc2 train on Thursday as we did not get any fixes in for a month now.

Best regards,
Oliver

