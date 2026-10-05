Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F151478E2C;
	Mon,  5 Oct 2026 10:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791197287; cv=pass; b=LhBiGXr7qRbHDjlOXkAyyjVx9wQLtpvutvVX+NpgHh/K+vS6dqx3cc8F+0yu2YmFFqiJFIQBMoFN6qtVcTgIWLszziV0pfx5trP+Fa45TfD2Q0yyeN2pmUtMLoyEcahnI9K08bVWgaNbdnILso3N6pQboIJcR2WAVFuJQ/q+LSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791197287; c=relaxed/simple;
	bh=oP7zq6AEtyPuoPqLvn1yvpKfIzVGfsx55snpFYwvdKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TMWAoqTdAvnFR13D0ttWmXfYvb8i1bien7TzMXJICKckBv06Ef9Uob3NdiA/cYBEt7kTjS+/fDmBNpv+K1HWMFzHJDGUtu8u9MarWInIxxD4lLyMAmOw6xj4MYZ04ywc9Fucy5ca0CCLTKKX+8X0d+b0fsGU6BodI7Fup1gF6b8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=JxzeQX2W; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="JxzeQX2W"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 41B9A2012A4;
	Mon, 05 Oct 2026 12:48:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791197283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4WWLnsU07IwM3dlzINqo8MwV2u40UtVBRundRCk4nAU=;
	b=JxzeQX2WEEGsEASLsm6QCTw87C2PG7PmIvBhtZtY6LbpVtZF2E9r2JeqEF0sv1BSFPAnqO
	SZrNuajL2IFXrItCem20OrwkXDIbXfXgh8/KbovgQ8FBl+iX4iLxy9ndrPCSS4bxs6BVDN
	eXhm3RH6nT7qIuvhuQ4M+NHfxUK9B135mTyyclRS8gTWftEUtPtf49BugPUZzSjWndd+ZX
	TM1vo3A+5ov//KIr/kF6BYGJTT0oqaWWEZc0U2G8xPkkGlG+laOOjKePtr3PhrfXttDOQe
	Wwk2lxvGHHUI1p3sknGYnLEXfZGWP/a8qFqB3TJlp9d9tqaf065QX6pUuvqejQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791197283; a=rsa-sha256;
	cv=none;
	b=WqbX6T7BTT2tgO29bT0nYYJ8UrRW3HZe3mXodZyGkiw1gRX5nKAeYkwnsM4qa73ilmfrWm
	a61IBaGOs/hTVrFlaZw2s4FBf44uvUi6G3Ew62y4JgbnZ3auCIES0Al6FsqFEWXMxTofNL
	NUdrA89iXA92VoP23aDDqxt6t/JmROCzqgA0yTQzQD62tuDORE8fr9xEqPGcMZulg/3HQk
	joe5U9Heycqdq+Kz7ZeG5ev6ujzBvWLksWh/CBK6et+0oZS4VHicUHWJI6G6FheW9n0q0I
	a+7f2mYBqnsRK/zNbVsB64YmgOa4s3LHks+7tplwL6flAG7P2vaw2FSeUE/mwQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791197283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4WWLnsU07IwM3dlzINqo8MwV2u40UtVBRundRCk4nAU=;
	b=c4ELF8VD4aqJYPDF/nVM9RKT8CsEQdL+EL7mhJY2NUSQy7gjxL4Sr5ICLzLPsyK61ZYOo0
	ig+ULY3IGhjUotN0RVq8D04Br/0b3O0UmS3xPKDFVjr5swzD0IDiEw4ZuSoLPlx3aopkuv
	9xbZnjbYuyyiWPvo76IHV/NF3JxRgEnrJty3cF8NKC6xO9kB+frQ1KrthYgu56WPJZ9vCF
	gvSRbk+qFjkbW4yQhP5EpDockAKejIQv4P0x2uCj/DCBfjzgls+BC3FW8/IChV/ErBzK/s
	MIzsnJvkIIyRwRIMgZTfHJCSORlVClbNxexZPbRN9pbs4sDM+AFcjX9N4gMq/Q==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xDgEl-004Mxu-0T;
	Mon, 05 Oct 2026 12:48:03 +0200
Received: from pengutronix.de (90-182-211-1.rcp.o2.cz [90.182.211.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 8B9295BA103;
	Mon, 05 Oct 2026 10:48:02 +0000 (UTC)
Date: Mon, 5 Oct 2026 12:48:02 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev-bot+sashiko@kernel.org
Cc: ciprianmarian.costea@oss.nxp.com, mailhol@kernel.org, 
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev, 
	haibo.chen@nxp.com, linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, s32@nxp.com, imx@lists.linux.dev, eballetb@redhat.com, 
	kuba@kernel.org
Subject: Re: [PATCH v7 3/4] can: rx-offload: allow more than one receive
 source
Message-ID: <20261005-bittern-of-historical-storm-a147a0-mkl@pengutronix.de>
References: <20261002071203.1287650-4-ciprianmarian.costea@oss.nxp.com>
 <179106338585.1406898.13675590689657020972@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5nt4d4nww5iayqlm"
Content-Disposition: inline
In-Reply-To: <179106338585.1406898.13675590689657020972@kernel.org>


--5nt4d4nww5iayqlm
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v7 3/4] can: rx-offload: allow more than one receive
 source
MIME-Version: 1.0

On 03.10.2026 21:36:25, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 4 (2)
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>
> - [Medium] In can_rx_offload_move_to_skb_queue() the comment says the
>   sorted merge will 'keep the timestamp order over all sources', but it=
=E2=80=A6

I've found some old downstream patch series that might solve the RX
starvation and continuous timestamp problem:

https://lore.kernel.org/all/20261005-upstream-can-rx-offload-batching-alter=
native-v1-0-4c08ccb516ec@pengutronix.de/

The idea is to not flush the whole skb_irq_queue but only 3/4 of it.
Feel free to use ideas or the code in your series.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--5nt4d4nww5iayqlm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCasOAXQAKCRDMOmT6rpmt
0tLOAQCG73yVaNkcInVFT4BMq0DsG7arhdwnytO1aahprm/zPgD/U1p4cVAsR/Fp
TmsBt3Q7FYQB55UyDUuGnRor+SXfeAc=
=rA+P
-----END PGP SIGNATURE-----

--5nt4d4nww5iayqlm--
