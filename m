Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772C53CC33F;
	Fri, 28 Aug 2026 06:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787900316; cv=none; b=DtdM5oYSR6E2WJgULaT0g8+c6pY96WxdgfFFn9PmIROcW8gCFoVB8kFc/sN6oPDb9n1pClatoRm276mLuCK1aCaX6qj9W4p6xWoAHfFWHY5JSnqAd9GPyKtzKmNs0uXh9ihq0qZSsr3MWNua1vMddlwDEll2N32N7KXzjPlYfHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787900316; c=relaxed/simple;
	bh=WLich3nu80IVX9m5emvNtJAK1D2PGDaua4ENX/232vs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fjPT7s6odtSfEmAbmhFLodYBgLuQIq1vDw8zanK8d8Eg7OsfXDB7CTXP/14M11OhIMIgPvPeqzJgh1OGMWDdg5Ytnhbtm8TzUBRnkkOIMlTJaCKSYy/J4aXSxjOt/TTQkKOwmuHli/wq8iHk8jlA+DRZ7K9qdEyNzI0Wp85fvzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 17549200FE5;
	Fri, 28 Aug 2026 08:58:30 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wzqXl-003j3K-38;
	Fri, 28 Aug 2026 08:58:30 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A16C058DFE4;
	Fri, 28 Aug 2026 06:58:29 +0000 (UTC)
Date: Fri, 28 Aug 2026 08:58:29 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Farhad Alemi <farhad.alemi@berkeley.edu>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, falemi@asu.edu, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] can: kvaser_usb: WARN_ON(!dev->cfg) in kvaser_usb_probe()
 from an unhandled clock-frequency encoding
Message-ID: <20260828-sassy-ammonite-of-focus-b2f17c-mkl@pengutronix.de>
References: <CA+0ovCjbbonrZ-eWsjT6r7VhBaO7t8M_HCYwWzU5XJDettsd8w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="a2cgurjaq4zq7vlf"
Content-Disposition: inline
In-Reply-To: <CA+0ovCjbbonrZ-eWsjT6r7VhBaO7t8M_HCYwWzU5XJDettsd8w@mail.gmail.com>


--a2cgurjaq4zq7vlf
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [BUG] can: kvaser_usb: WARN_ON(!dev->cfg) in kvaser_usb_probe()
 from an unhandled clock-frequency encoding
MIME-Version: 1.0

Hello Farhad Alemi,

for future reports please include the whole crash report in your mail.

On 28.08.2026 03:15:44, Farhad Alemi wrote:
> As part of the kernel research at ASU's SEFCOM
> lab, we hit the crash below. Crash reports can be found here:
>
>   https://github.com/farhad-alemi/public_bug_reports/tree/main/123-can-kv=
aser-warn-null-dev-cfg-kvaser_usb_probe/
>
>   WARNING: drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c:989
>            at kvaser_usb_probe+0x14a9/0x15e0
>
> Our reproducer.c is available upon request.

Please post the reproducer.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--a2cgurjaq4zq7vlf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCapExjwAKCRDMOmT6rpmt
0qqzAQC7ms7M4mxL8xFmTVgdPqn5buqthVvxcJJNXbOvhiiGXgEAn1BPovikRkDc
+3ftalwkgnZ/Qn8AxMdISVqBv/q43ws=
=oYMD
-----END PGP SIGNATURE-----

--a2cgurjaq4zq7vlf--
