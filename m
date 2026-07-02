Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E73C34F498;
	Thu,  2 Jul 2026 08:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782982153; cv=none; b=fqZIgCxSh0DZENIR0Sv7yE1ZNF/l/DxaGD/YghXUGG0UVy4dKy6Ty69bXCu9nq0oVYm50gPBRD++0yFRBUgLMsx/FMwSY+WpRdS2V9YsBqHXqmJ+NZDerstylj7I0/BroR9TnkjLpbFQXE3twQxGfPRx8hMU8EetLhlgnCYf0tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782982153; c=relaxed/simple;
	bh=7wSPEAvHVPKDCi5YqK0yrAD5Yqjwtx8pW9dn4Px3iF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YIu9vBVSGy85EB6jJAhyDWYj5kNRo37XdhmjEuf4npnmgDs09U7vNm+Ye+jJZL7SBbb+BdLa/PAcmc9LfNc3M9fcSiERrBbHrlOE11HKwC/JaJKnXZ+t4uLBl5Qw5ygHz0P8jiAILEFb6lRB6TAL3+WVQ9Fgv5+UZQT627fnwog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 9E5A7201223;
	Thu, 02 Jul 2026 10:49:07 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wfD6Z-005iXJ-1Y;
	Thu, 02 Jul 2026 10:49:07 +0200
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 1628755E0B7;
	Thu, 02 Jul 2026 08:49:07 +0000 (UTC)
Date: Thu, 2 Jul 2026 10:49:06 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Cunhao Lu <1579567540@qq.com>
Cc: krzk <krzk@kernel.org>, heiko <heiko@sntech.de>, 
	linux-can <linux-can@vger.kernel.org>, mailhol <mailhol@kernel.org>, kernel <kernel@pengutronix.de>, 
	robh <robh@kernel.org>, krzk+dt <krzk+dt@kernel.org>, conor+dt <conor+dt@kernel.org>, 
	devicetree <devicetree@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	linux-rockchip <linux-rockchip@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, 
	shawn.lin@rock-chips.com
Subject: Re: [PATCH 1/3] dt-bindings: can: rockchip: add rk3588v2 CAN-FD
 compatible
Message-ID: <20260702-urchin-of-abstract-fruition-25a192-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <tencent_97F21396469202221027FD429A6E69DA6409@qq.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5reivf23ta633xqa"
Content-Disposition: inline
In-Reply-To: <tencent_97F21396469202221027FD429A6E69DA6409@qq.com>


--5reivf23ta633xqa
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/3] dt-bindings: can: rockchip: add rk3588v2 CAN-FD
 compatible
MIME-Version: 1.0

On 02.07.2026 16:17:25, Cunhao Lu wrote:
> > And why is this different from rk3588?
>
> The reason I used rk3588v2 is that this is how the controller identifies
> itself at runtime:

There are 2 silicon revision (v2 and v3) of the rk3568 available on the
market. The v2 has several errata in the CAN-FD core, the v3 has some of
them fixed...

>   rockchip_canfd fea60000.can can0: Rockchip-CANFD rk3588v2 rev2.2 (errat=
a 0x0000) found
>   rockchip_canfd fea70000.can can1: Rockchip-CANFD rk3588v2 rev2.2 (errat=
a 0x0000) found

However, the version register _in_ the CAN-FD was not changed. :/
This is why we have a rockchip,rk3568v2-canfd and a
rockchip,rk3568v3-canfd compatible.

> I also checked Rockchip's vendor kernel 6.1 sources. The RK3588 DTS uses
> the binding name "rockchip,can-2.0" for these controllers, while the
> upstream driver has SoC-specific compatibles for the Rockchip CAN-FD IP.
> That is why I chose the SoC/IP variant name rockchip,rk3588v2-canfd.
>
> If the preferred binding name is rockchip,rk3588-canfd instead, I can
> change the compatible in v2.

Yes, please use rockchip,rk3588-canfd, unless we get information from
rockchips about CAN-FD errata and SoC silicon revisions.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--5reivf23ta633xqa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCakYl/wAKCRDMOmT6rpmt
0rfWAP9/cy8OIXtO2OsLEOg1oWmpztwHSI3qImvegZ3uAfi0ewEAuNTEKGjvR8Zk
lIRDOsvwwOhBdVLvPlX2tiOSHSCDaAU=
=sMDb
-----END PGP SIGNATURE-----

--5reivf23ta633xqa--
