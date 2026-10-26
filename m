Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793009423;
	b=kQiqYdXWTs5USW/tLNr7oRVfvI+WUbF/LXJdUKKyzSXnnF31qqN1ZFD+pDx4SE97FVhu
	 ZiywJAJKP2aBzETm8l8Yrbmlc74R+d1caEcQC3X2Mi5tQdoMG2MiZZ6VXagzYAs3ASK0Z
	 zYtSy8I/5n4myvCtiX70RZH1vkRpqZu1wqbZT0vJS82ZB9RYxEa2uIDyJFRRQeInp1WJt
	 /K04pFjYaQmvD+w5JX9bq22O9znMRbTI9mic8IdG1nnSIWHicZDlfwOg8zYtJszH0WdH6
	 wDpstXkr5c87o9dwVhiwHwBKJsy/UAyhqBy7g77UFrjBduH3NlultwNLcKdVSqs3GtQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793009423;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=WIfVKwsrPjLWsh90vbkt1d0E7lY5jGAHXwNPjz5Yee4=;
	b=EYxMQo0oGlfeukpWAktjbtoQSQZv6gJqaQIq1ediLethU+ZxE8nyhlRQ6YnsP6qPbWLq
	 uqwZTAMHq1muB6J88vqKJPuNDRHkidHFsEU1LWn7ohxavD8OP3jywBtm+u0mAiA5HRPsM
	 zj7GZVH5O6v4OrPAKe3ZkSqPqzAv9SMcaDipOPn5OrIPcn5UEVAnecRQze3ydC8XXOOe4
	 yftuFEJ7cYiJ55Bajs9nYQZgaXaVcVh+R9W8uC7U+/UgEyN3UW8DLCdXeFqu24aNOYO/b
	 LzM1NlGy9eg8QkgU9CO7QW86W5ALk962Yl+VGeYOjj4aSzc4GHtrrg/H6g3/d7tEMZA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=F1tsCOGF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.173
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12170606A31E
	for <linux-can@vger.kernel.org>; Mon, 26 Oct 2026 10:10:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12170606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=F1tsCOGF
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3a49a022221so19166131fa.3
        for <linux-can@vger.kernel.org>; Mon, 26 Oct 2026 03:10:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793009421; cv=none;
        d=google.com; s=arc-20260327;
        b=IY/cvvTAbE63U74w43eYnr3Ep3WbY4H2SBA9coa5QB/xvzXwMwKcX25gETUK3aEaHE
         QgYGBoSg2rxXYJwGnShV09wzaOjAOQTnDZOP6HgiML5g7Nwosc+Q+JzGx2K6J6tx7BkC
         2d9+r6JLfn9FZsV5ELNEQi4RG+XITbHEAVZoY3zaQsCCZAD/VpEJuc6FqUOZ6af9nVFL
         czVWcDSTsuZlIf1suIRBf0ShUEXLqfrut7BiFYOLAjr43Emg4p4P+Rd1QJ7zjVm9e1Rm
         B7uFwTzVhFFaUVmZNYRVfc0/13lz1HAajWVcVQbFOMp4Yh95blSX7IIRx4+X1nkHk5zQ
         exQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WIfVKwsrPjLWsh90vbkt1d0E7lY5jGAHXwNPjz5Yee4=;
        fh=UDmiFjDUsl58/oI1pbxKLXmAuoEiB7qNSJQzd9c7Gr0=;
        b=RhV1d3EIfmU9PE8ALUHTZTgkfYLgFzQwKUO5Z1QH/+WHJRxRwNe9tBTu+UtOwaNzsy
         pCe22p36kTSaBoB5ujgpBLwVIH3t1u8go/p49A6yBmvE9GYCiUqtTdIHwvS+bj99zOib
         ouSdTXaJX8tSpv4LwzlfXTFL0mI4c0p535tIgXDdoiR7a3GXf08qUcNDA9IE8rCxmCAx
         pXkpo6Kt6KydDEskYAxak59/hvy7jW/0jWg1419LVFjiU/vpf6U/EQWK2Zph2yz5DeDt
         7vZIwFCxz5FAYBOYiitfAN2JSIenyvFJHULZqeiBOvGnotUV59dtL8y46xhOIPzdgT88
         nO1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1793009421; x=1793614221; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WIfVKwsrPjLWsh90vbkt1d0E7lY5jGAHXwNPjz5Yee4=;
        b=F1tsCOGFyrf1GEzPd64XH5MJHVQc60iZDkDWIPh/r7T8yrgwDjcGubeG2M8wDK/QyR
         BzZO9PrxgggBCXfzJ1KQlHVhmhDY/O2KArOY28csqGy5C4eCywmOiZdew8og88ax1/+a
         MAKkj4eznUStaaT5EMsLxdst/bpEbw4yfTnGkXjcYwzXDyJmNu8AhXSWuJMChJ8frlzd
         Srt5Pq2gqeUxYzhBTOId4ESJ3Ndk6DwR9Q4F/RP1cSxiRl4pcqasfnFb9ZLKkBo+xqlL
         8Gt19PDZggcYbsUMUSjzoH1PtdSP1wfJYM0CyQmHgDjWLZKtgK4Rv+WH8HhAMywmoTk4
         JRHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793009421; x=1793614221;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WIfVKwsrPjLWsh90vbkt1d0E7lY5jGAHXwNPjz5Yee4=;
        b=n1FPtCcIXVWK1hOXIcFLLwwW70XiSe0MHT+MB8IDaEDI8g6UUQLakP3IZJqqs/I2kB
         5oFFY3IkBTuwoXik3wR1bE1XqkRSoBGw9ryLhJCoP42hfD4TbgkqLKPnIAdlo/cBiQfr
         efkZE8vnQlIJ4JsjXOmwLRA7pS18B99RoeuThm8MFbFadBaHH+okngkl1HDxc/9u2H3+
         Fs3FsUVGx9T8sypGM6N/vamXcCv2APvUzOrWKkC6TuVb73RsQF6jNgbxcTynBlHv18Of
         uvhbVmp69TKZX4HIHJC9LH0LcJe5mGGHgwuahQPMHLCsMdIDQGv5zBG+9SCuHYqRvehR
         +tCg==
