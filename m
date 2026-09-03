Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C53F2D8767
	for <linux-can@vger.kernel.org>; Thu,  3 Sep 2026 06:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.162
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788418642; cv=pass; b=AkFfkQivMrXCs2OLyE9eV6Q+ndTLn5Oy3MMsWMeCiuY4x9Gf2K+1TNKNgu3E11AM+ipnfRHOZNvrpkbIJrTcL7w3MZy2NEH0d/xYhqvgGQV9NKJ2ALDi7h9HkNh0p0BFW+yCmvLFjuLW1cIvYgjQ8HxU58aNxDcR90LZuM4iP9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788418642; c=relaxed/simple;
	bh=38mqkt7Uk4r+oULWCtMHnreEf1WtOkAN6VkH/1Z4vaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QK+KilA+6CrLtWHzAoASnAu41McwCA/aVslB2xDq3Oyg4CjF/Wpmu2rE2H+L19py25esTyO5oQSVLFohJnJA7q6X+m/JbpP4Bd/ceUcVW02FdugVrO9AoexAM8Ddjnig4j0Ov9jDPRdhpVTurfSF0LSTPJgTYtDaFiVJg0c4ijo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Wya8n5dm; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=OFWe5zck; arc=pass smtp.client-ip=81.169.146.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Wya8n5dm";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="OFWe5zck"
ARC-Seal: i=1; a=rsa-sha256; t=1788418632; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=pKTnZtgUeH9wxyD33cQqbecXSFykXkYJj3u6pvMUdWpC8NXz94Ud+qs9KQEweqhGrO
    fTL6HYnJvAhlC3ww9ls0pBU1vOqHtlwWrt+VV78BOeiMI4+LOhYLxDMuMZ754YU48e0r
    mxWvFAY3LeVSlGmjebjvOpEWD9+lyc5qr8I4JNjVhKAXGG0nGOaD4OFawjtTUKy6XpW9
    dWtQYv0LxmMaxcAlwgVP7LB8iXlxeljFa8NU8pwFa/cAPrVw+CUKNII9XGr2cQUSNy7J
    LCTwpxyD7gww1EEREIUcyJg//vBAXv2d+2s0ZKanJ3oSlZ57WLR/s+K9Gmdev4P7e7rb
    IBhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1788418632;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=EsmFDdWafBcBCr977Uyj6+pbJO9akfXELAWfBXzYkS0=;
    b=fJIYC7O9CGVN0H02b000R9eGuh33uV59gpCA5gGagmLxjjUi+GvWCCN8lXD5W09s/a
    OhcsUVDrxXX95zdey3bGdKykgRbUrKp24hpFrbmovEJeYyQ164iqKYE+qLUPBfbFlS0D
    PnVGrwJsYGkJzmyg15bYPlv4K1wslc3ESThJ+ItBwn195Ob3Iu5E/EKTR/K2oIh4N1Vo
    8+4ik3EcAbhEc2rkqu+KeQ3oDCAU7cgXXCqP1aki/KwUO617pwCyM4r2yAqNJHLlg+7P
    l+rmVRMXRa9uoU/p+76jWrOKBOba8OCJbIf5bHYIpc33yabxr1lwt4eh5VM+0du8DAgQ
    +Aeg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1788418632;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=EsmFDdWafBcBCr977Uyj6+pbJO9akfXELAWfBXzYkS0=;
    b=Wya8n5dm/V5dcOYtb+RTh2wX3eL1Pt7n5la1FRHahq007R41Ez7kV4BDxS8+bvUapz
    44s5KEgO1PErSTvJKTzbcvI4n8tTV6cq5i6AzikRI97SZYkvvD3mQ8ZZKbee5EqSiegb
    YeFYU/quUEvkTQdHnrb0yuTC3J1WpiLUsH8scfAfg5vK8uIH/cbovqbMyaWTQg6E038d
    ND/AKbhkHROWa160oGwCKfIJGg8/pKT4bdBwdeZH2YUosGZOmcWvkgi4eNylU4H/VwM5
    oYOcPFBXL82sft5gNp8Y47+rgj9XXXJMENEUEdp8Y+7371dZC17kGIm4dZjcUMoPo0cL
    m+hg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1788418632;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=EsmFDdWafBcBCr977Uyj6+pbJO9akfXELAWfBXzYkS0=;
    b=OFWe5zckWIc6Ey5PZaBwT7AaTZ/aMR5BtgVhG5zrzP2huiuL80cei5V0xo6/4VN5Pa
    ngkhncv1gGWk7DhFRGDw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id K171b72836vCA1M
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 3 Sep 2026 08:57:12 +0200 (CEST)
Message-ID: <b66c5a16-9b5b-429b-acba-d816f82fcc37@hartkopp.net>
Date: Thu, 3 Sep 2026 08:57:06 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: remove CAN filters independent from namespace
To: sashiko-reviews@lists.linux.dev
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org,
 Oleksij Rempel <o.rempel@pengutronix.de>
