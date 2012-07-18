From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: flexcan: add 2nd clock to support imx53 and newer
Date: Wed, 18 Jul 2012 10:37:22 +0200
Message-ID: <500675C2.9090303@pengutronix.de>
References: <1342562748-24701-1-git-send-email-mkl@pengutronix.de> <50061B86.7080200@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig267E53159F5FC9F34CFDA2C7"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57019 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753081Ab2GRIhg (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 18 Jul 2012 04:37:36 -0400
In-Reply-To: <50061B86.7080200@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Hui Wang <jason77.wang@gmail.com>
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, Steffen Trumtrar <s.trumtrar@pengutronix.de>, Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig267E53159F5FC9F34CFDA2C7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 07/18/2012 04:12 AM, Hui Wang wrote:
> Marc Kleine-Budde wrote:
>> From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
>>
>> This patch add support for a second clock to the flexcan driver. On
>> modern
>> freescale ARM cores like the imx53 and imx6q two clocks ("ipg" and "pe=
r")
>> must be enabled in order to access the CAN core.
>>
>> In the original driver, the clock was requested without specifying the=

>> connection id, further all mainline ARM archs with flexcan support
>> (imx28, imx25, imx35) register their flexcan clock without a
>> connection id,
>> too.
>>
>> This patch first renames the existing clk variable to clk_ipg and adds=

>> the
>> connection id "ipg" to the clk_get() call. Then a second clock "per" i=
s
>> requested. As all archs don't specify a connection id, both clk_get
>> return
>> the same clock. This ensures compatibility to existing flexcan support=

>> and adds support for imx53 at the same time.
>>
>> After this patch hits mainline, the archs may give their existing flex=
can
>> clock the "ipg" connection id and implement a dummy "per" clock.
>>
>> This patch has been tested on imx28 (unmodified clk tree) and on imx53=

>> with a seperate "ipg" and "per" clock.
>>
>> Cc: Sascha Hauer <s.hauer@pengutronix.de>
>> Cc: Shawn Guo <shawn.guo@linaro.org>
>> Cc: Hui Wang <jason77.wang@gmail.com>
>> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>> ---
>>  drivers/net/can/flexcan.c |   52
>> ++++++++++++++++++++++++++++++---------------
>>  1 file changed, 35 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
>> index c8a6fc7..281d51f 100644
>> --- a/drivers/net/can/flexcan.c
>> +++ b/drivers/net/can/flexcan.c
>> @@ -190,7 +190,8 @@ struct flexcan_priv {
>>
>>  =20
> [...]
>>      if (!clock_freq) {
>> -        clk =3D clk_get(&pdev->dev, NULL);
>> -        if (IS_ERR(clk)) {
>> -            dev_err(&pdev->dev, "no clock defined\n");
>> -            err =3D PTR_ERR(clk);
>> +        clk_ipg =3D clk_get(&pdev->dev, "ipg");
>> +        if (IS_ERR(clk_ipg)) {
>> +            dev_err(&pdev->dev, "no ipg clock defined\n");
>> +            err =3D PTR_ERR(clk_ipg);
>> +            goto failed_clock;
>> +        }
>> +        clock_freq =3D clk_get_rate(clk_ipg);
>> +
>> +        clk_per =3D clk_get(&pdev->dev, "per");
>> +        if (IS_ERR(clk_per)) {
>> +            dev_err(&pdev->dev, "no per clock defined\n");
>> +            err =3D PTR_ERR(clk_per);
>>              goto failed_clock;
>>          }
>>  =20
> For those only register one clk and without con_id (mx35), clk_per will=

> equal to clk_ipg, how to handle this situation, modify mx35 clk tree?

This isn't a problem, the clock is just enabled twice. As soon as this
patch is mainline the clock tree on the one-clock-for-flexcan archs can
modify their clock tree. I've commented on this in the commit message,
have you read it?

>> -        clock_freq =3D clk_get_rate(clk);
>>      }
>> =20
>>      mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> @@ -1039,7 +1052,8 @@ static int __devinit flexcan_probe(struct
>> platform_device *pdev)
>>          CAN_CTRLMODE_BERR_REPORTING;
>>      priv->base =3D base;
>>      priv->dev =3D dev;
>> -    priv->clk =3D clk;
>> +    priv->clk_ipg =3D clk_ipg;
>> +    priv->clk_per =3D clk_per;
>>      priv->pdata =3D pdev->dev.platform_data;
>>      priv->devtype_data =3D devtype_data;
>> =20
>> @@ -1067,9 +1081,11 @@ static int __devinit flexcan_probe(struct
>> platform_device *pdev)
>>   failed_map:
>>      release_mem_region(mem->start, mem_size);
>>   failed_get:
>> -    if (clk)
>> -        clk_put(clk);
>>   failed_clock:
>> +    if (clk_per)
>>  =20
> Use if (!IS_ERR(clk_per))

Yes, good catch.

Is it allowed to call clk_put with a NULL pointer? Both clocks can be
NULL, if the frequency is defined via the device tree, this is case for
powerpc.

>> +        clk_put(clk_per);
>> +    if (clk_ipg)
>>  =20
> Ditto.
>=20
> If we use devm_clk_get(), we can save to call clk_put().

Even better. I think I'll send a separate patch to convert the whole
driver to devm.

>> +        clk_put(clk_ipg);
>>      return err;
>>  }
>> =20
>> @@ -1086,8 +1102,10 @@ static int __devexit flexcan_remove(struct
>> platform_device *pdev)
>>      mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>      release_mem_region(mem->start, resource_size(mem));
>> =20
>> -    if (priv->clk)
>> -        clk_put(priv->clk);
>> +    if (priv->clk_per)
>> +        clk_put(priv->clk_per);
>> +    if (priv->clk_ipg)
>> +        clk_put(priv->clk_ipg);

This will go away with devm then :)
>> =20
>>      free_candev(dev);
>> =20
>>  =20
>=20
> --=20
> To unsubscribe from this list: send the line "unsubscribe linux-can" in=

> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig267E53159F5FC9F34CFDA2C7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAGdckACgkQjTAFq1RaXHMRUACfXBZF/imySAYuG0IMK8Lddixc
MYUAn3oFOe/OD6kX9HJ1CnhGbuJtG2H5
=xDGj
-----END PGP SIGNATURE-----

--------------enig267E53159F5FC9F34CFDA2C7--
