From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 2/3] can: ti_hecc: Add TI HECC DT binding documentation
Date: Mon, 12 Oct 2015 11:50:02 +0200
Message-ID: <561B824A.3080003@pengutronix.de>
References: <1443988779-19935-1-git-send-email-anton.a.glukhov@gmail.com>
 <1443988779-19935-2-git-send-email-anton.a.glukhov@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Uhc2HdEdfWWABGB0tUB6PMj6asUbPfbAS"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:57992 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308AbbJLJuK (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 12 Oct 2015 05:50:10 -0400
In-Reply-To: <1443988779-19935-2-git-send-email-anton.a.glukhov@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Anton Glukhov <anton.a.glukhov@gmail.com>, linux-can@vger.kernel.org, bcousson@baylibre.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Uhc2HdEdfWWABGB0tUB6PMj6asUbPfbAS
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/04/2015 09:59 PM, Anton Glukhov wrote:
> DT binding documentation for TI High End CAN Controller

Please add the device tree binding discussion mailing list on Cc.
>=20
> Signed-off-by: Anton Glukhov <anton.a.glukhov@gmail.com>
> ---
>  .../devicetree/bindings/net/can/ti_hecc.txt        | 31 ++++++++++++++=
++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/can/ti_hecc.t=
xt
>=20
> diff --git a/Documentation/devicetree/bindings/net/can/ti_hecc.txt b/Do=
cumentation/devicetree/bindings/net/can/ti_hecc.txt
> new file mode 100644
> index 0000000..e29b0ec
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/can/ti_hecc.txt
> @@ -0,0 +1,31 @@
> +* Texas Instruments High End CAN Controller
> +
> +This file provides information, what the device node
> +for the hecc interface contains.
> +
> +Required properties:
> +- compatible: "ti,am35x-hecc"
> +- reg: offset and length of the register set for the device
> +- interrupts: interrupt mapping for the hecc interrupts sources
> +- clocks: clock phandles (see clock bindings for details)
> +- ti,scc-ram-offset: offset to scc module ram
> +- ti,hecc-ram-offset: offset to hecc module ram
> +- ti,mbx-offset: offset to mailbox ram

Are the offsets a per SoC parameter? I'm not sure if it's better to put
the offsets into the driver.

> +
> +Optional properties:
> +- ti,int-line: interrupt line

Better make it a bool and describe it better.

> +
> +Example:
> +
> +For am3517evm board:
> +	hecc: can@0x5c050000 {
> +		compatible =3D "ti,am35x-hecc";
> +		status =3D "disabled";
> +		reg =3D <0x5c050000 0x4000>;
> +		interrupts =3D <24>;
> +		clocks =3D <&hecc_ck>;
> +		ti,scc-ram-offset =3D <0x3000>;
> +		ti,hecc-ram-offset =3D <0x3000>;
> +		ti,mbx-offset =3D <0x2000>;
> +		ti,int-line =3D <0>;
> +	};
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--Uhc2HdEdfWWABGB0tUB6PMj6asUbPfbAS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJWG4JKAAoJEP5prqPJtc/HqH8H/igOYyfTHYWoRYPIIKrqvcrS
PQCsf7kTTjC7dcPEhxHLb0H8eFUGLEHY8Rfh0fH6BTa708csP2fqEJOYfPyXsAvH
SrOW2qwZAzy7JD3Ay4kH8atHZSvU9sSWhgoQ/opsJQxBc5ID3m/qwOlg30QBK737
EZWXVSPfl7A6xfZFazMf8pnckCLuAxPu5ijBby4SHZqSDRxFdHrM3bbJkiI3SK8B
uNpwtYNn2/Ouqd+Sf70mownu/EUVJ/tm5Dpobmzpd4dAcbaQdAnW5ldtvGWS1XBG
Clv12IYqeoLEaW3KZKgAGFswsdpxPwcJ+zwn9iPIXHjoSks5xsWuLdwFIk1IqmU=
=xHcn
-----END PGP SIGNATURE-----

--Uhc2HdEdfWWABGB0tUB6PMj6asUbPfbAS--
