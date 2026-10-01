Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF0E4F93D0;
	Thu,  1 Oct 2026 09:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790846616; cv=pass; b=cIW4w6CC1XjJYikGwSQi65/PEt+6x3RfL1AjobDO8FwCQEWky+8Uf1nushQzdKUJn7b5tlBgpPtG7oQoqFsH8LDXpohdac92sl2g0C3+PL4aYBConfIEYEIyL/LRQOqHpeNbZP1wmYTDCgpgOEUjmtJWauTnFxtXswgFF6gIixc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790846616; c=relaxed/simple;
	bh=uXz06xG8AGFlhl8QdbP6ubMQBsrBTy82UncVvrfZ/Sc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Myz7qfQBUNpKW4reTe8XLhSKTDntmQNOX2vVTT5JrRFn81K7+1zFkXNPO8hSthEz12AuScUL8QjqZInaQMt3kt8ci+upXH/lCkzbwAXQwJPLrNR9JhDomxX8FN3OyfV1aaAgG6tWmPvDOkC872620Yahe9Dhm0Y3B/Q9b67oDMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=RXpzIR5N; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=P0A+ThxM; arc=pass smtp.client-ip=81.169.146.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="RXpzIR5N";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="P0A+ThxM"
ARC-Seal: i=1; a=rsa-sha256; t=1790846592; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=VU7naCXCb5pyJcB6TM2YeJLZw7uG9n6IjXxivy22LuSy/pXjz3ekCsNXYtZK/FMosZ
    bLT+imdlAVoAh41xL+9VNXPM4sY6e1PjG0KZD0ueTIzIQXhb9NYOe9IyuLmib33ROPCe
    zvzkx6bSp3YYxcHbpZx+nh5o5mFhBSW1WdPvGkCHeKeMS0XZQJYMVoSzPoUVhn42FVd2
    pafUeAu5A1E024ee7G58dCYycG/lWS1bv4le5pGtuzD2C9H7cZ78yuyLlvulGT6RmDuy
    yvooUi9OeoUJCgaJvYi6hmuaW+7qRJVxi4oOLWkj/smMXhZyg5a4yEAE2BzzdZnPK+WW
    rFNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1790846592;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=YrNRnCjkjXbRg1JmZz7Nqw66nkRndh2mIE9HFNpd+N8=;
    b=nLwkonWqFWSLi2M/fzQwFNwgomfOU/u615Ac+jefyywOYDlyPwMM6NJCrI+hEYrsyj
    gFIGtSOkvMG3YHz7a0nd7H3LyKKr6SzUB1mbCIY11Sslu4gjf5fAnp1dXaFduBR1UQrF
    saNLb6/aipV1tYRycHSdAqeq4/NtHMvtPGbu8UcGkfJ179dHmtfVy3fioW2d9R0xWnsH
    iUeTvabKdcSbROtF8rkBKhLgBbpH90Z6ll8sn5HapMcgviVDIDAdq/7dpL5RF9kqxfKJ
    TntPyM9hUthwe0xNAC7waOf1qKtenoUlE152VnJUleQcPTy2BQ9hIIjb2i8lcyOabYZs
    5ncQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1790846592;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=YrNRnCjkjXbRg1JmZz7Nqw66nkRndh2mIE9HFNpd+N8=;
    b=RXpzIR5NVpLLORDG4vYHRndB6ZO+pRXlscFRKP6khIBxVqVGZEFM4lVkQrl5Gtyymp
    Q5OIz1mdpiAcxhp7X1xmFZxbksSuNd+913hg6YZ5YAd5Uxkcdhsleup2ph0R6Gi2hWGq
    yFznQhYJJYl3ApEIQ2PMq0lBH2dHPGrLMMKt2d6JsD8LdGp6dOYNhz+5W1VcSrrLOhUF
    ZTlIGdOYP0Y4hXMW5XURNgP1j/oAymK/e+Fa3YMuZcBTAUs4bOFDH9VE7plGNhTLA0+H
    /tAS5aJ3zYZ8CQlAx/oa0FToNJztfZyNAojZsOrkgDY0mnnNuK6o9vl8AaV10Q+PV677
    RJIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1790846592;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=YrNRnCjkjXbRg1JmZz7Nqw66nkRndh2mIE9HFNpd+N8=;
    b=P0A+ThxMDn17eRy3H8Suw81Cjovp6VPF2XmLBw9c27m6ydxLpoRoMZfHk8MY3oRcrm
    Q16moYgn5E8RNSO4SvCg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4Kp38="
