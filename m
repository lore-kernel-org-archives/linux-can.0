Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794819760;
	b=b3d03diSDkJoqMCGLB+p0L/yaWz0YuyG4354QYGN8Kr0KKsu5WzeLx9p83KAxfSnySFJ
	 icuDNWcY2PEU7d8wS3PINNW4rYHiHgMwIqZIzZiMvMWFg5StpeO1qo8ZgFdkQVtKBFeEk
	 ok5MYCNy1on2IykQqKCSJS0fYSKHZgruURQ5YTihgJ8rTWnvKPHIO2noPyaO6XNgiz5Ea
	 JhjCo6ll3bOrUXgwXDmnLbEeLGFNop96/KKumV5oLdtDBYcUhyxKC7izH2J1YnewuCumf
	 kxkTwlDvmVXHAyivU2GCXCiX6G+UbDsnegLt0U6z8id1vkUvbDo07VcRlSrB20vVyuA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794819760;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=gSivPvFJiN/o9sHnCOQ/xSnfVG2VPNxyEl3XoLFpb1g=;
	b=nyOmiPOdchTPvA5UExC4WGk+3lP+0tulB2Deym/QgR5YNeTlgtoXro8JcV6fLpSA5wwu
	 qfzxhlUFm2peS9XeeAR4iIvoes3WwKUbLkRFRdoUNjn/LipFMFdRJ8yS1Ls0YW1ymLge6
	 R5eVTxenKRtCVcfx0JpZ5PZW/jIl8ZU1R9pmAfihB6KBnPSAl5uVB+/Mi8YVw93hr7BI0
	 80T78FYMep6L7qbrauROfyy/gfQZHpr927qBBBZ0MXKiCMoovVxih7PqnfAevRy1rdPSP
	 ATLcYSZZV86MWTSmL9Yr1Ci4nijOrMnKGbab7xLzx1yeLhkNOeXGeDHNFr3iuk5GIyg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=FsoK6+iJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478C9606A323;
	Mon, 16 Nov 2026 09:02:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 478C9606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=FsoK6+iJ
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 8357E200370;
	Mon, 16 Nov 2026 10:02:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794819756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gSivPvFJiN/o9sHnCOQ/xSnfVG2VPNxyEl3XoLFpb1g=;
	b=FsoK6+iJFwg4mS4xkKhjPs+JANZNPeRCfuU87pVQUYb2foEGASy5BN5IDA8lZEww20+/O5
	LberRih+cg0C8xWWhDRag1b1wf2gAaX8NqTb8EzAPAkvkwQ3UrgzcLlTHIKpmkhI6QaHP8
	4E2ILzm7lR7tfg60ZdIJGPYNqWoNhI0NhGkvFqKfzbNThoVk+xKEin08K6rtlaq2gxeSL9
	4iDeINjkCK/TQjtcsgNYNMyOw/0HHej44CQj04yyMuFj0Yavy2uRfX/LqlD7N036vwJA8a
	UKVCqYslY6eKmd/i2cJzHow1ygHZ9Zyut8PZCovfomEVzxvaP94Vj4i2zq14Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794819756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gSivPvFJiN/o9sHnCOQ/xSnfVG2VPNxyEl3XoLFpb1g=;
	b=ANd7Gi8YqF5qfcD6o679YCWZT2+GGVuY9454qjkbdaIX862cDFaQ0xtXea4aXoPkfl2xzY
	Qu4aj0FvdK0jWtxXo34o321VUxKQA9pes5AJxF51bkMlVQj+36S3ZXYLC6Xbdzg8MCIY9l
	Y+h9PmqxOMwaLFY0Lt/OZ573Rxha9Cy+w4zflG7o70beZJAlBPoFX7f9NqePQxMlOowI1e
	reM9rE5O8CfrADAiVRfV+VYakSG6geJWPkg2UMU8jVuQNqjc5+pm2KKQTNKBGVYi5fVJVf
	1FcQYwIBZv6rgQtJBRCNllxwpTI3iISA8B8PfqfLFTN8upxmjMYOGn8hP86SKQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794819756; a=rsa-sha256;
	cv=none;
	b=Ufuv12KJvt034y4FAmhnuQrKBnJ8N66LXUPdmYv58ubeW3Ym/2hEm8xLDuIZ5zAhlMRP1l
	XCiRKgCa+vspvudn6HR7gpzbAt8uFHlEE+wiHCeZ3mJvdLQ6YxKp+dkHxSz7stk4PoTy7U
	d30M9Tv4OxeFSVxkoPg2GAY8ETqtZi85aMi6iNt5uRf4huLXbizmkeNMATTT8Foc+w86Zs
	tw0g0ZJ/+WiHHz6mqALdo60mmG0I7+daBLYILFpQ13+uniWqp6GhzxJlVAowGypjORyuUY
	dobZ2rgnqcdLFqpSOrdqPJTpTN2dYUrgN1xd5P4OQIdEkg8nqNCOosnpbgcX2Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xSsbj-0000Ii-2t;
	Mon, 16 Nov 2026 10:02:36 +0100
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 2B7025ED070;
	Mon, 16 Nov 2026 08:54:59 +0000 (UTC)
