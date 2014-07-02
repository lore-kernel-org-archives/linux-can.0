From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] do not use --symlink for autoreconf
Date: Wed, 02 Jul 2014 14:58:44 +0200
Message-ID: <53B40204.7040400@pengutronix.de>
References: <1404303178-24608-1-git-send-email-nautsch2@gmail.com> <53B3F88E.2080202@pengutronix.de> <53B3FC62.1030209@gmail.com> <53B3FE0B.7090205@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="dlQeOr4Qcp8HIPKcFfn4xTc6pmpFuno7j"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47356 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752406AbaGBM6t (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 2 Jul 2014 08:58:49 -0400
In-Reply-To: <53B3FE0B.7090205@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andre Naujoks <nautsch2@gmail.com>, linux-can@vger.kernel.org
Cc: socketcan@hartkopp.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dlQeOr4Qcp8HIPKcFfn4xTc6pmpFuno7j
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/02/2014 02:41 PM, Andre Naujoks wrote:
> On 02.07.2014 14:34, Andre Naujoks wrote:
>> On 02.07.2014 14:18, Marc Kleine-Budde wrote:
>>> On 07/02/2014 02:12 PM, Andre Naujoks wrote:
>>>> When packaging the can-utils, I understand, that the generation
>>>> step for autoconf should be done beforehand. However using the
>>>> --symlink option in the autoreconf step installs links instead of
>>>> the actual files, which leads to a build failure when trying to
>>>> build on another host with different autotools installed.
>>>>
>>>> Signed-off-by: Andre Naujoks <nautsch2@gmail.com>
>>>
>>> How do you package the can-utils? The usual steps are:
>>>
>>> ./autogen.sh ./configure make dist
>>
>> with git archive. Something like
>>
>> git archive --prefix=3Dcan-utils-`git describe --always --dirty`/ -o
>> can-utils-`git describe --always --dirty`.tar.gz HEAD
>=20
> ... after which I unpack, autogen.sh and repack. Which is probably not
> the sanest way of doing this, but should work.

This is why you get the problems with the links....

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--dlQeOr4Qcp8HIPKcFfn4xTc6pmpFuno7j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlO0AgQACgkQjTAFq1RaXHO1kACfcV+mFB98RG+8NPgOD8uOHrVS
MhcAnjviNTMkXawKX0/wlgI6RpW+kFDZ
=0/qC
-----END PGP SIGNATURE-----

--dlQeOr4Qcp8HIPKcFfn4xTc6pmpFuno7j--
