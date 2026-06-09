Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E96E3EB10F
	for <linux-can@vger.kernel.org>; Tue,  9 Jun 2026 18:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781031101; cv=none; b=NU3vpKezul5DqPG0CRCz7pLyBkVtUQ6lZcRVxXDfGO+jKZ10+W1kGCIXb0pSdRRixBYf7AoH281BsZLHEx1Jw03IrGMfQyJBHVW7fwtXj4cEdMFZAE6vi6Qw1TnclnhEraBrJvztpp+sMhB3vr0/QLriO+5W7szFmzWQK2g2LZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781031101; c=relaxed/simple;
	bh=dGLIHAPYNXvt7ViDk1IAvHi8uKqioO7LJgheeOQx4Lw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XhjzdqzdvVW57ct5CpMZOtQ3cgqy4MMKL3iPoLoZ1CSIO5IV40S7QYpFlDmUeH3XHagkqgbbEJZ3AzZ/UhTVY3N1lTj2UOx/eDmht+pUjx/uxkmpyvlzTYLieIuOWzqORakBFLXri+Z9zBE2Nc+bDAB2KbNgmsVtL7v52L918SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iwmEVUDz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwmEVUDz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E76CE1F00893;
	Tue,  9 Jun 2026 18:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781031099;
	bh=neEcZ1HiNbVAOnKx4RHlPaY0OidOPm3B/p7GRBlHz7c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iwmEVUDzwgg4SfW9C1d4qF9JSBX5qWnj1AOnFgdtz1ZHVrbhQxvWxbjUs4d63kU1A
	 gLO9O8pX0/It05pGsdHpz4xmSqWGcTFfT/MkUzPSEmp7y/SAKCOKNmtpVmb2fRIZ6v
	 99GlM0hSt4Q8kjHiAj1a6xWcZ9D+txycgdcMvKYW41Al+hDwmN6gfnP/1xXfxXN8jR
	 fufrd2hSQpWumVixYee1V7twKMy6/3P0o5tQU9295CPHeuGgL8/js8ueImGhAn9Cbd
	 Wi2GelitNgBmzj3rAICqPPTgBrFjAqiB4n5Ygh9s6oDQJe3IuBDp4fdFo5gXrE43kE
	 4B2yxhpVwFsgQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH can-next] can: bcm: mark intentional lockless read of
 bo->bound for KCSAN
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org
In-Reply-To: <20260601181915.71862-1-socketcan@hartkopp.net>
References: <20260601181915.71862-1-socketcan@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 18:51:38 +0000
Message-Id: <20260609185138.E76CE1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Lockless TOCTOU race in bcm_sendmsg() leads to unintended Global C=
AN Filter Leak.
--

commit 7f7ce41fd35425d40c8342127156c8195ff2363e
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: mark intentional lockless read of bo->bound for KCSAN

The commit marks the lockless read of bo->bound in bcm_sendmsg() and the
corresponding write in bcm_notify() with READ_ONCE() and WRITE_ONCE() to
resolve KCSAN warnings. It asserts this lockless read is functionally safe
and will safely drop downstream operations.

Closes: https://lore.kernel.org/linux-can/CAGp+u1aBK8QVjsvAxM2Ldzep4rEbsP9x=
_pV3At4g=3Dh1kVEtyhA@mail.gmail.com/

> Once the lock is acquired, any subsequent attempts to configure BCM
> jobs (like RX_SETUP) will safely fail because bcm_notify() has
> already cleared bo->ifindex to 0. While a user-defined ifindex of 0
> is normally a valid feature to listen on "all" CAN interfaces,
> bcm_notify() only triggers for specific real CAN devices. In this
> unregister context, the combination of bound=3D0 and ifindex=3D0 effectiv=
ely
> invalidates the socket binding. This prevents the registration of
> stale CAN filters and drops downstream operations safely without any
> memory corruption or stale state exploitation.

[Severity: High]
Is this description accurate regarding safely failing and preventing the
registration of stale CAN filters?

This is a pre-existing issue, but if bcm_notify() unregisters the device
concurrently, couldn't a race occur where bcm_sendmsg() caches ifindex =3D=
=3D 0
while still observing bo->bound =3D=3D 1?

Since bo->ifindex is a plain read at the top of bcm_sendmsg(), the compiler
can defer it until after the volatile read of bo->bound and the potentially
sleeping memcpy_from_msg().

If this happens, bcm_sendmsg() could observe bo->bound =3D=3D 1, but cache
bo->ifindex =3D=3D 0.

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index fd9fa072881e2..6c93c57212b49 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -1379,7 +1379,8 @@ static int bcm_sendmsg(struct socket *sock, struct =
msghdr *msg, size_t size)
>  	int cfsiz;
>  	int ret; /* read bytes or error codes as return value */
> =20
> -	if (!bo->bound)
> +	/* Lockless fast-path check for bound socket */
> +	if (!READ_ONCE(bo->bound))
>  		return -ENOTCONN;
> =20
>  	/* check for valid message length from userspace */

[Severity: High]
This isn't a bug introduced by this patch, but doesn't bcm_sendmsg() then
pass the cached ifindex =3D=3D 0 to bcm_rx_setup() under the socket lock?

net/can/bcm.c:bcm_sendmsg() {
    ...
    lock_sock(sk);

    switch (msg_head.opcode) {
    ...
    case RX_SETUP:
        ret =3D bcm_rx_setup(&msg_head, msg, ifindex, sk);
        break;
    ...
}

Does bcm_rx_setup() ever re-validate bo->bound while holding the lock?

If it doesn't, wouldn't bcm_rx_setup() interpret ifindex =3D=3D 0 as an exp=
licit
request to listen on all CAN interfaces?

net/can/bcm.c:bcm_rx_setup() {
    ...
    } else
        err =3D can_rx_register(sock_net(sk), NULL, op->can_id,
                              REGMASK(op->can_id),
                              bcm_rx_handler, op, "bcm", sk);
    ...
}

Could this actively register a global filter on an unbound socket, leaking
traffic from all CAN buses into a process that was only authorized to
monitor a specific, now-deleted interface?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601181915.7186=
2-1-socketcan@hartkopp.net?part=3D1
