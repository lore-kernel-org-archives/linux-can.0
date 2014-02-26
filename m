From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/2] can: mcp251x: Move diagnostic messages to dev_dbg()
Date: Wed, 26 Feb 2014 09:23:17 +0100
Message-ID: <530DA475.3050609@pengutronix.de>
References: <1393048274-7949-1-git-send-email-shc_work@mail.ru> <530A486B.3040005@grandegger.com> <530CFFF3.4030600@pengutronix.de> <1393388457.834211289@f330.i.mail.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="eJwiNlbXUUf46btlF0mPJnqvO26gIJ8nj"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51381 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801AbaBZIXh (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 26 Feb 2014 03:23:37 -0500
In-Reply-To: <1393388457.834211289@f330.i.mail.ru>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Shiyan <shc_work@mail.ru>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, Christian Pellegrin <chripell@evolware.org>, Chris Elston <celston@katalix.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eJwiNlbXUUf46btlF0mPJnqvO26gIJ8nj
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 02/26/2014 05:20 AM, Alexander Shiyan wrote:
> =D0=92=D1=82=D0=BE=D1=80=D0=BD=D0=B8=D0=BA, 25 =D1=84=D0=B5=D0=B2=D1=80=
=D0=B0=D0=BB=D1=8F 2014, 21:41 +01:00 =D0=BE=D1=82 Marc Kleine-Budde <mkl=
@pengutronix.de>:
>> On 02/23/2014 08:13 PM, Wolfgang Grandegger wrote:
>>> On 02/22/2014 06:51 AM, Alexander Shiyan wrote:
>>>> This patch moves diagnostic messages used for debugging purposes
>>>> to dev_dbg().
> ...
>>>> @@ -1155,7 +1155,7 @@ static int mcp251x_can_probe(struct spi_device=
 *spi)
>>>> =20
>>>
>>>>  	devm_can_led_init(net);
>>>> =20
>>>> -	dev_info(&spi->dev, "probed\n");
>>>> +	dev_dbg(&spi->dev, "probed\n");
>>>
>>> This one could even be removed.
>>
>> +1
>=20
> Resend this one modified patch?

yes, please

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--eJwiNlbXUUf46btlF0mPJnqvO26gIJ8nj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlMNpHUACgkQjTAFq1RaXHOxXgCdE06nhE6bkfCJzRfmmO0amXAD
FaMAnjbIAYwdRQwujUj80zFZaDNNhrnw
=JZjs
-----END PGP SIGNATURE-----

--eJwiNlbXUUf46btlF0mPJnqvO26gIJ8nj--
