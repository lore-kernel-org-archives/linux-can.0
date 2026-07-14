Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B5936896D
	for <linux-can@vger.kernel.org>; Tue, 14 Jul 2026 10:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784025297; cv=pass; b=Km6k9ndUrssVrlzYndzKT6pYMyFl7PBRN7Z8FlAR4w8Zepg20U/+9HoAi8wa50hNqeIW9KaZzW5FxXYb5G8cug5Xkl41z7xNcYD8+1rwzVwrkn5AeBfw11bAzCe5h7b9XJoA6hgANQaWDJ8fC2AslLV59joxNMsSYfg/LxxfMFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784025297; c=relaxed/simple;
	bh=AAEcFQGtcecLchFvTm2ISgteLPexJXdaqPYKWPw44LU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FRCrkFKZEO7eMauRC8Xh7jB0g82gzbdgwILbXknolp9Res31dd0If+HosUiUCtMv1glGeHc9iRzkso28jajtslbbh5qWxqDejRvTvTaFM0frTFqzK5Q2E4n2h8Bp7nEWdlkneI9yBmkXyegHHEM2mTWXweaVaEdgquxi3NICYYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=VDkso9Rw; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=s+SpujTx; arc=pass smtp.client-ip=81.169.146.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="VDkso9Rw";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="s+SpujTx"
ARC-Seal: i=1; a=rsa-sha256; t=1784025287; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=f3iDVH3oS8ZWLcS2jbW9wgo09mIcnxaECQwpQhj1SyPktDuDIyHcJzXIu4mwTInEt9
    VJRcDYU/r0/Yyn+uvhFQwS8JLEYgjgouABOdx5E739/qreNoGbElVpLcqJ/t/8bNYbxW
    SEeqtyCcT7Ji1Vqg4rr96YGGlWL2WhUm5h4Ult3E/sqI9Q91x9tgNGzJYMDp5iI4fsrJ
    O0JWAFRPQT+5Gp0Kl/Ohr4CfIHgr+FJhLVXkb2MplEIjnblruQS/CLasZTBrwrSSbxCM
    cHSFKCS9oHRxZc3Z7AtR7fXhKEuOZt0Z2slEdsLOjmqF/WB9qEUj5TO6B1rTGl7iQSUd
    Z5Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784025287;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=wENVxy0lHI8icvv+L7d6MLxO8aNohN94xfeFPRyybOs=;
    b=S/6x+DksC7YB/D0yDhdHdRwNHOWdAfLH0dSRm2VEWOLcCkTEpMcVA4IK0tzub7Moue
    4G8yUiQK2jjaRVehz6mORIDc2NxH9iiGdArtY5Ub3qkPQXlvZ0FCtT40TCZvu8/E1NGf
    Sn4gE6xsKv6pnT74T8qiJfNSAAXxJAmQbfkT/tEfxH5mZrf2JoSEaVB4M13xteGqh7NN
    lrCn8YitR+QLHJIv6l1JByskWNHBL8BSpYs8jnVC88dExls75aXHNVZWiJ00emrHSIC+
    5BTEXnxrvSehDMx+RWiEv+5ucT5sj3tmyhW2Z/OeoGD6a6jkqeOGHfwuzLumeH5A2pKV
    0gFw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784025287;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=wENVxy0lHI8icvv+L7d6MLxO8aNohN94xfeFPRyybOs=;
    b=VDkso9RwbXqlcnfAFAysFEbcm5sGXO98ntyLi3okUuk6k2TqGFZTq6HOJbbhdTePZU
    Ey26j4Kv+8HADEuUJpZ57zhod1wn/I926AHUQc0b7Og+maV/w55GbupUdoNplLYLHbLO
    JQyuSeqAQrgSsGcY3bFmUpKE+0tli/LIlLwn16NGFA06daDHrYh8SzilADad1sT8ANGq
    hFwRDWR2KRgUDmxjw6LX9I2Tekt8lzeE12wCq1G+d2T22i5GjeyJSqrvtmYId1d4tApz
    egdFb4To4nvrpOHykZbo/jWwFjHAjS6IjvXnFmEcoBtBoFeccSrBnmTJ8Jd4/A2gt3KP
    zkpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784025287;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=wENVxy0lHI8icvv+L7d6MLxO8aNohN94xfeFPRyybOs=;
    b=s+SpujTxhLuuhOD5quQIsCQrbqKVwDw5ynBlNEegk2F3Niw2mYLg98Q3UuzBKMkI6G
    uNRyHylJW6ah67xjU2Dg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from [192.168.20.190]
    by smtp.strato.de (RZmta 55.5.6 DYNA|AUTH)
    with ESMTPSA id Ka9fdb26EAYlj3S
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 14 Jul 2026 12:34:47 +0200 (CEST)
Message-ID: <6d3ca143-bf77-466a-b01e-83622e0f7506@hartkopp.net>
Date: Tue, 14 Jul 2026 12:34:46 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 03/11] can: bcm: add locking when updating filter and
 timer values