X-Gm-Message-State: AFq9FYIy89XMwk6jtkZ1roMX2UUVhbMFqU+fCJj77/m8eJK8RA7mlUJP
	GF25ydZcMBDW4Jcbz0dQVfGkfdKkF3z2cvjnr9NYUSNrzTGbLqAJgzZ8EEDQsG1M+KP8gQTWHfF
	LBUXjFIlJn7Riaduel1TaGZRA5/l5h2MJIiTgWWca7l8=
X-Gm-Gg: AYBFou3+hzhMhni8Z47HpRuU9X7jJjhf2/sVl/CPtr5eCQkdX42oZDjHm5eI2Xg31P0
	kIsg4OTk2wolrpPTYt0B10jfr8oZD/jIvyTFmVPgbJ0lx1eJb2aybe6gYbNJdt5LLNUTaZq/0dt
	hYjPZKr+vVSF3EYhov2TNCgnUpTDdP5532nZlpkLAGgCxctZ2dNHObhE+/yb7QY99ZfgqALxBn6
	GwEFo24lzE4PXz0HF2Oz7kHg2MKKVm0YLh0TTLGqM8sYIcTfOWTzAtgEK9VbMjifM01CRzPoBls
	qf7GG6BW1OGcss3vxE4zL83CP+FJp2jtfGJiEBPtN22TXCWHYoY8W6rt55rGZI5Qo0jNvcsBJrj
	9I9Epz9dA63TarXn6l16o7ZGgEyJgqWcZZRRahOCmylPRpXYAjDeCKa3A00XnVNDTqmf6
