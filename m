From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/2] can: peak_usb: remove some 'struct timeval' users
Date: Mon, 6 Nov 2017 16:01:23 +0100
Message-ID: <4d541e16-c5a8-2c2a-c430-1daf5c8577cf@pengutronix.de>
References: <20171103163220.3799742-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="iCA7OMKMkrX7bMlhOcXNLorSsRpAasxJj"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20171103163220.3799742-1-arnd@arndb.de>
Sender: netdev-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Wolfgang Grandegger <wg@grandegger.com>
Cc: "David S. Miller" <davem@davemloft.net>, Kees Cook <keescook@chromium.org>, Allen Pais <allen.lkml@gmail.com>, Stephane Grosjean <s.grosjean@peak-system.com>, Johan Hovold <johan@kernel.org>, =?UTF-8?B?7LaU7KeA7Zi4?= <jiho.chu@samsung.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iCA7OMKMkrX7bMlhOcXNLorSsRpAasxJj
Content-Type: multipart/mixed; boundary="kbt110tSQtscPRT1P1xgEax45JBqc74SU";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Arnd Bergmann <arnd@arndb.de>, Wolfgang Grandegger <wg@grandegger.com>
Cc: "David S. Miller" <davem@davemloft.net>, Kees Cook
 <keescook@chromium.org>, Allen Pais <allen.lkml@gmail.com>,
 Stephane Grosjean <s.grosjean@peak-system.com>,
 Johan Hovold <johan@kernel.org>, =?UTF-8?B?7LaU7KeA7Zi4?=
 <jiho.chu@samsung.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <4d541e16-c5a8-2c2a-c430-1daf5c8577cf@pengutronix.de>
Subject: Re: [PATCH 1/2] can: peak_usb: remove some 'struct timeval' users
References: <20171103163220.3799742-1-arnd@arndb.de>
In-Reply-To: <20171103163220.3799742-1-arnd@arndb.de>

--kbt110tSQtscPRT1P1xgEax45JBqc74SU
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 11/03/2017 05:31 PM, Arnd Bergmann wrote:
> We want to remove 'struct timeval' and related interfaces since this is=

> generally not safe for use beyond 2038.
>=20
> For peak_usb, we can simplify the internal interface by using ktime_t
> directly. This should not change any behavior, but it avoids a few
> conversions.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Both applied to can-next.

Tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--kbt110tSQtscPRT1P1xgEax45JBqc74SU--

--iCA7OMKMkrX7bMlhOcXNLorSsRpAasxJj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAloAeUQACgkQHv7KIOw4
HPYCUwf+LBNjXlVBb6R6Q2fwI+uhniu/tHwUv78Sk4fTDRrbRo5+R79oWrv6b6Gj
fsKukJdu02BQx07s8sCbi5Stx3ZPDPxqS6icTsMwVgey9UAj9i3vRpKPUAz08ylU
Zx2tp+U2etQejE+192xUeZAuqviNEQeIASqGEIfxUsTRVvHmjIEYrOu+4kfkfCVy
/pBzJBf3oXGDPDm2TvH2/EvQE0GoRUYqSe7mG8CFKmUyVOjS6kEOppUAVIzkRHgO
yXcSugiW6Q3ip5S0RLtHeMnz+oq2+QUgOTjyA0FsVAw49Ztppn8QFHz+Fx5T6ySV
/08RdsqPMBnRQufcDFxTYScruuf5aA==
=TzmP
-----END PGP SIGNATURE-----

--iCA7OMKMkrX7bMlhOcXNLorSsRpAasxJj--
