Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22C82931EE;
	Tue, 13 Oct 2026 04:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791866290; cv=none; b=Fr7CGomjjJmgd7m4kmzS3w6zUiYZ8iBsCMRhbM4rBniWyjtYXxDrN3/e8aSnG3DFnbiineFPnTWUMXgSBhDvhtIJvqeNsrKVWard1ZE38bUvOiPv5uA6xzmw75mIxf2Blf+dG6ecH+2mAEGj9lMIxRBx1Q3MCApXflAXPqx9V/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791866290; c=relaxed/simple;
	bh=sfKls+nTZxcUxg04fXfGfXZ/rgflL8/M8cD4E/HXMRg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YtPz3bmapLpDoJ/Ry939sFHdPEZ7lt9GfOdUnPNhg67Wz0cIgTspNDbPwHy/0VxBXk3OnUTQNrD9kKNbN4lLk2M5S6TyP4jhbvK72Ls5aqBHTePRmq09gk1qkvhR+v/rUr/YjR3oGeysNX7MO0E1+J3tF005pzLZOollRiQa6HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VXoqV3np; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VXoqV3np"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 561E31F000FF;
	Tue, 13 Oct 2026 04:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791866288;
	bh=qRsEz9BghhrxycjfdpTQyP8fgJmg01WmYZxpyUUmf6c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VXoqV3np6MGxywM4Nd6+YiU2NsXWU8gBK9QgZ8eo0CZUQR5u6iJmUWB8Y7xeZ5owt
	 XublRNojVFe/XDXCSBKffghS6cxs+R8qfckOeYe+0UNKbgCtyr+YDFvGEBcX80CSeK
	 5xgFVdiYluYxnmWp9vImEbxbojA8oSGZUdKQJC1MbMwZUAh2DCgNBI9+YFchSahMtA
	 jOCgRZZK2MmsZ36pcjkENGZ27U2c9xn/SmITcTPPG62fi6cArn0UEJKt+Mh6Xd7xIf
	 hm/D+mvQxaN1ZPqtmc1IzTllOKHecBuRIsVDfw6K7LUF6kitgHyN8dbTGLyz81E9k1
	 qu1OTvFw06DGg==
Subject:
 Re: [PATCH v2] can: j1939: fix potential race condition in BAM segmentation
From: netdev-bot+sashiko@kernel.org
To: alexander.hoelzl@gmx.net
Cc: o.rempel@pengutronix.de, robin@protonic.nl, linux-kernel@vger.kernel.org,
 kernel@pengutronix.de, linux-can@vger.kernel.org, kuba@kernel.org
Date: Tue, 13 Oct 2026 04:38:07 +0000
Message-ID: <179186628788.1406898.13353230557173618837@kernel.org>
In-Reply-To: <20261011151216.118932-1-alexander.hoelzl@gmx.net>
References: <20261011151216.118932-1-alexander.hoelzl@gmx.net>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 8 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 · Low: 5

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Refcount leak in j1939_xtp_rx_rts() (net/can/j1939/transport.c,
  new transmitter-BAM else-branch, lines 1819-1821).
- [Medium] A late echo restarts an aborted BAM transmission.
- [Medium] Race between the txtimer callback and BAM echo processing in
  j1939_xtp_rx_rts().
- [Low] The fix addresses a real, user-visible bug: a TP.BAM transmit
  session stalls and is aborted by the rx timeout when the BAM echo is…
- [Low] The first hunk (@@ -7,7 +7,6 @@) removes the blank line between
  the copyright comment block and `#include <linux/can/skb.h>` in…
- [Low] The new comment in j1939_session_tx_dat() (lines 871-874) and the
  commit message treat the looped-back frame as a "tx ack".
