Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4B4379C42
	for <linux-can@vger.kernel.org>; Sat, 17 Oct 2026 06:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792217508; cv=none; b=PwokL7rKCam4/ZuNzomiymNBIM1o2SKBr+NmHti/q7+6+sTduwd4yWXYTt18qM9s3x+Bpqg28i4BXvj7hENsyyDsSpHaX/RF0EYWQyqPr3hDSxWE0o1BhqJ3Y45B8nGwGEPnTrDr+HciJVNb4AAFfGMAFWc4fOsAGPDkPrtxG2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792217508; c=relaxed/simple;
	bh=+phnDcJBwqudcnREbJw5ZYXbHU3tj5icIca7vEOxu2U=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=I0Gu1fjro10KcyvONOtBu7inuT4wYZlcknZyIXut9+CzTejQX+y86oyyb8CgiZKCfqrfYWIXP1Ah+5gg0AYc/ezLU0enTfM1NqAl/ItC3hoLTU3VqJ5XxvA/PrlVGqlBCLWOCkhTeP0hdBeka7z4zI5/JxSEfBB1a4XP9nwqTGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NEqWuixX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NEqWuixX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D33D1F000C5;
	Sat, 17 Oct 2026 06:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792217507;
	bh=wBU+LST8KyGa9Tf1e9KDvAmFed+Ou9O2W/csc3lcXKs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NEqWuixXkaoBHAGVFiVUUSpueYM9rprpjR905r5DpmdgbM8oq+g4eNQk/C3GB2kjY
	 jHS5BQuqAqHUFFjww1Rez9rdAJqbPQiz6X4cz81drktnb4KDowgtMqD8QC6LapdmnV
	 Tg6IGA6K5dQ9bIqzuluoWU6sYHw8VIQx8pqEvmYimQT8iGQGSe2nwhilutkvHExiS8
	 FnHtgfMOt4NqbJ4lA7CEOQ7ZHNfadXfyFcd82+vfkxKw8aWuy41YIBE9xkf4syRKLl
	 Q9dUVeHUf3E6ykVSv/0K2X34dfWaWeDCuwDwQGtMY07Ywb1yA+rUBpxu0kZH2x4O1Z
	 4/r7b10lzc2sA==
Message-ID: <sashiko-outbox-175333@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 2/2] can: can327: publish tty->disc_data only
 after register_candev()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chaosheng Qu" <chaosheng.qu.linux@gmail.com>
Cc: linux-can@vger.kernel.org, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <e02d5a1d31bb8dbc6397e3469cd0578b85d78970.1792118038.git.chaosheng.qu.linux@gmail.com>
References: <cover.1792118038.git.chaosheng.qu.linux@gmail.com>
 <e02d5a1d31bb8dbc6397e3469cd0578b85d78970.1792118038.git.chaosheng.qu.linux@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 06:11:46 +0000
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] can327: lost tty_wakeup due to netdev registration before ldisc_=
sem unlock
--

commit db9e26aa5c7ca57012c78c9e24a1886bd4102174
Author: Chaosheng Qu <chaosheng.qu.linux@gmail.com>

can: can327: publish tty->disc_data only after register_candev()

This commit modifies the can327 line discipline to assign tty->disc_data
only after register_candev() completes successfully. This prevents the
error path from unwinding while leaving a stale pointer in tty->disc_data
if device registration fails.

> diff --git a/drivers/net/can/can327.c b/drivers/net/can/can327.c
> index 90f5e35f3c8f9..d40dadbb57330 100644
> --- a/drivers/net/can/can327.c
> +++ b/drivers/net/can/can327.c
> @@ -1037,7 +1037,6 @@ static int can327_ldisc_open(struct tty_struct *tty)
> =20
>  	/* Mark ldisc channel as alive */
>  	elm->tty =3D tty;
> -	tty->disc_data =3D elm;
> =20
>  	/* Let 'er rip */
>  	err =3D register_candev(elm->dev);
> @@ -1046,6 +1045,8 @@ static int can327_ldisc_open(struct tty_struct *tty)
>  		return err;
>  	}
> =20
> +	tty->disc_data =3D elm;
> +

[Severity: Medium]
Does this sequence result in a lost wakeup that can permanently stall
transmissions?

By calling register_candev() here, the network device is exposed to userspa=
ce
before can327_ldisc_open() returns. If userspace asynchronously brings the
interface up, it can trigger a transmission that eventually results in a ca=
ll
to tty_wakeup() when the UART transmits.

However, the caller of can327_ldisc_open() (which is tty_set_ldisc() in
drivers/tty/tty_ldisc.c) holds tty->ldisc_sem for writing.

When tty_wakeup() runs, it tries to get the ldisc safely:

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

Because ldisc_sem is still held for writing by the open path, tty_ldisc_ref=
()
fails to acquire the read lock and returns NULL. This causes tty_wakeup()
to silently skip the write_wakeup callback.=20

If the wakeup is lost, the transmission remains permanently stalled, leaving
the CAN interface bricked until it is manually brought down and back up. The
commit message notes that tty_ldisc_ref() serializes against the open path,
but relies on skipping the wakeup to prevent a use-after-free. Could we
defer registering the network device until after the ldisc semaphore is
released, or is there another way to prevent the transmission stall?

>  	netdev_info(elm->dev, "can327 on %s.\n", tty->name);
> =20
>  	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792118038.gi=
t.chaosheng.qu.linux@gmail.com?part=3D2
