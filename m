Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C284E323A;
	Thu,  1 Oct 2026 10:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790850553; cv=pass; b=JShvpjt9N6m76Edw/+hazfxxygHQx/oyVMDj5NTqnPQhtDPGmyaIMm5GSiCRsfK/P8EXJOCW+gVrjett70NyTwaaaqsEDIpvpAqGYlxCKJpSrsZyFR2pZDQYAB3IxG97MIyNFCsmorqCE4naYvEUh2RPHMxzhaxqSFClMV/U70Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790850553; c=relaxed/simple;
	bh=RQxW2qfK9ZTjzlW+LErzsDO8GNh/Nmjc10lOUeiEg+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tLlzKcQlmzfjam1RZhycOWCjv86lE+6XIPIo8Cxmyis1YJ0Csmn0QKfwEGEri/deRkHmO26TGUZ6rF3Hhz1XXQtEx3FHxz9vW+2x+8DiDb4G7LsHJj4KL5srrQJU/yGhCzo+I0pXiIbpL/rwWjA437q72xVxKYH9Nj5z8Id3suU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=szK0I9xO; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=bQ9nLA2h; arc=pass smtp.client-ip=85.215.255.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="szK0I9xO";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="bQ9nLA2h"
ARC-Seal: i=1; a=rsa-sha256; t=1790850529; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=B+bxIkxhLEr/IeF28Tmk2ZyGykquHOOEipKtdhOuNjNs0x/ZoFB0X4Y8vUR2sIR8F2
    W/fc11TJ77tYpqDdY7FjRV8M00BDI0OU9G/PqLGeKAZSUUF5mbh4s372Cp1JXbw84hb6
    CWWzhVrIhEgZUycJlSCDX8pQ00Yytscp3XYac+T9cniyPwX1EAawjXJLUf6sYo6l4XDE
    YGaDt0qT12VEG9/HLApbHMIo9NTUlMX0o/Y/9qjd8HDDdWPibxkyPUY8a/tGvK7NMYtB
    XyuPOxyZa8/sXdpMHPJVH+ch3wSYNx42+E+sLixzSsE431mx5GFbc8m7/ZpjM7uznVWu
    vAQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1790850529;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=NzeXNqilBP/PAIHeIbEaxjxhQaTNKCvBAgVE3wzT7nw=;
    b=gNv8jcwnbByYTU8j6fJk+KdPBT/nHidMQUcsRPhMRn9+fFG5dvPDlnYMZ+wfmW4+D7
    ZXvRYd0PM/GTn4N7IfwjeCXG21R/y4OYxYx3immpz8qFa7HpkUUKfM0eBmUzXMjQojHQ
    McYiZ44SUfEjekgMst9vFULTHkZi6kjG1l+MGHVrbtU2SQmhxeuceJ73m0zymQnOTITF
    KqI8wvu78OwkKTOwsSk7I7+mFnd1ZOVP0gMGvn5RNH4ha/wzFgBrrVEX3jmdynUzmu6O
    Wvv85tfg9vdMmJ8US+2T3tWSXiupLe5j9xbI8euo2AlV68GtcF0QPcac+PmBH2Gbn9l9
    YZLA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1790850529;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=NzeXNqilBP/PAIHeIbEaxjxhQaTNKCvBAgVE3wzT7nw=;
    b=szK0I9xOVZZT9Y7HGm9yjJnl/ceKS6AMj0kRJO8xGytgUK5LBEoo7f4WIkbB2Z5+AX
    eUmaw6dBPQICBId3QoJ0wmcq+I3bwvoZaWwUwS2GSCc3A42oKGltFBZETIt/ZdPv137K
    /vI9l4bTYzGy0f0FMnTipjfkT17ZhZypBrMXnpjDh4cYlJLr20JygLV4YAExRZ51e8TH
    /sgpaIjyT/AUrM5Vam/uZ8KB1T9vrWOR7Lp2AITEinThAN8TVtD3BN3kt4T0A2bA2OzG
    3DbiOXJZ9DtReWFA2CXD+mxQwyHbLbSb8NTWAhyklwUVmusbYhM0uKa/J6zpoRR5tN75
    cMZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1790850529;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=NzeXNqilBP/PAIHeIbEaxjxhQaTNKCvBAgVE3wzT7nw=;
    b=bQ9nLA2hpLQsYdTTFNcxiiqWZDcqY7v6KgtNLvOLAglt05WbIvYkCYgHYPeuC50din
    +GzKJm9ni+2yee1cc5DQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id K04b9a291ASmgiz
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 1 Oct 2026 12:28:48 +0200 (CEST)
Message-ID: <e4a05f3a-7206-4fe4-b04f-bf2a9f1fb926@hartkopp.net>
Date: Thu, 1 Oct 2026 12:28:48 +0200
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
 <cb83d0dc-58a4-4262-99a0-1e4478630ba0@hartkopp.net>
 <19ab3d46-f326-4f08-a161-d31ae272a9d8@redhat.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <19ab3d46-f326-4f08-a161-d31ae272a9d8@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 01.10.26 12:13, Paolo Abeni wrote:
