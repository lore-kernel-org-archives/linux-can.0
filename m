From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v10 1/7] Add CAN FD infrastructure for CAN driver
Date: Tue, 04 Mar 2014 22:32:49 +0100
Message-ID: <53164681.5000802@pengutronix.de>
References: <1393965855-3408-1-git-send-email-mkl@pengutronix.de> <53164414.2070903@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="qb09g4RllEg8E49fl5BqwRaFFf4tamaef"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58335 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932398AbaCDVc7 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 4 Mar 2014 16:32:59 -0500
In-Reply-To: <53164414.2070903@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc: kernel@pengutronix.de

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qb09g4RllEg8E49fl5BqwRaFFf4tamaef
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 03/04/2014 10:22 PM, Oliver Hartkopp wrote:
>> - 5/7
>>   In can_changelink(), when setting the data bittining, I removed the =
call to
>>   priv->do_set_data_bittiming().
>=20
> I think the call to priv->do_set_data_bittiming() has to remain here to=
 be
> consistent to priv->do_set_bittiming() in the same function.
>=20
> When priv->do_set_[data_]bittiming() is to be removed in the future it =
should
> be removed for both functions in the same way to prevent confusion.

Okay, however I'll reject every driver using
priv->do_set_[data_]bittiming anyways :P

>>   Further I moved the new "if (data[IFLA_CAN_DATA_BITTIMING])" at the =
bottom,
>>   so that all "if"s are sorted by "IFLA_".
>=20
> ?? You are moving the "if (data[IFLA_CAN_DATA_BITTIMING])" here and the=
n you
> move it in 6/7 again. %-)

Doh! suppose I've squashed it into the wrong patch.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--qb09g4RllEg8E49fl5BqwRaFFf4tamaef
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlMWRoEACgkQjTAFq1RaXHM9BQCfT+yytmi6+1xdwXjBY25V0LrG
h/MAoJLz2VoXoYEZQojDitgFlLvPmrZ2
=Mvvw
-----END PGP SIGNATURE-----

--qb09g4RllEg8E49fl5BqwRaFFf4tamaef--
