From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: sja1000_isa: add locking for indirect register access
 mode
Date: Tue, 15 Apr 2014 23:49:17 +0200
Message-ID: <534DA95D.60506@pengutronix.de>
References: <CA+s8ZrqFBun4bo2rJJFHb0FrV7m7PLybUVM+jjahKsdW8bdnaQ@mail.gmail.com> <164afc991761b9eeb0eec6902814d00e@grandegger.com> <534D0F00.7000202@hartkopp.net> <CA+s8Zrqrd_U0g1GRCDzXncgWLA_kO3Hyhjwy6Oe1S0cYohm2og@mail.gmail.com> <534D1F63.6080101@hartkopp.net> <534D270D.5060705@pengutronix.de> <534D31EF.6050107@hartkopp.net> <534D3748.6060602@pengutronix.de> <534D6C98.4020109@hartkopp.net> <alpine.DEB.2.02.1404152323500.22697@ionos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="t6t5GQhg54URx8oGcFqQdtntuO4rWNt74"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36933 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750866AbaDOVtZ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 15 Apr 2014 17:49:25 -0400
In-Reply-To: <alpine.DEB.2.02.1404152323500.22697@ionos.tec.linutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Wolfgang Grandegger <wg@grandegger.com>, khurram gulzar <khurramgulzar@gmail.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--t6t5GQhg54URx8oGcFqQdtntuO4rWNt74
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 04/15/2014 11:26 PM, Thomas Gleixner wrote:
> On Tue, 15 Apr 2014, Oliver Hartkopp wrote:
>=20
>> When accessing the SJA1000 controller registers in the indirect access=
 mode,
>> writing the register number and reading/writing the data has to be an =
atomic
>> attempt.
>>
>> As the sja1000_isa driver is an old style driver with a fixed number o=
f
>> instances the locking variable depends on the same index like all the =
other
>> configuration elements given on the module command line.
>>
>> As a positive side effect dev->dev_id is populated by the instance ind=
ex,
>> which was missing in 3e66d0138c05d9 ("can: populate netdev::dev_id for=
 udev
>> discrimination").
>>
>> Reported-by: Marc Kleine-Budde <mkl@pengutronix.de>
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>>
>> ---
>>
>> diff --git a/drivers/net/can/sja1000/sja1000_isa.c b/drivers/net/can/s=
ja1000/sja1000_isa.c
>> index df136a2..014695d 100644
>> --- a/drivers/net/can/sja1000/sja1000_isa.c
>> +++ b/drivers/net/can/sja1000/sja1000_isa.c
>> @@ -46,6 +46,7 @@ static int clk[MAXDEV];
>>  static unsigned char cdr[MAXDEV] =3D {[0 ... (MAXDEV - 1)] =3D 0xff};=

>>  static unsigned char ocr[MAXDEV] =3D {[0 ... (MAXDEV - 1)] =3D 0xff};=

>>  static int indirect[MAXDEV] =3D {[0 ... (MAXDEV - 1)] =3D -1};
>> +static spinlock_t indirect_lock[MAXDEV];  /* lock for indirect access=
 mode */
>=20
> You need to initialize the spinlock if you want to survive lockdep.
>=20
> Either use the proper static initializer or do an explicit
> spin_lock_init() on each of the locks before using them.

There's a spin_lock_init in the probe function:

>  static int sja1000_isa_probe(struct platform_device *pdev)
> @@ -169,6 +177,7 @@ static int sja1000_isa_probe(struct platform_device=
 *pdev)
>  		if (iosize =3D=3D SJA1000_IOSIZE_INDIRECT) {
>  			priv->read_reg =3D sja1000_isa_port_read_reg_indirect;
>  			priv->write_reg =3D sja1000_isa_port_write_reg_indirect;
> +			spin_lock_init(&indirect_lock[idx]);
>  		} else {
>  			priv->read_reg =3D sja1000_isa_port_read_reg;
>  			priv->write_reg =3D sja1000_isa_port_write_reg;

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--t6t5GQhg54URx8oGcFqQdtntuO4rWNt74
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlNNqV0ACgkQjTAFq1RaXHO4SgCbBg25P4I/5F5RoAmS7ZPg0nRl
GxwAnR2vBFIYqMyuUqHchylQyF1ewsz9
=p+6Z
-----END PGP SIGNATURE-----

--t6t5GQhg54URx8oGcFqQdtntuO4rWNt74--
