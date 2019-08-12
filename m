From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 0/5] can: xilinx_can: Bug fixes
Date: Mon, 12 Aug 2019 11:05:48 +0200
Message-ID: <7ecaa7df-3202-21d8-de93-5f6af3582964@pengutronix.de>
References: <1565594914-18999-1-git-send-email-appana.durga.rao@xilinx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="sagdrJZ59M6nkFUf5xCavfQsFxYSrlJdg"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1565594914-18999-1-git-send-email-appana.durga.rao@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>, wg@grandegger.com, davem@davemloft.net, michal.simek@xilinx.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sagdrJZ59M6nkFUf5xCavfQsFxYSrlJdg
Content-Type: multipart/mixed; boundary="XU6lLjqMQHKkznFu7DXacI3ue2hegnNB3";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>,
 wg@grandegger.com, davem@davemloft.net, michal.simek@xilinx.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Message-ID: <7ecaa7df-3202-21d8-de93-5f6af3582964@pengutronix.de>
Subject: Re: [PATCH 0/5] can: xilinx_can: Bug fixes
References: <1565594914-18999-1-git-send-email-appana.durga.rao@xilinx.com>
In-Reply-To: <1565594914-18999-1-git-send-email-appana.durga.rao@xilinx.com>

--XU6lLjqMQHKkznFu7DXacI3ue2hegnNB3
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 8/12/19 9:28 AM, Appana Durga Kedareswara rao wrote:
> This patch series fixes below issues
> --> Bugs in the driver w.r.to CANFD 2.0 IP support
> --> Defer the probe if clock is not found
>=20
> Appana Durga Kedareswara rao (3):
>   can: xilinx_can: Fix FSR register handling in the rx path
>   can: xilinx_can: Fix the data updation logic for CANFD FD frames
>   can: xilinx_can: Fix FSR register FL and RI mask values for canfd 2.0=

>=20
> Srinivas Neeli (1):
>   can: xilinx_can: Fix the data phase btr1 calculation
>=20
> Venkatesh Yadav Abbarapu (1):
>   can: xilinx_can: defer the probe if clock is not found

Please add your S-o-b to patches 4+5.

As these all are bugfixes please add a reference to the commit it fixes:

    Fixes: commitish ("description")

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--XU6lLjqMQHKkznFu7DXacI3ue2hegnNB3--

--sagdrJZ59M6nkFUf5xCavfQsFxYSrlJdg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl1RK+wACgkQWsYho5Hk
nSD1iwf/cx5osypGvF69/hTY7cVJveyYYou0gzGEDicu7r8hBO4NrzPu1Bew52DG
ktwAOqELBNDvHXTNZNXk+6wbOUfBpgTVt+jkGqZV67I1W6RL9H85mvE1AUPaJQZN
5l0Vj0FPgbtcM0ERo009PAgGUoW1zYEZTHTqh7ZUqCQ8DXDN4rhL2F1SPe1O2tC3
khy2JD/m6kYb1YAMR7eDmvliM1fAnPJ6ZGpuxIfFrZTr3iX6hACTTxb/CYV0+Pf4
AzH31YtflWXAmjn0001MFmwTW3phfPXwS0qB+gjwBQspjzt4wpMxCRLLSE0nImD/
z6NdxAEEC/xXts1l5F3iRSSAMUDQeQ==
=fZEP
-----END PGP SIGNATURE-----

--sagdrJZ59M6nkFUf5xCavfQsFxYSrlJdg--
