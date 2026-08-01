Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CAC2ECD32
	for <linux-can@vger.kernel.org>; Sat,  1 Aug 2026 08:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.218
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785572302; cv=pass; b=IQ8JOOMtosAcCXOk2NGqnq2KHTiLJ3/HDGOGSj3Q7UYJptou1FhMsJnQe6uzjGPo3Y7UTGmhVLVPBO759HVHWXqlmke9nIREuReyJNN5YIaPvuO4tiNJYw+iaBy0uMl+wUSjr2MgafAcBOqSx/+35RQdUGLo9hQx5lj83OmZr60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785572302; c=relaxed/simple;
	bh=n2iNb42lmW71fTbBEa0+d7FMOSDGJxaHQlHxUh7L/bk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dVcSOCg48gIkR1RAWsGmweGcAVvl1BPwRCzn7mDvZPc71sfYEuBGNIKDOptt6TByZDmYxUBwbSYNldSG24FX+Y/WWJe7Lu6Jwc37vfPT03oBmFwPWkwtHK7vu9Ak4jzsj485Y1DiOR3JqMKAMWTg4CYfS80fSl8CDLz30wSIvI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=QMiOP/o+; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=2IHf4+84; arc=pass smtp.client-ip=81.169.146.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="QMiOP/o+";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="2IHf4+84"
ARC-Seal: i=1; a=rsa-sha256; t=1785572291; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=g0byZn5xyMrWShEeZ32Qts9rITA9W81HQB/SBRA3Cgw2SFMbxaUyPkpk8YSKAmO1EG
    09irRkwIMh8z7xSB3zldHvyppWzFJuSfSeo/eNuJi28ObG8lxMH7cAMuSG3RN1Vj+7DL
    aUU6WLXbSnwe23NWsCPttzI2kc0EZkAxiJPZ+8eTp6q7WgArxvHwNR7w1VArxuXFukZ4
    tS53GB4KT8FXKSy9L8/xycJD/TzVCmbJKA9TmmbC4Lqu7KFZt72hFiQ8K4aJPmvHwVlc
    WJoV3RlYUK+KrpBLe6LoreJB8/g4gn+m/3RtQuMJ0u8Fij3dLHYj9lxYVJP6YKse8Jmr
    NRdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1785572291;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=UzFY907uNcf6cMJlWc5IWHFja+Y78bUMwJOMUf/yOsA=;
    b=KT07LpuwTt2nxUBx2bpyZLN3yAGtXcm/qsoCZD37H3d+nEUyodnEi7iSOh0rbalPIs
    65TkvE40DkYgudeWqr9mQHGTajFiVcCskkYmRSX5OVL/my+rlR188m++UVXQrjVDZWDs
    bEt1eCM31wXE36bA3jdm9cAH5EJ0nIDk4RwrgObxQJ5lQpVywnXXc/H+aGi9B/qHS4uk
    3ixxp35xE+wE7IubENdOrpktENFZ+/Fpme+EP2x5mKspH06KqPrFx2X+kYxu0xSyGiAH
    UXGm6RccTgpdpcatgCg8Yr55d4sNvvvM8Rm9Md0Ysi4TgXxq04g7sbnDvSQN5welCfTL
    yZTg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1785572291;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=UzFY907uNcf6cMJlWc5IWHFja+Y78bUMwJOMUf/yOsA=;
    b=QMiOP/o+vA4QErC39/qREX02IIZKMF7kfNyc0quMTZyXjoPbm9leuvJ4NJ1SMnwoZj
    EzseoVZbzMtPpnwXb8v3cKVIXTpEggLZWgSAw7UEL80lw9dP1Prhqqx32VbZ43voY585
    qk3B+abnEe/tP7Js4dlItwhKlTRRdCAii5PHCGMHNE8JnrXe4XmO4rnC1m09vD792ryz
    lET8EGQXj7YNFiL+SudvgIDh0KXeO6TqgEDbRJVEEFlIYaPLAsAOLolceAvUWVulu4QJ
    UnlOAv7nB7Iq3JHc5r/coFh59tqsmiywCdEFzYAXy8t3CQaq97NWK8nuX7KUn+1/dukm
    KAmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1785572291;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=UzFY907uNcf6cMJlWc5IWHFja+Y78bUMwJOMUf/yOsA=;
    b=2IHf4+84xXkqWiRuxTA0n+rArVx9g8c07IzXwV0cOK5vEOP79UA+IoSK/NcpWOmjci
    xiy3GuZdRQ/WdEaemlAQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from [192.168.20.231]
    by smtp.strato.de (RZmta 55.5.6 DYNA|AUTH)
    with ESMTPSA id K528192718IAhWH
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 1 Aug 2026 10:18:10 +0200 (CEST)
Message-ID: <ac22b59e-129b-4883-b9c6-da5e69e4078d@hartkopp.net>
Date: Sat, 1 Aug 2026 10:18:05 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: dev: can_dropped_invalid_skb: drop CAN XL frames on
 non-CAN XL devices
To: sashiko-reviews@lists.linux.dev, Vincent Mailhol <mailhol@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, linux-can@vger.kernel.org,
 Marc Kleine-Budde <mkl@pengutronix.de>
