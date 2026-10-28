Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793220697;
	b=3tzl07CFlrXrZpwdbNwx0L1F3ChaWaxQlNnOICbOG2Qv+a4q271BMM1mJrxPQLkr+TMn
	 BGnjqVXZk//e2rneUWf8vGSAl6i3ac/n8ZeLSN1YUjtFnIZE7MUUjNVbm2sjZp9NFen4p
	 AVwtIIzb+A8Nb8r9ijpDfPr+OMeued6uIU3Q73jKAa01y4ttiDVbS0l98M3Th/lHbalfb
	 15kjLR5tPKyRMbGLNNph2Q1E6tEMxxUUZ48uf9KC5wWcwFY5RcBQPNbT4l9n4b/O+cA0E
	 6Z/rOzbGLc/GefFfgDL2+4T493/eg4x58xI9EZBzveIGl3evkW3tcsM15cmVzjwAsKA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793220697;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=JQwb9ctZnkH9xouQ9GoF7QHdoIRdNtwo37B2zpMKa7U=;
	b=e6+oFtxIRLKMwQXqR6Adh4qYnYyhmAZvs5EWQiIQMY9LZYvZ/vdkph1CiJYtJaYBXiA2
	 CtP4f6PUusq/UqdqSIH7gZTwwUoqTQ9pGkO5IuyVVhQYK5vfyCEtssptXuBytq+HqNmJ6
	 2/5f2K6wvwIECzwuKosWhzyENt2lTECy2kmioCEZGTMFWRqcxt2VHCXAkDN6+ZJTv7wZW
	 ln6mV+Wa7fB3Mc7yZpPSkjULZSh4jgMilGudGRu98lYAqq5wKmtY0jFx0I29XEz4rAgiX
	 6J0qNQjHqP6M9uYN6dmoKKqpakaAG5gtJN0hTVXJcxlj1xLfpnm4UnbhaQu9W8oZIaQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=AnfGSoBg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD94C606A31A
	for <linux-can@vger.kernel.org>; Wed, 28 Oct 2026 20:51:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD94C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=AnfGSoBg
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id A99AB201FF2;
	Wed, 28 Oct 2026 21:51:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793220689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JQwb9ctZnkH9xouQ9GoF7QHdoIRdNtwo37B2zpMKa7U=;
	b=AnfGSoBg59H/JtjrhHEHuxgfSeYsE8EAsEsGt4VBPGZQfAmXwr9R7DbyTFe1/Pplk1KnO9
	IFyaZASuK8vxEiLeluYkwabMtuAwi0aUW3tSQWuEikpnCcjvT1GWkG2FYznQEYr1akwtpd
	KGffpfUkfU8RdY5A1bfoIeoYIXe0KFtvWgnW0F/jMUk7JoQjYcBVTG/Lfp3aXQkM62wTVc
	uF4RE0qzmhIkuWUVWVUo7eZOagBeZhp58fp90NoDU3U6YZ2PfUrz8/8OO92Hb/LWJjGHPD
	gX/KqSCDuwS3ndgNJSCb1jKP8woin5V6UnaNT/OWt7gzIqVAEYkCHLbfcu5R6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793220689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JQwb9ctZnkH9xouQ9GoF7QHdoIRdNtwo37B2zpMKa7U=;
	b=T0bvIo+LtIC5qIUdbin2KVg+h+zo2RGsZjGq9CkWfRNJPzHiZMd9R54QhSp0SXKzMFRnT6
	YJiD4gESyExLdA3mm7CxoUiV+he5D4knCv0/IN2nnWUQB5wITGmQqz7uKdsvialpLekGe8
	8cylb/ZqzSATEUQ7DIOGXIncXfCd3KLgsOV6PwQ+3wh2+RpJuqvI6YIepwJsazxzXJ2DGG
	0iS8ZWF3YJN2g9jH30t12oJw+bAPlej3B7QIN1MGkvDUgoS5q8u6bixlSfWVptcHHhYiYD
	PChVHrAcWafPuibII6UH2jnq8TOTWJpSFD+3a70lWvS8LhtFgOBhvgl4K6uhQw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793220689; a=rsa-sha256;
	cv=none;
	b=f5rnmvtoWuotgLaMKVV8lhH1DhaUlXMhwjWjo4UCOUS1JFTDBB3ogenshPBd2xhzxfwm2q
	Jgp1GDiTzse1FrXRrA0aFv9W03EkyDjTG9KRLn4FguHbuRB/ww7vSDXvaS+yqMRypJsltb
	q4D+usM7O4aU885BSmOsCxCQaTc4ZJEPMPgBtVsUgQe8RRz3ZYti7Zd3yj37wtruCwukxI
	V1lkO2UBfJJ07E2P6PL8YWe/fpB1MXa2mPlxunn5jvqBfTuwmkQ+hf6aCgX8/0VB7snR/6
	ARDO9jw57dnRQc8h6k1NwZ4ilEpy/+YEBDiMbQ4/8T81D2pw3HPf6mANutrt7w==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xMAcL-001crY-1q;
	Wed, 28 Oct 2026 21:51:29 +0100
