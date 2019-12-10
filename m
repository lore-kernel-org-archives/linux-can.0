From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2] can: tcan4x5x: Turn on the power before parsing the
 config
Date: Tue, 10 Dec 2019 17:46:06 +0100
Message-ID: <5c6cba4b-efc1-6982-aa6f-c5e90fbb5aa4@pengutronix.de>
References: <20191210163204.28225-1-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="pP3GmhQynuFVQhOpVFpKVBofGaQQdp8Kb"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191210163204.28225-1-dmurphy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pP3GmhQynuFVQhOpVFpKVBofGaQQdp8Kb
Content-Type: multipart/mixed; boundary="RYWLW15WZQLM7id6xO88q6TUEsbe5fZ7O";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Dan Murphy <dmurphy@ti.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Message-ID: <5c6cba4b-efc1-6982-aa6f-c5e90fbb5aa4@pengutronix.de>
Subject: Re: [PATCH v2] can: tcan4x5x: Turn on the power before parsing the
 config
References: <20191210163204.28225-1-dmurphy@ti.com>
In-Reply-To: <20191210163204.28225-1-dmurphy@ti.com>

--RYWLW15WZQLM7id6xO88q6TUEsbe5fZ7O
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 12/10/19 5:32 PM, Dan Murphy wrote:
> The parse config function now performs action on the device either
> reading or writing and a reset.  If the regulator is managed it needs
> to be turned on.  So turn on the regulator if available if the parsing
> fails then turn off the regulator.
>=20
> Fixes: a5235f3c7c23 ("can: tcan45x: Make wake-up GPIO an optional GPIO"=
)
> Signed-off-by: Dan Murphy <dmurphy@ti.com>

Applied to linux-can.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--RYWLW15WZQLM7id6xO88q6TUEsbe5fZ7O--

--pP3GmhQynuFVQhOpVFpKVBofGaQQdp8Kb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl3vy88ACgkQWsYho5Hk
nSBbyQf/SYPgQ9W4VJnUTBNv/mbIkTXCd+PsI7uo5464zX0WGbdiFVEttBLFUezz
fDowEqMFi7jkTi7rS5fUkOH9fL5Oi5oQHIhB5AGwTVFUOmQQwFwspPM3rdiygNOM
nTs3skR8FzwV56IvXvbxAiNuQWOaqNDiOLcHBhivSUcmfJ3lToDsP5HBqIU8u8Ct
f+aBe1Mn+x1vhmWfZRAcVUXvUUsOMm4ZS9X7wvcZqPIMOCUKp/vItpQHNnIXRQ02
ykXJtDt1e9ZAw8ZKxpcxPlQAic7GVXDgbVOAAhIycQosBCd9ueODWCh1fIk8VjIt
MUGOieZ9M4/eNGKwQwLpC0AEDRPh8Q==
=UP1A
-----END PGP SIGNATURE-----

--pP3GmhQynuFVQhOpVFpKVBofGaQQdp8Kb--
