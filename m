From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH resend] can: rcar_can: convert to SPDX identifiers
Date: Thu, 27 Sep 2018 11:05:02 +0200
Message-ID: <1bfdc10a-41e9-2a1f-b944-a8816186e998@pengutronix.de>
References: <874ledyrc6.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="LqXYgdV2Ll4ppqwzzQQulY2r8c3HCiq2v"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <874ledyrc6.wl-kuninori.morimoto.gx@renesas.com>
Sender: netdev-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Wolfgang Grandegger <wg@grandegger.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux-Net <netdev@vger.kernel.org>, linux-can@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LqXYgdV2Ll4ppqwzzQQulY2r8c3HCiq2v
Content-Type: multipart/mixed; boundary="WOHXJ4MorcyPPMh23GJt5evmFzzmmPdHx";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Wolfgang Grandegger <wg@grandegger.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Linux-Net <netdev@vger.kernel.org>, linux-can@vger.kernel.org
Message-ID: <1bfdc10a-41e9-2a1f-b944-a8816186e998@pengutronix.de>
Subject: Re: [PATCH resend] can: rcar_can: convert to SPDX identifiers
References: <874ledyrc6.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <874ledyrc6.wl-kuninori.morimoto.gx@renesas.com>

--WOHXJ4MorcyPPMh23GJt5evmFzzmmPdHx
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 09/26/2018 03:41 AM, Kuninori Morimoto wrote:
>=20
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> This patch updates license to use SPDX-License-Identifier
> instead of verbose license text.
>=20
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

Wolfram Sang has already supplied a similar patch, but not for Makefile
and Kconfig. I've applied your patch for Makefile and Kconfig and
adjusted the commit message accordingly.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--WOHXJ4MorcyPPMh23GJt5evmFzzmmPdHx--

--LqXYgdV2Ll4ppqwzzQQulY2r8c3HCiq2v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlusnT4ACgkQk9IU1zQo
ZfGUEggA2BrO340zbi8ZLpi6HoLj7omJuz4WpENUgGU2vmFQF5b4d3Ir8XdNEz+W
HyYIhFicj+8z1sEAg/4dsQa4LghuQGOmUdN6Wo+F5LOtkaREI2WRV+lXSY/jOES4
VfXfcm80fIorwIVNMGopgreEzACrJZYFl71erWnT9lgAkttkAlF//vIlYJkklPDd
t4NpSDiKoxFNQg7fIXRIjDUAkTnLFWwO8V0LvCD0kiG2vBIfwf6hGnAfRwBMzNRa
Z6jxKMGoURVGqHGDErSCQyuL/CDFJvZjPmJY5NxR3gdPqlQ4fokNZV30qeA6LrPY
FS/OojcQOuUNuApS+fXFeeVwHSYkdg==
=gZqz
-----END PGP SIGNATURE-----

--LqXYgdV2Ll4ppqwzzQQulY2r8c3HCiq2v--
