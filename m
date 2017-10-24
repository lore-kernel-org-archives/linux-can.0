From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 0/2] can: kvaser_usb: Small fixes
Date: Tue, 24 Oct 2017 13:03:03 +0200
Message-ID: <6bff85a5-ddbb-a88f-8114-9761d8abce09@pengutronix.de>
References: <20171024102329.28526-1-jimmyassarsson@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="wPqctxXeNnJDvM6j6XdvlbLkc1pDW8UJ1"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:46531 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751874AbdJXLDI (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 24 Oct 2017 07:03:08 -0400
In-Reply-To: <20171024102329.28526-1-jimmyassarsson@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Jimmy Assarsson <jimmyassarsson@gmail.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wPqctxXeNnJDvM6j6XdvlbLkc1pDW8UJ1
Content-Type: multipart/mixed; boundary="0iLoukJNhGHaVtebDrCTFwpRPKFAEnNrg";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Jimmy Assarsson <jimmyassarsson@gmail.com>, linux-can@vger.kernel.org
Message-ID: <6bff85a5-ddbb-a88f-8114-9761d8abce09@pengutronix.de>
Subject: Re: [PATCH 0/2] can: kvaser_usb: Small fixes
References: <20171024102329.28526-1-jimmyassarsson@gmail.com>
In-Reply-To: <20171024102329.28526-1-jimmyassarsson@gmail.com>

--0iLoukJNhGHaVtebDrCTFwpRPKFAEnNrg
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 10/24/2017 12:23 PM, Jimmy Assarsson wrote:
> Fix two issues in the kvaser_usb driver.
>=20
> Jimmy Assarsson (2):
>   can: kvaser_usb: Correct return value in printout
>   can: kvaser_usb: Ignore CMD_FLUSH_QUEUE_REPLY messages
>=20
>  drivers/net/can/usb/kvaser_usb.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Both applied to can and added stable on Cc.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--0iLoukJNhGHaVtebDrCTFwpRPKFAEnNrg--

--wPqctxXeNnJDvM6j6XdvlbLkc1pDW8UJ1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlnvHecACgkQHv7KIOw4
HPaeKAgAjVkB2Ri+qHCDik6QN2G75s+8+FM3Br+qTsqDfnkJMDRy3H7gJDwx/DBc
YdzkGFWRJxkH43U9qEhinydNh7zhfBG+orgVhzzJMKd57grkrBQe/RstPb3RWje6
truuTpLa1lvtJ6feDskh+2Ajs0TMCIdCe0Bd887Rq2uQC5YiO0uKbgR4F730FSpX
16PMtNncxN6TGCm0EsJFHAGUFwNNwgK8lO6sQde68TgruX4hO1fd1xzZLqVogI/O
Rl6bCeJbm1fixDcSO5Vg0hSy4cl6GBkFtiWaqdNS3I/YoMgBuavba9DRqOygC/Uc
qcPy2f0WVAJexeKuhXtz7CjerwiWiQ==
=/grB
-----END PGP SIGNATURE-----

--wPqctxXeNnJDvM6j6XdvlbLkc1pDW8UJ1--
