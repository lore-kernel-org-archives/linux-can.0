Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=81.169.146.164
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792678102;
	b=oTilbbWsRm1n3J3b2vVQLnB8lc0HVzO+HXQF8WCdvPiVk3Gb+hQWEgPD7fIq7HyDIehv
	 +ubjkc66McfVY2mjvx2m4DAj/eVQtUcPmcwBgfsiOTyY5fOnlFsDWlPEUQURLpBw3dJ3D
	 3dw/ubO5PeDZOFOPtYSrYesYISkNO0vn5hUceRMFlNQnaAsv9N/TUePVFvijBMONs5ykb
	 Rh1gBSZuzgKeTvSZ9bd4pVUiAevI6n3/fd5Lcu+EJCjy69YD+6PgYMRnj++uNbRVnY17B
	 3jZXtFTjZ8M6rS6LEvYFFJfHy6M1TEHnB7LChwiGE3KauRu7TPACUePGZcQuEBGkShg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792678102;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=kOHvr9tzBaDdrfbvtULL7K2rzEWIQvjIeFn8Av/masY=;
	b=U6r/tpSIKtLTA34SOrafHO8SvBRn/4KDYIJEBvCJ2F7ybby25gwUJFsiAUJM5i2Hpo9X
	 PAeJuV5OZGImXS/RKiWjoFEhyi62ShaLcMRmfCluRpKbjqdFyKhgXVW+uMx3N0CyZ8ewC
	 XSMioN0ZpHpsc2zBcBfaNSTLpJ+iU1Y1tYLU525Xh0/5tzwcL9DCoKSpsI/ftrxLb5ux8
	 jGXDlqhRlbyYjzjFDnQa2DaU+6gqQRsfHKwBPonYZYxYpRY/WPK79SqdR8fG6SqaQK+Gc
	 mDqvnWWTOI2ggXR7i83GAL2nBdUkAlacSVlzzpuCWx8EJ2TUrt+3RBXQzr1zzr7mUMw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=jh6goxT7;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=jZvhxiLT;
	arc=fail smtp.remote-ip=81.169.146.164
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0380F606A31B;
	Thu, 22 Oct 2026 14:08:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0380F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=jh6goxT7;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=jZvhxiLT
ARC-Seal: i=1; a=rsa-sha256; t=1792678080; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=iPQjh8/zI4U7XaWy4pqkFyRFhga8MapedqIPS6hDsTfoFb5ztnFL5coF8y8Y4L6IdR
    McFbo0Yt6lTOzshVwmPDaFsfcIjHYoHnKwQZUz7p39FJathzJLhYr5BZx5IaRY4yQZdL
    rEUdtWe7CXQuEaWjNRzUgbu+a2LoHcIhjnD4ZN8kJzeN5vDC6ssRH+5qtMQ5AWe29K/9
    UUYz9whEokKKnQuhIjZH83keSdYfnEZkrjr63Fb3MJPLgStrE9rY0D2FyKrG7XK/DwN4
    UNNSqclI74ymU/96Lq4zlbtL86JaEBKqwpqDJUt5gYmYGHPmGE0UnNPBRUeFUdL4yRCu
    AMGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792678080;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=kOHvr9tzBaDdrfbvtULL7K2rzEWIQvjIeFn8Av/masY=;
    b=sZ5EuEyhaYfR3bZrwEYnxhRhHikg1aFCDch64k9RqXsN1GjHUmT4dVAACSxRBJC3cF
    MzVToh2aUyOs7VE0gaftF4pujLrmpXxYVjhCUfnlIHXJ9W3S0k256euueaZBKgocZ+/n
    0aEZqlvOjWOElcdbGY2r+JL5N9+kWZh2LIQCJgEMyVf8NI97FDDS66J6sXh0kk0BM5w7
    70Ow5WL2vNQW0t485iVWb7WTr3q+SPCslmfirEUGNDFy/cbEJgeuKiAbBt3NhRr+lmf/
    gcPG+D6AqS7FJQJPdARl9x4HM5xCqQhPHrQsrtUCEdG43IwHqKysZZyLPTZx7RzfCcSv
    3zqA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792678080;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=kOHvr9tzBaDdrfbvtULL7K2rzEWIQvjIeFn8Av/masY=;
    b=jh6goxT7qKEfNjlQg1c8SDk0Haw/ryvaxZEqp5mD+zdk0S6KQ5K5rnNoVTSe4ivB7i
    k57z8dbrROVhnx7tyxuTGsIixmbBCcuaobD3qcNiyR7mrnvqJA7MyAaWkyKHZMDEbYgc
    cIX3D9aZ7E1uBrXubPvfTHa0aCeuin9OEB1hs+Eklj43dlWSvDbvSbigQr/XxMr8EBmI
    PUSF0YTv+329QKq+1CkPxpIxT41w93FuA5LLyBWhQu5MWbdSZSPmMiL8a0PocCLBVeiD
    t7JMDd8iipGm1x+sscGCZHF399Yphfdhbpc2RVm783dhvU7KwnxJ1EUAKXME8+zuLDyl
    6Kmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792678080;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=kOHvr9tzBaDdrfbvtULL7K2rzEWIQvjIeFn8Av/masY=;
    b=jZvhxiLTz5iRbG3njQ2jbx7OYJD5JKO4k/7od2vVnu1XoKx9ZzVXjprAKOdiQKBRTt
    hZb1ff1lgpVJwgudnZDw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29ME7xp2T
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 22 Oct 2026 16:07:59 +0200 (CEST)
Message-ID: <00ecd34e-9296-4db0-b78e-49b4f9440db5@hartkopp.net>
Date: Thu, 22 Oct 2026 16:07:54 +0200
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
Subject: Re: [PATCH net-next 0/11] pull-request: can-next 2026-10-22
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
 kernel@pengutronix.de
