Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793009337;
	b=lHy5Tk/0I156Z6+XTMFODnqYt8psUAd6rX6TJr0ZJ9E5PBx/RRfd7OnlAVKtXld0f/NH
	 gYy2mogzXOxhJVmkz8VFcBBCY5bCvikX2J1AA4A70iUYuWOYq9RpECsb5TwU2aNaQ+4OI
	 c5YJ0UqRsOFB4Ms+FczyPxZVLtwzwVBqlCb7og6HRK7rewfhItYQWBnNsl63gAFDtATLL
	 TXJT9sJCAX+eOVDQajOepcItFhHCs/Q/UdmKuXXMhmnIJs4htRc5Nboxv68hLQE5ooHC8
	 M/LU/o2p+JqfKX3D4fyhpsKepqCAK+R16NAtD/eZjB9CQPJHBNv8w3B3/Am46RTKAKg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793009337;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=/QZdhr66rkg+mddDeLt6NyEXCB5Cy/OAiGhHQtmLsDk=;
	b=SkgqDQB+GEE6NPf8TwdonF5emQ/C4suO4QB3ihkwH4YFJLBbQmTDraWBx6i3zkEwbZdO
	 byLNXIo3xIJ7SSzmuof1jIdZT11GtYBOYANuprOoJrX9cWaPUEHcSJv4d5+ts8a39NhXp
	 GgaClV195aUc8RIP2d8Z+o0xK7xfSANvYGBbBySaKKp1zA+oq0oajrvtVKTsYMd1PS1WF
	 TiEKMbQh4sKVg0a9CrES5kLAEsxeJWSeRd24/uhX0gKVc0fiyPeRUvxFHhU7GW0WAkXd9
	 cvBKntz7lAM1zV6Xzj4oOKOVFZirg8zBhoek3H6sEO89vaYdiblBoLrOGHYpxKssW9Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=arK9O3ZB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.178
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C7B606A31A
	for <linux-can@vger.kernel.org>; Mon, 26 Oct 2026 10:08:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4C7B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=arK9O3ZB
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3ab01c46697so22865621fa.1
        for <linux-can@vger.kernel.org>; Mon, 26 Oct 2026 03:08:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793009335; cv=none;
        d=google.com; s=arc-20260327;
        b=GaaNobcWP/7I7+t7x51Fu6KXyiGfUT5stLEYnZ8d8Qxd1n0tSq6cBhkZr9IuS3K2HZ
         kOuEx7zgHbylNO4XQarP+RxWoh7BUTUEhr1vl1HVHUGG3OcEplpbnYmrnFAL0LO1wnWd
         QnZz05IMqw5LI2OP4n/BZ7qXwjWnKLv9yoI+H83HE/kCiipFcgyuHkFGZwFFPIluqYDx
         iEh3ic61g+CgtEPIxkbedN6jmkdFFnpcGXntqvOvAmHc0vk8k6dvgEhmXbAevrySgziQ
         zM7IcB9Ty1Tbxo3fX/o4Nfhkw+zD9XHes3Z9ktz7JYHVSSHWobXfb7m15QSIZPZhjHyf
         JkdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/QZdhr66rkg+mddDeLt6NyEXCB5Cy/OAiGhHQtmLsDk=;
        fh=HVarKeFQVkAgQqACwzu8b4+ZmAMpZm66382NKgqKHC8=;
        b=iQ8hPXGLgtMQ9qRdfTk0jbgNe65u9hdlMX1m01V922E2U/XMH7PwoGPGptl4OhFjwK
         xHTCLLCnv5LfNRoA32gcyAmtBoqrjoA97uY2gAC8VDFU2NFM6PCSwwbw8/Hm2zCLgEwL
         JlqI2tU33xxioeL/XS2dx2ilZ4D9VdAQOUuQBz9/KVwEL7fS9vIEiOkIcnRguj2Gr9T0
         Fg1D6O1WXhsr6KvpgVshVsfGa5jq9sj4WAV5JkVrxeIMldZzQihR/M53wCQFEUibMdsm
         jmA3pPI9AWZw0qrOXbfhBG1mAqSEdm9gyqwvXw7C2cR4QhmQS55SJYOxywQePrePh3nP
         XBwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1793009335; x=1793614135; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/QZdhr66rkg+mddDeLt6NyEXCB5Cy/OAiGhHQtmLsDk=;
        b=arK9O3ZBOTIYcE0z6LK4aq76vYG73spf4XJ8LAFE7xgtgsDtoPU26tbVWkQ5/1yxxg
         jPo/FVytupdyNzMpZPVuUw1R2odaON4oBj3byDrZV45KW+51Ejw5zvZ9jl6JQxl4uisd
         cx/XlqykGpQp6FWcq9/g4S93UfQ63Gm/jewo72TN3lYjRrw4PT8+yn5j3YaoUvIQuTBy
         Z4qyLeoT0wkRfNYxtjj4p8zlUBE9x3K9D1DU/wrH8ACNYFR5hBCshdjTibYMiXRxWI/B
         Nfi6cit6fSUHKN0O3blzvLpZHjG+QYQQb9Gf0IwlUWXXjbLsZIsXLG4ljcFCs6JJYioO
         achw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793009335; x=1793614135;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/QZdhr66rkg+mddDeLt6NyEXCB5Cy/OAiGhHQtmLsDk=;
        b=UPUtVcm3ySA09UGeC0pwS6v8gbx/8y6ySXjmkfElQGIcmOWL2wp5xCXF1SDrCK58Lh
         7CaPF9nYR4IbrhLsPA60tsc0vsngg8ca/OwkhbYNv55F9DF9FKbp01LLFragI16VLNgs
         Jw3KtwJHcfZLKRD1EY/CIR+abzXOx4NoZeS89/Gar+vGbBSzf4OV3Goeh8Fzj19/33pW
         +1P40ZztDkKYQZ9J57AcGz4ys9ZtZ3S1JnJ2lHa1LwGsLjzDPyUpovZy8jdMb2KxoUg4
         8SifId321QCseH/pwjIK5yF0Z9N+S+8CuPmZkq1P4F5qtaLBPRReAuGQVZCm4DerZ6Oo
         zG0Q==
