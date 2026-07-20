Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3E433F5AE
	for <linux-can@vger.kernel.org>; Mon, 20 Jul 2026 11:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784546611; cv=none; b=YD0xMjTTJ6vdaBtGqA9ce+iwQml5oQHpFFt/dpNKZaRLEksLpyMtJ1l8pKlUAW7+SXAjW5u6MosY4Znx8F4xaBPBP71smicJHPvwlbpJ0DtH3MVP1+Y7dn9AH0c6XAevQYO5ZsI4AOnYwuihF3iQ8gFkM1/NBJzIOF0KdnT1XcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784546611; c=relaxed/simple;
	bh=7oVD3TcDN63GUsDq46aVgYlaD14qExu1i0nwEXvTnAA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VwyDm2lIWcRi+FV9aH3Q5mdn56NdhersDhVFz0lX5Tz+jPx07WkN+H9ivSeSZQ9GSoontqRTWym6o7trrWMDA4onYJSsRpY3upCGRFAk4QGclByfR44/X4nevgjPdH3OZKA2BDi9BQVY3owJQU013EbUPcxvUFhOtTHnlgPPlZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/0g3UP1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/0g3UP1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F1A21F00A3A;
	Mon, 20 Jul 2026 11:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784546609;
	bh=7d63sfpMzW1c0NHep176tY5tv93Lo8N+WKH4m0rx6k8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G/0g3UP1EMrb8DplNYJkYvyeRAegVL70oD6EXOP4AY6p1v5iOsyWMfK5D7oH6HYj5
	 6LAMYPNenFuZ9bkRRPekLs2QRl1c93lS5u1VpGa7lmxbZ9wzOGJX3x4UY8ZYkJs04j
	 x+R94E7bmvc0EbuOHwjIeqZz8UpS3lzzkoxUHQsm5O8JajazWiQcdtoeXCcPkJXlXb
	 npdlcatzJCSbOVpGo6+rXkAJ75XjxQPjt3tLoIv4z2dvxUVKhdd55QQURR0MZN6t4e
	 YLV51/gb4UMf+IbqA8y8IqShgbvOsomq9tXDOfMa6p2vKmqN/5qWe5VUH/aNixchAm
	 wzgb2uFZI96fg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] can: isotp: fix timer drain order, wakeup handling and
 tx_gen ordering
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org
In-Reply-To: <20260720110830.111709-1-socketcan@hartkopp.net>
References: <20260720110830.111709-1-socketcan@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 11:23:29 +0000
Message-Id: <20260720112329.8F1A21F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Signal interruption in wait_tx_done unconditionally resets socket =
state, potentially clobbering a concurrent transfer.
--

--- Patch [1]: [PATCH] can: isotp: fix timer drain order, wakeup handling a=
nd tx_gen ordering ---
commit cdb0b283760f7e72e982cd4e81ec76ef6a8a011d
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: isotp: fix timer drain order, wakeup handling and tx_gen ordering

This patch addresses several issues found in the CAN ISOTP protocol.
It fixes timer drain ordering, wakeup handling on socket release, and
ensures tx_gen is incremented before state transitions to avoid timeout
stamp races.

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
[ ... ]
> @@ -1246,15 +1261,18 @@ static int isotp_sendmsg(struct socket *sock, str=
uct msghdr *msg, size_t size)
>  	spin_lock_bh(&so->rx_lock);
>  	goto err_out_drop_locked;
>  err_event_drop:
> -	/* interrupted waiting on our own transfer - drain its timers */
> +	/* interrupted or shut down while waiting on our own transfer */
>  	spin_lock_bh(&so->rx_lock);
>  	hrtimer_cancel(&so->txfrtimer);
>  	hrtimer_cancel(&so->txtimer);
>  	hrtimer_cancel(&so->echotimer);
>  err_out_drop_locked:
>  	/* release the claim; so->rx_lock still held from above */
> -	so->cfecho =3D 0;
> -	so->tx.state =3D ISOTP_IDLE;
> +	WRITE_ONCE(so->cfecho, 0);
> +
> +	/* only claim to IDLE if isotp_release() has not taken over */
> +	if (READ_ONCE(so->tx.state) !=3D ISOTP_SHUTDOWN)
> +		WRITE_ONCE(so->tx.state, ISOTP_IDLE);

[Severity: High]
This is a pre-existing issue, but can this error path clobber a concurrent
transfer?

If Thread A calls isotp_sendmsg() with CAN_ISOTP_WAIT_TX_DONE and is
interrupted by a signal, wait_event_interruptible() evaluates to false and
returns -ERESTARTSYS.

Before Thread A can acquire so->rx_lock at err_event_drop, its transfer
might complete normally. The RX path would set so->tx.state to ISOTP_IDLE
and wake up a concurrently blocked Thread B.

If Thread B then claims the socket, increments so->tx_gen, and starts its
own transfer, Thread A would eventually resume, acquire so->rx_lock, and
blindly cancel timers and reset tx.state to ISOTP_IDLE, corrupting Thread B=
's
new transfer.

Should this error path verify that so->tx_gen still matches the thread's own
generation before resetting the state, similar to how it is checked in
isotp_tx_timeout()?

>  	spin_unlock_bh(&so->rx_lock);
>  	wake_up_interruptible(&so->wait);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720110830.1117=
09-1-socketcan@hartkopp.net?part=3D1
