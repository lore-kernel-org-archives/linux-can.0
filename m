Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792428634;
	b=OX4e0Kb1G2IO0q/Iowogi4D3NEaGuwthCgP6dzfgl9baalM8Y9FyIgS0L7+k+2TIMnEy
	 ITyaHs2/Wh6rBV16wPzQUIMry8KTtcSHWsBv5fT1bO8CdmGnuWUbFYiX8K1ZPRmnw/n2N
	 b/RdqYFYIwyANNnY69RCjh+bB3UtuukaBgA3jkavp9XZcotScbPM4SPmr8lAaBZVU6aJq
	 RglDUt6HPB5BAA3zDPILVyzqYqJvmDt5RGsKVhk2cI/qvxwA2t/LsNYjfTFy4D/kWNixu
	 ATYT/Bn4oCkKo24kMFNQL3BmaMrWF9v1JG0h3pEL1F+N4epr1MsZ0ftGFyBIKI3vE/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792428634;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/I65V32PGTiM4REHWqBoCEw2Cveelr30AyoQIvsKPj0=;
	b=4jLOXerMKWnb+lE4bsp2lfox+Bnw6rSKUDF73Q4IdIrfx+JuifS2HbtcGDjhXlLP7bLS
	 BE4oO5oXtb1mhERtOiFkaSku6EyTsbi9QJ0ggE6hG6GOjLTm75Z1pRYkkMeXLjSF+yAeV
	 OmLGgsCGHu9EBfaZFKCB1JGkFFNc5VU+nsHrf6Nnk2t88D0U4PBZXxNl/1RakSC3TdJ/M
	 jFqKd+rJIhkTu9MUdBr0Ekl0hvkcaL9Tmqk9pa6A7Oxg20qDLjptKx3sKe8vne0ifuD3v
	 33P6QZ7aodI1xBgvjC3S5tckkQk/GzFlgmAFdahZHLBJW1ARNmGc5OZ1rzH82xwYlpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bXRx14qM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B127A606AEC1
	for <linux-can@vger.kernel.org>; Mon, 19 Oct 2026 16:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bXRx14qM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3EF31F000D0;
	Mon, 19 Oct 2026 16:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792428633;
	bh=/I65V32PGTiM4REHWqBoCEw2Cveelr30AyoQIvsKPj0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bXRx14qMOTVAg0pIoCLlQ8guXOdxhe4i5g873ulj8/3nwTIxngIcUUynTC9jFOSOt
	 hXUvjvuNE1Px8ThTJl8gH08V5+H6gL2UhY3EgSM1wK/Gm8rddh3/wHzdwwEYu9IxqK
	 wQ/OVl3ZCqWHREG/nifrJD5/rsr8G/um5jPoKlJEFMs+0GSP/94xccWxZYPwNF/lVi
	 mpdcKxV6G3VIGdKCgpXNCOwx9LpvnwvTEgiXOoUwU86Rr+V3HrctCNzbyagf6SvN+y
	 h+2ar0di3ShjTkDV2TjUAFeU9EHeH3Q0iANXkfEQnWxIj57BH0EoY/1wBM/5k7vyE7
	 cNrkegOgCPRtg==
Message-ID: <sashiko-outbox-177945@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 05/12] can: proc: reset pkg_stats atomics
 individually
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261018164417.1540449-6-mkl@pengutronix.de>
References: <20261018164417.1540449-1-mkl@pengutronix.de>
 <20261018164417.1540449-6-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 16:50:32 +0000
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] can: proc: pre-reset local snapshots overwrite zeroed stats in c=
an_stat_update()
--

commit 569f80e5a195e52b5ac88d8f5cdb36714d69c5db
Author: Runyu Xiao <runyu.xiao@seu.edu.cn>

can: proc: reset pkg_stats atomics individually

This patch replaces the whole-struct memset() in can_init_stats() with
can_reset_pkg_stats() to reset atomic_long_t counters via atomic_long_set()
and scalar fields individually. It also uses atomic_long_xchg() in
can_stat_update() to fetch and clear the *_delta counters atomically.

Link: https://patch.msgid.link/20261016110905.422684-1-socketcan@hartkopp.n=
et

