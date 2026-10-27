Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793110505;
	b=vtyqoCxPA3i4xdtLx0kzH4ohGQp8yftUeb1dBIHiGWfygXSS8fHLX62rDp0M60NdyNgX
	 6yugFCPLzZ4c9mBWkJlkm+X1GTE3ZMYL/2BxZREhHlEu6yIQ7Hyqc+0Ou0FQ4Zr/4i+3N
	 e41TmM4fv0OzE9FPTDCgHlsW5LqPaet5JsygPvuEeB4KPxke/CVGRYCNK57QpOjoFxbPt
	 twL0y4xHZAWXh/U962aQlUcTKd+hy695mPFU2llkUydv6gte8MXFFKaMPFGWzo1wIszkm
	 DqaYL2NyuezSDieCFfKvHigHVu0TvzSSmCUh/lDqfeEfoUPDRy5gPu0YcCWyju3bAaA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793110505;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=AZGHU/6bpP0vuZyDpKTJ9Lt9KjTQ5UVsrPd845cBFGE=;
	b=szTMZmjLDFcy1T+YOOsrKk/mKFNaMJaxDHeYkD2lwOt6/n9Hc6ER/tyTxhWvO6QG4YAf
	 UW+5HSQwWnktHPdX0xa9bj/5FQjtVjw1Y1IK7Tvk8ndi/g5P+f6S/5blUWpG2bETwV3MP
	 qaqcBK/wotlCYUgOxVjPQMC//LqOOlrXzRf9JXpQNUN4aGasilGN5nFd0Z5aHbDdriRZS
	 gI6tt3/7/VfGI15FB75+TaZgJb9OsXLd0vWxjvtcGEDM4Ho2McgF0lf4pqqnYVfdw6Xwa
	 acS311gcDIQx5rsOpNCrBUflotFUBnV6TD7qEo5Wqa4QAsFHj5HDxvgTWcxxfFqes3Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=ufSHUJE5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.175
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E59606A31D
	for <linux-can@vger.kernel.org>; Tue, 27 Oct 2026 14:15:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86E59606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=ufSHUJE5
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3ab01c46697so35850761fa.1
        for <linux-can@vger.kernel.org>; Tue, 27 Oct 2026 07:15:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793110503; cv=none;
        d=google.com; s=arc-20260327;
        b=YW7oYt3+bBZyGUeD/Xg7SKAJKH6islJoDXbRoNYvWZgz47Lo7t7FNnozAoQkBAYnb8
         Cv9L+gNejowvm2BnnBZciR5phAn0U2FEd1LynxWn90XhYwp9QY1jeSs3Weg4FVWcQRVt
         LJEudmDZpNUn7ZPGeWppldMCCFroo/IKEoV+g93XokZpHGYHEGvID0FlsCFe+Q0k+l55
         /ial3NIh2n1sakCs4qNaMg5UlMB6SFTziRV8Hnkp7sxBYqI9Du7gA/gQyA88MN47VnEq
         T44lslEVHWdLyUq0ks8VdqKKyFb4kXsd2rUIerB5S9wcDUUOQgcOlM56IAnQXo+iJLXz
         qdnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AZGHU/6bpP0vuZyDpKTJ9Lt9KjTQ5UVsrPd845cBFGE=;
        fh=UDmiFjDUsl58/oI1pbxKLXmAuoEiB7qNSJQzd9c7Gr0=;
        b=rTPMcH1xhN7bELaUG0kVCvxc+L4ZF5SAfaYz+SXanF+VMEyLNUa28N+8sJJPoRQA0d
         BXSPnNjwKKo9W6lr5AdBTiMT3xBjVol5rj85U2tqNIUnF8wEPOqiLjj294zLIyRC1SxM
         bAZL5fo0IVyDY3zBG1X5FCCc2ipgYEMHS+GYtGy23Djv0W4n4rc7mtbJaR5y9tba+AAv
         xz4ugX8b7UCKN785vUapgm+6/xoabaUyWx03mpgxBIwI1EJg+cFl+89mQGJ8IBYdjims
         hkFCjes0lmBdtuIAE0Rt/cKoJzs+vPN78dtp5aasbwwoRfaf6NZr3ZaTaNblfgwNd21l
         y9Cw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1793110503; x=1793715303; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AZGHU/6bpP0vuZyDpKTJ9Lt9KjTQ5UVsrPd845cBFGE=;
        b=ufSHUJE5OsCNqkdwCxEfo4MeoQMDsEaJNY2cJaFnuTNX/zYQ83WZKR/DYjmpNisUvG
         BNnM1dNMtrP41EvG02JGpv4ubqAePEHkTB+ABc87m5etZArji74UYs8r7uIaqNMykjTH
         31ch2ovp8EZSnDROEmnzk7JwqXznliv41tq0NumehuXQfTPcSuznDqzh1pbL4FJpKaNW
         gK01ZA5KVGTjYv1uhGmPtpv8TzNVltYEBSm5AT7wlzZetcbW84RUbOH2nyqs4VunETDL
         a9T+O+3wLnQgKXLqIEN92yduzSVlNpEdK3Ut6zMgnwuBT4zZa6CJRWS7rBR6Tp/qiUgQ
         lbng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793110503; x=1793715303;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AZGHU/6bpP0vuZyDpKTJ9Lt9KjTQ5UVsrPd845cBFGE=;
        b=zKDLiHAnhcWIGphqX+hdC3jvslZJJXYfphzumWAVKQhiVw3gyAte5d6oKZZHG6pjp0
         Wj4HIlVt/GWFmhe38DpcPaFXXB+nPONpkKoiPVAFHiyZ4kiv56iZoQ9cqe1wiWHFo9uS
         sHFsxY7iZfp6zHqWWyRO7Z2t1Jfs5xBAE2breKvQXLafveoq+JGITo4mcacFbgJAZXxu
         sEaL9UbMH79h5f9su3vdIBWgp0y6z1tK2ESb56lFZDnRfmkdRdac1z6tjiRAXZ1B3IhL
         d5oExCsTTdMPIeRwOx7pGwb6/yA6MtRqMjRbcF5nZeCQ8kZ0b/939Fv3K5uiYPMTcoPR
         fXXw==
