Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E8D372056
	for <linux-can@vger.kernel.org>; Fri, 16 Oct 2026 10:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792144954; cv=pass; b=n/tT3sb1cOrzOgwuM6qXd8eCApNixWFBjq2K81Gg3T2eF6OKA6Qz/6CM+2nWpOpogycr098sThn2CWk8JC+v0go6cnoA1QZI1fJ0KUnf1EA02qin1JFkHuU6IaBF1r2mij2Dh6UbZ2k4S2layEe0xhkcGYzyiWzF0rlbPgnOkHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792144954; c=relaxed/simple;
	bh=cjGR03b7bOGd50KvPLpOFJnmfMCo6/4yLjqcH0durGI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tx+4Ladgf7/D25k7hpGZyrpKVrVZuIVNQFhisJ/ZW/YWIaLJA6Nw++klcEysx350df9Orcbzq81s7KnXpaAuYFBkAL8Un4fA+1NHIKsDFq2BRnwQMqSUGnWuOkjZRhtc/IVda+vgJDTEvcQIvzhsQGpKBTyF2qe0YWH5GdaAgHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=N8Uvka7l; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=yFDhyy0M; arc=pass smtp.client-ip=85.215.255.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="N8Uvka7l";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="yFDhyy0M"
ARC-Seal: i=1; a=rsa-sha256; t=1792144926; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=UL5Q5dqDBtcP37JKTxujfzIbFMupXPgfhBhaYrE7O/HKJ+wPe1I7Un/jGeabfvFtBV
    +rwDGP3vih/UlPHZCSCbWhJF3P72/g4eBG6gQYeOL03V6qG1Ad98kurLHPZl6AmFDzJh
    QPbSmdcyTUpnTFqyBkTFEVgfD0iUj5etE6PSmXQUVfZ0S/NqSIpIc/5QnpdMHmwmimAu
    tUtJYS/3sHxtZ91f6+HjEmHBkS0AkvD9YpwrR8jThOB4wyEs5ef+nTSuyLdxkfdBrHhL
    rXNRGSGKRV8w+ufFlIuWOMXpKqWo2QeTJv28YKLyBtxb7/TL0NBYAJmpqP/F9Vyf1VIz
    17DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792144926;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=rDlPpzWzUAAlcDs9R1pOREdvWvP85Tf9fktOSGumWHA=;
    b=RLPoFmp/q0x38wTpIfEH9d73B8WD6xoq0DSyQLS1r3rmXEsn+UEf9XvlYB7lHQR2IA
    MpI1tEt51dbdFlT+JQtVaWSluzjEiFd7fUhit+rTKjXErL+cgCMv5GX2hqWlMBYRd1AC
    cqtrPO1SwfaQDTjNUiq0t8yk+avMu0uCfyY7pzqFjW1Eoz4q4KSih/PLBFgLSK8KDd47
    VCal06lq+hCquNFKj+ZYW86VPwmnNT1wYgwxUj2sTyxG4xPjKZN/tgtLryqisoXSo9Rr
    MeESLmhO/wpx30Yvu746eHDtETjU25vJ2w8FcwiLT6iU77LzDvCuVbYh1xDHSlUvJpDM
    jkAw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792144926;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=rDlPpzWzUAAlcDs9R1pOREdvWvP85Tf9fktOSGumWHA=;
    b=N8Uvka7l9BmjSI5JLunWlWZdg+SV8mwJE6QplGRVc5Xh+u1FKnTtVCB5DOj/Zuo2pN
    12musSrjSTn5zvpm+Dle7g9m69WNOP0ftig/OAu7taUiMoB2c4kTzfbsrxqjmAytQ0Ix
    7sIibOiB25q/h5aET+Si+QgWPbuRMySfVdDRDtBQP94bRgwMdS5ZehJ494PTyaHJk72p
    7B+ugvtn+8nrCpLpxSle2itlXAX3y2pjf45mi4VioLT8rMtHvgJXe8AV1Xg2pfRXL0YZ
    Xj3TJqJaHI82UAK9EaOByenVxZkcd4LGgq41o2P6JTRaSwu6TlhVD5D+YpVq20xg1vrx
    hG/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792144926;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=rDlPpzWzUAAlcDs9R1pOREdvWvP85Tf9fktOSGumWHA=;
    b=yFDhyy0Mt4eBePaFYLiMkV0QKDkmYcVn0A29lCZg8KqUXV7JKeMmvgD3gsE8rTeKjc
    uCUUo7GB9cbXL8yEQMBw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29GA26LaZ
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 16 Oct 2026 12:02:06 +0200 (CEST)
Message-ID: <e71563e4-2d8d-4302-a9d1-b0dc34fea3a1@hartkopp.net>
Date: Fri, 16 Oct 2026 12:02:06 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH can-next v2] can: replace ARPHRD_CAN type checks with
 can_get_ml_priv()