X-Received: by 2002:a05:651c:a143:b0:3ab:540b:f4a7 with SMTP id
 38308e7fff4ca-3ac6fcaf492mr11424881fa.8.1793009421188; Mon, 26 Oct 2026
 03:10:21 -0700 (PDT)
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1792979091.git.zihanx@nebusec.ai> <6bbcca411ac9433ae4ed8b8e64f56ff16dfc20b0.1792979091.git.zihanx@nebusec.ai>
 <sashiko-outbox-184711@kernel.org>
In-Reply-To: <sashiko-outbox-184711@kernel.org>
From: zihan xi <zihanx@nebusec.ai>
Date: Mon, 26 Oct 2026 18:10:09 +0800
X-Gm-Features: AclHuK9mL9U7eY2u3lf4XfdQUvXs_JXzYKSaspkKJwT8jnFIkLa-JlQEAUVocso
Message-ID: <CAANe3eQrZjWanuiFgNjhsoQb7W5fRm+JVFjnGOtD03Z3aNyTCQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] can: j1939: fix session reference leak on TX timer restart
To: sashiko-reviews@lists.linux.dev
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Oliver Hartkopp <socketcan@hartkopp.net>, Vincent Mailhol <mailhol@kernel.org>, 
	Oleksij Rempel <o.rempel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 4:57=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [Critical] can: j1939: session refcount underflow in j1939_tp_schedule_=
txtimer()
> - [High] can: j1939: race between j1939_tp_schedule_txtimer() and txtimer=
 cancellation
