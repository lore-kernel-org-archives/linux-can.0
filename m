Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FE03C07A;
	Tue, 13 Oct 2026 04:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791867373; cv=none; b=mO/yKPNE7M3CXuiEcaZQCXO8plE1kkqkshLaECPd8bbLwiq99reg5nVtZ7ljzgX46Pdkeurq2RFrfhpV/Ub/5fz71GgkVdQl/oivMq+EaDwSZDr06XVR8RpNE2qpRJNyH2gsD7HtZzvPHJCRflwJehtzntanwx/P0oH4quq9EHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791867373; c=relaxed/simple;
	bh=niEQADnWy5nSyvj1GZdVw4oCuzIbgdIszJ6wI/WXklk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b5oglDeOj7i8G6qj+jyPKSCUSNMuTKYLjImRGGIXQgyPw+avhgE81OEMwYnH4KVYu5VdAIDvcxn/hElVloSbov677+lI70VJro2Rk/6rL2JCDgv9ltX05f5FDrQMLsI5naFaAugQVNR8JHyIonZ6QzSCzgKxdHQioj0ULioNCyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kDnBnyY/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kDnBnyY/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35E391F000FF;
	Tue, 13 Oct 2026 04:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791867371;
	bh=EvQHcMj8d3foWz+Mob6vBi4q2cLgPonIWsgQ2rwVgTA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kDnBnyY/W5m8T8w0Fv2qWyycHcQERYccJ95t4QIBwQl1ouVge1VPoGkdNjB+8XXi+
	 YwGLrJ1ssIfpFvfutGYibBRhoVpau05sK3+DFur/pwxgmQAphChlw4wEPtpM/z7J86
	 1lSHZbI3sKLQYMpKQGdyYjOBOdpIeo0TdkyXOPoZeCFsdDglqlfCVN60t98J2+nEf6
	 vt7sbRgwUdcDUGsVyA3jKNrkT9Px7mtGhUQqHgQplY2vMtlU3NQvD8Syc5g6gw4gUx
	 vjGiyLWnq7veDtTCQY+3ci9jNy4FAF/qEgnizaRYOTLGKPtEi9mlsxjWdPrcnUQAT4
	 CI98bbLZrKfGA==
Subject:
 Re: [PATCH v3] can: j1939: fix potential race condition in BAM segmentation
From: netdev-bot+sashiko@kernel.org
To: alexander.hoelzl@gmx.net
Cc: o.rempel@pengutronix.de, robin@protonic.nl, linux-kernel@vger.kernel.org,
 kernel@pengutronix.de, linux-can@vger.kernel.org, kuba@kernel.org
Date: Tue, 13 Oct 2026 04:56:10 +0000
Message-ID: <179186737069.1406898.4501392866752412525@kernel.org>
In-Reply-To: <20261011153119.120302-1-alexander.hoelzl@gmx.net>
References: <20261011153119.120302-1-alexander.hoelzl@gmx.net>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 3 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new BAM-transmitter echo branches can bring an aborted
  session back to life.
- [Medium] Forged TP.DT frames can stall a BAM transmission for as long
  as they keep coming, and it never times out.
- [Medium] The new re-arm in the RX path (cancel, then schedule) is not
  atomic and holds no lock, so it can leak session references.
- [Low] The commit message understates the bug and has no Fixes: tag.
- [Low] The new J1939_TP_BAM_ECHO_TIMEOUT_MS (250) constant does not
  control the timeouts that actually wait for an echo.

--

can: j1939: fix potential race condition in BAM segmentation

This patch moves txtimer scheduling for BAM transmissions out of the
transmit path and into the echo (tx ack) handlers. The 50ms frame spacing
timer is now armed in j1939_xtp_rx_rts() and j1939_xtp_rx_dat_one() when
the looped back BAM or DT frame arrives, instead of in
j1939_session_tx_rts() and j1939_session_tx_dat().

> If there is a high busload and the BAM frame is stuck in the controller
> for some time, the txtimer might elapse before the looped back frame is
> received and the session will stall.

[Severity: Low]
Is "stall" the right word for what happens before this patch?

If the 50ms txtimer fires before the BAM echo arrives, last_cmd is still 0.
j1939_xtp_txnext_transmiter() then calls j1939_session_tx_rts() again, and
that call returns early:

	if (dat[0] == session->last_txcmd)
		/* done already */
		return 0;

