Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E6B175A6C;
	Fri, 16 Oct 2026 02:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792118225; cv=none; b=aYWtsRUawhFGwtGpqplBUt9BG7VO3rDBM4ODEVnrnQcy1fkfBRkgEY8A+5OK7jejMsxeyieSUiWKFzjKWZym2XDNnw4LtmFiIStDV5wnLvqARv2RObJz2l82bENxPaQuKeXeQwKTm2Mfs7hlIjlFaJP/+uX3MH9od2uB5KdTlnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792118225; c=relaxed/simple;
	bh=pNNPofbfMhRKvpE3eu5MDaVkUjmyJn9y1w6yyPH9U6s=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TNXt5unABVBp5JNw/v99Y3xpDjpuqzbgB6QRzo0sP+tsIUEREHxOb2L5GBq52xpZkPmhA72c9ENJFkXdBq26IinTfYX/Lk35SrxRz6QPtNUj+AXDJPPj+cK4KeR5C3uRLnTPmolGQG+cEsKqoq6G14RNsZkcNsFJUw81uPYDH5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BpwVkcQO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BpwVkcQO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BF141F000C5;
	Fri, 16 Oct 2026 02:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792118224;
	bh=JIOX8ZMxiezLEq9kRfvQBA4SgyCHInyhzbH9wUaESiY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=BpwVkcQOUy0sKrJHUD1hgrWH7S4dcBgC36kH5uCMOq6sPVntFOBbXAA4dSDCnEYes
	 oIVzKadhwSVJSgeVeb6HGyRJxueNo2UP19ZcMlRL6LyO0fH1+FssuXreueIsFNQXPa
	 JxX3JWK5c0eXk3hMS4bsU7agQGOnpffU59hAQS9RijWa3WDaBeCRqNdzioF6Bp2LMO
	 W2abyb//gOSi1IOeMRPe8AJ9lx5JzJnpMQHB1wC2OBAYmQrMstiEsKX3jAiospRGcv
	 +/buWd8YY/A6fcREIZe+XhGMZRgGXueNwyLeap8cs7BKPbWuuyatqXa/E7pEBRgmSb
	 HZzEB7rCytUOA==
Subject:
 Re: [PATCH net-next 04/37] can: proc: reset pkg_stats atomics individually
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, socketcan@hartkopp.net,
 kurt.van.dijck@eia.be
Date: Fri, 16 Oct 2026 02:37:03 +0000
Message-ID: <179211822321.434549.9771966136026807937@kernel.org>
In-Reply-To: <20261015015336.816543-5-mkl@pengutronix.de>
References: <20261015015336.816543-5-mkl@pengutronix.de>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 (3) · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] can: dropped statistics updates due to unprotected
  atomic_long_set()

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but the patch's
  Fixes: commit 80b5f90158d1 also broke the reset in can_stat_update(),…
- [Medium] This problem wasn't introduced by this patch, but user_reset
  (net/can/proc.c:66, 'static int user_reset;') is one file-scope flag…
- [Medium] This problem wasn't introduced by this patch, but
  can_stat_update() reads each *_delta counter with atomic_long_read()…
- [Low] This problem wasn't introduced by this patch, but the scalar
  fields of struct can_pkg_stats are still accessed with plain loads and…

--

can: proc: reset pkg_stats atomics individually

This patch replaces the whole-struct memset() in can_init_stats() with a
new helper, can_reset_pkg_stats(). The helper resets the atomic_long_t
counters of struct can_pkg_stats with atomic_long_set() and clears the
scalar derived statistics with plain stores.

Link: https://patch.msgid.link/20260512133937.21957-1-runyu.xiao@seu.edu.cn

