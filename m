Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E4019E968;
	Fri, 31 Jul 2026 08:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785485320; cv=none; b=MQ9lxPAuEsSmsGuY0nak4dcrFGlM/xdGupWTrY2UsSe8cC6W+w3nAjPeimA6PnO1WkE+VKvh5sGCBkJwATUPcZLx1mnFoo+oKj0UEwDD7gW5P5IchyQnCckBSRy1OERJk27QbsaLB7qQNm+ZPLNq5oGeFs/tJupt5a/CZ4iEPyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785485320; c=relaxed/simple;
	bh=Ts8sbhSJm6YSPWbsbrjbiDf7ccc/1YaQgL4UXPUY7SE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iqc7eNP58Xg0DElaXBtutm8W5vxKdTBt27c65Mwqs2AVZ2aCruRfsU2zL1KfCITymjaL7Fr1lmYXuNg4XVCUlQ+Gft7sEXS0rEDY0hmbjOv/a3u5UV0GkONArNU9ecs52uaA7QMdgKcYeYK4+F/GjQ0/7nl+QV2eZHhp8Ych/50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 321FF2020C1;
	Fri, 31 Jul 2026 10:08:36 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wpiIG-002Awd-0M;
	Fri, 31 Jul 2026 10:08:36 +0200
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id CE745577CBF;
	Fri, 31 Jul 2026 08:08:35 +0000 (UTC)
Date: Fri, 31 Jul 2026 10:08:35 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: sashiko-bot@kernel.org
Cc: Cunhao Lu <1579567540@qq.com>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, robh@kernel.org, linux-can@vger.kernel.org, 
	devicetree@vger.kernel.org, conor+dt@kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>, 
	Vincent Mailhol <mailhol@kernel.org>
Subject: Re: [PATCH v6 2/4] can: rockchip: add RK3588 CAN support
Message-ID: <20260731-tuna-of-splendid-protection-ae6a0a-mkl@pengutronix.de>
References: <tencent_207E464D12344B3228096E23A001D6882508@qq.com>
 <20260730144605.A68E41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g7nujloidt2lie2b"
Content-Disposition: inline
In-Reply-To: <20260730144605.A68E41F000E9@smtp.kernel.org>


--g7nujloidt2lie2b
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 2/4] can: rockchip: add RK3588 CAN support
MIME-Version: 1.0

On 30.07.2026 14:46:05, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues: - [High] The rockchip_canfd driver
> unconditionally enables CAN-FD mode in the hardware, even if the user
> only requests Classic CAN mode. However, the data bit timing registers
> are only initialized if the user explicitly requests CAN-FD. This
> leaves the hardware configured to process CAN-FD frames but with
> uninitialized data bit timing, causing it to lose synchronization and
> transmit error frames, which disrupts valid CAN-FD traffic on the bus.
> --

Good point. IIRC in non CAN-FD mode, the controller switches into a much
less capable register layout and disables many features. We accept the
downsides.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--g7nujloidt2lie2b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCamxYAQAKCRDMOmT6rpmt
0nn9AP9DqV4V+X8vXOVXeyj265nB4yHt1L2ALHqLZ3lDfwOxKgD/eSLzYR6A2q7v
OgoTq3rWvjLnQ9M3e2e9Gbk9yE9/Rg4=
=w1j2
-----END PGP SIGNATURE-----

--g7nujloidt2lie2b--
