From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v5 5/5] include: Move includes copied from the Linux kernel
 into include/linux
Date: Thu, 16 Jan 2014 23:11:28 +0100
Message-ID: <52D85910.8000200@pengutronix.de>
References: <1389888754-23013-1-git-send-email-mkl@pengutronix.de> <1389888754-23013-6-git-send-email-mkl@pengutronix.de> <20140116192818.GC25911@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="8d4Qk3iPT1fONaU35pKOc1OLcsJDb1pws"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53764 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751038AbaAPWLe (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 16 Jan 2014 17:11:34 -0500
In-Reply-To: <20140116192818.GC25911@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8d4Qk3iPT1fONaU35pKOc1OLcsJDb1pws
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 01/16/2014 08:28 PM, Uwe Kleine-K=C3=B6nig wrote:
> On Thu, Jan 16, 2014 at 05:12:34PM +0100, Marc Kleine-Budde wrote:
>> From: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>>
>> This makes it possible to update the copies more easily, e.g.:
>>
>> 	cd $path_to_linux_repo
>> 	make headers_install
>> 	rsync -a --delete --exclude .\* usr/include/linux/can* $path_to_can_u=
tils/include/linux
>>
>> Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

> I want to have pointed out in the commit log that it was you who added
> isotp.h to the move. I don't care that much for your split into two
> patches to fix the #includes first, but IMHO that should be documented,=

> too.

Yes, but no. I imported the isotp header, but not from the kernel. It
was imported from the berlios svn repo.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--8d4Qk3iPT1fONaU35pKOc1OLcsJDb1pws
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlLYWREACgkQjTAFq1RaXHNEHACgjAKmjtBrUzNE6P8zcJYK/1Pk
BAEAoJmLn8OkCkGlq1mDml1QcfFBQOJp
=T5ip
-----END PGP SIGNATURE-----

--8d4Qk3iPT1fONaU35pKOc1OLcsJDb1pws--
