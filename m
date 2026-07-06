Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742C82EBDDE
	for <linux-can@vger.kernel.org>; Mon,  6 Jul 2026 22:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783378706; cv=none; b=uvkxd07Ir2dLODzaTfxNMxvil/JYgGkjkZLKBr+WUM1XotaYKY0hos84AtEBXUYLW3Z2h8QlrS2whRpV3dr7k3gfL+ypcGC5J1rKQwM7KBKqpfyU46c8hwc8LCg1Zn8x6pU7A15IOWrsPZY51Vl0GsVa/51PXWEBEH2FVOV1NSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783378706; c=relaxed/simple;
	bh=PBFw+QpPUgs3r+cNCqDkxyp6h0a1Elth6TcS2KHj9W0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Bxgs7pSRjb1v0aKA8d2QinxT0rw6oHxvCLKqdQZP2phYKYk7SEIVgsnKeQRgeTwsnVIkhHFQSHsUO9GA84E8w0CoAr/YgHUtzs9LFVBuNwHpousnq/1LBm3VCimMQtcQ3Wch7GAR/4/OfL7zAb6aplN4WLJaFhOl/QHO8eyE6QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJRnNPgG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJRnNPgG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED6EB1F000E9;
	Mon,  6 Jul 2026 22:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783378705;
	bh=Do1L/oX4PFzY5m0KboU5zR7bxQrf3M4nCqc8hU7OTEo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YJRnNPgG+3sgmHzZcg2CbR/s6T2RdVDagCUcLQo0hPmEwjKPOBaqt8ZqhRSB8vumn
	 BLoD4iPxmuj8GfZAzfCRd+2XPEgzLdtkY1issIDKURs8j5Rfe7TYJjwZ4Kp/7e96Dq
	 gJ00qtV80xe6JbmTli8eJPM7TT/4vw+5QJ+UxOc0geZlvFzZLQCUYAd0hw9lnTE/5x
	 2+2/zVJUO602PXpHIGYbo5+YAWqqQZxIvc1L15/F02jSVfm93iel1KuOdOprLzPqv+
	 7M2YH5fkVmx90Z2ZMaNl5c4aNOvHW8eY3idFUzTPhHgMRQzoFuXOOoxO4IFcHDzVmY
	 iLFdEP/yK3H7Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/3] j1939: restrict amount of consecutive
 retransmission requests
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QWxleGFuZGVyIEjDtmx6bA==?= <alexander.hoelzl@gmx.net>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org
In-Reply-To: <20260706224548.100451-1-alexander.hoelzl@gmx.net>
References: <20260706224548.100451-1-alexander.hoelzl@gmx.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 22:58:24 +0000
Message-Id: <20260706225824.ED6EB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Flawed retransmit tracking logic causes both spurious connection a=
borts and counter resets.
- [High] CTS hold messages bypass the retransmit limit, enabling indefinite=
 connection persistence (DoS).
--

--- Patch [1]: [PATCH v4 1/3] j1939: restrict amount of consecutive retrans=
mission requests ---
commit e2e0a35fca4d64ebcdd174aa2094ae405f7ecced
Author: Alexander H=C3=B6lzl <alexander.hoelzl@gmx.net>

j1939: restrict amount of consecutive retransmission requests

This commit introduces a retransmit counter and aborts the segmented
data transfer if the retransmit limit is reached.

> diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
> index 81f58924b4acd..16867d8030922 100644
> --- a/net/can/j1939/j1939-priv.h
> +++ b/net/can/j1939/j1939-priv.h
[ ... ]
> @@ -285,6 +285,8 @@ struct j1939_session {
>  		unsigned int block;
>  		/* dpo - ETP.CM_DPO, Data Packet Offset */
>  		unsigned int dpo;
> +		/* retransmits - amount of received retransmit requests (including hol=
ds) */
> +		unsigned int retransmits;

[Severity: High]
If this counter is intended to include holds, will they actually be counted?

Looking at j1939_xtp_rx_cts_one() in transport.c, if j1939_cts_is_hold(skb)
is true, the function sets the hold timeout and returns early:

	if (j1939_cts_is_hold(skb)) {
		...
		j1939_tp_set_rxtimeout(session, J1939_CTS_HOLD_TIMEOUT_MS);
		return;
	}

Because this early return bypasses the new retransmits tracking logic,
could a peer keep a session open indefinitely by continuously sending
CTS hold messages?

>  	} pkt;
>  	struct hrtimer txtimer, rxtimer;
>  };
> diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> index df93d57907da7..6f999b18bbca5 100644
> --- a/net/can/j1939/transport.c
> +++ b/net/can/j1939/transport.c
[ ... ]
> @@ -1457,6 +1465,19 @@ j1939_xtp_rx_cts_one(struct j1939_session *session=
, struct sk_buff *skb)
>  	else if (dat[1] > session->pkt.block /* 0xff for etp */)
>  		goto out_session_cancel;
> =20
> +	/* If the 'next packet number to be sent' in the CTS is smaller or
> +	 * equal to an already sent packet it is a retransmit request.
> +	 */
> +	if (session->pkt.tx >=3D pkt) {
> +		session->pkt.retransmits++;

[Severity: High]
Does this logic reliably track retransmits, given that session->pkt.tx
is updated asynchronously by txtimer?

If a peer drops a packet and requests the next one (forward progress),
but txtimer has already sent past that requested packet number, wouldn't
session->pkt.tx >=3D pkt evaluate to true? This seems like it could
spuriously increment the counter and abort valid transfers over lossy links.

Conversely, if a peer sends a duplicate CTS request before txtimer has sent
the newly requested packet, session->pkt.tx would still be pkt - 1. Wouldn't
that evaluate to false and cause the else block to reset the retransmits
counter to 0?

> +		if (session->pkt.retransmits >=3D J1939_CTS_MAX_NUM_TRANSMITS) {
> +			err =3D J1939_XTP_ABORT_FAULT;
> +			goto out_session_cancel;
> +		}
> +	} else {
> +		session->pkt.retransmits =3D 0;
> +	}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706224548.1004=
51-1-alexander.hoelzl@gmx.net?part=3D1
