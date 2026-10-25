Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=81.169.146.162
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792955826;
	b=Q5xAOZzYscV+aJCoK3CQVKlDLSZQKbSlcEUjrk1kk9mbvT+w4ztG2u0syGUUePeEqJ/P
	 E5hruZtjK4oxAUYoNgDtyOL0/VvnXOKZtLn/S5SVyWqSlXYekR5QhSQ8CsTlOa9ogxetK
	 VZqepuBrtaMmHQq2iQ6M0TQOUDIgAEl4R/cF2vqVARNHHH1Eb9Fje10rsiT+Jm36QvLKg
	 wZjMbCD1HNNww9JSD5sIUdqRTBSfRJE19PeUKA996Lk2iBCK4pMeDvU0467NUrKVDN+Am
	 2Lwy9MFRTqJ2DychQlHmycsrPp3PbMnF/0UF2lI08XvjNPnKvkipVLjp2584W4zhqjA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792955826;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=GGSA+KiaTozGul7GRoLVjXY0TQKMgDIoEuH7esSqChw=;
	b=txVdJwpnGqeOxrSZ/shKvulV3uh8ZcCwmdNrc7uAB041qv2a5DWW6FrWhoLcKuxwk94H
	 Y0MAPYLAQ/gXxU5qxHwJ5Ws7WbFtgu21YO1P9Wfa7TzaIxiiIGOz3+g03khWnDpVt3x9f
	 w4CDebjK9eC5YjFAwjqlpUuF+DUg4yvuE2Ekiiqomg2w10KI5HBLOwcX71gdHrwm93SJ2
	 bHa8fzRrczs1tGKOCpVKsOLUoY+SpOdiEy0pvYlBlFmbMHJLZwfqb+5dnQNx1g6N/fueN
	 CCV2IV3hMiYuywO60eHi630HuiuC0Yia399vOEMPhtMfRZUpDsQ9Pm4M9FuKY81zNZw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=PXJnaXGa;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=IyhXaKka;
	arc=fail smtp.remote-ip=81.169.146.162
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59C7606A31E
	for <linux-can@vger.kernel.org>; Sun, 25 Oct 2026 19:17:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E59C7606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=PXJnaXGa;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=IyhXaKka
ARC-Seal: i=1; a=rsa-sha256; t=1792955818; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=if2yGOcLTWI8mus9Ek3eSXe7I1Ma2CwV46E3DoA3zcH5a6q3viatZuQ7FfD3YAgOMS
    Bsa48gCbJO/pZT7U7xd+Simlgcv7QM0cr+oDIttIsmpRh4LMaVkYrjQcHOYwUQCnmg19
    k/sW0uauYrZOnVEKRMmHuw2AtgVmQu95hr1i7P24vSgJPWz+Y8AFb/NI8zzwb8s4rxBQ
    YEu3KKtz5TOn4H5/wFa/yBrbrgn6Pjvu3Dj6FNVdneHJqvJZZ1fzWHWHu9DL2+m20v7I
    Ys46c64eYItqtQV7btqXoBpAgo5PDatcWXya4exIFPRmDr22+bB0o4iopM2Ja/qTFHOG
    NZhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792955818;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=GGSA+KiaTozGul7GRoLVjXY0TQKMgDIoEuH7esSqChw=;
    b=qrGWKasK+TFidsmMIPlfWI7k7+l4A6utiT4I7jAmmuxgnDhTtdRtzW4vQF/Kkzcz5M
    nJuwyZYRKqfEHGfevLIYPQiDDaOqVV060wF0Lirc4ecSblNNyArioSUqpBVV/MMR1D49
    p8pcQuZudAamzenM90d0q25dcr3p5VPmM2SwoGB9YtE/vZaMP4YiSGJJtfLIZFtBmD0A
    WCPdzia1cawH1mEm4phofBf1nRaCsGsqUv6sUug6m/mYHzhCyxIXpXIia/mHwjJscXjn
    Im09OiTSiZH5oYmQeaeDt5cc6PfZWqUw+Ug8AStBldx4v40Y03W0ppsNPSGyEOk+HYC0
    0AHA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792955818;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=GGSA+KiaTozGul7GRoLVjXY0TQKMgDIoEuH7esSqChw=;
    b=PXJnaXGaCjZv19diGAnO4xovt6xY7/t8lNtrUnjUzRzBaDIbs2sdiYw5K4vu00ekA4
    RLtiZVq15U3D8DiIqABrU0bVNvKq+auit7RDZzUjaKeUP67Z2gT4UN+CTlE8elH2lJkw
    asAiEDcYtOE9tA7thEIc437s8qhPSlWHociP8GeQUJ4PxYgWEfDCPRINCkbMxxL1+aZa
    vxsREQ77FJFkWt6wq79NlUvhBo4H30pmAcs/Sdrcx4g8x10IEHRJCTWnap3xVm02ENTV
    iVnqfMcsu4F3ZIHMMpDNPhcFSVWr0VQXH9o5TV5B3ApoOa1Oy7HnMbxHq3+Nn7qXcBy2
    +gNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792955818;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=GGSA+KiaTozGul7GRoLVjXY0TQKMgDIoEuH7esSqChw=;
    b=IyhXaKkaKC0tzGkk4HZQrlg5klnZkBOCEgXc+lskpRP6agyEEMotwRVJ6bZYsgzqO/
    CTn+n1ogSNZ+S1Xtp9DQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29PJGwywo
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 25 Oct 2026 20:16:58 +0100 (CET)
Message-ID: <6421fcb8-beb0-4d42-b94c-6c936af3d7cd@hartkopp.net>
Date: Sun, 25 Oct 2026 20:16:58 +0100
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
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20261025-unstoppable-valiant-woodpecker-20c6dd-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 25.10.26 20:06, Marc Kleine-Budde wrote:
> On 25.10.2026 19:55:11, Oliver Hartkopp wrote:
>>
>>
>> On 25.10.26 12:28, Marc Kleine-Budde wrote:
>>> On 23.10.2026 14:17:54, Oliver Hartkopp wrote:
>>>> This series fixes a use-after-free in CAN_ISOTP and CAN_BCM that can be
>>>> triggered when a CAN device is moved to another network namespace while
>>>> a socket bound to this device is released [1].
>>>
>>> This series doesn't apply to net-next/main, probably as it's based on
>>> https://lore.kernel.org/all/20260831052031.902699-1-ekffu200098@gmail.com/
>>> Sashiko fails and you'll get no review feedback.
>>>
>>> "b4" has a feature to track dependencies and put annotations into the
>>> series. Please consider switching to b4 and use "b4 prep --edit-deps" to
>>> track dependencies.
>>
>> Good idea. But it does not help for my current problem:
>>
>> https://lore.kernel.org/linux-can/bd31fd1b-1fe7-44a5-99ee-635262a1ed33@hartkopp.net/
>>
>> Against which tree should I post the patches?
> 
> Does this work?
> 
> base-commit: net-next/main
> message-id: <20260831052031.902699-1-ekffu200098@gmail.com>

Ah, I see what you are aiming for.

But net-next does not have the required "can: raw: remove redundant NULL 
check before netdev_hold()" commit.

Or did you intend

base-commit: linux-can-next/main
message-id: <20260831052031.902699-1-ekffu200098@gmail.com>

??

Best regards,
Oliver

