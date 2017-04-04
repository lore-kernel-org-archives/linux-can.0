From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v3 2/4] ARM: dts: sun4i: Add can0_pins_a pinctrl settings
Date: Tue, 4 Apr 2017 17:40:55 +0200
Message-ID: <20170404154055.ccteyn3eeviciwvh@lukather>
References: <1491238814-4888-1-git-send-email-menschel.p@posteo.de>
 <1491238814-4888-3-git-send-email-menschel.p@posteo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="y6rzyeakzjypnhrf"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:36826 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754089AbdDDPlH (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 4 Apr 2017 11:41:07 -0400
Content-Disposition: inline
In-Reply-To: <1491238814-4888-3-git-send-email-menschel.p@posteo.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Patrick Menschel <menschel.p@posteo.de>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, wens@csie.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-can@vger.kernel.org


--y6rzyeakzjypnhrf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 03, 2017 at 07:00:12PM +0200, Patrick Menschel wrote:
> The A10 SoC has an on-board CAN controller. This patch adds the
> pinctrl settings for pins PH20 and PH21.
>=20
> This patch is adapted from the description in
> Documentation/devicetree/bindings/net/can/sun4i_can.txt
>=20
> Signed-off-by: Patrick Menschel <menschel.p@posteo.de>
> ---
>  arch/arm/boot/dts/sun4i-a10.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a=
10.dtsi
> index 7c559e7..f7dced4 100644
> --- a/arch/arm/boot/dts/sun4i-a10.dtsi
> +++ b/arch/arm/boot/dts/sun4i-a10.dtsi
> @@ -974,6 +974,11 @@
>  			#interrupt-cells =3D <3>;
>  			#gpio-cells =3D <3>;
> =20
> +			can0_pins_a: can0@0 {
> +				pins =3D "PH20","PH21";

You need a space after the comma here. Fixed and applied.
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--y6rzyeakzjypnhrf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJY476HAAoJEBx+YmzsjxAgYVYQAKYNFedMrmBe024DIkxiVh9y
+J+rFCauPtdI26Ltf0wlw1GzrL4G77fKW02yi2/cIcjooq2NLGMw8nI9oG9tosdR
O+eD2C1Nz2pogBXm45K/a6S5fveYkH9DxdA/m3NfQMnBxcy4hW7nlrdSU0ECrzK6
Y/r1m+0pAuRqF1EBEJSAkK+plFoG+MKm+VJLVF712zH0iN67KxixsKegNWmxvvPc
stz5Dk7chwXZgv20cGn2vhjykz70Il6wN1Cps0zZv6vfPyQR2mo0msFT1fhe8lCY
rS+76WrbU+R2LdArtL1d5LxsoTNNdakavPx2T8KwxLJAzxOkrZmNB7LpoxptkiM0
b1ZbctaGFEnqiWVcP3WLIa2opXAhxN1iEllWOdSqXvP3ilrORtz586dnoyJXFXRx
6LNO9YPiTVl7vM8YgsAyA2Tx7BkbRtqIqb7KwEV52eEdL4BpSJkO0jrldAcBQ0y+
TFrwQeWEnx204e61WExSD3N4SaBe2/pQPkLbTioVZu0b57cfVqYxwwXibo6kg3AL
OwG9x2uKbnRZx2Qgu+apCa7DoJsj9Qq3LnwKnyi6YgyDRZwhZw7/RORXsv2/MN4y
vIOJrNZWrVznn3DBOw6xlg4nZJ0A8SMukGH1gXZz30QEWqVkMx0QCTNR5TwSsAGv
qdm4bV2REr1DXYJCwN6L
=GFyb
-----END PGP SIGNATURE-----

--y6rzyeakzjypnhrf--