- [Low] The patch adds J1939_TP_BAM_ECHO_TIMEOUT_MS (250) but uses it
  only on the echo-receive side (j1939_xtp_rx_rts line 1821,…
- [Low] An attacker can stall a transmitter BAM session indefinitely with
  spoofed TP.DT frames.

--

can: j1939: fix potential race condition in BAM segmentation

This patch moves the txtimer scheduling for BAM transmissions out of the
transmit path and into the echo (looped back frame) receive path. The
next TP.DT is then only scheduled after the previous frame has been
echoed. This avoids a stall when the BAM echo arrives after the 50ms
txtimer has already fired.

> diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> index 8fcfd13e5e6f8..ec0679aded090 100644
> --- a/net/can/j1939/transport.c
> +++ b/net/can/j1939/transport.c
> @@ -7,7 +7,6 @@
>  //                         Marc Kleine-Budde <kernel@pengutronix.de>
>  // Copyright (c) 2017-2019 Pengutronix,
>  //                         Oleksij Rempel <kernel@pengutronix.de>
> -
>  #include <linux/can/skb.h>
>  #include <net/can.h>

[Severity: Low]
This isn't a bug, but removing the blank line between the copyright block
and the includes looks unrelated to the BAM timing fix. Could it be
dropped from this patch?

[ ... ]

> @@ -766,7 +768,6 @@ static int j1939_session_tx_rts(struct j1939_session *session)
>  
>  	session->last_txcmd = dat[0];
>  	if (dat[0] == J1939_TP_CMD_BAM) {
> -		j1939_tp_schedule_txtimer(session, 50);

[Severity: Low]
Should this have a Fixes: tag? The 50ms txtimer arm removed here appears
to come from the original J1939 commit:

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")

Users can see the stall, so a Cc: stable might also be appropriate.

>  		j1939_tp_set_rxtimeout(session, 250);

[Severity: Low]
This isn't a bug, but J1939_TP_BAM_ECHO_TIMEOUT_MS is only used on the
echo receive side, in j1939_xtp_rx_rts() and j1939_xtp_rx_dat_one().

The transmit side still uses a literal 250 in two places: here, and in
this line in j1939_session_tx_dat():

	if (pkt_done)
		j1939_tp_set_rxtimeout(session, 250);

Should these use the new constant too, so the two sides can't drift
apart?

>  	} else {
>  		j1939_tp_set_rxtimeout(session, 1250);

[ ... ]

> @@ -866,12 +867,19 @@ static int j1939_session_tx_dat(struct j1939_session *session)
>  		session->last_txcmd = 0xff;
>  		pkt_done++;
>  		session->pkt.tx++;
> -		pdelay = j1939_cb_is_broadcast(&session->skcb) ? 50 :
> -			j1939_tp_packet_delay;
>  
> -		if (session->pkt.tx < session->pkt.total && pdelay) {
> -			j1939_tp_schedule_txtimer(session, pdelay);
> +		/* For BAM transfer the tx timer is scheduled after receiving
> +		 * the looped back frame as a tx ack. This means that here the
> +		 * timer is only scheduled for directed transfers.
> +		 */

[Severity: Low]
Is the looped back frame always a tx ack? In can_send(), devices without
IFF_ECHO get a software clone. It is passed to netif_rx() as soon as
dev_queue_xmit() returns:

net/can/af_can.c:can_send() {
    ...
	err = dev_queue_xmit(skb);
    ...
	if (newskb)
		netif_rx(newskb);
    ...
}

That happens at enqueue time, not when the frame completes on the bus.
Examples are vcan without echo=1, slcan, can327, and drivers that only
set IFF_ECHO conditionally. On these devices, frames held in a qdisc or
driver queue can still go out back to back.

The commit message also says:

    This also fixes the problem that when consecutive
    data frames are stuck in the controller they will be sent
    without any delay.

Would it be more accurate to limit this claim, and this comment, to
IFF_ECHO devices?

> +		pdelay = j1939_tp_packet_delay;
> +		if (j1939_cb_is_broadcast(&session->skcb)) {
>  			break;

[ ... ]

> @@ -1806,8 +1814,12 @@ static void j1939_xtp_rx_rts(struct j1939_priv *priv, struct sk_buff *skb,
>  	session->last_cmd = cmd;
>  
>  	if (cmd == J1939_TP_CMD_BAM) {
> -		if (!session->transmission)
> +		if (!session->transmission) {
>  			j1939_tp_set_rxtimeout(session, 750);
> +		} else {
> +			j1939_tp_schedule_txtimer(session, J1939_TP_BAM_FRAME_SPACING_MS);

[Severity: High]
Can this leak a session reference if the txtimer is already queued?

j1939_tp_schedule_txtimer() always takes a reference before calling
hrtimer_start():

void j1939_tp_schedule_txtimer(struct j1939_session *session, int msec)
{
	j1939_session_get(session);
	hrtimer_start(&session->txtimer, ms_to_ktime(msec),
		      HRTIMER_MODE_REL_SOFT);
}

If the timer is already pending, hrtimer_start() only moves its expiry.
The callback then runs once and drops only one of the two references.

j1939_xtp_rx_rts_session_active() only rejects sessions with
last_cmd != 0. The txtimer can be pending while last_cmd is still 0:

  - after j1939_tp_schedule_txtimer(session, 0) in j1939_sk_send_loop()
  - during the 10-25ms delayed activation in
    j1939_sk_queue_activate_next_locked()
  - during the -ENOBUFS retry re-arm in j1939_tp_txtimer()

A BAM with this session's SA and DA=0xff could arrive in that window in
two ways:

  - as a late echo from an earlier timed out session with the same
    addresses (j1939_session_match() doesn't compare the PGN)
  - as a spoofed frame, because j1939_can_recv() sets
    J1939_ECU_LOCAL_SRC from the SA alone, so a remote node or a local
    CAN_RAW socket can inject it

With a leaked reference, j1939_session_destroy() never runs. The priv
and netdev references are never dropped, so unregister_netdevice() could
hang waiting for the device.

The j1939_xtp_rx_dat_one() hunk in this patch cancels first, with the
comment "cancel the txtimer to avoid leaking session references". Should
this site also call j1939_session_txtimer_cancel() before re-arming?

> +			j1939_tp_set_rxtimeout(session, J1939_TP_BAM_ECHO_TIMEOUT_MS);

[Severity: Medium]
Does this restart a session that has already been aborted?

If the BAM echo is delayed by more than 250ms (the high busload case in
the commit message), j1939_tp_rxtimer() aborts the session:

j1939_tp_rxtimer() {
    ...
			hrtimer_start(&session->rxtimer,
				      ms_to_ktime(J1939_XTP_ABORT_TIMEOUT_MS),
				      HRTIMER_MODE_REL_SOFT);
			__j1939_session_cancel(session, J1939_XTP_ABORT_TIMEOUT);
    ...
}

__j1939_session_cancel() sets state to J1939_SESSION_WAITING_ABORT and
sets session->err. It also calls j1939_sk_send_loop_abort(), which sets
sk->sk_err.

The session stays on active_session_list with last_cmd == 0, so
j1939_xtp_rx_rts_session_active() still lets the late echo through. This
branch then sets last_cmd to J1939_TP_CMD_BAM and arms the txtimer.
j1939_tp_set_rxtimeout() also replaces the abort-wait rxtimer.

j1939_xtp_txnext_transmiter() dispatches on last_cmd alone:

	case J1939_TP_CMD_BAM:
		ret = j1939_session_tx_dat(session);

So TP.DT frames would go out for a session that user space has already
been told failed. Each DT echo then re-arms both timers in
j1939_xtp_rx_dat_one() until the session completes.

Should the new rx path re-arms check session->state, under
active_session_list_lock, before restarting the timers? Without that
check, the rx path can also re-arm timers after j1939_session_cancel()
on another CPU has cancelled them.

[Severity: Medium]
Can this j1939_tp_set_rxtimeout() race with the one in
j1939_session_tx_rts()?

j1939_session_tx_rts() runs in the txtimer callback. It queues the BAM
via j1939_tp_tx_ctl() and only then calls
j1939_tp_set_rxtimeout(session, 250). The echo can be processed on
another CPU in that window, for example with the TX complete IRQ on a
different CPU, with RPS, or on PREEMPT_RT.

j1939_tp_set_rxtimeout() is not atomic:

	j1939_session_rxtimer_cancel(session);
	j1939_session_get(session);
	hrtimer_start(&session->rxtimer, ms_to_ktime(msec),
		      HRTIMER_MODE_REL_SOFT);

Consider this interleaving:

CPU1 (echo, j1939_xtp_rx_rts)
  j1939_session_rxtimer_cancel()  -> nothing pending

CPU0 (txtimer, j1939_session_tx_rts)
  j1939_session_rxtimer_cancel()  -> nothing pending
  j1939_session_get()
  hrtimer_start()

CPU1
  j1939_session_get()
  hrtimer_start()

Two references are taken but only one rxtimer is queued, so one session
reference would leak.

j1939_xtp_rx_dat_one() cancels the txtimer first, and hrtimer_cancel()
waits for a running callback. Should this site do the same? The same
pattern already exists for directed RTS echoes, but this patch adds it
for BAM.

>  	} else {
>  		if (!session->transmission) {
>  			j1939_session_txtimer_cancel(session);
> @@ -1961,6 +1973,12 @@ static void j1939_xtp_rx_dat_one(struct j1939_session *session,
>  	} else if (remain) {
>  		if (!session->transmission)
>  			j1939_tp_set_rxtimeout(session, 750);
> +		else if (j1939_cb_is_broadcast(&session->skcb)) {
> +			/* cancel the txtimer to avoid leaking session references */
> +			j1939_session_txtimer_cancel(session);
> +			j1939_tp_schedule_txtimer(session, J1939_TP_BAM_FRAME_SPACING_MS);
> +			j1939_tp_set_rxtimeout(session, J1939_TP_BAM_ECHO_TIMEOUT_MS);
> +		}

[Severity: Low]
Should the timers only be re-armed here when the DT frame actually
advanced pkt.rx?

j1939_xtp_rx_dat() sends any TP.DT with J1939_ECU_LOCAL_SRC to the
transmitter session, and j1939_can_recv() sets that flag from the SA
alone.

A spoofed DT with a stale sequence number (packet < pkt.rx) passes the
bounds checks. A payload mismatch is only reported with
netdev_err_once(). pkt.rx doesn't move, so remain is still true.

This branch then pushes both the txtimer and the rxtimer out again. A
node on the bus, or a local CAN_RAW socket via loopback, could send such
frames more often than every 50ms. The session would then never transmit
or time out, and no error is reported until the socket is closed.

Before this patch, spoofed DT frames didn't touch the transmitter's
timers.

>  	} else if (do_cts_eoma) {
>  		j1939_tp_set_rxtimeout(session, 1250);
>  		if (!session->transmission)

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261011151216.118932-1-alexander.hoelzl%40gmx.net
