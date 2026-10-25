Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.218
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792954527;
	b=ncdgx8izKrrw3Ns46coMS31J8l980i6DKWym5sxknCfzjP6bFzW87JqJLi78Z2t040Bq
	 QaH7knnfFOyghTu1nrHPp6boS8oilQqVHYMBWbvnlQlwyV8wGXoxhHADJ0ZipU8/bJbwM
	 HaWw4I1w2hI7xY1fWA2yw4n9ECWCgs4JSaGtUkhqftMqBTMK1wcs8FBK5rsK+dW190Bag
	 9pL4THRQokYan9t+U1gceIWgAdY1CnOf+g205uHRy9vrO3bVRTmmr4QsgNWFfhBjUpWS3
	 OZLkyrtl0H4qWuE+5fLO+9YmfeInD5fIseDrC2SLhU60LpULFFV/rNc4lX57s/8aHNg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792954527;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Br0EmF3297wXZdSB2OyjUxUMIFYv12Q4TJ6otdZwTZ4=;
	b=vC1nQz8KHOqBaglmTlWxXnCggqyimHX52EgTFWwREFNKzkK2JI85OBPqzHA2u6Ii4Bl/
	 3zOFfYPLzCY+lvkjx1NA8eGWnR9Z103SQ5WMINvq5b0znvrG+nil6NPbkh8cGC3dvD03Z
	 qJ2a5fBKqjwgbstgd5qah2SC+812deit4P+OUS0Oqn+c+JX9pMFLm19+QtX/LKJXP8h9H
	 u2Ml5/8GAhTsFs4lstBaTUPkrsHcS94bGWGmoOS63odQcWc9Otk/3tZJFF+oBxikmMbmX
	 6AxX8gkwUZJiniD+Jy3WnUr1wZ9LYLMFj8TDwAb9KyzuO1v+1Uh+JSUuSKXBbDCTPvQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=evDFs1jM;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=fN24eY35;
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.218
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BFB606A31E
	for <linux-can@vger.kernel.org>; Sun, 25 Oct 2026 18:55:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8BFB606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=evDFs1jM;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=fN24eY35
ARC-Seal: i=1; a=rsa-sha256; t=1792954516; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=UfQnGVW4x/CMXPXlIpUCBx1CBofSveUAcSrKOgr4mD5CYGqII+F8Kq25uuMGe3ntXL
    RUwoGsdRu66wRda7Y5kpQUmS5Sxb61oywq+pukDwE4KRmThaM9Qc8qxtX+UnUTh6eo4B
    I8gf7kCVBGUoLsbNxFcZC4lK3FzpLSGMHhm+USctWhgnuUFUWz2KCE6EVkOF69l8qbzO
    Z2bLYRVRFWOwrwsAKJVtsA2p0yWo3Rjc5ef1m9nT/bdAcNEzzWjjDNrSFiRj5oSpq4kr
    6Xsn6l3WsFNryCKDD7E0p6CQATKF5LZuXoeBbeQJQZrzxgRkn6PpXWe4R9KXBzv3vA+D
    0Zlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792954516;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Br0EmF3297wXZdSB2OyjUxUMIFYv12Q4TJ6otdZwTZ4=;
    b=qDLc+IxYBXF2rOHXFIsTxq5QzvDu2ycMvGUrSB2Tq4qfJO7gsZJxf1oTKJ5umFT7fT
    ROG/yOfdc9iX3Hlu+VGk+bB68CNpHwTZm0FUqepS7jyfETUEggY1j6ilrl2h+kN6G/4h
    FXRNyMn3urSF8q/c7SaC56nVWnBIvsnIcrumyGTtmgrgcM+Ni/XX5P88K1UBDVFT9oFx
    cK9pVnQhO6JS6ylpZXvHXCVie521tyzSasfTsCnL04Fyi682xNXopJbTQNHLqu8h0ecQ
    XDhv0L/iTGOyxmNJhlftSS6hBcBq7s2egxrfqwu3RqSSg9S2RKZTGCShSZdStnKzV6E3
    2gfQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792954516;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Br0EmF3297wXZdSB2OyjUxUMIFYv12Q4TJ6otdZwTZ4=;
    b=evDFs1jMTO9IOyJAkkQKBre/4mcd8rkktXzku80BRBH8iTaL0foTW+aMvIYxVPJrzg
    xozRj8XXPQMIVdnnsq+3jcOFKQLyK6fPAhhzSQ+4VHw4EPR/5JN9rnrPh/qfT4V5li9W
    Pn2b9rnp6sd3iTi/4KiOEaTpo+A4zq2PYv7tymD7vnM5TjOmQOUdHOn5hL85VVJSlqjP
    qFFUkv6PEurZNaPDuvBNlN6NbrKzH4SoxHzT3OfIwSXCcoCjbETFCzhe5U1kpOb5NTiE
    +5rZ5fB/lCe5xV0TgBqN6KjQETJxGWT3qNFe83SK42lgy9HF15vhQK+XIvTmun3ioNHv
    7rgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792954516;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Br0EmF3297wXZdSB2OyjUxUMIFYv12Q4TJ6otdZwTZ4=;
    b=fN24eY35SKDMMInKV4DfrE3ssRVwxyV0MNpZbPOwxP4bz5xyPdDouUS+I3PVD3NxLa
    nzRG1vv7CkumwP2QJHBg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29PItGytW
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 25 Oct 2026 19:55:16 +0100 (CET)
Message-ID: <ee27f899-0ac1-4059-ac74-e4ddaab61b0c@hartkopp.net>
Date: Sun, 25 Oct 2026 19:55:11 +0100
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
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20261025-pompous-mahogany-koala-f18498-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 25.10.26 12:28, Marc Kleine-Budde wrote:
> On 23.10.2026 14:17:54, Oliver Hartkopp wrote:
>> This series fixes a use-after-free in CAN_ISOTP and CAN_BCM that can be
>> triggered when a CAN device is moved to another network namespace while
>> a socket bound to this device is released [1].
> 
> This series doesn't apply to net-next/main, probably as it's based on
> https://lore.kernel.org/all/20260831052031.902699-1-ekffu200098@gmail.com/
> Sashiko fails and you'll get no review feedback.
> 
> "b4" has a feature to track dependencies and put annotations into the
> series. Please consider switching to b4 and use "b4 prep --edit-deps" to
> track dependencies.

Good idea. But it does not help for my current problem:

https://lore.kernel.org/linux-can/bd31fd1b-1fe7-44a5-99ee-635262a1ed33@hartkopp.net/

Against which tree should I post the patches?

Best regards,
Oliver

