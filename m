From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: pch_can: Data transmission stops after dropped packet
Date: Fri, 07 Dec 2012 00:24:02 +0100
Message-ID: <50C12912.7000806@pengutronix.de>
References: <loom.20121114T160521-534@post.gmane.org> <50ACABE2.2020306@grandegger.com> <50C0B05F.7020606@grandegger.com> <2331999.ZYFOYXdjyx@ws-stein> <50C1160A.20203@grandegger.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig548FA151ACDDEBDC355B79E3"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33841 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753977Ab2LFXYK (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 6 Dec 2012 18:24:10 -0500
In-Reply-To: <50C1160A.20203@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>, Michael Pellegrini <mikep86@gmail.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig548FA151ACDDEBDC355B79E3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/06/2012 11:02 PM, Wolfgang Grandegger wrote:
> Hi Michael,
>=20
> On 12/06/2012 06:05 PM, Alexander Stein wrote:
>> Hi Michael,
>>=20
>> On Thursday 06 December 2012 15:49:03, Wolfgang Grandegger wrote:
>>>> Details of the soak test:
>>>>=20
>>>> There are two systems involved in the test: the PCH-System and
>>>> an External Node. The External Node transmits data at a high
>>>> rate, bringing bus utilization to ~35%. The PCH-System also
>>>> transmits data, in bursts of 10 messages every 5 ms. Combined,
>>>> the two systems utilize ~90% of bus bandwidth. The PCH-System
>>>> is constantly checking that it is receiving data from the=20
>>>> External Node at the expected rate and in the expected order.
>>=20
>> So you do a lot of transmit and reception of CAN frames?
>>=20
>>> On another thread Alexander is reporting problems with the same
>>> driver when he runs a I2C application concurrently. Are you able
>>> to stress the system in a similar way?
>>=20
>> Could you please test with the following patch? Do you see error
>> messages from this patch? Thanks!
>=20
> To summarize my understanding of your problem(s). As long as there
> are no I2C transfers, everything works fine, right? The patch below
> does report some write-readback failures but that's due to reserved
> read-only bits. I assume t hat you also use my "RFC v2" patches for
> c_can.
>=20
> Trouble starts with concurrent I2C transfers. Then the protected=20
> write-readback test fails, which I regard as abnormal hardware
> behavior, resulting in message losses and out-of-order reception.

Out-of-sequence reception might be a problem due to a problem in the rx
algorithm. And the drops are probably due to overflowing rx mailboxes.
The out-of-sequence will most mist likely occur if the rx fifo runs
full, but does not overflow.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig548FA151ACDDEBDC355B79E3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlDBKRYACgkQjTAFq1RaXHOV1ACgk0DSTNi8AZ46ZANMMvfJfTuJ
GawAnRstYWtFBvtWfPsUH2flQrmtcboU
=H/CC
-----END PGP SIGNATURE-----

--------------enig548FA151ACDDEBDC355B79E3--
