From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: gs_usb: fix return value of the "set_bittiming"
 callback
Date: Fri, 15 Dec 2017 14:27:55 +0100
Message-ID: <0f752fcb-64bf-d471-b376-48d4c2cf53c7@pengutronix.de>
References: <7e1d101e-9c10-4067-ab6e-91c4338670d3@grandegger.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="DRV77pmIGacEJOvpdS2UmXfKkXXwcOiH1"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:54873 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755489AbdLON2F (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 15 Dec 2017 08:28:05 -0500
In-Reply-To: <7e1d101e-9c10-4067-ab6e-91c4338670d3@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Maximilian Schneider <max@schneidersoft.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DRV77pmIGacEJOvpdS2UmXfKkXXwcOiH1
Content-Type: multipart/mixed; boundary="nUbDO4Kf4Uo5Ui6CGoWFScdKa3BLseXOa";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Wolfgang Grandegger <wg@grandegger.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Maximilian Schneider <max@schneidersoft.net>
Message-ID: <0f752fcb-64bf-d471-b376-48d4c2cf53c7@pengutronix.de>
Subject: Re: [PATCH] can: gs_usb: fix return value of the "set_bittiming"
 callback
References: <7e1d101e-9c10-4067-ab6e-91c4338670d3@grandegger.com>
In-Reply-To: <7e1d101e-9c10-4067-ab6e-91c4338670d3@grandegger.com>

--nUbDO4Kf4Uo5Ui6CGoWFScdKa3BLseXOa
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 12/13/2017 07:52 PM, Wolfgang Grandegger wrote:
> The "set_bittiming" callback treats a positive return value as error!
> For that reason "can_changelink()" will quit silently after setting
> the bittiming values without processing ctrlmode, restart-ms, etc.
>=20
> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
> ---
>  drivers/net/can/usb/gs_usb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.=
c
> index 68ac3e8..52907d4 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c
> @@ -449,7 +449,7 @@ static int gs_usb_set_bittiming(struct net_device *=
netdev)
>  		dev_err(netdev->dev.parent, "Couldn't set bittimings (err=3D%d)",
>  			rc);
> =20
> -	return rc;
> +	return rc < 0 ? rc : 0;
>  }
> =20
>  static void gs_usb_xmit_callback(struct urb *urb)
>=20

I've changed the patch to:
index 8bf80ad9dc44..3ed2a47e3af0 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -267,7 +267,7 @@ static int gs_cmd_reset(struct gs_usb *gsusb, struct =
gs_can *gsdev)

        kfree(dm);

-       return rc;
+       return (rc > 0) ? 0 : rc;
 }

As some other code in the driver already uses this.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--nUbDO4Kf4Uo5Ui6CGoWFScdKa3BLseXOa--

--DRV77pmIGacEJOvpdS2UmXfKkXXwcOiH1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlozzdsACgkQHv7KIOw4
HPbGVwgAh8gpqVY/xxZSwZxiSjSmEwiUBhsmeWJ1X/VYpXY/eT0QmH8YWiG8oTut
diS+Q7ZwMmnsaRnPXHeBw6xPjyZU70SWygOfaot/4UGTaTuYlsg0T+Fxp2+5cH9e
AwIWRE10skt75KE3R+jfGZkNVeJWd39NGQtSKChcNsZE5NNrwZxbMjH2fVzYiowB
dJYL3WuRzi4Dm/NyX9CLYkdyTZZ7ykW74oqcX4QRr/diBPk4aznYlK8UuWz3gzLz
BONqgBsaTh3H4vmUOypsk4YrOyr+AFm3/BlJodyjwLR3gO0WWDFxjcBsxf7M2nl8
nJXnQZUyKM9VhcdESmGUvhmlynqxIw==
=vgVf
-----END PGP SIGNATURE-----

--DRV77pmIGacEJOvpdS2UmXfKkXXwcOiH1--
