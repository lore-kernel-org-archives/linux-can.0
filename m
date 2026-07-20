Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D906414DC4
	for <linux-can@vger.kernel.org>; Mon, 20 Jul 2026 16:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784563994; cv=none; b=AJQNEE/9Q1Kwjl33JvA5HXsdPxJbittscAj+zOvURjMIFQZiFV3t8kIz6wRkqk7p51JJ6oNtrtdk4+zEExQdXLDTtrlzedJRnQnAtEPhI0PlORCAQTCo4maCoh5WpfOZKWN9JhH6u2oJKRbIqVt7IkzrvJcwh1yD0OaMe3PoJqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784563994; c=relaxed/simple;
	bh=0tMRgwRM8aZ5FXtm2LSHQlCKs21cjSIQB2rogmIAgrs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DR1rACspCsrBvNm+tHcdg5cvn6SaJH2k1NoAJsGtHBv9d5+qlKk/F+Gfn/VWT+vAf6WAg3cH9o9y822Kk230oUhM5S0cqisNjzv2zRKzZxQutMTFrMhNYEQqz2oH+bh0s2OIQGjG7o3BLYnn8sIRssPXiZ62w33B+a11jMJxdJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TNYRbj1l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TNYRbj1l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FAB41F00A3A;
	Mon, 20 Jul 2026 16:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784563989;
	bh=hxUdqNNYOsY0ECIbdREuBbgX8YDEDsJh7YImgxcyZmo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TNYRbj1lk39hVJ4BfknDTPGhkHFAOpq2b8AI/rOYR/6sIdTHTzKfUk3ulzEeFfYYV
	 LaoAe2hyoZk7F+UuXtSW7CqLwtBg4EN+/D5DXeLzlf8FdBjeONzqXvAdDpgkNXlKPw
	 RkaWAajrol2Itiq4JtMIR0T+ktvhhPBNrnLlTNDuDx6sBemxxPl2sLgADn8/U+FBD7
	 ieoSCncMGMEhTh4ygBHcceZkmgjYhbJFDtHXw19tf65M2/6ic5Crp7kq6G5nWJ4eec
	 p2nCQ6v2byKG8icaesHFHT+R/AvPOgV/zorYDBodyrK6WZ9h3qUC7HChYbsxQqK1Af
	 dnhFkKGmjOl7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] can: isotp: fix timer drain order, wakeup handling
 and tx_gen ordering
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, "Vincent Mailhol" <mailhol@kernel.org>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260720160115.130306-1-socketcan@hartkopp.net>
References: <20260720160115.130306-1-socketcan@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 16:13:08 +0000
Message-Id: <20260720161308.9FAB41F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent `isotp_sendmsg` calls with `CAN_ISOTP_WAIT_TX_DONE` cau=
se threads to block on subsequent transfers and swap error statuses.
--

--- Patch [1]: [PATCH v3] can: isotp: fix timer drain order, wakeup handlin=
g and tx_gen ordering ---
commit 2b634d5a94a2b1f513e556aa9e369ec38e365df2
Author: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: can: isotp: fix timer drain order, wakeup handling and tx_gen orde=
ring

This patch is a follow-up to a previous commit fixing several issues with t=
imer
draining, wakeup handling, and tx_gen ordering in the ISOTP protocol. It al=
so
aligns state accesses and uses skb->hash for echo frames.

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index 54becaf6898f1..3e5800f440579 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
[ ... ]
> @@ -1230,10 +1246,18 @@ static int isotp_sendmsg(struct socket *sock, str=
uct msghdr *msg, size_t size)
> =20
>  	if (wait_tx_done) {
>  		/* wait for complete transmission of current pdu */
> -		err =3D wait_event_interruptible(so->wait, so->tx.state =3D=3D ISOTP_I=
DLE);
> +		err =3D wait_event_interruptible(so->wait,
> +					       READ_ONCE(so->tx.state) =3D=3D ISOTP_IDLE ||
> +					       READ_ONCE(so->tx.state) =3D=3D ISOTP_SHUTDOWN);

[Severity: High]
This isn't a bug introduced by this patch, but does checking the global soc=
ket
state here cause threads to incorrectly sleep if a concurrent transfer clai=
ms
the socket before this condition is evaluated?

If Thread A and B both call isotp_sendmsg() concurrently on the same socket
and Thread A finishes its transfer and wakes up both threads, Thread B might
claim the socket and set tx.state =3D ISOTP_SENDING before Thread A evaluat=
es
this condition. In that case, Thread A sees ISOTP_SENDING and incorrectly g=
oes
back to sleep waiting for Thread B's transfer to finish.

>  		if (err)
>  			goto err_event_drop;
[ ... ]
> @@ -1246,15 +1270,26 @@ static int isotp_sendmsg(struct socket *sock, str=
uct msghdr *msg, size_t size)
>  	spin_lock_bh(&so->rx_lock);
>  	goto err_out_drop_locked;
>  err_event_drop:
> -	/* interrupted waiting on our own transfer - drain its timers */
> +	/* interrupted or shut down while waiting on our own transfer */
>  	spin_lock_bh(&so->rx_lock);
> +
> +	/* new transfer already started by concurrent sendmsg()? */
> +	if (READ_ONCE(so->tx_gen) !=3D my_gen) {
> +		/* don't touch timers and states of the new transfer */
> +		spin_unlock_bh(&so->rx_lock);
> +		return err;
> +	}

[Severity: High]
This is a pre-existing issue, but when a thread is interrupted while waiting
on a subsequent transfer, it returns an error here instead of returning
success for its own original completed transfer.

Following the scenario above, if Thread A is later woken by Thread B's fail=
ure,
could Thread A incorrectly consume Thread B's error via sock_error(), retur=
ning
it, while Thread B subsequently gets 0 and incorrectly returns success?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720160115.1303=
06-1-socketcan@hartkopp.net?part=3D1
