From: Martin Elshuber <martin.elshuber@theobroma-systems.com>
Subject: Re: [PATCH can-next] can: ucan: remove set but not used variable
 'udev'
Date: Mon, 10 Sep 2018 15:41:20 +0200
Message-ID: <6c5a4c2e-3c82-1a40-3b8d-16b19c37f165@theobroma-systems.com>
References: <1535507214-145191-1-git-send-email-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="5NhB3tq3r3L5iddUYSwYwGWc8F621xOuQ"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1535507214-145191-1-git-send-email-yuehaibing@huawei.com>
Sender: netdev-owner@vger.kernel.org
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5NhB3tq3r3L5iddUYSwYwGWc8F621xOuQ
Content-Type: multipart/mixed; boundary="s0qqF7t7EztvqtlT7yOTdPQp4zRdyQgz3";
 protected-headers="v1"
From: Martin Elshuber <martin.elshuber@theobroma-systems.com>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Message-ID: <6c5a4c2e-3c82-1a40-3b8d-16b19c37f165@theobroma-systems.com>
Subject: Re: [PATCH can-next] can: ucan: remove set but not used variable
 'udev'
References: <1535507214-145191-1-git-send-email-yuehaibing@huawei.com>
In-Reply-To: <1535507214-145191-1-git-send-email-yuehaibing@huawei.com>

--s0qqF7t7EztvqtlT7yOTdPQp4zRdyQgz3
Content-Type: text/plain; charset=utf-8
Content-Language: de-AT
Content-Transfer-Encoding: quoted-printable

Thank you for the fix

Reviewed-by: Martin Elshuber <martin.elshuber@theobroma-systems.com>

> Fixes gcc '-Wunused-but-set-variable' warning:
>=20
> drivers/net/can/usb/ucan.c: In function 'ucan_disconnect':
> drivers/net/can/usb/ucan.c:1578:21: warning:
>  variable 'udev' set but not used [-Wunused-but-set-variable]
>   struct usb_device *udev;
>=20
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/net/can/usb/ucan.c | 3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/drivers/net/can/usb/ucan.c b/drivers/net/can/usb/ucan.c
> index 0678a38..c9fd83e 100644
> --- a/drivers/net/can/usb/ucan.c
> +++ b/drivers/net/can/usb/ucan.c
> @@ -1575,11 +1575,8 @@ static int ucan_probe(struct usb_interface *intf=
,
>  /* disconnect the device */
>  static void ucan_disconnect(struct usb_interface *intf)
>  {
> -	struct usb_device *udev;
>  	struct ucan_priv *up =3D usb_get_intfdata(intf);
> =20
> -	udev =3D interface_to_usbdev(intf);
> -
>  	usb_set_intfdata(intf, NULL);
> =20
>  	if (up) {
>=20



--s0qqF7t7EztvqtlT7yOTdPQp4zRdyQgz3--

--5NhB3tq3r3L5iddUYSwYwGWc8F621xOuQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQIcBAEBCgAGBQJblnSBAAoJENNzc6lDjKRXI/YP/09Ry0AMxjnMfBCrjr7tn/Hu
4n2Xx4Be8UxkI05tirDkVY2NmDG8afudw9ThNEVvQT4YWPLnVQei8sFYz2Em5LIs
NW7bhoJ3ZoEIMD5YTALqWFitUmTFfIWAh0SRhZPtJXGx2taBNFTnFChSK2PJN5k7
kU+WyBY5KD4k2ClvJ/5c+MJCUFZR4HcdJzTaEtdALt7uabZ0X57BFKA15KXPhgEY
MGLEy0C7vMlIv3fjx2kg7dikNA+3418sllortOHpl7ixgE9fxDVTEtbyqfXZ9B45
TcsPA8hgwR6WkywV8lwyw4t6tFy+pEb8XlmNWMtyPwMK7t2VWQP4+rp0AxL+hRLO
Od4uMU4NzWro9qcN2joA6DoS6FGJkau7tR8HSu70nLN8kiYymWHWw8kzIaJm+FOt
AGSyIk88Y1xbghVmqcgFQ9BcLpc+sMhsRoV/exbOXFiAtrGrX3g0/y+wyVob1Wyt
OaCFQZIgJwdh+x081f43GfnrwwWGdIqGkYxnmQnRIN1pLgylwRzdSMXl6NiVXcdD
KLBph4WcxcpIUFuTstKX5hH2Q3cNCQn6sXDwVlgBILZt2r3stitRMUTu3Mdzw32+
RwPTgHSkOCe/Wqkc7Ld/Uz95Qb6qee+H9Guwpmgd8xT64aIMlhgO8G8lfraPo4er
sEOjqhQna0MLpI2XJim6
=4kel
-----END PGP SIGNATURE-----

--5NhB3tq3r3L5iddUYSwYwGWc8F621xOuQ--