Nothing re-arms the txtimer after that. The 250ms rxtimer armed in
j1939_session_tx_rts() then fires, and j1939_tp_rxtimer() aborts the
session:

	__j1939_session_cancel(session, J1939_XTP_ABORT_TIMEOUT);

So user space sees the transfer aborted with EHOSTUNREACH, not a stall.
Could the commit message describe that?

This also fixes behaviour that goes back to the original J1939 code. Should
it carry this tag so stable picks it up?

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")

> diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> index 8fcfd13e5e6f8..c61a021880c01 100644
> --- a/net/can/j1939/transport.c
> +++ b/net/can/j1939/transport.c

[ ... ]

> @@ -26,6 +25,9 @@
>  #define J1939_TP_CMD_BAM 0x20
>  #define J1939_TP_CMD_ABORT 0xff
>  
> +#define J1939_TP_BAM_FRAME_SPACING_MS 50
> +#define J1939_TP_BAM_ECHO_TIMEOUT_MS 250

[Severity: Low]
This isn't a bug, but J1939_TP_BAM_ECHO_TIMEOUT_MS does not seem to set the
timeouts that actually wait for an echo. Those still use a bare 250.

In j1939_session_tx_rts(), after the BAM is sent:

	if (dat[0] == J1939_TP_CMD_BAM) {
		j1939_tp_set_rxtimeout(session, 250);

In j1939_session_tx_dat(), after each DT frame:

	if (pkt_done)
		j1939_tp_set_rxtimeout(session, 250);

The macro is only used in j1939_xtp_rx_rts() and j1939_xtp_rx_dat_one().
Both run after the echo has already arrived, and j1939_session_tx_dat()
overwrites that rxtimer about 50ms later.

Should the echo wait sites use the macro instead?

> +
>  #define J1939_ETP_CMD_RTS 0x14

[ ... ]

> @@ -1806,8 +1814,13 @@ static void j1939_xtp_rx_rts(struct j1939_priv *priv, struct sk_buff *skb,
>  	session->last_cmd = cmd;
>  
>  	if (cmd == J1939_TP_CMD_BAM) {
> -		if (!session->transmission)
> +		if (!session->transmission) {
>  			j1939_tp_set_rxtimeout(session, 750);
> +		} else {
> +			j1939_session_txtimer_cancel(session);
> +			j1939_tp_schedule_txtimer(session, J1939_TP_BAM_FRAME_SPACING_MS);
> +			j1939_tp_set_rxtimeout(session, J1939_TP_BAM_ECHO_TIMEOUT_MS);
> +		}

[Severity: Medium]
Can a late echo bring an aborted session back to life here? The same
question applies to the new branch in j1939_xtp_rx_dat_one().

Both branches re-arm the txtimer and rxtimer without
active_session_list_lock and without checking session->state. Under the
bus load this patch targets, a BAM or DT echo can arrive more than 250ms
late. By then j1939_tp_rxtimer() has already taken the abort path under the
list lock:

j1939_tp_rxtimer()
    j1939_session_list_lock(session->priv);
    ...
        hrtimer_start(&session->rxtimer,
                      ms_to_ktime(J1939_XTP_ABORT_TIMEOUT_MS),
                      HRTIMER_MODE_REL_SOFT);
        __j1939_session_cancel(session, J1939_XTP_ABORT_TIMEOUT);

That sets J1939_SESSION_WAITING_ABORT, sets err to EHOSTUNREACH and arms
the forced deactivation timer.

The session is still on active_session_list, so the late echo is still
delivered here. j1939_tp_set_rxtimeout() then cancels the abort rxtimer and
replaces it with a normal 250ms one. The txtimer fires 50ms later:

j1939_tp_txtimer()
  j1939_xtp_txnext_transmiter()
    j1939_session_tx_dat()

None of these check session->state. More DT frames therefore go out for a
session that was already reported as aborted.

Each of those echoes goes through the same re-arm in
j1939_xtp_rx_dat_one(), which pushes the forced deactivation back again.
The session can even reach j1939_session_completed() after user space was
told the transfer was aborted.

There also seems to be a narrower window against
j1939_cancel_active_session() (socket close or NETDEV_DOWN). It cancels the
timers under active_session_list_lock:

	if (hrtimer_try_to_cancel(&session->txtimer) == 1)
		j1939_session_put(session);

The RX path still holds the reference from j1939_session_get_by_addr(). If
it re-arms after this point, one more frame is sent for a session in
J1939_SESSION_DONE.

Before this patch, the BAM transmitter echo path only updated last_cmd and
pkt.rx. Should these new branches check session->state under the list lock
before re-arming?

[ ... ]

> @@ -1961,6 +1974,12 @@ static void j1939_xtp_rx_dat_one(struct j1939_session *session,
>  	} else if (remain) {
>  		if (!session->transmission)
>  			j1939_tp_set_rxtimeout(session, 750);
> +		else if (j1939_cb_is_broadcast(&session->skcb)) {
> +			/* cancel the txtimer to avoid leaking session references */
> +			j1939_session_txtimer_cancel(session);
> +			j1939_tp_schedule_txtimer(session, J1939_TP_BAM_FRAME_SPACING_MS);
> +			j1939_tp_set_rxtimeout(session, J1939_TP_BAM_ECHO_TIMEOUT_MS);
> +		}

[Severity: Medium]
Can forged TP.DT frames hold off a BAM transmission indefinitely here?

j1939_can_recv() sets J1939_ECU_LOCAL_SRC based only on the SA:

	if (j1939_address_is_unicast(skcb->addr.sa) &&
	    priv->ents[skcb->addr.sa].nusers)
		skcb->flags |= J1939_ECU_LOCAL_SRC;

So j1939_xtp_rx_dat() routes any TP.DT frame with the host's SA and DA 0xff
to the transmitter session's j1939_xtp_rx_dat_one(). That frame can come
from another node on the bus or from a local CAN_RAW socket.

A frame with packet != session->pkt.rx (for example, dat[0] = 1 sent
repeatedly) does not advance pkt.rx:

	if (packet == session->pkt.rx)
		session->pkt.rx++;

It still sets remain, though, so this branch cancels and re-arms the 50ms
txtimer and the 250ms rxtimer. The memcmp mismatch is only logged once.

Suppose such a frame arrives at least every 50ms. The txtimer never fires,
so no data goes out. The rxtimer never fires either, so the session is never
aborted. Later BAM transfers queued for that SA would hang behind it as
well.

Before this patch, the transmitter paced itself with its own txtimer, and
this branch ignored transmitter sessions.

Should this branch re-arm only when the frame is the echo of the packet
just sent (packet == session->pkt.tx - 1), or when pkt.rx actually
advanced?

[Severity: Medium]
Could this cancel then re-arm sequence leak session references if two DT
frames for the same BAM session are processed at the same time?

j1939_tp_schedule_txtimer() always takes a reference:

	j1939_session_get(session);
	hrtimer_start(&session->txtimer, ms_to_ktime(msec),
		      HRTIMER_MODE_REL_SOFT);

Nothing serialises j1939_xtp_rx_dat_one() calls for the same session.
j1939_session_get_by_addr() holds active_session_list_lock only during the
lookup.

Two CPUs could handle TP.DT frames for this session at once. One example is
the af_can loopback netif_rx() for a device without IFF_ECHO, racing a
frame from the bus or an injected one. Another is two CAN_RAW injectors on
vcan. The interleaving would be:

CPU1                              CPU2
j1939_session_txtimer_cancel()
  hrtimer_cancel() == 1, put
                                  j1939_session_txtimer_cancel()
                                    hrtimer_cancel() == 0
j1939_tp_schedule_txtimer()
  j1939_session_get()
  hrtimer_start()
                                  j1939_tp_schedule_txtimer()
                                    j1939_session_get()
                                    hrtimer_start()

When the timer fires, only one reference is dropped. The rxtimer has the
same problem through j1939_tp_set_rxtimeout().

A leaked session never reaches j1939_session_destroy(). Its j1939_priv
reference and priv_dev_tracker netdev reference are then never released,
and unregistering the CAN netdev would hang waiting for the device to
become free.

j1939_xtp_rx_cts_one() already uses the same unlocked pattern for directed
sessions. Before this patch, though, the RX path never touched the txtimer
for BAM transmitter sessions.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261011153119.120302-1-alexander.hoelzl%40gmx.net
