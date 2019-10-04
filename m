From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: peakcan: report bus recovery as well
Date: Fri, 4 Oct 2019 23:15:41 +0200
Message-ID: <ec53be09-bb1e-90b5-cb0a-f9f0643df800@pengutronix.de>
References: <20190925085824.4708-1-jhofstee@victronenergy.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="blD1oht6kpsNjdxWBp7jdd3QmfVUbVoj0"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190925085824.4708-1-jhofstee@victronenergy.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeroen Hofstee <jhofstee@victronenergy.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Stephane Grosjean <s.grosjean@peak-system.com>, Wolfgang Grandegger <wg@grandegger.com>, "David S. Miller" <davem@davemloft.net>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--blD1oht6kpsNjdxWBp7jdd3QmfVUbVoj0
Content-Type: multipart/mixed; boundary="Hzn4Rg2vCRtx4pOqGCZy6T2HKK0vQYBmy";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Jeroen Hofstee <jhofstee@victronenergy.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Stephane Grosjean <s.grosjean@peak-system.com>,
 Wolfgang Grandegger <wg@grandegger.com>,
 "David S. Miller" <davem@davemloft.net>,
 "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Message-ID: <ec53be09-bb1e-90b5-cb0a-f9f0643df800@pengutronix.de>
Subject: Re: [PATCH] can: peakcan: report bus recovery as well
References: <20190925085824.4708-1-jhofstee@victronenergy.com>
In-Reply-To: <20190925085824.4708-1-jhofstee@victronenergy.com>

--Hzn4Rg2vCRtx4pOqGCZy6T2HKK0vQYBmy
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 9/25/19 10:58 AM, Jeroen Hofstee wrote:
> While the state changes are reported when the error counters increase
> and decrease, there is no event when the bus recovers and the error
> counters decrease again. So add those as well.
>=20
> Change the state going downward to be ERROR_PASSIVE -> ERROR_WARNING ->=

> ERROR_ACTIVE instead of directly to ERROR_ACTIVE again.
>=20
> Signed-off-by: Jeroen Hofstee <jhofstee@victronenergy.com>
> Cc: Stephane Grosjean <s.grosjean@peak-system.com>

Applied to linux-can.

Tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--Hzn4Rg2vCRtx4pOqGCZy6T2HKK0vQYBmy--

--blD1oht6kpsNjdxWBp7jdd3QmfVUbVoj0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl2Xtn0ACgkQWsYho5Hk
nSDsvwf/b5OxYblVd6n3qKvWtkl9kos5IEohPhx6O5pj8FH0zCFELZPETMMpU28s
64UZBviNw3Ieg5cX08730ghOQ8+spxg6Vm7HIE5hbKBOWs9HSlMU13hRmjRrRZIU
DIpPi+d3AZXejCVwHUPn5fwL5MT1G75pSF/d0FTEVaA4S8PudNybplo4TG9E4Lc8
006jAABbN9K4PJjZn1qJHF1Zq15R4bpLkbACBxLmhRAdsNz1X2jt8aoNRWBWpScA
gFr7o88x512Tq8SdnhRLd9zYA/UYLbXRlxGU1TQ2ihaO1wGcLjqBIfmJpx10ivS9
dblb7NcFg3SUNbzmJ3D6TAvvD68wLg==
=9q2E
-----END PGP SIGNATURE-----

--blD1oht6kpsNjdxWBp7jdd3QmfVUbVoj0--
