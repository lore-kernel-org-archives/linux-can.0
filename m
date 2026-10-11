Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514222DC357
	for <linux-can@vger.kernel.org>; Sun, 11 Oct 2026 15:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791733733; cv=none; b=WSUsTuF3432AMWyYXh4W/y+7n+ROxkKn1mNAXk5DLgXbbld9wvxLaCuaALnW0OchjnGvrMJiZf5zHtGbOEMi2tYyvK5Ni50wt0epqLXWNAaUQnq8DD4jQQBxyMM01psuRX9pKUGswTxt/8m4QbxZ3ElSXgIC37NOY0bWCTwxF/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791733733; c=relaxed/simple;
	bh=sOPP9Wxidyg3foQRQX5C3Lma0ddWtYWCUhWFkbS1JvU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=WXPyVpaPy69hVvEjO1hEBFWDSu8uTAH57v93aNmJzJEBgBMfUtEwtKaTAG8sl1LCa/JoTrEVVugmcfgdGmRui1kUUnfUnlFoGZzYrjOMneoJyMvudhe9Nq97bA80kigHOdq8t2klwdzcZH2D+Xk8FhJWezZaLI4oUjNcdkmYUzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MprsKj1Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MprsKj1Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CF4F1F0089C;
	Sun, 11 Oct 2026 15:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791733731;
	bh=/HpscMh78lKGWRAvUKRF+WtOHL8AdDYwZzCCQEY/oqs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MprsKj1ZJCVZOulH1Jd9WvyMdquSwMxE7lua/5yMSrmR1V1zaDPFxtXPCqS5qSAuX
	 8jhn5ybOuKmT3OPCJycM5M0EIaZNmCFDWswxP75Pp4I0iKSkuPFvgNSnarwvuOhjpY
	 TnJz0PaR/U6U3Q6S0kIOwGaxNsjeVME/m4KOyh6TRacw9qU30fKXgDsjIp7/oO+JGV
	 kkoeO9BJRnUlI2b4Fjh91QTlKlhekoK12TtMANOOcapYtf0/hBACKaZedbazsunHAS
	 7NzNW9GwtKLNbkYdBJgudek7GHS23q8NUVl43gWJNkkEBqd/Il3nMpTIH4EEPJ3T/e
	 oE1PsnoseXC8g==
Message-ID: <sashiko-outbox-167306@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] can: j1939: fix potential race condition in BAM
 segmentation
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QWxleGFuZGVyIEjDtmx6bA==?= <alexander.hoelzl@gmx.net>
Cc: linux-can@vger.kernel.org, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20261011153119.120302-1-alexander.hoelzl@gmx.net>
References: <20261011153119.120302-1-alexander.hoelzl@gmx.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 15:48:51 +0000
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] can: j1939: session reference leak on concurrent txtimer scheduling
--

commit 8433158f9fc2fee1a98accad978bba5e01cfc621
Author: Alexander H=C3=B6lzl <alexander.hoelzl@gmx.net>

can: j1939: fix potential race condition in BAM segmentation

This patch addresses a race condition in segmented BAM messages by moving
the tx timer scheduling such that it is scheduled when the tx ack is
received. This aims to prevent session stalls when a BAM frame is stuck and
fixes the behavior for consecutive data frames.

> diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> index 8fcfd13e5e6f8..c61a021880c01 100644
> --- a/net/can/j1939/transport.c
> +++ b/net/can/j1939/transport.c
[ ... ]
> @@ -1961,6 +1974,12 @@ static void j1939_xtp_rx_dat_one(struct j1939_sess=
ion *session,
>  	} else if (remain) {
>  		if (!session->transmission)
>  			j1939_tp_set_rxtimeout(session, 750);
> +		else if (j1939_cb_is_broadcast(&session->skcb)) {
> +			/* cancel the txtimer to avoid leaking session references */
> +			j1939_session_txtimer_cancel(session);
> +			j1939_tp_schedule_txtimer(session, J1939_TP_BAM_FRAME_SPACING_MS);
> +			j1939_tp_set_rxtimeout(session, J1939_TP_BAM_ECHO_TIMEOUT_MS);
> +		}
>  	} else if (do_cts_eoma) {
>  		j1939_tp_set_rxtimeout(session, 1250);
>  		if (!session->transmission)
>  			j1939_tp_schedule_txtimer(session, 0);

[Severity: High]
Does this do_cts_eoma path leak session references when multiple packets are
processed rapidly?

When a receiver session processes data packets in j1939_xtp_rx_dat_one(), it
evaluates do_cts_eoma =3D true if pkt.rx >=3D pkt.last. Because pkt.last is
initialized to 0 and never updated for receiver sessions, this condition is
true for every data packet.

Consequently, j1939_tp_schedule_txtimer(session, 0) is called for every
packet without first cancelling any pending timer.

Since j1939_tp_schedule_txtimer() unconditionally calls
j1939_session_get(session) before starting the timer, calling it multiple
times before the timer fires (e.g. in a NAPI batch) will re-arm the timer
and leak the extra references, as the timer callback only drops a single
reference.

Should this path also call j1939_session_txtimer_cancel(session) first,
similar to the new block added above for remain?

>  	} else {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011153119.1203=
02-1-alexander.hoelzl@gmx.net?part=3D1
