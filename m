From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: C_CAN: can frame drops
Date: Fri, 25 Jul 2014 12:10:23 +0200
Message-ID: <53D22D0F.3020001@pengutronix.de>
References: <BAY176-W240BDB3FFF425370BF5B47D3FE0@phx.gbl>,<53D204A4.1060502@pengutronix.de> <BAY176-W4D41B1290DE5D3B2BD6D0D3FC0@phx.gbl>,<53D2126C.40600@pengutronix.de> <BAY176-W426E5C1C47CA0379DFCD84D3FC0@phx.gbl>,<53D214E2.7020205@pengutronix.de> <BAY176-W40C40CD192EBD241673159D3FC0@phx.gbl>,<53D219E8.5060307@pengutronix.de> <BAY176-W36138D837FA40B1721062ED3FC0@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="dk6TalpQkL54dHsUM3M9xejroNpaaDfpH"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55535 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759997AbaGYKKd (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 25 Jul 2014 06:10:33 -0400
In-Reply-To: <BAY176-W36138D837FA40B1721062ED3FC0@phx.gbl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ssagarr Patil <hugarsagar@outlook.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dk6TalpQkL54dHsUM3M9xejroNpaaDfpH
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/25/2014 11:47 AM, Ssagarr Patil wrote:
>>> Any suggestion on how to still improve the performance so as there is=
 zero frame loss ?
>>> either on driver or application side.
>>
>> Use the latest kernel, at least v3.15 which has tglx's patches
>> integrated. v3.16 might even be better. If you want to log all CAN
>> messages, you can probably make use of recvmmsg() to receive more than=

>> one CAN frame at a time (instead of using recvmsg() or read()). When
>> writing to disk, don't write a single CAN frame at a time, it's better=

>> to write large blocks, i.e. several 4k of data.
>>
> I am using the v3.16 (the master branch from git://gitorious.org/linux-=
can/linux-can.git)
>=20
> OK will try experiment with recvmmsg() & and writing to disk with large=
 blocks.
> =20
>> Depending on the actual c_can/d_can implementation you're using, there=

>> might be some optimisation left in the driver, i.e. use 32 bit access =
if
>> possible. However before touching the driver, measurement to identify
>> the hot spots should be done.
>>
> OK
>=20
>> The next step would be to switch to preempt rt enabled system.
>>
> I am afraid I cant use this, as project needs to be run on normal Linux=
=2E

Preempt-rt is a normal Linux system, though. :)

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--dk6TalpQkL54dHsUM3M9xejroNpaaDfpH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlPSLRIACgkQjTAFq1RaXHP78QCeJccTc8sejTdOTB0J1wBbaCWM
0AgAn1ZUbcoemXue8pJdQaLBFhPC4eX8
=ij0C
-----END PGP SIGNATURE-----

--dk6TalpQkL54dHsUM3M9xejroNpaaDfpH--