X-Gm-Message-State: AFq9FYKtnASjotntFrHnajWHMx+Zf4mIu0LRTotbMcza/DThQ7b199gX
	zNLYI1xnJRWsvEe3UJBmWtQI9gYFXtzu19/bYlQJRnT6XgMW4gs1rN0L9BUOGq48YkgGg4Q61Al
	TvymJ2h1eX44c2Yt/fCDE9cUNaPZ8GbA3RkMm6wsFFbg=
X-Gm-Gg: AYBFou2oDgK7Lp0T5PQNxUI9MZt8fa9enw9y7YcPD2oqppuPE7T3e+VigPLZnwYSb++
	bgS4y1qX5xFA0oz+qncv40Zt95Se28uUhRbR4xVybQtzCVTpMRKq0o2Y2J2DkKFGasEQ4wFQo6h
	zHkKLHiqwnc5RuyBJlf7mO4XWcbxVb/NeZRfLc7IE0Kv5e3DKevBS4o3sYsLemr9dXjD7XQouZi
	1EYh9l3fBq9EqKSDOG3tqc2EzOPt+nRRtyVS6LJaZkCucrICF4m45NNMA6jmOrgziNcPezOEm8F
	RtsaOwaSQuR5Y60awgNOGdX2HHJbK36EeqiATniqb95lMLVBfH4DtlJAhJ7Yq1KHwOHpVdcw0ZJ
	mcJjPMtd1eSrZVWG4szeQD03zvl+QVVRy509kpCD+Qmr1kXxUeTSdW7ENTPNU7SSaVCw=
X-Received: by 2002:a05:651c:3241:b0:3ac:4b79:5726 with SMTP id
 38308e7fff4ca-3ac6fd12765mr14926811fa.17.1793009334372; Mon, 26 Oct 2026
 03:08:54 -0700 (PDT)
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
 <20261026-smiling-aloof-perch-f8368d-mkl@pengutronix.de>
In-Reply-To: <20261026-smiling-aloof-perch-f8368d-mkl@pengutronix.de>
From: zihan xi <zihanx@nebusec.ai>
Date: Mon, 26 Oct 2026 18:08:43 +0800
X-Gm-Features: AclHuK-lPh2T9hyqmS8mG1538Vk1qJu5bd3Q4TtDU0IGu0qFawsJM5oPkfZiC5c
Message-ID: <CAANe3eTr=DnaPm_vc8NELW0jAH714AJjFStszPSPnQUi374tYA@mail.gmail.com>
Subject: Re: [PATCH 1/1] can: j1939: fix session reference leak on TX timer restart
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, robin@protonic.nl, o.rempel@pengutronix.de, 
	kernel@pengutronix.de, socketcan@hartkopp.net, lkp@intel.com, 
	ecathinds@gmail.com, dev.kurt@vandijck-laurijssen.be, vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 3:45=E2=80=AFPM Marc Kleine-Budde <mkl@pengutronix.=
