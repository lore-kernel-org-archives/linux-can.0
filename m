Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7F73DA5AA
	for <linux-can@vger.kernel.org>; Mon, 19 Oct 2026 07:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792396417; cv=none; b=LPDmk6JJ8fD6lRGf3SJ+eMb+n1NOyEBcVRZNMDW2YCv0z0wH4P5mu6/oAhSf3gNrttysKeSp1aorZWDdh1EOY2sUxYo5YqPRS60FRKmCfPG7lcao7J7UjedjtRBHXNkQNfPc3fu+mjo7iG5HQfzlnSR0H2JibHESfKrvsQQMQG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792396417; c=relaxed/simple;
	bh=59Qe/C0vftVFQPXCQh84YCzywCY+y55bgmnZvSI/U9E=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ob98saVk2f5uMt3Dqs1WhQfsxm05zXtAv9QNCyGfFQXXzwPUSvX+CeFDopMt8lqqkuSbZmZADlPbUEwMG76uvYSy3AVffTC5Z4SMdj6Y6WL/3DYUd1oeqi5jwX+zWUSx9TfEx97fbsIO+12k+dLzhxhTS5at1ebOhAbXU/qrk+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWOn6nTE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWOn6nTE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8F801F000C4;
	Mon, 19 Oct 2026 07:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792396415;
	bh=72c2uprbBs85mTUArfPemSJM666Ha969cur+Lr6+YEo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PWOn6nTEvhGx2QaJ5sHFbg3/JCnlPc4mVm43AGrzf3Gk6njW05k+864eXBXKGVX+7
	 HnOwXcSkSbkDpFoGk05Jj3Wsu/y7TUV1GyxdyWjgK7bxIahUm7xKnBRD36IP4bdOkk
	 bevqhxngEcPHhVn7pgBYdX0i2Q+ass1rzXfunMj+7opLO1/uL41WqQjjkL/xcJX9Cv
	 C25WTtgGXvIGtiaB0KE8PV53FnCGhTrotQf6qJwKcjhDzt9ICj+phqf4uV6wyJQ5Ic
	 pMt0SfPUU+SASF5yqKVjamUJEkLZSF6jI3F/jpa3faCLQRCE9gok22wmQRW3C0HRE8
	 mGMvSjXa1JcOg==
Message-ID: <sashiko-outbox-176764@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH can-next v3 1/4] can: proc: reset pkg_stats atomics
 individually
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261019074244.50391-2-socketcan@hartkopp.net>
References: <20261019074244.50391-1-socketcan@hartkopp.net>
 <20261019074244.50391-2-socketcan@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 07:53:34 +0000
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] can: proc: stale counter snapshots in can_stat_update() overwrit=
e reset stats
--

commit 947871fd730bb7740551ee6c8b42c7ac5ed61308
Author: Runyu Xiao <runyu.xiao@seu.edu.cn>

can: proc: reset pkg_stats atomics individually

This patch replaces the whole-struct memset() in can_init_stats() with
individual atomic_long_set() and scalar field resets in can_reset_pkg_stats=
(),
and switches can_stat_update() to use atomic_long_xchg() when reading and
clearing the delta counters.

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
Does can_stat_update() overwrite the freshly reset scalar statistics in
pkg_stats with stale pre-reset counter snapshots after calling
can_init_stats()?

At the beginning of can_stat_update() in net/can/proc.c, the counters are
snapshotted into local variables before checking for a reset or overflow:

	unsigned long j =3D jiffies; /* snapshot */

	long rx_frames =3D atomic_long_read(&pkg_stats->rx_frames);
	long tx_frames =3D atomic_long_read(&pkg_stats->tx_frames);
	long matches =3D atomic_long_read(&pkg_stats->matches);
	/* fetch and clear values for 'current rate' calculation */
	long rx_frames_delta =3D atomic_long_xchg(&pkg_stats->rx_frames_delta, 0);
	long tx_frames_delta =3D atomic_long_xchg(&pkg_stats->tx_frames_delta, 0);
	long matches_delta =3D atomic_long_xchg(&pkg_stats->matches_delta, 0);

	/* restart counting in timer context on user request */
	if (user_reset)
		can_init_stats(net);

	/* restart counting on jiffies overflow */
	if (j < pkg_stats->jiffies_init)
		can_init_stats(net);

	/* prevent overflow in calc_rate() */
	if (rx_frames > (LONG_MAX / HZ))
		can_init_stats(net);
	...

When user_reset is set (for example, after reading /proc/net/can/reset_stat=
s)
or when one of the overflow conditions triggers, can_stat_update() calls
can_init_stats() -> can_reset_pkg_stats(), which zeroes the atomic counters
and the derived scalar fields (total_*, current_*, max_*).

However, the local variables rx_frames, tx_frames, matches, rx_frames_delta,
tx_frames_delta, and matches_delta still hold the pre-reset values when
can_stat_update() continues immediately below:

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

As a result, those pre-reset local variables overwrite total_rx_match_ratio,
current_*, and max_* right after can_reset_pkg_stats() cleared them (and if
the reset was triggered by the rx_frames, tx_frames, or matches overflow
checks, the overflowing values are still passed into the ratio and calc_rat=
e()
calculations).

Additionally, because can_init_stats() sets pkg_stats->jiffies_init =3D jif=
fies
by reading live jiffies rather than using the snapshot j, if jiffies ticks
between the snapshot and can_init_stats(net) during a user_reset, the
subsequent check (j < pkg_stats->jiffies_init) will also evaluate to true,
calling can_init_stats(net) a second time and then passing jiffies_init > j
along with the stale non-zero tx_frames and rx_frames into calc_rate().

Should can_stat_update() re-arm the timer and return early (or zero the loc=
al
snapshot variables) when can_init_stats() is called?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019074244.5039=
1-1-socketcan@hartkopp.net?part=3D1
