Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793005112;
	b=ekTvI8MSITomPUOSD2sxhFTAJ29FGsa4TRZ5C+lvypM7gVda6XkT2Cve0JxTpe7Ke4MU
	 Kn0mIINBHnmtYmLj9bz/vrBfxOP+sjXgQhf3hBz0WDBRwNj3lkXevwm7KzU3oxtcNpbBi
	 E4b0+HhYhAyNc+9UdqTbUYJG01fLloDzH3RlombtHxeZEizUQYF60N3ySxt/iU9F7Skcy
	 Zrg7rcoXI4jNqZAB0XeLF5ajRbO/2Jq4cIDnin3N42wRl0QRZDS3whPTaG1t2vsuUIzM3
	 Uq7kLoXMDEe4z856/77/N/Btn/4fkPhZtO70l1z7KSk5Y0UYvB2NjfkhyTF6PJdObWQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793005112;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=I2ngR38zJ3Wx1x46hGVNXGL7G48WMDGoEe/e6LQvSu4=;
	b=mAowQhq8MoCZguuNd8il83fOs0FWAC5T+foVSqvjJVhdhdRr/EJ5qha/ODEPlhHstLcI
	 gnbzUuyzOVMigzb3yL5JpQIexO2fp45gMpTb4AZmaHBlOLulIdKh5iuFfPyJtE30RoATl
	 DpucDn8G1B3AhoeIbBjqvo17yaOkLSCMKQ919HqdhVnLxBSfSrPoGRM2kpBxywPO2uYoH
	 x8P2lztRdVHFSAGJ1G6iIpbsxA5CqVClhhUNC0hFk+EXIjWJ7vT3upnUgpP40QZXDgOC1
	 4JFh97PPRrqJTz5wvazcCGdo6si4mePjUuU/vWHLfFT32Q92gqAw2ALe0AucxHByrVw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=BVV3o4Ip;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=YQg2ZWO+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.171
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00BD606A31A
	for <linux-can@vger.kernel.org>; Mon, 26 Oct 2026 08:58:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B00BD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=BVV3o4Ip;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=YQg2ZWO+
ARC-Seal: i=1; a=rsa-sha256; t=1793005099; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=hBbEvM7mrumUo8vEJUEAdVDb2b97C1GFvXD3eeOMbB6TRBfGIEHKJT8KGsf7xy0eRc
    fcSEIx4sZX49QUSesFtKTcp5POCax6bBigQR4jr96fflDKjB/frq5N7ay4FxJO46Tq78
    TcOWUPBW7OXPo5Xz/wbR68PW6VaXupznLJliZJ8fikVrIFvrGZNmzPsPH459Wsptb+ZL
    87Bl7cH4en3D9b2D95UqT3M0LX5aZItA2Ksda2VYE88rDNxNHqIFY+Qfdt3FvcOIMgxB
    FyIx4FVu64kikeAFV4vejhd4mwRm0huJrteBljwMFSV/mOUHJ2JOqsg/chB3DURIzHSW
    JnFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1793005099;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=I2ngR38zJ3Wx1x46hGVNXGL7G48WMDGoEe/e6LQvSu4=;
    b=cTk9MRbiD2GBjrNz35gFWUnLrQBd9z4uaIhxthb1UYX01CWQKOHLx1gaIADMXL7Fx3
    aRpeec9eS6c5GNSWEw1ja7t06DdiIJUvCoR28msmBuXXrCeLIyspbAN4ln1IIeQbFEzq
    TWTWXmhI05pkTHYW8+r2PExbL/TU24GhQbJzwFJlC8Pc/S/l0xjfok8ltFBCsc8jwgNq
    r/B1pqnbujzZNlcukzwTGICpw1iHjeIOFwNlDrBt2RteVItIM+iYJQDApScaMs9stt1x
    4Pskf1BJEfY9gWhuCDbSr3FJEhHpJi2OykPfxUP1W+j+d1klbkVPeEo0DFNY6RRVh+Zd
    WSmw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1793005099;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=I2ngR38zJ3Wx1x46hGVNXGL7G48WMDGoEe/e6LQvSu4=;
    b=BVV3o4Ipvn6fbpVVDkWM0HpZcwR4bUUyivE0VSQUXFuU71xOMF3pa2XpOp5tXl4QiH
    P4gYlx9NppTThaIDxJZxZpews6Z5CyQp4SbS+4MPAyRrNZzGK5TRdjXc1+houYgYJJVi
    4RHIJEq3JRkdkRJBlGAz5+ThZBXW5WnPGiq0jPjd8mZC9slY+Ig6fa154PtZJMFaYmEm
    cWDyFRMiTO79+FDOB1ky1ZPn5ny7eKWZJXwyuCDTlwmmq5pNqxVjNaS9MshU4Pj3U0fq
    U1bbZzevPz1/bl0UFSz/s0+CWJJGmXXFL7K1HZMr6vzYbdMrBA/xohaqYlqy8JwSA7wT
    IvSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1793005099;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=I2ngR38zJ3Wx1x46hGVNXGL7G48WMDGoEe/e6LQvSu4=;
    b=YQg2ZWO+rJDJA1X/IpLnGv0JEYax/t0WCooGtsAPH0eIJMfQ7Bg8YsYeLOQe+Ge301
    a9/sKFjn5lY7l2QUWCDA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29Q8wJ0nC
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 26 Oct 2026 09:58:19 +0100 (CET)
Message-ID: <9b1b9893-f523-4c8b-8a93-62d9eff50d47@hartkopp.net>
Date: Mon, 26 Oct 2026 09:58:14 +0100
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
Subject: Re: [PATCH v9 5/7] can: isotp: check the return values of
 can_rx_register() in isotp_bind()