To: sashiko-reviews@lists.linux.dev
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org
References: <20260714-bcm_fixes-v13-0-fd667c61099a@hartkopp.net>
 <20260714-bcm_fixes-v13-3-fd667c61099a@hartkopp.net>
 <20260714102728.3A1C41F000E9@smtp.kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260714102728.3A1C41F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14.07.26 12:27, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Dropping bcm_rx_update_lock in bcm_rx_handler creates a TOCTOU race that can erroneously process a received frame as a filter and restart timers for an RX_RTR_FRAME operation.
> --

Fixed in patch 4

> 
> --- Patch [3]: [PATCH v13 03/11] can: bcm: add locking when updating filter and timer values ---
> commit 72b0ae7b8598826552a4ceb6840f50d02ba50085
> Author: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> can: bcm: add locking when updating filter and timer values
>      
> This commit adds a new bcm_rx_update_lock to protect timer and filter
> updates from concurrent access in bcm_rx_setup() and various RX handlers.
> It also fixes a race by normalizing the RTR flag on the staged buffer
> before registering the frames.
> 
> Link: https://lore.kernel.org/linux-can/6975d5cf.a00a0220.33ccc7.0022.GAE@google.com/
> 
>> diff --git a/net/can/bcm.c b/net/can/bcm.c
>> index b612135b017d1..af4bb4182bc29 100644
>> --- a/net/can/bcm.c
>> +++ b/net/can/bcm.c
> 
> [ ... ]
> 
>> @@ -729,9 +751,18 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
>>   	/* update statistics */
>>   	op->frames_abs++;
>>   
>> -	if (op->flags & RX_RTR_FRAME) {
>> +	/* snapshot the flag under lock: op->flags/op->frames may be updated
>> +	 * concurrently by bcm_rx_setup().
>> +	 */
>> +	spin_lock_bh(&op->bcm_rx_update_lock);
>> +	rtr_frame = op->flags & RX_RTR_FRAME;
>> +	if (rtr_frame)
>> +		memcpy(&rtrframe, op->frames, op->cfsiz);
>> +	spin_unlock_bh(&op->bcm_rx_update_lock);
>> +
>> +	if (rtr_frame) {
>>   		/* send reply for RTR-request (placed in op->frames[0]) */
>> -		bcm_can_tx(op);
>> +		bcm_can_tx(op, &rtrframe);
>>   		return;
>>   	}
>>   
>> @@ -743,6 +774,8 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
>>   			traffic_flags |= RX_OWN;
>>   	}
>>   
>> +	spin_lock_bh(&op->bcm_rx_update_lock);
>> +
> 
> [Severity: Medium]
> Could this lock split cause a race condition if a concurrent bcm_rx_setup()
> updates the operation to an RX_RTR_FRAME?
> 
> If bcm_rx_handler() initially sees rtr_frame == false and drops the lock:
> 
> CPU1 (bcm_rx_handler)
>      spin_lock_bh(&op->bcm_rx_update_lock);
>      rtr_frame = op->flags & RX_RTR_FRAME; // false
>      spin_unlock_bh(&op->bcm_rx_update_lock);
> 
> CPU2 (bcm_rx_setup)
>      spin_lock_bh(&op->bcm_rx_update_lock);
>      op->flags |= RX_RTR_FRAME;
>      // updates op->frames but does not clear op->kt_ival1
>      spin_unlock_bh(&op->bcm_rx_update_lock);
> 
> CPU1 (bcm_rx_handler)
>      spin_lock_bh(&op->bcm_rx_update_lock);
>      // Proceeds down the non-RTR path with op->flags now having RX_RTR_FRAME set
>      ...
>      bcm_rx_starttimer(op);
> 
> When bcm_rx_handler() reacquires the lock and proceeds along the non-RTR path,
> it will incorrectly compare the received frame against the new RTR reply frame,
> potentially sending a spurious RX_CHANGED.
> 
> Furthermore, since op->kt_ival1 is not cleared when switching to RTR mode, could
> this erroneously start a timer for an RTR operation and result in a spurious
> RX_TIMEOUT?
> 
>>   	if (op->flags & RX_FILTER_ID) {
>>   		/* the easiest case */
>>   		bcm_rx_update_and_send(op, op->last_frames, rxframe,
>> @@ -778,6 +811,8 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
>>   
>>   rx_starttimer:
>>   	bcm_rx_starttimer(op);
>> +
>> +	spin_unlock_bh(&op->bcm_rx_update_lock);
>>   }
> 

