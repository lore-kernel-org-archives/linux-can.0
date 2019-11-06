From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v3] can: m_can: add support for handling arbitration error
Date: Wed, 6 Nov 2019 11:35:00 +0100
Message-ID: <51e2e2bf-1798-941c-79e4-d1339d4095a2@pengutronix.de>
References: <CGME20191030114039epcas5p434c9a7ffb715f2af2f4d3745239b5bbd@epcas5p4.samsung.com>
 <1572435539-3315-1-git-send-email-pankj.sharma@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="53MC47IrhTQ4HgJg9q9nOJJDycTuMKIMf"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1572435539-3315-1-git-send-email-pankj.sharma@samsung.com>
Sender: netdev-owner@vger.kernel.org
To: Pankaj Sharma <pankj.sharma@samsung.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: wg@grandegger.com, davem@davemloft.net, pankaj.dubey@samsung.com, rcsekar@samsung.com, jhofstee@victronenergy.com, simon.horman@netronome.com, Sriram Dash <sriram.dash@samsung.com>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--53MC47IrhTQ4HgJg9q9nOJJDycTuMKIMf
Content-Type: multipart/mixed; boundary="0h3ZKPClZPFl2Svl2UqG7h4oe2TJefym9";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Pankaj Sharma <pankj.sharma@samsung.com>, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: wg@grandegger.com, davem@davemloft.net, pankaj.dubey@samsung.com,
 rcsekar@samsung.com, jhofstee@victronenergy.com, simon.horman@netronome.com,
 Sriram Dash <sriram.dash@samsung.com>
Message-ID: <51e2e2bf-1798-941c-79e4-d1339d4095a2@pengutronix.de>
Subject: Re: [PATCH v3] can: m_can: add support for handling arbitration error
References: <CGME20191030114039epcas5p434c9a7ffb715f2af2f4d3745239b5bbd@epcas5p4.samsung.com>
 <1572435539-3315-1-git-send-email-pankj.sharma@samsung.com>
In-Reply-To: <1572435539-3315-1-git-send-email-pankj.sharma@samsung.com>

--0h3ZKPClZPFl2Svl2UqG7h4oe2TJefym9
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 10/30/19 12:38 PM, Pankaj Sharma wrote:
> The Bosch MCAN hardware (3.1.0 and above) supports interrupt flag to
> detect Protocol error in arbitration phase.
>=20
> Transmit error statistics is currently not updated from the MCAN driver=
=2E
> Protocol error in arbitration phase is a TX error and the network
> statistics should be updated accordingly.
>=20
> The member "tx_error" of "struct net_device_stats" should be incremente=
d
> as arbitration is a transmit protocol error. Also "arbitration_lost" of=

> "struct can_device_stats" should be incremented to report arbitration
> lost.
>=20
> Signed-off-by: Pankaj Sharma <pankj.sharma@samsung.com>
> Signed-off-by: Sriram Dash <sriram.dash@samsung.com>

Added to linux-can-next.

Tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--0h3ZKPClZPFl2Svl2UqG7h4oe2TJefym9--

--53MC47IrhTQ4HgJg9q9nOJJDycTuMKIMf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl3CodUACgkQWsYho5Hk
nSDIwQf+KnF4Iy1ams3ZQI103hBt1kC7kJSz5s/ZOurGAm+3A81bANjLl6NRkA+C
Mv+bNvJon3PP70AuJ/92Ng1i8AzCGbSD0W7/o67ohIPt5KtOokYhGLNiC8ooNTzm
Vuvn2QqwNKUXa9CyErrar6N0p3Ufwn/kLLWbbvgWScZd9DyvOW4MYQH+cioWsnRA
YZYSI8f/Ra5UkVoQoMPxfF+kOJxs1yV5YIfu50CPNQKNsdrXm24y2TcS17h0AtYF
pW3XeUuZ8FBgiyNXRiwWX8yN1JxWUJIJAqrFE3yyBTtOj3AIvkASTfPl9Hp+KwS9
hpbrxAr032w6O1sf4G8kCkp5ivfX4g==
=eeEE
-----END PGP SIGNATURE-----

--53MC47IrhTQ4HgJg9q9nOJJDycTuMKIMf--
