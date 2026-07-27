Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EC03E5EC3;
	Mon, 27 Jul 2026 08:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785142663; cv=pass; b=oRhTY+hpds3IHqg6BTDjfMZnVSB/VWWqCa8P3KkhBZ4kU8ZoQxXXf2GKYfKGozkR1hJAHpTv+rG4YnMMpT3bAzx8zNACbbpm9kEg6zbNuuZjK0ekgeEwq5sbLXweVA1Qu5HiQvaWSP6BO5iImw3fijvNRPD+AyTJUVY7VOxxV/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785142663; c=relaxed/simple;
	bh=OQceWvvAPco1UlSW4D6O75OyCUIaN8svFUb01E6wuhI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AVKfdh06R7fM4GKoOyPg/QQ+LRHsX6Jn89+e3sC/fp8OargSFP63ZBn626VReRJxi7iMYYxydQVoJUSgwm/Xb/fDhZUTk9dXN39+1anTVaHgytXy61DONpNb2W37dxZUaZjyjodUMVFmKz5/1RasVSzJqwI+JQQghx1I4snbQ5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=c5p9z0qm; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=UccEp9uc; arc=pass smtp.client-ip=81.169.146.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="c5p9z0qm";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="UccEp9uc"
ARC-Seal: i=1; a=rsa-sha256; t=1785142651; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=n3p+/TzjfBEAWTtJdbR8ukOU8+tGgLBwpAalCDVPXXFilClw0LyK0La7xM7rsFja17
    F44VzLJnkFC/QUZLU9oKeqkmH5SLdZSxMyiurjNFD+EztiZQ47CcW8rGhoWk5IRsko3s
    AZbWsKvLt/2ei6ln7IjIGZmru3lsNx7ffiNhE+OpxGr6/u379QGdvRG81LlpeTfnGGQ7
    /dxg9ud9htnlsPLrYFwe3WZN9hrzBc8X5iQ6YhyCjRQPEFXsxt6urER+mdeZBDTiKgh1
    qAUAkrx/6Xzp7Cf6AVQBmordOPQOC/BwHGHdhWsbcB8QNwOncEqLMfYCYhtp9koI/gL6
    uExg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1785142651;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=BWFH4kIKomL4HPARNx3Qgzd1hB0K6CqT//lZHHoUthk=;
    b=OSFb1XnyUdciIijsvoIlqiN9dWjVQAWfhcfyviu7umhBkF9TBnbFzTV01BySn4GWhV
    GFr35+SL08qYoUKmQvjUXITOtNIDnKTv8Oh2ZpWoFKd6S6G7vSbThuwDkkzlphdFOULN
    gSLqn7Ib2nOQsYJ9GlmKxhBynKo6XYab0NgFUhHxyEvpMWLDr4rjpYTI7BiM9jwFVhR9
    Wx3epEzUC2RIyatio1eRTnZ5iY9PxiWUZ0IW8fCzcVXpkgWeHxTCBUAfpizhwp2vNQeE
    2n2NMDHOnThr/oVUavVe/Xgr6cS+eOSxCm05gGoKbEr/rL17sJ9qASuCK+sqrBf8hijm
    5tHw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1785142651;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=BWFH4kIKomL4HPARNx3Qgzd1hB0K6CqT//lZHHoUthk=;
    b=c5p9z0qmDgDkxlUn83xPbqRf0i5SScllZq8xXdcqvntzm3ZpaySIzJfS0Uzyda3hhU
    ajKtsKtCjCXC42RqUDzExKB5UxKsUzVIJlo0dyQm4138ymUiYtPo/Z/nEiQ3R1q3s5b+
    4/Xgm6hAHlYkJXSHgLG8tjQkoTvwKP19Th74/eVZKUEVKsCA2yHmQAj52MY34XQ6rIMF
    pt5NxjyxtF6yH3foAG/uMoZd8aVloU9/wE3b6ITbjpLz6cN/HmxeBloH7AfylntStQ7d
    Z2yPpJGV77eZgnUSIHdkEbku6TLLaJspObsJWwQcZagjVxh4BFPFTfrOiseeRYj3Pl7y
    XM8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1785142651;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=BWFH4kIKomL4HPARNx3Qgzd1hB0K6CqT//lZHHoUthk=;
    b=UccEp9uccrh46QqOGKgxKnDTDB4RXCNtsAofenrvhzw7iNysgbxvifrh8V18bTlMtQ
    LccerlYKuKOqCBTmf2Aw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from [192.168.20.231]
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926R8vU87h
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 27 Jul 2026 10:57:30 +0200 (CEST)
Message-ID: <91498185-bcf5-4064-8402-c08b60a531b3@hartkopp.net>
Date: Mon, 27 Jul 2026 10:57:23 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] can: bcm: add missing synchronize_rcu() in
 bcm_delete_rx_op()
