Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC643A451F
	for <linux-can@vger.kernel.org>; Wed, 20 May 2026 13:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.165
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779282415; cv=pass; b=LYE4L6rVNC/JJIty0p2EjOBm78pKyTOErFWMEdu3ojr5EpKRjPImaM+8y1KSwkv/Y5+mf9qBJ4DpP7UV3w8JeJMVY9vTEmxODKpFRuSODehAtBOTsjXOQnO6yWOxBmg+jeHbPHHsfo9zWMHt8pvcG2Z6ZuSS/n+HfFBuvj+BYn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779282415; c=relaxed/simple;
	bh=FJ1vRTtUAoxh1fXzl8v6kZwH2JsofIZz21RQa8abNo0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nl98JwexbtCl7NZb3c9uDdbVG/uQEznACH8LcgHlpEO7jB3Lc29hETHN8VoZveGwlU2GctTSSsIMkV1CxN4ivy44TpQfuww4sfe8hAh5TV9cK/PWxryxb0jPxJqa90T/CmZgv/zF4A3eBB0vmK+ZdaM+QYqBqM4GD3Z+fd3sF7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=RHcNwc3C; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=wJypJLfW; arc=pass smtp.client-ip=81.169.146.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="RHcNwc3C";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="wJypJLfW"
ARC-Seal: i=1; a=rsa-sha256; t=1779282222; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=lKSM2iqAReqKiOoia7/6fFgZscYwxdCCm6u5aKvLfV9tTVmx4Xo7iwgVJNycYLPAgZ
    F2fm0ypAIy5aeIc79uuWkaGWvXiCAryVCMPRlVihBPwUbfDFww5XR18Kmz0Y0cyQd73C
    hwuspCQ1DGyR6HRoTveN6kJF07dcBUf1DJP8hMwZfX2WgHUfndiiB0WKCwb8G+i69UAl
    UIr8+RriUdkLzL6t8z41nh3y6djVaWHs7JuizDI/HCWZ0OEgGiADljoBnhExwP4MO7BG
    zR0uUZZpR4ScxpgOT6T8sYYO9nGslPqv1GpESnZ66DDR5m0ta4nl3yCeuoA1zR1o7bGB
    8w0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1779282222;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=yVxiVg6LRb9nqefX97SLfS87c2hhHHQBg3gBg5KthFE=;
    b=dBrvXarCJsLNO6P9wj6wkU8rEXpyD26QQySy3ZjNHYrWAbCj67HYtk/U59APtESD8c
    syEQtDkoApWxOKzdOwS5PgH4w1v8Em9+RCHV9C8klZE7nkvLzpnKlfKIL+HmTq2ey3U0
    hs8dPHIDhAwpTCLIrnv67jUus2+49LesGqoSiqEXshGBZgpZhaDaaQB9em0Sxs+SKflJ
    IzvQnuOqazMH/6QekHjbjkECXTdXHco4FjnJsxT1vareTdJXfeA0ybX+I5lYAVqqngxC
    UdueAKxPcKPP8XQjplrkbUqi6q4fajL1IpP9i4ESs8hI1UyM0f6h2rxZ1AlYqIMOvDVM
    gXzg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1779282222;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=yVxiVg6LRb9nqefX97SLfS87c2hhHHQBg3gBg5KthFE=;
    b=RHcNwc3CSuTYL8CSRPQiUztknhaPS3y57Wp05cYQ2SgawKGguimGev8haIAVd1gAln
    1aJleKxuSESEZIKaNvxOWyqMcw8QXOcAfEdnGp0RhcfDf6TYCFFd/bMK2Ox0lPYg3Aph
    hXe6ck6H3ZbTCnbVdUKYIc2C3aenKwYhVCaudzXm/jMW39NISyeTFUp2eSmGoS9QcT4j
    uDyKBv75twq9YlpNK5Wj6brkLLKbmbeh3lvhe7rKHOd40ODpz608MOWQmJ+Vm2+2OtNs
    Tb2pooeFN7JsYs67MM4nnQrsgmcBg8FXrv0wwlc/BYzJ3F+yOQJDtibzpq2UhwI4L4qp
    OEiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1779282222;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=yVxiVg6LRb9nqefX97SLfS87c2hhHHQBg3gBg5KthFE=;
    b=wJypJLfWXlcd0hs02Jb8B31sR9i3RobRwu9zeD2s69HvHiKPLfin1wQn0kYoYFP6wk
    yhEAVhz1btSdSkQCRIBw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeFQ7s0ZDT0tksFSR+Aix0esQJVIAlZEg=="
Received: from [IPV6:2a00:6020:4a38:6800:217d:dfe3:b063:ecb0]
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Kba96d24KD3gLTg
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 20 May 2026 15:03:42 +0200 (CEST)
Message-ID: <442a92c9-5810-4fcd-ab05-5b0acd0f345c@hartkopp.net>
Date: Wed, 20 May 2026 15:03:42 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] can: bcm: prevent thrtimer UAF in rx path by checking
 RX_NO_AUTOTIMER
To: Lee Jones <lee@kernel.org>
Cc: linux-can@vger.kernel.org
References: <20260519113806.85456-1-socketcan@hartkopp.net>
 <20260520124758.GA305027@google.com> <20260520124907.GB305027@google.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260520124907.GB305027@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 20.05.26 14:49, Lee Jones wrote:
> On Wed, 20 May 2026, Lee Jones wrote:
> 
>> On Tue, 19 May 2026, Oliver Hartkopp wrote:
>>
>>> From: Lee Jones <lee@kernel.org>
>>>
>>> Commit f1b4e32aca08 ("can: bcm: use call_rcu() instead of costly
>>> synchronize_rcu()") removed the synchronize_rcu() call from
>>> bcm_delete_rx_op() and introduced the RX_NO_AUTOTIMER flag to prevent
>>> timers from being rearmed during deletion.  However, it only applied
>>> this check to op->timer via bcm_rx_starttimer().
>>>
>>> It missed the fact that op->thrtimer can also be rearmed by an
>>> in-flight bcm_rx_handler() (which runs as an RCU reader) via
>>> bcm_rx_update_and_send().  This allows op->thrtimer to be queued after
>>> bcm_remove_op() has already cancelled it, leading to a use-after-free
>>> when the timer fires on the deferred-freed struct bcm_op.
>>>
>>> Address the omission by checking the RX_NO_AUTOTIMER flag
>>> in bcm_rx_update_and_send() before starting op->thrtimer, effectively
>>> preventing it from being rearmed concurrently with teardown.
>>>
>>> [Hartkopp] Added the setting of RX_NO_AUTOTIMER also to bcm_release() before
>>> removing the CAN filters following the bcm_delete_rx_op() approach.
>>>
>>> Additionally WRITE_ONCE()/READ_ONCE() macros have been introduced for
>>> the changes of RX_NO_AUTOTIMER at rx op removal time to prevent a
>>> potential code reordering of RX_NO_AUTOTIMER setting after CAN filter removal.
>>>
>>> Signed-off-by: Lee Jones <lee@kernel.org>
>>> Co-developed-by: Oliver Hartkopp <socketcan@hartkopp.net>
>>
>> You did?  Can you add a note saying what you changed please?
> 
> FYI, did you also see the second swing I took at this:
> 
> https://lore.kernel.org/r/20260520080523.2513957-1-lee@kernel.org

Yes, and I answered to your patch.

Is there some lag in the e-mail communication right now?

That's why I also wondered why you sent a patch one day after my v2 
proposal.

Best regards,
Oliver


> 
>>> Fixes: f1b4e32aca08 ("can: bcm: use call_rcu() instead of costly synchronize_rcu()")
>>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>>> ---
>>>   net/can/bcm.c | 14 ++++++++++++--
>>>   1 file changed, 12 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/net/can/bcm.c b/net/can/bcm.c
>>> index a4bef2c48a55..abf7bd2c2e6f 100644
>>> --- a/net/can/bcm.c
>>> +++ b/net/can/bcm.c
>>> @@ -537,10 +537,16 @@ static void bcm_rx_update_and_send(struct bcm_op *op,
>>>   
>>>   	/* with active throttling timer we are just done here */
>>>   	if (hrtimer_active(&op->thrtimer))
>>>   		return;
>>>   
>>> +	/* bcm_remove_op() may have cancelled thrtimer concurrently with this
>>> +	 * RCU-protected handler; do not rearm it. Mirrors bcm_rx_starttimer().
>>> +	 */
>>> +	if (READ_ONCE(op->flags) & RX_NO_AUTOTIMER)
>>> +		return;
>>> +
>>>   	/* first reception with enabled throttling mode */
>>>   	if (!op->kt_lastmsg)
>>>   		goto rx_changed_settime;
>>>   
>>>   	/* got a second frame inside a potential throttle period? */
>>> @@ -603,11 +609,11 @@ static void bcm_rx_cmp_to_index(struct bcm_op *op, unsigned int index,
>>>   /*
>>>    * bcm_rx_starttimer - enable timeout monitoring for CAN frame reception
>>>    */
>>>   static void bcm_rx_starttimer(struct bcm_op *op)
>>>   {
>>> -	if (op->flags & RX_NO_AUTOTIMER)
>>> +	if (READ_ONCE(op->flags) & RX_NO_AUTOTIMER)
>>>   		return;
>>>   
>>>   	if (op->kt_ival1)
>>>   		hrtimer_start(&op->timer, op->kt_ival1, HRTIMER_MODE_REL_SOFT);
>>>   }
>>> @@ -838,11 +844,11 @@ static int bcm_delete_rx_op(struct list_head *ops, struct bcm_msg_head *mh,
>>>   	list_for_each_entry_safe(op, n, ops, list) {
>>>   		if ((op->can_id == mh->can_id) && (op->ifindex == ifindex) &&
>>>   		    (op->flags & CAN_FD_FRAME) == (mh->flags & CAN_FD_FRAME)) {
>>>   
>>>   			/* disable automatic timer on frame reception */
>>> -			op->flags |= RX_NO_AUTOTIMER;
>>> +			WRITE_ONCE(op->flags, op->flags | RX_NO_AUTOTIMER);
>>>   
>>>   			/*
>>>   			 * Don't care if we're bound or not (due to netdev
>>>   			 * problems) can_rx_unregister() is always a save
>>>   			 * thing to do here.
>>> @@ -1618,10 +1624,14 @@ static int bcm_release(struct socket *sock)
>>>   
>>>   	list_for_each_entry_safe(op, next, &bo->tx_ops, list)
>>>   		bcm_remove_op(op);
>>>   
>>>   	list_for_each_entry_safe(op, next, &bo->rx_ops, list) {
>>> +
>>> +		/* disable automatic timer on frame reception */
>>> +		WRITE_ONCE(op->flags, op->flags | RX_NO_AUTOTIMER);
>>> +
>>>   		/*
>>>   		 * Don't care if we're bound or not (due to netdev problems)
>>>   		 * can_rx_unregister() is always a save thing to do here.
>>>   		 */
>>>   		if (op->ifindex) {
>>> -- 
>>> 2.53.0
>>>
>>
>> -- 
>> Lee Jones
> 

