From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: (Case 14359) Kvaser socketCAN support
Date: Thu, 24 Apr 2014 14:06:46 +0200
Message-ID: <5358FE56.3020408@pengutronix.de>
References: <CAGm1_ks40c8SGE+BuokShMmOXkGk0PO4MF67N+jhYh+DBWnp6w@mail.gmail.com> <5357e7f5.c72de00a.4ba2.40ff@mx.google.com> <CAGm1_kuo9J1_0nPew_urkF-jh6Y0J0oFaW9QVZe4k4T0KqcVkg@mail.gmail.com> <5358D731.9000908@pengutronix.de> <5358FCFF.9020604@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Fbc8UGpnVv4kRNVwu1TSVOT3TFObNhl2p"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44482 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753371AbaDXMGz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 24 Apr 2014 08:06:55 -0400
In-Reply-To: <5358FCFF.9020604@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Yegor Yefremov <yegorslists@googlemail.com>, Kvaser Support <support@kvaser.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Olivier Sobrie <olivier@sobrie.be>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Fbc8UGpnVv4kRNVwu1TSVOT3TFObNhl2p
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 04/24/2014 02:01 PM, Oliver Hartkopp wrote:
>=20
>=20
> On 24.04.2014 11:19, Marc Kleine-Budde wrote:
>> On 04/24/2014 09:46 AM, Yegor Yefremov wrote:
>>> What about making a table with following columns:
>>>
>>> 1. driver module name
>>> 2. supported devices
>>> 3. kernel version, where all these devices are supported
>>>
>>> *alternative variant*
>>>
>>> 1. device name
>>> 2. related driver module name
>>> 3. kernel version
>>
>> ^^^ I think this is the most useful variant.
>=20
> Yep!
>=20
> If possible I would like to add the Vendor too:
>=20
> 1. Vendor (with URL to the Vendor)
> 2. device name  (with URL to the Product if possible)
> 3. related driver module name
> 4. Kconfig option: CONFIG_CAN CONFIG_CAN_DEV CONFIG_SJA1000 CONFIG_EMS_=
PCMCIA

Please only the Kconfig option of the device (CONFIG_EMS_PCMCIA), maybe
CONFIG_SJA1000, but not more.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--Fbc8UGpnVv4kRNVwu1TSVOT3TFObNhl2p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlNY/lYACgkQjTAFq1RaXHP86QCglEPogEpBQFSKJ0KNA2kqOhdv
t0IAn2rsA572oyBZVYT5CbDKPqaQ8nCJ
=6IXT
-----END PGP SIGNATURE-----

--Fbc8UGpnVv4kRNVwu1TSVOT3TFObNhl2p--
