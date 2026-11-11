Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794370906;
	b=z9D96OjvQJvPzxICi/8RnZl9uH2cT/V/7hAtrV+arHpINBz5mQc9WR6n+X4nzybJQ/0i
	 xKT1qtqx3lo3KPNRfEobuluTu4OGfJ/nava+BfEu8qYB2ZoCGCEGGFptJEWCI42f1yNxv
	 5CWmujuRg/z9Kiau2rDKflPm874dgFvAHNRUhQulGVpLYQfdzGj0K2dQ6o3sCu3Mp9z4/
	 Xyn2qjKXgzNRG8Ec0LFLJhcLuU4muKI0r4TY7ABFX4y+lfHIuv+42VXKSUzHdN2dFdOKr
	 Bxly/wfpOlIf1/avl0kaISYXE1rwmtX//yDpSPwzvX7ayqhnzRXW0qYxQjT7ZizZ+CQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794370906;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=NE10uQ5c0/s6ZsijNzdHMpN0Qxg5+9J6dJh89lq+8XM=;
	b=XLXiJZt1agIwZDHAsftq4csxo51SjadB+3OGMewyuJBAdgr/YQ3Nxrz0yODucc/2wZB3
	 4WJ2AYTbJ55jZibyNLwXnx4r15ran9reDGbIhtIKeWMViDGC+qMxuZgKp0Qv5OFw0cevJ
	 qqsopanRtkOGJWp/66C1B588ipbPx94ge47LXTxGNWD3CmTb9QLD5u83994I92cIVnOJ4
	 8LrIdNhcasa+T0WnyJV+3gnDScMmewxJU2415DxK5qSM/y0ym46k3iRDOndSglAxlOE5Y
	 BNGWoUgSHhOEAMGM3xadUtZByzY2+dEBwgN+ka4PfGdNKGss72JuzpsEKpIi/0b5gnQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=VBnIgzyN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.170
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4B2606A31C
	for <linux-can@vger.kernel.org>; Wed, 11 Nov 2026 04:21:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F4B2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=VBnIgzyN
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3acd523a802so22959831fa.2
        for <linux-can@vger.kernel.org>; Tue, 10 Nov 2026 20:21:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794370904; cv=none;
        d=google.com; s=arc-20260327;
        b=gVvdB6NHMC59pUt2fDcKD29r8nEvm4xD07QIEalvyxoNFGMyJS1zGUE/gNVxLERR9B
         ZGJpOiIN8om76qBeHcN17QLRRCGYb/AxHNY2+NIuqbERLU3kxea334fkmp0IBLEfzceQ
         RpgMVrEyhvMX6tMAhEQijNfuEEl7jnXCSgzAnw1Stw18mIMizaSRiYNCQGOjaDTqChnu
         6WtFCBHdpD08Am/POG8g7hNSlhF1R3ePycxOIw2WCJkuPcufNeSpDa8X6AXAY1/PJ95U
         LOMLE3DzXkHMpS8Nxaj3d6N8soqQPhCVPFqrBUdmojMPPkyGy3c26l4zuugnGS9Ymwpa
         9qOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NE10uQ5c0/s6ZsijNzdHMpN0Qxg5+9J6dJh89lq+8XM=;
        fh=XF9tSkK9aYY1aRpFpg3KJRM/H6Rmcy6wUEtOvsDPDMI=;
        b=oqWsSMO99oeim4aVy2UKeArUgQQ0ZZsl3Xr/3JUpON7oTxiwl8lvqFDG2knWrBKr8O
         pgE6oh3F8IeTrGJN9v7CHypUWgnR6r74wjbOPIL00o3S0jZDyRdoygkjoQY73oxbtm0f
         EkxtYoQqU1IJj4GQUKnTMmTrqrHmzBPfprjAxkuwJK182ZPCJG/My4LUFtP94qNFJpqQ
         HyovC1Bq08TVrRXkklIbHDODG6DCTirzbrxMBq3IuZzZ7oygoDQZAxksIun6tXpKZXsU
         PU51x231okTJbl0LTR/ldjNqkYZ+xZnlZ0o0jeOtNx7tw3Stvyjmxym+T6bCQ9oFzDlT
         aLCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1794370904; x=1794975704; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NE10uQ5c0/s6ZsijNzdHMpN0Qxg5+9J6dJh89lq+8XM=;
        b=VBnIgzyN7NE4ZsIAQew5lEW2SDaaTGqVJLG3YSZ5vkQNxBrb0WXN81Nzs+a1+5zvyo
         R8iWuPjRYlZ4rGKZnC2MBLNHMmvW8BYSvhN5wEXpW5XGE4weKxlOgRQJu7XgW+BlOaTf
         MZz8PeU1KsdyS4ttlcug9z7bOI5ie3U66aRHUG43HzxHgMxGvKSLmtC8UX4lRZsW02gS
         qSSJ4wKI/Wcf+AH9bplAQhKE/b67mHNcyn465tct/YLfHEZ8uQBpz45qKzcvT0o0ECqb
         wFv+6GuYf8LK6nYRbpCwmTZv+hRc3U94tVydBZXOeoI5Pp4e9LI7Yz5Ymb25mPTQYjY5
         +h/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794370904; x=1794975704;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NE10uQ5c0/s6ZsijNzdHMpN0Qxg5+9J6dJh89lq+8XM=;
        b=RBJGkfHLyCp+jvMnjY+lfUwh/KTGzc5+O9e2zIhYn/JL7pjiaMSrmZ2eNdU2Na+t0P
         plCg+H5Q5q3+AomYnVrUMm/e5zVmtkNhewXhTKL4RJg2atgfuu+cOJEqNc58hd3BCjTN
         FuCsSsvrXVVv+7PnY9NtvhyAsIBT36+lqIR7G5sMpaqRO6UC0iAZqtR+L7Fyg4d5wMZV
         806ovzooyRWpo61J174yUGmvzgPmjPyPZWKoYUO5Bxvd9hymZJsJDCd7yTjuVG4/ngFx
         R+s+nhOir2eIr7dNfMjjDqlcidNb5YgYo4drmb112jTBf1Ac1+wfAqdFZLicCO3zNecu
         gq/w==