References: <20260902182915.19486-1-socketcan@hartkopp.net>
 <20260902185254.877981F000E9@smtp.kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260902185254.877981F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 02.09.26 20:52, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> - [High] Permanent struct net_device reference leak on error path in bcm_connect().
> - [Medium] Cross-namespace data corruption in BCM ANYDEV receive operations.
> - [Medium] Timer cancellation regression leading to leaked BCM TX timers.
> - [Medium] Per-namespace CAN receive list statistics leak in isotp_release().
> --
> 
> commit 510b2a0288244edb9bcc3905c8c1576ae80db01f
> Author: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> can: remove CAN filters independent from namespace
> 
> This patch removes the namespace equality check in the netdev notifiers for
> BCM, ISOTP and RAW sockets to ensure CAN filters are removed even when the
> device's namespace changes. It also introduces tracked netdevice pointers
> for BCM and converts isotp.c to use the device's namespace during
> unregistration.
> 
> Link: https://lore.kernel.org/linux-can/CEA6A38A-2646-4ADA-95B4-CBAE2F301A8E@doyensec.com/
> 
>> diff --git a/net/can/bcm.c b/net/can/bcm.c
>> index 3d637a1e0ac1a..42851d37cc9ae 100644
>> --- a/net/can/bcm.c
>> +++ b/net/can/bcm.c
> [ ... ]
>> @@ -1223,6 +1246,12 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
>>   		op->sk = sk;
>>   		sock_hold(sk);
>>   		op->ifindex = ifindex;
>> +		tx_dev = dev_get_by_index(sock_net(sk), ifindex);
>> +		if (tx_dev) {
>> +			op->tx_dev = tx_dev;
>> +			netdev_hold(tx_dev, &op->tx_dev_tracker, GFP_KERNEL);
>> +			dev_put(tx_dev);
>> +		}
>>   
>>   		/* initialize uninitialized (kzalloc) structure */
>>   		hrtimer_setup(&op->timer, bcm_tx_timeout_handler, CLOCK_MONOTONIC,
> 
> [Severity: Medium]
> If dev_get_by_index() returns NULL here because the interface does not exist
> yet, op->tx_dev remains NULL but the timer is still armed below.
> 
> If the device is created later, bcm_can_tx() dynamically resolves it and
> succeeds. However, if the device is then unregistered, bcm_notify() skips
> cancelling the timer because it strictly checks op->tx_dev == dev:
> 
>      list_for_each_entry(op, &bo->tx_ops, list)
>          if (op->tx_dev == dev) {
>              hrtimer_cancel(&op->timer);
>              ...
>          }
> 
> Will this leave the hrtimer permanently leaked and firing indefinitely,
> repeatedly failing device lookups?
> 
> [ ... ]

Yes. v2 adds an error handling for dev_get_by_index() calls for tx_dev 
in bcm_tx_setup()

>> @@ -1794,9 +1823,6 @@ static void bcm_notify(struct bcm_sock *bo, unsigned long msg,
>>   	struct bcm_op *op;
>>   	int notify_enodev = 0;
>>   
>> -	if (!net_eq(dev_net(dev), sock_net(sk)))
>> -		return;
>> -
>>   	switch (msg) {
>>   
>>   	case NETDEV_UNREGISTER:
> 
> [Severity: Medium]
> Since this namespace check was removed, bcm_notify() now processes events
> across all network namespaces.
> 
> For ANYDEV sockets, the code later in this function handles NETDEV_UNREGISTER
> like this:
> 
>      if (!op->ifindex) {
>          spin_lock_bh(&op->bcm_rx_update_lock);
>          if (op->if_detected == dev->ifindex)
>              op->if_detected = 0;
>          spin_unlock_bh(&op->bcm_rx_update_lock);
>      }
> 
> Because ifindexes are only unique per-namespace, deleting a CAN interface
> in one namespace triggers this globally.
> 
> Can this cause an ifindex collision that spuriously clears the if_detected
> state of an ANYDEV socket operating in a completely different namespace,
> causing it to drop active frame assembly or mismanage timers?
> 
> [ ... ]

Yes. v2 re-introduces the net_eq() check for ANYDEV case handling of 
op->ifdetected

>> @@ -2031,11 +2066,14 @@ static int bcm_connect(struct socket *sock, struct sockaddr_unsized *uaddr, int
>>   		}
>>   
>>   		bo->ifindex = dev->ifindex;
>> +		bo->dev = dev;
>> +		netdev_hold(dev, &bo->dev_tracker, GFP_KERNEL);
>>   		dev_put(dev);
>>   
>>   	} else {
>>   		/* no interface reference for ifindex = 0 ('any' CAN device) */
>>   		bo->ifindex = 0;
>> +		bo->dev = NULL;
>>   	}
> 
> [Severity: High]
> Does this error path leak the acquired net_device reference?
> 
> If the subsequent proc_create_net_single() allocation fails, the function
> jumps to the fail label and returns without calling netdev_put():
> 
>      if (!bo->bcm_proc_read) {
>          ret = -ENOMEM;
>          goto fail;
>      }
> 
> The cleanup also skips setting WRITE_ONCE(bo->bound, 1). When the socket
> is later closed, bcm_release() skips the release because bo->bound is 0:
> 
>      if (bo->bound) {
>          WRITE_ONCE(bo->bound, 0);
>          bo->ifindex = 0;
>          if (bo->dev) {
>              netdev_put(bo->dev, &bo->dev_tracker);
>              bo->dev = NULL;
>          }
>      }
> 
> Could this permanently leak the net_device and tracker, preventing the
> interface from ever being cleanly unregistered?
> 

Yes. v2 drops bo->dev reference tracking when procfs initialization fails

>> diff --git a/net/can/isotp.c b/net/can/isotp.c
>> index 155530aedce2e..0835a4758a72f 100644
>> --- a/net/can/isotp.c
>> +++ b/net/can/isotp.c
>> @@ -1492,11 +1492,11 @@ static int isotp_release(struct socket *sock)
>>   	 */
>>   	if (so->bound && so->dev) {
>>   		if (isotp_register_rxid(so))
>> -			can_rx_unregister(net, so->dev, so->rxid,
>> +			can_rx_unregister(dev_net(so->dev), so->dev, so->rxid,
>>   					  SINGLE_MASK(so->rxid),
>>   					  isotp_rcv, sk);
>>   
>> -		can_rx_unregister(net, so->dev, so->txid,
>> +		can_rx_unregister(dev_net(so->dev), so->dev, so->txid,
>>   				  SINGLE_MASK(so->txid),
>>   				  isotp_rcv_echo, sk);
>>   		netdev_put(so->dev, &so->dev_tracker);
> 
> [Severity: Medium]
> Does this leak the per-namespace receive list statistics in the socket's
> original namespace?
> 
> If the device was moved to a different network namespace, this now passes
> the new namespace (dev_net(so->dev)) to can_rx_unregister().
> 
> When can_rx_unregister() runs, it decrements the statistic in the
> provided namespace:
> 
>      if (rcv_lists_stats->rcv_entries > 0)
>          rcv_lists_stats->rcv_entries--;
> 
> Because can_rx_register() incremented the counter in the socket's original
> namespace (sock_net(sk)), does decrementing it in the new namespace permanently
> leak the count in the old one, while inappropriately decrementing the new one?
> 

Yes. A cosmetic problem that can be fixed in a follow-up af_can.c patch. 
Not relevant for this stable fix.

Oliver
