From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [PATCH v4 2/6] dt-bindings: net: can: binding for CTU CAN FD
 open-source IP core.
Date: Tue, 4 Aug 2020 11:18:17 +0200
Message-ID: <20200804091817.yuf6s26bclehpwwi@duo.ucw.cz>
References: <cover.1596408856.git.pisa@cmp.felk.cvut.cz>
 <701442883f2b439637ff84544745725bdee7bcf8.1596408856.git.pisa@cmp.felk.cvut.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="kyw4twhhtai4pjwf"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <701442883f2b439637ff84544745725bdee7bcf8.1596408856.git.pisa-/N2ztlQkxE7Ub/6JBqosbQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: pisa-/N2ztlQkxE7Ub/6JBqosbQ@public.gmane.org
Cc: linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, socketcan-fJ+pQTUTwRTk1uMJSBkQmQ@public.gmane.org, wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, c.emde-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org, armbru-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, martin.jerabek01-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, ondrej.ille-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jnovak-jQs2MHkdoM/twjQa/ONI9g@public.gmane.org, jara.beran-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, porazil-hnFyeMMZ0rvQT0dZR+AlfA@public.gmane.org
List-Id: linux-can.vger.kernel.org


--kyw4twhhtai4pjwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> The commit text again to make checkpatch happy.

?


> +    oneOf:
> +      - items:
> +          - const: ctu,ctucanfd
> +          - const: ctu,canfd-2
> +      - const: ctu,ctucanfd

For consistency, can we have ctu,canfd-1, ctu,canfd-2?

Best regards,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--kyw4twhhtai4pjwf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXykn2QAKCRAw5/Bqldv6
8kYCAJ4jA/qIYWq2pUyjiAJ/fOhTarpq6wCgxLuE0RfCV4mrqnFOk1DXh6CugEU=
=4PoT
-----END PGP SIGNATURE-----

--kyw4twhhtai4pjwf--
