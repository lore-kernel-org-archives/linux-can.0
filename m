From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: flexcan: add hardware controller version support
Date: Mon, 02 Jul 2012 09:23:59 +0200
Message-ID: <4FF14C8F.6080604@pengutronix.de>
References: <1341174085-11781-1-git-send-email-mkl@pengutronix.de> <4FF10668.4000504@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9CD06618AE7569E8A0D819E9"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38537 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932139Ab2GBHYG (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 2 Jul 2012 03:24:06 -0400
In-Reply-To: <4FF10668.4000504@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Hui Wang <jason77.wang@gmail.com>
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de, Wolfgang Grandegger <wg@grandegger.com>, Shawn Guo <shawn.guo@linaro.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9CD06618AE7569E8A0D819E9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 07/02/2012 04:24 AM, Hui Wang wrote:
> Marc Kleine-Budde wrote:
>> From: Hui Wang <jason77.wang@gmail.com>
>>
>> At least in the i.MX series, the flexcan contrller divides into ver_3
>> and ver_10, current driver is for ver_3 controller.
>>
>> i.MX6 has ver_10 controller, it has more reigsters than ver_3 has.
>> The rxfgmask (Rx FIFO Global Mask) register is one of the new added.
>> Its reset value is 0xffffffff, this means ID Filter Table must be
>> checked when receive a packet, but the driver is designed to accept
>> everything during the chip start, we need to clear this register to
>> follow this design.
>>
>> Use the data entry of the struct of_device_id to point chip specific
>> info, we can set hardware version for each platform.
>>
>> Cc: linux-can@vger.kernel.org
>> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
>> Cc: Wolfgang Grandegger <wg@grandegger.com>
>> Cc: Shawn Guo <shawn.guo@linaro.org>
>> Signed-off-by: Hui Wang <jason77.wang@gmail.com>
>> [mkl: add id_table support]
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>> ---
>> Hui Wang,
>>
>> can you please test if this works for you on mx6.
>>  =20
> Sorry for reply late.
>=20
> This patch works well on the mx6. But i found a minor problem, please
> see below.
>> regards, Marc
>>
>>
>>  drivers/net/can/flexcan.c |   61
>> +++++++++++++++++++++++++++++++++++++++------
>>  1 file changed, 53 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
>>
>>  =20
> <snip>
>>      }
>> =20
>> +    of_id =3D of_match_device(flexcan_of_match, &pdev->dev);
>> +    if (of_id) {
>> +        devtype_data =3D of_id->data;
>> +    } else if (pdev->id_entry->driver_data) {
>> +        devtype_data =3D (struct flexcan_devtype_data *)
>> +            pdev->id_entry->driver_data;
>> +    } else {
>> +        err =3D -ENODEV;
>> +        goto failed_devtype;
>> +    }
>> +
>>      dev->netdev_ops =3D &flexcan_netdev_ops;
>>      dev->irq =3D irq;
>>      dev->flags |=3D IFF_ECHO;
>> =20
>>      priv =3D netdev_priv(dev);
>> +    priv->devtype_data =3D devtype_data;
>>      priv->can.clock.freq =3D clock_freq;
>>      priv->can.bittiming_const =3D &flexcan_bittiming_const;
>>      priv->can.do_set_mode =3D flexcan_set_mode;
>> @@ -993,6 +1042,7 @@ static int __devinit flexcan_probe(struct
>> platform_device *pdev)
>>      priv->dev =3D dev;
>>      priv->clk =3D clk;
>>      priv->pdata =3D pdev->dev.platform_data;
>> +    priv->devtype_data =3D devtype_data;
>>  =20
> Two priv->devtype_data =3D devtype_data; ?
>=20
> It seems one of them is redundant and is not needed.

Thanks,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig9CD06618AE7569E8A0D819E9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/xTI8ACgkQjTAFq1RaXHPMXwCggDCazxOT2+CpaTg+RcagMen7
4ZkAn0gya2jb0+YRRx+CW9JSYFD5EnwP
=VlZU
-----END PGP SIGNATURE-----

--------------enig9CD06618AE7569E8A0D819E9--