X-Gm-Message-State: AFq9FYI95edqwZtbQwtTiSatmB9wsH+aUlFDat3C9hl0X+mpASiS869c
	qZ+/uvdrsifI6UMX8Eq2GY12wB7ezvPS3F5E7xQ444qVjVCkX9YCoVpNTM/s3RZREDprC4n2tAV
	BM3Dms+AQY5QOfAcrvFHs9mq/taoFpbGLzDcKSDnu5HkL95sfx9gYSFYECv5emg==
X-Gm-Gg: AYBFou0ukzfJaCdA+ZlCLLSW0TBwu7MkFUrJ0HOh08AZuEAbIHggPE26y3ofUrOnt9m
	pqQruzWldnJNiGpifzAtXLb3ExeITf1Kpxz8HCgG6xJ8Qm4ep1zsQ2afNeUgGSf57Qse83PEKLY
	HKzzC9LhvUpCUK4x1rrYg2feugLxZ38zIwx1kz94A3nr+QGz224AZzr+F0DqwIL+eRSTVlGRPSv
	GeOyy9dWr7rpeuvUjkizhsTVurASAmAvMjMgfbM4xqJ1wej+Xi/a8XkDGIpknTExcTlk5n05U05
	sC1GA9/P5USWlZCo3diwVSVr0q7+u9svQF4VWezqW9G6JNK/oIS7hV8KBm11SOnBZeIu6a7BIb9
	fjm6WXgsbFV79HmFQUGZowrSjhDA8TinDtD/2bKYKrDYLtxdl6ATr3ZvBW2ZV+97Z0a2FPduJBc
	Mrd9YVenxtx6x4
X-Received: by 2002:a05:651c:b25:b0:3a9:c1de:852a with SMTP id
 38308e7fff4ca-3ac6fafe0a7mr25748871fa.3.1793110502525; Tue, 27 Oct 2026
 07:15:02 -0700 (PDT)
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1793012287.git.zihanx@nebusec.ai> <c07c904f7c5d36e2ddd2ecaa2e76c4b210b0647e.1793012287.git.zihanx@nebusec.ai>
 <sashiko-outbox-186622@kernel.org>
In-Reply-To: <sashiko-outbox-186622@kernel.org>
From: zihan xi <zihanx@nebusec.ai>
Date: Tue, 27 Oct 2026 22:14:49 +0800
X-Gm-Features: AclHuK8P_9OMXyNTOJ-KaZNHVXeDDVcjNmemnXcTLb8nRzI6OSqDc8HWCTIKBH4
Message-ID: <CAANe3eRL=QL9tmzEjcOwhsct_kaoSCC=4-wcZsy8xbPxzTo6KQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] can: j1939: fix session reference leak on TX timer restart
To: sashiko-reviews@lists.linux.dev
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Oliver Hartkopp <socketcan@hartkopp.net>, Vincent Mailhol <mailhol@kernel.org>, 
	Oleksij Rempel <o.rempel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 9:28=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 3 potential issu=