> diff --git a/net/can/proc.c b/net/can/proc.c
> index de4d05ae34597..70104f13077e0 100644
> --- a/net/can/proc.c
> +++ b/net/can/proc.c
> @@ -76,16 +76,39 @@ static const char rx_list_name[][8] =3D {
>   * af_can statistics stuff
>   */
> =20
> +static void can_reset_pkg_stats(struct can_pkg_stats *pkg_stats)
> +{
> +	atomic_long_set(&pkg_stats->rx_frames, 0);
> +	atomic_long_set(&pkg_stats->tx_frames, 0);
> +	atomic_long_set(&pkg_stats->matches, 0);
> +
> +	pkg_stats->total_rx_rate =3D 0;
> +	pkg_stats->total_tx_rate =3D 0;
> +	pkg_stats->total_rx_match_ratio =3D 0;
> +
> +	pkg_stats->current_rx_rate =3D 0;
> +	pkg_stats->current_tx_rate =3D 0;
> +	pkg_stats->current_rx_match_ratio =3D 0;
> +
> +	pkg_stats->max_rx_rate =3D 0;
> +	pkg_stats->max_tx_rate =3D 0;
> +	pkg_stats->max_rx_match_ratio =3D 0;
> +
> +	atomic_long_set(&pkg_stats->rx_frames_delta, 0);
> +	atomic_long_set(&pkg_stats->tx_frames_delta, 0);
> +	atomic_long_set(&pkg_stats->matches_delta, 0);
> +}
> +
>  static void can_init_stats(struct net *net)
>  {
>  	struct can_pkg_stats *pkg_stats =3D net->can.pkg_stats;
>  	struct can_rcv_lists_stats *rcv_lists_stats =3D net->can.rcv_lists_stat=
s;
>  	/*
> -	 * This memset function is called from a timer context (when
> +	 * This stats reset is called from a timer context (when
>  	 * can_stattimer is active which is the default) OR in a process
>  	 * context (reading the proc_fs when can_stattimer is disabled).
>  	 */
> -	memset(pkg_stats, 0, sizeof(struct can_pkg_stats));
> +	can_reset_pkg_stats(pkg_stats);
>  	pkg_stats->jiffies_init =3D jiffies;
> =20
>  	rcv_lists_stats->stats_reset++;
> @@ -121,9 +144,10 @@ void can_stat_update(struct timer_list *t)
>  	long rx_frames =3D atomic_long_read(&pkg_stats->rx_frames);
>  	long tx_frames =3D atomic_long_read(&pkg_stats->tx_frames);
>  	long matches =3D atomic_long_read(&pkg_stats->matches);
> -	long rx_frames_delta =3D atomic_long_read(&pkg_stats->rx_frames_delta);
> -	long tx_frames_delta =3D atomic_long_read(&pkg_stats->tx_frames_delta);
> -	long matches_delta =3D atomic_long_read(&pkg_stats->matches_delta);
> +	/* fetch and clear values for 'current rate' calculation */
> +	long rx_frames_delta =3D atomic_long_xchg(&pkg_stats->rx_frames_delta, =
0);
> +	long tx_frames_delta =3D atomic_long_xchg(&pkg_stats->tx_frames_delta, =
0);
> +	long matches_delta =3D atomic_long_xchg(&pkg_stats->matches_delta, 0);
> =20
>  	/* restart counting in timer context on user request */
>  	if (user_reset)

[Severity: Medium]
In net/can/proc.c:can_stat_update(), the counters and deltas are read into
local variables before the reset checks:

	if (user_reset)
		can_init_stats(net);

	/* restart counting on jiffies overflow */
	if (j < pkg_stats->jiffies_init)
		can_init_stats(net);

	/* prevent overflow in calc_rate() */
	if (rx_frames > (LONG_MAX / HZ))
		can_init_stats(net);
	...

When a user reads /proc/net/can/reset_stats (setting user_reset =3D 1) or an
overflow condition triggers, can_init_stats(net) -> can_reset_pkg_stats()
zeroes all the counters and scalar fields in pkg_stats, and updates
pkg_stats->jiffies_init =3D jiffies.

However, because can_stat_update() does not return early or clear those
local snapshot variables after calling can_init_stats(net), it proceeds to
recompute the statistics using the stale pre-reset values:

	/* calc total values */
	if (rx_frames)
		pkg_stats->total_rx_match_ratio =3D (matches * 100) / rx_frames;

	pkg_stats->total_tx_rate =3D calc_rate(pkg_stats->jiffies_init, j,
					    tx_frames);
	pkg_stats->total_rx_rate =3D calc_rate(pkg_stats->jiffies_init, j,
					    rx_frames);

	/* calc current values */
	if (rx_frames_delta)
		pkg_stats->current_rx_match_ratio =3D
			(matches_delta * 100) /	rx_frames_delta;

	pkg_stats->current_tx_rate =3D calc_rate(0, HZ, tx_frames_delta);
	pkg_stats->current_rx_rate =3D calc_rate(0, HZ, rx_frames_delta);

	/* check / update maximum values */
	if (pkg_stats->max_tx_rate < pkg_stats->current_tx_rate)
		pkg_stats->max_tx_rate =3D pkg_stats->current_tx_rate;
	...

Doesn't this immediately overwrite pkg_stats->total_rx_match_ratio,
current_rx_match_ratio, current_tx_rate, current_rx_rate, max_tx_rate,
max_rx_rate, and max_rx_match_ratio with pre-reset values right after
can_reset_pkg_stats() cleared them (with max_* and match ratios persisting
across subsequent timer ticks)?

Additionally, if jiffies advances between the initial snapshot of j at the
start of can_stat_update() and pkg_stats->jiffies_init =3D jiffies in
can_init_stats(), the subsequent check (j < pkg_stats->jiffies_init) will
evaluate to true, calling can_init_stats(net) a second time and passing
oldjif > newjif into calc_rate(). And if an overflow check on rx_frames,
tx_frames, or matches triggered the reset, the rate and ratio calculations
still run with the overflowing local values.

Should can_stat_update() re-arm the timer and return early when a reset
occurs, or perform the reset checks before snapshotting the counters?

[ ... ]

>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018164417.1540=
449-1-mkl@pengutronix.de?part=3D5