X-Gm-Message-State: APuU4Z+IPVqX2zontcL54el15VDj1ntBMElDUzGbUSjHUM56ulFRPBM/
	Lf/ipfmzTRoUo3xhJt5pE2JN3akzLpDhUi3KRCHM+UD730yUaU94D+VCIwLUJRsaZtGJi31s3O/
	0W2lk3SfWrlcrbVAuT99HHznrZpEWQt4NHZ85UpRHEF/wbq219lr1SvVwKgI=
X-Gm-Gg: AYBFou1De2SO7P+yxyEbpPNSIwJ11+BcGduIXJclN6Y3sCspHPBPiinYqrTm8385Oa5
	5WhNiGDMICx/Huuv6etFni7rwgshefS7P9s2Gl79OG4L0kB1rPQKrSBVxoR/B0HfSrq2clF0Jf+
	wHN7zfaAag2pmdEvy8cheyzIM5jsiOkTsNLCfFc7LGZ1dUHBQc5UnDsaDcYfs7X/zRI/pVTwCrH
	iz7C0M4cN4sA7GjQmE2eUVUcK+JAGjinGSUHO51wvGPTa/wefxSu+k/WbBn7QR/IetYxSP84Ym5
	6Tp9l/p22ACxzFVepDD7mnqDWbRYZQv5wgkSy3UHYAKyNHGvVnmjBLsprm1jJvDA5AU++SlwTMZ
	BVsgovg5rbYmS+KmrFr0YX4qblb7hXYjyIdt+XeaJXCUo0k9i04HG3yWN8tHEbSw+2LOrzY5DaK
	uD0BJtFyGfdrsgL3WA3scvCB2ezN0=
X-Received: by 2002:a05:651c:f1c:b0:3ac:e31b:bb74 with SMTP id
 38308e7fff4ca-3ae1252b89bmr1752401fa.0.1794370904204; Tue, 10 Nov 2026
 20:21:44 -0800 (PST)
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109131624.276943-2-zihanx@nebusec.ai> <179436890073.488853.351945341699455054@kernel.org>
In-Reply-To: <179436890073.488853.351945341699455054@kernel.org>
From: zihan xi <zihanx@nebusec.ai>
Date: Wed, 11 Nov 2026 12:21:33 +0800
X-Gm-Features: AclHuK_NXcsoJ-W3lTi0XNfRaZsnK741ik_t61S0WEdczfW4V3ftuNNzBx4NIqE
Message-ID: <CAANe3eQj9LKnBr7Pek5L8c_rezUWoRGS2tbhUP4T27mbod8zyA@mail.gmail.com>
Subject: Re: [PATCH net v8 1/2] can: j1939: account for timer references
 across rearm
