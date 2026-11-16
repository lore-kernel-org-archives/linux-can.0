Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794828293;
	b=BUC3caCIQ9M5eg7YdeonESl26TC2VCCpSLtpNc3MkkH0dNCVek5hdwwWh/EN26U+W0hM
	 yxp10W0UKmsYnTz/S7GYHDBebUtPKW1QYH7oUAB8djiEhcdpBynt6yafTHFxVXM2opoQ6
	 ZCIzX5t1dZesSdunwVemRJ8r1EIdLNDRrRhvcIBtT5Ia5xPybd7INR3MhrfnLB0bCbir9
	 zxPrb2TsdSzsEQuUrTNJtuCaYe8dR1GIlBr12RYPwmLh8xJ1dlVapLYScbF2c8fdVaH/b
	 iHpXYNGYPwKxF0B/gEPrdp+qsR+nO6r46N2bukR4kTFI3ty12lIdFMBYJP2i2qBk1vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794828293;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=/G0OBqYYq6xIWzjTU/6NWOOkjhYFeYVJ9RAPumwh/FM=;
	b=tma4yISBh0oz579BVbktUweiQPsiV9LHSzcVEiS/felTQ3z7HYAtftufWf7wLuTgnjiU
	 cLCVY2HOvkxoZ5tpU4PJfgdJTwq5B4JdSgwpDNpFfmR0bBeuDAPEYQHWln3ylLhmDQm5w
	 NGZWOD+/bjNHCcUZflA9k4zhqE8FtrcIQRWEX6tbsI2egRjBIV6uNqas6o0q+cmKyOyjc
	 9Vy1Z+wbehwu8wg8hqcogqGZTwKiWndkB1Rj4/I/EB32xnzinvHg/GjZEMd7nZ/96Q0d5
	 THVNvUZflqoxhcO4HKouiPXeDFt2MtQdMKVxoAZS0ytJ4Li9cQYYD2CMFeIegh8Umww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VGuOCjnJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 2EDD2606A339;
	Mon, 16 Nov 2026 11:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VGuOCjnJ
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 2C7311F000C4;
	Mon, 16 Nov 2026 11:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794828292;
	bh=/G0OBqYYq6xIWzjTU/6NWOOkjhYFeYVJ9RAPumwh/FM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VGuOCjnJRgL4l8T0yyJl+XIlzd2n9c4XWgneQU03EGq1tXs5HJFurQ7wV+9mTv0eA
	 sIoZHG8uG7Cis89p0AyQ+tyWD0JmQFW42EyFJN2L3pclB46cRqyDMtO32K5QV+uIZh
	 mdL/sRAdJWya3ZcTa9cPlilrSbGYxEbnkgmnYaKZ44abJMxpDpnyWNT0jzZCl1gY48
	 HE6ALwNmXjCTQHN1rKuP8rZ4M2dy2YIY9yNTlTLwsB39YozcnCyB3wyL6WvCg1WTJr
	 kRUC8idgaWRdWfS9RfoOQurQ/GLS549ATH8vRtQVkLCqdSM25wCH8sjmlkuiUYFJSj
	 Sc0PuCxZaziQg==
Date: Mon, 16 Nov 2026 12:24:50 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
	Biju Das <biju.das.jz@bp.renesas.com>
Cc: Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>, 
	Harini T <harini.t@amd.com>, Michal Simek <michal.simek@amd.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, "magnus.damm" <magnus.damm@gmail.com>, 
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH can 4/4] can: rcar_canfd: rcar_canfd_probe(): reject
 devices without match data
Message-ID: <avrnzDmTgdpK9jQQ@monoceros>
References: <20261114-fix-device_get_match_data-v1-0-2d82025e9646@pengutronix.de>
 <20261114-fix-device_get_match_data-v1-4-2d82025e9646@pengutronix.de>
 <TYYPR01MB660340F5E219C29045BF61F9867C2@TYYPR01MB6603.jpnprd01.prod.outlook.com>
 <20261116-cream-hornet-from-lemuria-703c6b-mkl@pengutronix.de>
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
	protocol="application/pgp-signature"; boundary="i5ob7g33zo25fx6g"
