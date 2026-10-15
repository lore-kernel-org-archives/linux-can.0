Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCB347B425
	for <linux-can@vger.kernel.org>; Thu, 15 Oct 2026 08:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792051389; cv=pass; b=sBKoFZg7hwHXQ0h7Bfn2s7zZBbN0N83IpLWCOiJ9AdsZehBFJDWGAfhKvN0QHc92TTOuD+WChbNOM1hYKE79ScChL8QhCUKLdTvtAAyHEE/Y4N1OFTfwOza3XKi3ew7yDJDZBmIgDLbw6JQSXbn0zK5cQl5li5SHGgJtb4eEnRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792051389; c=relaxed/simple;
	bh=4t04sx7pthW34ZVmo3wz4/MS+ZjLrNF+fo2O+zOxWP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tIi4GeHcuQNLeFU6lnuoFdPlqkwOU3TXXyrE7S8XVjhgHZdTS+q9lsoULEDyaAPmAcW2GSnPqkSyjwYe2HYDUg9C0HJ24geQrLBRhPP0lzm34HkUob1NYXS0OVLfi/iw/+UO3rNRNHBQ7bvP/x1ZlhyHhPyE0h98kG1MbfYwzNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=J4hkL0mD; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=bS57cEWi; arc=pass smtp.client-ip=81.169.146.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="J4hkL0mD";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="bS57cEWi"
ARC-Seal: i=1; a=rsa-sha256; t=1792051384; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ZCq3DzqgboSn4kc91KjA/cfAOL1kmmzL0ifurWro841ADvPsBN3pz7CLKeCYFjONPn
    c8guwsyuhFmv72QlAT7eO3EXXQS9pa+/tH9mFjccV/++cPlZuJ3BQQ0XvyZpr4fOuDCC
    vPgLZKbK8WyUS5dD/elbxSJZspyIETzAOJzStBUuRsPBx0O7/JzBQ/KZ8Riqt+Axsxo1
    +InJn0P9MipTadXdJqwHuiQRgM7Z0BS9Wtk1kkDObBcsadofGJFzg+/ozQFji6756JuY
    k1FMduneChiVv45EsE1kcTcJJmv3sNRBx6XigMYx/csKzOO7MUzHKUJAh0bhyzKEMPHe
    2Dow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792051384;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=CTkZXDk3BRgR+hSnCulYZcr2i24p/D47MMIh7MIFEZI=;
    b=jondMKxH1JrUbCL0rIO/tY7TWL8i6qG/c0KkPXQECgSE/EF5uHdy8wQ0szdaEQe9U2
    aOprbH8qlBNSCaRun0N5rCA0djPyORZ/21bov/7hKIuGHl8gpukEvJOuqd5E2gtn1RYE
    AQ4Hmi4OtV3/TX1JmnaxoyKkluetBQjZrLiLcaNFg5deJKD1O3RcPZEtt74jrCgnnKBf
    sAO4081OF0R3k/90AZR3juAvFCX44jDcQp4XFS4fQktzXI9DWwJZmBHsMvXtACCi0fRo
    BHdiXRCrY1eQrlsRT9FibmQ1JY+sB7dtIXPCxvWs/wPQEwvfB6S+MXJet+aiipZyg+w2
    9KQQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792051384;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=CTkZXDk3BRgR+hSnCulYZcr2i24p/D47MMIh7MIFEZI=;
    b=J4hkL0mDkHjktVM/JqrfNbPAr2psVhSZCOmUrijR6Dqi2N7x9BhPiCVNCOwivasJXR
    phUdIpk0hV1ihpeCYNkkD2g9XS99RwjhpRFhNXr04a3vYvESu/CEyspxurZffziGLWHM
    iUOxocfHTEZHXLLUo9nD0dmitJRgeweNVydr0GAFpkeP37D75jCFtOhTzfgAuJv9Sde1
    p/tucl8GgxkQtdE9UtPUJQIvMdFlu4wKviGaitnsBvDzp3MaQETJqET1+mY+l0qcw8eg
    qWAM0kh6CW7Drg1A24hWkbYsIA3f1VJVwA9vKFqVG56629cMWtc9Vr0E8AR0nEoa/nR7
    X9Vg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792051384;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=CTkZXDk3BRgR+hSnCulYZcr2i24p/D47MMIh7MIFEZI=;
    b=bS57cEWiXHN3j01ADs80Ac3+f8qT4vu1aNv9gIuDr57jWOfIiCMyAyFS3BryYoqvcq
    /mc+Iuy/G8Cyd4fRJ+Aw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29F834GQM
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 15 Oct 2026 10:03:04 +0200 (CEST)
Message-ID: <310d797e-00d8-4737-a308-1aecbeac4c75@hartkopp.net>
Date: Thu, 15 Oct 2026 10:03:04 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] can: bcm: prevent thrtimer UAF in rx path by checking
 RX_NO_AUTOTIMER
To: Lee Jones <lee@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org
References: <20260519113806.85456-1-socketcan@hartkopp.net>
 <20261014-hilarious-bold-jellyfish-f47b11-mkl@pengutronix.de>
 <20261015073410.GD1182143@google.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20261015073410.GD1182143@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15.10.26 09:34, Lee Jones wrote:
> On Thu, 15 Oct 2026, Marc Kleine-Budde wrote:
> 
>> On 19.05.2026 13:38:05, Oliver Hartkopp wrote:
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
>>> Fixes: f1b4e32aca08 ("can: bcm: use call_rcu() instead of costly synchronize_rcu()")
>>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>>
>> This patch is obsolete, right?
> 
> No, I don't think so.  I thought it was applied to the maintainer tree?
> 

I think it became obsolete through all the recent (and stable) changes 
that addressed multiple races. The UAF problem is solved today.

Btw. the use of READ_ONCE() and WRITE_ONCE() can be seen as some 
addditional hardening but the entire patch does not fit to the current 
bcm.c code.

The READ_ONCE() and WRITE_ONCE() may be added for the 7.5 net-next 
window cycle. No pressure here.

Best regards,
Oliver

