Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795795459;
	b=Rwt4i5FfeqbX0fbKK6cBuo6jIRcWMNxQo6SkkJIIeQNBSRzMDcjt0rlp10FnrVbrTAQ2
	 C/A8CI+DAm91lohJ1tLEcPUUTDzPvdeOnOv6UDKPSRsvUSJRQl2XPyPSPQErFi1eKstjy
	 +qo+zxOEnCTHxKUwQ7xgUE5eX5MHwD3/Z/aUnsBgyUdtQVWIwaLTWFPsnbt0qnNEIQrL/
	 GkGYlDULjdLmxnrlVfwtJ9/Z66TEo+qOPfnNKzWT+MrXQQyAxiRXG3U0IROpKSm+MBnc9
	 ur3+XR5PzbnsOGRgGb/hx6C1ath8cmjSyzo+XrRBto+HBGQEiOfPB3XbjcgEOtgvWBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795795459;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=8JIF4556REnzPGgIsVx9mFzE6WZEsCyWiN0cVXIRkOo=;
	b=Ocyi+FS7b6gvgVgdt0oG0pNiprigDYlwUvHubInuHlkYitoix51XZTlz6GxImjnh4MSO
	 iZpSqG+jVsKApRltD/v8jZete71CmmCCUmFM4lkRanQRjTGKH0aFNOnMHP9bFrNPbff2c
	 xP/gJ4aJ+SC6Ncr24vLwV7YrURs7Q5vlGg89RYgIn+qgdH9k3K8iKU38ZUqcnosZhaeuS
	 92vVtREY1ApBbLcBNdmPn+IonulTTJUvPPZWJkhnSOLpUg4BJUHKNB+P5rRc3Yx9F94Pn
	 WFy30lAi1ICUmCn1rmVuCwKv65PKCHvQGAB1aPlxzIVqreu+aiVzKzIoh1O9oCDUCPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GduA3EoZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8726A606A31E;
	Fri, 27 Nov 2026 16:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GduA3EoZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 133CE1F00925;
	Fri, 27 Nov 2026 16:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795795458;
	bh=8JIF4556REnzPGgIsVx9mFzE6WZEsCyWiN0cVXIRkOo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GduA3EoZ1ZOcoIoF3MmCCawrahTCpElIybzkT6ggVNtnkStHy6vszVlJdUhFEbhuW
	 wHWX0qTdiHwCvpq8Isyx4dz9RdWRq2O3yqobrcm378aYEqLuo6QAi8A5cGqlDzER60
	 K8QeqoAx92vJRDrBel2pKmBUryrKbYu7/xf5WALEDY/eMtZ5IEZf6vuTs7gFH1Y6iz
	 mMIuSFgnGS17GUjqhJPRh5UAn1Evsqn6THoKVxY6BwS290RCaOUGtL5Bmd6ydMtaFb
	 bw5IkLMLVpnso4vpEKSA8Z8i4ITO8X+ilekqwo2o4u33YmLDKXT2XlnoW8IRONViQs
	 ogi50j+vqsnmw==
Subject:
 Re: [PATCH net v3] can: j1939: reject an out-of-range data packet offset
From: netdev-bot+sashiko@kernel.org
To: piyus@iiitd.ac.in
Cc: robin@protonic.nl, o.rempel@pengutronix.de, mkl@pengutronix.de,
 socketcan@hartkopp.net, mailhol@kernel.org, linux-can@vger.kernel.org,
 kernel@pengutronix.de, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kapil@presceralabs.ai, kuba@kernel.org
Date: Fri, 27 Nov 2026 16:04:17 +0000
Message-ID: <179579545761.3135.18369632186646303264@kernel.org>
In-Reply-To: <20261126150339.2110025-1-piyus@iiitd.ac.in>
References: <20261126150339.2110025-1-piyus@iiitd.ac.in>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 · Low: 4

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The v3 notes say the patch fixes a session leak, but it fixes
  only one path into it, and the patch's own new cancel makes another…
- [Medium] The new check in j1939_xtp_rx_eoma_one() stops a cancelled
  session from being completed, but only on the EOMA path.