e(s) to consider:
> - [High] can: j1939: rxtimer race and leak in j1939_cancel_active_session=
()
> - [High] can: j1939: lock inversion calling hrtimer_cancel() under txtime=
r_lock
> - [Low] can: j1939: missing lock annotations in j1939_session_list_lock()
> --
>
> commit f04ccae0c143b4770bcd167c770232649c770e32
> Author: Zihan Xi <zihanx@nebusec.ai>
>
> can: j1939: fix session reference leak on TX timer restart
>
> This commit fixes a session reference leak when rearming an active TX hrt=
imer
> by serializing TX timer starts and cancellations under a per-session spin=
lock
> and reusing the existing timer reference. It also defers scheduling a new=
ly
> activated session until after dropping sk_session_queue_lock.
>
> Link: https://bugtracker.nebusec.ai/f/11143
> Link: https://lore.kernel.org/all/cover.1792979091.git.zihanx@nebusec.ai/
>
> > diff --git a/net/can/j1939/Makefile b/net/can/j1939/Makefile
> > index 19181bdae1736..113595c257309 100644
> > --- a/net/can/j1939/Makefile
> > +++ b/net/can/j1939/Makefile
> > @@ -1,5 +1,7 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >
> > +CONTEXT_ANALYSIS :=3D y
>
> [Severity: Low]
> Enabling CONTEXT_ANALYSIS :=3D y in net/can/j1939/Makefile opts all files=
 in
> this directory into Clang's thread-safety analysis when
> CONFIG_WARN_CONTEXT_ANALYSIS=3Dy is enabled.
>
> In net/can/j1939/transport.c, j1939_session_list_lock() and
> j1939_session_list_unlock() wrap spin_lock_bh() and spin_unlock_bh() with=
out
> context lock annotations:
>
> static inline void j1939_session_list_lock(struct j1939_priv *priv)
> {
>         spin_lock_bh(&priv->active_session_list_lock);
> }
>
> static inline void j1939_session_list_unlock(struct j1939_priv *priv)
> {
>         spin_unlock_bh(&priv->active_session_list_lock);
> }
>
> Because spin_lock_bh() and spin_unlock_bh() carry __acquires() and
> __releases() annotations, won't Clang emit -Wthread-safety-analysis warni=
ngs
> (failing the build under CONFIG_WERROR=3Dy) unless j1939_session_list_loc=
k()
> and j1939_session_list_unlock() are annotated with
> __acquires(&priv->active_session_list_lock) and
> __releases(&priv->active_session_list_lock)?

Thanks for pointing this out. I=E2=80=99ll add the acquire/release annotati=
ons
to the session-list lock wrappers and validate the J1939 context-analysis
build with clang-23.
>
> [ ... ]
>
> > diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> > index 8fcfd13e5e6f8..4a2e986023d89 100644
> > --- a/net/can/j1939/transport.c
> > +++ b/net/can/j1939/transport.c
> > @@ -9,6 +9,7 @@
> >  //                         Oleksij Rempel <kernel@pengutronix.de>
> >
> >  #include <linux/can/skb.h>
> > +#include <linux/cleanup.h>
> >  #include <net/can.h>
> >
> >  #include "j1939-priv.h"
> > @@ -303,7 +304,13 @@ void j1939_session_put(struct j1939_session *sessi=
on)
> >
> >  static void j1939_session_txtimer_cancel(struct j1939_session *session=
)
> >  {
> > -     if (hrtimer_cancel(&session->txtimer))
> > +     int ret;
> > +
> > +     spin_lock_bh(&session->txtimer_lock);
> > +     ret =3D hrtimer_cancel(&session->txtimer);
> > +     spin_unlock_bh(&session->txtimer_lock);
> > +
> > +     if (ret)
> >               j1939_session_put(session);
> >  }
>
> [Severity: High]
> Can calling hrtimer_cancel() while holding session->txtimer_lock here (an=
d in
> j1939_tp_schedule_txtimer()) cause a lock ordering inversion with the hrt=
imer
> softirq expiry lock?
>
> Because session->txtimer and session->rxtimer use HRTIMER_MODE_REL_SOFT,
> hrtimer_cancel() -> hrtimer_cancel_wait_running() acquires
> cpu_base->softirq_expiry_lock when waiting for a running callback,
> establishing the lock order:
>
>   session->txtimer_lock -> cpu_base->softirq_expiry_lock
>
> In the reverse direction, when j1939_tp_txtimer() or j1939_tp_rxtimer() r=
uns
> in softirq context under hrtimer_run_softirq() (which holds
> cpu_base->softirq_expiry_lock), it can call:
>
>   j1939_sk_queue_activate_next()
>     -> j1939_tp_schedule_txtimer(next, txtimer_delay)
>       -> spin_lock_bh(&next->txtimer_lock)
>
> This establishes the reverse lock order:
>
>   cpu_base->softirq_expiry_lock -> session->txtimer_lock
>
> Since all session->txtimer_lock instances share the same lockdep class, w=
on't
> this trigger a lockdep circular locking dependency splat and risk deadloc=
king
> on CONFIG_PREEMPT_RT when a softirq timer callback tries to acquire
> next->txtimer_lock while another thread holds next->txtimer_lock waiting =
in
> hrtimer_cancel()?