> On 10/1/26 11:23, Oliver Hartkopp wrote:
>> On 01.10.26 10:40, Paolo Abeni wrote:
>>> On 9/29/26 22:43, Marc Kleine-Budde wrote:
>>>> this is a pull request of 16 patches for net/main.
>>>>
>>>> The first patch is by Vincent Mailhol and drops CAN-XL frames on non
>>>> CAN-XL devices.
>>>>
>>>> A patch by zjamg restores the skb header initialization lost during
>>>> the v7.0 release cycle.
>>>>
>>>> Oliver Hartkopp contributes 3 patches for the CAN net layer, the first
>>>> one fixes the net namespace integration for BCM, ISOTP and the CAN RAW
>>>> protocols. The second one converts the unreliable ARPHRD_CAN type
>>>> check to the robust can_get_ml_priv(). The third one fixes the unique
>>>> skb identifier regression under RPS, introduced in the v7.0 release
>>>> cycle, which causes lost packets.
>>>>
>>>> A patch by Joshua Crofts adds a missing
>>>> pm_runtime_dont_use_autosuspend() to the m_can_pci driver.
>>>>
>>>> Maximilian Zimmermann's patch for the xilinx CAN driver adds the
>>>> setting the ESI and BSR flags in the receive path if they are active.
>>>>
>>>> Jiale Yao's patch for the mcp251xfd driver rejects devices without
>>>> match data.
>>>>
>>>> Ji-Ze Hong fixes a struct size mismatch in the f81604 CAN driver.
>>>>
>>>> The next patch is by me, targets the gs_usb driver and adds
>>>> workarounds for the HScanT USB to CAN adapter.
>>>>
>>>> Cen Zhang fixes a slab-out-of-bounds read access in the kvaser_usb
>>>> driver.
>>>>
>>>> A patch by Stefan Günther targets the peak_usb driver and fixes the
>>>> CAN-ID when reporting CAN errors.
>>>>
>>>> Chris Strong contributes 2 patches, to fix an out of memory and packet
>>>> loss problem in the mcp251xfd CAN driver under sustained receive
>>>> traffic.
>>> Linus has started pushing back on the ever-increasing net RC PRs:
>>>
>>> https://lore.kernel.org/netdev/CAHk- 
>>> =wiSnTE9vBZ=5_v+3EEkdazCCbBM5YABRzRHUAeRdyd4Xw@mail.gmail.com/
>>>
>>> We are trying to defer things to 'next', especially this late
>>> in the cycle.
>>>
>>> I think there are a few patches here eligible for that. i.e.
>>>
>>> can: gs_usb: add workarounds for HScanT USB to CAN adapter
>>
>>
>>> can: remove CAN filters independent from namespace
>>> can: convert unreliable ARPHRD_CAN type checks to robust 
>>> can_get_ml_priv()
>>
>> I would be fine with those two patches.
>> There was unfortunately some new(!) feedback by sashiko-bot on the 
>  > namespace patch and the ml_priv patch is not that urgent.
> FTR I mentioned the HScanT patch because if feels more additional H/W
> enablement than a fix and is also quite largish/invasive. Feel free to
> disagree!

Btw. we need the

can: convert unreliable ARPHRD_CAN type checks to robust can_get_ml_priv()

patch as it is a prerequisite for the urgent

can: fix unique skb identifier regression under RPS

The ml_priv patch is not a big thing and intended for stable too.

> Also, not sure if it's already clear, but the main/more relevant sashiko
> instance for netdev is the nipa one:
> 
> https://netdev-ai.bots.linux.dev/sashiko/#
> 
> It uses more models, and cross-correlates among them and sashiko.dev
> feedback.

Ok. The review on Linux-CAN ML was done with

gemini/gemini-3.1-pro-preview

https://sashiko.dev/#/patchset/20260929163424.16382-1-socketcan%40hartkopp.net

While the PR netdev review was done by

bedrock/us.anthropic.claude-opus-5-5

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260929210700.1183036-1-mkl%40pengutronix.de

@Marc: Can we switch on Linux-CAN Patchwork to Claude Opus too?

Best regards,
Oliver