> diff --git a/net/can/proc.c b/net/can/proc.c
> index de4d05ae3459..64b3bdc2fa7e 100644
> --- a/net/can/proc.c
> +++ b/net/can/proc.c
> @@ -76,16 +76,39 @@ static const char rx_list_name[][8] = {
>   * af_can statistics stuff
>   */
>  
> +static void can_reset_pkg_stats(struct can_pkg_stats *pkg_stats)
> +{
> +	atomic_long_set(&pkg_stats->rx_frames, 0);
> +	atomic_long_set(&pkg_stats->tx_frames, 0);
> +	atomic_long_set(&pkg_stats->matches, 0);
> +
> +	pkg_stats->total_rx_rate = 0;
> +	pkg_stats->total_tx_rate = 0;
> +	pkg_stats->total_rx_match_ratio = 0;

[Severity: Low]

This isn't a bug introduced by this patch, but these scalar fields are
still written with plain stores from timer softirq context. The writers
are can_reset_pkg_stats(), can_init_stats() (for jiffies_init) and
can_stat_update().

Process context reads the same fields with plain loads, in
can_stats_proc_show():

	seq_printf(m, " %8ld %% total match ratio (RXMR)\n",
			pkg_stats->total_rx_match_ratio);

and in can_reset_stats_proc_show():

	if (pkg_stats->jiffies_init != jiffies)

Without READ_ONCE()/WRITE_ONCE() or data_race(), will KCSAN keep
reporting data races on struct can_pkg_stats? The commit message limits
its goal to "the live counters", so this is only an observation.

> +
> +	pkg_stats->current_rx_rate = 0;
> +	pkg_stats->current_tx_rate = 0;
> +	pkg_stats->current_rx_match_ratio = 0;
> +
> +	pkg_stats->max_rx_rate = 0;
> +	pkg_stats->max_tx_rate = 0;
> +	pkg_stats->max_rx_match_ratio = 0;
> +
> +	atomic_long_set(&pkg_stats->rx_frames_delta, 0);
> +	atomic_long_set(&pkg_stats->tx_frames_delta, 0);
> +	atomic_long_set(&pkg_stats->matches_delta, 0);
> +}

[Severity: Medium]
This is a pre-existing issue. The commit message says plain writes in
the reset path "can lose or mix live statistics updates", but the same
kind of loss remains in the regular timer path after this patch.

can_stat_update() runs once per second from the stats timer. It
snapshots the delta counters at the top of the function, for example:

	long rx_frames_delta = atomic_long_read(&pkg_stats->rx_frames_delta);

It then derives current_tx_rate, current_rx_rate and
current_rx_match_ratio from those locals. Only at the very end does it
clear the counters:

	atomic_long_set(&pkg_stats->rx_frames_delta, 0);

While this runs, can_send() and can_receive() keep calling
atomic_long_inc() on tx_frames_delta, rx_frames_delta and matches_delta
from other CPUs. An increment that lands between the read and the set
is lost. It is not in the snapshot used for this interval, and it is
wiped before the next interval starts. Under load, the current_* rates
and the current match ratio therefore undercount. The rx_frames,
tx_frames and matches totals still count the frame.

Switching can_reset_pkg_stats() from memset() to per-field
atomic_long_set() avoids plain stores to the atomics. It does not turn
the read and the clear in can_stat_update() into a single atomic step,
so this window is unchanged by the patch.

Would taking each snapshot with atomic_long_xchg() against 0 at the
top of can_stat_update(), and dropping the trailing atomic_long_set()
calls, close the window? Should that be folded into this fix, or sent
as a separate patch?

[Severity: Medium]

This is a pre-existing issue, but can_stat_update() reads the *_delta
counters at the top and clears them at the bottom, after the
calculations and any can_init_stats() calls:

net/can/proc.c:can_stat_update() {
	...
	long rx_frames_delta = atomic_long_read(&pkg_stats->rx_frames_delta);
	long tx_frames_delta = atomic_long_read(&pkg_stats->tx_frames_delta);
	long matches_delta = atomic_long_read(&pkg_stats->matches_delta);
	...
	/* clear values for 'current rate' calculation */
	atomic_long_set(&pkg_stats->tx_frames_delta, 0);
	atomic_long_set(&pkg_stats->rx_frames_delta, 0);
	atomic_long_set(&pkg_stats->matches_delta, 0);
	...
}

Meanwhile can_send() and can_receive() call atomic_long_inc() on these
deltas from other CPUs, for example:

	atomic_long_inc(&pkg_stats->tx_frames_delta);

Any increment between the snapshot and the clear is overwritten. It
never shows up in current_tx_rate, current_rx_rate or
current_rx_match_ratio, though the totals still count it.

Would taking each snapshot with atomic_long_xchg(&delta, 0) close that
window?

> +
>  static void can_init_stats(struct net *net)
>  {

[ ... ]

> -	memset(pkg_stats, 0, sizeof(struct can_pkg_stats));
> +	can_reset_pkg_stats(pkg_stats);

[Severity: Medium]

This is a pre-existing issue, but this patch has Fixes: 80b5f90158d1.
Should the reset in can_stat_update() be handled as well? That commit
also changed can_stat_update() to snapshot the counters into locals
before any of the can_init_stats() calls:

net/can/proc.c:can_stat_update() {
	long rx_frames = atomic_long_read(&pkg_stats->rx_frames);
	long tx_frames = atomic_long_read(&pkg_stats->tx_frames);
	long matches = atomic_long_read(&pkg_stats->matches);
	...
	/* restart counting in timer context on user request */
	if (user_reset)
		can_init_stats(net);
	...
	/* matches overflow - very improbable */
	if (matches > (LONG_MAX / 100))
		can_init_stats(net);

	/* calc total values */
	if (rx_frames)
		pkg_stats->total_rx_match_ratio = (matches * 100) / rx_frames;
	...
}

After can_init_stats() returns, the pre-reset locals are still used for
total_rx_match_ratio, current_rx_match_ratio, current_tx_rate,
current_rx_rate and the max_* fields. So the values that
can_reset_pkg_stats() just cleared get refilled from pre-reset data.

With the stats timer enabled (the default), can_reset_stats_proc_show()
only sets user_reset = 1, so every user requested reset takes this path.
If no more traffic arrives, total_rx_match_ratio and
current_rx_match_ratio keep their pre-reset values indefinitely. They
are only recomputed under if (rx_frames) and if (rx_frames_delta).

The matches > (LONG_MAX / 100) guard is also defeated, because
(matches * 100) is still computed from the stale copy after the reset.
On 32-bit with HZ <= 100, rx_frames and matches can both pass
LONG_MAX / 100 in the same tick. Can this multiplication then overflow a
signed long and export a garbage ratio?

Before 80b5f90158d1, these expressions read pkg_stats->... after
can_init_stats() and so saw zeros. Given this, the commit message
statement "This preserves the existing reset semantics for scalar
fields" does not hold for the default timer-driven path.

>  	pkg_stats->jiffies_init = jiffies;
>  
>  	rcv_lists_stats->stats_reset++;

[Severity: Medium]

This isn't a bug introduced by this patch, but user_reset is a single
file-scope flag shared by every network namespace and accessed with
plain loads and stores:

static int user_reset;

can_pernet_init() arms a separate can_stat_update() timer for each
netns. A read of /proc/net/can/reset_stats in netns A sets the global
flag. Whichever netns timer runs next resets its own stats and clears
the flag here:

	if (user_reset) {
		user_reset = 0;
		rcv_lists_stats->user_reset++;
	}

reset_stats is created with mode 0644. Can an unprivileged user in one
netns therefore reset another namespace's statistics, including
init_net's, while the reset requested for netns A never happens?

Separately, with the stats timer disabled, two concurrent readers of
reset_stats can both pass the check in can_reset_stats_proc_show():

	if (pkg_stats->jiffies_init != jiffies)
		can_init_stats(net);

Could they then race on the plain stats_reset++ and user_reset++
increments and on the user_reset test-and-clear?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015015336.816543-2-mkl%40pengutronix.de
