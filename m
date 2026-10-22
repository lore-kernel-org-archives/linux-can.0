Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792672895;
	b=aggEXpdSgwp4/PxoyRyPr2qpdGbGXnIUS1Kwu+rFb1shGoWd2jcNecLx4t9C9yHn4Qj6
	 SbSYFlJXQPTqhpo7z6m+BGOrppLHVwr5ztPnOHqC2vhcF5PSeFNXUUfInf72Elt4ui4bl
	 ThmR5mlY9o62inbvv3JvK8v3FXER/TH3ptx8lVNK7D3W4h5s5N0EyjCPK9QNC7aUo9meM
	 VcVJBZRCa1rbc4DEdpq0ZjBNzquKYzBzvYil7OVVdsDxm4WZQrly9QQpFv1TKMcUtMq9R
	 UZKOmhyaqX1Q5hCbT3iowvfQPDHFjOHqoDpHNFnv0dDwjwJM6LX50CaKxjBe5LbfN9A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792672895;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=A2+dp2zkYoXzciDDCmS52+BBtcBhvPkmwUgZHfvAXvs=;
	b=eGFWMiJHah+8i+qIxJT/n1YeYbwBkwHVmtmL6/cEC3wSnq+oFVr3pqKRoRs4HNDfK2ML
	 WT+5k2YHtrqLA/OG7EUh1fwr4VoGRP5X96Q/rXnLH7YXkYzNXjKA4mC+81fqZKdty7Vtn
	 c8Rec6Qn3+AuQG1flK01golybNqKxda8RY6HvoTHh8noMXSTJH3ITCOBTjrLMECVVYnKt
	 h6twaWSxMNO6JMlBG4Glce4Aq3Zrkh9iwKZOx1YaTVxeBSOLG2oHhqh99i7n1Af4i4bM5
	 8NyDmQrHkXyjXY2bH5OPTR61Z+QJgp8mLZ9sIGBNRU90vtokCGjknQg7jdRTfdjCN5Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=YJDZpVpI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B057E606A319;
	Thu, 22 Oct 2026 12:41:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B057E606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=YJDZpVpI
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id DC8B92009B1;
	Thu, 22 Oct 2026 14:41:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792672891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A2+dp2zkYoXzciDDCmS52+BBtcBhvPkmwUgZHfvAXvs=;
	b=YJDZpVpIePgnc8rdAsxAXGZ9CihqydGZ9x4ZV0fgs/kpUrSbSxQorTQoevDOtCotSdHbmr
	CXxtzwo6Z5DyYPFeTFnenc7Z5z9J2guNF2Eym/QhBsRq1VuvyuYzYdeFXuQIrLT5w1ydEi
	niu6oti3Vnii2+r6IfPOu9y1ZdYbLUMpKu4uf/4+XpJBUGuIpa1/aqggBA4HRHNtfzJKZR
	zHfnJv3ufP5sz45lizC02+VG8meMXuVHJQzR0qNI1cSZNBPBmgjchRlhANmb4My1egAqiP
	pEDfJSl6bDn/Jsw/Fb3uedJnwpLU3EbRqPev+YLflRhuTCP8Es6aGIQxNtFxjA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792672891; a=rsa-sha256;
	cv=none;
	b=Tq6/UYICModPxkJiZaY4wbGmazMeA4GVAvA7+q7QhMrd+d8+/99nD10hTeHnyKAoTbPG7X
	M/eW0PfdPZq5bqc8GmIR/FaYU8jRBiMd+mRJoFmKQ4+geh2t0lSOALm5zMu9fW9vSvTrCi
	6spW5wR7XmNKEf0xsl3HtK/5r0tIF3meqx6MKj83YUwDNAsQjLLB5Cz0HwTZpTIKi0EN0v
	m9fAqEK5BDOtaz9yCjWC/Nz8BmkPCKP8yTS7SmNFvtThBCBtfyd9+nAfuWPnCH6JJf1Z2P
	C8h1+PUIxhZjZPYVg3hZu6duhUxgvK2B7qWRqajlP6z6a011tj6p0vM7c4HurQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792672891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A2+dp2zkYoXzciDDCmS52+BBtcBhvPkmwUgZHfvAXvs=;
	b=PQNHcoEHJfZ7DxB1zhUvRByrSdXBP+IR9eUSSvwL6Z7oMWdTiQ8O/PLoXixWi5pUnzTZUf
	f/8oAjuW9qCqyAxokWHZl0blqFL77Wh61c1JNin2tSPSlfcfE0191E306QgrvqYBO6AFMj
	kkMZ9rMKfTO7Fk47ZVOoMYw+AiHXMkFipi8BLszo1gTCOolS/GC+aeGiorxhl88IUJ7d2U
	2XljY/kyHP9XHMZsNgVVau29egXm8Ua82glkz2n+9OR6pJ/C3vRyFgfWzN9rUFYG2dU8hX
	HLkHfcez+y+0ncz8+X5Z9kG/hFq4B0obDygvCd4dMzGrLI9cA6ZZiITr55uuwA==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xJs6t-000hzp-2b;
	Thu, 22 Oct 2026 14:41:31 +0200
Received: from pengutronix.de (unknown [IPv6:2a0a:edc0:0:701:46a6:1197:ccb4:99ca])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 622705D0E8C;
	Thu, 22 Oct 2026 12:41:31 +0000 (UTC)
Date: Thu, 22 Oct 2026 14:41:31 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org, 
	kernel@pengutronix.de
Subject: Re: [PATCH net-next 0/11] pull-request: can-next 2026-10-22
Message-ID: <20261022-unique-famous-dachshund-f51d3d-mkl@pengutronix.de>
References: <20261021231130.2085690-1-mkl@pengutronix.de>
 <eb3b2eee-3460-4b03-a180-1d3806a7f8f7@redhat.com>
 <5fdffd4b-7f80-471b-93b3-706c00cb51da@hartkopp.net>
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
	protocol="application/pgp-signature"; boundary="nforibwexwhhwea5"
Content-Disposition: inline
In-Reply-To: <5fdffd4b-7f80-471b-93b3-706c00cb51da@hartkopp.net>


--nforibwexwhhwea5
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next 0/11] pull-request: can-next 2026-10-22
MIME-Version: 1.0

On 22.10.2026 13:19:08, Oliver Hartkopp wrote:
> Unfortunately sashiko-bot complained about something new in my patch 11/11
> and suggests to move some release_sock() calls 4 lines down behind
> sk_error_report(sk) :-/

Is this review already available to the public?

> Would you like to have that re-spin PR to be named as "net" PR ?
> And when would it be best to be sent?

I'll rebase the changes to net, and usually "net" is always open.
(Correct me, if this is outdated information.)

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--nforibwexwhhwea5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCatoEeAAKCRDMOmT6rpmt
0uShAP0WK2mUhM76NDmM1sTaw9RY3flN1gl2MjbuMh/e+iiFGgD/e84G79VDot6/
nUNQB95cQW3f7PeK4XF6EQ0ioxllxwY=
=kMkj
-----END PGP SIGNATURE-----

--nforibwexwhhwea5--
