From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 4/4] leds: netdev trigger: allow setting initial values
 in device tree
Date: Thu, 14 Mar 2019 11:29:11 +0100
Message-ID: <20190314102911.GA15173@amd>
References: <20190311144227.GA4404@amd>
 <20190313202615.22883-1-linux@rasmusvillemoes.dk>
 <20190313202615.22883-5-linux@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190313202615.22883-5-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-can@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-can.vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2019-03-13 21:26:15, Rasmus Villemoes wrote:
> It can be quite convenient to initialize a netdev-triggered LED with a
> device name and setting the rx,tx,link properties from device tree,
> instead of having to do that in an init script in userspace.
>=20
> My main motivation for this is to be able to switch away from the
> deprecated CONFIG_CAN_LEDS, so add an example based on that and add a
> pointer in the net/can/Kconfig file.
>=20
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  .../devicetree/bindings/leds/common.txt       | 17 ++++++++++
>  drivers/leds/trigger/ledtrig-netdev.c         | 31 +++++++++++++++++++
>  drivers/net/can/Kconfig                       |  3 +-
>  3 files changed, 50 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/leds/common.txt b/Document=
ation/devicetree/bindings/leds/common.txt
> index 7cb88460a47c..4f3a97e73417 100644
> --- a/Documentation/devicetree/bindings/leds/common.txt
> +++ b/Documentation/devicetree/bindings/leds/common.txt
> @@ -43,6 +43,23 @@ Optional properties for child nodes:
>                  Documentation/ABI/testing/sysfs-class-led-trigger-netdev)
>                  to reflect the state and activity of a net device.
> =20
> +                The optional child node netdev can be used to
> +                configure initial values for the link, rx, tx and
> +                device_name properties. For example, setting
> +                linux,default-trigger =3D "netdev" and adding the child
> +                node
> +
> +                netdev {
> +                    rx;
> +                    tx;
> +                    link;
> +                    device-name =3D "can0";
> +                };
> +
> +                can be used to replace 'linux,default-trigger =3D
> +                "can0-rxtx"' that relies on the deprecated
> +                CONFIG_CAN_LEDS.

I'm sorry, but no, not like this. I see it works for you, only having
single can device, but it would quickly break with two of them and two
ethernets are rather common.

So this will need to be device =3D <&phandle_of_ethernet_device> or
something like that. There may be example with usb port triggers.

Thanks,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyKLPcACgkQMOfwapXb+vLlNgCfc3mopLHDPlDR1GQfE7Nv1dpU
d0UAoJmgtJ2Wlbcb8+a2niNEHhkyAXXo
=xX3T
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