To: sashiko-reviews@lists.linux.dev, linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>
References: <20261016093525.327367-1-socketcan@hartkopp.net>
 <sashiko-outbox-174104@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <sashiko-outbox-174104@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 16.10.26 11:50, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] can: isotp: silent bind() failure if can_rx_register() returns -ENOMEM
> --
> 
> commit 95cbcd2505f7f236f0737cc7471505243facbfe5
> Author: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> can: replace ARPHRD_CAN type checks with can_get_ml_priv()
> 
> This commit replaces explicit ARPHRD_CAN hardware type checks with
> can_get_ml_priv() to prevent NULL pointer dereferences when a TUN/TAP
> device is repurposed to mimic a CAN device.
> 
> Link: https://patch.msgid.link/20261012164802.94113-1-socketcan@hartkopp.net
> 
>> diff --git a/net/can/isotp.c b/net/can/isotp.c
>> index f5dc9d04bd686..6c28802c0605f 100644
>> --- a/net/can/isotp.c
>> +++ b/net/can/isotp.c
>> @@ -1610,7 +1611,7 @@ static int isotp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int l
>>   		err = -ENODEV;
>>   		goto out;
>>   	}
>> -	if (dev->type != ARPHRD_CAN) {
>> +	if (!can_get_ml_priv(dev)) {
>>   		err = -ENODEV;
>>   		goto out_put_dev;
>>   	}
> 
> [Severity: Medium]
> A few lines lower in isotp_bind(), the return values of can_rx_register()
> are ignored:
> 
> 	if (isotp_register_rxid(so))
> 		can_rx_register(net, dev, rx_id, SINGLE_MASK(rx_id),
> 				isotp_rcv, sk, "isotp", sk);
> 
> 	/* no consecutive frame echo skb in flight */
> 	WRITE_ONCE(so->cfecho, 0);
> 
> 	/* register for echo skb's */
> 	can_rx_register(net, dev, tx_id, SINGLE_MASK(tx_id),
> 			isotp_rcv_echo, sk, "isotpe", sk);
> 
> If can_rx_register() fails (for example, returning -ENOMEM due to a failed
> kmem_cache_alloc()), bind() will succeed but the socket is not fully
> registered to receive CAN frames. This leads to a silent failure where
> user-space believes the socket is successfully bound, but no traffic will
> ever be received.
> 
> Could this regression be prevented by checking the return values and
> propagating the error appropriately, or cleaning up any partial
> registrations?
> 
When this patch is applied isotp_bind() can only fail with -ENOMEM and 
nothing breaks. The socket just becomes unusable. And if we have -ENOMEM 
we have a big problem anyway.

If I would provide such a patch the proc pointer removal patch would 
break next.

I have ~20 patches for isotp and its CAN XL support. I will add the 
isotp_bind() error handling there when these current (can-next) fixes 
are in mainline.

Best regards,
Oliver
