From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 00/12] CAN updates for net-next, please review
Date: Wed, 01 Feb 2012 14:03:37 +0100
Message-ID: <4F293829.4080403@pengutronix.de>
References: <1328046410-21392-1-git-send-email-mkl@pengutronix.de> <4F290933.9060202@grandegger.com> <4F290A38.8080807@pengutronix.de> <4F2912E7.6070802@grandegger.com> <4F2923C3.1000902@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig1C0FF8F8562E39BADDEC0B1A"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51584 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754179Ab2BANDo (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 1 Feb 2012 08:03:44 -0500
In-Reply-To: <4F2923C3.1000902@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1C0FF8F8562E39BADDEC0B1A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 02/01/2012 12:36 PM, Marc Kleine-Budde wrote:
> On 02/01/2012 11:24 AM, Wolfgang Grandegger wrote:
>>> Go ahead. I'll have to setup a compile time test script anyway.
>>
>> Before pinging Dave, I could do some regression builds here as well.
>=20
> That would be fine, it's in my repo.
>=20
> https://gitorious.org/~bet-frogger/linux-can/mkl-linux-can-next

Fixed a typo, which I introduced in the "replace the
dev_dbg/info/err/... with the new netdev_xxx macros" patch.

Updated my branch

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig1C0FF8F8562E39BADDEC0B1A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk8pOC0ACgkQjTAFq1RaXHORdQCbBD0PI1rHmyfsNPLCjAfgZBsd
BQkAn3iuAF7UUv4nTV4uaq4GakupWiRF
=7qDN
-----END PGP SIGNATURE-----

--------------enig1C0FF8F8562E39BADDEC0B1A--
