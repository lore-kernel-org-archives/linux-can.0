Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792652452;
	b=42zoYs1OF1GcLR6Nv1NBzw52cxAKjnDrYlhH5q8GVWPHjmjc3wFZ4gg/t3V6NNhAf3lB
	 XiTrTYLqocpbvOtJiF7JDhKgYcdqJUpYkvsfRYkkI/UOMCy3kAKczAWZTafb/jyBfh8PK
	 5Biz2GmnSfi2BMvApNj8F8UJa9UwOyCD7gcvBCSAxgWy1wlLRz3tez3mflhhBqb7hINmX
	 5SyWWbskcTSIXeFIo23kMQcFhKCwTIBX2r6cgaD366r8rVGJFN+dDyhwC9OgH+OhvIqtS
	 17nNQXFs++uEgOjVKxgYWLL7fdaruQMMrdxZXeAzE/FNQiSGd3C1L2NOYSb/V0//r1w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792652452;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=g5nsSSjuBClHBx39NqG0kfSc5pljRc11IezXCRfp1Ic=;
	b=x5aFtYQ6LxMwrTWmW3XvgOwrlTyxEBq1eDMKvyqN/4qBicvWyngjJQ6N2Oo4wnNfHvFI
	 IZEa3bWAqh65uCDiTf8irsmOUUahRHJH3Q6ap+5lZuwfF0Vb5RNWe2diroWiS7dVgwNKt
	 bs18J5qiNHQWc9NDjkl9Oi6p1CxvjcyXmjH5xN1Qrm8ko3wgOyu7pTGLoWUjxBlGu5Udd
	 gsmbtFVAya93BS/kQgpkEHE8tVf21enWN3wUmOet/AS55k7Z0xjKmhoBmKzJbXrWPwxmk
	 T3VczgXMcPE9mrWR/vhTPzI89dGJ6GmI2RRSuGBQnVMWiIpkVoESjbp4d9F5KNdm4Bw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=geXRJp1J;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40535606A319;
	Thu, 22 Oct 2026 07:00:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40535606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=geXRJp1J
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id C90AF2008E4;
	Thu, 22 Oct 2026 09:00:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792652447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g5nsSSjuBClHBx39NqG0kfSc5pljRc11IezXCRfp1Ic=;
	b=geXRJp1Jol3L9poDopu0R8VUKm/mRkb0evBpWIFUaXBiM3QyihnCPf5jnAQc+qeQZCPKWc
	xrr1kvIl8Ent5lGr7y0+LEacoNBiClHFhWoVE1q29HaCl5pJOQ9U1SwgNy5RD0/FRlnshp
	Jj0HEkilTLBMN8sf87/hlOwRQCBWowI5DfilxOYkrotCNCUBz6F/TCCLJIHT2ClkVGkie/
	a/oWZStpy2ktHmF5fw1XsV0+wtfw45Yeaho9MW7r3+ygs9fQMTHj+tuUo/TB2cnEM0ye4e
	h5amPe4kcHfIA35an2va+G4kchRWloI1i1w0E3rBqGLftgv5hG7UW6ASzNrDEg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792652447; a=rsa-sha256;
	cv=none;
	b=Cq6ACqQO3tLU849Qwl3nlOozR7OGPfVWKC2GnLc1JqK30uZQ1T1RdabasaJwDdU3EgHTzg
	Jfg8HlwVwm7QQrVOxKTYwDUuruI0MyaSoEGs+Vj7PiyTb1bT4QLWzA/QxsTkYIP/zs6gzk
	1hoaNX3uyTHu0UFqE3dL+sF/1DshnSBLFrAI3+E2j7JpBG7p1e/IoD9XhQs+d6rdwnmgSH
	ERRRrBke0W/AQC0kM+mTZlldEMhV+ccNCKf/AgCp60LkGUtvxfosw94CtUsTgMbTn2bedb
	RKEWJ9FPTnt+uGYJIEKcWPU3mEw5rzokEnm0MBvFopOyhdnZ7/Con9LVwU23Bw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792652447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g5nsSSjuBClHBx39NqG0kfSc5pljRc11IezXCRfp1Ic=;
	b=SZwHrfPsuL99dHZQZL0piMR04UZJoEuler4kCfiAQlbnX0NHp67TtQYo1d9wC7h7dTRUFw
	3qq4vLc4f0wBFa7iDv3NQy5t2LiW3MH6NJUfBCZr305HC9lNxjDCHDrpY8CmRGLVVqwuKW
	w8kijStDsPVSNG5wEWsk/lkyl3wJrAxnYDDynwQJLIyriVOmVvfrZEPJfgSNGkGfzbdZpT
	7WtMkKYvQH/fRSkSqk6eHApbSEeX8zKhHTOhw8zWzvC8d58yRG7HR2wLoOGLGCMp65yWpU
	Qp2Ysiv1/Cib4qbxisi4P8+qUYrWLGrpGfHsjFlOlPducLFxPFiPqPBkjqNBkg==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xJmn9-000fOB-2L;
	Thu, 22 Oct 2026 09:00:47 +0200
Received: from pengutronix.de (unknown [IPv6:2a0a:edc0:0:701:97f1:546b:5b0f:c991])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 349905D0AA8;
	Thu, 22 Oct 2026 07:00:47 +0000 (UTC)
Date: Thu, 22 Oct 2026 09:00:46 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: "Kumar, Udit" <u-kumar1@ti.com>
Cc: vigneshr@ti.com, gehariprasath@ti.com, rcsekar@samsung.com, 
	mailhol.vincent@wanadoo.fr, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, msp@baylibre.com
Subject: Re: [PATCH] can: m_can: Implement workaround for errata i2278 and
 i2279
Message-ID: <20261022-spiked-pigeon-from-mars-3f2786-mkl@pengutronix.de>
References: <20260514065511.3573223-1-a-dutta@ti.com>
 <20260514-tiny-koel-of-order-65ade7-mkl@pengutronix.de>
 <9787fdc5-8a51-4567-a576-a3b9f4fcc59d@ti.com>
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
	protocol="application/pgp-signature"; boundary="ghmookne3nuwdo2i"
Content-Disposition: inline
In-Reply-To: <9787fdc5-8a51-4567-a576-a3b9f4fcc59d@ti.com>


--ghmookne3nuwdo2i
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: m_can: Implement workaround for errata i2278 and
 i2279
MIME-Version: 1.0

On 22.10.2026 08:49:22, Kumar, Udit wrote:
> > The latest Bosch m_can documentation doesn't mention this problem,
> > neither the TCAN4550 docs. Can this be an integration problem of the SoC
> > on TI's side?

> this is similar to Errata 22 from Bosch
> Message order inversion when transmitting from dedicated Tx Buffers
> configured with same Message ID.
> page-29, release doc REL20210625

Can you give me a link to the Bosch Errata sheet? Do you know if TI's
tcan4x5x is affected by the erratum?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ghmookne3nuwdo2i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCatm0mgAKCRDMOmT6rpmt
0uubAQDF6lnULptj1zzExy4g0Yco4kYq7xT6SwW02f0gkeWykwEA0ZAB6twIeieA
3RKf/U9c++yRfGVNGdDw0R/ESFWFLAY=
=Dr6A
-----END PGP SIGNATURE-----

--ghmookne3nuwdo2i--
