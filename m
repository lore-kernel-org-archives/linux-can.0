From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 2/2] flexcan: add err interrupt for p1010rdb
Date: Fri, 20 Jun 2014 10:52:48 +0200
Message-ID: <53A3F660.4040807@pengutronix.de>
References: <1403229664-33912-1-git-send-email-B45475@freescale.com> <1403229664-33912-2-git-send-email-B45475@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="bqlora6BK4ukL71ILfLvhVwk0MwKBdXr8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40733 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933833AbaFTIxF (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 20 Jun 2014 04:53:05 -0400
In-Reply-To: <1403229664-33912-2-git-send-email-B45475@freescale.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Zhao Qiang <B45475@freescale.com>, linuxppc-dev@lists.ozlabs.org, linux-can@vger.kernel.org, wg@grandegger.com, B07421@freescale.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bqlora6BK4ukL71ILfLvhVwk0MwKBdXr8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 06/20/2014 04:01 AM, Zhao Qiang wrote:
> add err interrupt for p1010rdb into dts.
>=20
> Signed-off-by: Zhao Qiang <B45475@freescale.com>
> ---
> Changes for v2:
> 	- add binding documentation update
>=20
>  Documentation/devicetree/bindings/net/can/fsl-flexcan.txt | 7 +++++--
>  arch/powerpc/boot/dts/fsl/p1010si-post.dtsi               | 6 ++++--
>  2 files changed, 9 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt =
b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
> index 56d6cc3..81929e5 100644
> --- a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
> +++ b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
> @@ -10,7 +10,9 @@ Required properties:
>    - fsl,p1010-flexcan
> =20
>  - reg : Offset and length of the register set for this device
> -- interrupts : Interrupt tuple for this device
> +- interrupts : Interrupt tuple for this device.
> +	The first interrupt is for FlexCAN(Message Buffer and Wake Up)
> +	The second is for error(Shared with IFC, PEX1 and some other device)

The second interrupt is optional, at least on ARM we don't need it,
please reflect this in the documentation update.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--bqlora6BK4ukL71ILfLvhVwk0MwKBdXr8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlOj9mAACgkQjTAFq1RaXHMeFQCggdDcCfhAOL9ae8ae2YfmJzmY
7zcAn14d4nfeC5Lkl/wjBVM3m+d1q6MY
=+PpV
-----END PGP SIGNATURE-----

--bqlora6BK4ukL71ILfLvhVwk0MwKBdXr8--
