From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 2/2] net: m_can: Make wake-up gpio an optional
Date: Thu, 5 Dec 2019 16:35:50 +0100
Message-ID: <e945f9da-f5a1-64b9-3c5e-5ca249fbed16@pengutronix.de>
References: <20191204175112.7308-1-dmurphy@ti.com>
 <20191204175112.7308-2-dmurphy@ti.com>
 <b9eaa5c4-13bc-295f-dcbf-d2a846243682@geanix.com>
 <827b022e-9188-7bcf-25e3-3777df3b08a5@ti.com>
 <809b9ff1-88e3-4e46-33e0-856db37898b2@pengutronix.de>
 <76e96337-bbcf-89f1-2f1c-45144c15cb5b@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Wc3YXHL1XLvzdI9vz7XTtzADIEYftsVJw"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <76e96337-bbcf-89f1-2f1c-45144c15cb5b@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>, Sean Nyekjaer <sean@geanix.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Sriram Dash <sriram.dash@samsung.com>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Wc3YXHL1XLvzdI9vz7XTtzADIEYftsVJw
Content-Type: multipart/mixed; boundary="dTwGmQcY3cJl9phvti4yfNLUSimxXhLDz";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Dan Murphy <dmurphy@ti.com>, Sean Nyekjaer <sean@geanix.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Sriram Dash <sriram.dash@samsung.com>
Message-ID: <e945f9da-f5a1-64b9-3c5e-5ca249fbed16@pengutronix.de>
Subject: Re: [PATCH 2/2] net: m_can: Make wake-up gpio an optional
References: <20191204175112.7308-1-dmurphy@ti.com>
 <20191204175112.7308-2-dmurphy@ti.com>
 <b9eaa5c4-13bc-295f-dcbf-d2a846243682@geanix.com>
 <827b022e-9188-7bcf-25e3-3777df3b08a5@ti.com>
 <809b9ff1-88e3-4e46-33e0-856db37898b2@pengutronix.de>
 <76e96337-bbcf-89f1-2f1c-45144c15cb5b@ti.com>
In-Reply-To: <76e96337-bbcf-89f1-2f1c-45144c15cb5b@ti.com>

--dTwGmQcY3cJl9phvti4yfNLUSimxXhLDz
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 12/5/19 4:01 PM, Dan Murphy wrote:
>> Dan, what about maintainerchip of the tcan4x5?
>=20
> Ooops that was buried in my inbox.
>=20
> It only makes sense for someone from TI to take maintainership of the=20
> TCAN device.

Sriram Dash (Cc'ed) is maintainer of the MMIO driver:

> +F:     Documentation/devicetree/bindings/net/can/m_can.txt            =
                                                                         =
                                                                  =20
> +F:     drivers/net/can/m_can/m_can.c                                  =
                                                                         =
                                                                  =20
> +F:     drivers/net/can/m_can/m_can.h                                  =
                                                                         =
                                                                  =20
> +F:     drivers/net/can/m_can/m_can_platform.c                         =
                                                                         =
                                                                  =20

See:

> Do I need to submit a patch to the maintainers file or is the authorshi=
p=20
> enough?

Yes, please send a patch, see Sriram's patch as an example:

> https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git/commi=
t/?h=3Dlinux-can-fixes-for-5.5-20191203&id=3D8c2a58568d6d952f7c7f1dac125b=
33dc8414627b

> As far as a device what country do you reside in?

Germany, I'll drop you the address in a private Mail.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--dTwGmQcY3cJl9phvti4yfNLUSimxXhLDz--

--Wc3YXHL1XLvzdI9vz7XTtzADIEYftsVJw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl3pI9YACgkQWsYho5Hk
nSChZwf9GVUthIYenwb3wykFFV+orR1ib18vyom95EkMPLE8A0gkVpORZNVyuW/0
flw90u5CDPJEargPlGsjsnqdXpOTByAbHJLeoJIZGY5ILBuYQzPVS1YWzxHShX/O
U3R5qRG14DnY2b9dhbOUM91ri9ZL3arIh5BNwdIjzsari+LopKBdKCJr6LSO0wcx
bJ7QYKCbQossyRLVdKY9lZfLGAGFhgj6hGk+N4qzx+d6o5nu7JuSDZ1qQp+hBUYl
pxhJPR/kRyHbNLiIXFDaRUcPrNqGWg20W/2U2R2kygk8agvuOjnitiKeaqZq4yMJ
7LMoeSmJz/KDnGi3miLxYr1FO6yR9A==
=iM6m
-----END PGP SIGNATURE-----

--Wc3YXHL1XLvzdI9vz7XTtzADIEYftsVJw--
