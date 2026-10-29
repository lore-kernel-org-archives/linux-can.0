Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793268169;
	b=GyC9M2vfb0VANX22LlFAQdNGSeSZuJvEaF0uyAPNGorfL1sSPErbRLZsc1PwQNQEQeF2
	 3rnsJ/Avizf4fCXgUfrNvPTfdMavMRyd5ZHgsDT848qZp+PZiPiM7ENBxeboQyrPOdZ/i
	 /TTrlnkROlHmB/pprVSjJQkWlEbWtE1uevxKFFe/fI8Da9cesWN+sLAa8ftZnmHfuCBl/
	 6wlebtL1+OVUpvO6CyRCP3zAhUaXXwf92FKDvfwLh53FTgNwjZBxbY2BrLbp4TvRAEq2B
	 cQHWnNceKeHaKFvu89I60akpausWmBfZh4WMWOzGe601emNVtiu+ZM8ZE4GBSYMQLlQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793268169;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=6iQa+csK5IjT3mexfwqthY2wIT9oXO6qpsqrgSw5lko=;
	b=ASXasNt72/C6kk6ZgInC8gTbgc80Wz1tvRE56aUjrCfbgxxrMvzHfA7GjlYBNsaq+hb9
	 f5VfxzzaDkpTw+wN7Oe7VLgTo1EyKvUH24i8AdGVHHPUhTY45AODh2S1SiATmxN4BRmBe
	 BI3qAZlVTn/bi1mLTe3Jl3chw8mw7NukBU74vhwktt51cNePW6iFxWrSTUdguQinqXipQ
	 HHLE3IgY7oTqnOkiBGO3idQQBufyHrS+8ahv/OF+n4QA1j5l2sBzvx/wAytKLMInKxIYC
	 UHqinD++tvLJaSKcFW+Lxi5no2QJJI+fDRNRe0Aby38K0+CHW0E+kq/KLrZ0u7+q9Dw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=C63nIuKy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.174
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC2D606A31C
	for <linux-can@vger.kernel.org>; Thu, 29 Oct 2026 10:02:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DC2D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=C63nIuKy
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3a75f960be3so18580901fa.2
        for <linux-can@vger.kernel.org>; Thu, 29 Oct 2026 03:02:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793268167; cv=none;
        d=google.com; s=arc-20260327;
        b=mFTQ61zq3bZ7BqnZ6F0cHcO+Jkko1Y6PVz4p7FVYw0gmOq283YZH+tVE1dgmSSOY5+
         aTejoNO3gsuKc5Fl/k548FPKrjyAWv0s7VgOL9uafqJaCK8cG/nfdOkg3l32bqvSNZ5o
         VVdejG8UxAiC7M9bq9J6+mPfP7+XfnHqzmxk8UYHYVv+zgYK1x3GAS9SIuSmFCUgx6fc
         vDh7V/Cj6i7G/bMUk0VIVu304nc1pPYXNzh2ogKadrNuv+nj7mLMGwZ/+N3igTvCU8Hz
         +jAWMbBw/z5v8hkY7yurB6r+ufJIvqsGuithAXUQwSfmgJE4ZVm+NaXY5S5wWh+pEcIo
         VnTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6iQa+csK5IjT3mexfwqthY2wIT9oXO6qpsqrgSw5lko=;
        fh=UDmiFjDUsl58/oI1pbxKLXmAuoEiB7qNSJQzd9c7Gr0=;
        b=Q/X7iZBpGCd2hl5KDW1QyjR5ql8S1hG5kOAxHl4WGXlZlP3DKPnNfpKnkO+YD3bsv+
         0nr/9v4Byj5mlNaNuxrz3E6ocoqpv6Hip0pUlM3qArXWH6SsDmT7FH66CAsR2e4TUxsv
         y4vrw6RhE2Bj62xC/kxl/OoYIwd8YyZFknEkXGlpU/xIALyzQxQ/EucpupWqAjibxSsz
         FT4kKhrFsNHD+vw4naWuG9SCzOZNpIgUWrBFV1tQyPl59PV1F92HkBIgvPhvfcbe+jhi
         B6q9TfveCccZcBfHe7aHcE62rpXRUw0gjSrdtgbZ7IJBRlDBWBVxDMA5+nu+V/QoFmh4
         02gg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1793268167; x=1793872967; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6iQa+csK5IjT3mexfwqthY2wIT9oXO6qpsqrgSw5lko=;
        b=C63nIuKyylh7KXk+TWYi8DEt4Cp8/vhXKr9rslW74iVeB2W1BJztKbzx1SWGvnAx3W
         fr51Zuvcl22LgBp7ZudMkzFXwMCIARBYvH47JFFqXulypoCuKmUgsI0nkLhBQCTFyrVy
         ugp5LTK967zvnoG4/dPRwJhFKLWwjRskJlQrzBAoiTV3olsIt7xrFUesfQpasz5JTvP/
         5ss6Qee0oqfXOcu+uvkOv7lF16MrRl59CRlP2ptAkhA2sDpBUA2CFBdgR9nmHrwd6LQf
         w2R0nXNjdqRL+tc7BiaT3q+0/WTZfRZlPt5FhYt/0yLF876p3l1lAEyp9VZ7bPoWT4M0
         +/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793268167; x=1793872967;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6iQa+csK5IjT3mexfwqthY2wIT9oXO6qpsqrgSw5lko=;
        b=TcgShpByxNCS6EykDRmFq8xfKjaSLFG32HnZTKHW80FfHcTP3w2+bkJspU6StjeOKg
         ABzN+CJRmvkv1wK2VwLrf9dZUPkwiyo1+uR7ULGjOdKuxMyhu2i0WxAGTV+q29BNjYxc
         SszeQL9YxUyV3IEJCWUof+mNSSptfTC0p1///CbDGI4mZJxOB5g4fonLnuPXHHsw6wO9
         2R+bgTS32gt6f6zdwj67U2wqX9K05rz6bdXawMweRDQVb6WQBj7GGGyGeIQzSXVSRWYT
         bBN9lx/AqW3BMxlfCh3ZDr3aH4+X1snz2zN0e+i7VFz+TkKTMF2rbQ4+eTZxlnyla13/
         /91A==