de> wrote:
>
> On 26.10.2026 07:02:48, Zihan Xi wrote:
> > The TX timer holds a session reference while it is queued. Restarting a=
n
> > active timer only changes its expiry, so taking another reference for e=
ach
> > restart can leak sessions.
> >
> > Serialize TX timer rearming and reuse the queued timer reference. Take =
a
> > new reference when no queued timer owns one, including if a callback is
> > running.
> >
> > Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
> >
>
> Drop the newline after the Fixes: tag.

I=E2=80=99ll remove the blank line after the Fixes: tag.
>
> > Cc: stable@vger.kernel.org
> > Reported-by: Vega <vega@nebusec.ai>
> > Link: https://bugtracker.nebusec.ai/f/11143
> > Assisted-by: LLM
>
> Please remove the Assisted-by: tag, it's obsolete. Instead, please state
> in your cover letter that LLM were used to create the patch. See commit
> 1e035297ffda ("docs: remove Assisted-by references") for details.
>

I=E2=80=99ll remove the Assisted-by tag and mention LLM use in the cover le=
tter.

> > Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
> > ---
>
> What about the txtimer in transport.c?
>
> | net/can/j1939/transport.c:306:31: warning: passing pointer to variable =
'txtimer' requires holding spinlock '&j1939_session::txtimer_lock' [-Wthrea=
d-safety-pointer]
> |   306 |         if (hrtimer_cancel(&session->txtimer))
> |       |                                      ^
> | net/can/j1939/transport.c:1552:26: warning: passing pointer to variable=
 'txtimer' requires holding spinlock '&j1939_session::txtimer_lock' [-Wthre=
ad-safety-pointer]
> |  1552 |         hrtimer_setup(&session->txtimer, j1939_tp_txtimer, CLOC=
K_MONOTONIC, HRTIMER_MODE_REL_SOFT);
> |       |                                 ^
> | net/can/j1939/transport.c:2254:40: warning: passing pointer to variable=
 'txtimer' requires holding spinlock '&j1939_session::txtimer_lock' [-Wthre=
ad-safety-pointer]
> |  2254 |                         if (hrtimer_try_to_cancel(&session->txt=
imer) =3D=3D 1)
> |       |                                                             ^
>

I=E2=80=99ll annotate txtimer and address all reported accesses, including =
the
cancellation paths, without holding the lock while waiting for a
callback.
>
> >  net/can/j1939/j1939-priv.h |  3 +++
> >  net/can/j1939/transport.c  | 11 ++++++++++-
> >  2 files changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
> > index cf26352d1d8c..6c46dec73bbb 100644
> > --- a/net/can/j1939/j1939-priv.h
> > +++ b/net/can/j1939/j1939-priv.h
> > @@ -10,6 +10,7 @@
> >  #define _J1939_PRIV_H_
> >
> >  #include <linux/can/j1939.h>
> > +#include <linux/spinlock.h>
> >  #include <net/sock.h>
> >
> >  /* Timeout to receive the abort signal over loop back. In case CAN
> > @@ -290,6 +291,8 @@ struct j1939_session {
> >               unsigned int dpo;
> >       } pkt;
> >       struct hrtimer txtimer, rxtimer;
>
> Add __guarded_by to the txtimer:
>
> | struct hrtimer txtimer __guarded_by(&txtimer_lock);
>
> and switch on context analysis for j1939:
>
> --- a/net/can/j1939/Makefile
> +++ b/net/can/j1939/Makefile
> @@ -1,5 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>
> +CONTEXT_ANALYSIS :=3D y
> +
>  obj-$(CONFIG_CAN_J1939) +=3D can-j1939.o
>
>  can-j1939-objs :=3D \
>
> ...and compile with clang-23. See
> Documentation/dev-tools/context-analysis.rst for more details.
>
> regards,
> Marc
>

I=E2=80=99ll enable context analysis for J1939 and validate the result with=
 clang-23.
> --
> Pengutronix e.K.                 | Marc Kleine-Budde          |
> Embedded Linux                   | https://www.pengutronix.de |
> Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |
