Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2157C29B8E1
	for <linux-can@vger.kernel.org>; Fri, 17 Jul 2026 06:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784270891; cv=none; b=FNW7Njj5UPb+kxSTXNRyufsT7JPxL01yjJGGQZp1rNCMKtlDQTydmTukHmagqLsR7ifvtLl7uezLYYv+3VyDfc9jjt6kOqfuIbUMjFmkFGIm9zAdil1Onk0Fa//fR3ZGuARr6oKxw/8gAPGpgskYiBiVXFWMfE8XGFbqyO8dff0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784270891; c=relaxed/simple;
	bh=tM5EPRszyDhBbQQcFRcRgKZI19b4xN7G/Ac5Yzaq/dg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BgAPiw12BQvN2vjWgiaulyONt+deR9bCZxCwqNfSKf9HW3xEjEaVWV8n4gY4an34oLZznsq9aRFrtAIruAXJT8dMU+KwfqfIBi3Ee6vMhSjIgcrgSGWztzyNL8sNSeiEomASgsFkOhHCIa+2YAm3kDRA8o0csvbFVXnGHpv7Wig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhMkCugt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhMkCugt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D025B1F000E9;
	Fri, 17 Jul 2026 06:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784270886;
	bh=bXpOnGf/lifGpuouRI3RQDk034nF804bTTsVg7gzK0o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fhMkCugtMxiXrG7o/IClkHsniM8jYjbKNbbMZfXk6vJkd2OzSKxvo+H4NiZlvz/vC
	 OhNomXjh1YhONuW7CGz9yjl5uE9N6CKrQBuUtxXS9BDJbLV2Ve9tu9GrD2Cnn7jjvx
	 S8sK7kp3KzQxT8mDf5q1eBA5nbq7ET4zaIK4co/+ux39e+QqI21mSqo5W9F2oQswYn
	 CFCAnNbu7ShJlXePLj1aHujP0iF5QpOWGskSqjTr0tz+Qng1OkIAlhpVfFFPwP1/oe
	 Kh8DBWRIQD/IbZ8FyFbmz9r92ZLtc+ZRLvCiVrNH8CjypBuhmyiMRgNCOBDgy5HfD/
	 LZl6XBfsPqDDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tty: ldisc: fix deadlock between ldisc_sem and
 rtnl_mutex
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yun Zhou" <yun.zhou@windriver.com>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org
In-Reply-To: <20260716064719.1401892-1-yun.zhou@windriver.com>
References: <20260716064719.1401892-1-yun.zhou@windriver.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 06:48:05 +0000
Message-Id: <20260717064805.D025B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Concurrent read/write/poll system calls spuriously return EOF or E=
IO during line discipline transitions, breaking UAPI.

Pre-existing issues:
- [High] The circular lock dependency between ldisc_sem and rtnl_mutex is n=
ot fully resolved, remaining on the error handling and hangup paths.
--

--- Patch [1]: [PATCH] tty: ldisc: fix deadlock between ldisc_sem and rtnl_=
mutex ---
commit bb627a1c685e7cab3f8500d0d87506f028ebe9fe
Author: Yun Zhou <yun.zhou@windriver.com>

tty: ldisc: fix deadlock between ldisc_sem and rtnl_mutex

This commit aims to fix a circular lock dependency between the tty ldisc_sem
and the networking rtnl_mutex. It does this by modifying tty_set_ldisc() to
call the line discipline open() callback outside of the ldisc_sem write loc=
k.

Closes: https://syzkaller.appspot.com/bug?extid=3Dde610eeef174bd59a8a3

> diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
> index 27fe8236f6623..248a6995cc53a 100644
> --- a/drivers/tty/tty_ldisc.c
> +++ b/drivers/tty/tty_ldisc.c
> @@ -556,15 +556,28 @@ int tty_set_ldisc(struct tty_struct *tty, int disc)
>  	/* Shutdown the old discipline. */
>  	tty_ldisc_close(tty, old_ldisc);
> =20
> -	/* Now set up the new line discipline. */
> -	tty->ldisc =3D new_ldisc;
> +	/* Clear tty->ldisc so concurrent readers back off during transition */
> +	tty->ldisc =3D NULL;
>  	tty_set_termios_ldisc(tty, disc);
> +	tty_ldisc_unlock(tty);

[Severity: High]
Does unlocking the semaphore while the ldisc pointer is NULL introduce a UA=
PI
break for concurrent operations?

If a concurrent process calls read(), write(), or poll() during this unlock=
ed
window, it can enter tty_ldisc_ref_wait() in drivers/tty/tty_io.c. Because =
the
semaphore was unlocked here, tty_ldisc_ref_wait() will successfully acquire
the read lock but observe tty->ldisc as NULL.

This causes the reader to immediately return EOF or -EIO, potentially
aborting userspace applications unexpectedly during a line discipline
transition.

> +
> +	/*
> +	 * Open the new discipline outside ldisc_sem. The ldisc .open()
> +	 * may acquire locks (e.g., rtnl_mutex) that would create circular
> +	 * dependencies if taken under ldisc_sem. tty_lock is still held,
> +	 * preventing concurrent ldisc changes and hangup.
> +	 */
>  	retval =3D tty_ldisc_open(tty, new_ldisc);
> +
> +	tty_ldisc_lock(tty, MAX_SCHEDULE_TIMEOUT);
> +
>  	if (retval < 0) {
>  		/* Back to the old one or N_TTY if we can't */
>  		tty_ldisc_put(new_ldisc);
>  		tty_ldisc_restore(tty, old_ldisc);

[Severity: High]
This is a pre-existing issue, but does this fully resolve the circular lock
dependency?

If tty_ldisc_open() fails above, the error path calls tty_ldisc_restore(),
which eventually calls tty_ldisc_failto(). Inside tty_ldisc_failto(),
tty_ldisc_open() is called while the ldisc_sem write lock is held.

Similarly, during hangup processing, tty_ldisc_reinit() calls tty_ldisc_ope=
n()
while holding the ldisc_sem write lock.

If the restored or reinitialized discipline acquires rtnl_mutex on these pa=
ths,
it appears the lock inversion and potential deadlock would still occur.

> +	} else {
> +		/* Success - install new ldisc */
> +		tty->ldisc =3D new_ldisc;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716064719.1401=
892-1-yun.zhou@windriver.com?part=3D1
