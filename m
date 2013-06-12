From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/2] flexcan: Use a regulator to control the CAN transceiver
Date: Wed, 12 Jun 2013 11:39:10 +0200
Message-ID: <51B841BE.1020300@pengutronix.de>
References: <1370460445-15386-1-git-send-email-festevam@gmail.com> <51B605E7.6080903@pengutronix.de> <CAOMZO5CtSZ-ru1PFdgBhtvNYMSfaqe=0Bnmk4sTLRzHROp1YEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2OJDIBXQRDGXHSEVRQWQA"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46138 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876Ab3FLJjU (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 12 Jun 2013 05:39:20 -0400
In-Reply-To: <CAOMZO5CtSZ-ru1PFdgBhtvNYMSfaqe=0Bnmk4sTLRzHROp1YEA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: shawn.guo@linaro.org, linux-can@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2OJDIBXQRDGXHSEVRQWQA
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 06/11/2013 04:38 AM, Fabio Estevam wrote:
> On Mon, Jun 10, 2013 at 1:59 PM, Marc Kleine-Budde <mkl@pengutronix.de>=
 wrote:
> };
>>> +
>>> +             reg_can_3v3: can-3v3 {
>>> +                     compatible =3D "regulator-fixed";
>>> +                     regulator-name =3D "can-3v3";
>>> +                     regulator-min-microvolt =3D <3300000>;
>>> +                     regulator-max-microvolt =3D <3300000>;
>>> +                     gpio =3D <&gpio2 13 0>;
>>
>> Can you convert GPIO2_13 from a hog gpio to a normal pinctl gpio?
>=20
> I kept gpio2_13 as a hog gpio because on imx28-evk.dts we use this
> approach for the fec and usb regulators.

Using the hog gpio pinmux for the fec and usb might be due to historical
reasons. I personally prefer the pinmux properly added to the regulator.
But I'm not the mxs maintainer, so I don't insist on changing the pinmux
setup. However a Acked-by from Shawn Guo would be fine.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2OJDIBXQRDGXHSEVRQWQA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlG4QcIACgkQjTAFq1RaXHP1bQCdEgHCZ0wIaPD02n2LRgs9ewdV
hd8An3rwOlczg988NBEzFhuIjyznWac2
=oyEA
-----END PGP SIGNATURE-----

------enig2OJDIBXQRDGXHSEVRQWQA--
