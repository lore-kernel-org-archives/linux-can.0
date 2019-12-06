From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 0/2] can: m_can_platform: Bug fix of kernel panic for
Date: Fri, 6 Dec 2019 08:39:02 +0100
Message-ID: <a967e70e-456d-7855-6bb1-2e2285ce6f9b@pengutronix.de>
References: <CGME20191119102134epcas5p4d3c1b18203e2001c189b9fa7a0e3aab5@epcas5p4.samsung.com>
 <1574158838-4616-1-git-send-email-pankj.sharma@samsung.com>
 <f0550b0b-6681-75a3-c58a-28f5b7ca0821@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="J7PAfLCnD6GAAUfn5Afj7StQLBgIq7dkS"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f0550b0b-6681-75a3-c58a-28f5b7ca0821@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>, Pankaj Sharma <pankj.sharma@samsung.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: wg@grandegger.com, davem@davemloft.net, rcsekar@samsung.com, pankaj.dubey@samsung.com
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--J7PAfLCnD6GAAUfn5Afj7StQLBgIq7dkS
Content-Type: multipart/mixed; boundary="R6Lpc9rHMptUxg3wRCeFA8vNFLQfkt4PV";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Dan Murphy <dmurphy@ti.com>, Pankaj Sharma <pankj.sharma@samsung.com>,
 linux-can@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: wg@grandegger.com, davem@davemloft.net, rcsekar@samsung.com,
 pankaj.dubey@samsung.com
Message-ID: <a967e70e-456d-7855-6bb1-2e2285ce6f9b@pengutronix.de>
Subject: Re: [PATCH 0/2] can: m_can_platform: Bug fix of kernel panic for
References: <CGME20191119102134epcas5p4d3c1b18203e2001c189b9fa7a0e3aab5@epcas5p4.samsung.com>
 <1574158838-4616-1-git-send-email-pankj.sharma@samsung.com>
 <f0550b0b-6681-75a3-c58a-28f5b7ca0821@ti.com>
In-Reply-To: <f0550b0b-6681-75a3-c58a-28f5b7ca0821@ti.com>

--R6Lpc9rHMptUxg3wRCeFA8vNFLQfkt4PV
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 12/5/19 9:57 PM, Dan Murphy wrote:
> Pankaj
>=20
> On 11/19/19 4:20 AM, Pankaj Sharma wrote:
>> The current code is failing while clock prepare enable because of not
>> getting proper clock from platform device.
>> A device driver for CAN controller hardware registers itself with the
>> Linux network layer as a network device. So, the driver data for m_can=

>> should ideally be of type net_device.
>>
>> Further even when passing the proper net device in probe function the
>> code was hanging because of the function m_can_runtime_resume() gettin=
g
>> recursively called from m_can_class_resume().
>>
>> Pankaj Sharma (2):
>>    can: m_can_platform: set net_device structure as driver data
>>    can: m_can_platform: remove unnecessary m_can_class_resume() call
>=20
> Did you CC: linux-stable for these?=C2=A0 We are probably going to have=
=20
> customers picking up 5.4 LTS and would need these bug fixes.

Both patches made it into the v5.4 release. So no need for stable.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--R6Lpc9rHMptUxg3wRCeFA8vNFLQfkt4PV--

--J7PAfLCnD6GAAUfn5Afj7StQLBgIq7dkS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl3qBZYACgkQWsYho5Hk
nSAGuAgAp5+CFD1N0dWgqU7yjdFbAf6OalnacbP2rmsjsvwt/qyQZQbagbBkYOE6
0feJAdi+qoOaWSwzWRR7C0C8iMui7BgoNxSVruj9sbuOU1EovwCleeGXOBGV/CJH
8qO729v18hVFQeV/vT+f5ZrKVmxB/Uf2Ub6jb4E+vyaaLd/X3iMsYpmsaJTcISTA
nZYSOBX2atcQsJizcr4eSnLNhvMof92L+swrtOcA5epMG7fXJ+cZxgLwT0xOlz6a
fMzrfDkKi83duGa0R3N5WRaWrCCPyG5uy9C4JJ8uuyZKcI9hGe85V3WyN+c7yOL2
w2rPULjEMM5EIRE+mK2ZhJAKoxHcgQ==
=D87v
-----END PGP SIGNATURE-----

--J7PAfLCnD6GAAUfn5Afj7StQLBgIq7dkS--
