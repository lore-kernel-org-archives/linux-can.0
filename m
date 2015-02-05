From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can-doc: Fixed a wrong filepath in can.txt
Date: Thu, 05 Feb 2015 16:37:17 +0100
Message-ID: <54D38E2D.1010105@pengutronix.de>
References: <1423146804-8530-1-git-send-email-stefan@sevenbyte.org> <20150205100053.420e4941@lwn.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="GTewsph6KpgpAqSISoca9mGlqMhBUQau9"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150205100053.420e4941@lwn.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>, Stefan Tatschner <stefan@sevenbyte.org>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GTewsph6KpgpAqSISoca9mGlqMhBUQau9
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/05/2015 04:00 PM, Jonathan Corbet wrote:
> On Thu,  5 Feb 2015 15:33:24 +0100
> Stefan Tatschner <stefan@sevenbyte.org> wrote:
>=20
>> -  described in the Linux header file "include/linux/can/error.h".
>> +  described in the Linux header file "include/uapi/linux/can/error.h"=
=2E
>=20
> Looks good.  It needed a changelog, though, so I took the liberty of
> adding one.

Are you taking the patch?
FWIW: Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--GTewsph6KpgpAqSISoca9mGlqMhBUQau9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJU0440AAoJECte4hHFiupUIIYP/jAy1AY6PZTfYckba0HJuhuP
MPPKq0Dql+VdRmS1vYDrUbJVbWHgltBXO8epEB88HsWYrDjfkwSaW8mTpZgpAR1j
2WIR4L0POJNpwZ6ivzgb3gLa/lFSQilFuhYMYQ1FD9/2avODvOZCTCBzJMaqf/rr
ROvp76QoTRiPvLzzYqgVfTXTHX6rEwQ7DKHCVFJGc5t9DsLcVLYuy/NJRVrUCxga
MKYet7TfU794CrGS1ese977o+8lR6jJ73GcWj0loxpYAoLKEAqBubya2HX1XYXHa
KNWjishDgULlgVZvS2N5dE0I+58Iw6oAU2WgssI2UPNESwWd6dIU9hKHezrpYBDK
EwITUX8zfn/mDvHOQXq7Pfjfd1SkFVRceMXLCy2CghsMqBDlyeHx01GmBN2ggmOZ
9Lg8EKCoWK0E5Me1X4IxW/bjafhGWrjlFpeTAe8i+uxAyTt+Ob4IFy3pzrN1XLM0
PTKoxFL4I/jiIeLwAhceNfj28yHeWyGrD8dKjtQAcwun63olT1KcWmO8SMQCXwAB
PD9xV3hQWS/7cxL/4LaSmlSq/p8K7uJwNRecxsO4stvFGs3zn5SvuS5L8cpK4TPA
hUDxSBAoX02NWNte5cpreQM1ERax+LwSJDR6/preArgRn+D+zEIoYQlFJ+KrmpWr
WyqRRYGc361QmoFJADaO
=WmiO
-----END PGP SIGNATURE-----

--GTewsph6KpgpAqSISoca9mGlqMhBUQau9--
