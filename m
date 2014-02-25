From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: MCP2515 DTS support
Date: Tue, 25 Feb 2014 22:35:18 +0100
Message-ID: <530D0C96.6060207@pengutronix.de>
References: <144554558e0.2748.cbaa067694a7e68fb76a213b35423fb5@gmail.com> <5308FE97.8090804@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="UAAIO1Rma7Q9dgpn9aMkGCXkjEbHnHhQ0"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55127 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339AbaBYVf1 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 25 Feb 2014 16:35:27 -0500
In-Reply-To: <5308FE97.8090804@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Lucas Zampar Bernardi <lucas.zampar@gmail.com>, Alexander Shiyan <shc_work@mail.ru>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UAAIO1Rma7Q9dgpn9aMkGCXkjEbHnHhQ0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 02/22/2014 08:46 PM, Lucas Zampar Bernardi wrote:
> Hi again,
>=20
>=20
> I found the causes of problem, and now I need to know if I was setting
> wrong structure or there are driver problem.
> I've had this modification on mcp251x.c:
>=20
> static int mcp251x_can_probe(struct spi_device *spi)
> {
>     const struct of_device_id *of_id =3D of_match_device(mcp251x_of_mat=
ch,
>                                &spi->dev);
>     struct mcp251x_platform_data *pdata =3D dev_get_platdata(&spi->dev)=
;
>     struct net_device *net;
>     struct mcp251x_priv *priv;
>     int freq, ret =3D -ENODEV;
>     struct clk *clk;
>=20
>=20
>     clk =3D devm_clk_get(&spi->dev, NULL);
>     dev_dbg(&spi->dev, "MCP2515: clk =3D devm_clk_get(&spi->dev, NULL)"=
);
>     if (IS_ERR(clk)) {
>         if (pdata)
>         {
>             freq =3D pdata->oscillator_frequency;
>         }
>         else
>         {
>>>        freq =3D 20 * 1000 * 1000;    // FORCE FREQUENCY to 20Mhz
>             //return PTR_ERR(clk);
>         }
>     } else {
>         dev_dbg(&spi->dev, "MCP2515: freq =3D clk_get_rate(clk);");
>         freq =3D clk_get_rate(clk);
>     }
>=20
>=20
> Then the driver start to run.
>=20
> I think that the problem is about how to set a correct clock.
>=20
>=20
> I put on can node:
>                 can0: can@1 {
>                     compatible =3D "microchip,mcp2515";
>                     reg =3D <2>;
>                     spi-max-frequency =3D <5000000>;
>                     clocks =3D <&mcp251x_clock>;
>                     interrupt-parent =3D <&pioC>; /* MCP GPO Interrupt =
*/
>                     interrupts =3D <12 0x2>;
>                 };
>=20
>=20
>=20
> and my clocks node:
>=20
>     clocks {
>         #address-cells =3D <1>;
>         #size-cells =3D <1>;
>         ranges;
>=20
>         main_clock: clock@0 {
>             compatible =3D "atmel,osc", "fixed-clock";
>             clock-frequency =3D <12000000>;
>         };
>=20
>         mcp251x_clock: mcp2515 {
>             compatible =3D "fixed-clock";
>             #clock-cells =3D <0>;
>             clock-frequency =3D <20000000>;
>         };
>=20
>=20
>     };
>=20
>=20
> So... How can we know if it's a DTS definition or a driver problem?

The driver looks good. I've put Alexander Shiyan, who contributed the DT
pachtes, on Cc. Maybe he can post the DT he used.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--UAAIO1Rma7Q9dgpn9aMkGCXkjEbHnHhQ0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlMNDJYACgkQjTAFq1RaXHNiTgCcCvqbm64sBi5Pu16x1gIt+lRO
4/oAn1I+CP5oi3/Ao8lNHrlT67tkby0C
=UjwT
-----END PGP SIGNATURE-----

--UAAIO1Rma7Q9dgpn9aMkGCXkjEbHnHhQ0--
