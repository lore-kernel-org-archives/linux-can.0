Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06763DC4C9
	for <linux-can@vger.kernel.org>; Thu, 27 Aug 2026 11:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787830424; cv=none; b=ttioUtlptBI/CC3+43oLqckdcyFkVsVSbKrYyHsgrrbx3oz8b8NVqDQWdubhuRkt2YY4aRcfHonhDYMd7kNI8XZT0uUgj2UAC+bcApE/xBOCo9XGuNmcGfK2yq4VYI4MP2xUBTp/f5Km7gGqtByVqBaUmhN5jSDz8pd20jo9JOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787830424; c=relaxed/simple;
	bh=RKewpoT59q6+V04BrrO+dNO5b8NhpuyHCLYBN9C7GeE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Fp2gdQhNRaX1xBLX63poN9k51jb4PUOVpcGV2hI3c1Qh44VWUTr9ZFeEZZW5n9ePsGj58zJIAWbeD9VecFa08/GoIgf/GxCng/T4LdA543XXZYyX874nStu+suee7RzeAk+HaLe3jfcNgZV8eU40b4MRxF4zmRGVw+tBY901Quw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JG5nAZGw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JG5nAZGw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5FFD1F000E9;
	Thu, 27 Aug 2026 11:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787830423;
	bh=MwHpL05zZ8Z/vkDhJ5jTapWRuA5X0FZNP4bXqSiNK+0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JG5nAZGwlmUqR7qH+SFg3a3zUh9LbuAcpgAyAT78bUPW3UGNNhvSFdetk3EcXj+Za
	 nZHCk1PeN7L6dJDGAYuIQzKV+1azQd77e03x/az6d9sHGfUU5FzPjCRcbzAQQFkRcd
	 /gTNs0svJzTa0k4ZgeTzuAaoO71ohIvs6D4GeWl8jRSgBuv8W95E190NPuqlG1gkHv
	 Ho4Uu9/ox11TOSbI9CtZVsfFK3ftG0aVbnZtSMtXY1p4URpGbdKMlmNOQ3ALn2DgIJ
	 nJlTWj3G1br5n8dgBN7vsqJ6GAxpmuuV0FpZK0b2iZK2PjQOnEnQ4ODT9dfPMHfL6j
	 1HbBuiDzignkQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] can: j1939: cancel all pending ECUs on device stop
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Antipov" <dmantipov@yandex.ru>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>
In-Reply-To: <20260827111410.20401-1-dmantipov@yandex.ru>
References: <20260827111410.20401-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 11:33:42 +0000
Message-Id: <20260827113342.E5FFD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] ABBA deadlock between `j1939_ecu_cancel_all()` and `j1939_ecu_time=
r_handler()` due to a TOCTOU race condition.
- [High] Use-After-Free in `hrtimer_cancel()` when the ECU is freed by the =
timer callback.
- [High] Lockless ECU reference drop in the fast-path causes concurrent lis=
t modification and corruption.
- [Medium] Erroneous `lockdep_assert_held()` check in the timer callback wi=
ll cause false-positive warnings.
--

commit f501d51ab1fd28cee33a268e9dffc6800425d782
Author: Dmitry Antipov <dmantipov@yandex.ru>

can: j1939: cancel all pending ECUs on device stop
   =20
This commit cancels all pending ECUs in j1939_netdev_stop() to prevent
the stopped device from processing ECUs, avoiding scenarios where the
j1939_priv struct is never freed.
   =20
Closes: https://syzkaller.appspot.com/bug?extid=3D489e907b2a026a6f5fa0

> diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
> index cdc3c0a719379..9511134313a7d 100644
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
Does holding write_lock_bh(&priv->lock) during synchronous timer
cancellation here risk an ABBA deadlock?

j1939_ecu_timer_cancel() calls hrtimer_cancel(), which spins waiting for
the timer callback to finish. If j1939_ecu_timer_handler() runs
concurrently on another CPU, could it read priv->stop =3D=3D 0 (due to a TO=
CTOU
race just before priv->stop is updated) and attempt to acquire the same
lock:

j1939_ecu_timer_handler() {
    ...
    } else {
        write_lock_bh(&priv->lock);
    ...
}

This sequence would leave hrtimer_cancel() spinning for the callback, while
the callback spins for priv->lock, resulting in a deadlock.

> +	write_unlock_bh(&priv->lock);
> +}
> +
[ ... ]
> @@ -131,18 +141,23 @@ static enum hrtimer_restart j1939_ecu_timer_handler=
(struct hrtimer *hrtimer)
>  		container_of(hrtimer, struct j1939_ecu, ac_timer);
>  	struct j1939_priv *priv =3D ecu->priv;
> =20
> +	/* We're asked to stop from j1939_netdev_stop(). */
> +	if (unlikely(atomic_read(&priv->stop))) {
> +		lockdep_assert_held(&priv->lock);

[Severity: Medium]
Is this lockdep assertion correct for an asynchronous timer callback?

Since hrtimer callbacks execute asynchronously in softirq context, the
callback does not inherently hold priv->lock, regardless of whether
j1939_netdev_stop() holds it on another CPU. Because lockdep verifies the
current execution context, won't this unconditionally trigger a warning?

> +		j1939_ecu_put(ecu);

[Severity: High]
Does dropping the ECU reference here without priv->lock risk list corruption
and a use-after-free?

If j1939_ecu_put() drops the final reference, __j1939_ecu_release() will be
called, which performs an unprotected list deletion:

__j1939_ecu_release() {
    ...
    list_del(&ecu->list);
    ...
}

Because this happens concurrently with j1939_ecu_cancel_all() traversing
the list using list_for_each_entry_safe() on the shutdown CPU, this
could corrupt the linked list.

Additionally, if the ECU is freed via kfree(ecu) in this path, what
happens to the CPU executing hrtimer_cancel(&ecu->ac_timer) inside
j1939_ecu_timer_cancel()? Will it dereference freed memory as it continues
to spin on the destroyed timer structure?

> +	} else {
> +		write_lock_bh(&priv->lock);
> +		/* TODO: can we test if ecu->addr is unicast before starting
> +		 * the timer?
> +		 */
> +		j1939_ecu_map_locked(ecu);
> +
> +		/* The corresponding j1939_ecu_get() is in
> +		 * j1939_ecu_timer_start().
> +		 */
> +		j1939_ecu_put(ecu);
> +		write_unlock_bh(&priv->lock);
> +	}
>  	return HRTIMER_NORESTART;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827111410.2040=
1-1-dmantipov@yandex.ru?part=3D1
