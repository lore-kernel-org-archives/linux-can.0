From: Martin Elshuber <martin.elshuber@theobroma-systems.com>
Subject: Re: [PATCH can-next] can: ucan: remove duplicated include from ucan.c
Date: Mon, 10 Sep 2018 20:10:44 +0200
Message-ID: <8044e179-fdba-3da5-c474-405f661b3389@theobroma-systems.com>
References: <1535505945-143347-1-git-send-email-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Nm7msZHDmTvHj6aakUa2Toknt0ZMl5WD3"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1535505945-143347-1-git-send-email-yuehaibing@huawei.com>
Sender: netdev-owner@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>, Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Nm7msZHDmTvHj6aakUa2Toknt0ZMl5WD3
Content-Type: multipart/mixed; boundary="GVLmqNM6dREqQ75qdkAR4McKa37QeA3H7";
 protected-headers="v1"
From: Martin Elshuber <martin.elshuber@theobroma-systems.com>
To: YueHaibing <yuehaibing@huawei.com>,
 Wolfgang Grandegger <wg@grandegger.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller"
 <davem@davemloft.net>,
 Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Message-ID: <8044e179-fdba-3da5-c474-405f661b3389@theobroma-systems.com>
Subject: Re: [PATCH can-next] can: ucan: remove duplicated include from ucan.c
References: <1535505945-143347-1-git-send-email-yuehaibing@huawei.com>
In-Reply-To: <1535505945-143347-1-git-send-email-yuehaibing@huawei.com>

--GVLmqNM6dREqQ75qdkAR4McKa37QeA3H7
Content-Type: text/plain; charset=utf-8
Content-Language: de-AT
Content-Transfer-Encoding: quoted-printable

Thank you for the fix

Reviewed-by: Martin Elshuber <martin.elshuber@theobroma-systems.com>

Am 29.08.18 um 03:25 schrieb YueHaibing:
> Remove duplicated include.
>=20
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/net/can/usb/ucan.c | 4 ----
>  1 file changed, 4 deletions(-)
>=20
> diff --git a/drivers/net/can/usb/ucan.c b/drivers/net/can/usb/ucan.c
> index 0678a38..c6f4b41 100644
> --- a/drivers/net/can/usb/ucan.c
> +++ b/drivers/net/can/usb/ucan.c
> @@ -35,10 +35,6 @@
>  #include <linux/slab.h>
>  #include <linux/usb.h>
> =20
> -#include <linux/can.h>
> -#include <linux/can/dev.h>
> -#include <linux/can/error.h>
> -
>  #define UCAN_DRIVER_NAME "ucan"
>  #define UCAN_MAX_RX_URBS 8
>  /* the CAN controller needs a while to enable/disable the bus */
>=20



--GVLmqNM6dREqQ75qdkAR4McKa37QeA3H7--

--Nm7msZHDmTvHj6aakUa2Toknt0ZMl5WD3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQIcBAEBCgAGBQJblrOmAAoJENNzc6lDjKRXq1IQAJH0qAu6QLSSalo09ohMX1u6
PjSlBQUslvDqX7rH7XWuRtC4Twwd3fL2gCR8ipTLZjvCws3TckRPZhtJR+/6mgoP
t7KBX4pM6Ia3jJMc7+1X7fZpYijOLBQ4iuCGR7eAOtP+lhbZn/MHfFJDQ7pKGZqK
bMGicq4hKKzlmZN3awWb3lognPaboyFlvtdpOkPnnOlpRO6QXPKnkrqGjjSMGUmP
2pY4F1C8quVXLsNa0tpT9sLiKCvmYJ7lyB6ccmmcP7cJjecIBKptjkPYdULPObiK
PnT7btSEwGJo+WJv2iRo54+dZMDW4YraiMxPxoJ8OaYXOTOLombTvnsbOhk2PxCu
gcob2qkCVRNWDlDLr/wI9s10x2VhXJoW9/CTLqxIVzKTlBRr3G1Mqhexsww7E4y0
qCbU/Cfy57ePuQhemAbAV3WiDzchgUNJiJnaiwiMwZefxS+vI17QXJ1YzjgSxsU7
rZCi1ULy9xr4LUtZbP18qULjtkjda8CtaSuSPOC+kkf5KgiZbKb70cbMd8HX5iXv
sn0EF9BjAmiamRIWYdRqAlLyba5yIg3ts0sx5bhkpxd+CQt011HhyvF6UaXIhhP4
87oh6jFImkgoe3/H/wX+fUH/tkwvqCh2dlZYvWHz9nLYGi8yPZVLzSJAHioOnUqQ
+v0r5CZt4oz+/1fGdmVx
=E4n2
-----END PGP SIGNATURE-----

--Nm7msZHDmTvHj6aakUa2Toknt0ZMl5WD3--
