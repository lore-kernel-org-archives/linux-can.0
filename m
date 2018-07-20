From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 0/5] can: enable multi-queue for SocketCAN devices
Date: Fri, 20 Jul 2018 16:36:23 +0200
Message-ID: <06646b4d-52c3-4839-0bbe-a782db42ce7c@pengutronix.de>
References: <f858e62c59754a0c9f785b3dfc7aa50f@de.bosch.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="9bDmvbzgCcCXDjfJWWuAEMSF5yOsHje1N"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f858e62c59754a0c9f785b3dfc7aa50f@de.bosch.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>, Wolfgang Grandegger <wg@grandegger.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "hs@denx.de" <hs@denx.de>, "ZHU Yi (BT-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>, "Petrovic Petar (CM-CI1/ENP1)" <Petar.Petrovic2@de.bosch.com>, "Baetge Stephan (CM-CI1/ENP1)" <Stephan.Baetge@de.bosch.com>, "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>, "socketcan@hartkopp.net" <socketcan@hartkopp.net>, "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9bDmvbzgCcCXDjfJWWuAEMSF5yOsHje1N
Content-Type: multipart/mixed; boundary="F6ycatdmei4JAPqsla2oUHKy1kNKHejbW";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>,
 Wolfgang Grandegger <wg@grandegger.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "hs@denx.de" <hs@denx.de>, "ZHU Yi (BT-FIR/ENG1-Zhu)"
 <Yi.Zhu5@cn.bosch.com>,
 "Petrovic Petar (CM-CI1/ENP1)" <Petar.Petrovic2@de.bosch.com>,
 "Baetge Stephan (CM-CI1/ENP1)" <Stephan.Baetge@de.bosch.com>,
 "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
 "socketcan@hartkopp.net" <socketcan@hartkopp.net>,
 "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>
Message-ID: <06646b4d-52c3-4839-0bbe-a782db42ce7c@pengutronix.de>
Subject: Re: [PATCH v2 0/5] can: enable multi-queue for SocketCAN devices
References: <f858e62c59754a0c9f785b3dfc7aa50f@de.bosch.com>
In-Reply-To: <f858e62c59754a0c9f785b3dfc7aa50f@de.bosch.com>

--F6ycatdmei4JAPqsla2oUHKy1kNKHejbW
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 07/11/2018 07:00 PM, Jonas Mark (BT-FIR/ENG1) wrote:
> Hi Marc,
>=20
>> Betreff: [PATCH v2 0/5] can: enable multi-queue for SocketCAN devices
>=20
> You have been interested in seeing the reason why we are proposing the
> "can: enable multi-queue for SocketCAN devices" patch for the Linux
> mainline. So far I have not heard from you. Do you now see a chance of
> getting the patch accepted?

I've applied patch 1.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--F6ycatdmei4JAPqsla2oUHKy1kNKHejbW--

--9bDmvbzgCcCXDjfJWWuAEMSF5yOsHje1N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAltR82cACgkQk9IU1zQo
ZfFc7Qf/WOevY2KunZKlIUs49lIgWJGta/xB+sdrSidNnNo1J/1C2DBoTh2KtG8J
V7VNxMj6guJ9FMkUCtLrWJwobtzr4NJr9VjfrwAbssJwMJxwYdV9/JaQiieiwLZ9
0VdjxjpurDSh3t2ltb2txXYwKfwzo5IzA3kxg3MgV0hYs9EpdPryg+72EaJuaoGT
pqn9bFhsiiO5Klf3oJc4eRxklTLdElZUq/7LuGMC7zZm6K2YqKPXaLBFr9RAsPGu
Xe4VopR8SF5WAF3l6FMpc6g7JNsxV2CA0CGB1c0hRnSpfVeZwuc2AQrv+LbVB4c4
hV68zgspjhcAR3+lqlF4mjlJaTZXKA==
=09iI
-----END PGP SIGNATURE-----

--9bDmvbzgCcCXDjfJWWuAEMSF5yOsHje1N--
