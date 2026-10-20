Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792496666;
	b=IZwjf4tcKUybLVZtzMTykfQZc6KZegChl4tcKdx1y0bJHYrgQqDJ6ofcCi44/gxCzUsq
	 H7eu1fiAyyG9QvTojqPRqpcBHiMdKbqI55FB+5XdaQ0fTvKQyLnajY94XYfWQ7mqFoNHU
	 Tm4OL7cn4M/CPeBxBSOAkVIgLjwQWWon+N28KtvPzBtVPMna/vvQilh/8gCHlAZmF7zY/
	 7d0dpyOAZseHPvCr1V4lG8qeO/d4fJMx13rOafgW/fcWzCJaCqAm/sF8r90QhdXc5ZnSB
	 k73BJgE3uR+VT4GYJc1qmQ/eRcJBKo8vTAXNBy8oe2mG1mTTukkE2Re8aWDUFWmavNQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792496666;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=DSkMaD60Wc8MncsX8fH07bCSsOrU0vJetNk82ltZeXo=;
	b=HBw7QEPcmrxXq3AHoWLC6027Z3xeXfxfUjqNStvKMRydrSJYYvdpA8VUJxa/DmI9gNd5
	 YOFw5kzaz3HikFUrztjMPgMTjhy48a0KgqKxeY1KboYi50MaF/9KMOBJuCGS3ii1Bz0gJ
	 cm9Qg4oou+sRl5pkuCP0musVGaPfEOGrLAW7vh2JLHTXu+qdm8Pv8BRXxsBnmHhuvp1nF
	 VIYiik89/cbPA7EFTKUE/I7MMuj6OTT51JRAAImWbYa/DEXAZJVJDS2PUchoPmwjtWR9Y
	 bpWoN/P1a6VvcvN2ZecCxV5pmQwY2YpaiFd6l9cHpgUO15EF2rw6j8Ez1lhFPKqwDUg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=a2ev1IUh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC8D606A323
	for <linux-can@vger.kernel.org>; Tue, 20 Oct 2026 11:44:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DC8D606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=a2ev1IUh
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id B78432009B1;
	Tue, 20 Oct 2026 13:44:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792496662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DSkMaD60Wc8MncsX8fH07bCSsOrU0vJetNk82ltZeXo=;
	b=a2ev1IUhhcepXhS63oZKBkUfFqwhQLMDYXRvluoVKLUov0YCXGqF0zSCs6WETh9U4ssdPD
	MFgCaumfdBq2gYXSE3xMWZHp24JdrtlNRG/DsO2WDKEek1cNOrliv75KpsJgwa2rjLCmOS
	0LrhocgjbrXuZO/qxZlLg/uZPYRiYRiTGAejsQsTQF0tC0CcMeeicdR44zGN/mgSrU+UgD
	oPx5cjd4Zzo7Hl+B7DKtQj+vAnuNs/+vOFMDeYfM4LfLRhg8cQIb0rxniQ4NC9OeRvxAEA
	Pk8dm+P6NoyMTPIoSYCunRGm3CMfWTBVYcnz5EyFYWBTnh/OfaCqP9NwkSKDtg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792496662; a=rsa-sha256;
	cv=none;
	b=I2+826976Gg8P/5mdypoWy2RLrppI9Uos9d4wG1q6qAZLIRRAdGXhyg4aM13cVIBDAS1HR
	4OrNoNlVWBE2BA9jSgCemKpMAzTZGSbjQJ3UIZ5nG9+pS3snLPfwLpktBBqcM7gql04IIh
	CWdzeXdj/q6PdKumL7I6+oFgkWRS8flL+1w3f7BfwocO3Q5XGoSCP86dj+QQkdimlh2awG
	IrrO7b614RSRooFJca9rRm2GdLhBaiFz3cDtWeeiudwYlAxujhTGjjsRvEiOpBpJlsyvPD
	pTm8g+hoKG3yC0sGJQVIvB3w6ahmMggFmGGuuTINoggkWQ79xMe8ZTC23VR44g==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792496662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DSkMaD60Wc8MncsX8fH07bCSsOrU0vJetNk82ltZeXo=;
	b=O4dsHMMtekIMUfM3YMULypolGa5jtqyGGnq+L2gf9aOG2pH5WI4s+VYWYUMIz+PPeqoxgh
	8ZtuAE+bb0isaU9V0GzXewwREBu2EROS0DvksLHcoFCnUlOT5gpWh9WHgFAF9w9o5oWJn8
	tzd4blW/lFR3xxCgI7/W2gW8geG3tqOLRvuCEp6ZusvOQEWlxyAfvdkA6Qi8efjtdYwAuT
	ZTiRjLRlCKl3W1JIipayF3PTKUJN7OlvnfaMhgHACrwu8PhG/dari3BbXOzod8ZT7Ziw+X
	kvixpWE1WdMv2vxx72xNGNhAFTEJBI4eBNyuMQGWFbt30N9/NXuT/FHbu/il6Q==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xJ8GU-000Mlg-20;
	Tue, 20 Oct 2026 13:44:22 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 540A55CA068;
	Tue, 20 Oct 2026 11:44:22 +0000 (UTC)
Date: Tue, 20 Oct 2026 13:44:21 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: sashiko-bot@kernel.org
Cc: =?utf-8?B?U3TDqXBoYW5l?= Grosjean <stephane.grosjean@free.fr>, 
	linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>, 
	Vincent Mailhol <mailhol@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH v3 09/10] can: peak_usb: unregister the netdev before
 dev_free() on probe failure
Message-ID: <20261020-solid-original-hippo-5ed735-mkl@pengutronix.de>
References: <20261020-canfd_check_channel_idx-v3-0-74d17c5a599e@peak-system.fr>
 <20261020-canfd_check_channel_idx-v3-9-74d17c5a599e@peak-system.fr>
 <sashiko-outbox-178730@kernel.org>
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
	protocol="application/pgp-signature"; boundary="obwse246htixkqar"
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-178730@kernel.org>


--obwse246htixkqar
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 09/10] can: peak_usb: unregister the netdev before
 dev_free() on probe failure
MIME-Version: 1.0

On 20.10.2026 09:26:47, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [High] can: peak_usb: premature register_candev() in peak_usb_create_de=
v()
> - [High] can: peak_usb: race in peak_usb_create_dev() due to early regist=
er_candev()

pw-bot: cr

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--obwse246htixkqar
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCatdUEwAKCRDMOmT6rpmt
0hI2AQD/P5Ra6JplVq75Pz33BThoi1YD26O1ndU+BAhbm5LLNAD+PVDeB4x/6qld
c5ALEP+c+U23odrc3HvZ/1YZ/Vk2Dg8=
=7idz
-----END PGP SIGNATURE-----

--obwse246htixkqar--
