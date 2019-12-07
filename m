From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH V3 0/6] can: flexcan: fixes for stop mode
Date: Sat, 7 Dec 2019 15:10:54 +0100
Message-ID: <67da1a42-f3d3-6ac1-e5f9-211d2da00ba3@pengutronix.de>
References: <20191204113249.3381-1-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="ycQUMqggH0Flcqx6hA22owqu8FToNnCwG"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191204113249.3381-1-qiangqing.zhang@nxp.com>
Sender: netdev-owner@vger.kernel.org
To: Joakim Zhang <qiangqing.zhang@nxp.com>, "sean@geanix.com" <sean@geanix.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ycQUMqggH0Flcqx6hA22owqu8FToNnCwG
Content-Type: multipart/mixed; boundary="G5HJZyHAi8udaunguHWzlGTRXiIoaL1et";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Joakim Zhang <qiangqing.zhang@nxp.com>, "sean@geanix.com"
 <sean@geanix.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Message-ID: <67da1a42-f3d3-6ac1-e5f9-211d2da00ba3@pengutronix.de>
Subject: Re: [PATCH V3 0/6] can: flexcan: fixes for stop mode
References: <20191204113249.3381-1-qiangqing.zhang@nxp.com>
In-Reply-To: <20191204113249.3381-1-qiangqing.zhang@nxp.com>

--G5HJZyHAi8udaunguHWzlGTRXiIoaL1et
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 12/4/19 12:36 PM, Joakim Zhang wrote:
> Hi Marc,
>=20
>    I removed the patch (can: flexcan: try to exit stop mode during prob=
e stage)
> out of this patch set for now. This patch should further discuss with S=
ean and
> I will prepare it according to final conclusion. Thanks.
>=20
> Regards,
> Joakim Zhang
>=20
> Joakim Zhang (5):
>   can: flexcan: Ack wakeup interrupt separately
>   can: flexcan: add low power enter/exit acknowledgment helper
>   can: flexcan: change the way of stop mode acknowledgment

Above 3 applied to linux-can.

>   can: flexcan: propagate error value of flexcan_chip_stop()
>   can: flexcan: add LPSR mode support

Above 2 applied to linux-can-next

Marc
--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--G5HJZyHAi8udaunguHWzlGTRXiIoaL1et--

--ycQUMqggH0Flcqx6hA22owqu8FToNnCwG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl3rsu4ACgkQWsYho5Hk
nSCAiAgAqw7anwYTOjePxi2RpKgP+6rrr23CWyoohozVvX0MoXS2mQj25thcAB48
I95OiAlWeI6hsBEtjmjjS0EwR+bM/yoZ8ThewvfcYtOhqCLpxepi9dFT47WVvDXR
KFZFAr97s+n1gnOmkVDxUmEnE8jGTTQlxrOtptz+WsipWcFbt6pL2kQGsmdiMjyr
WKzP5eCpno3QVJzAsaLxevmHvNMOjTJ59RY1pMwRcyGcFsHn0R8C9RBA9qAe6k3M
sK13Vhz5p6MmiOpw7xaFYpID0jHg5O3MnLOIwKFkuqQrmHTDL+sfCH+I0bL+0fMz
eKwPyX8jFunfW+69iZpyFca6idhsiw==
=vNel
-----END PGP SIGNATURE-----

--ycQUMqggH0Flcqx6hA22owqu8FToNnCwG--
