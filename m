From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: SocketCAN stops read after RX overflow, is it normal?
Date: Thu, 3 Sep 2015 11:01:40 +0200
Message-ID: <55E80C74.8060600@pengutronix.de>
References: <55E6CCC8.7010908@picquet.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Qn5jNUt7cFRC9eWTuE69akqHKKsv2EIrk"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48185 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751894AbbICJBr (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 3 Sep 2015 05:01:47 -0400
In-Reply-To: <55E6CCC8.7010908@picquet.fr>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Guillaume Picquet <guillaume@picquet.fr>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Qn5jNUt7cFRC9eWTuE69akqHKKsv2EIrk
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/02/2015 12:17 PM, Guillaume Picquet wrote:
> Hi every one.
>=20
> I=E2=80=99m not sure to post to the correct list, if so please correct =
me.

100% correct.

> I=E2=80=99m doing tests on embedded hardware with integrated CAN bus in=
terface=20
> (based on AT91). The driver provides Linux Socket API and I try to see =

> the limits:
> I have one transmitter that writes CAN frames (CAN_RAW) as fast as=20
> possible and a receiver that reads continuously.
> After a moment the receiver gets an error frame signalling RX overflow.=
=20
> I have no problem with that, it's normal and expected.
> But question is why at this point no more frame is received ?

It's probably a bug in the driver.

> read() do not return, I've tested also with select() which return timeo=
ut.
> (The restart-ms option is set)
>=20
> I expected some dropped frames and others RX buffer errors but not the =

> end of reception.
>=20
> The only way to recover the interface is to set it down and up again.

Try the patches I send you in the other mail. They switch the at91 to
the new infrastructure. Some generic testing show good results, but it
seems you have a harder/better test case.

Hope that helps, please keep us informed,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--Qn5jNUt7cFRC9eWTuE69akqHKKsv2EIrk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJV6Ax0AAoJEP5prqPJtc/HeIkH/i9IGx0bTnOEHAc9J6yWN1Gv
vi8QFueclp+uX+VrrSoO1hgGKiLN9YsFIUJBW25pMGytH7pvYdypKVIIVVe/uBZ6
nx/u5BetSgczdj6FJwUgnBeU7n/0syj+X60JgdvAgNEVE2mPuQFuWcwUwb/U7O0G
j5TKPBEWPUCnOTU6Der0WzeMi4dkEmdpbgSLUOYxadmqy1rzVAuWbdJB46/0nGdd
kgQNdBc5DQuCmPhdqXxqd0SK0zVp94KZOgYENZh9w5E+wV8kbPqh7YPMncaspR01
djpjJ4ktUJ/EhYyxoh0/6jAdi6wk6nwgtkuFM5k35N5nrcMT/b6rVtWaNNbp6zA=
=hxrK
-----END PGP SIGNATURE-----

--Qn5jNUt7cFRC9eWTuE69akqHKKsv2EIrk--
