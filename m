From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v5 0/5] Add support for CAN FD to broadcast manager
 (CAN_BCM)
Date: Fri, 17 Jun 2016 15:42:05 +0200
Message-ID: <21cd205a-197c-6fc4-e9c0-79f6fc304536@pengutronix.de>
References: <1466170528-10193-1-git-send-email-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="uBIcVG6iiT12nvvLk1BlvxNS17PHMb5M2"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:52008 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751309AbcFQNmM (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 17 Jun 2016 09:42:12 -0400
In-Reply-To: <1466170528-10193-1-git-send-email-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uBIcVG6iiT12nvvLk1BlvxNS17PHMb5M2
Content-Type: multipart/mixed; boundary="1xTpJ7xXcbXUjb6lv5oD2hkVaTlaCF7ke"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Message-ID: <21cd205a-197c-6fc4-e9c0-79f6fc304536@pengutronix.de>
Subject: Re: [PATCH v5 0/5] Add support for CAN FD to broadcast manager
 (CAN_BCM)
References: <1466170528-10193-1-git-send-email-socketcan@hartkopp.net>
In-Reply-To: <1466170528-10193-1-git-send-email-socketcan@hartkopp.net>

--1xTpJ7xXcbXUjb6lv5oD2hkVaTlaCF7ke
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/17/2016 03:35 PM, Oliver Hartkopp wrote:
> This series adds the capability for the CAN broadcast manager to handle=

> CAN FD frames analogue to the CAN frames. It allows sending as well as =
all
> known data filtering functions (including multiplex filtering).
>=20
> Changes in v2:
> Introduce a helper variable cfsiz to prevent multiple CFSIZ(op) operati=
ons
> in bcm_rx_handler() (patch 4/5).
>=20
> Changes in v3:
> Introduce a helper variable cfsiz into struct bcm_op to minimize CFSIZ(=
op)
> operations (patch 4/5).
> Fix documentation table of contents and code example (patch 5/5)
>=20
> Changes in v4:
> fixed more style issues remarked by checkpatch.pl (patch 1/5)
> Use CFSIZ macro in bcm_sendmsg() for TX_SEND too (patch 4/5)
>=20
> Changes in v5:
> Rename function GET_U64() to get_u64() and update version date (patch 4=
/5)
>=20
> Oliver Hartkopp (5):
>   can: bcm: fix indention and other minor style issues
>   can: bcm: use CAN frame instead of can_frame in comments
>   can: bcm: unify bcm_msg_head handling and prepare function parameters=

>   can: bcm: add support for CAN FD frames
>   can: bcm: add documentation for CAN FD support
>=20
>  Documentation/networking/can.txt |  25 +++-
>  include/uapi/linux/can/bcm.h     |   1 +
>  net/can/bcm.c                    | 309 +++++++++++++++++++++++--------=
--------
>  3 files changed, 204 insertions(+), 131 deletions(-)

applied to can-next.

tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--1xTpJ7xXcbXUjb6lv5oD2hkVaTlaCF7ke--

--uBIcVG6iiT12nvvLk1BlvxNS17PHMb5M2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJXY/4tAAoJED07qiWsqSVqJYwIAJinHd1SQzrpHv+5YRlow+aU
L/ow0r2dKeXcGsCcnLbhDMauzEwH6CSVjVkJyMGb9nU5qCSprpvSql9/TIPjKBBI
1ydyPQNYUaJczg0dCG4HGRtMyZUnKCZWd7y3B8CxyBELhedlgDbhHVpuQjYRXFeJ
TrGuT03kX5w2c8G+RuJdj1YzauaPiUwXyU3XD3etApSsYhBu9aCxmS3dYfNTiIWl
Tim3us9/yKqltyA28QDtu7ehoPl0nG0k//BI1vqZDKEC008CQYKv402S9AX6PHrU
7BBZNTfXM8SVtzqxoX4KBEkWK5QCXmWN5R9hl+2uWWcaJ/gqFlmqRAE2NaRCb2s=
=5LvF
-----END PGP SIGNATURE-----

--uBIcVG6iiT12nvvLk1BlvxNS17PHMb5M2--
