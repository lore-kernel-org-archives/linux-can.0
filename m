From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] do not use --symlink for autoreconf
Date: Wed, 02 Jul 2014 15:08:37 +0200
Message-ID: <53B40455.80202@pengutronix.de>
References: <1404303178-24608-1-git-send-email-nautsch2@gmail.com> <53B3F88E.2080202@pengutronix.de> <53B3FC62.1030209@gmail.com> <53B3FE0B.7090205@gmail.com> <53B40204.7040400@pengutronix.de> <53B403D5.9070406@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Guq0HnF2fxX09KiqJEVx0hn4Hw8eA1DPF"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39457 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752148AbaGBNIk (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 2 Jul 2014 09:08:40 -0400
In-Reply-To: <53B403D5.9070406@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andre Naujoks <nautsch2@gmail.com>, linux-can@vger.kernel.org
Cc: socketcan@hartkopp.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Guq0HnF2fxX09KiqJEVx0hn4Hw8eA1DPF
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/02/2014 03:06 PM, Marc Kleine-Budde wrote:
> On 07/02/2014 02:58 PM, Marc Kleine-Budde wrote:
>> On 07/02/2014 02:41 PM, Andre Naujoks wrote:
>>> On 02.07.2014 14:34, Andre Naujoks wrote:
>>>> On 02.07.2014 14:18, Marc Kleine-Budde wrote:
>>>>> On 07/02/2014 02:12 PM, Andre Naujoks wrote:
>>>>>> When packaging the can-utils, I understand, that the generation
>>>>>> step for autoconf should be done beforehand. However using the
>>>>>> --symlink option in the autoreconf step installs links instead of
>>>>>> the actual files, which leads to a build failure when trying to
>>>>>> build on another host with different autotools installed.
>>>>>>
>>>>>> Signed-off-by: Andre Naujoks <nautsch2@gmail.com>
>>>>>
>>>>> How do you package the can-utils? The usual steps are:
>>>>>
>>>>> ./autogen.sh ./configure make dist
>>>>
>>>> with git archive. Something like
>>>>
>>>> git archive --prefix=3Dcan-utils-`git describe --always --dirty`/ -o=

>>>> can-utils-`git describe --always --dirty`.tar.gz HEAD
>>>
>>> ... after which I unpack, autogen.sh and repack. Which is probably no=
t
>>> the sanest way of doing this, but should work.
>>
>> This is why you get the problems with the links....
>=20
> Try something like this instead (untested, though):
>=20
> project=3Dcan-utils-`git describe --always --dirty`
> git archive --prefix=3D$project/ -o $project.tar HEAD
> tar xf $project.tar
> cd $project
> ./autogen.sh
> cd ..
> tar -rhf $project.tar \
>         $project/GNUmakefile.in
>         $project/aclocal.m4
>         $project/autom4te.cache/
          ^^^^^^^^^^^^^^^^^^^^^^^^

Doh! You don't want to package this. Copy/Paste error.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--Guq0HnF2fxX09KiqJEVx0hn4Hw8eA1DPF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlO0BFUACgkQjTAFq1RaXHP8VgCglCQozHr+5UlQZcjNKSjEQCjz
BdQAn1lx30+YS0hRaBYEXODfIbCwvF7B
=16Ki
-----END PGP SIGNATURE-----

--Guq0HnF2fxX09KiqJEVx0hn4Hw8eA1DPF--
