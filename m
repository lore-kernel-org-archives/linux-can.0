Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6240842C50A;
	Fri, 31 Jul 2026 10:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785494151; cv=none; b=bOOB7VaGDmnpPnEcLgm3LplFFUcZhg8cToddpjexeJy+7+B9d8Rl+xzaYdqn2hfYw7fkBXEruxSMzqUJi5UKR6qylxhfT9e5pIw5rJG+Fje9sHXiPxIkQrNS1sqnRf+Y/lKpL8dzQV1tHaa2w8SQVFeGWbCLuCegoOIUkii5yAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785494151; c=relaxed/simple;
	bh=3RGkOwI5i/cneGCWCG/E8yhtMkLqX/0IK8OBoqdvtpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GRLDd8w6dlOFIjxd4YkCaa6p+gXsmTKzAKDfmtLsbyf7elx1aLTKu2xjzlzckVFxW6SniLg86oNyipmLf9j2JbsQl1w4XCzkaNlUp+CeYtm7JkscQ2dej8IYrd7F8AFwwV35x7Iiu140fTGnjWg4ta7PLqXPb3jEnHl2xCQS4JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 15034200060;
	Fri, 31 Jul 2026 12:35:23 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wpkaI-002CCS-37;
	Fri, 31 Jul 2026 12:35:22 +0200
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A39C8577EF6;
	Fri, 31 Jul 2026 10:35:22 +0000 (UTC)
Date: Fri, 31 Jul 2026 12:35:22 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Cunhao Lu <1579567540@qq.com>
Cc: kernel <kernel@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	linux-can <linux-can@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-rockchip <linux-rockchip@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: Re: [PATCH v6 2/4] can: rockchip: add RK3588 CAN support
Message-ID: <20260731-precise-functional-lobster-cd779f-mkl@pengutronix.de>
References: <tencent_7BAA0052C402BFFD26291A64198084E39107@qq.com>
 <tencent_207E464D12344B3228096E23A001D6882508@qq.com>
 <20260731-tall-camouflaged-earthworm-e1a7d0-mkl@pengutronix.de>
 <tencent_A3698A465C4621E164443B0005D1CC6FAE05@qq.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cnylr377k2yewvl7"
Content-Disposition: inline
In-Reply-To: <tencent_A3698A465C4621E164443B0005D1CC6FAE05@qq.com>


--cnylr377k2yewvl7
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 2/4] can: rockchip: add RK3588 CAN support
MIME-Version: 1.0

On 31.07.2026 17:23:45, Cunhao Lu wrote:
> Hi Marc,
>
> > Can you attach the TDC to the CAN framework? See commit 5e1663810e11
> > ("can: mcp251xfd: fix TDC setting for low data bit rates"). And check if
> > CAN-FD works on the rk3588 works?
>
> Could we leave the RK3588 TDC support out of this patch series for now?

=2E.and mark the rk3588 as RKCANFD_QUIRK_CANFD_BROKEN for now? Fine with me.

> I will test whether CAN-FD works on RK3588 with TDC integrated with the
> CAN framework and report the test result. If the testing shows that it
> works, I will enable it in a separate follow-up patch.

Sounds good,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--cnylr377k2yewvl7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCamx6ZwAKCRDMOmT6rpmt
0vtOAP0UQb/GCgeUljeDGPlvGiMz5FF5kTb5taLlQIf0aMF/eAD/YqQGGpp+XdXD
XNCbZNGlV/rUCLuJOo4u6txQAqLuzgY=
=7yZ/
-----END PGP SIGNATURE-----

--cnylr377k2yewvl7--
