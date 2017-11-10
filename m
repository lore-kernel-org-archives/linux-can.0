From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: ifi: Fix transmitter delay calculation
Date: Fri, 10 Nov 2017 14:07:55 +0100
Message-ID: <26787f01-3f35-c3b7-4f50-877fcd2051eb@pengutronix.de>
References: <20171110102239.6864-1-marex@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="4MIP320w2pkUmf9q2OIMJeTxpJk0XPjtR"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:47437 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752992AbdKJNIC (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 10 Nov 2017 08:08:02 -0500
In-Reply-To: <20171110102239.6864-1-marex@denx.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marek Vasut <marex@denx.de>, linux-can@vger.kernel.org
Cc: Markus Marb <markus@marb.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4MIP320w2pkUmf9q2OIMJeTxpJk0XPjtR
Content-Type: multipart/mixed; boundary="5vMUoeEgNAFSetT9NM991g2sqtOW3PNxe";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Marek Vasut <marex@denx.de>, linux-can@vger.kernel.org
Cc: Markus Marb <markus@marb.org>
Message-ID: <26787f01-3f35-c3b7-4f50-877fcd2051eb@pengutronix.de>
Subject: Re: [PATCH] can: ifi: Fix transmitter delay calculation
References: <20171110102239.6864-1-marex@denx.de>
In-Reply-To: <20171110102239.6864-1-marex@denx.de>

--5vMUoeEgNAFSetT9NM991g2sqtOW3PNxe
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 11/10/2017 11:22 AM, Marek Vasut wrote:
> The CANFD transmitter delay calculation formula was updated in the
> latest software drop from IFI and improves the behavior of the IFI
> CANFD core during bitrate switching. Use the new formula to improve
> stability of the CANFD operation.
>=20
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Markus Marb <markus@marb.org>
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>

added to can.

Tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--5vMUoeEgNAFSetT9NM991g2sqtOW3PNxe--

--4MIP320w2pkUmf9q2OIMJeTxpJk0XPjtR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAloFpKsACgkQHv7KIOw4
HPYiYwf9HOUtiDX4+FTC1nafsO75UYIdjDHr3IMTRQYKY0o7VSVTT1PQc45E8emT
8iDLkgs6Z58xQcIjvPc/pyO3b2egSw8MSLMltjnZ43/wUyzxh0TRaq+hE/iijiZW
VzifAgM3Bd78c16YNUPVFUdlE6kXqaS8GQuy1L4unuCpHcc/zAq2XKsehnhrfYny
usCBzm6AajYGB4gJzeVL5JBcpX6cJGHRSJfHTukqjdfaLc90CspkTVk2cOWT3hXX
tWrt1C6JEPYAtJrARtgMtoRvw0UXH8KKzrY16X7U2LkY8QZt99pDWJInQ604/vfu
ZV0bQray9S+9tpyLj4kYcsU09qKM6A==
=Pinm
-----END PGP SIGNATURE-----

--4MIP320w2pkUmf9q2OIMJeTxpJk0XPjtR--
