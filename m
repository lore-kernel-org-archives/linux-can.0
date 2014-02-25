From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/2] can: mcp251x: Move diagnostic messages to dev_dbg()
Date: Tue, 25 Feb 2014 21:41:23 +0100
Message-ID: <530CFFF3.4030600@pengutronix.de>
References: <1393048274-7949-1-git-send-email-shc_work@mail.ru> <530A486B.3040005@grandegger.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="5U4Aqv0wrAx4FdMuorJnhp4QqAdLSViiW"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44009 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752769AbaBYUl1 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 25 Feb 2014 15:41:27 -0500
In-Reply-To: <530A486B.3040005@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Alexander Shiyan <shc_work@mail.ru>, linux-can@vger.kernel.org
Cc: Christian Pellegrin <chripell@evolware.org>, Chris Elston <celston@katalix.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5U4Aqv0wrAx4FdMuorJnhp4QqAdLSViiW
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 02/23/2014 08:13 PM, Wolfgang Grandegger wrote:
> On 02/22/2014 06:51 AM, Alexander Shiyan wrote:
>> This patch moves diagnostic messages used for debugging purposes
>> to dev_dbg().
>>
>> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
>> ---
>>  drivers/net/can/mcp251x.c | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/net/can/mcp251x.c b/drivers/net/can/mcp251x.c
>> index cdb9808..56e38a6 100644
>> --- a/drivers/net/can/mcp251x.c
>> +++ b/drivers/net/can/mcp251x.c
>> @@ -601,10 +601,10 @@ static int mcp251x_do_set_bittiming(struct net_d=
evice *net)
>>  			  (bt->prop_seg - 1));
>>  	mcp251x_write_bits(spi, CNF3, CNF3_PHSEG2_MASK,
>>  			   (bt->phase_seg2 - 1));
>> -	dev_info(&spi->dev, "CNF: 0x%02x 0x%02x 0x%02x\n",
>> -		 mcp251x_read_reg(spi, CNF1),
>> -		 mcp251x_read_reg(spi, CNF2),
>> -		 mcp251x_read_reg(spi, CNF3));
>> +	dev_dbg(&spi->dev, "CNF: 0x%02x 0x%02x 0x%02x\n",
>> +		mcp251x_read_reg(spi, CNF1),
>> +		mcp251x_read_reg(spi, CNF2),
>> +		mcp251x_read_reg(spi, CNF3));
>> =20
>>  	return 0;
>>  }
>=20
> It's common practice to show the bit-timing settings in the kernel log.=

> Therefore I prefer to keep this useful dev_info. If we change it, we
> should update all other drivers as well.

I'm not sure if the output is needed. The bit timing algorithm seems to
work so I think it's okay to make the driver more quiet.

>> @@ -1155,7 +1155,7 @@ static int mcp251x_can_probe(struct spi_device *=
spi)
>> =20
>=20
>>  	devm_can_led_init(net);
>> =20
>> -	dev_info(&spi->dev, "probed\n");
>> +	dev_dbg(&spi->dev, "probed\n");
>=20
> This one could even be removed.

+1

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--5U4Aqv0wrAx4FdMuorJnhp4QqAdLSViiW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlMM//MACgkQjTAFq1RaXHNGEQCfUXfKAuzlJCUwD1YoYiEs4aDw
LfAAniOVLwZeaQ63MFr+2v/xcVyvdWeb
=sRvw
-----END PGP SIGNATURE-----

--5U4Aqv0wrAx4FdMuorJnhp4QqAdLSViiW--