Received: from pengutronix.de (unknown [213.208.157.249])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id DB2755D93F9;
	Wed, 28 Oct 2026 20:51:26 +0000 (UTC)
Date: Wed, 28 Oct 2026 21:51:24 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>, 
	Norbert Szetei <norbert@doyensec.com>, Runyu Xiao <runyu.xiao@seu.edu.cn>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v12 0/7] can: protect the receive lists with a per-device
 lock
Message-ID: <20261028-miniature-smiling-leech-6d02ea-mkl@pengutronix.de>
References: <20261027-can-rx-lock-v12-0-eb5afc2d8b9b@hartkopp.net>
 <1e9a2768-e30e-4f2d-bc71-57550d210c0a@hartkopp.net>
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
	protocol="application/pgp-signature"; boundary="k2lbbuf7gcdgkud3"
Content-Disposition: inline
In-Reply-To: <1e9a2768-e30e-4f2d-bc71-57550d210c0a@hartkopp.net>


--k2lbbuf7gcdgkud3
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v12 0/7] can: protect the receive lists with a per-device
 lock
MIME-Version: 1.0

On 28.10.2026 17:36:26, Oliver Hartkopp wrote:
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261027-can-rx-lock-=
v12-0-eb5afc2d8b9b%40hartkopp.net

Seems clashiko doesn't post to the mailing list any more? Did the bot
reply only to you?

> The remaining Sashiko findings on v12 are either issues that are fixed by
> later patches of this series (as Sashiko notes itself o_O) or pre-existing
> issues that are not related to this series:
>
> - CAN_BCM and CAN_J1939 also copy user space data under lock_sock(),
>   while their netdev notifiers take lock_sock() under RTNL. This is not
>   a new problem introduced by this series. I will look into this later.
>   It does not affect this patch set.
>
> - The user_reset in net/can/proc.c is denoted as not network namespace
>   aware. This is on my list for a separate can-next patch too.
>
> The only new finding is that isotp_bind() keeps so->rxid/so->txid after
> a failed bind(), which is visible via getsockname(). This is intended:
> As so->ifindex is reset to 0, there is no interface and therefore no
> valid address. The remaining CAN IDs only show that a bind() has been
> attempted and failed. No need to reset these values.

IMHO a failing syscall should not leave any half set option. You're
rolling back so->ifindex, why not roll back rxid and txid, too?

> Sashikos suggestion to
> assign so->rxid/so->txid only on the success path would cause a new race =
at
> start-up when a FirstFrame is received during the bind() process - which =
is
> currently solved and working.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--k2lbbuf7gcdgkud3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCauJgRAAKCRDMOmT6rpmt
0u3zAQCqXKEQIv6Y5G4DO+LsitdnA2f5wJ85Xb5eJP9MnPEWcwD/S0T0W/dbUayF
0Mia6krii7M9xVkgcB53d3GJT1RTRAE=
=rruh
-----END PGP SIGNATURE-----

--k2lbbuf7gcdgkud3--
