Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87FC43BDDE;
	Mon, 17 Aug 2026 16:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786983792; cv=none; b=fa66uLQk5+6d5Tu+arZyM7antv6rLVHGz54FqrQD47gXx5AYVYd2Cg5hLMAkw54QimaZVaPB2eRanmbYRHS/15uUgnLa6IQ+jRIELIjJ3+9sWCU4T+Uk3JufbTygGldPydq8W+AT3aSDd+ij9XHlaAaKnAUfJTFPvYZyKhW5vRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786983792; c=relaxed/simple;
	bh=W2rwiI0p1PvB/EiVI5SngxFzf3q1kEaDT6oNx8aga5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=newCrub6pnxk1/sbwwJDPIMCbzxyNqt/qNJZ626+1OW3KetjSZOgfbqU63AW8GDCtefFxn8fQrp/rBg+o6VrRlzxfXeD+ptdeVRYD0PlCyoRjKM+XimjQzCBx8yp9ZO6DTmyUH1RarVDf/N2tH2/r5lYXBMDliWh6HqFttLrzS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id A1B6A2006B4;
	Mon, 17 Aug 2026 18:23:03 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ww075-001z6I-1m;
	Mon, 17 Aug 2026 18:23:03 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 35B3B584E00;
	Mon, 17 Aug 2026 16:23:03 +0000 (UTC)
Date: Mon, 17 Aug 2026 18:23:03 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Cunhao Lu <1579567540@qq.com>
Cc: kernel@pengutronix.de, Vincent Mailhol <mailhol@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, linux-can@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, Heiko Stuebner <heiko.stuebner@cherry.de>, 
	Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH v6 0/4] can: rockchip: add RK3588 CAN support
Message-ID: <20260817-guillemot-of-premium-saturation-6b893d-mkl@pengutronix.de>
References: <tencent_7BAA0052C402BFFD26291A64198084E39107@qq.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ma3cqweawtb2547h"
Content-Disposition: inline
In-Reply-To: <tencent_7BAA0052C402BFFD26291A64198084E39107@qq.com>


--ma3cqweawtb2547h
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 0/4] can: rockchip: add RK3588 CAN support
MIME-Version: 1.0

On 30.07.2026 22:34:01, Cunhao Lu wrote:
> Add support for the RK3588 CAN controller.
>
> RK3588 integrates three CAN-FD controllers that are closely related to
> the existing Rockchip CAN-FD IP already supported in the kernel. The
> RK3588 variant is not fully compatible with RK3568v2 because the RX
> FIFO count register field has a different layout.
>
> This series therefore:
>
> - extends the existing Rockchip CAN-FD binding with the
>   rockchip,rk3588-canfd compatible
> - adds a dedicated RK3588 match entry and devtype in the driver

I'll take the first 2 patches.

> - describes the three CAN controller nodes in rk3588-base.dtsi
> - enables CAN on the RK3588 Tiger Haikou board

The DT changes should probably go via the rockchip tree.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ma3cqweawtb2547h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCaoM1ZAAKCRDMOmT6rpmt
0izZAP4x4ZKMEz+dpfqacmemKCSyinUbnvUl0Sg46rKIkBXK8QD+PQDTtFldoneP
iYloyriCSVEzhFRqYdTN9pM8op98WwU=
=3CzL
-----END PGP SIGNATURE-----

--ma3cqweawtb2547h--
