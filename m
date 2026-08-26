Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E6723D7F4
	for <linux-can@vger.kernel.org>; Wed, 26 Aug 2026 14:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787754759; cv=none; b=d+mTZH5bydwqalm8ubsvgNS3TiUordTKYgMEXwIyaXxtVWZ0ml7y6X5PsMuZi2KO27Bvx8j27Z1B2RdKzUQ/HgxNBMn6t3CnIL/SH2Ys5m9zvAZNmU6bcvDFeFVpkmRsnoadz0x23jDrwguZP7tFUWNrhoU94TJZ6eYYn6FHD4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787754759; c=relaxed/simple;
	bh=Mw7YCz0hpx1At2zDoXw2ztRYW10by2pdeRLiZawNAFE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UMal2T6x1wmMMp0GJAJKP2DFzviHcp64PxxS2BUiswUeJ8wrtpv9oGNvHy5OAArpB3wXQhm2PiwRvpqenaOPB1XWR+CBKdEMwaDhlHLnww7oIupWK3egKQDPFgJmq4ohm9V0RgBDsAiyxO3IN3Nmg0balrfMvUhBd3UQB1oU/HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oIKQXw+H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oIKQXw+H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C6561F000E9;
	Wed, 26 Aug 2026 14:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787754757;
	bh=Q9Xf92o9phXX6I0I9WRuHUVV0GjBQ0gceRjcBPNtd0M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oIKQXw+H7+TuUzY0YIVWIB2PewUkTgZ8HQ/TDq2Xd2s3VcWhNNpD/IAv2WF+EfyAP
	 sRb47H79BKXl9ThtJ72EmD4wFAOje8kp4cl5mdpA0HdV5ZxZhnFc7e7DQnYLlRu5wp
	 TFeXCvYfNYxfy9ZH+G1jejkthhzAePbNypUowAjd3YpRN6fuOwYRWF7+CMz8tXpkrK
	 SEKDXUJPMNy8k/M9TdFMPSmmbd0hrbnYCf7myIr5xMuwAmfOpz2qnmXIAk/GYzRoSk
	 AW/ydEbRPCoYHzoSdcL1+GLhEm/f9Eti3h9HcdhAg+Cvmisu29y6NJ6ftcxYu5u3ra
	 I5Tt/LRGP1TVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] can: j1939: j1939_sk_bind(): fix j1939_ecu leak when
 re-bind failed
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tetsuo Handa" <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, "Marc Kleine-Budde" <mkl@pengutronix.de>, linux-can@vger.kernel.org, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>
In-Reply-To: <45b82053-7f32-43fc-b37b-067058a72c98@I-love.SAKURA.ne.jp>
References: <8063b5c1-6171-4350-a7d1-6ccd079fb0ff@I-love.SAKURA.ne.jp>
 <20260826-zealous-wandering-giraffe-3fb7ce-mkl@pengutronix.de>
 <45b82053-7f32-43fc-b37b-067058a72c98@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 14:32:36 +0000
Message-Id: <20260826143237.4C6561F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] `__j1939_ecu_release()` removes an ECU from the `priv->ecus` l=
ist without holding `priv->lock`, which leads to concurrent list corruption=
 if the last reference is dropped outside the lock.
--

commit d72a1d2e096554fd47b18d74b1390d647b9e0f01
Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

can: j1939: j1939_sk_bind(): fix j1939_ecu leak when re-bind failed

This commit fixes a refcount leak in struct j1939_ecu when a re-bind
operation fails. It defers the removal and release of old ECU references
until after new resources are successfully acquired.

Closes: https://syzkaller.appspot.com/bug?extid=3De2af46126e0644cbebdd

> diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
> index 50a598ef5fd4a..24efb25c58c3f 100644
> --- a/net/can/j1939/socket.c
> +++ b/net/can/j1939/socket.c
[ ... ]
> @@ -519,22 +517,31 @@ static int j1939_sk_bind(struct socket *sock, struc=
t sockaddr_unsized *uaddr, in
>  		jsk->priv =3D priv;
>  	}
> =20
> +	/* get new references without dropping old references */
> +	ret =3D j1939_local_ecu_get(priv, addr->can_addr.j1939.name, addr->can_=
addr.j1939.addr);
[ ... ]
> +	/* drop old references after re-bind() succeeded */
> +	if (was_bound) {
> +		j1939_jsk_del(priv, jsk);
> +		j1939_local_ecu_put(priv, jsk->addr.src_name, jsk->addr.sa);

[Severity: Critical]
This is a pre-existing issue, but does dropping the ECU reference here expo=
se
a race condition with incoming address claim packets?

If this j1939_local_ecu_put() drops the primary reference to the ECU while
holding priv->lock, could a concurrent j1939_ac_recv() processing an address
claim packet drop the final reference without holding the lock?

Looking at j1939_ac_recv() in net/can/j1939/address-claim.c, it temporarily
gets an ECU and then drops it locklessly:

net/can/j1939/address-claim.c:j1939_ac_recv() {
    ...
    ecu =3D j1939_ecu_get_by_addr(priv, sa);
    ...
    j1939_ecu_put(ecu);
}

If the lockless j1939_ecu_put() in j1939_ac_recv() drops the final reference
to 0, it invokes __j1939_ecu_release(), which performs list deletion:

net/can/j1939/bus.c:__j1939_ecu_release() {
    ...
    list_del(&ecu->list);
    ...
}

Since this list_del() executes entirely outside of priv->lock, can this lead
to concurrent modifications to the priv->ecus doubly-linked list and cause
memory corruption?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/45b82053-7f32-43fc-=
b37b-067058a72c98@I-love.SAKURA.ne.jp?part=3D1
