Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F38A2D73B6;
	Tue, 29 Sep 2026 14:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790691558; cv=pass; b=V55WwpXfVcYyeMizo7euhs9El7m+xWdCcsWD+EeXxRJ9qp4K8ws2s8yM2GP/BZE24h3et1vBHx9lnp3uAA72DwjIEDQtz2hnMk2zMnaMdwmR3ETLRr+L6AFrXqnX8ckeGrPdlLeEYgH/cvrl3yiQ4jUCQow6Bo+2+rbzE1NNgPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790691558; c=relaxed/simple;
	bh=ni+BI1ouvlTGJ1KK/M2u5NHCbVyDz53Zm28rXNfRb44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mkrxrf+FOXYfl8/IRpwW3e7KqJBq0++AOyfvcWmbLv8bEviAudoF4Sss253SMiyMgkMayh4bR39yvsoc3uznxnNapvakYNYYL4FUm+CHKXn9751hFTBRzJu+MEpmTqMDHxHwn0g/ioosAHLXyDUPKcTrgSPMb6/WPmJZZOgK02Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=bX6Pp+xv; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="bX6Pp+xv"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id CB30520007B;
	Tue, 29 Sep 2026 16:19:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790691548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TmGTKRlxpynV8OYZ+hg9m7/obIfpUfUzF4Gu7phnyYI=;
	b=bX6Pp+xvynpN45a3wG5oj5Ar2LB4JUJiEHWqLblUk4YqKIkauWxEoBiJPfRHcJNOgtbLhU
	I+DfYYp8erV6CBRZoRvk9r73CENECc5yiRgNaGCXRA5DtN1u5r79qHwVbDvhbeiWdvzg2z
	NnPx2Z7EK8tPObYppBhTiFVxIHQVeG5uv1X5u4JbfFwEV3kKIrHWAjg2bS5nRQm6bZBGO1
	82NHdPi2IxONMNhcp/trm2AiQv2EddZjUB7s9jhNWzPJKKXy5raf64QlKhX4qUfQYVS+C6
	lS9uN8HNo2puRYjbnnbx056VU+s6JDdMvffYXKtHHczxNXVo0nyLF1d/+C1qJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790691548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TmGTKRlxpynV8OYZ+hg9m7/obIfpUfUzF4Gu7phnyYI=;
	b=Mn2zpWzY9I/rUn5IPa+CD20TUUYWAoWnQSPlgM7Q9WsolT5t0xuAPKkkgTaTQpvXgTv/rq
	+u/BQHYQpvHZhMDINQvLV7T79fcFG4jBrY0KBvc/1xU84cYXVHjy/xUGu849D3A8bTdKod
	f8VYGk0a9uaguJiGj6alOastLiYehRSDtzBMxgEhGOANAlASU73SoLjLdHD6JtacTSzBbb
	BAeTauTxNMOzlgwOWEGDH+mkalIxDc9LU0TEYmNES+K1Nd8b3mUoenKpK4oMnrtT/u67Kw
	r9ZC22nVFN8+gTnH+ZiP0cGDGmouDd2PpnCIKoYbSQyqhPxpDqN6Tz13raXPOg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790691548; a=rsa-sha256;
	cv=none;
	b=RG5rUWGzGrSgxImEICeSheV+evT/VKr1Yj7RauU5H4ndTg9j6OTaY0nnoDFh/sD9YhjXjH
	TKhhYOJSGTDLoGOhmNktjBg0LpMsx/j+31WjOGN4PXVY7E1Kh7GQBNVrBE9HnaBJ+V0OUe
	HbtslK/jwSYIXzm/dYzW1Bm17R2hq4U+FVm1NDp5d/dq1MNUv/Jk7wPIip+Uywx2GKRP3P
	6TQUGnZSIZ0QgTsZ+OWP3GCg7nrPgEAZXw75898H1uTAi+iV6J/qffAEicZ6zTMtJ9xt9L
	M3USC+HBH6MfgTi0npBIK7wrmnjHZelpnLwiZU1LWChMSlHpkfvVauN3ibtueA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xBYfk-003PGS-2N;
	Tue, 29 Sep 2026 16:19:08 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 5539F5B4937;
	Tue, 29 Sep 2026 14:19:08 +0000 (UTC)
Date: Tue, 29 Sep 2026 16:19:08 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Claudiu Beznea <claudiu.beznea+renesas@tuxon.dev>
Cc: mailhol@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, geert+renesas@glider.be, magnus.damm@gmail.com, 
	biju.das.jz@bp.renesas.com, fabrizio.castro.jz@renesas.com, claudiu.beznea@tuxon.dev, 
	linux-can@vger.kernel.org, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v4 0/7] can: rcar_canfd: Add support for Renesas RZ/G3S
Message-ID: <20260929-loon-of-remarkable-romance-197df6-mkl@pengutronix.de>
References: <20260902141544.565763-1-claudiu.beznea+renesas@tuxon.dev>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qmqwmpauwv5x7gzq"
Content-Disposition: inline
In-Reply-To: <20260902141544.565763-1-claudiu.beznea+renesas@tuxon.dev>


--qmqwmpauwv5x7gzq
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 0/7] can: rcar_canfd: Add support for Renesas RZ/G3S
MIME-Version: 1.0

On 02.09.2026 17:15:37, Claudiu Beznea wrote:
> Series adds CAN support for the Renesas RZ/G3S SoC. Along with it a typo
> fix patch was added on the CAN driver.
>
> Merge strategy:
> - patches 1-5/7 should go though the CAN tree

Applied 1...5 to the linux-can-next tree.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--qmqwmpauwv5x7gzq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCarvI2QAKCRDMOmT6rpmt
0nqJAPwMHqD/5/QETLswXeIkQskDnXi6oMwiwqJS8G5wpwU3NAEAtjREkc8RvgXN
CnDa9kxJT5xkGu7cnX/oHJCG8mLUOAw=
=or/f
-----END PGP SIGNATURE-----

--qmqwmpauwv5x7gzq--
