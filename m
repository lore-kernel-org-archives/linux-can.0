From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/2] can: flexcan: make flexcan_priv.devtype_data member
 point to const data
Date: Mon, 16 Jul 2012 10:28:24 +0200
Message-ID: <5003D0A8.7000908@pengutronix.de>
References: <1342184664-10720-1-git-send-email-mkl@pengutronix.de> <1342184664-10720-2-git-send-email-mkl@pengutronix.de> <20120716082139.GS592@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig14662CB75D0639611FDB3220"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48719 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752401Ab2GPI2b (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 16 Jul 2012 04:28:31 -0400
In-Reply-To: <20120716082139.GS592@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig14662CB75D0639611FDB3220
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 07/16/2012 10:21 AM, Uwe Kleine-K=F6nig wrote:
> Hello,
>=20
> On Fri, Jul 13, 2012 at 03:04:23PM +0200, Marc Kleine-Budde wrote:
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>> ---
>>  drivers/net/can/flexcan.c |    4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
>> index 81324a1..1b6f562 100644
>> --- a/drivers/net/can/flexcan.c
>> +++ b/drivers/net/can/flexcan.c
>> @@ -192,7 +192,7 @@ struct flexcan_priv {
>> =20
>>  	struct clk *clk;
>>  	struct flexcan_platform_data *pdata;
>> -	struct flexcan_devtype_data *devtype_data;
>> +	const struct flexcan_devtype_data *devtype_data;
>>  };
>> =20
>>  static struct flexcan_devtype_data fsl_p1010_devtype_data =3D {
>> @@ -960,7 +960,7 @@ static const struct platform_device_id flexcan_id_=
table[] =3D {
>>  static int __devinit flexcan_probe(struct platform_device *pdev)
>>  {
>>  	const struct of_device_id *of_id;
>> -	struct flexcan_devtype_data *devtype_data;
>> +	const struct flexcan_devtype_data *devtype_data;
>>  	struct net_device *dev;
>>  	struct flexcan_priv *priv;
>>  	struct resource *mem;
> Maybe this can be squashed into
>=20
> 	30c1e67 (can: flexcan: add hardware controller version support)
>=20
> (currently in next) together with making fsl_p1010_devtype_data and
> fsl_imx6q_devtype_data const?

Squashing is not possible, because it's already in David's tree. If I
mark fsl_p1010_devtype_data and fsl_imx6q_devtype_data as const, I get
these errors:

drivers/net/can/flexcan.c:950: warning: initialization discards
qualifiers from pointer target type
drivers/net/can/flexcan.c:951: warning: initialization discards
qualifiers from pointer target type

In a tree without you proposed patch.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig14662CB75D0639611FDB3220
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAD0KwACgkQjTAFq1RaXHPAIgCdGgstPeEPQwz6vwXdYW0SwuZx
X3MAoJKFptRbTYLiuYoGd/CxR5F2lHFm
=b46A
-----END PGP SIGNATURE-----

--------------enig14662CB75D0639611FDB3220--