Received: from [192.168.20.217]
    by smtp.strato.de (RZmta 55.6.2 SBL|AUTH)
    with ESMTPSA id K04b9a2919NBfMg
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 1 Oct 2026 11:23:11 +0200 (CEST)
Message-ID: <cb83d0dc-58a4-4262-99a0-1e4478630ba0@hartkopp.net>
Date: Thu, 1 Oct 2026 11:23:07 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/16] pull-request: can 2026-09-29
To: Paolo Abeni <pabeni@redhat.com>, Marc Kleine-Budde <mkl@pengutronix.de>,
 netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
 kernel@pengutronix.de
References: <20260929210700.1183036-1-mkl@pengutronix.de>
 <9956662e-6001-413d-864d-d8d048a93819@redhat.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <9956662e-6001-413d-864d-d8d048a93819@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 01.10.26 10:40, Paolo Abeni wrote:
> Hi,
> 
> On 9/29/26 22:43, Marc Kleine-Budde wrote:
>> this is a pull request of 16 patches for net/main.
>>
>> The first patch is by Vincent Mailhol and drops CAN-XL frames on non
>> CAN-XL devices.
>>
>> A patch by zjamg restores the skb header initialization lost during
>> the v7.0 release cycle.
>>
>> Oliver Hartkopp contributes 3 patches for the CAN net layer, the first
>> one fixes the net namespace integration for BCM, ISOTP and the CAN RAW
>> protocols. The second one converts the unreliable ARPHRD_CAN type
>> check to the robust can_get_ml_priv(). The third one fixes the unique
>> skb identifier regression under RPS, introduced in the v7.0 release
>> cycle, which causes lost packets.
>>
>> A patch by Joshua Crofts adds a missing
>> pm_runtime_dont_use_autosuspend() to the m_can_pci driver.
>>
>> Maximilian Zimmermann's patch for the xilinx CAN driver adds the
>> setting the ESI and BSR flags in the receive path if they are active.
>>
>> Jiale Yao's patch for the mcp251xfd driver rejects devices without
>> match data.
>>
>> Ji-Ze Hong fixes a struct size mismatch in the f81604 CAN driver.
>>
>> The next patch is by me, targets the gs_usb driver and adds
>> workarounds for the HScanT USB to CAN adapter.
>>
>> Cen Zhang fixes a slab-out-of-bounds read access in the kvaser_usb
>> driver.
>>
>> A patch by Stefan Günther targets the peak_usb driver and fixes the
>> CAN-ID when reporting CAN errors.
>>
>> Chris Strong contributes 2 patches, to fix an out of memory and packet
>> loss problem in the mcp251xfd CAN driver under sustained receive
>> traffic.
> Linus has started pushing back on the ever-increasing net RC PRs:
> 
> https://lore.kernel.org/netdev/CAHk- 
> =wiSnTE9vBZ=5_v+3EEkdazCCbBM5YABRzRHUAeRdyd4Xw@mail.gmail.com/
> 
> We are trying to defer things to 'next', especially this late
> in the cycle.
> 
> I think there are a few patches here eligible for that. i.e.
> 
> can: gs_usb: add workarounds for HScanT USB to CAN adapter


> can: remove CAN filters independent from namespace
> can: convert unreliable ARPHRD_CAN type checks to robust can_get_ml_priv()

I would be fine with those two patches.
There was unfortunately some new(!) feedback by sashiko-bot on the 
namespace patch and the ml_priv patch is not that urgent.

> 
> WDYT? How much a pain would be shrinking this PR?
> 
> Thanks,
> 
> Paolo
> 
> 

Best regards,
Oliver

