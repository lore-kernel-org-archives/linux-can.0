Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794335764;
	b=tHB5c8EJvTUnVipRgOXArm6wx/rqVofp+JthnporEt0q5nEmi0xIKqxOQzi3SI5ZI5nD
	 FAPDX7xYaQUF/sWFHd+454MxbqssBYcWzg3SyDQtVujxhLNWig+53vmsv95a7UiNphWA8
	 6RXGjRhtv0bm4k9Nq10Drq7mAcLUvU2YTYknE2wa3JqzBh07eplpZcovUYsTlVajWUPne
	 b5OAlp+8Tfj5WT8aN7+rOjbayDPwHFZbdVqiS99LpXLCvtprcK6kYnQa0E474FTK2+joq
	 jXVrnYSKazJmLWIOk3zlvye4cKGDWxu2fY5J+4HEcDv14dt1V0O7rX3RxGw2legTPpQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794335764;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=BOafJ6cmPXqPWNzGZO/JyPEtr5lk4E3EUztVodxn4Wo=;
	b=g1h1DQYdfwOdAQK1eK3eH17Z5b3uUp5zmkQL0ohiz1tXZzDCDShDphIOVmLaRwRd7I7Y
	 p2WhvpFM1+m0hXg5SdbcKmOnNTb8F57T121QQqG7JszONmDnX9I+XXVjwZaI3zNE1C0w8
	 d/wkoo91VTau6yPjVu5HgrfXgas9IF4Mpi0MrZLntxpt92STmbPA9B+tqeoGDsMXXvq4a
	 /JQayWVGK64qKVboRMUxB1yRmc+80XiMghur7KimPnlNI+aTzdbIW7sgF1g92WTxGaBIx
	 f99LFGMV6XwBLFHVH07Jl7qfzLKK6aAQt85Tv4DCExP1VTTD8wWnwmom4roUBo/F0SA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=OkWepP8Z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C02606A320
	for <linux-can@vger.kernel.org>; Tue, 10 Nov 2026 18:36:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79C02606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=OkWepP8Z
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 445ED2000EB;
	Tue, 10 Nov 2026 19:35:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794335756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BOafJ6cmPXqPWNzGZO/JyPEtr5lk4E3EUztVodxn4Wo=;
	b=OkWepP8ZLCu6RBbm744WXYrC1bsbDR086eDEyIw5ZvyLjWn9XxuF7rqOvIxuuCRh7GAYJT
	ihmlk1VjLWsZ7xBwAAYvVrFFe7xkT+p883hZeoCv8Fm41BTpZD2dzrx69Y4fttiUwNldsM
	Q3V+ILjyUn+RcEi3TvceBr3uBUMGGDjpIsHqIcO8UUm8ZBotkiZ4UUDXyC5xuwGJR3Spm3
	+THZIZiiib4mH1rak8/P5mhd/Tt5diPkhyPgjOTmosRJN1mYRQd5rPndZZbcQw6jOROVJz
	h5x+JmYVrZEdHlxedDCNwbGX7Flg35ZiC4GjOLruIIQr68xFeVRDGSBl6Q3rIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794335756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BOafJ6cmPXqPWNzGZO/JyPEtr5lk4E3EUztVodxn4Wo=;
	b=dU5eqD6kgI8bBKPJ0460p4vrH1Dc8Tfk0UezJGkL7XdFWh9pb/gt/flLbzRv8znq0RyEJW
	74xp3G0cOa+frWR2ZVA+6SdHDqWzeCyn+FAytQTXYaxdnfiHMx9/x3ptYFZ6eJyhXy+N63
	7Ny/gwG7jaQ5ceGe8/zobzDvmewEidZ1M7ykew5/ZgbidVnxkJMGTs7xn0Trx1KhTQWi+s
	vtIcRin1X5I4M5uftWkIRAOHiKlcENKMbF9mTDXgAsQht87KEqs8DfbU+pQhuLiN+Pnexp
	K7cIM65j1a22DtkqG7xAUs8Xe5KrNDC0R6UQc4jtaldzuue9JOC3JfipfQZkXw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794335756; a=rsa-sha256;
	cv=none;
	b=g9o6qEEb4SpvWZ+vBjPN5TXvWQTRIT9t0sPhdsYegqZk8DNCYo671TDsE29K3cHRWVid+F
	BTcNOY+vZUbI0NN3d0YrfA3xGCdE3B8qVleqL6FnEKhm4iNVcYw0eXQYT0ZW7dvH7fbzti
	v8/M68rgg5ccdknPKZHG/PjF36dAtokkAerQxgwgVn+3PGehfGshKL54jlfpsu6w7YzSte
	bAz9Rkd8/bI45v47cF4ff/RhNb/Jyvm3GF6T7SqDURyNHKpWDZq+I/UykCe6helXLgr7/T
	CX+aCJ2IHkP/V4bNlZFMdBkBiwuFHPwCpeLPPn3gftkekH28YCX6Qr9AaLW9sg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xQqhI-003XOr-0X;
	Tue, 10 Nov 2026 19:35:56 +0100
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id BF1515E7024;
	Tue, 10 Nov 2026 18:35:55 +0000 (UTC)
