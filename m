From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 2/2] flexcan: add err interrupt for p1010rdb
Date: Thu, 19 Jun 2014 10:28:52 +0200
Message-ID: <53A29F44.3020806@pengutronix.de>
References: <1403163973-48239-1-git-send-email-B45475@freescale.com> <1403163973-48239-2-git-send-email-B45475@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="P6plu1rWV2MRkJ6Q3x3mIGmtEHscfWpQk"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50554 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757535AbaFSI27 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 19 Jun 2014 04:28:59 -0400
In-Reply-To: <1403163973-48239-2-git-send-email-B45475@freescale.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Zhao Qiang <B45475@freescale.com>, linuxppc-dev@lists.ozlabs.org, linux-can@vger.kernel.org, wg@grandegger.com, B07421@freescale.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--P6plu1rWV2MRkJ6Q3x3mIGmtEHscfWpQk
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 06/19/2014 09:46 AM, Zhao Qiang wrote:
> add err interrupt for p1010rdb into dts.

Please update the flexcan binding documentation, too.

Marc

>=20
> Signed-off-by: Zhao Qiang <B45475@freescale.com>
> ---
>  arch/powerpc/boot/dts/fsl/p1010si-post.dtsi | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/boot/dts/fsl/p1010si-post.dtsi b/arch/powerpc=
/boot/dts/fsl/p1010si-post.dtsi
> index 4313ff6..bcd95ba 100644
> --- a/arch/powerpc/boot/dts/fsl/p1010si-post.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/p1010si-post.dtsi
> @@ -141,13 +141,15 @@
>  	can0: can@1c000 {
>  		compatible =3D "fsl,p1010-flexcan";
>  		reg =3D <0x1c000 0x1000>;
> -		interrupts =3D <48 0x2 0 0>;
> +		interrupts =3D <48 0x2 0 0
> +			      16 0x2 0 0>;
>  	};
> =20
>  	can1: can@1d000 {
>  		compatible =3D "fsl,p1010-flexcan";
>  		reg =3D <0x1d000 0x1000>;
> -		interrupts =3D <61 0x2 0 0>;
> +		interrupts =3D <61 0x2 0 0
> +			      16 0x2 0 0>;
>  	};
> =20
>  	L2: l2-cache-controller@20000 {
>=20


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--P6plu1rWV2MRkJ6Q3x3mIGmtEHscfWpQk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlOin0QACgkQjTAFq1RaXHMqgACfR61Svvvui3htliIOxNe851uP
GLMAmwTwfBp/ZGP9vTMDX3dblPA1TCz6
=Or2S
-----END PGP SIGNATURE-----

--P6plu1rWV2MRkJ6Q3x3mIGmtEHscfWpQk--
