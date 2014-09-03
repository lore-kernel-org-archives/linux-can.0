From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 2/3] can: flexcan.c: Re-write receive path to use MB queue
 instead of FIFO
Date: Wed, 03 Sep 2014 11:12:22 +0200
Message-ID: <5406DB76.5000301@pengutronix.de>
References: <1409133487-23367-1-git-send-email-david@protonic.nl>	<1409133487-23367-3-git-send-email-david@protonic.nl>	<5405AA50.6040100@pengutronix.de>	<20140902140407.1ee9db68@archvile>	<5405D9FA.6050207@pengutronix.de> <20140903091954.611e527e@archvile>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="m1x6Oo95fdqmfsgkPlJbrufuU2OpjTuSC"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52113 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753530AbaICJYM (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 3 Sep 2014 05:24:12 -0400
In-Reply-To: <20140903091954.611e527e@archvile>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Jander <david@protonic.nl>
Cc: wg@grandegger.com, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--m1x6Oo95fdqmfsgkPlJbrufuU2OpjTuSC
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 09/03/2014 09:19 AM, David Jander wrote:
>>>> You make use of the CTRL2 register, which is not present on some old=
er
>>>> (but supported) flexcan IP cores. You increase FLEXCAN_MCR_MAXMB to
>>>> 0x40, which is not supported on older IPs. The register rximr, is al=
so
>>>> not present on older cores. Don't break support for the older CAN co=
res.
>>>
>>> Oops. Thanks for pointing that out. I will check the reference manual=
 of
>>> the i.MX53 (which should have be the oldest supported version of this=
 IP
>>> core, right?). Of course I do not want to break older CAN cores.
>>> I will check correctness testing the code on an i.MX28 board which I =
have.
>>
>> Regarding the versions of the IP cores, we should not trust them, as
>> they are not public available..
>=20
> Ok. I fear that for this last patch we will need some run-time check fo=
r the
> version of the flexcan we have. I suppose the typical table with OF ids=
 and
> flags will do?

Yes, we already track this information in
> struct flexcan_devtype_data {
> 	u32 features;	/* hardware controller features */
> };

There is:
> #define FLEXCAN_HAS_V10_FEATURES	BIT(1) /* For core version >=3D 10 */

which is probably what you need. Feel free to add another bit, if you
need to.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--m1x6Oo95fdqmfsgkPlJbrufuU2OpjTuSC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlQG23kACgkQjTAFq1RaXHOrKgCfc0JdD96gpvweKmP7LVobf8IQ
2IUAn0e3uJXRDqCpiAo8c8OTTb7vEgw7
=KcwU
-----END PGP SIGNATURE-----

--m1x6Oo95fdqmfsgkPlJbrufuU2OpjTuSC--
