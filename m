From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: peak_pci: TX Frame Loss
Date: Thu, 3 Dec 2015 09:20:35 +0100
Message-ID: <565FFB53.20300@pengutronix.de>
References: <20151118145121.32487.38169@maxwell.marel.net>
 <20151202180937.19023.96078@maxwell.marel.net>
 <565F4439.3050309@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="79HtWaWRrV6mI0SXj0PiF3JkFMN15G9P8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:59778 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758642AbbLCIUp (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 3 Dec 2015 03:20:45 -0500
In-Reply-To: <565F4439.3050309@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Andri Yngvason <andri.yngvason@marel.com>, linux-can@vger.kernel.org
Cc: wg@grandegger.com, s.grosjean@peak-system.com, hrafnkell.eiriksson@marel.com, haukur.hafsteinsson@marel.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--79HtWaWRrV6mI0SXj0PiF3JkFMN15G9P8
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/02/2015 08:19 PM, Oliver Hartkopp wrote:
>> diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja10=
00/sja1000.c
>> index f968d1e..b5115c2 100644
>> --- a/drivers/net/can/sja1000/sja1000.c
>> +++ b/drivers/net/can/sja1000/sja1000.c
>> @@ -93,6 +93,7 @@ static void sja1000_write_cmdreg(struct sja1000_priv=
 *priv, u8 val)
>>  	spin_lock_irqsave(&priv->cmdreg_lock, flags);
>>  	priv->write_reg(priv, SJA1000_CMR, val);
>>  	priv->read_reg(priv, SJA1000_SR);
>> +	udelay(10);
>>  	spin_unlock_irqrestore(&priv->cmdreg_lock, flags);
>>  }
>=20
> Hi Andri,
>=20
> looking at the code above I wonder whether the
>=20
> 	priv->read_reg(priv, SJA1000_SR);
>=20
> is a bad hack anyway.
>=20
> The read_reg() becomes readb(priv->reg_base + (port << 2)) in peak_pci.=
c and
> the result is never used.
>=20
> What if the entire operation gets 'optimized' at some point?

readX() calls are never optimized out.

> Can you check what happens if you just replace the priv->read_reg() wit=
h your
> udelay(10) call?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--79HtWaWRrV6mI0SXj0PiF3JkFMN15G9P8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJWX/tTAAoJEP5prqPJtc/HlSMH/jjCva7viRVSmZOKEvRMgQ2H
nXR/f6rMvv/3FZtwg1PhLSGP85E134cljvID22z0c5YvSuYU1wCa5jayUNAlEswk
5Z9LZqj4z06cUPGX2slvk+CRdHe6XqkgeedVU1PA+cfH5BHoaFuBaU9zBh7Q1Inb
VOW1IGTW6WxPiVXcxWcm/56yoi/y5y5PQgoEvXmOpt9+zoqQAIDo5rFan2yusoQH
EWJNoe5h2GiZZlh96zPAnMPJmi4X4Ci35m3jqWJTMy9osF2Rsh4EdJtVLs71fJdX
vxh0dLQxWh5CYtFHp3wveUGc7QG4OI3Lbzz/R52T3mum+IR2HtMfXnygpHuczb4=
=4qvR
-----END PGP SIGNATURE-----

--79HtWaWRrV6mI0SXj0PiF3JkFMN15G9P8--
