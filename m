From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 4/4] leds: netdev trigger: allow setting initial values
 in device tree
Date: Sun, 17 Mar 2019 20:11:50 +0100
Message-ID: <20190317191150.GA31285@amd>
References: <20190311144227.GA4404@amd>
 <20190313202615.22883-1-linux@rasmusvillemoes.dk>
 <20190313202615.22883-5-linux@rasmusvillemoes.dk>
 <20190314102911.GA15173@amd>
 <6fb71b90-1ae3-9d93-6e0c-c95e441ced7a@rasmusvillemoes.dk>
 <20190314120047.GA19072@amd>
 <2cd9c42c-1056-979f-568e-c7e387bf90c6@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2cd9c42c-1056-979f-568e-c7e387bf90c6@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-can@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-can.vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2019-03-14 14:19:42, Rasmus Villemoes wrote:
> On 14/03/2019 13.00, Pavel Machek wrote:
> linux,default-trigger from
> >=20
> > Yeah and now insert the modules for the can devices in different
> > order... May not happen in your case but will be fairly common for
> > ethernets.
>=20
> Unpredictable device names is not a problem I'm trying to solve, nor one
> that actually occurs on embedded systems. And even if one has such a
> system, one is likely running udev or similar to rename devices to
> something sane and predictable, in which case a fixed string _still_
> works fine. Or one uses udev rules to munge the netdev trigger sysfs
> files, and has applications dealing with devices appearing as banana457.
>=20
> OK, so there's of_find_net_device_by_node, so a phandle solution might
> also be possible, and might work just as well for my case. But I still
> think initializing with a fixed string is the simplest and sanest thing
> to do.

Simplest, yes. Mergeable, no. Sorry.

Udev will not help with renaming -- it runs after kernel boot, while
udev parsing is usually done before userland starts.

Plus, device tree should really describe hardware, and be usable with
other operating systems. Of course, there are exceptions, but "can0"
is unneccessarily linux-specific.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyOm/YACgkQMOfwapXb+vK53QCeIdu8vu9Fai0AxUL3FZQMEO2k
r5QAoKxdUdhvcbLSBdfF+dFwQEtFyYK5
=JKhN
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