Content-Disposition: inline
In-Reply-To: <20261116-cream-hornet-from-lemuria-703c6b-mkl@pengutronix.de>


--i5ob7g33zo25fx6g
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can 4/4] can: rcar_canfd: rcar_canfd_probe(): reject
 devices without match data
MIME-Version: 1.0

On Mon, Nov 16, 2026 at 09:54:58AM +0100, Marc Kleine-Budde wrote:
> On 16.11.2026 08:39:36, Biju Das wrote:
> > Hi Marc,
> >
> > > -----Original Message-----
> > > From: linux-arm-kernel <linux-arm-kernel-bounces@lists.infradead.org>=
 On Behalf Of Marc Kleine-Budde
> > > Sent: 14 November 2026 12:56
> > > Subject: [PATCH can 4/4] can: rcar_canfd: rcar_canfd_probe(): reject =
devices without match data
> > >
> > > A device bound through driver_override need not match an entry in of_=
match_table. In that case
> > > device_get_match_data() returns NULL, but
> > > rcar_canfd_probe() dereferences the result.
> > >
> > > Reject devices without match data before continuing probe.
> > >
> > > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > > ---
> > >  drivers/net/can/rcar/rcar_canfd.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar=
/rcar_canfd.c
> > > index 000a6433f46d..9d463a9c1766 100644
> > > --- a/drivers/net/can/rcar/rcar_canfd.c
> > > +++ b/drivers/net/can/rcar/rcar_canfd.c
> > > @@ -2113,6 +2113,8 @@ static int rcar_canfd_probe(struct platform_dev=
ice *pdev)
> > >  	int i;
> > >
> > >  	info =3D of_device_get_match_data(dev);
> > > +	if (!info)
> > > +		return -ENODEV;
> >
> >
> > There is a patch on the fly to disable driver_override by default [1].
> > In that case if we plan to use driver_override, probe will return failu=
re.
> > I may be wrong. Please correct me if Iam wrong
> >
> > [1] https://lore.kernel.org/all/0f7446324f6a0c8f0153d6532d92a6eeecd6a30=
8.1790612298.git.u.kleine-koenig@baylibre.com/
>=20
> Thanks, I wasn't aware of this series. I tested the driver_override on
> the flexcan driver with latest net/main, fixed it, and applied the fix
> to all affected CAN drivers.
>=20
> Should I drop the driver_override related null pointer checks from this
> series?

IMHO yes.

I just sent out a new revision of the change, find it at
https://lore.kernel.org/all/20261116110853.3418077-2-u.kleine-koenig@baylib=
re.com/
as I failed to add you Cc.

Best regards
Uwe

--i5ob7g33zo25fx6g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmr65/8ACgkQj4D7WH0S
/k7QDggAiTmuQNmh8+yNOaWxYwM2xqEF7KXcta6Zhrr5tw9dbPFOi1591HFVqoXF
b+PrVbmxgaxpRIc2JJd+193U26DHWtmbSfZuJp16XUGreT3qZif3XIPXQItdHKX9
iEfgiclP6EXqPncKeNY98MlLkT44xrcXxKHOuINAw5pmHD43QZLVMoNul9vvxHzp
NjcRoO6YYv1alrkzDiCNghiXGFcIbB6NRSvcLg3pF8S+js6tyKC7yGPedHI22ul1
0jPhDkdWfYmpFS8Mp6O9JkWZOAq07GnaQrOb9PfuT6R8hrsdL6SWg3Tcrj059/mu
NIUb+nPT//FTZ9tIRjdXrU3JjDhlnA==
=9hPs
-----END PGP SIGNATURE-----

--i5ob7g33zo25fx6g--