- [Medium] j1939_xtp_rx_dpo_one() reads `was_dying = session->state >=
  J1939_SESSION_WAITING_ABORT` (transport.c:1852) without the…
- [Low] The new `session->state >= J1939_SESSION_WAITING_ABORT` check in
  j1939_xtp_rx_eoma_one() (transport.c:1426) reads the state without…
- [Low] Both new comments are wrong about RX_ABORT.
- [Low] The changelog says that for an out-of-range offset "the lookup
  returns NULL and the copy and the completion run on it".
- [Low] The main changelog, above '---', describes only the DPO range
  check and the offset-0 lookup.

--

can: j1939: reject an out-of-range data packet offset

This patch rejects an ETP DPO whose data packet offset is not below
session->pkt.total. The session is cancelled, and it is deactivated if it
was already waiting for its abort. The patch also makes
j1939_session_completed() look the receive message up at offset 0, and
makes j1939_xtp_rx_eoma_one() ignore an EOMA on a session in WAITING_ABORT.

Link: https://lore.kernel.org/all/179553126874.3135.14817947057284289051@kernel.org/

> j1939_session_skb_get_by_offset() then looks for a buffered skb at
> pkt.dpo * 7, and j1939_xtp_rx_dat_one() copies into the session's skb at
> that offset.  An offset past the session's packet count has no skb behind
> it, so the lookup returns NULL and the copy and the completion run on it.

[Severity: Low]
Is the part about the copy accurate? j1939_xtp_rx_dat_one() already checks
the bounds and checks for NULL before the memcpy:

	se_skb = j1939_session_skb_get_by_offset(session, packet * 7);
	if (!se_skb) {
		netdev_warn(priv->ndev, "%s: 0x%p: no skb found\n", __func__,
			    session);
		goto out_session_cancel;
	}

The NULL only seems to reach the old j1939_session_completed(), which passed
the result of j1939_session_skb_get() straight to j1939_sk_recv().

Could the changelog also say how completion is reached after a bad DPO? That
would be an EOMA with sa equal to our address, either the echo of our own
EOMA or a spoofed one.

> diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> index 8fcfd13e5e6f8..54e7ae9a88c3e 100644
> --- a/net/can/j1939/transport.c
> +++ b/net/can/j1939/transport.c
> @@ -1242,10 +1242,15 @@ static void j1939_session_completed(struct j1939_session *session)
>  	struct sk_buff *se_skb;
>  
>  	if (!session->transmission) {
> -		se_skb = j1939_session_skb_get(session);
> -		/* distribute among j1939 receivers */
> -		j1939_sk_recv(session->priv, se_skb);
> -		consume_skb(se_skb);
> +		/* the whole message, not the window the peer's last DPO
> +		 * happened to name
> +		 */
> +		se_skb = j1939_session_skb_get_by_offset(session, 0);
> +		if (se_skb) {
> +			/* distribute among j1939 receivers */
> +			j1939_sk_recv(session->priv, se_skb);
> +			consume_skb(se_skb);
> +		}
>  	}

