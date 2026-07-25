Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794FB4908CA
	for <linux-can@vger.kernel.org>; Sat, 25 Jul 2026 08:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784969270; cv=none; b=LfcebgLNNuYTjY8YUyBniJmr5iQlDVn+CmXTKdVAxqALmfa2gwAnVTUqeg2egwLyUoyWLDFR7PbmhZJ2g5/KGg4ByxSKFDWfVo5/NF+AwpI+l50U12IbSlvCzb9PRX/tbkrLZxLkhqq0Lju+dXEaqLOlusZHybgtozaaPGhPdlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784969270; c=relaxed/simple;
	bh=UXTm02nefb8ksukj1yqrwgtmjllVWnKGyY47reOlZ0U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fIDTQZe7cHQRpo7ZCzU83oDwPtlMy+9lxe5nWJlpmt1pSDjCsY2Qm4UPFR3YGqAUfejxfEZTJe0WzttcbCG2WVQtQRhpvKJiUGPdvnHnTTLqBgTWV/j4HX7zayQ11Hs9qRGU42kpg7GMIl7aQRCOPSByr0Yy8YQosJztjpA3nhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYarsA8r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYarsA8r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C82601F00A3A;
	Sat, 25 Jul 2026 08:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784969269;
	bh=zsb5vSMZnQPnvauzqVbxtiLkrcwl1bTe6P6RpTGEBz0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YYarsA8r3G2MdP3AFPeN8Oc4puJbMimnqz235VEmNQytCFI5lbX3AufoFy1O0c6ZB
	 g3LzTlL5GSL657CQjGGStG/Z9CpUA4+bP2DK+N6QdiSMi519ek60aA8Ln6XhbC9fQZ
	 debRSkItZGU/hlb6DGsm6FKID8RsDnykDRh63t7QM5d8UM3YC5Cs5Y+NHtM5URIqyv
	 3wovxW4neuKRgUDjWU094TqC5gClcytpMnAZp8cTotzSce0MOexfrcsE5WA9L7w1BK
	 vDUnb73LTcTG9Ni1J8/A6t9JuJQoARNjtrE77nLuOrR1HJBnoiSSXsQ2RTVPf7Tb+r
	 jhrF2GwBVpn5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] tty: ldisc: fix deadlock between ldisc_sem and
 rtnl_mutex
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yun Zhou" <yun.zhou@windriver.com>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>
In-Reply-To: <20260724084648.3879356-1-yun.zhou@windriver.com>
References: <20260724084648.3879356-1-yun.zhou@windriver.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 08:47:48 +0000
Message-Id: <20260725084748.C82601F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The patch replaces a lockdep splat with a silent waitqueue deadloc=
k on the success path.

Pre-existing issues:
- [High] Incomplete fix for circular locking between ldisc_sem and rtnl_mut=
ex, leaving deadlocks on teardown, error, and hangup paths.
--

--- Patch [1]: [PATCH v3] tty: ldisc: fix deadlock between ldisc_sem and rt=
nl_mutex ---
commit 98cde28b47f83f4a2bf71bb1e35f53d9a7a36294
Author: Yun Zhou <yun.zhou@windriver.com>

tty: ldisc: fix deadlock between ldisc_sem and rtnl_mutex
   =20
This commit attempts to fix a circular lock dependency between ldisc_sem
and rtnl_mutex reported by syzbot. It moves the tty line discipline .open()
callback outside the ldisc_sem write lock in tty_set_ldisc(). It also adds
logic in tty_ldisc_ref_wait() to wait for the ldisc transition to complete.

Closes: https://syzkaller.appspot.com/bug?extid=3Dde610eeef174bd59a8a3

> diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
> index 27fe8236f6623..6ec93e6b84988 100644
> --- a/drivers/tty/tty_ldisc.c
> +++ b/drivers/tty/tty_ldisc.c
> @@ -242,6 +242,16 @@ struct tty_ldisc *tty_ldisc_ref_wait(struct tty_stru=
ct *tty)
> =20
>  	ldsem_down_read(&tty->ldisc_sem, MAX_SCHEDULE_TIMEOUT);
>  	ld =3D tty->ldisc;
> +	while (!ld && !test_bit(TTY_HUPPED, &tty->flags)) {
> +		ldsem_up_read(&tty->ldisc_sem);
> +
> +		/* ldisc may be NULL during a discipline switch; wait and retry */
> +		wait_event(tty->read_wait,
> +			   READ_ONCE(tty->ldisc) !=3D NULL ||
> +			   test_bit(TTY_HUPPED, &tty->flags));

[Severity: High]
Does this wait_event() create a silent waitqueue deadlock that replaces the
lockdep splat?

If thread A switches to a network ldisc like slcan, it will set tty->ldisc
to NULL in tty_set_ldisc() and drop ldisc_sem, but then block waiting for
rtnl_mutex in the .open() callback.

Concurrently, if thread B already holds rtnl_mutex and calls tty_poll(),
it enters tty_ldisc_ref_wait() here. Thread B will observe tty->ldisc as NU=
LL
and block uninterruptibly in this wait_event(), waiting for thread A to
re-assign tty->ldisc.

Since thread A is blocked waiting for thread B to release rtnl_mutex,
will both threads hang forever without a lockdep warning?

> +		ldsem_down_read(&tty->ldisc_sem, MAX_SCHEDULE_TIMEOUT);
> +		ld =3D tty->ldisc;
> +	}
>  	if (!ld)
>  		ldsem_up_read(&tty->ldisc_sem);

[ ... ]

> @@ -556,15 +566,28 @@ int tty_set_ldisc(struct tty_struct *tty, int disc)
>  	/* Shutdown the old discipline. */
>  	tty_ldisc_close(tty, old_ldisc);

[Severity: High]
This is a pre-existing issue, but does this leave the deadlock intact on
teardown and error paths?

The tty_ldisc_close() function is called here while the ldisc_sem write
lock is held. For network ldiscs like slcan, the ops->close() callback
will acquire rtnl_mutex, which perfectly preserves the original deadlock:

tty_set_ldisc()
  tty_ldisc_lock()       <-- acquires ldisc_sem
  tty_ldisc_close()
    ld->ops->close()     <-- acquires rtnl_mutex

Similarly, on error fallback paths (like tty_ldisc_restore() calling
tty_ldisc_failto()), and during hangup in tty_ldisc_reinit(), both close()
and open() are called while holding the ldisc_sem write lock.

If userspace triggers a fallback to slcan, or a hangup occurs while
slcan is active, won't the deadlock still occur?

> -	/* Now set up the new line discipline. */
> -	tty->ldisc =3D new_ldisc;
> +	/* Clear tty->ldisc so concurrent readers back off during transition */
> +	tty->ldisc =3D NULL;
>  	tty_set_termios_ldisc(tty, disc);
> +	tty_ldisc_unlock(tty);
> =20
> +	/*
> +	 * Open the new discipline outside ldisc_sem. The ldisc .open()
> +	 * may acquire locks (e.g., rtnl_mutex) that would create circular
> +	 * dependencies if taken under ldisc_sem. tty_lock is still held,
> +	 * preventing concurrent ldisc changes and hangup.
> +	 */
>  	retval =3D tty_ldisc_open(tty, new_ldisc);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724084648.3879=
356-1-yun.zhou@windriver.com?part=3D1
