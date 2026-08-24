Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872DE4334CD
	for <linux-can@vger.kernel.org>; Mon, 24 Aug 2026 16:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787587728; cv=none; b=qdICFwi+fyP/QerNLhzPvfDY0LTycl5mHCBin3SbXhUHV1MmElhJ2XjsHGtWDh1QqlyrJkE1L1Gc43Fa9JcOBWqrmINkqt1tEUMM1bBKWjfLK5l/3mmHfaIQXiBJ1W9rJG7PlwsbHYfZXjWeRMtiNqzlDeqxy2Soanj18ypfN2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787587728; c=relaxed/simple;
	bh=6n/Fu+nymvc2WKO+YU7uzEtuPHAz/bNYpvJ5Zm+Y1CA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rNq1fsGjvU5KYR0NbE4b3Bu/qAwGydD4puGYlEVEUdkpdVb3w6tP+W88p30hIN87EpMDuuZBM/iWmi04/dt3ugXZGBhc511c6Nz1sSp5lp9eOmFnYUSPM/yGfB4qs4LBfszl9hEH6H+R7iKD16HlFo0JOljQPvDzwHeAXmQjD6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BACG9lN3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BACG9lN3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FBFF1F000E9;
	Mon, 24 Aug 2026 16:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787587724;
	bh=KtOIgD6dK9Ul0ZJRXRz5/NUj1C/jerAlgeiBcvBOGIw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BACG9lN3V6bQ2/PbdkuFTZjwcO+pADq3y+/Inbotl1+WTHzztJoLLjnFkKHs+BpzB
	 YlbhXp2bUKIv3Bmp5/xQQU6BcyLQdWUIcR0+KoWmQlFqpeiCke2gZz4L5obzp0gLYj
	 ydVKQ10a5XrPPS3CqSvGCY7ZTxoMg9GJImtG6oEWHBEbjE9A596TMas9SmqB4yokL1
	 qt1tiOWqC2B5gNKdmfwfaDdIs/kCv9UNWeE01B8YLhARlF2XUeLDMcUSfHu7V1/s5G
	 sZdqEItQe9dnw2Rf0iPqd+4gDIXdDTap1P4ZSoT2/QJpflKg+BdVQykXYKQ7VLQ6Qi
	 bMz0EycSVupSw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] can: j1939: cancel all pending ECUs on device stop
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Antipov" <dmantipov@yandex.ru>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, linux-can@vger.kernel.org, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260824155406.246942-1-dmantipov@yandex.ru>
References: <20260824155406.246942-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 16:08:43 +0000
Message-Id: <20260824160844.4FBFF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] AB-BA deadlock between `priv->lock` and `hrtimer_cancel()` when st=
opping the device.
- [High] Unconditional cancellation of all ECUs on any socket closure break=
s address claiming for the entire CAN interface.

Pre-existing issues:
- [Critical] Unlocked list deletion in `__j1939_ecu_release()` leads to lis=
t corruption.
--

--- Patch [1]: [PATCH] can: j1939: cancel all pending ECUs on device stop -=
--
commit f80db37c4e58ab7d9daa72ce8c93a7552521ee48
Author: Dmitry Antipov <dmantipov@yandex.ru>

can: j1939: cancel all pending ECUs on device stop
   =20
This patch modifies the device stop routine to cancel all pending ECU
timers to prevent a situation where an ECU continues holding a reference
to the private data structure after the device stops processing.
   =20
Reported-by: syzbot+489e907b2a026a6f5fa0@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3D489e907b2a026a6f5fa0
Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")

> diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
> --- a/net/can/j1939/bus.c
> +++ b/net/can/j1939/bus.c
> @@ -96,6 +96,16 @@ void j1939_ecu_unmap(struct j1939_ecu *ecu)
>  	write_unlock_bh(&ecu->priv->lock);
>  }
> =20
> +void j1939_ecu_cancel_all(struct j1939_priv *priv)
> +{
> +	struct j1939_ecu *ecu, *tmp;
> +
> +	write_lock_bh(&priv->lock);
> +	list_for_each_entry_safe(ecu, tmp, &priv->ecus, list)
> +		j1939_ecu_timer_cancel(ecu);

[Severity: High]
Could this introduce an AB-BA deadlock with the timer callback?

The loop holds the lock while cancelling the timer:

write_lock_bh(&priv->lock);
list_for_each_entry_safe(ecu, tmp, &priv->ecus, list)
        j1939_ecu_timer_cancel(ecu);

If j1939_ecu_timer_handler() is currently executing on another CPU, it
will unconditionally attempt to acquire the exact same lock:

net/can/j1939/bus.c:j1939_ecu_timer_handler() {
    ...
    write_lock_bh(&priv->lock);
    ...
}

Would this cause hrtimer_cancel() to spin waiting for the callback to
finish, while the callback waits for the lock held by this thread?

[Severity: Critical]
This isn't a bug introduced by this patch, but iterating this list might
expose a pre-existing list corruption issue.

When j1939_ecu_timer_cancel() drops the reference via j1939_ecu_put(), or
when a temporary reference is dropped in j1939_ac_recv(), it can trigger
the final release:

net/can/j1939/bus.c:__j1939_ecu_release() {
    ...
    list_del(&ecu->list);
    ...
}

The list_del() executes without holding priv->lock. If this happens
concurrently while another thread is iterating priv->ecus (like the loop
introduced here), could it corrupt the list and cause a use-after-free or
kernel panic?

> +	write_unlock_bh(&priv->lock);
> +}
> +
>  void j1939_ecu_unmap_all(struct j1939_priv *priv)

[ ... ]

> diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
> --- a/net/can/j1939/main.c
> +++ b/net/can/j1939/main.c
> @@ -306,6 +306,7 @@ struct j1939_priv *j1939_netdev_start(struct net_devi=
ce *ndev)
> =20
>  void j1939_netdev_stop(struct j1939_priv *priv)
>  {
> +	j1939_ecu_cancel_all(priv);

[Severity: High]
Does unconditionally cancelling all ECUs here break address claiming for
the shared interface?

It appears j1939_netdev_stop() is called whenever any local user closes
a J1939 socket, but the CAN interface itself might still be in use by
other sockets. Calling j1939_ecu_cancel_all() before checking the shared
rx_kref count could disrupt network management for those remaining users.

>  	kref_put_mutex(&priv->rx_kref, __j1939_rx_release, &j1939_netdev_lock);
>  	j1939_priv_put(priv);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824155406.2469=
42-1-dmantipov@yandex.ru?part=3D1
