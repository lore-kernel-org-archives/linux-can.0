Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=116.203.23.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794486316;
	b=4g2Vjr/XXyepkMiQeI29SOj4dYTN6vaCoXX+ebaUqzhDLWoThjRRX8OuVUljFFNIVZTT
	 xuhe7ftrNNyNPX2mFZfbk50aDxL466BdxGnGsCeLWsoHcD+xkOcykykReGLviNSX0bn+S
	 kVPkzI2ZVslkWujEPZtR/Xvwb3iMknpSX+cPl8NafJbv4fM3pKdxqKR0KvAXIbgsQM4ra
	 npxvIqZseDmk+Giu038kcfnIdKSocmnJS4iAynwoj8yZrgzWV+qc8CM1Z3IsqYsbxrJFj
	 8CkRpPZaLhX7SDG4MK9QWg5zvYB1y3ptqaih4/F8LGv+VhgzfK6r+99Aaj3QN3Znhuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794486316;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=8i/uhcfxN/8zwUIkJ+0GT/xOXIEgXM4kF3JgaxZa4CE=;
	b=YgGAFFoNspRp3lZFA1DPRYex5CKuif6wci19SYlYcP7U8FTRGIk0Fb+ZKu7Prq78aR3H
	 1ep6yAUu+jTc9f6KSOgwknY/AtiVYWOFUPP06dWj8/5Zn1iMzYq2qYSKlf/e30bjfB9UK
	 1YbVwOJDupHXBnKVy6tWH6SyX43fi4y3/ACAJGligO3/dvV9S3dQC2BvJ5YhUVJFXhs3T
	 x00vhautjoNZRTHkgznPV3H64yCet3rwUDsCZdlsddOesG5koiLUvmxZEi/5hvJs9T0si
	 qyHuctLvfnyQFyMsoI0F/5gu+ZsC1GtKzwCZqftEsEfLh1f4q0bxZ3Ilq3PWAgVTWsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=blackshift.org;
	spf=pass smtp.mailfrom=blackshift.org;
	arc=none smtp.remote-ip=116.203.23.228
Received: from glittertind.blackshift.org (glittertind.blackshift.org [116.203.23.228])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2992B606A323;
	Thu, 12 Nov 2026 12:25:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2992B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackshift.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blackshift.org
Received: from bjornoya.blackshift.org (unknown [IPv6:2003:102:af17:cb00:cf3e:e168:1a5d:8293])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(Client CN "bjornoya.blackshift.org", Issuer "YR2" (not verified))
	by glittertind.blackshift.org (Postfix) with ESMTPS id C664E79E51D;
	Thu, 12 Nov 2026 12:25:06 +0000 (UTC)
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 7D3D35E9843;
	Thu, 12 Nov 2026 12:25:06 +0000 (UTC)
Date: Thu, 12 Nov 2026 13:25:05 +0100
From: Marc Kleine-Budde <mkl@blackshift.org>
To: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, 
	kernel@pengutronix.de, geert@linux-m68k.org
Subject: Re: [PATCH net-next 07/12] can: rcar_canfd: Use DT clock names in
 the probe message
Message-ID: <20261112-awesome-noisy-rottweiler-c59eef-mkl@blackshift.org>
References: <20261110115112.3807247-1-mkl@pengutronix.de>
 <20261110115112.3807247-8-mkl@pengutronix.de>
 <20261111-wise-graceful-avocet-27fa57-mkl@pengutronix.de>
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h5mwy2y6uu7ew7ro"
Content-Disposition: inline
In-Reply-To: <20261111-wise-graceful-avocet-27fa57-mkl@pengutronix.de>


--h5mwy2y6uu7ew7ro
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next 07/12] can: rcar_canfd: Use DT clock names in
 the probe message
MIME-Version: 1.0

On 11.11.2026 13:01:12, Marc Kleine-Budde wrote:
> On 10.11.2026 12:41:30, Marc Kleine-Budde wrote:
> > From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >
> > Print the DT binding clock names when reporting the selected clock at t=
he
> > end of probe. These names are part of the DT ABI, so they are stable and
> > match what users see in the device tree.
> >
> > Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > Link: https://patch.msgid.link/20261019121356.2421761-3-claudiu.beznea@=
kernel.org
> > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>
> The netdev sashiko/clashiko found a medium issue. Can you comment on it?

Upstream, i.e. netdev, will probably not merge this series, as long as
there are uncommented sashiko warnings >=3D medium.

> If you re-spin the series, take a look at the low issues, too:
>
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261110115112.380724=
7-1-mkl@pengutronix.de

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--h5mwy2y6uu7ew7ro
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCavWwHwAKCRDMOmT6rpmt
0uUzAP9MumASFw6Wk4pM+RQWQhP1oECo3SMBN/lbaJ/loPkvFQEA8d7VNAxPQkge
FKcDlMg0L2NR11mzz77hAYiiq16GPAM=
=Db55
-----END PGP SIGNATURE-----

--h5mwy2y6uu7ew7ro--
