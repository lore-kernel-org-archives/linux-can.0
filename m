From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/5][RFC] can: slcan: Replace sizeof struct can_frame with
 CAN_MTU
Date: Fri, 17 Jun 2016 11:24:12 +0200
Message-ID: <5c0b646c-f020-98d0-de88-0a604c62fddf@pengutronix.de>
References: <1465500064-5402-1-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="3npS3DdmwXocF3Jk5qFpAVBFvIXa1aDUg"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:52370 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751711AbcFQJYW (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 17 Jun 2016 05:24:22 -0400
In-Reply-To: <1465500064-5402-1-git-send-email-marex@denx.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marek Vasut <marex@denx.de>, linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3npS3DdmwXocF3Jk5qFpAVBFvIXa1aDUg
Content-Type: multipart/mixed; boundary="XiTIFFF8RC5jEn2vrn0F05dgRvC6H5rdf"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Marek Vasut <marex@denx.de>, linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <5c0b646c-f020-98d0-de88-0a604c62fddf@pengutronix.de>
Subject: Re: [PATCH 1/5][RFC] can: slcan: Replace sizeof struct can_frame with
 CAN_MTU
References: <1465500064-5402-1-git-send-email-marex@denx.de>
In-Reply-To: <1465500064-5402-1-git-send-email-marex@denx.de>

--XiTIFFF8RC5jEn2vrn0F05dgRvC6H5rdf
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/09/2016 09:21 PM, Marek Vasut wrote:
> Use CAN_MTU macro instead of sizeof(struct can_frame) just like the
> other drivers do.
>=20
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Oliver Hartkopp <socketcan@hartkopp.net>
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>

Added this one to can-next.

Thnaks,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--XiTIFFF8RC5jEn2vrn0F05dgRvC6H5rdf--

--3npS3DdmwXocF3Jk5qFpAVBFvIXa1aDUg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJXY8G8AAoJED07qiWsqSVqXNIH/28rQ7A5pI+UuVsMz0F/Qryd
EChtmTE/jgOGwVmz1+JCyD4+7CleoEfNATQGG4AjJdYpxI0ZDlgTo74mYuU6P+hW
kajvrHBxjeEmtMB/h8dYFMm+WEAKj+8uuAIKNxEjlOOz07pndnaoNf6LymLBJV+8
Q1N+bEtU3M0PwxOI6We/Uh4vaVN+68o9JCe2HuQNN/rpBgDA/c7pWe4IfSHTtvrv
lL8mgVEB+/jNaaCzFuNehSLm4BzK32JR9aLofLrWj5vrz1+1BjCeun+P4kF8C+HW
S75DwI+JYv2LEuBXIY4K+1+9LpkwYGaa83euliEILj/1k4BpmHu0QsASMAJgiEc=
=gs2v
-----END PGP SIGNATURE-----

--3npS3DdmwXocF3Jk5qFpAVBFvIXa1aDUg--