To: Nguyen Le Thanh Tung <nguyenlethanhtung555@gmail.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260727083750.2057304-1-nguyenlethanhtung555@gmail.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260727083750.2057304-1-nguyenlethanhtung555@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 27.07.26 10:37, Nguyen Le Thanh Tung wrote:
> bcm_delete_rx_op(), reachable from an unprivileged user via an RX_DELETE
> bcm_msg_head, unregisters the CAN rx handler and then immediately calls
> bcm_remove_op(), which cancels op->timer and frees the op via call_rcu():
> 
> 	can_rx_unregister(..., bcm_rx_handler, op);
> 	list_del_rcu(&op->list);
> 	bcm_remove_op(op);		/* hrtimer_cancel() + call_rcu() */
> 
> bcm_rx_handler() runs in an RCU read-side critical section and re-arms
> op->timer on frame reception via bcm_rx_starttimer(). A handler that is
> already in flight on another CPU when RX_DELETE is processed can be past
> its RX_NO_AUTOTIMER check -- a plain, unordered u32 store set a few lines
> earlier in bcm_delete_rx_op() -- and re-arm the timer after bcm_remove_op()
> has cancelled it. The op is then freed after the grace period with its
> hrtimer still enqueued, so the timer fires on freed memory in the timer
> softirq: an out-of-bounds access that can crash the machine or disclose
> adjacent kernel memory. AF_CAN BCM sockets are reachable in a user +
> network namespace (e.g. over a vcan interface), so this is triggerable
> by an unprivileged local user.
> 
> commit d5f9023fa61e ("can: bcm: delay release of struct bcm_op after
> synchronize_rcu()") fixed exactly this race for the socket teardown path
> in bcm_release(), by draining in-flight handlers with synchronize_rcu()
> between can_rx_unregister() and bcm_remove_op(), but the RX_DELETE path in
> bcm_delete_rx_op() was left unchanged and still has the race.
> 
> Add the same synchronize_rcu() to bcm_delete_rx_op() so that no
> bcm_rx_handler() can be running -- and thus re-arm the timer -- once
> bcm_remove_op() cancels it and frees the op. bcm_delete_rx_op() is only
> called from bcm_sendmsg() under lock_sock() in process context, so
> sleeping in synchronize_rcu() is safe here, exactly as it already is in
> bcm_release().
> 
> Fixes: d5f9023fa61e ("can: bcm: delay release of struct bcm_op after synchronize_rcu()")
> Signed-off-by: Nguyen Le Thanh Tung <nguyenlethanhtung555@gmail.com>

NAK

This is already fixed with

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/net/can/bcm.c?id=68973f9db76144825e4f35dfdc80fb8279eb2d57
("can: bcm: defer rx_op deallocation to workqueue to fix thrtimer UAF")

without re-introducing the costly synchronize_rcu().

There are a bunch of bcm fixes that have been applied to 7.2-rc3 and are 
queued for several stable trees. Please re-check the current bcm.c 
developments and fixes.

Best regards,
Oliver

> ---
>   net/can/bcm.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index 75653584f..25f868530 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -822,6 +822,14 @@ static int bcm_delete_rx_op(struct list_head *ops, struct bcm_msg_head *mh,
>   						  bcm_rx_handler, op);
>   
>   			list_del_rcu(&op->list);
> +
> +			/* wait for any in-flight bcm_rx_handler() to finish so a
> +			 * concurrent frame reception cannot re-arm op->timer after
> +			 * bcm_remove_op() has cancelled it and the op is freed
> +			 * (same drain as the bcm_release() teardown path).
> +			 */
> +			synchronize_rcu();
> +
>   			bcm_remove_op(op);
>   			return 1; /* done */
>   		}

