Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E99E56A
	for <linux-can@vger.kernel.org>; Sun, 12 Jul 2026 14:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783865029; cv=none; b=mMhPGCMiLgOb9mq8aMH3fKLebVQANBdwkDlcjyWlPOcSRcv/KcaxV5JfjKo5is8wMO958bOV+hhs/vuN9owcGkXYwXSD3UXI9jKg/ACmFISHbBWfw28AWnXMk3a65rbXx5YtAEBOfhxl4mGPYNWB31Auh8if10+kpybcoj0rCCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783865029; c=relaxed/simple;
	bh=8M5+DACO4FSKjDVOFkmuvTmbZ1vrnejmbQqYurqjUZQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BP73nPjm0Z47v+Bl9hKhI4xaPwdlhX2FfTVe4CzAHQVS7qvyN87byWaf0LGGjHk5hwH1SpIxX+X4oAiKdOGjVSgHwXNv1MX5+q0ItW0jvDMrHVNbtHuO1CihqTkKuAxlF97eQ6O7alyQ7DBalr3A7Rzws3fjSaa61fiICALOM4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BlH1uN2U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BlH1uN2U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CBA41F000E9;
	Sun, 12 Jul 2026 14:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783865027;
	bh=BlvCG/bn63cQLoVfFEkJl+Egol/yvdj2zEkqW1qHLEI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BlH1uN2Uq9i7eGANfUptOeYoSSOmW8/mANRahfk2P6QOP0Mol3hA70zLp231YUhKq
	 FNUuUx8XI6i5uDOgPzKcSsP2VyqBXHlXLTaDxXqzsrdq+VuEOY0HBXuqybzEHFsKqG
	 /rcr76J/t+u5NrLgd8sCd8OVlzJuYqrAzxCwJ5shUTWfjGTnTpj+nJtmL0V727ZNul
	 ofix0FBsuCA/UlwNi3oIhDleunTs9ztkqThW9uDvVD0/uqbQrFF24uQAArTLyxWHEQ
	 MiLbf/YoA6m9Pf6i6evL8wY1XRrvGueF9QFuTR/gIe4Iwp45Gm/5WzNgF04qozGs/U
	 p/2VHB45WTZLA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 1/4] can: isotp: use unconditional synchronize_rcu()
 in isotp_release()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org
In-Reply-To: <20260712-isotp-fixes-v9-1-137840d7f0f4@hartkopp.net>
References: <20260712-isotp-fixes-v9-0-137840d7f0f4@hartkopp.net>
 <20260712-isotp-fixes-v9-1-137840d7f0f4@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 12 Jul 2026 14:03:46 +0000
Message-Id: <20260712140347.6CBA41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Unconditional `synchronize_rcu()` in `isotp_release()` can be tr=
iggered by unprivileged users via unbound sockets.

Pre-existing issues:
- [High] Concurrent isotp_sendmsg() callers can forcibly abort another thre=
ad's active transmission upon receiving a signal.
--

--- Patch [1]: [PATCH v9 1/4] can: isotp: use unconditional synchronize_rcu=
() in isotp_release() ---
commit d8a6dd60eabcde6d6f502a2471ec7e04cf918503
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: isotp: use unconditional synchronize_rcu() in isotp_release()

This patch makes isotp_release() always call synchronize_rcu() before
cancelling timers to close a race condition when a concurrent
NETDEV_UNREGISTER clears so->bound.

Link: https://lore.kernel.org/linux-can/20260707085210.6B6C01F000E9@smtp.ke=
rnel.org/

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index c48b4a818297e..d30937345bcdc 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
[ ... ]
> @@ -1237,11 +1237,18 @@ static int isotp_release(struct socket *sock)
>  						  SINGLE_MASK(so->txid),
>  						  isotp_rcv_echo, sk);
>  				dev_put(dev);
> -				synchronize_rcu();
>  			}
>  		}
>  	}
> =20
> +	/* Always wait for a grace period before touching the timers below.
> +	 * A concurrent NETDEV_UNREGISTER may have already unregistered our
> +	 * filters and cleared so->bound in isotp_notify() without waiting
> +	 * for in-flight isotp_rcv() callers to finish, so this call must not
> +	 * be skipped just because so->bound is already 0 here.
> +	 */
> +	synchronize_rcu();
> +

[Severity: Medium]
Could this unconditional synchronize_rcu() be triggered rapidly by
unprivileged users?

If an unprivileged user creates an unbound CAN_ISOTP socket and closes it
immediately, it appears it will now hit this synchronize_rcu() in
isotp_release() because so->bound is no longer checked.=20

Might a rapid loop of socket creation and destruction allow local
unprivileged users to degrade system performance by constantly blocking for
RCU grace periods?


This is a pre-existing issue, but I noticed a potential race condition in
isotp_sendmsg() when handling signals.

[Severity: High]
Can a thread interrupted by a signal forcibly abort another thread's active
transmission?

If multiple threads call isotp_sendmsg() on the same socket, the function
uses cmpxchg() to gain exclusivity over the TX state machine. If a thread
fails the cmpxchg and waits in wait_event_interruptible(), but is then
interrupted by a signal, it jumps to err_event_drop:

net/can/isotp.c:isotp_sendmsg() {
...
err_event_drop:
        /* got signal: force tx state machine to be idle */
        so->tx.state =3D ISOTP_IDLE;
        hrtimer_cancel(&so->txfrtimer);
        hrtimer_cancel(&so->txtimer);
...
}

Does this forcible state reset to ISOTP_IDLE and timer cancellation happen
even though the interrupted thread does not own the state machine? This
appears to abort the active transmission and could allow a third thread to
pass the cmpxchg, leading to concurrent execution of isotp_sendmsg() on the
same so->tx variables.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260712-isotp-fixe=
s-v9-0-137840d7f0f4@hartkopp.net?part=3D1
