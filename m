Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3FF286D5E
	for <linux-can@vger.kernel.org>; Sun, 11 Oct 2026 15:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791732399; cv=none; b=P43VU6e9pzvYb6H63bVc4cRnxELwr5xZ41hblenziWf+V7b9kMBqOJqftqMp9TTnNlBO7Gk773Ks8+X3fDF9+S6i88nLnphvTBlIqFlpGU3n0ra9WRyxkeLTQm68BiCSHrDvobt0j6cteeOlPi0TeuMT51ZXmx9TiMYZw+wNZnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791732399; c=relaxed/simple;
	bh=Rgxi7MtptbHRYd7NOPJxlZcnqigdXfQ0+4BmB7HDoa4=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=YJY4+5WnSM8gnDsFPja365OtiGU1hxsY/FcvNZnxWeqcXsFW7JEY9oBFr0FjFXfDE+W3PWASDSHLtNnEFrCpCG3oOyg7WdcRGGmv2sEc8Tt0lyTiXS8ZYAhhJ7D40ldIFbC5fvX98ngo1Hoj0ygcAXTxl7+urEuZbUPfDkhkNpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EPOpwjQO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EPOpwjQO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B4F91F0089B;
	Sun, 11 Oct 2026 15:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791732397;
	bh=G/vHQiPdQmDHUo/diFHiqrIiGION7r5E773jiVRVETc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EPOpwjQOcSD/sAclaTnS9uZwfxeL99lSx+28R6QBgilqxuC3s5h1g94SMlw5VLIaO
	 UVxhuN0LwtADUXBqnzVJWp5wjZ3ipF+RvuUwklI2bno2kv/+QSqZegd6oX46dSUjWk
	 T17XZIvwbWSCmafZbCPymioz9lU0870xzi4NlF8fwx1AYVEt6+Il1yh4Fit0IQsZNj
	 qOrbdRCnY/4OLI9x1B2/2m9iWV0Sc8RCRfY9Jx61O6+sXHKgt/PG/lkTrdDxU0kUuB
	 VBx25Grhc6V6yiLTAfLUBb4m1KgosrcJvXyYgR2QpHdwmgdqposwQZedJdqbTg6Z/H
	 40+UKUyKAXwUA==
Message-ID: <sashiko-outbox-167300@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] can: j1939: fix potential race condition in BAM
 segmentation
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QWxleGFuZGVyIEjDtmx6bA==?= <alexander.hoelzl@gmx.net>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org, "Vincent
 Mailhol" <mailhol@kernel.org>
In-Reply-To: <20261011151216.118932-1-alexander.hoelzl@gmx.net>
References: <20261011151216.118932-1-alexander.hoelzl@gmx.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 15:26:36 +0000
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] can: j1939: session reference leak in j1939_xtp_rx_rts on spoofe=
d loopback
--

commit b1f46ca54f92cbc040e1810933f35ac82b494289
Author: Alexander H=C3=B6lzl <alexander.hoelzl@gmx.net>

can: j1939: fix potential race condition in BAM segmentation

This patch resolves a race condition in segmented messages using the BAM
protocol by rescheduling the tx timer when the tx ack is received. It ensur=
es
that consecutive data frames aren't sent without delay if they are stuck in=
 the
controller.

> diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> --- a/net/can/j1939/transport.c
> +++ b/net/can/j1939/transport.c

[ ... ]

> @@ -1806,8 +1814,12 @@ static void j1939_xtp_rx_rts(struct j1939_priv *pr=
iv, struct sk_buff *skb,
>  	session->last_cmd =3D cmd;
> =20
>  	if (cmd =3D=3D J1939_TP_CMD_BAM) {
> -		if (!session->transmission)
> +		if (!session->transmission) {
>  			j1939_tp_set_rxtimeout(session, 750);
> +		} else {
> +			j1939_tp_schedule_txtimer(session, J1939_TP_BAM_FRAME_SPACING_MS);
> +			j1939_tp_set_rxtimeout(session, J1939_TP_BAM_ECHO_TIMEOUT_MS);
> +		}

[Severity: Medium]
Does this code leak a struct j1939_session reference if the timer was alrea=
dy
active?

If a BAM RTS transmission fails with -ENOBUFS (e.g., due to the CAN TX queue
being full), j1939_tp_txtimer() schedules session->txtimer to retry.

If a spoofed BAM loopback packet is received from the network during this
window, j1939_xtp_rx_rts() is called with transmitter =3D true.

Because it is the first received RTS for this session (session->last_cmd =
=3D=3D 0),
it bypasses the active session abort check, processes the loopback, and cal=
ls
j1939_tp_schedule_txtimer() directly.

Since hrtimer_start() inside j1939_tp_schedule_txtimer() silently overwrites
the pending retry timer, could this abandon the session reference taken when
the retry timer was originally scheduled?

Should there be a call to j1939_session_txtimer_cancel(session) before
scheduling the new timer, similar to the one added in j1939_xtp_rx_dat_one(=
)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011151216.1189=
32-1-alexander.hoelzl@gmx.net?part=3D1