To: sashiko-reviews@lists.linux.dev, linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>
References: <20261025-can-rx-lock-v9-0-7ef2a2b5c2b4@hartkopp.net>
 <20261025-can-rx-lock-v9-5-7ef2a2b5c2b4@hartkopp.net>
 <sashiko-outbox-184481@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <sashiko-outbox-184481@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 25.10.26 23:28, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] can: isotp: incomplete rollback and premature rx registration in isotp_bind()
> --
> 

Yes. This can be done better!

Fixed in v10

https://lore.kernel.org/linux-can/20261026-can-rx-lock-v10-5-281c4b556a1a@hartkopp.net/

pw-bot: cr

> commit b2feba7ed89eac12b701d3372fa7b7613b9b4096
> Author: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> can: isotp: check the return values of can_rx_register() in isotp_bind()
> 
> This commit checks the return values of can_rx_register() in isotp_bind()
> for the RX and echo receivers. If registering the echo receiver fails, it
> unregisters the previously registered RX receiver and returns the error.
> 
>> diff --git a/net/can/isotp.c b/net/can/isotp.c
>> index 1a272ce6a2bde..da80ef606ce09 100644
>> --- a/net/can/isotp.c
>> +++ b/net/can/isotp.c
>> @@ -1624,16 +1624,25 @@ static int isotp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int l
>>   
>>   	ifindex = dev->ifindex;
>>   
>> -	if (isotp_register_rxid(so))
>> -		can_rx_register(net, dev, rx_id, SINGLE_MASK(rx_id),
>> -				isotp_rcv, sk, sock_i_ino(sk), sk);
>> +	if (isotp_register_rxid(so)) {
>> +		err = can_rx_register(net, dev, rx_id, SINGLE_MASK(rx_id),
>> +				      isotp_rcv, sk, sock_i_ino(sk), sk);
>> +		if (err)
>> +			goto out_put_dev;
>> +	}
>>   
>>   	/* no consecutive frame echo skb in flight */
>>   	WRITE_ONCE(so->cfecho, 0);
>>   
>>   	/* register for echo skb's */
>> -	can_rx_register(net, dev, tx_id, SINGLE_MASK(tx_id),
>> -			isotp_rcv_echo, sk, sock_i_ino(sk), sk);
>> +	err = can_rx_register(net, dev, tx_id, SINGLE_MASK(tx_id),
>> +			      isotp_rcv_echo, sk, sock_i_ino(sk), sk);
>> +	if (err) {
>> +		if (isotp_register_rxid(so))
>> +			can_rx_unregister(net, dev, rx_id, SINGLE_MASK(rx_id),
>> +					  isotp_rcv, sk);
>> +		goto out_put_dev;
>> +	}
> 
> [Severity: Medium]
> Can this rollback leave the socket permanently wedged or with stale state if
> a frame arrives while the second can_rx_register() is running?
> 
> In net/can/isotp.c:isotp_bind(), the first can_rx_register() publishes
> isotp_rcv to the device's RCU receive list while so->ifindex, so->rxid,
> so->txid, and so->bound are still uninitialized (or zero), and then the
> second can_rx_register() allocates with GFP_KERNEL. Because isotp_rcv() runs
> in softirq without checking so->bound, incoming frames matching rx_id can be
> processed during this window:
> 
> 1. If a First Frame arrives, isotp_rcv() -> isotp_rcv_ff() sets
> so->rx.state to ISOTP_WAIT_DATA:
> 
> net/can/isotp.c:isotp_rcv_ff() {
> 	...
> 	/* initial setup for this pdu reception */
> 	so->rx.sn = 1;
> 	WRITE_ONCE(so->rx.state, ISOTP_WAIT_DATA);
> 
> 	/* no creation of flow control frames */
> 	if (so->opt.flags & CAN_ISOTP_LISTEN_MODE)
> 		return 0;
> 
> 	/* send our first FC frame */
> 	isotp_send_fc(sk, ae, ISOTP_FC_CTS);
> 	return 0;
> }
> 
> When CAN_ISOTP_LISTEN_MODE is not set, isotp_send_fc() looks up so->ifindex
> (which is still 0) and returns before starting so->rxtimer:
> 
> net/can/isotp.c:isotp_send_fc() {
> 	...
> 	dev = dev_get_by_index(sock_net(sk), so->ifindex);
> 	if (!dev) {
> 		kfree_skb(nskb);
> 		return 1;
> 	}
> 	...
> 	hrtimer_start(&so->rxtimer, ktime_set(1, 0), HRTIMER_MODE_REL_SOFT);
> 	return 0;
> }
> 
> If the second can_rx_register() then fails with -ENOMEM, can_rx_unregister()
> removes isotp_rcv without resetting so->rx.state to ISOTP_IDLE. With
> isotp_rcv unregistered and so->rxtimer never armed, so->rx.state stays in
> ISOTP_WAIT_DATA forever, causing all future isotp_bind() attempts on the
> socket to fail with -EAGAIN:
> 
> net/can/isotp.c:isotp_bind() {
> 	...
> 	if (READ_ONCE(so->tx.state) != ISOTP_IDLE ||
> 	    READ_ONCE(so->rx.state) != ISOTP_IDLE) {
> 		err = -EAGAIN;
> 		goto out;
> 	}
> 	...
> }
> 
> 2. If a Single Frame arrives in this window before the second
> can_rx_register() fails, isotp_rcv() -> isotp_rcv_sf() queues an skb onto
> sk->sk_receive_queue of the unbound socket, which cannot be read while
> unbound and would be delivered as stale data if the socket is later bound.
> 
> 3. Because can_rx_unregister() only schedules deletion via call_rcu(), an
> in-flight isotp_rcv() callback can still be running after isotp_bind() drops
> lock_sock(sk) and returns an error, racing with subsequent isotp_setsockopt()
> calls that modify so->opt, so->rxfc, and so->ll without taking so->rx_lock
> when so->bound is 0.
> 
> Would it make sense to initialize the socket fields before registering the
> receivers (or guard isotp_rcv() on so->bound) and ensure any in-flight
> receiver and partial RX state are cleaned up on failure?
> 

