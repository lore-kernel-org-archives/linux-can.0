Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795861225;
	b=15At/1KXxSuiHjp4smSdrLeMupoEpzU8HfsvPTTObbbKwvoNsiRd16W7z4Aq9aArhHU4
	 IljhcUnKANl6Xjh1tN6nKd8m/ZsBWLEWFLmeb7tcsqc+YEg3sIi1uVIzjf2BswrN12dF4
	 Vi7GqPbcC1DZeRyg0HHDqSivIwyHC5lrzhV5ClTZ8NsJhv4O6Wnm1cHOeYWwGPf2S06i9
	 gqWvgAzaPItrW2KLDnVqc6MkzHoSD1zWXzdfr0/FSu2NEq/nCudtUEh4mgwqkchaB/eNY
	 H/NC14qJgLQCIB/4kUkf0ESHUvTC+sRVFOE/A9w94qDZILNpY/GKJRPRbsjaeVZLQLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795861225;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=88ZJcKOyh2bYY5IxXEEu197UU6Mp4l2baEcu0hcXUPc=;
	b=NcjBHAxC9aklWs45dMD8wiH3sZrQAF/ZRS+pB4gqga7L9PX8TZvRHuZIt7Ar4k6gBFqJ
	 KVvfDlIgA4x1Z6yHSAg3wiDSAV+Iq0ux2hmLmMuKuRYDvv8JRJ/oh8AFJENEqHmFZwAKP
	 ZsYJNKUqvwr8viJx2eafJa6XfQpF56CxvMc14rnW1BNHXTcogKVqzHrYNutt2Sbov6t9E
	 59CiiZsFEiolYD1lCPmvovgP7Eoo2Dl4iPOx8HQeQCZzZmOGh8zWsRVliDSs2m6RCY7wo
	 AeN07mU3yK9Pz4DEQ08qbvaBwDgPUKXDWoNv3wyiHmwkJXs8MhX5DiSwiZYEDyjj4RQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j3scswI9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594C6606A31C
	for <linux-can@vger.kernel.org>; Sat, 28 Nov 2026 10:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j3scswI9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B7D11F000C1;
	Sat, 28 Nov 2026 10:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795861225;
	bh=88ZJcKOyh2bYY5IxXEEu197UU6Mp4l2baEcu0hcXUPc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=j3scswI9A5yaQZj7oEw6WOuOiOeif+WSS6bcQv5EUHftsi9kaFfvfBxH9g2zdyB4s
	 G6wGvIZAW+2DyeVyBOSa7OL11IvWDbJI5yBr6VtmRmh3LHaVIVR0E6yKT4Rdd2AR/D
	 i/5px4M/3dN5OwhIoMSUfb3awEAmDu2Y6qaAUBdgN0+wzgAZdk0Qqrn8AsOgsD13f0
	 Daw0CDGatMLYC9cpuwmGq1U+8WQVrU4VUS7DreLL819ju9lbebbWdPYDu5PdfnEYmj
	 0t1EnG0TswClamSWOjzr0nN97YuJ4vy9RzrBuCQikrx7xpZqEVISDOyjTUnncU5l4D
	 OI3CWSbMDxl9w==
Subject: Re: [PATCH can-next 16/22] can: isotp: rename rx_lock as it has
 become state machine lock
From: netdev-bot+sashiko@kernel.org
To: socketcan@hartkopp.net
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, sashiko-bot@kernel.org,
 zihanx@nebusec.ai, o.rempel@pengutronix.de, yewentian395@gmail.com,
 kuba@kernel.org
Date: Sat, 28 Nov 2026 10:20:24 +0000
Message-ID: <179586122421.3131.17965447413151442667@kernel.org>
In-Reply-To: <20261126-getsockopt-memcg-isotp-v1-16-681ef8d8c2c9@hartkopp.net>
References: <20261126-getsockopt-memcg-isotp-v1-16-681ef8d8c2c9@hartkopp.net>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The rename leaves one comment that still describes the old,
  narrower purpose of the lock.

--

can: isotp: rename rx_lock as it has become state machine lock

This renames the isotp_sock spinlock from rx_lock to sm_lock. The lock now
serializes the whole tx/rx state machine, not just parts of the receive
path. All lock call sites and the comments that mention the lock are
updated.

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index fc03dedb0c86c..8e8f838160aff 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c

[ ... ]

> @@ -804,7 +804,7 @@ static void isotp_rcv(struct sk_buff *skb, void *data)
>  	 * CAN frame reception time. This locking is not needed in real world
>  	 * use cases but the inconsistency can be triggered with syzkaller.
>  	 */
> -	spin_lock(&so->rx_lock);
> +	spin_lock(&so->sm_lock);

[Severity: Low]
This isn't a bug, but should this comment in isotp_rcv() be updated along
with the rename?

The commit message describes sm_lock as "a full state machine locking
primitive". This comment still says the locking "is not needed in real
world use cases".

Other comments touched by this patch depend on the RX path taking the
lock. In isotp_sendmsg():

	/* claim the socket under so->sm_lock: this serializes the claim
	 * with the RX path and with sendmsg()'s own error paths below, so
	 * none of them can ever see a transfer mid-claim
	 */

And in isotp_rcv_echo():

	/* claiming a transfer also takes so->sm_lock, so a plain recheck
	 * is enough: so->tx.state can't have flipped to ISOTP_SENDING for
	 * a new claim while we're still in here
	 */

isotp_release() also forces ISOTP_SHUTDOWN under sm_lock so that it
can't race a sendmsg() claim. The isotp_tx_timeout() comment says the
timers get cancelled under sm_lock.

This serialization also matters in normal use. Softirq processing in
isotp_rcv()->isotp_rcv_fc() and the half duplex check read tx.state while
isotp_sendmsg() may be claiming a new transfer in process context, for
example when a late flow control frame arrives.

As far as I can tell, the comment is still unchanged at the end of the
series, after "can: isotp: introduce CAN_ISOTP_MIN_TX_DL".

Could the comment be reworded so it doesn't suggest the RX path locking
is optional?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261126-getsockopt-memcg-isotp-v1-0-681ef8d8c2c9%40hartkopp.net