To: netdev-bot+sashiko@kernel.org
Cc: linux-can@vger.kernel.org, robin@protonic.nl, o.rempel@pengutronix.de, 
	kernel@pengutronix.de, socketcan@hartkopp.net, mkl@pengutronix.de, 
	bst@pengutronix.de, lkp@intel.com, maxime.jayat@mobile-devices.fr, 
	ecathinds@gmail.com, vega@nebusec.ai, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 11:48=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wr=
ote:
>
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 2
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] The commit message ("account for timer references across
>   rearm") understates what this stable-tagged patch does.
> - [Low] The commit message names neither the leak trigger nor its impact.
> - [Low] In j1939_simple_txnext(), the J1939_SIMPLE echo timeout is now
>   armed only after a successful send (j1939_send_one at line 1286, then=
=E2=80=A6
>
> --
>
> can: j1939: account for timer references across rearm
>
> This patch makes each j1939 session timer hold one session reference for
> its whole queued and running lifetime, instead of taking one on every
> hrtimer_start(). It adds per-timer locks, shutdown flags and canceler
> counts so that rearming and cancellation are synchronized with terminal
> state changes, and it arms the simple-TX echo timeout only after a
> successful send.
>
> Link: https://bugtracker.nebusec.ai/f/11143
>
> > Rearming a session timer updates the existing hrtimer rather than
> > creating another callback. Taking a session reference for every start
> > can therefore leave references behind when the timer is rearmed.
>
> [Severity: Low]
> Could the commit message name the trigger and the impact here?
>
> Before this patch, the receiver do_cts_eoma branch of
> j1939_xtp_rx_dat_one() calls j1939_tp_schedule_txtimer() without
> cancelling first:
>
>         } else if (do_cts_eoma) {
>                 j1939_tp_set_rxtimeout(session, 1250);
>                 if (!session->transmission)
>                         j1939_tp_schedule_txtimer(session, 0);
>
> The old j1939_tp_schedule_txtimer() called j1939_session_get() and then
> hrtimer_start(). Several TP.DT frames that satisfy pkt.rx >=3D pkt.last c=
an
> be processed before the txtimer softirq runs, for example duplicates of
> the last packet in one NET_RX batch. Each of those calls takes a
> reference, but the single callback drops only one.
>
> The session is then never freed, so j1939_session_destroy() never reaches
> netdev_put() and j1939_priv_put(). The session memory leaks and the CAN
> net_device stays pinned, which can hang unregister_netdevice(). A remote
> CAN node can trigger this.

Agreed. I will add a concise description of the receive-side DAT rearm
trigger and its impact: repeated timer starts can take references that are
not subsequently released, retaining sessions and potentially blocking
device unregistration. The detailed packet sequence and PoC evidence will
remain in the cover letter.
>
> > Track one session reference across each timer's queued and running
> > lifetime. Apply the same accounting to the RX timer and synchronize
> > rearming and cancellation with terminal state changes. Arm the simple-T=
X
> > echo timeout only after a successful send, and keep terminal session
> > transitions from leaving stale timer references or changing the result.
>
> [Severity: Medium]
> Is this description complete for a patch tagged Cc: stable? Besides the
> timer reference accounting, several changes in net/can/j1939/transport.c
> are visible to userspace. "changing the result" only hints at them.
>
> j1939_xtp_rx_abort_one(): a peer abort that arrives in
> J1939_SESSION_WAITING_ABORT no longer overwrites session->err. It also no
> longer calls j1939_sk_send_loop_abort() or queues J1939_ERRQUEUE_RX_ABORT=
:
>
>         } else if (!rxtimer_shutdown &&
>                    session->state =3D=3D J1939_SESSION_WAITING_ABORT) {
>                 ...
>                 deactivate =3D j1939_session_deactivate_locked(session);
>
> Peer aborts are also ignored completely once rxtimer_shutdown is set.
>
> j1939_session_completed(): this now returns early unless the state is
> J1939_SESSION_ACTIVE. An EOMA, or the final BAM TP.DT, that arrives after
> a local abort no longer completes the session. The reassembled data is
> not delivered through j1939_sk_recv() either:
>
>         if (!completed)
>                 return;
>
> j1939_session_cancel(): J1939_ERRQUEUE_RX_ABORT is now queued only when
> the call wins the transition. Before, it was queued on every call:
>
>         if (cancelled && !session->sk)
>                 j1939_sk_errqueue(session, J1939_ERRQUEUE_RX_ABORT);
>
> j1939_tp_schedule_txtimer() and j1939_tp_set_rxtimeout() now silently
> refuse to arm for non-active sessions, or while a cancel is pending.
>
> j1939_tp_rxtimer(): the simple message echo timeout path now calls
> j1939_sk_queue_activate_next(). The old code only called
> j1939_session_deactivate().
>
> Several netdev_alert() messages are now printed only when the caller wins
> the state transition.
>
> The follow-up commit "can: j1939: serialize TX with session shutdown"
> does not describe these changes either.
>
> Could these changes be spelled out in the commit message, or split into
> separate patches? That would let stable backporters see which
> userspace-visible changes are part of the fix.

Agreed. Patch 1 changes more than timer reference accounting: terminal
state transitions now gate RX completion and error reporting, and timer
rearming is refused after shutdown. I will update the commit message to
describe these user-visible behavior changes and explain their relationship
to synchronizing timer lifetime with terminal state. I will also check
whether any of these changes can be separated without leaving an
inconsistent intermediate patch.

>
> > diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> > index 8fcfd13e5e6f8..c327fd9618a0c 100644
> > --- a/net/can/j1939/transport.c
> > +++ b/net/can/j1939/transport.c
>
> [ ... ]
>
> > @@ -1082,12 +1283,12 @@ static int j1939_simple_txnext(struct j1939_ses=
sion *session)
> >
> >       can_skb_set_owner(skb, se_skb->sk);
> >
> > -     j1939_tp_set_rxtimeout(session, J1939_SIMPLE_ECHO_TIMEOUT_MS);
> > -
> > -     ret =3D j1939_send_one(priv, skb);
> > +     ret =3D j1939_send_one(session->priv, skb);
> >       if (ret)
> >               goto out_free;
> >
> > +     j1939_tp_set_rxtimeout(session, J1939_SIMPLE_ECHO_TIMEOUT_MS);
> > +
>
> [Severity: Low]
> Can this leave a J1939_SIMPLE session in J1939_SESSION_ACTIVE with no
> timer armed?
>
> If j1939_send_one() fails with -ENETDOWN, the code jumps to out_free and
> the echo timeout is never armed. j1939_tp_txtimer() then does nothing for
> that error, because it expects a later netdev event to clean up:
>
>         case -ENETDOWN:
>                 /* In this case we should get a netdev_event(), all activ=
e
>                  * sessions will be cleared by j1939_cancel_active_sessio=
n().
>
> That expectation does not hold if the interface was already down before
> the session was created. On the path
> j1939_sk_sendmsg()->j1939_sk_send_loop()->j1939_tp_send(), no function
> checks IFF_UP. j1939_session_activate() checks only the registration
> state:
>
>         } else if (priv->ndev->reg_state !=3D NETREG_REGISTERED) {
>                 ret =3D -ENODEV;
>
> j1939_sk_netdev_event_netdown() leaves ENETDOWN in sk_err. The first
> sendmsg consumes it through sock_error() in sock_alloc_send_skb(). A
> second sendmsg then activates a simple session, and can_send() returns
> -ENETDOWN.
>
> Before this patch, the pre-armed echo timeout fired after
> J1939_SIMPLE_ECHO_TIMEOUT_MS, set session->err =3D -ETIME, and deactivate=
d
> the session. Now the session stays on priv->active_session_list until
> socket close, NETDEV_UNREGISTER or another down event.
>
> The old rxtimer path also left the session at the head of the socket's
> sk_session_queue, because it did not call
> j1939_sk_queue_activate_next(). So the socket queue stall is not new.
>
> The follow-up commit "can: j1939: serialize TX with session shutdown"
> keeps this ordering.
>
> Would it make sense to also arm the echo timeout, or deactivate the
> session, when the send fails with -ENETDOWN?

Agreed; this is a valid edge case. If the interface is already down when
a simple session is created, the send can fail with -ENETDOWN without a
subsequent NETDEV_DOWN event to clean up the session. With the echo timeout
now armed only after a successful send, that session can remain ACTIVE
without a timer. I will fix the -ENETDOWN path so it terminates the session
and advances the socket queue, and add a targeted test for a send on an
already-down interface.

pw-bot: cr
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261109131624.276943-1-zihanx%40nebusec.ai