References: <20260731-drop_canxl_frames-v1-1-7387b70353b3@kernel.org>
 <20260731164529.500821F00AC4@smtp.kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260731164529.500821F00AC4@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 31.07.26 18:45, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] `can_skb_init_valid()` directly modifies `skb->data` without checking if the SKB is cloned or shared, violating SKB shared buffer rules and causing data corruption.
> --
> 
> --- Patch [1]: [PATCH] can: dev: can_dropped_invalid_skb: drop CAN XL frames on non-CAN XL devices ---
> commit 4602c4bbb604b601116708346040725e0603f25d
> Author: Vincent Mailhol <mailhol@kernel.org>
> 
> can: dev: can_dropped_invalid_skb: drop CAN XL frames on non-CAN XL devices
> 
> Sending a PF_PACKET bypasses the CAN framework logic and can directly
> reach a CAN driver's xmit() function. The PF_PACKET framework only
> checks that skb->len does not exceed the net_device MTU.
> 
> For a CAN device that is not CAN XL capable, anything above CANFD_MTU
> (72 bytes) is therefore dropped before it reaches the driver. However,
> CAN XL frames are variable length. can_is_canxl_skb() accepts lengths in
> the range CANXL_HDR_SIZE + CANXL_MIN_DLEN up to CANXL_MTU, i.e. 13 to
> 2060 bytes.
> 
> As a result, an ETH_P_CANXL skb with a length between 13 and 72 bytes
> can pass both the MTU and the can_dropped_invalid_skb() checks.
> 
> A driver that does not support CAN XL will interpret canxl_frame->flags
> as a length because of the overlap with can_frame->len. And because
> CANXL_XLF is set, the resulting length is between 128 and 255. For
> drivers that do not check can_frame->len before copying can_frame->data,
> as most drivers do, this results in a buffer overflow of up to 247
> bytes.
> 
> Drop ETH_P_CANXL skbs if the device does not have the CAN_CAP_XL
> capability. Keep can_is_canxl_skb() for the validation of CAN XL skbs.
> 
> Closes: https://sashiko.dev/#/patchset/20260731-master-v5-0-5b27029dee20@qq.com?part=1
> Fixes: fb08cba12b52 ("can: canxl: update CAN infrastructure for CAN XL frames")
> 
>> diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
>> index 95fcdc1026f80..4f7a189de265d 100644
>> --- a/drivers/net/can/dev/skb.c
>> +++ b/drivers/net/can/dev/skb.c
> 
> [ ... ]
> 
>> @@ -384,7 +385,7 @@ bool can_dropped_invalid_skb(struct net_device *dev, struct sk_buff *skb)
>>   		break;
>>   
>>   	case ETH_P_CANXL:
>> -		if (!can_is_canxl_skb(skb))
>> +		if (!can_cap_enabled(dev, CAN_CAP_XL) || !can_is_canxl_skb(skb))
>>   			goto inval_skb;
>>   		break;
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but looking at can_skb_init_valid()
> which is called right after this switch statement:
> 
> drivers/net/can/dev/skb.c:can_skb_init_valid() {
>      ...
> 		/* set CANFD_FDF flag for CAN FD frames */
> 		if (can_is_canfd_skb(skb)) {
> 			struct canfd_frame *cfd;
> 
> 			cfd = (struct canfd_frame *)skb->data;
> 			cfd->flags |= CANFD_FDF;
> 		}
>      ...
> }
> 
> Can this modification of skb->data happen without ensuring exclusive ownership
> via skb_unshare() or skb_cow_head()?
> 
> If a local user constructs a linear CANFD packet via AF_PACKET, which is then
> cloned (e.g., via TC mirred or BPF redirect) and queued to a CAN interface, it
> seems can_skb_init_valid() will directly modify cfd->flags in the shared data
> buffer.
> 
> Since the network core's validate_xmit_skb() does not unclone an already-linear
> SKB, could this corrupt other users of the same buffer data and lead to silent
> data corruption in unrelated code paths?
> 

The finding about can_skb_init_valid() modifying skb->data on a 
potentially shared buffer is not relevant for this (correct) patch.

The FDF-flag write in can_skb_init_valid() only matters for PF_PACKET 
use: PF_CAN allocators already set CANFD_FDF. The write exists to 
normalize frames for PF_PACKET observers (tcpdump/Wireshark) so they can 
distinguish classic CAN from CAN FD at the netdev level, and to 
compensate for PF_PACKET senders that omit the bit. That normalization 
is functionally required.

The shared-buffer concern only becomes realistic through a specific 
chain: a PF_PACKET sender injects a CANFD-sized frame, the CAN driver's 
loopback puts an echo skb back into can_rcv(), and cgw (without 
modfuncs) clones it for forwarding to another interface. Only on that 
second can_skb_init_valid() call is the skb cloned. By then the bit was 
already set on the exclusive skb during the initial xmit path, so the 
flags |= CANFD_FDF write is strictly idempotent for any parallel 
consumer of the shared buffer — no memory-safety or 
information-disclosure consequence. It's a formal violation of the skb 
sharing rules without an observable effect, so the current code can stay 
as-is.

Best regards,
Oliver