Date: Mon, 16 Nov 2026 09:54:58 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>, 
	Harini T <harini.t@amd.com>, Michal Simek <michal.simek@amd.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, "magnus.damm" <magnus.damm@gmail.com>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, 
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: Re: RE: [PATCH can 4/4] can: rcar_canfd: rcar_canfd_probe(): reject
 devices without match data
Message-ID: <20261116-cream-hornet-from-lemuria-703c6b-mkl@pengutronix.de>
References: <20261114-fix-device_get_match_data-v1-0-2d82025e9646@pengutronix.de>
 <20261114-fix-device_get_match_data-v1-4-2d82025e9646@pengutronix.de>
 <TYYPR01MB660340F5E219C29045BF61F9867C2@TYYPR01MB6603.jpnprd01.prod.outlook.com>
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
	protocol="application/pgp-signature"; boundary="cr5iuyzxl6tekon4"
Content-Disposition: inline
In-Reply-To: <TYYPR01MB660340F5E219C29045BF61F9867C2@TYYPR01MB6603.jpnprd01.prod.outlook.com>


--cr5iuyzxl6tekon4
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: RE: [PATCH can 4/4] can: rcar_canfd: rcar_canfd_probe(): reject
 devices without match data
MIME-Version: 1.0

On 16.11.2026 08:39:36, Biju Das wrote:
> Hi Marc,
>
> > -----Original Message-----
> > From: linux-arm-kernel <linux-arm-kernel-bounces@lists.infradead.org> O=
n Behalf Of Marc Kleine-Budde
> > Sent: 14 November 2026 12:56
> > Subject: [PATCH can 4/4] can: rcar_canfd: rcar_canfd_probe(): reject de=
vices without match data
> >
> > A device bound through driver_override need not match an entry in of_ma=
tch_table. In that case
> > device_get_match_data() returns NULL, but
> > rcar_canfd_probe() dereferences the result.
> >
> > Reject devices without match data before continuing probe.
> >
> > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > ---
> >  drivers/net/can/rcar/rcar_canfd.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/r=
car_canfd.c
> > index 000a6433f46d..9d463a9c1766 100644
> > --- a/drivers/net/can/rcar/rcar_canfd.c
> > +++ b/drivers/net/can/rcar/rcar_canfd.c
> > @@ -2113,6 +2113,8 @@ static int rcar_canfd_probe(struct platform_devic=
e *pdev)
> >  	int i;
> >
> >  	info =3D of_device_get_match_data(dev);
> > +	if (!info)
> > +		return -ENODEV;
>
>
> There is a patch on the fly to disable driver_override by default [1].
> In that case if we plan to use driver_override, probe will return failure.
> I may be wrong. Please correct me if Iam wrong
>
> [1] https://lore.kernel.org/all/0f7446324f6a0c8f0153d6532d92a6eeecd6a308.=
1790612298.git.u.kleine-koenig@baylibre.com/

Thanks, I wasn't aware of this series. I tested the driver_override on
the flexcan driver with latest net/main, fixed it, and applied the fix
to all affected CAN drivers.

Should I drop the driver_override related null pointer checks from this
series?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--cr5iuyzxl6tekon4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCavrE4AAKCRDMOmT6rpmt
0qa7AP9N2WlxewGrUbH+Kiiv8Q4GOrtgxpFu7tkpLBsyZsuKcQEAoN9crIRmBX03
Gt9CkTyuqbyZzD3GTXYfNRjIC+54JAE=
=oW/X
-----END PGP SIGNATURE-----

--cr5iuyzxl6tekon4--
