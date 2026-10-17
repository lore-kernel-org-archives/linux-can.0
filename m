Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BC31F30BB
	for <linux-can@vger.kernel.org>; Sat, 17 Oct 2026 06:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792217507; cv=none; b=iDZW0RavMkyQGiQvZaQAA+pb/0pLzRHAXgPhrYq2r6FXpdbe1AgPGObIujVcvvdhMDscpZ+6xQQRAaX7uNAJyr5gzNym1m89zlHn/8RQY2E3f1Fib1uAoG9yWhj0DXUf4L2GB9WYfnY3OJ8LBlG0OcQUjBeLSRfKozQx0LcdwSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792217507; c=relaxed/simple;
	bh=FbSO5ON0kGxGnvupNIYBllDjI//sncYhkU3pg6Bhhj4=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=IFHxZ/L5wcGv0bKxkuvSeH4GGbuOM8ItUxHkiL/TkliuXhzzvine+cOjm83UUp7SXLsqcLuESV/NSRH6/kaJby74v7+V7Rc+AtAaALhJdTlOwUfh+5R1qaBVIhFldjKcpcfkOIG0fZ0v2zwCVUZOppxo/aa96EmL6V+elGhv3oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cexm1V4W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cexm1V4W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF0A11F000C4;
	Sat, 17 Oct 2026 06:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792217506;
	bh=WQODnyqvt+2YaEvhbt85rT0pWRTHG9VcsAAKkfWv7tw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Cexm1V4W/zzXlGFHXKA2hNxPgUS+GGX/Y66FlGIJgAins8ujuvDhdcI+GJEcTPgkh
	 jFicTt2ChU2u1nXlf+7nViSKJK6zyzsXEL4T/HZdCA5QkssuAh/zW2DnjJ17PKpOqv
	 HmdUfzou2Du+4K2TR6QItC9fMxm9M5awfyhPdt/WgCGi9cc042AI+jPSlZTSPTl0a2
	 sgjQ9iiXSG5JE72Uy+vHzVH88RSV9ERN+zSnreh/QpydJvJL8gNCUvC+kqHQC7yvuu
	 T2epliRImHKFcly7MkCHbAo0j8gj6ZKeJRxwHjsWfvGGwFJVXOnK5clRQtlgTVW/io
	 QAMLdYjOMmjAw==
Message-ID: <sashiko-outbox-175332@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 1/2] can: slcan: publish tty->disc_data only
 after register_candev()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chaosheng Qu" <chaosheng.qu.linux@gmail.com>
Cc: linux-can@vger.kernel.org, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <afc724d533dc3e7d6d423a641ecb6ca5b40451f7.1792118038.git.chaosheng.qu.linux@gmail.com>
References: <cover.1792118038.git.chaosheng.qu.linux@gmail.com>
 <afc724d533dc3e7d6d423a641ecb6ca5b40451f7.1792118038.git.chaosheng.qu.linux@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 06:11:45 +0000
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] can: slcan: permanent TX queue stall due to lost tty_wakeup
--

commit 97d420d988d6c139c8f2ceadb7c0d2d8b4b77ede
Author: Chaosheng Qu <chaosheng.qu.linux@gmail.com>

can: slcan: publish tty->disc_data only after register_candev()

This commit modifies slcan_open() to assign the private slcan structure to
the tty layer only after the network device is successfully registered. The
goal is to simplify the error handling path so that the pointer does not
need to be cleared if register_candev() fails.

> diff --git a/drivers/net/can/slcan/slcan-core.c b/drivers/net/can/slcan/s=
lcan-core.c
> index c9414faafe664..fc6ecf110aabf 100644
> --- a/drivers/net/can/slcan/slcan-core.c
> +++ b/drivers/net/can/slcan/slcan-core.c
> @@ -849,7 +849,6 @@ static int slcan_open(struct tty_struct *tty)
> =20
>  	/* Mark ldisc channel as alive */
>  	sl->tty =3D tty;
> -	tty->disc_data =3D sl;
> =20
>  	err =3D register_candev(dev);
>  	if (err) {
> @@ -858,6 +857,8 @@ static int slcan_open(struct tty_struct *tty)
>  		return err;
>  	}
> =20
> +	tty->disc_data =3D sl;

[Severity: Medium]
Does this change introduce a regression that leads to a permanent TX queue
stall?

Because register_candev() drops rtnl_lock internally and makes the network
device visible to userspace, an administrator could bring up the interface
and transmit a CAN packet while slcan_open() is still executing.

If the transmit buffer fills up, slcan_netdev_xmit() stops the queue and
relies on the UART hardware calling tty_wakeup() to restart it.

However, since slcan_open() still holds the ldisc_sem write lock (acquired
during tty_set_ldisc()), tty_wakeup() will fail to acquire the read lock:

drivers/tty/tty_io.c:tty_wakeup() {
	...
	ld =3D tty_ldisc_ref(tty);
	if (ld) {
		if (ld->ops->write_wakeup)
			ld->ops->write_wakeup(tty);
		tty_ldisc_deref(ld);
	}
	...
}

Will this cause tty_ldisc_ref() to silently drop the wakeup, leaving the
netdev queue permanently stopped?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792118038.gi=
t.chaosheng.qu.linux@gmail.com?part=3D1
