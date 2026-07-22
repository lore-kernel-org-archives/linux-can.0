Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123FB3D955F
	for <linux-can@vger.kernel.org>; Wed, 22 Jul 2026 08:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784710322; cv=none; b=UgaGxv9M7JzwVRwK0B+Jx2hMp0Xe7ChkRRyhSYxuWcqURXWy269XNqqpgJbPYGZocOxfbCwSmFk9WyDWv7Dy3ofJsDuB4464v4oT/sPIRid5PZRWQKN9DZPgPOG9kooe/sekbtMgXfzWdWb6eR77NkQR/YVkz2hDn95c7sINcVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784710322; c=relaxed/simple;
	bh=9ryw/eTPaq5U+9IeUFTMSN4EBK20meREpuVdkLdNUcM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jYvvOqPeezu95kE7vaOBHaSd94XWk0GpXo6gF5IGFf5dCpsZPYYTyk/2HWeudYc7DzCXzopZCh81HIArE1kCOs0Th0WG0UuGl6u/hA7uGDGnyMB1KUuAnixJ+BoLlAJGuQxtqnKwaVgy3jrAt7pznEwES+gJlRa3qtm4QoJqDj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MSA03qiA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MSA03qiA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38F681F00A3D;
	Wed, 22 Jul 2026 08:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784710320;
	bh=HdcW6bXbLbD8KkqR4DnuFHYks7pH2RNTcE3gRX8D7WY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MSA03qiACiFtUNMaQRFxjbpjDNuAGfeAM2KY532qsPH/0AObOjy7S6hS8meddFXI5
	 76WZyfn9ky9KO8ZiA5p2pXHoDrhYqHt2dyk087JuHgDpbdca0iwJOMXadBKC8YN5fK
	 J9WJwVIDnQgHKjvanDTet4hXqtsOJ3eII5hBQtLJm+vt2iBzzr1huGK2/K45jffD43
	 Z0pCgVu2MOVBGfxUvex4N7GBwCqmJnrnQ+5pfg6nvaEpKF5X4+U2xtPPpt3U5lNXgz
	 sYAyT7WWRCZJTCp/FxP1qlX27E3kXgvKKqvkk3zHBLwo+5+wZUYdj9Z3NniGG3khxN
	 HGMWRMIUwZ7Mw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] tty: ldisc: fix deadlock between ldisc_sem and
 rtnl_mutex
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yun Zhou" <yun.zhou@windriver.com>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>
In-Reply-To: <20260721085035.2485657-1-yun.zhou@windriver.com>
References: <20260721085035.2485657-1-yun.zhou@windriver.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 08:51:58 +0000
Message-Id: <20260722085200.38F681F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] A Time-of-Check to Time-of-Use (TOCTOU) race condition in `tty_l=
disc_ref_wait` can cause spurious EOF or -EIO errors for concurrent readers.

Pre-existing issues:
- [High] The circular lock dependency (ldisc_sem -> rtnl_mutex) is not full=
y resolved in error fallback, hangup, and teardown paths.
--

--- Patch [1]: [PATCH v2] tty: ldisc: fix deadlock between ldisc_sem and rt=
nl_mutex ---
commit aa2b45f5a2e0cd2e80f19ce89583432e4e6eb9e4
Author: Yun Zhou <yun.zhou@windriver.com>

tty: ldisc: fix deadlock between ldisc_sem and rtnl_mutex

syzbot reported a circular lock dependency involving tty ldisc_sem and
the networking rtnl_mutex. Fix by moving the .open() call outside the
ldisc_sem write lock.

Closes: https://syzkaller.appspot.com/bug?extid=3Dde610eeef174bd59a8a3

> diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
> index 27fe8236f6623..bd94a1f13c44c 100644
> --- a/drivers/tty/tty_ldisc.c
> +++ b/drivers/tty/tty_ldisc.c
> @@ -242,8 +242,20 @@ struct tty_ldisc *tty_ldisc_ref_wait(struct tty_stru=
ct *tty)
> =20
>  	ldsem_down_read(&tty->ldisc_sem, MAX_SCHEDULE_TIMEOUT);
>  	ld =3D tty->ldisc;
> -	if (!ld)
> +	if (!ld) {
>  		ldsem_up_read(&tty->ldisc_sem);
> +
> +		/* ldisc may be NULL during a discipline switch; wait and retry */
> +		if (!test_bit(TTY_HUPPED, &tty->flags)) {

[Severity: Medium]
Could this if statement lead to a Time-of-Check to Time-of-Use (TOCTOU)
race condition returning spurious EOF or -EIO to concurrent readers?

If a reader thread waits here for a discipline switch to finish, the writer
finishes, wakes up the reader, and drops tty_lock. Before the reader can
acquire ldisc_sem(read) again, a third thread could initiate another line
discipline switch, acquiring tty_lock and setting tty->ldisc =3D NULL.

Since this uses an if statement instead of a while loop, wouldn't the reader
see NULL again and incorrectly return NULL without retrying?

> +			wait_event(tty->read_wait,
> +				   READ_ONCE(tty->ldisc) !=3D NULL ||
> +				   test_bit(TTY_HUPPED, &tty->flags));
> +			ldsem_down_read(&tty->ldisc_sem, MAX_SCHEDULE_TIMEOUT);
> +			ld =3D tty->ldisc;
> +			if (!ld)
> +				ldsem_up_read(&tty->ldisc_sem);
> +		}
> +	}
>  	return ld;
>  }

[ ... ]

> @@ -556,15 +568,28 @@ int tty_set_ldisc(struct tty_struct *tty, int disc)
>  	/* Shutdown the old discipline. */
>  	tty_ldisc_close(tty, old_ldisc);

[Severity: High]
This is a pre-existing issue, but doesn't the circular lock dependency
still exist in the teardown, hangup, and error fallback paths?

Switching away from a network line discipline (like slcan or slip) calls
.close() here while ldisc_sem is held for write. The .close() callback calls
unregister_netdev(), acquiring rtnl_mutex.

Similarly, if opening a new discipline fails, the fallback tty_ldisc_failto=
()
calls .open() under ldisc_sem, recreating the exact same deadlock. The same
happens in tty_ldisc_reinit().

> -	/* Now set up the new line discipline. */
> -	tty->ldisc =3D new_ldisc;
> +	/* Clear tty->ldisc so concurrent readers back off during transition */
> +	tty->ldisc =3D NULL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721085035.2485=
657-1-yun.zhou@windriver.com?part=3D1
