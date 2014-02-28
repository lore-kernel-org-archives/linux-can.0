From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v5 4/6] can: introduce the data bitrate configuration
 for CAN FD
Date: Fri, 28 Feb 2014 13:30:29 +0100
Message-ID: <53108165.5050606@pengutronix.de>
References: <1393452662-3154-1-git-send-email-socketcan@hartkopp.net> <1393452662-3154-5-git-send-email-socketcan@hartkopp.net> <530EFAA0.4090000@pengutronix.de> <530F7E6A.4050307@hartkopp.net> <53106B6B.6040307@pengutronix.de> <53107F29.1080109@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="ixVV4OFFa8XN6mMqLWrmbFL8VNgbtDAPp"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51546 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751661AbaB1Mae (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 28 Feb 2014 07:30:34 -0500
In-Reply-To: <53107F29.1080109@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ixVV4OFFa8XN6mMqLWrmbFL8VNgbtDAPp
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 02/28/2014 01:20 PM, Oliver Hartkopp wrote:
>=20
>=20
> On 28.02.2014 11:56, Marc Kleine-Budde wrote:
>> On 02/27/2014 07:05 PM, Oliver Hartkopp wrote:
>>> On 27.02.2014 09:43, Marc Kleine-Budde wrote:
>>>
>>>>> +		if (priv->do_set_data_bittiming) {
>=20
>=20
>>
>>> The bitrate is always set via do_set[_data]_bittiming() when the inte=
rface is
>>> down - and *not* during the open process.
>>
>> No, not _always_. The flexcan and at91 drivers (maybe others, too) wri=
te
>> the values during open().
>=20
> flexcan does not assign priv->do_set_bittiming() and does the bitrate s=
etting
> at open time.
>=20
> Thats ok too.
>=20
> This is up to the driver, whether do_set[_data]_bittiming() is assigned=
 and
> when the stuff in the bitrate structures is set into the registers.
>=20
> I don't understand your problem.

A new do_set_data_bittiming() callback is not needed, as it's better do
set the data and "normal" bit timing registers during open().

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--ixVV4OFFa8XN6mMqLWrmbFL8VNgbtDAPp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlMQgWUACgkQjTAFq1RaXHONFgCfSlNpodFoje4cObbITn9LELlV
f8QAoImpJgoqa+fN1spuQKbjLvoQ1yUY
=o6Eo
-----END PGP SIGNATURE-----

--ixVV4OFFa8XN6mMqLWrmbFL8VNgbtDAPp--
