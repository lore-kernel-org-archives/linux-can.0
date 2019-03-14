From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 4/4] leds: netdev trigger: allow setting initial values
 in device tree
Date: Thu, 14 Mar 2019 13:00:47 +0100
Message-ID: <20190314120047.GA19072@amd>
References: <20190311144227.GA4404@amd>
 <20190313202615.22883-1-linux@rasmusvillemoes.dk>
 <20190313202615.22883-5-linux@rasmusvillemoes.dk>
 <20190314102911.GA15173@amd>
 <6fb71b90-1ae3-9d93-6e0c-c95e441ced7a@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6fb71b90-1ae3-9d93-6e0c-c95e441ced7a@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-can@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-can.vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2019-03-14 12:26:38, Rasmus Villemoes wrote:
> On 14/03/2019 11.29, Pavel Machek wrote:
> > On Wed 2019-03-13 21:26:15, Rasmus Villemoes wrote:
> >> It can be quite convenient to initialize a netdev-triggered LED with a
> >> device name and setting the rx,tx,link properties from device tree,
> >> instead of having to do that in an init script in userspace.
> >>
> >> +                The optional child node netdev can be used to
> >> +                configure initial values for the link, rx, tx and
> >> +                device_name properties. For example, setting
> >> +                linux,default-trigger =3D "netdev" and adding the chi=
ld
> >> +                node
> >> +
> >> +                netdev {
> >> +                    rx;
> >> +                    tx;
> >> +                    link;
> >> +                    device-name =3D "can0";
> >> +                };
> >> +
> >> +                can be used to replace 'linux,default-trigger =3D
> >> +                "can0-rxtx"' that relies on the deprecated
> >> +                CONFIG_CAN_LEDS.
> >=20
> > I'm sorry, but no, not like this. I see it works for you, only having
> > single can device, but it would quickly break with two of them and two
> > ethernets are rather common.
> >=20
> > So this will need to be device =3D <&phandle_of_ethernet_device> or
> > something like that. There may be example with usb port triggers.
>=20
> Huh? I have two CAN devices, and there are two LEDs on the front panel
> labeled CAN-A and CAN-B; my device tree nodes for that are
=2E..
> and this works just fine. The only change from the old DT is the
> addition of the netdev nodes and changing linux,default-trigger from
> "can0-rxtx", "can1-rxtx" to both "netdev".

Yeah and now insert the modules for the can devices in different
order... May not happen in your case but will be fairly common for
ethernets.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyKQm8ACgkQMOfwapXb+vI2kgCeI4eLitwds68MutQltj+a4klK
xT0An1vLH+H/RtsLkTkIb2mBueNE1jsi
=BBl1
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
