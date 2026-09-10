Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C21147D937
	for <linux-can@vger.kernel.org>; Thu, 10 Sep 2026 17:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789061828; cv=none; b=cw1cPKhB02bffYmpHvbHF2+/Bd94zk5AwrJIVJuz/ZOTTG7mClVTWMd8x3z6UmqtAiL3uIyAula6oiwST9lIAt/vlx2cXmeZ1SIz/aeS/3MRhO+P81DefgRkgZTFQnLKqXx4hgoAqo84+D+g6QyQoejrjC0afff1BjKn+44RA+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789061828; c=relaxed/simple;
	bh=l1jCILyR1ou+9At5IcG8DMqTwlco0jNsQ4ni3JYyIw0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TAkvt8p4KmvqW2oE7JAtMTq0OPl91QN618waZh4a8YPwsRzxyMLQkFRKnqkfYqbppUPfCjhZVkQNl9IknIIG3Ctc7SrmF2G9qOzrGadrYgkr7jkrdMGIyDp5dobXwtfUiK6oCQQQNlwn9mAxBvl7NZ6aiWp8m8kCIx+OQQpt6Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+sn+Moh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+sn+Moh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB6AF1F000FF;
	Thu, 10 Sep 2026 17:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789061821;
	bh=nxywpQabneDgyhCSRVy5vRSU9jp6KVpCle5fEXI7LsI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e+sn+Mohl4386GaiF6zArhcC9nqHdnQwnlU4JV1rX9ax2LaKzan38hIiUyFKLlHfH
	 sQyoLgw/W8KoRi8U183FFSwwFHhtNSo2OSpoLnRku5sDJXe1JvempSz0zOxUHjmJIv
	 iHr1DRmrKZIgvjzoGE2GRspM82S7W/Yy5gzAh+ONWAorR2hYTuZ6CqPL/9TNW70oKe
	 /CNsP1L9B0bnHzUYrUPoXisIR87PHeEDskvip0Lb0foyOY8EMBJhTLikXi1RIqPI31
	 l46Giy4Cu60yk/M2za6tyjbNKMENXtn8nozxwjG1VkvtCG3gW2ypuIO+Wec40X8nwG
	 Xq3boMxtKi/LQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 2/2] can: j1939: check received packet count
 before completing session
Reply-To: sashiko-reviews@lists.linux.dev
To: "Liu Chao" <liuc63@xiaopeng.com>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Vincent
 Mailhol" <mailhol@kernel.org>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260909173105.158202-3-liuc63@xiaopeng.com>
References: <20260909173105.158202-1-liuc63@xiaopeng.com>
 <20260909173105.158202-3-liuc63@xiaopeng.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 17:37:00 +0000
Message-Id: <20260910173700.EB6AF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] A TOCTOU race condition in `j1939_xtp_rx_eoma_one`'s error path le=
ads to a cancelled deactivation timer and a permanent session leak.

Pre-existing issues:
- [High] Unconditional timer cancellation in `j1939_xtp_rx_dat_one` and `j1=
939_xtp_rx_cts_one` error paths can permanently leak aborting sessions.
- [High] AB-BA deadlock between `j1939_session_list_lock` and `hrtimer_canc=
el` inside `j1939_session_cancel`.
--

commit 814e4e3f93c71a9da50106bf799262ce6cff348a
Author: Liu Chao <liuc63@xiaopeng.com>

can: j1939: check received packet count before completing session

This commit modifies the j1939 receive path to ensure all data packets
have arrived before completing a session on EOMA. It adds a packet count
verification to prevent delivering incomplete messages to userspace, and
implements a safe abort path when packets are missing.

> diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> index c40db43379598..fe447077bcc89 100644
> --- a/net/can/j1939/transport.c
> +++ b/net/can/j1939/transport.c

[ ... ]

> @@ -1422,6 +1436,16 @@ j1939_xtp_rx_eoma_one(struct j1939_session *sessio=
n, struct sk_buff *skb)
>  	j1939_session_timers_cancel(session);
>  	/* transmitted without problems */
>  	j1939_session_completed(session);
> +	return;
> +
> + out_session_cancel:
> +	/* Don't touch timers if the session is already aborting;
> +	 * cancelling the deactivation timer here would leak the session.
> +	 */
> +	if (session->state >=3D J1939_SESSION_WAITING_ABORT)

[Severity: High]
Can this lockless state check create a TOCTOU race condition?

Because the state check is lockless, another CPU can transition the session
to WAITING_ABORT and arm the deactivation timer after the lockless check but
before timer cancellation. The first CPU then blindly cancels this newly
armed deactivation timer.

The subsequent call to j1939_session_cancel() acquires the lock, sees the
state is already WAITING_ABORT, and skips re-arming the timer, leaving the
session leaked permanently on the active_session_list.

This can be triggered remotely on the CAN bus by sending an invalid EOMA
packet simultaneously with an abort or timeout occurring on another CPU.

> +		return;
> +	j1939_session_timers_cancel(session);

[Severity: High]
This isn't a bug introduced by this patch, but could the unconditional timer
cancellation in the error paths of j1939_xtp_rx_dat_one() and
j1939_xtp_rx_cts_one() permanently leak aborting sessions?

When an invalid DAT or CTS packet is received for an already aborting sessi=
on,
the code hits the out_session_cancel path which unconditionally calls
j1939_session_timers_cancel():

net/can/j1939/transport.c:j1939_xtp_rx_dat_one() {
    ...
 out_session_cancel:
	kfree_skb(se_skb);
	j1939_session_timers_cancel(session);
	j1939_session_cancel(session, abort);
}

A remote attacker on the CAN bus can cause an abort and quickly follow up
with an invalid DAT or CTS packet. This unconditionally kills the running
deactivation timer because j1939_session_cancel() does not re-arm timers
for sessions already in the WAITING_ABORT state.

> +	j1939_session_cancel(session, J1939_XTP_ABORT_FAULT);

[Severity: High]
This is a pre-existing issue, but does calling hrtimer_cancel() while holdi=
ng
active_session_list_lock create an AB-BA deadlock?

CPU A executing j1939_session_cancel() acquires active_session_list_lock
and invokes hrtimer_cancel() (via j1939_tp_set_rxtimeout() or
__j1939_session_cancel()).

Concurrently, CPU B executing the j1939_tp_rxtimer() softirq callback
attempts to acquire active_session_list_lock:

net/can/j1939/transport.c:j1939_tp_rxtimer() {
    ...
	} else {
		j1939_session_list_lock(session->priv);
		if (session->state >=3D J1939_SESSION_ACTIVE &&
    ...
}

hrtimer_cancel() will spin-wait for the timer callback to finish on CPU B,
but CPU B is spinning waiting for the spinlock held by CPU A. This race
can be triggered remotely on SMP systems when an attacker sends a packet
that causes an abort precisely when the receiver timeout timer is firing.

>  }
> =20
>  static void

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909173105.1582=
02-1-liuc63@xiaopeng.com?part=3D2
