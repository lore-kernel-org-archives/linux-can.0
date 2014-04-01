From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/4] can: mcp251x: Check return value of spi_setup()
Date: Tue, 01 Apr 2014 14:49:30 +0200
Message-ID: <533AB5DA.6040306@pengutronix.de>
References: <1396001687-7092-1-git-send-email-shc_work@mail.ru> <533AA979.9060201@pengutronix.de> <1396356451.825797457@f388.i.mail.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="oOuRT7PowINa7ggW4SX1Khlx146rbvjRS"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54069 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751162AbaDAMtd (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 1 Apr 2014 08:49:33 -0400
In-Reply-To: <1396356451.825797457@f388.i.mail.ru>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Shiyan <shc_work@mail.ru>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oOuRT7PowINa7ggW4SX1Khlx146rbvjRS
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 04/01/2014 02:47 PM, Alexander Shiyan wrote:
> Tue, 01 Apr 2014 13:56:41 +0200 =D0=BE=D1=82 Marc Kleine-Budde <mkl@pen=
gutronix.de>:
>> On 03/28/2014 11:14 AM, Alexander Shiyan wrote:
>>> This patch moves setup of SPI bus a bit earlier and adds check
>>> for spi_setup() result to be sure SPI bus is communicated with the
>>> device properly.
>>>
>>> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
>>> ---
>>>  drivers/net/can/mcp251x.c | 25 +++++++++++++------------
>>>  1 file changed, 13 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/net/can/mcp251x.c b/drivers/net/can/mcp251x.c
>>> index 28c11f8..26879c7 100644
>>> --- a/drivers/net/can/mcp251x.c
>>> +++ b/drivers/net/can/mcp251x.c
>>> @@ -1032,8 +1032,8 @@ static int mcp251x_can_probe(struct spi_device =
*spi)
>>>  	struct mcp251x_platform_data *pdata =3D dev_get_platdata(&spi->dev)=
;
>>>  	struct net_device *net;
>>>  	struct mcp251x_priv *priv;
>>> -	int freq, ret =3D -ENODEV;
>>>  	struct clk *clk;
>>> +	int freq, ret;
>>> =20
>>>  	clk =3D devm_clk_get(&spi->dev, NULL);
>>>  	if (IS_ERR(clk)) {
>>> @@ -1076,6 +1076,18 @@ static int mcp251x_can_probe(struct spi_device=
 *spi)
>>>  	priv->net =3D net;
>>>  	priv->clk =3D clk;
>>> =20
>>> +	spi_set_drvdata(spi, priv);
>>> +
>>> +	/* Configure the SPI bus */
>>> +	spi->bits_per_word =3D 8;
>>> +	if (mcp251x_is_2510(spi))
>>> +		spi->max_speed_hz =3D spi->max_speed_hz ? : 5 * 1000 * 1000;
>>> +	else
>>> +		spi->max_speed_hz =3D spi->max_speed_hz ? : 10 * 1000 * 1000;
>>> +	ret =3D spi_setup(spi);
>>> +	if (ret)
>>> +		return ret;
>>
>> You're omitting the error handling here. I'll send a v2.
>=20
> spi_setup() returns 0 or an error. What is wrong here?

You're not cleaning up the allocated resources.

-               return ret;
+               return out_clk;

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--oOuRT7PowINa7ggW4SX1Khlx146rbvjRS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlM6tdoACgkQjTAFq1RaXHO8+wCfTMfqzeB2jz7LwBrkUX/feKOw
vVYAnRcuAdXIWSoOz7xzaW6Cq2D1zI53
=EEWn
-----END PGP SIGNATURE-----

--oOuRT7PowINa7ggW4SX1Khlx146rbvjRS--