References: <20261021231130.2085690-1-mkl@pengutronix.de>
 <eb3b2eee-3460-4b03-a180-1d3806a7f8f7@redhat.com>
 <5fdffd4b-7f80-471b-93b3-706c00cb51da@hartkopp.net>
 <20261022-unique-famous-dachshund-f51d3d-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20261022-unique-famous-dachshund-f51d3d-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 22.10.26 14:41, Marc Kleine-Budde wrote:
> On 22.10.2026 13:19:08, Oliver Hartkopp wrote:
>> Unfortunately sashiko-bot complained about something new in my patch 11/11
>> and suggests to move some release_sock() calls 4 lines down behind
>> sk_error_report(sk) :-/
> 
> Is this review already available to the public?

Yes. It was some delayed v5 (PR 2026-10-21) review:

https://lore.kernel.org/linux-can/179266767682.3135.6448103178144570295@kernel.org/

- [Medium] After this patch, CAN_RAW serializes bind/setsockopt/release
   against NETDEV_UNREGISTER only with lock_sock().

This is the issue that sockopt() uses lock_sock() which might block the 
rtnl_lock in the notifier. This has been partly addressed in patch 11/11 
so that we are better than today's mainline status. On the TODO list.

- [Medium] can: raw/isotp: race in bind() overwrites ENODEV with 
ENETDOWN on unbind

This is a new topic of v6 which wasn't remarked by sashiko in the v5 
review before. Fixed in v7.

- [Low] isotp_bind() now publishes so->dev with WRITE_ONCE(so->dev, dev)
   inside the RCU lookup (net/can/isotp.c:1623).

Fixed in v6.

Pre-existing issues:
- [Low] isotp_bind() calls can_rx_register() twice: for rx_id when
   isotp_register_rxid(so) is true (net/can/isotp.c:1648-1650), and for…

Groundhog day. Not critical. On the TODO list.
> 
>> Would you like to have that re-spin PR to be named as "net" PR ?
>> And when would it be best to be sent?
> 
> I'll rebase the changes to net, and usually "net" is always open.
> (Correct me, if this is outdated information.)

Ok. As you suggested to work on the two TODO topics, I'll post a new 
series on CAN ML and wait for the cross-review.

This should be fine for a 'net' PR then, after the current net-next hit 
Linus' tree.

Best regards,
Oliver

