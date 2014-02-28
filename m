From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v8 4/7] can: provide a separate bittiming_const parameter
 to bittiming functions
Date: Fri, 28 Feb 2014 16:16:45 +0100
Message-ID: <5310A85D.7010900@pengutronix.de>
References: <1393593549-23072-1-git-send-email-socketcan@hartkopp.net> <1393593549-23072-5-git-send-email-socketcan@hartkopp.net> <5310A828.3030507@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="9DNhQUF06uquVR1BU97cDfB43HvN6e29E"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34717 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751898AbaB1PQv (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 28 Feb 2014 10:16:51 -0500
In-Reply-To: <5310A828.3030507@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9DNhQUF06uquVR1BU97cDfB43HvN6e29E
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 02/28/2014 04:15 PM, Oliver Hartkopp wrote:
> Hey Marc,
>=20
> i've just seen a whitespace issue here:
>=20
> On 28.02.2014 14:19, Oliver Hartkopp wrote:
>=20
>> -	return 0;
>> +	if (!bt->tq && bt->bitrate)
>> +			err =3D can_calc_bittiming(dev, bt, btc);
>> +	else if (bt->tq && !bt->bitrate)
>> +			err =3D can_fixup_bittiming(dev, bt, btc);
>> +	else
>> +		err =3D -EINVAL;
>> +
>> +	return err;
>=20
> Should I send a v9 or what's the best way for you?

Errr, v9, can you (re-)add the comments about the standard and expert mod=
e?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--9DNhQUF06uquVR1BU97cDfB43HvN6e29E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlMQqF0ACgkQjTAFq1RaXHP6kQCfQ9R3vI0Kj0tcjosCnjA6XI13
ZgoAniEpFQbC5UbhsJ343LONgbLz5vnj
=kFN/
-----END PGP SIGNATURE-----

--9DNhQUF06uquVR1BU97cDfB43HvN6e29E--