This is valid. I=E2=80=99ll redesign the timer synchronization and referenc=
e
handoff so that no path waits for a callback while holding txtimer_lock.

>
> [ ... ]
>
> > @@ -2234,24 +2273,37 @@ void j1939_simple_recv(struct j1939_priv *priv,=
 struct sk_buff *skb)
> >
> >  int j1939_cancel_active_session(struct j1939_priv *priv, struct sock *=
sk)
> >  {
> > -     struct j1939_session *session, *saved;
> > +     struct j1939_session *session, *iter;
> >
> >       netdev_dbg(priv->ndev, "%s, sk: %p\n", __func__, sk);
> > -     j1939_session_list_lock(priv);
> > -     list_for_each_entry_safe(session, saved,
> > -                              &priv->active_session_list,
> > -                              active_session_list_entry) {
> > -             if (!sk || sk =3D=3D session->sk) {
> > -                     if (hrtimer_try_to_cancel(&session->txtimer) =3D=
=3D 1)
> > -                             j1939_session_put(session);
> > +     for (;;) {
> > +             session =3D NULL;
> > +             j1939_session_list_lock(priv);
> > +             list_for_each_entry(iter, &priv->active_session_list,
> > +                                 active_session_list_entry) {
> > +                     if (sk && sk !=3D iter->sk)
> > +                             continue;
> > +
> > +                     /* Keep the session alive while cancellation wait=
s for the
> > +                      * TX timer callback outside active_session_list_=
lock.
> > +                      */
> > +                     session =3D iter;
> > +                     j1939_session_get(session);
> > +                     WRITE_ONCE(session->txtimer_shutdown, true);
> >                       if (hrtimer_try_to_cancel(&session->rxtimer) =3D=
=3D 1)
> >                               j1939_session_put(session);
> > -
> >                       session->err =3D ESHUTDOWN;
> >                       j1939_session_deactivate_locked(session);
> > +                     break;
> >               }
> > +             j1939_session_list_unlock(priv);
> > +
> > +             if (!session)
> > +                     break;
> > +
> > +             j1939_session_txtimer_cancel(session);
> > +             j1939_session_put(session);
> >       }
> > -     j1939_session_list_unlock(priv);
> >       return NOTIFY_DONE;
> >  }
>
> [Severity: High]
> In j1939_cancel_active_session(), can session->rxtimer remain armed after
> j1939_session_txtimer_cancel() finishes, delaying or leaking the session,
> socket, and net_device references and clobbering session->err?
>
> While holding priv->active_session_list_lock, j1939_cancel_active_session=
()
> calls hrtimer_try_to_cancel(&session->rxtimer), sets session->err =3D ESH=
UTDOWN,
> and deactivates the session before dropping the lock and calling
> j1939_session_txtimer_cancel(session).
>
> If j1939_tp_txtimer() is concurrently running on another CPU (or starts b=
efore
> j1939_session_txtimer_cancel() cancels it, or rearms itself because the
> txtimer_shutdown check in j1939_tp_txtimer() is not serialized by
> session->txtimer_lock), it executes j1939_simple_txnext(),
> j1939_xtp_txnext_transmiter(), or j1939_xtp_txnext_receiver(). Those path=
s
> call j1939_tp_set_rxtimeout(), which takes a new reference via
> j1939_session_get(session) and starts session->rxtimer after
> hrtimer_try_to_cancel(&session->rxtimer) has already run. For example,
> j1939_simple_txnext() arms session->rxtimer for J1939_SIMPLE_ECHO_TIMEOUT=
_MS
> (10s) before calling j1939_send_one(), and on -ENETDOWN, j1939_tp_txtimer=
()
> leaves rxtimer armed expecting j1939_cancel_active_session() to clean it =
up.
>
> In addition, if j1939_tp_rxtimer() is currently running and has re-armed
> session->rxtimer, hrtimer_try_to_cancel(&session->rxtimer) returns -1 and=
 does
> not cancel the newly queued timer or drop its session reference.
>
> Because j1939_session_deactivate_locked() has already removed the session=
 from
> priv->active_session_list, subsequent iterations of the loop will not see=
 it
> again. Should session->rxtimer be synchronously cancelled via
> j1939_session_rxtimer_cancel(session) after j1939_session_txtimer_cancel(=
),
> similar to j1939_session_timers_cancel()?

This is valid. The TX callback can rearm the RX timer after the current
try-to-cancel, and an in-flight RX callback can overwrite the shutdown
error. I=E2=80=99ll synchronize RX timer cancellation after draining the TX
callback and ensure the shutdown error is preserved.
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793012287.=
git.zihanx@nebusec.ai?part=3D1