X-Gm-Message-State: AFq9FYIIstjifeVxcDKsCHMC80ZElMakPRD4PREGeFigMReGy/vuIPVJ
	SlYRAPyV+2Y6i/kA1PiCjx0fW954WkqwHcOFqhyQID2L6bXJ8lxEDbUGONjmJKt4uw5qCzoIPJM
	Ae7sXT6iaJJy0p453P3plS0W22ubKMIZBO2KC00LPQMA=
X-Gm-Gg: AYBFou2BXyx3BALR3Cj1HuEPzf4k7aJsJeZ3d2nA9IeuORmjA/wova4ACMoqPQTGG1s
	YWNlLiyHrgfkHh592pEOVIfwrx7ztMBT2qHP8aszUf7KCeJEX3g7cQsgWyr30da0Ouf4N8eWDiU
	2Tuo3r2hbDBV5QzovSvB9FbeohPp07JnDUAAltuHpnlpDlvPHA3nYi2yj4NBqIDdZrzMOxn9Pxf
	/0hfUkpTY8CCsnWOCggN2kHi151WxNq8q4+eNM8U6ap7O/roo39cOwpcdhMQdKhL+45M7Unh+8A
	vZ22PFS3z1Otr1SK+zZ3UBo4YP820fVGJsaoDJ3k6+LMsdNBkNIGv/9K9V/EZgSLgyTKyFsxzAi
	G2sNldzk/CPCJgS29mu/+FmnCFORARBzZIz136ii8Y2udBQrC0DdhbCTZrRkjlhsAVrEr
X-Received: by 2002:a2e:b8ca:0:b0:3ab:48e6:6783 with SMTP id
 38308e7fff4ca-3ac9ce3b947mr11587791fa.2.1793268167152; Thu, 29 Oct 2026
 03:02:47 -0700 (PDT)
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1793259424.git.zihanx@nebusec.ai> <a683b6afb2c21e0d05be0ebe18c4f60b98152d25.1793259424.git.zihanx@nebusec.ai>
 <sashiko-outbox-189012@kernel.org>
