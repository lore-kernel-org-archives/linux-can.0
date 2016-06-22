From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 0/2] can: rcar_canfd: Add Classical CAN & lower state
 transition support
Date: Wed, 22 Jun 2016 22:34:09 +0200
Message-ID: <602d4286-754f-f02f-4bd2-3e238cc4789a@pengutronix.de>
References: <1466434007-50873-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
 <1466598707-44076-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="sHCbUQ4mJTiSdMAk7lsULQ5m8agaXj9Dn"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1466598707-44076-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>, wg@grandegger.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org
Cc: ulrich.hecht+renesas@gmail.com, horms@verge.net.au, linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org, chris.paterson2@renesas.com, magnus.damm@gmail.com, socketcan@hartkopp.net
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sHCbUQ4mJTiSdMAk7lsULQ5m8agaXj9Dn
Content-Type: multipart/mixed; boundary="sPmXpiwEJs9x3qPRuaurOL4wcxhPk5T6h"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>,
 wg@grandegger.com, robh+dt@kernel.org, pawel.moll@arm.com,
 mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org
Cc: ulrich.hecht+renesas@gmail.com, horms@verge.net.au,
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 chris.paterson2@renesas.com, magnus.damm@gmail.com, socketcan@hartkopp.net
Message-ID: <602d4286-754f-f02f-4bd2-3e238cc4789a@pengutronix.de>
Subject: Re: [PATCH v2 0/2] can: rcar_canfd: Add Classical CAN & lower state
 transition support
References: <1466434007-50873-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
 <1466598707-44076-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
In-Reply-To: <1466598707-44076-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>

--sPmXpiwEJs9x3qPRuaurOL4wcxhPk5T6h
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/22/2016 02:31 PM, Ramesh Shanmugasundaram wrote:
> This patch is based on latest can-next(tag:linux-can-next-for-4.8-20160=
617).
>=20
> Changes since v1:
>  - property named changed from "can-nofd" to "no-can-fd" (Rob H)
>  - added new patch(0002) that support lower state transitions (Wolfgang=
 G)
>    (http://marc.info/?l=3Dlinux-can&m=3D146650325116971&w=3D2)
>=20
> Ramesh Shanmugasundaram (2):
>   can: rcar_canfd: Add Classical CAN only mode support
>   can: rcar_canfd: Add back-to-error-active support
>=20
>  .../devicetree/bindings/net/can/rcar_canfd.txt     |  21 +-
>  drivers/net/can/rcar/rcar_canfd.c                  | 429 +++++++++++++=
+-------
>  2 files changed, 310 insertions(+), 140 deletions(-)

Applied to can-next.

Tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--sPmXpiwEJs9x3qPRuaurOL4wcxhPk5T6h--

--sHCbUQ4mJTiSdMAk7lsULQ5m8agaXj9Dn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJXavZBAAoJED07qiWsqSVqqgIH/1b8DgsnztQETaJ8WYLkokQz
ZOcUOwpDOXGxA5BdYxHCyO74hoLIqvgR78ToxveujVynHPgR/gbUBjMR/QWp4S1G
AoN8sBLWY2121DF362KAQ5QGje18Bx502V0X0CFGHZUMUuH1MnoSXVmNp9nC8Cwk
XzEO66M/AgB8Zto2u6por+Y3r2mkuWWMrcIhzMKlGN0HWnTD1RckqxlxMOdXWDct
h1nnyCtG8imb1N0Wh707xRiBjaBbdzcj+mxKf/f1adQXJVsZjPFL9ojvsnVbxcP8
V6ucN9hlNwSXuSFE2qFTG1ny6ihOoLmK30BcyHu5vFWmk5WVpqz3+HvgwR582sU=
=4uYv
-----END PGP SIGNATURE-----

--sHCbUQ4mJTiSdMAk7lsULQ5m8agaXj9Dn--