> --
>
> commit 132d2449245f60a20ddade9b51a9c2efc0a02136
> Author: Zihan Xi <zihanx@nebusec.ai>
>
> can: j1939: fix session reference leak on TX timer restart
>
> This patch adds a spinlock to serialize TX timer rearming in
> j1939_tp_schedule_txtimer() and reuses the existing session reference whe=
n
> restarting an already queued TX timer.
>
> Link: https://bugtracker.nebusec.ai/f/11143
>
> > diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> > index 8fcfd13e5e6f8..e9af8547c69b4 100644
> > --- a/net/can/j1939/transport.c
> > +++ b/net/can/j1939/transport.c
> > @@ -716,9 +716,17 @@ static int j1939_xtp_tx_abort(struct j1939_priv *p=
riv,
> >
> >  void j1939_tp_schedule_txtimer(struct j1939_session *session, int msec=
)
> >  {
> > -     j1939_session_get(session);
> > +     int ret;
> > +
> > +     spin_lock_bh(&session->txtimer_lock);
> > +     /* Keep the timer's reference when only changing its expiry. */
> > +     ret =3D hrtimer_try_to_cancel(&session->txtimer);
>
> [Severity: High]
> Could temporarily dequeuing session->txtimer here race with callers that
> cancel the timer without holding session->txtimer_lock?
>
> In net/can/j1939/transport.c, neither j1939_session_txtimer_cancel() nor
> j1939_cancel_active_session() acquires session->txtimer_lock:
>
> static void j1939_session_txtimer_cancel(struct j1939_session *session)
> {
>         if (hrtimer_cancel(&session->txtimer))
>                 j1939_session_put(session);
> }
>
> and in j1939_cancel_active_session():
>
>         if (hrtimer_try_to_cancel(&session->txtimer) =3D=3D 1)
>                 j1939_session_put(session);
>
> Previously, j1939_tp_schedule_txtimer() called hrtimer_start() directly o=
n
> an already queued timer, updating its expiry under the hrtimer base lock
> without transitioning hrtimer_active(&session->txtimer) to false.
>
> With this change, when session->txtimer is queued and its callback is not
> running, hrtimer_try_to_cancel(&session->txtimer) dequeues the timer and
> returns 1, making hrtimer_active(&session->txtimer) false until
> hrtimer_start() runs.
>
> If another CPU calls j1939_session_txtimer_cancel() (for example via
> j1939_session_timers_cancel() on session abort or completion, or from
> j1939_xtp_rx_cts_one()) or j1939_cancel_active_session() during that wind=
ow,
> hrtimer_cancel() / hrtimer_try_to_cancel() will see the timer as inactive
> and return 0. j1939_tp_schedule_txtimer() will then call hrtimer_start() =
and
> re-arm session->txtimer on a session whose timers were already cancelled.

The refcount race is valid: the queued-state check is not atomic with
callback completion, expiry, or cancellation. I=E2=80=99ll rework the
timer-reference ownership protocol before resubmitting.
>
> > +     /* A running callback may already have requeued the timer. */
> > +     if (ret !=3D 1 && !hrtimer_is_queued(&session->txtimer))
> > +             j1939_session_get(session);
> >       hrtimer_start(&session->txtimer, ms_to_ktime(msec),
> >                     HRTIMER_MODE_REL_SOFT);
>
> [Severity: Critical]
> What prevents a queued session->txtimer from expiring or being cancelled
> between the lockless hrtimer_is_queued() check and hrtimer_start(), causi=
ng
> a refcount underflow on session->kref?
>
> In kernel/time/hrtimer.c, hrtimer_try_to_cancel() leaves the timer queued
> and returns -1 whenever the timer callback is currently running:
>
>         if (!hrtimer_callback_running(timer)) {
>                 ret =3D remove_hrtimer(timer, base, HRTIMER_STATE_INACTIV=
E);
>                 if (ret)
>                         trace_hrtimer_cancel(timer);
>         }
>
> Consider the following sequence across two CPUs when j1939_tp_txtimer() i=
s
> running on CPU 0 and has already requeued session->txtimer once (holding =
one
> session->kref reference for the running callback and a second reference f=
or
> the queued timer):
>
> 1. CPU 1 calls j1939_tp_schedule_txtimer() and takes session->txtimer_loc=
k.
>    Because j1939_tp_txtimer() is still running on CPU 0,
>    hrtimer_try_to_cancel(&session->txtimer) returns -1 without removing t=
he
>    queued timer.
>
> 2. CPU 1 checks hrtimer_is_queued(&session->txtimer), which observes
>    timer->is_queued =3D=3D 1, so CPU 1 skips j1939_session_get(session) i=
ntending
>    to reuse the queued timer's reference.
>
> 3. Before CPU 1 enters hrtimer_start() and takes the hrtimer base lock, t=
he
>    running j1939_tp_txtimer() callback on CPU 0 finishes (dropping its ow=
n
>    reference via j1939_session_put(session)), and the queued timer either=
:
>    - immediately expires in __hrtimer_run_queues() / __run_hrtimer() (whi=
ch
>      does not take session->txtimer_lock), dequeuing the timer and runnin=
g a
>      second j1939_tp_txtimer() that drops the second session->kref refere=
nce:
>
>         j1939_session_put(session);
>
>         return HRTIMER_NORESTART;
>
>    - or is cancelled by an unlocked j1939_session_txtimer_cancel() or
>      j1939_cancel_active_session() on another CPU, which also dequeues th=
e
>      timer and drops the second session->kref reference.
>
> 4. CPU 1 then executes hrtimer_start(&session->txtimer, ...), which enque=
ues
>    session->txtimer from the inactive state without having taken a new
>    session reference.
>
> When that newly started timer subsequently fires in j1939_tp_txtimer() or=
 is
> cancelled, j1939_session_put(session) will drop a reference that was neve=
r
> taken, underflowing session->kref and freeing struct j1939_session while =
it
> is still in use.

The cancellation race is also valid: cancellation is not serialized
with rearming. I=E2=80=99ll address both races together and re-review the
callback and teardown paths.
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792979091.=
git.zihanx@nebusec.ai?part=3D1