Date: Tue, 10 Nov 2026 19:35:55 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: khj <hj351016@gmail.com>
Cc: sashiko-reviews@lists.linux.dev, linux-can@vger.kernel.org, 
	Oliver Hartkopp <socketcan@hartkopp.net>, Vincent Mailhol <mailhol@kernel.org>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, =?utf-8?B?U3TDqXBoYW5l?= Grosjean <s.grosjean@peak-system.fr>
Subject: Re: [PATCH v2] can: peak_usb: pcan_usb: shut down restart timer on
 free to avoid use-after-free
Message-ID: <20261110-imperious-daft-mamba-51f539-mkl@pengutronix.de>
References: <20261109044911.1163505-1-hj351016@gmail.com>
 <sashiko-outbox-206243@kernel.org>
 <CAGr5VtNkwbhJSg9sFi=Lk67y9SA6ofQnpuBFa2NrKy8=mUecmQ@mail.gmail.com>
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k3mqnqapcsr4shmp"
Content-Disposition: inline
In-Reply-To: <CAGr5VtNkwbhJSg9sFi=Lk67y9SA6ofQnpuBFa2NrKy8=mUecmQ@mail.gmail.com>


--k3mqnqapcsr4shmp
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] can: peak_usb: pcan_usb: shut down restart timer on
 free to avoid use-after-free
MIME-Version: 1.0

On 10.11.2026 14:04:08, khj wrote:
> You're right that timer_shutdown_sync() alone is not sufficient. The
> restart URB submitted in pcan_usb_restart() is not anchored, so
> peak_usb_unlink_all_urbs() does not kill it, and its completion handler
> pcan_usb_restart_pending() can still run after free_candev() and
> dereference the freed pcan_usb via mod_timer(&pdev->restart_timer, ...).
> Shutting the timer down does not help once the object backing it is gone.
>
> So the complete fix has to stop that URB as well, not just the timer --
> e.g. anchor the restart URB so peak_usb_unlink_all_urbs() kills it, and
> also cover the probe-error paths you point out (dev_free() being skipped
> on a pcan_usb_get_serial() failure, and running before unregister_candev()
> on a dev_set_bus() failure, with the restart URB potentially still in
> flight because probe failure does not unlink it).
>
> Since that becomes a teardown reorganization in your driver, I'd rather
> not guess at the shape. Marc, how would you prefer this handled -- anchor
> the restart URB into one of the existing anchors (tx_submitted) or a
> dedicated one, and should the register_candev()-before-dev_init() ordering
> be part of the same change? I'm happy to send a v3 once the preferred
> direction is clear.

Please discuss driver design with St=C3=A9phane Grosjean (Cc'ed). Your
patch/series should probably based on
https://lore.kernel.org/all/20261103-canfd_check_channel_idx-v8-0-4e8b2c0a8=
806@peak-system.fr/

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--k3mqnqapcsr4shmp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCavNkCAAKCRDMOmT6rpmt
0v5qAP9dZCRKh8c1Ic5oIGHHDK96Bvwbpym6r8fP1YMMZGDtowEAqIT1rKmdKs6v
bEjLePxeTi3kJ4XwvhyWD5ga84tKdQY=
=QXpk
-----END PGP SIGNATURE-----

--k3mqnqapcsr4shmp--
