From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v3 4/4] ARM: dts: sun7i: Add can0_pins_a pinctrl settings
Date: Tue, 4 Apr 2017 17:43:04 +0200
Message-ID: <20170404154304.7vgqx3jbkfm3n5lt@lukather>
References: <1491238814-4888-1-git-send-email-menschel.p@posteo.de>
 <1491238814-4888-5-git-send-email-menschel.p@posteo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pqn6mwmliho32pua"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1491238814-4888-5-git-send-email-menschel.p-1KBjaw7Xf1+zQB+pC5nmwQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Patrick Menschel <menschel.p-1KBjaw7Xf1+zQB+pC5nmwQ@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-can.vger.kernel.org


--pqn6mwmliho32pua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 03, 2017 at 07:00:14PM +0200, Patrick Menschel wrote:
> The A20 SoC has an on-board CAN controller. This patch adds
> the pinctrl settings for pins PH20 and PH21.
>=20
> This patch is adapted from the description in
> Documentation/devicetree/bindings/net/can/sun4i_can.txt
>=20
> Signed-off-by: Patrick Menschel <menschel.p-1KBjaw7Xf1+zQB+pC5nmwQ@public.gmane.org>
> ---
>  arch/arm/boot/dts/sun7i-a20.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a=
20.dtsi
> index c637e10..8536caf 100644
> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> @@ -1096,6 +1096,11 @@
>  			#interrupt-cells =3D <3>;
>  			#gpio-cells =3D <3>;
> =20
> +			can0_pins_a: can0@0 {
> +				pins =3D "PH20","PH21";

Same thing here, you need a space after that comma. I've fixed it and
applied the patch.

Thanks!
Maxime
--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--pqn6mwmliho32pua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJY478IAAoJEBx+YmzsjxAgvgwQALA63j9K9rwoQxX1yDHPq/Zi
WnVQMIDI1Oy7FTfuW5Z0R3tFMrFF5BvU/ARmksbypDIPhm1NCS/a0f2e9M9XmuaM
LGW6RbvSOEJ9qn7CmNNY8RSeHF203KH9QbC9JCMScTq/+Z3YedHAhZwRVM+45U9j
+pvkvIb+WM7v8FSCrBXwn8suCh/9jzgoBABYOovrzB3UCZuykzSGh09ItxFruh3A
i6RV5bM1uNofb6aJy5PZ1gffiiaGI/L6eHb1/tE/X/298JgIn6J5rs0SrpcbT9il
SIKWPrPeVSFgo6qqiEIH97Ktf8VdXP6xJisB8NR1SZ916EtujV9h7NJjub+MNtSg
uiH0PNsGzYbkzvbHyj01RVSQ9LOGX+GxtzzWH8PqHFFjefhrCK0LZJXD20t0ReUX
dMOmnUqqDXUIKiv4CVk0p4U4KPtnFaKVc1/OHGnuXxHIK58Xp16tcjKq8tXpXp5D
TlhOInqEb4lzt0zsQp/ZKyHkKZC3t/BK/oLmBzN7O796kLkwPbx67ncRH6/3+TsL
RiXI5nU7mu0w5PuOudGpvLxBVb/nOX3XeFEdVh/dskVNtHQAIsSzpO8y6Fhyc2UM
DX6ZJZFpbJ5S2w1RkjqvVWCGIzoalThHMfJrmmipT1AB3TRR+vdNwmCzI/scwwKF
QQh+LTXWpx4aKdKRHolw
=fU2Q
-----END PGP SIGNATURE-----

--pqn6mwmliho32pua--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