In-Reply-To: <sashiko-outbox-189012@kernel.org>
From: zihan xi <zihanx@nebusec.ai>
Date: Thu, 29 Oct 2026 18:02:33 +0800
X-Gm-Features: AclHuK-EkVpjHr16G0lR9YcS6ivNboOau7EQX62qEElvvaaKkBsqoi7q1Ii34po
Message-ID: <CAANe3eSNKGcFtetJurYR=YjUmuR-paWif4FXQpTMwnKMv_4aCg@mail.gmail.com>
Subject: Re: [PATCH net v3 2/3] can: j1939: stop TX sends after session shutdown
To: sashiko-reviews@lists.linux.dev
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Oliver Hartkopp <socketcan@hartkopp.net>, Vincent Mailhol <mailhol@kernel.org>, 
	Oleksij Rempel <o.rempel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 5:15=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 5 potential issu=
e(s) to consider:
> - [High] can: j1939: timer callbacks still cancel session after tx_send_s=
hutdown
> - [High] can: j1939: unconditional error notifications outside session st=
ate guards
> - [High] can: j1939: session leak on sk_session_queue when simple TX race=
s rxtimer
> - [Medium] can: j1939: TX sends not shut down before draining timers on c=
ompletion
> - [Medium] can: j1939: spurious netdev_alert() in j1939_session_tx_dat() =
on -ESHUTDOWN
> --
>
> commit 2c11cd00299ff52c942a6b68d469115b501da6d9
> Author: Zihan Xi <zihanx@nebusec.ai>
>
> can: j1939: stop TX sends after session shutdown
>
> This commit introduces a per-session tx_send_lock and tx_send_shutdown ga=
te to
> serialize session data and control frame transmissions against session
> deactivation and incoming XTP ABORT handling. It also suppresses sending =
an
> outbound XTP ABORT frame when tx_send_shutdown has been set.
>
> Link: https://bugtracker.nebusec.ai/f/11143
> Link: https://lore.kernel.org/all/cover.1793012287.git.zihanx@nebusec.ai/
>
> > diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> > index 0dd08d1b8f755..570e2b8d08263 100644
> > --- a/net/can/j1939/transport.c
> > +++ b/net/can/j1939/transport.c
>
> [ ... ]
>
> > @@ -1363,12 +1398,14 @@ static void __j1939_session_cancel(struct j1939=
_session *session,
> >       struct j1939_priv *priv =3D session->priv;
> >
> >       WARN_ON_ONCE(!err);
> > +     lockdep_assert_held(&session->tx_send_lock);
> >       lockdep_assert_held(&session->priv->active_session_list_lock);
> >
> >       session->err =3D j1939_xtp_abort_to_errno(priv, err);
> >       session->state =3D J1939_SESSION_WAITING_ABORT;
> >       /* do not send aborts on incoming broadcasts */
> > -     if (!j1939_cb_is_broadcast(&session->skcb)) {
> > +     if (!session->tx_send_shutdown &&
> > +         !j1939_cb_is_broadcast(&session->skcb)) {
> >               j1939_xtp_tx_abort(priv, &session->skcb,
> >                                  !session->transmission,
> >                                  err, session->skcb.addr.pgn);
> > @@ -1381,6 +1418,7 @@ static void __j1939_session_cancel(struct j1939_s=
ession *session,
> >  static void j1939_session_cancel(struct j1939_session *session,
> >                                enum j1939_xtp_abort err)
> >  {
> > +     spin_lock_bh(&session->tx_send_lock);
> >       j1939_session_list_lock(session->priv);
> >
> >       if (session->state >=3D J1939_SESSION_ACTIVE &&
> > @@ -1391,6 +1429,7 @@ static void j1939_session_cancel(struct j1939_ses=
sion *session,
> >       }
> >
> >       j1939_session_list_unlock(session->priv);
> > +     spin_unlock_bh(&session->tx_send_lock);
> >
> >       if (!session->sk)
> >               j1939_sk_errqueue(session, J1939_ERRQUEUE_RX_ABORT);
>
> [Severity: High]
> When j1939_xtp_rx_abort_one() processes an incoming XTP ABORT frame, it c=
alls
> j1939_session_tx_send_shutdown(session) and then drains both timers via
> j1939_session_timers_cancel(session) while session->state is still
> J1939_SESSION_ACTIVE:
>
> net/can/j1939/transport.c:j1939_xtp_rx_abort_one() {
>         ...
>         j1939_session_tx_send_shutdown(session);
>         j1939_session_timers_cancel(session);
>         j1939_session_list_lock(priv);
>         if (session->state >=3D J1939_SESSION_ACTIVE &&
>             session->state < J1939_SESSION_ACTIVE_MAX)
>                 session->err =3D j1939_xtp_abort_to_errno(priv, abort);
>         j1939_session_list_unlock(priv);
>         if (session->sk)
>                 j1939_sk_send_loop_abort(session->sk, session->err);
>         else
>                 j1939_sk_errqueue(session, J1939_ERRQUEUE_RX_ABORT);
>         j1939_session_deactivate_activate_next(session);
> }
>
> While j1939_session_timers_cancel() is waiting for txtimer in
> j1939_session_txtimer_cancel() (before j1939_session_rxtimer_cancel_sync(=
)
> increments session->rxtimer_cancelers), a concurrent j1939_tp_txtimer()
> callback that fails prior to j1939_session_tx_send() (for instance with
> -EOVERFLOW in j1939_session_tx_dat(), -ENOENT in j1939_session_tx_cts() o=
r
> j1939_session_tx_eoma(), or -ENOMEM in j1939_tp_tx_dat_new()) can call
> j1939_session_cancel(), or a concurrent j1939_tp_rxtimer() callback can e=
nter
> its non-simple timeout branch.
>
> Because !session->tx_send_shutdown is only checked around j1939_xtp_tx_ab=
ort()
> inside __j1939_session_cancel() rather than gating the cancellation block=
 in
> j1939_session_cancel() and j1939_tp_rxtimer(), won't the timer callback s=
till:
>
> 1. rearm session->rxtimer for J1939_XTP_ABORT_TIMEOUT_MS via
>    j1939_tp_set_rxtimeout_locked() (or record session->rxtimer_pending =
=3D true
>    if rxtimer_cancelers is non-zero),
> 2. overwrite session->err with the local timer error and transition
>    session->state to J1939_SESSION_WAITING_ABORT, and
> 3. immediately call j1939_sk_send_loop_abort(session->sk, session->err),
>    waking session->sk with the wrong sk_err before j1939_xtp_rx_abort_one=
()
>    sets session->err from the received ABORT frame and notifies the socke=
t a
>    second time?
>
> Should j1939_session_cancel() and the timeout branch in j1939_tp_rxtimer(=
)
> check !session->tx_send_shutdown before rearming rxtimer and calling
> __j1939_session_cancel()?
>

Agreed. The shutdown gate currently prevents sends, but does not prevent
timer callbacks from changing session state, rearming the RX timer, or
reporting errors. I will serialize these terminal side effects in the next
revision.

> [ ... ]
>
> > @@ -1460,6 +1498,9 @@ static enum hrtimer_restart j1939_tp_txtimer(stru=
ct hrtimer *hrtimer)
> >                * propagation of the error to user space.
> >                */
> >               break;
> > +     case -ESHUTDOWN:
> > +             /* A terminal path won before this packet could be sent. =
*/
> > +             break;
> >       case -EOVERFLOW:
> >               j1939_session_cancel(session, J1939_XTP_ABORT_ECTS_TOO_BI=
G);
> >               break;
>
> [Severity: Medium]
> Here j1939_tp_txtimer() treats -ESHUTDOWN as an expected race with sessio=
n
> shutdown, but in j1939_tp_txtimer() -> j1939_xtp_txnext_transmiter() ->
> j1939_session_tx_dat(), a -ESHUTDOWN return from j1939_tp_tx_dat() still =
hits
> the error log check:
>
> net/can/j1939/transport.c:j1939_session_tx_dat() {
>         ...
>                 ret =3D j1939_tp_tx_dat(session, dat, len + 1);
>                 if (ret < 0) {
>                         /* ENOBUFS =3D=3D CAN interface TX queue is full =
*/
>                         if (ret !=3D -ENOBUFS)
>                                 netdev_alert(priv->ndev,
>                                              "%s: 0x%p: queue data error:=
 %i\n",
>                                              __func__, session, ret);
>                         break;
>                 }
> }
>
> Will a session shutdown racing with j1939_session_tx_dat() emit a spuriou=
s
> netdev_alert() with -ESHUTDOWN (and still call j1939_tp_set_rxtimeout() i=
f
> pkt_done > 0 from earlier packets in the loop)?

Agreed. -ESHUTDOWN is an expected result when terminal shutdown wins. I
will suppress that alert and avoid rearming the RX timeout after this
shutdown result, including when earlier packets were sent in the loop.
>
> > @@ -1558,6 +1599,7 @@ static enum hrtimer_restart j1939_tp_rxtimer(stru=
ct hrtimer *hrtimer)
> >               /* The message is probably stuck in the CAN controller an=
d can
> >                * be send as soon as CAN bus is in working state again.
> >                */
> > +             spin_lock_bh(&session->tx_send_lock);
> >               j1939_session_list_lock(priv);
> >               if (session->state >=3D J1939_SESSION_ACTIVE &&
> >                   session->state < J1939_SESSION_ACTIVE_MAX) {
> >                       session->err =3D -ETIME;
> >                       j1939_session_deactivate_locked(session);
> >               }
> >               j1939_session_list_unlock(priv);
> > +             spin_unlock_bh(&session->tx_send_lock);
> >               j1939_session_txtimer_cancel_async(session);
> >               j1939_session_rxtimer_cancel(session);
>
> [Severity: High]
> Can this J1939_SIMPLE timeout path in j1939_tp_rxtimer() leak the session=
 on
> jsk->sk_session_queue and hang socket close when it races with
> j1939_simple_txnext()?

Agreed. If the SIMPLE timeout deactivates the session before the send path
advances the socket queue, the queued session can remain pending. I will
ensure the winning terminal path advances or removes it exactly once.

>
> In j1939_tp_txtimer() -> j1939_simple_txnext(), rxtimer is armed before
> j1939_session_tx_send() is called, and j1939_sk_queue_activate_next(sessi=
on)
> is only called if j1939_session_tx_send() succeeds:
>
> net/can/j1939/transport.c:j1939_simple_txnext() {
>         ...
>         j1939_tp_set_rxtimeout(session, J1939_SIMPLE_ECHO_TIMEOUT_MS);
>
>         ret =3D j1939_session_tx_send(session, skb);
>         if (ret)
>                 goto out_free;
>
>         j1939_sk_errqueue(session, J1939_ERRQUEUE_TX_SCHED);
>         j1939_sk_queue_activate_next(session);
> }
>
> If j1939_tp_rxtimer() fires before j1939_session_tx_send() succeeds (eith=
er
> between j1939_tp_set_rxtimeout() and j1939_session_tx_send(), or while tx=
timer
> is retrying after j1939_session_tx_send() returned -ENOBUFS),
> j1939_tp_rxtimer() transitions session->state to J1939_SESSION_DONE via
> j1939_session_deactivate_locked() and cancels both timers without calling
> j1939_sk_queue_activate_next(session).
>
> When j1939_simple_txnext() then calls j1939_session_tx_send(), it sees
> state !=3D J1939_SESSION_ACTIVE and returns -ESHUTDOWN, jumping to out_fr=
ee
> without calling j1939_sk_queue_activate_next(session), and j1939_tp_txtim=
er()
> breaks out of its switch on -ESHUTDOWN.
>
> Doesn't that leave session permanently queued on jsk->sk_session_queue wi=
th
> its queue kref and jsk->skb_pending count held, stalling subsequent queue=
d
> sessions and causing j1939_sk_release() to block indefinitely waiting on
> !j1939_sock_pending_get(&jsk->sk)?
>
> >       } else {
> > +             spin_lock_bh(&session->tx_send_lock);
> >               j1939_session_list_lock(session->priv);
> >               if (!session->rxtimer_cancelers &&
> >                   session->state >=3D J1939_SESSION_ACTIVE &&
> >                   session->state < J1939_SESSION_ACTIVE_MAX) {
> >                       netdev_alert(priv->ndev, "%s: 0x%p: rx timeout, s=
end abort\n",
> >                                    __func__, session);
> >                       j1939_tp_set_rxtimeout_locked(session,
> >                                                     J1939_XTP_ABORT_TIM=
EOUT_MS);
> >                       __j1939_session_cancel(session, J1939_XTP_ABORT_T=
IMEOUT);
> >               }
> >               j1939_session_list_unlock(session->priv);
> > +             spin_unlock_bh(&session->tx_send_lock);
> >
> >               if (!session->sk)
> >                       j1939_sk_errqueue(session, J1939_ERRQUEUE_RX_ABOR=
T);
>
> [Severity: High]
> In this branch of j1939_tp_rxtimer(), as well as in j1939_session_cancel(=
) and
> j1939_xtp_rx_abort_one(), the socket error notification outside the lock =
runs
> unconditionally even when the state check (or !session->rxtimer_cancelers=
)
> evaluates to false.
>
> For example, when an RX session (!session->sk) completes in
> j1939_xtp_rx_dat_one() (when final is true) and calls
> j1939_session_timers_cancel() -> j1939_session_rxtimer_cancel_sync(),
> session->rxtimer_cancelers is incremented while waiting for a running
> j1939_tp_rxtimer() callback to finish. In j1939_tp_rxtimer(), the conditi=
on
> !session->rxtimer_cancelers is false, so __j1939_session_cancel() is skip=
ped
> and session->err remains 0, but j1939_tp_rxtimer() still calls
> j1939_sk_errqueue(session, J1939_ERRQUEUE_RX_ABORT) after dropping the lo=
cks.
>
> Similarly, if j1939_session_cancel() or j1939_xtp_rx_abort_one() finds th=
at
> another path already transitioned session->state out of the active range,=
 it
> still invokes j1939_sk_errqueue() or j1939_sk_send_loop_abort().
>
> Should these error notifications be gated on whether the caller actually =
won
> the state transition?

Agreed. I will make socket error reporting conditional on winning the
relevant state transition, including the session-cancel, RX-timeout, and
incoming-ABORT paths.
>
> > @@ -1671,6 +1716,8 @@ static void j1939_xtp_rx_abort_one(struct j1939_p=
riv *priv, struct sk_buff *skb,
> >                   session, j1939_xtp_ctl_to_pgn(skb->data), abort,
> >                   j1939_xtp_abort_to_str(abort));
> >
> > +     /* Stop TX callbacks before waiting for the timer callbacks to dr=
ain. */
> > +     j1939_session_tx_send_shutdown(session);
> >       j1939_session_timers_cancel(session);
> >       j1939_session_list_lock(priv);
> >       if (session->state >=3D J1939_SESSION_ACTIVE &&
>
> [Severity: Medium]
> Here j1939_xtp_rx_abort_one() calls j1939_session_tx_send_shutdown(sessio=
n)
> before j1939_session_timers_cancel(session), because session->state is st=
ill
> J1939_SESSION_ACTIVE while the timers are being drained.
>
> However, the other paths that call j1939_session_timers_cancel(session) b=
efore
> deactivating or canceling the session do not call
> j1939_session_tx_send_shutdown(session) first:
>
> - j1939_xtp_rx_eoma_one() sets session->pkt.tx_acked =3D session->pkt.tot=
al,
>   calls j1939_session_timers_cancel(session), and only then calls
>   j1939_session_completed(session) -> j1939_session_deactivate().
> - j1939_xtp_rx_dat_one() (both the final completion branch and
>   out_session_cancel) calls j1939_session_timers_cancel(session) before
>   j1939_session_completed(session) or j1939_session_cancel(session, abort=
).
> - j1939_simple_recv() calls j1939_session_timers_cancel(session) before
>   j1939_session_deactivate(session).
> - j1939_xtp_rx_cts_one() (at out_session_cancel) and
>   j1939_xtp_rx_rts_session_active() call j1939_session_timers_cancel(sess=
ion)
>   before j1939_session_cancel().
>
> While j1939_session_timers_cancel() is waiting for an in-flight
> j1939_tp_txtimer() callback in those paths, both session->tx_send_shutdow=
n is
> false and session->state is J1939_SESSION_ACTIVE, so j1939_session_tx_sen=
d()
> still allows packets through (and in j1939_xtp_rx_eoma_one(), a concurren=
t
> j1939_tp_rxtimer() firing before rxtimer_cancelers is incremented can sti=
ll
> send an XTP ABORT frame on a completed session).
>
> Should j1939_session_timers_cancel() itself call
> j1939_session_tx_send_shutdown(session) (or should those callers shut dow=
n TX
> sends before draining the timers)?

Agreed. Completion paths must close the session send gate before waiting
for timer callbacks. I will distinguish terminal shutdown from timer drains
that are temporary and allow the session to continue.
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793259424.=
git.zihanx@nebusec.ai?part=3D2
