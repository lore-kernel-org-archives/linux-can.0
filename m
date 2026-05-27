Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730982F7F12
	for <linux-can@vger.kernel.org>; Wed, 27 May 2026 18:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779907235; cv=none; b=GfdgjXpG4GXhOVNHz9XBmcxKpBqbRtsPNCAfFBJAbVswEWzmw3F6pQXFAW/ZE57+TlND4EWdQtVeFMyFvr21vX9OgKIvXEvpH5L79C9Ftk6cQbobz+5cHVpZHbb5yTlfrkj0CjzMLZev96bowN9isvSCVNrBuMS+63oL07ZNUVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779907235; c=relaxed/simple;
	bh=MRwAdHfRxNmwf8xZGWn/Zj8JRT/viPPrcOWMJDpAIvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MrzWiX6cjlfRaV7TsU0x9/gIB3EObBfuFh4p+4l3xVcT2VyN+RpJFGJFRmcR8iTGcNJrfBzrNh3MiuI/pn0EpXEZzcYUjdD/Lqbm6BvZB5GnOsO7qcqt3vnvHz6ISAf12mSEgq75VjBHaPaoOWrER1umzCul5algr+/zB/vmGkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1wSJB3-0004CE-Rw; Wed, 27 May 2026 20:40:25 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wSJB3-0029Q0-0Y;
	Wed, 27 May 2026 20:40:25 +0200
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 600B5543420;
	Wed, 27 May 2026 18:40:25 +0000 (UTC)
Date: Wed, 27 May 2026 20:40:25 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Andrei VOLKOV <andrey.volkov@munic.io>
Cc: Pavel Pisa <pisa@fel.cvut.cz>, Bernhard Beschow <shentey@gmail.com>, 
	=?utf-8?B?TWF0ecOhxaE=?= Bobek <matyas.bobek@gmail.com>, Matyas Bobek <bobekmat@fel.cvut.cz>, qemu-devel@nongnu.org, 
	qemu-arm@nongnu.org, Oliver Hartkopp <socketcan@hartkopp.net>, 
	Nikita Ostrenkov <n.ostrenkov@gmail.com>, "Daniel P. Berrange" <berrange@redhat.com>, 
	Peter Maydell <peter.maydell@linaro.org>, linux-can@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, 
	David Jander <david@protonic.nl>
Subject: Re: [PATCH v3 0/7] hw/arm/sabrelite: Add FlexCAN support
Message-ID: <20260527-hysterical-cuddly-oriole-dba44f-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <cover.1777571962.git.matyas.bobek@gmail.com>
 <CAFEAcA95RcGhhN8ZqVeOgRyhRqSar23EnJhCjVgKBwoqXBJwjw@mail.gmail.com>
 <08A7BC6B-7019-45C4-B581-0A26AD3AA554@gmail.com>
 <202605271738.21722.pisa@fel.cvut.cz>
 <20260527-fast-unbiased-flamingo-5c5cbe-mkl@pengutronix.de>
 <07cc057c-61b3-4744-96fa-1d792989cb4c@munic.io>
 <20260527-durable-festive-millipede-f6e2b9-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wlqdkxxfjfyqloqg"
Content-Disposition: inline
In-Reply-To: <20260527-durable-festive-millipede-f6e2b9-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--wlqdkxxfjfyqloqg
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 0/7] hw/arm/sabrelite: Add FlexCAN support
MIME-Version: 1.0

On 27.05.2026 20:38:10, Marc Kleine-Budde wrote:
> I'll agree to re-license the register definitions of the flexcan driver
> to GPL-2.0-or-later. I'll poke Sasha tomorrow.

Typo: Sascha

Sorry,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--wlqdkxxfjfyqloqg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCahc6lgAKCRDMOmT6rpmt
0sdmAP4zeDvmu2UenbT9Dny01/A0N58VZcNL+bd5pitKo7jGkwD+OZM2kBFufsth
KvYJxwZ5ofRp1602HuM6kPllw6U4HgY=
=OMs/
-----END PGP SIGNATURE-----

--wlqdkxxfjfyqloqg--
