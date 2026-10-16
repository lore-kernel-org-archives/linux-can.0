Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00492C08BB;
	Fri, 16 Oct 2026 14:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792160546; cv=pass; b=BPEicUJGfQA3ioC/ou1f8w/0oqv9ZJ6eYHRkKblCMMigpFQ+YxzUiOEenxUrkMW90U9Qd2t95Pr8KCe2R5ybSdshY1Oc511hd2ORhJ3LZM0Qgl6yzshWTjoaaRSSAVjYIufbhK9YpGD0ADBfaRYlpqCyJ9PMjoB/Y5bcdVhdXIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792160546; c=relaxed/simple;
	bh=TE+NeMObnw7cV2DSl8zm5/5kphmiKQFfXjysKCj72YM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GClFJg59sBp0e6WU/i4sD+Y7tdfg858YlXQo5ffERjAkHrSKSRgmrmZ//C4pMlUNHKeQ1sx6MUam1TCSxrlHT/ShTyeqTwJNo7xp+5NseTdtCZ9Jg2t/r3yTbia3PwMyKTk1Jr4imVbEjlEd9WS+sK08mBkECngFHwhvSyxsMYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=ccmO/NmQ; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="ccmO/NmQ"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id CE37A2022C9;
	Fri, 16 Oct 2026 16:22:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792160538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eKbF9RFkKWoB5pWbmAsRWMNhQMOff8da/uxoiKigJzc=;
	b=ccmO/NmQWb4OFsfFsjbp0QFq7srpuFyOp6dk/u3EjEmzDR5fzItGweSDq9n8vsBRSKaoC7
	sq1daH2jkJ2yb73gLMfTSUypf7HRiAyELnVMXkL+Ji6N+GafwIluyvQ32zmij5+BUcoZrl
	5hnVt01JfEVangVI8RWyo0OliBabU3UmPyW6byLn7qZzMrfLmDqAM2z1FvB04Tf+aCDJBc
	vU6JhH02NnGmeXmMpNBk2/dIStI6OOwjQIQ5ENMEocM5lOEG2O3kNlsm91ChgaYhdrxW+L
	BNWtgjRajnsn7ZueQkPng6ErTY1FYjV1Lo9kB/8SEOMs20W7Ylb2/K30U5EJRA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792160538; a=rsa-sha256;
	cv=none;
	b=E7lvEjmCGPbbauxGC8XbhOi34LTGSATxtGmsd8J/4hYHrLdg3G6J1jPnvTqBl8XfzXo/pe
	BKoaC3urIFiF5a/bLjc5A1upSOTqoZKBx5G63glgt4P9XhP8d5m3ryXdPRLI87++mY4SX4
	yCDL7bWJw/j99p5BbYoU7HrPSeL2zhn8SG4jhUX9cIyX2wLxk92h3XWgwfxTxjvtehYZb9
	MPhpu6MXTqrd+cJrI6kITwTukeFLNGmUubyPDZ0CcjWt3tGIpagfrXZ6eW+HkPFoTuUAnJ
	GcSmnba7ym9MFesKuvk0tjHxh+0YIRSIe8SyYS3cPbtz5xvmbzGM5wndUAf+xw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792160538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eKbF9RFkKWoB5pWbmAsRWMNhQMOff8da/uxoiKigJzc=;
	b=AHlnuqWnrvzMuGLodzju/rd23v9xuAjv9NWN0wy4W0oXHoRujzNPwe9hjJLUsueW95L+qI
	/b6ZdKgy0wKMi6IPF4MraO2+BQytAovonmiEdXwDtYdGfgZzuzMmGF8UzEy2d6cPBT5tGq
	CXfWAO9bM8AFFGa2d/PjgtoGWz6LGsCpOucyeJGU8KXhHL6Liyto/JjzFlr2wrAgsQDHDD
	P+aFX44T0dMpr0v8W7iUEmHrvQu1PRSqJcWh5kCR+vpGTYwitRC/OKkJy7stMSe5DZf5f8
	PROJMhuiryxUHzhM33f4rn7naWzVTsukGbxSgvEAp5oQZCjnQcJUcL1FEgH2AA==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xHip8-006CNF-2P;
	Fri, 16 Oct 2026 16:22:18 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 7CABE5C62D7;
	Fri, 16 Oct 2026 14:22:18 +0000 (UTC)
Date: Fri, 16 Oct 2026 16:22:18 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	linux-can@vger.kernel.org, kernel@pengutronix.de, socketcan@hartkopp.net, 
	kurt.van.dijck@eia.be
Subject: Re: [PATCH net-next 22/37] can: rcar_canfd: Add support for Renesas
 RZ/G3L
Message-ID: <20261016-international-aquatic-chowchow-8ffc4f-mkl@pengutronix.de>
References: <20261015015336.816543-23-mkl@pengutronix.de>
 <179211823337.434549.12652981577769724778@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fwntjsudtuolmsoq"
Content-Disposition: inline
In-Reply-To: <179211823337.434549.12652981577769724778@kernel.org>


--fwntjsudtuolmsoq
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next 22/37] can: rcar_canfd: Add support for Renesas
 RZ/G3L
MIME-Version: 1.0

On 16.10.2026 02:37:13, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 (1) =C2=B7 Medium: 1 (1) =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>
> - [Medium] The RZ/G3L binding never makes resets/reset-names required,
>   but the driver gives RZ/G3L the same reset handling as RZ/G3S.

looks like a valid issue

Marc

pw-bot: cr

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--fwntjsudtuolmsoq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCatIzFwAKCRDMOmT6rpmt
0vTAAP4jUJsqpdVmos02NDp+3CuG2scKxVFpE/YhkMZ+bdrzKgEAhca4npCSDVIL
lKHsmKa6St5Sgqa6vrlRueLty3pkUQg=
=sgTy
-----END PGP SIGNATURE-----

--fwntjsudtuolmsoq--
