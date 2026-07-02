Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DD0420E92;
	Thu,  2 Jul 2026 08:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782980148; cv=none; b=oDhKqdplm5+di2BTPdFMFv2wWWARAFur7KKFNGZn7VJNbpvIYLaAKtPduQNsR0VY8un7U8tPrICJdktpDawAHXOD5rGHQ7bmnlJNU49iDHT8TUQ4g2T4Lqoc/oybn8QY3b6pmvluOr97O3D54h2zKStIQxlBW7+hoyQWwpkQkMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782980148; c=relaxed/simple;
	bh=olv9L47YZtyhJBBLjkc5FHSFI+CVW3FRTTeji02CqVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SiBlrNaWcqlyX1FYF2ZYSwi+7zNa0hMwlRI3KnqpPslkPPRiT2KKdmLEnlqTfN47AtM+tKPS/hx21qSu7X2vWctzxzm6/dXZGVBEjqcwOohz3AckbXP0upmwNMLVSXgPLsy7FdTUcuuwQY3XTc79ykNngxAl1l0NR9DAFjry5CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 6AF33200F84;
	Thu, 02 Jul 2026 10:15:36 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wfCa8-005iP3-16;
	Thu, 02 Jul 2026 10:15:36 +0200
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 0C16455E028;
	Thu, 02 Jul 2026 08:15:35 +0000 (UTC)
Date: Thu, 2 Jul 2026 10:15:35 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Cunhao Lu <1579567540@qq.com>
Cc: heiko <heiko@sntech.de>, linux-can <linux-can@vger.kernel.org>, 
	mailhol <mailhol@kernel.org>, kernel <kernel@pengutronix.de>, robh <robh@kernel.org>, 
	krzk+dt <krzk+dt@kernel.org>, conor+dt <conor+dt@kernel.org>, 
	devicetree <devicetree@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	linux-rockchip <linux-rockchip@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] can: rockchip: add RK3588 CAN-FD support
Message-ID: <20260702-deft-grebe-from-camelot-1bf360-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <tencent_534F9A1699EA04B091BF8003C479BFA32607@qq.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vcp7brl22t3ha7yd"
Content-Disposition: inline
In-Reply-To: <tencent_534F9A1699EA04B091BF8003C479BFA32607@qq.com>


--vcp7brl22t3ha7yd
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/3] can: rockchip: add RK3588 CAN-FD support
MIME-Version: 1.0

On 02.07.2026 10:53:53, Cunhao Lu wrote:
> That works for me. I will prepare a v2 with:
>
> - the binding schema changed to use enum as suggested by Krzysztof
> - RKCANFD_QUIRK_RK3568_ERRATUM_6 enabled for RK3588v2
> - your Haikou patch added to the series

Is the SoC you're using actually a 'v2' silicon revision? At least on
the rk3568 the downstream kernel has code to read the revision.

> > But if it actually works, then personally I'm more than fine with
> > enabling CAN-FD :-D .
> >
> > I guess Marc might have more insight where the FD issue triggered on
> > the RK3568.
>
> I will also double-check that CAN-FD still works with the v2 changes and
> wait for Marc's feedback on the CAN-FD issue before deciding whether
> RKCANFD_QUIRK_CANFD_BROKEN should stay disabled for RK3588v2.

Compile the latest https://github.com/linux-can/can-utils/ and test:

$ cangen can0 -I 2 -Li -Di -p 10 -f -g 1 -c32 -b
$ cansequence -rv can1 -f

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--vcp7brl22t3ha7yd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCakYeJQAKCRDMOmT6rpmt
0ijEAQCCAxydwZ3i3hutlhk/dlVU3grIENXTT9QhVTiaGUAU4AEAg2reTTImi5Jb
Wd8vJRDW/vzbjqvE0edXoMky/cI/Ggo=
=ZccD
-----END PGP SIGNATURE-----

--vcp7brl22t3ha7yd--
