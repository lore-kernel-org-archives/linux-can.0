Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793045656;
	b=nGkyWiuaUCgCr8jzEqcwbY7szrroLQGtsQ0goLLRfUW8OJsT1bU6QqwqB9v4GGpDROIw
	 RpbjSCpUV53wbLX1CjILU5QWY9kxj0lryl7vDOCtLVf5rYAe/FYShwEM4XixuOchSIa46
	 PMbvVkst0c7gpB8ZrntRyiCpktGjZx51tJcerFap5hHFeZ+x/QbNI3uOHfVNhrX6S9qhS
	 pNLDjmf7tPuvzr0zw7II9G6r4LBQ9yh5lGO5cVbjZHcvibQ1pfPIDGubpX5sgfDFJYzNU
	 NDwKVNKNMkZkKqfH2G/fu/b4cusXF4d0BDQ+Grv2nqaVNKsTpGIHacSOBtaU/RQdMLw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793045656;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=mo7OWb0vTAkrLxJfq6AdadkFhTqOpVSPlDI1WMfvFp0=;
	b=ENkZPwTCF12PzQfgzP2yIrIMLAb1Fz6KsXK1AOPyXkEyjmvKXsxaKOK63R5UdMq38bku
	 w1otPzVn/e/6V5pDLFu/9hTsNyGm6/8Os0sf6FJqvxTY7msnDLpMV/wgTYkwz5evjWGo7
	 pGKG+rORfCZgFk1npeGIAE418acj88TaiToI+ngAAOwjq5ZgdD5bdb71ALqwNFOAcHbpP
	 8DJ68wasDH8J6mJtq2ad7aGJEJ6ACBT6/7rTSl9f3Ih6eU4RneGJVXZMzaG7DIQuEyJgc
	 fz7yKdEUh2ETBfGu+E+WTNoDPPo6e+BTZMSFk0Y9A3/uPtsnvBdP/mgN4FxWsjF2oEg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=GVm0Xmmf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D67A606A31A;
	Mon, 26 Oct 2026 20:14:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D67A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=GVm0Xmmf
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id EE1D5202292;
	Mon, 26 Oct 2026 21:14:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793045648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mo7OWb0vTAkrLxJfq6AdadkFhTqOpVSPlDI1WMfvFp0=;
	b=GVm0Xmmf1jcolQhG8NMyztFC2thu7NcadWEwPx/q7nfoAWcTF+2qU88rlILKr/2Y+71YNx
	cPc2gOXRaqhffBMG7whiYH/jCqTKuBUKlNKiQmhUqo7YbFNwnWa0NkJ4PiIH4GIU17/fK/
	Rll9HMbGRoAaBv2TBzayQIr0ArUc/A6rkBvStLPpyBzhhsdO/xS+bG1aC2mwytXHGzZEYY
	AFI1rQf8831zr1qZwdzdjBk0NLApQRvViJnfofav8+XwF1RnR0ccjQkBXuqZv2zJyw7jye
	1stT3O6s1Q7ZlghlSJHgoUrtRkW+bIHX3Y3kNxYtm9MS/my06jyyDBQnu+4l/Q==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793045648; a=rsa-sha256;
	cv=none;
	b=FGcY3t5XNNnDmDeHeo4773vmOP3hVzGQImqEUIF2o6/DveiJgnztDkNV3molrJlOuoiS1p
	Z8p7bCk//W9KMbtVmRO00VzG2GVgDU4MK6m1x2edb5prCZ1b1WAU4LFIP/s9mxjs3zdKxu
	kgmvcNVE5SthSarjJ9OfYPWtNXxu99wSEnJ497Q2fyGuEmyOqcUCLTiRK8QMY2CW4jY7A/
	6q0ESN9stL+uKnaWh3NmhhsFbZee7mrOgwCpVilV4fcWs2H91rS9/r23B8//kf+/TPwPjs
	Lm4wDgRonX47TJkX1U0DeH5Qi9hTwotbZlhyMepngN8XDmOXmbiuNUT+gvYqSw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793045648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mo7OWb0vTAkrLxJfq6AdadkFhTqOpVSPlDI1WMfvFp0=;
	b=KP30/GzNXgcJA/Hmyn8tBHDpTdrDa8B0P83uW0LbEWnrKI5gTwx34mGAnc2JldPACcAeS6
	DymO7aiMlHEDVu//qXj1l8yJSZeXNKsGPmRP0MKv27DlJAawZSO+Zu5o4HgNKlq8Il8bFA
	9TEAKeazKI4P8dp2T76QKe43cjVZ2cUjXnIM2I0HovMLkjiu5ed20HyEZ0JDtw0YWD3tki
	Xzt3zTpeHwvLvcgp5msPOzfG43idJrs2MJKjP9wkOx/YtCuddNprB+VHECYndc+I7m4B6u
	qWhGBTymG9+b3XPYPR863FucnTgGCqZNjI0dWNizYx/njYMAKeoADlUKJiTkQQ==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xLR56-001KbB-2n;
	Mon, 26 Oct 2026 21:14:08 +0100
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 936C35D7313;
	Mon, 26 Oct 2026 20:14:08 +0000 (UTC)
Date: Mon, 26 Oct 2026 21:14:08 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
	Wolfgang Grandegger <wg@grandegger.com>, Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] can: softing: Fix locking in softing_card_shutdown()
Message-ID: <20261026-adorable-furry-wildcat-0d5bf2-mkl@pengutronix.de>
References: <192450922df0eb9ce0cebccf381363680db65604.1793044027.git.bvanassche@acm.org>
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
	protocol="application/pgp-signature"; boundary="3s5bhnhdp5et65kd"
Content-Disposition: inline
In-Reply-To: <192450922df0eb9ce0cebccf381363680db65604.1793044027.git.bvanassche@acm.org>


--3s5bhnhdp5et65kd
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: softing: Fix locking in softing_card_shutdown()
MIME-Version: 1.0

Hello Bart,

thanks for you contribution.

On 26.10.2026 12:47:07, Bart Van Assche wrote:
> If mutex_lock_interruptible() fails, softing_card_shutdown() goes on
> without holding card->fw.lock and later unlocks that mutex anyway.
> Shutting down cannot fail, so use mutex_lock() instead. This makes
> sure the firmware state is always changed with fw.lock held and that
> only a held mutex is unlocked.
>
> Fixes: 03fd3cf5a179 ("can: add driver for Softing card")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Are you actively using this driver? It's scheduled for removal in the
v7.15.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--3s5bhnhdp5et65kd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCat+0jQAKCRDMOmT6rpmt
0oGhAQDeVNRVtO4S17yIk/I7fCX/mzpENiyH4c2iIiY+91PnLAD9H/qrY8B5CMlP
7zef8MYqUh/nUDSkABkk8eB8/VxrWAo=
=IyuS
-----END PGP SIGNATURE-----

--3s5bhnhdp5et65kd--
