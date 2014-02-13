From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH can-next] Add CAN FD driver infrastructure
Date: Thu, 13 Feb 2014 12:55:27 +0100
Message-ID: <52FCB2AF.1010400@pengutronix.de>
References: <52F291D8.90008@hartkopp.net> <52F374DC.3000105@pengutronix.de> <52F3DC33.6080402@hartkopp.net> <52FB57BD.90704@pengutronix.de> <52FBCC8B.3090905@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="6g20PxIs9cSEc7iSud6CfWaiabbQmQJrP"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39823 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751970AbaBMLzj (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 13 Feb 2014 06:55:39 -0500
In-Reply-To: <52FBCC8B.3090905@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Stephane Grosjean <s.grosjean@peak-system.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6g20PxIs9cSEc7iSud6CfWaiabbQmQJrP
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 02/12/2014 08:33 PM, Oliver Hartkopp wrote:
> On 12.02.2014 12:15, Marc Kleine-Budde wrote:
>> On 02/06/2014 08:02 PM, Oliver Hartkopp wrote:
>>> My patch is currently based on Davems net-tree, as this patch
>>>
>>> http://git.kernel.org/cgit/linux/kernel/git/davem/net.git/commit/?id=3D=
0ae89beb283a0db5980d1d4781c7d7be2f2810d6
>>>
>>> is currently not in mainline nor in net-next nor in linux-can-next.
>>>
>>> As the above patch clashes with the changes I did, I'll wait for Dave=
s
>>> net-next tree to be opened for development again before sending the p=
atch set.
>>
>> net-next is open and I've send a pull request to merge can-next/testin=
g
>> branch. Do you have a series with split patches I can have a look at?
>>
>=20
> Not yet. I'll try to prepare them asap.
> As the current pull request is just out I hope it's ok to prepare them =
this
> weekend ?!?

Sure, but I'm working on the berr_limit feature again, which will extend
the netlink interface, too.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--6g20PxIs9cSEc7iSud6CfWaiabbQmQJrP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlL8sq8ACgkQjTAFq1RaXHNYSwCeNYrMfg9wdc+ZzbSMY5BgdJII
Tj8AoJNRaS5+VDiaBduRsAb00saSEvo9
=8/P0
-----END PGP SIGNATURE-----

--6g20PxIs9cSEc7iSud6CfWaiabbQmQJrP--
