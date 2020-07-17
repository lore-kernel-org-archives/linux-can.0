From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 14/20] dt-bindings: spi: renesas,sh-msiof: Add r8a774e1
 support
Date: Fri, 17 Jul 2020 13:22:09 +0100
Message-ID: <20200717122209.GF4316@sirena.org.uk>
References: <1594811350-14066-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1594811350-14066-15-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200717115915.GD4316@sirena.org.uk>
 <CA+V-a8sxtan=8NCpEryT9NzOqkPRyQBa-ozYNHvi8goaOJQ24w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3yNHWXBV/QO9xKNm"
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CA+V-a8sxtan=8NCpEryT9NzOqkPRyQBa-ozYNHvi8goaOJQ24w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Lad, Prabhakar" <prabhakar.csengg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>, Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, Jakub Kicinski <kuba-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Niklas <niklas.soderlund-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Wim Van Sebroeck <wim-Q8PRGTgFL9WUCWQAtAn6Ix2eb7JE58TQ@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Amit Kucheria <amit.kucheria-LY4KaoCqKrnby3iVrkZq2A@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-can.vger.kernel.org


--3yNHWXBV/QO9xKNm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 17, 2020 at 01:15:13PM +0100, Lad, Prabhakar wrote:
> On Fri, Jul 17, 2020 at 12:59 PM Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> > On Wed, Jul 15, 2020 at 12:09:04PM +0100, Lad Prabhakar wrote:
> > > Document RZ/G2H (R8A774E1) SoC bindings.

> > Please in future could you split things like this up into per subsystem
> > serieses?  That's a more normal approach and avoids the huge threads and
> > CC lists.

> Sorry for doing this, In future I shall keep that in mind. (Wanted to
> get in most patches for RZ/G2H in V5.9 window)

If anything sending things as a big series touching lots of subsystems
can slow things down as people figure out dependencies and who's going
to actually apply things.

--3yNHWXBV/QO9xKNm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8Rl/AACgkQJNaLcl1U
h9DhTAgAgzuxfwIeWNm0FDyt+K9Mfz5di6xytCvItNaaahcI/Ct9HEQCGPpgG+SN
OegozumTbxf+HvdgEgg2JsMqKfoCid7/F/M/ywb24/SqHnpgIIKBA7U6bRF2PGMW
JHXG/oHSBd5yyV6xurj6YfaJidh9KJO5afRb8yisffI8ge1n+X7F2GQZyWke45cp
Ojag6elp7xYrRwC3ylAp2exRsoSw5SXYwqM4CNkrDEiXq1dKeePsm2vuxf6FmE4n
WclrCd+/9oWAk7dIoJTBX4BxBudcZlk25Y55Q6GyA/bbGMBWef1vWvUNasjQef0d
e/mSTsDdN+0RD9lg1rJ0RqtyHnDPhw==
=mPyM
-----END PGP SIGNATURE-----

--3yNHWXBV/QO9xKNm--
