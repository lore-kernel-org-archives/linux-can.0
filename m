From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v6] can: dev: add CAN interface termination API
Date: Thu, 19 Jan 2017 11:13:20 +0100
Message-ID: <7d6c2bc2-a1ae-cf9b-ea13-3a80405cfdd3@pengutronix.de>
References: <20170118145916.10580-1-mkl@pengutronix.de>
 <a8143a03-7218-a37c-7851-d1d6f9e68f3e@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="5xEfwXKGijblhrkJrEqpmJLJSVOJ9txSV"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:57917 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751410AbdASKya (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 19 Jan 2017 05:54:30 -0500
In-Reply-To: <a8143a03-7218-a37c-7851-d1d6f9e68f3e@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5xEfwXKGijblhrkJrEqpmJLJSVOJ9txSV
Content-Type: multipart/mixed; boundary="etfRnSGQUQghRjG6db3vRdV4fVjQswjfQ";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Message-ID: <7d6c2bc2-a1ae-cf9b-ea13-3a80405cfdd3@pengutronix.de>
Subject: Re: [PATCH v6] can: dev: add CAN interface termination API
References: <20170118145916.10580-1-mkl@pengutronix.de>
 <a8143a03-7218-a37c-7851-d1d6f9e68f3e@hartkopp.net>
In-Reply-To: <a8143a03-7218-a37c-7851-d1d6f9e68f3e@hartkopp.net>

--etfRnSGQUQghRjG6db3vRdV4fVjQswjfQ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/18/2017 06:48 PM, Oliver Hartkopp wrote:
> Just a small issue in the commit message:
>=20
> On 01/18/2017 03:59 PM, Marc Kleine-Budde wrote:
>> From: Oliver Hartkopp <socketcan@hartkopp.net>
>>
>> This patch adds a netlink interface to configure the CAN bus terminati=
on of
>> CAN interfaces.
>>
>> Inside the driver an array of supported termination values is defined:=

>>
>> const u16 drvname_termination[] =3D { 60, 120, CAN_TERMINATION_DISABLE=
D };
>>
>> struct drvname_priv *priv;
>> priv =3D netdev_priv(dev);
>>
>> priv->termination_const =3D &drvname_termination;
>=20
> This has to be:
> priv->termination_const =3D drvname_termination;
>=20
> or we will get a incompatible pointer warning.
>=20
> Found the issue by adding the documentation PoC in usb_8dev for testing=
:

Fixed.

Thanks,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--etfRnSGQUQghRjG6db3vRdV4fVjQswjfQ--

--5xEfwXKGijblhrkJrEqpmJLJSVOJ9txSV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEES2FAuYbJvAGobdVQPTuqJaypJWoFAliAkUAACgkQPTuqJayp
JWquIQf/e3twi03ffg62iz+BM/7TX6BcPPAQXddjRX1k2VbXnWKNLEHOBwGCb0mo
xbaI6dLKGUiTvhvzbiNUog1JKXFZbHrqpNnnvrLHlCPlo1TEAWDq7u92TDKHpyR3
YN8V9SjyEKkwbLbOAGNVSYS+RW55GFw1s6zRLueQRZ9TIMF2CbGuoqDUbSCDfhZJ
fcColbJAf8CvY/5+ehxe1TgKrXSexf5yf+/GFvLBqW6Mpkp62ZEVvqOkq/buMveI
etfA8H4kEjxSP9s/JPGAQYQQCv3s7Ujb27P1ylhEMYe4tgiUEQVF/TGr3C25nuxi
TYTi8AxIQ1Y+tVmezLI6nl/ctV/nrw==
=63qC
-----END PGP SIGNATURE-----

--5xEfwXKGijblhrkJrEqpmJLJSVOJ9txSV--
