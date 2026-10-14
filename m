Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA114A3D2E
	for <linux-can@vger.kernel.org>; Wed, 14 Oct 2026 21:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792014775; cv=pass; b=nFa3sNnfdynX3lV6kcOrZCDOWMUFeyVILVAjmvFbHjz+6RW08NlRs/41aWBUzhHyaPZFogs8ETdNGplkFnbK959bI0fJZ4wwNIr5wwQrgPUoZE77GH/lozUPxb6kNoLzHeF+5ZEJsS1ld/kHnaaRygYZ8FeG65BNci5asI3QCPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792014775; c=relaxed/simple;
	bh=dk7QXJJ7uonk7JiWQWe0zbLXh0IfW7vFnr/7akEdb2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kOxCy1L44Z933Cn46mH/aB5wQ6P1/W0PpY+z1Hec+Yu/CSQCeqjoupC4l9jz0FbnSoSC4+OQtc03WTAa4NgNpOzV+gNRdkB6RgzB0UuD0LcNST1i9EIV0b/j0Cu4wWAp5QmO6zgV0Z9oEIftvE5wHv+fWTUfgwHLlbL0KMgEe80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=MrrtufY5; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="MrrtufY5"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 17D30200563;
	Wed, 14 Oct 2026 23:52:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792014767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vHWMBUFhS2jZJ8fCjpnfKaEi1QJlaI0kQ5UHBcKjac8=;
	b=MrrtufY5/OmShezPE39Mv2MaEheWupHIrOsAAXutdf7Vll8BXMwoqS/CQkuFaOdqEgRg7Q
	y5fNEGfG5qR/nE4Lm1ddTb1DyAdp2WZCqeLB9WAKmWJYAQBi1SefhxBM34Qh5JZfVswj6x
	/T1Leze97o/ANvinDPOKBu7mFgcpuu8ULDVI32Aj+jr9OitBBPTj1Z36WbpDfs9CtZbSmd
	iyURlmyiOd2xA32fIVV5Ky7UktkSz8RXyFv6VkguvNXamKUVNFsilKiuJnayilMFLWyhgA
	OSRWdEfsruA9ZG6rqOLdPE+qDnfhsP/Bf85EE2SGOmFx4rkbvv4tjPE2+Hk8aA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792014767; a=rsa-sha256;
	cv=none;
	b=SH+DvVHe2AAozYrwynQk5eOz7kuN4vYAgG0d48VSw/A6WbmRvqMR1HmXPzYyJ6Rx/5BwEz
	Nn6p+mCHIH/MnGSKci/9eDrwkzeTIu+tLvPS+fZdon29KNOSwiN2ZlgbW74KOzSKQV5J1e
	xYyDvU9wGNrANRzuvf3ZDmlXp4nv3XGXne0KcwX/Om59fq3cGa3LMt9mDP6BvgjB/C6Udj
	BAEgGstE43KWTrn25EEDghU+njewyDHfi/BzigLXRjGw9RC0738jsUzEiyfxjmJfkLv0C+
	u4stcEH8i9+WmBQ85lksMaZ48VhiiCtBpACL6in4aigJqjL6dv1vcw8EG6UiXQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792014767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vHWMBUFhS2jZJ8fCjpnfKaEi1QJlaI0kQ5UHBcKjac8=;
	b=Zo7khDGaAEtiwVbk9aA+ZuNckcluureummwe3pnllWLxSvCpaWLfgAGt3Mu83ExDiAkLYM
	sN6y0XjkA370mUAhXGhySjZQws1Gt4QtRHaZO+k6rU0BzrXr3LOuYy/saZR/gAHvO98mYy
	jfZq0O7+Vnu+ZJUcWNDk/yncda9q/yuXkCzco6yzqRvW4XGfHzjOt/Bh0rTy6ZwLFK6Xui
	ocsm5KP5hW402iWRVKNbLcwXoJA9TcqfjczAmTfgmL/mhnCxkZR0L4SPNvPkjsgoCNWMeG
	rvOWZclWjYgmW0q641gyqcxftFNji7giwU/PPBbpvNvyV9I3lJ8v4lhv0Blv2w==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xH6ty-005vBA-3B;
	Wed, 14 Oct 2026 23:52:47 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id B93465C45D2;
	Wed, 14 Oct 2026 21:52:46 +0000 (UTC)
Date: Wed, 14 Oct 2026 23:52:46 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org
Subject: Re: [PATCH v3 0/3] CAN netlayer fixes for stable
Message-ID: <20261014-brilliant-impossible-platypus-4eda7e-mkl@pengutronix.de>
References: <20260928192410.71100-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jhyzxm3wlprg7jyg"
Content-Disposition: inline
In-Reply-To: <20260928192410.71100-1-socketcan@hartkopp.net>


--jhyzxm3wlprg7jyg
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 0/3] CAN netlayer fixes for stable
MIME-Version: 1.0

On 28.09.2026 21:24:07, Oliver Hartkopp wrote:
> This patch set aggregates the open stable fixes for the CAN netlayer.

pw-bot: cr
--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--jhyzxm3wlprg7jyg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCas/5rAAKCRDMOmT6rpmt
0qggAQCrJXbfPQDfH1xTQWhL2ZSWD7wCy6OZARAGXzMn+2BcugD+PLNu+4en7CFq
JqUm1SZkO8AOsU0Ii1JGMPuAlIr/3w4=
=wotf
-----END PGP SIGNATURE-----

--jhyzxm3wlprg7jyg--
