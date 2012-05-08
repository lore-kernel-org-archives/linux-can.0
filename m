From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: flexcan: add PM support
Date: Tue, 08 May 2012 17:46:09 +0200
Message-ID: <4FA93FC1.7030808@pengutronix.de>
References: <1336489937-29645-1-git-send-email-eric@eukrea.com> <4FA9394A.90303@pengutronix.de> <20120508173001.31ce8f0c@eb-e6520>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF80CB257EBE24B3DD5EAA01F"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43745 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755675Ab2EHPqR (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 8 May 2012 11:46:17 -0400
In-Reply-To: <20120508173001.31ce8f0c@eb-e6520>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?ISO-8859-1?Q?Eric_B=E9nard?= <eric@eukrea.com>
Cc: linux-can@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF80CB257EBE24B3DD5EAA01F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 05/08/2012 05:30 PM, Eric B=E9nard wrote:
> Hi Marc,
>=20
> Le Tue, 08 May 2012 17:18:34 +0200,
> Marc Kleine-Budde <mkl@pengutronix.de> a =E9crit :
>=20
>> On 05/08/2012 05:12 PM, Eric B=E9nard wrote:
>>> tested on an i.MX257
>>
>> What about the transceiver? Does is make sense to switch it off, too?
>>
> this could make sense on platform which have a transceiver with an
> enable input. I can add flexcan_transceiver_switch after/before
> flexcan_chip_disable/enable but won't be able to test that feature.

I looked at two ethernet drivers: ethernet/intel/ixgbe/ixgbe_main.c and
ethernet/intel/ixgbe/ixgbe_main.c and AFAICS they basically do the same
as in open/close. (btw: the flexcan driver switches the transceiver
on/off on open/close.) I haven't implemented any network driver pm yet,
but what is a driver supposed to do in suspend/resume?

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigF80CB257EBE24B3DD5EAA01F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+pP8UACgkQjTAFq1RaXHN/BQCfVucycEJufCEpuYoF2/bk6vKJ
P50An0zgH/MZaN+b2f1Owlun/gHMP8NJ
=jVyG
-----END PGP SIGNATURE-----

--------------enigF80CB257EBE24B3DD5EAA01F--