[Severity: Medium]
The EOMA hunk below stops a session in WAITING_ABORT from being completed.
However, j1939_xtp_rx_dat_one() also calls j1939_session_completed(), and
its BAM final branch has no state check:

	if (final) {
		j1939_session_timers_cancel(session);
		j1939_session_completed(session);

Can a cancelled BAM receive session still deliver its data here?

Take a BAM followed by one malformed DAT (skb->len != 8) or one with a bad
sequence number. That cancels the session: the state becomes WAITING_ABORT
and J1939_ERRQUEUE_RX_ABORT is queued.

j1939_xtp_rx_dat_one() never checks the state, and last_cmd (BAM or 0xff)
still passes the last_cmd switch. So the in-order DATs that arrive inside
the 500 ms abort window keep raising pkt.rx.

When pkt.rx reaches pkt.total, the abort timer is cancelled and the message
goes to j1939_sk_recv(). The sockets would see RX_ABORT, then the data, then
another RX_ABORT from j1939_session_destroy().

Would a state check in j1939_session_completed(), or under the list lock at
deactivation, cover both callers?

> @@ -1418,6 +1423,18 @@ j1939_xtp_rx_eoma_one(struct j1939_session *session, struct sk_buff *skb)
>  
>  	netdev_dbg(session->priv->ndev, "%s: 0x%p\n", __func__, session);
>  
> +	if (session->state >= J1939_SESSION_WAITING_ABORT) {

[Severity: Low]
This check also applies to transmit sessions. Before this patch, a TX
session in WAITING_ABORT that got the peer's EOMA was completed and
deactivated at once. Now it waits for its abort echo or for the 500 ms
abort timeout.

The changelog above the '---' only describes the DPO range check and the
offset-0 lookup. Two changes are explained only in the version notes, which
git am drops: this EOMA check, and the forced deactivation on a second bad
DPO. Could both be described in the permanent changelog?

The version notes also say:

  The delivery itself predates this series -
  j1939_session_completed() always called j1939_sk_recv() - but v2 is
  what made it reach a whole message, so the state test belongs here.

Is that right? Before the series, j1939_session_skb_get() looked up offset
pkt.dpo * 7. A receive session's skb_queue holds a single skb at offset 0
sized total_message_size (see j1939_session_new()).

So any in-range dpo, including 0, already returned the whole message. An
EOMA on a session cancelled for any other reason already delivered it. That
would make this hunk a separate fix that matters for stable on its own.

> +		/* This session has been cancelled and is waiting for its abort
> +		 * to go out.  Completing it here would hand its data to the
> +		 * receiving sockets and queue a second RX_ABORT, so leave it to
> +		 * the abort path.
> +		 */
> +		netdev_info(session->priv->ndev,
> +			    "%s: 0x%p: EOMA on a cancelled session\n",
> +			    __func__, session);
> +		return;
> +	}
> +
>  	session->pkt.tx_acked = session->pkt.total;
>  	j1939_session_timers_cancel(session);
>  	/* transmitted without problems */

[Severity: Low]
The state check above reads session->state without active_session_list_lock.
What happens if j1939_tp_rxtimer() or j1939_tp_txtimer() cancels the session
on another CPU after the check but before the
j1939_session_timers_cancel() and j1939_session_completed() calls here?

That cancel sets WAITING_ABORT, sends an abort and queues
J1939_ERRQUEUE_RX_ABORT. This CPU then cancels the new abort timer and
completes the session, so j1939_session_completed() still hands the message
to the sockets.

Does the check need to happen under the list lock, together with the state
change (deactivating the session or marking it as completing)? The message
would then be delivered only if that change succeeded.

> @@ -1823,14 +1840,36 @@ static void j1939_xtp_rx_dpo_one(struct j1939_session *session,

[ ... ]

> +	dpo = j1939_etp_ctl_to_packet(dat);
> +	if (dpo >= session->pkt.total) {
> +		bool was_dying = session->state >= J1939_SESSION_WAITING_ABORT;

[Severity: Medium]
was_dying is read without the list lock and before the timers are
cancelled. Can a timer callback move the session from ACTIVE to
WAITING_ABORT in between?

For example, j1939_tp_rxtimer() can fire on another CPU for the 750 ms DPO
timeout or the 1250 ms CTS timeout. Under the lock it re-arms the same
rxtimer:

			j1939_session_get(session);
			hrtimer_start(&session->rxtimer,
				      ms_to_ktime(J1939_XTP_ABORT_TIMEOUT_MS),
				      HRTIMER_MODE_REL_SOFT);
			__j1939_session_cancel(session, J1939_XTP_ABORT_TIMEOUT);

j1939_tp_txtimer() can do the same on errors, through j1939_session_cancel().

Back here, j1939_session_rxtimer_cancel() waits for the callback and then
cancels the abort timer it just armed. j1939_session_cancel() sees
WAITING_ABORT and arms nothing. The stale was_dying == false then skips the
deactivation.

Would the receive session be left on the active list with no timer?

The comment below cites j1939_xtp_rx_rts_session_active() as its model, and
that function checks session->state after the cancel. Could this decision
also be made after the cancel? For example, j1939_session_cancel() could
report whether it armed the abort timer.

> +
> +		netdev_info(session->priv->ndev,
> +			    "%s: 0x%p: data packet offset %u is not below the %u packet(s) of this session\n",
> +			    __func__, session, dpo, session->pkt.total);
> +		j1939_session_timers_cancel(session);
> +		j1939_session_cancel(session, J1939_XTP_ABORT_FAULT);
> +		if (was_dying)
> +			/* The cancel above is a no-op once the state is
> +			 * WAITING_ABORT, so it does not restart the timeout

[Severity: Low]
Is the cancel really a no-op here? j1939_session_cancel() queues RX_ABORT
outside its state guard:

	j1939_session_list_unlock(session->priv);

	if (!session->sk)
		j1939_sk_errqueue(session, J1939_ERRQUEUE_RX_ABORT);

So on the was_dying path every matching socket gets another RX_ABORT.
j1939_session_destroy() then queues one more, because session->err is set.

The new comment in j1939_xtp_rx_eoma_one() has a similar problem:

	 * to go out.  Completing it here would hand its data to the
	 * receiving sockets and queue a second RX_ABORT, so leave it to
	 * the abort path.

The abort path also ends in j1939_session_destroy(). That function queues
RX_ABORT whenever !transmission && session->err, on the completion path as
well. Should both comments be corrected?

> +			 * this function just cancelled.  Deactivate instead,
> +			 * as j1939_xtp_rx_rts_session_active() does, or the
> +			 * session stays on the active list with no timers and
> +			 * holds its skb and netdev references for good.
> +			 */
> +			j1939_session_deactivate_activate_next(session);
> +		return;
> +	}

[Severity: High]
This covers a second bad DPO. j1939_xtp_rx_dat_one() runs the same sequence
without any deactivation:

 out_session_cancel:
	kfree_skb(se_skb);
	j1939_session_timers_cancel(session);
	j1939_session_cancel(session, abort);
	j1939_session_put(session);

j1939_xtp_rx_cts_one() does the same:

 out_session_cancel:
	j1939_session_timers_cancel(session);
	j1939_session_cancel(session, err);

Can the DAT path be reached right after this rejection? Take an ETP receive
session after the echo of our own CTS, with last_cmd ==
J1939_ETP_CMD_CTS:

j1939_xtp_rx_dpo_one()      /* dpo >= pkt.total */
  j1939_session_cancel()    /* WAITING_ABORT, 500 ms timer armed,
                               last_cmd unchanged */

Then the peer sends its next DAT:

j1939_xtp_rx_dat_one()
  switch (session->last_cmd) -> default: goto out_session_cancel
  j1939_session_timers_cancel()   /* kills the abort timer */
  j1939_session_cancel()          /* already WAITING_ABORT, arms nothing */

A malformed DAT (skb->len != 8) gets there as well.

The echo of our own abort does not clean this up. It carries only
J1939_ECU_LOCAL_SRC, so j1939_tp_cmd_recv() calls
j1939_xtp_rx_abort(priv, skb, true). That only matches sessions with
transmission == true.

When the last bound socket closes, __j1939_rx_release() calls
j1939_priv_set(ndev, NULL), and j1939_netdev_notify() can no longer find
priv.

Would the session then keep its skb, its priv reference and its
netdev_hold() for good, with unregister_netdevice() waiting on it?

The underlying sequence existed before this patch: two bad DATs also
strand a session. The new DPO rejection makes it reachable with the
follow-up frame a sender would normally send. j1939_session_cancel() is
where the re-arm is skipped:

	if (session->state >= J1939_SESSION_ACTIVE &&
	    session->state < J1939_SESSION_WAITING_ABORT) {
		j1939_tp_set_rxtimeout(session, J1939_XTP_ABORT_TIMEOUT_MS);
		__j1939_session_cancel(session, err);
	}

Would it be better for j1939_session_cancel() itself to deactivate the
session, or re-arm the abort timer, when the session is already in
WAITING_ABORT? That would cover every caller and replace the was_dying
special case here and the similar one in j1939_xtp_rx_rts_session_active().

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261126150339.2110025-1-piyus%40iiitd.ac.in
