From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: c_can: fix segfault during rmmod
Date: Thu, 27 Sep 2012 13:11:56 +0200
Message-ID: <5064347C.3020706@pengutronix.de>
References: <1348742499-6526-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigDFD6274C2E755910762F4382"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48938 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753579Ab2I0LMG (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 27 Sep 2012 07:12:06 -0400
In-Reply-To: <1348742499-6526-1-git-send-email-anilkumar@ti.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: AnilKumar Ch <anilkumar@ti.com>
Cc: wg@grandegger.com, swarren@wwwdotorg.org, linux-can@vger.kernel.org, anantgole@ti.com, nsekhar@ti.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDFD6274C2E755910762F4382
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 09/27/2012 12:41 PM, AnilKumar Ch wrote:
> This patch fixes an oops which occurs during unloading the driver. The
> problem is that clock is not enabled during unregister_c_can_dev()
> which does c_can/d_can module interrupts enable/disable.

Looking at the code, I see that
    c_can_enable_all_interrupts(priv, DISABLE_ALL_INTERRUPTS);
is called during c_can_stop().

This should be sufficient as during unregister_netdev() the driver's
close function will be called (it the netdev is still opened) [1].

I think your patch
    4cdd34b can: c_can: Add runtime PM support to Bosch C_CAN/D_CAN contr=
oller
has not reached the David's net branch, so I prefer to remove the
offending:
    c_can_enable_all_interrupts(priv, DISABLE_ALL_INTERRUPTS);
call from the unregister_c_can_dev().

Marc

[1] I recently fixed a OOPS in another driver with this stack trace:

    [  172.954498] [<bf00c768>] (ti_hecc_close+0xb0/0x100 [ti_hecc]) from=
 [<c033be58>] (__dev__registered_many+0xc0/0x2a0)
    [  172.984161] [<c033c098>] (rollback_registered_many+0xc0/0x2a0) fro=
m [<c033c2f8>] (rollback_registered+0x20/0x30)
    [  172.994750] [<c033c2f8>] (rollback_registered+0x20/0x30) from [<c0=
33c370>] (unregister_netdevice_queue+0x68/0x98)
    [  173.005401] [<c033c370>] (unregister_netdevice_queue+0x68/0x98) fr=
om [<c033c3b8>] (unregister_netdev+0x18/0x20)
    [  173.015899] [<c033c3b8>] (unregister_netdev+0x18/0x20) from [<bf00=
d3ac>] (ti_hecc_remove+0x60/0x80 [ti_hecc])
    [  173.026245] [<bf00d3ac>] (ti_hecc_remove+0x60/0x80 [ti_hecc]) from=
 [<c02842dc>] (platform_drv_remove+0x14/0x18)
    [  173.036712] [<c02842dc>] (platform_drv_remove+0x14/0x18) from [<c0=
282f90>] (__device_release_driver+0x7c/0xbc)

Marc

>=20
> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> ---
>  drivers/net/can/c_can/c_can.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_ca=
n.c
> index 2c4a21f..638e3cc 100644
> --- a/drivers/net/can/c_can/c_can.c
> +++ b/drivers/net/can/c_can/c_can.c
> @@ -1265,8 +1265,10 @@ void unregister_c_can_dev(struct net_device *dev=
)
>  {
>  	struct c_can_priv *priv =3D netdev_priv(dev);
> =20
> +	c_can_pm_runtime_get_sync(priv);
>  	/* disable all interrupts */
>  	c_can_enable_all_interrupts(priv, DISABLE_ALL_INTERRUPTS);
> +	c_can_pm_runtime_put_sync(priv);
> =20
>  	unregister_candev(dev);
> =20
>=20


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigDFD6274C2E755910762F4382
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlBkNIAACgkQjTAFq1RaXHPwkQCfciPyFmliDZj+2CwuV7K4CC71
M9YAoISnSXCcX77ZL2GxPntYqdKEBPxN
=VKNQ
-----END PGP SIGNATURE-----

--------------enigDFD6274C2E755910762F4382--
