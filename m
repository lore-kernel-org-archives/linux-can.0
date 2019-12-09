From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 1/2] can: m_can: tcan4x5x: put the device out of
 standby before register access
Date: Mon, 9 Dec 2019 20:44:59 +0100
Message-ID: <78903660-2471-ee36-404b-4c9d2af02fc6@pengutronix.de>
References: <20191209192440.998659-1-sean@geanix.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="rWM2SGHou1ho9TwhaO20DOFk3TjQUWanU"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20191209192440.998659-1-sean@geanix.com>
Sender: stable-owner@vger.kernel.org
To: Sean Nyekjaer <sean@geanix.com>, dmurphy@ti.com, linux-can@vger.kernel.org
Cc: martin@geanix.com, stable@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rWM2SGHou1ho9TwhaO20DOFk3TjQUWanU
Content-Type: multipart/mixed; boundary="rct7xDw73UEwtnogzhg8znM22z6oPCmak";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Sean Nyekjaer <sean@geanix.com>, dmurphy@ti.com, linux-can@vger.kernel.org
Cc: martin@geanix.com, stable@vger.kernel.org
Message-ID: <78903660-2471-ee36-404b-4c9d2af02fc6@pengutronix.de>
Subject: Re: [PATCH v2 1/2] can: m_can: tcan4x5x: put the device out of
 standby before register access
References: <20191209192440.998659-1-sean@geanix.com>
In-Reply-To: <20191209192440.998659-1-sean@geanix.com>

--rct7xDw73UEwtnogzhg8znM22z6oPCmak
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 12/9/19 8:24 PM, Sean Nyekjaer wrote:
> The m_can tries to detect of niso (canfd) is available while in standby=
,

What's "of niso"?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--rct7xDw73UEwtnogzhg8znM22z6oPCmak--

--rWM2SGHou1ho9TwhaO20DOFk3TjQUWanU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl3upDsACgkQWsYho5Hk
nSCsJAgAuWKYqnBxkyntcAA6DTnJfJoZrBigsaZrUmw0+QYmIoihIQpgsdfeNmG7
zCZ7AyTLZJvJL3r6Q3MOK+x8ioX8uJScfHNEZOdvYtq4JN40KPT+qmldLuR19l0+
zrTj/JRqmRtEKhUS/E5yPkIzSDlolluSvdzuDO3W+n8yk7C3fQZ3elf8Z8hHoeou
fk05CQiKyLElnPjqZ3n2Jvu+VQSwfdfxxpGtjsMp+NJaXpe8IpYBvn0r+7lReDwU
hC61R8oVBD102U3j7E7fj3S832rPPitmhSqwJ+QiswPet0Ozv9urf86iTQ+ZWUyb
ZU27fAClJoexC4OoBZU2B4v0txmRxA==
=Ei7h
-----END PGP SIGNATURE-----

--rWM2SGHou1ho9TwhaO20DOFk3TjQUWanU--
