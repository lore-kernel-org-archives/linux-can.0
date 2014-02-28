From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v7 4/7] can: provide a separate bittiming_const parameter
 to bittiming functions
Date: Fri, 28 Feb 2014 14:02:40 +0100
Message-ID: <531088F0.4040708@pengutronix.de>
References: <1393583188-13307-1-git-send-email-socketcan@hartkopp.net> <1393583188-13307-5-git-send-email-socketcan@hartkopp.net> <5310691B.1090507@pengutronix.de> <531081A9.5020107@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="v4K1bc2EDfrkKCx8ibLQNxc64ukQFV2uX"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52141 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751580AbaB1NCo (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 28 Feb 2014 08:02:44 -0500
In-Reply-To: <531081A9.5020107@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--v4K1bc2EDfrkKCx8ibLQNxc64ukQFV2uX
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 02/28/2014 01:31 PM, Oliver Hartkopp wrote:
>=20
>=20
> On 28.02.2014 11:46, Marc Kleine-Budde wrote:
>> On 02/28/2014 11:26 AM, Oliver Hartkopp wrote:
>=20
>=20
>>>  {
>>> -	struct can_priv *priv =3D netdev_priv(dev);
>>> -	int err;
>>> +	int err =3D -EINVAL;
>>
>> Keep err uninitialized and make an explicit else err =3D -EINVAL.... s=
ee
>> below:
>>
>=20
>=20
>>> +	if (!bt->tq) {
>>> +		/* non-expert mode: Determine bit-timing parameters */
>>> +		if (bt->bitrate)
>>
>> Why not:
>> 	if (!bt->tq && bt->bitrate) {
>>
>>> +			err =3D can_calc_bittiming(dev, bt, btc);
>>> +	} else {
>>
>> 	} else if (bt->tq && !bt->bitrate) {
>>
>>> +		/*
>>> +		 * expert mode: Check bit-timing parameters and
>>> +		 * calculate proper brp and a human readable bitrate
>>> +		 */
>>> +		if (!bt->bitrate)
>>> +			err =3D can_fixup_bittiming(dev, bt, btc);
>>>  	}
>> 	} else {
>> 		err =3D -EINVAL;
>> 	}
>=20
> I don't have a strong preference on my implementation.
>=20
> But IMHO your suggested changes only add additional code and additional=

> comparisons in the if statement.
>=20
> I don't see a benefit in your suggestions :-(

You have 3 seperate if()s and an implicit error value from the
initialisation. This is IMHO more straight forward:

	if (!bt->tq && bt->bitrate)
		err =3D can_calc_bittiming(dev, bt, btc);
	else if (bt->tq && !bt->bitrate)
		err =3D can_fixup_bittiming(dev, bt, btc);
	else
		err =3D -EINVAL;

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--v4K1bc2EDfrkKCx8ibLQNxc64ukQFV2uX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlMQiPAACgkQjTAFq1RaXHPiKwCeIOKoJH3kcFLbDM1Fed1QqYhi
66AAn2R86RQIlsU7iHXy+TPo8hJT4wbc
=oQGu
-----END PGP SIGNATURE-----

--v4K1bc2EDfrkKCx8ibLQNxc64ukQFV2uX--
