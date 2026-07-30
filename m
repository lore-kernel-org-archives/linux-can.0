Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C283D9DDF
	for <linux-can@vger.kernel.org>; Thu, 30 Jul 2026 10:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785407390; cv=none; b=VDmOlE+PqON1+LF9ABl/+mMupt+qC1jKkoiLnvl/NAIuOJx0cBmIUcaT8pIxPDpU1OpWLi+0DmF0nh/Q5o/aPMH3M1eWN8/JJYeJ3FZdHOi7pVDa5Ca1/k6sQ+h4xSiWr5/w0nqKLmSFo3O9jnsYVIi6U7FGSBmrtsQIwHWmLns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785407390; c=relaxed/simple;
	bh=NYRzIgdY1cAqLlFDqzO/BOWTBDPd2vcUa8r5Qm8yyZo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R/8zyXlU04Zzhaf+xfRddC/dDTNqjrWMdShmKY7nqz1Yt0HQ+VlKvOoExCUEo01ceIXJy0Pc3gUN9n2KONrp1oSOfa0VUprmbocMwbIgcNSBwkyJbvUKdvXdeOYiJ6jZvpX6eBkcAj4NWcZpmXdmR43DJifT54WmNTaedwImJDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H9v5I+8b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H9v5I+8b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70AB61F00A3D;
	Thu, 30 Jul 2026 10:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785407388;
	bh=xLkItCEyyZeV7MXV2ehRTPvUNiSf4D3owmd1WVlzLTY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H9v5I+8bxY6vJu9YbmBmHdqiQwMRE007rfHzt2VPm+ZQrD77oSJCb0CVNrfFVk003
	 uUKe4EgXKfrns42qokAIdaOG09k4JJDoHKS3EI4yvBS8UBmtDHNT1d/4EWhbh0qc2U
	 n8/Bc1DPUB+e8KJerlH6nFOotC4TJsLiXP1OyiMe90SQItXutSGKAwlp/nnluXS7RC
	 uvnuZaRHz3NuaZ9oxUE2FO3Nb1uFZBU+ehLFS5PkNNT91+7MljGGy+FIxpl9KFN+VE
	 S22b3erkY8lJyzg4+MbLU50BdDibLJhf22fZAATN6Rf3d/WWHseK/AO+KMWS85mjxW
	 Uge/SG0bI7V2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 03/20] can: isotp: fix timer drain order, wakeup
 handling and tx_gen ordering
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org
In-Reply-To: <20260729102802.505168-4-mkl@pengutronix.de>
References: <20260729102802.505168-1-mkl@pengutronix.de>
 <20260729102802.505168-4-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 10:29:48 +0000
Message-Id: <20260730102948.70AB61F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Silently dropped asynchronous RX socket errors in isotp_sendmsg() =
due to ignored return value of sock_error(sk).
--

--- Patch [3]: [PATCH net 03/20] can: isotp: fix timer drain order, wakeup =
handling and tx_gen ordering ---
commit 3e2ba28e6e9e34bb3ea9b3075735283b9c9490c0
Author: Oliver Hartkopp <socketcan@hartkopp.net>
can: isotp: fix timer drain order, wakeup handling and tx_gen ordering

This commit addresses several concurrent state and timer handling issues in
the ISOTP protocol. It introduces a generation counter and packed result
array to track transfer state accurately across lock-free accesses.

Link: https://patch.msgid.link/20260724181525.43556-1-socketcan@hartkopp.net

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index 54becaf6898f1..1f11c66b343c8 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
[ ... ]
> @@ -1223,20 +1321,49 @@ static int isotp_sendmsg(struct socket *sock, str=
uct msghdr *msg, size_t size)
[ ... ]
>  	if (wait_tx_done) {
> -		/* wait for complete transmission of current pdu */
> -		err =3D wait_event_interruptible(so->wait, so->tx.state =3D=3D ISOTP_I=
DLE);
> +		/* wake up for:
> +		 * - concurrent sendmsg() claiming a new transfer
> +		 * - complete transmission of current PDU
> +		 * - shutdown state change in isotp_release()
> +		 * isotp_tx_gen_done() uses common tx.state/tx_gen read sequence
> +		 */
> +		err =3D wait_event_interruptible(so->wait,
> +					       isotp_tx_gen_done(so, my_gen));
>  		if (err)
>  			goto err_event_drop;
> =20
> -		err =3D sock_error(sk);
> -		if (err)
> -			return err;
> +		/* still our claim, but isotp_release() force-shut it down */
> +		if (smp_load_acquire(&so->tx.state) =3D=3D ISOTP_SHUTDOWN &&
> +		    READ_ONCE(so->tx_gen) =3D=3D my_gen) {
> +			err =3D -EADDRNOTAVAIL;
> +			goto err_event_drop;
> +		}
> +
> +		/* own completion, or tx_gen moved on - either way this is
> +		 * what isotp_get_tx_result() recorded for my_gen
> +		 */
> +		err =3D isotp_get_tx_result(so, my_gen);
> +
> +		/* drain to avoid stale error for a later poll()/SO_ERROR */
> +		sock_error(sk);

[Severity: High]
Does this unconditionally clear and discard concurrent asynchronous socket
errors?=20

By ignoring the return value of sock_error() here in isotp_sendmsg(), it
appears any unrelated RX errors (such as ETIMEDOUT set by
isotp_rx_timer_handler()) would be permanently lost without being reported
to the user.

Could this cause applications to hang in recvmsg() or poll() indefinitely
because they never see the RX connection failure?

> +
> +		return err ? err : size;
>  	}
> =20
>  	return size;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729102802.5051=
68-1-mkl@pengutronix.de?part=3D3
