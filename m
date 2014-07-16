From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v5 1/2] can: m_can: add device tree binding documentation
Date: Wed, 16 Jul 2014 12:05:05 +0200
Message-ID: <53C64E51.9050606@pengutronix.de>
References: <1405503050-16796-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="fUckgXfaif9XaNSDuUaov41ov3hHXnhcl"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40446 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755825AbaGPKFU (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 16 Jul 2014 06:05:20 -0400
In-Reply-To: <1405503050-16796-1-git-send-email-b29396@freescale.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Dong Aisheng <b29396@freescale.com>, linux-can@vger.kernel.org
Cc: wg@grandegger.com, socketcan@hartkopp.net, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, mark.rutland@arm.com, varkabhadram@gmail.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fUckgXfaif9XaNSDuUaov41ov3hHXnhcl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/16/2014 11:30 AM, Dong Aisheng wrote:
> add M_CAN device tree binding documentation
>=20
> Cc: Wolfgang Grandegger <wg@grandegger.com>
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Oliver Hartkopp <socketcan@hartkopp.net>
> Cc: Varka Bhadram <varkabhadram@gmail.com>
> Signed-off-by: Dong Aisheng <b29396@freescale.com>
> ---
> Changes since v4:
> - change the name of board dtsi to board dts which is more common
>=20
> Changes since v3:
> - change mram-cfg property name to bosch,mram-cfg
> - indent change
> ---
>  .../devicetree/bindings/net/can/m_can.txt          |   67 ++++++++++++=
++++++++
>  1 files changed, 67 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/can/m_can.txt=


I'll apply this series once we've got an Ack for the DT folks.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--fUckgXfaif9XaNSDuUaov41ov3hHXnhcl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlPGTlEACgkQjTAFq1RaXHOm3gCgizGzkGo2b+Gl/SYQz+8GUYk0
L2cAoJXvadvxqoCCJoVxDgq7jIud2OEK
=87FM
-----END PGP SIGNATURE-----

--fUckgXfaif9XaNSDuUaov41ov3hHXnhcl--
