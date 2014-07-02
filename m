From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] do not use --symlink for autoreconf
Date: Wed, 02 Jul 2014 16:05:15 +0200
Message-ID: <53B4119B.3090804@pengutronix.de>
References: <1404303178-24608-1-git-send-email-nautsch2@gmail.com> <53B3F88E.2080202@pengutronix.de> <53B3FC62.1030209@gmail.com> <53B3FE0B.7090205@gmail.com> <53B40204.7040400@pengutronix.de> <53B403D5.9070406@pengutronix.de> <53B40455.80202@pengutronix.de> <53B40D80.10706@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="hDhlrAEk4EGT9jq73FbiqWpxD0xA86HKR"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40402 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752550AbaGBOFX (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 2 Jul 2014 10:05:23 -0400
In-Reply-To: <53B40D80.10706@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andre Naujoks <nautsch2@gmail.com>, linux-can@vger.kernel.org
Cc: socketcan@hartkopp.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hDhlrAEk4EGT9jq73FbiqWpxD0xA86HKR
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/02/2014 03:47 PM, Andre Naujoks wrote:
> On 02.07.2014 15:08, Marc Kleine-Budde wrote:
>> On 07/02/2014 03:06 PM, Marc Kleine-Budde wrote:
>>> On 07/02/2014 02:58 PM, Marc Kleine-Budde wrote:
>>>> On 07/02/2014 02:41 PM, Andre Naujoks wrote:
>>>>> On 02.07.2014 14:34, Andre Naujoks wrote:
>>>>>> On 02.07.2014 14:18, Marc Kleine-Budde wrote:
>>>>>>> On 07/02/2014 02:12 PM, Andre Naujoks wrote:
>>>>>>>> When packaging the can-utils, I understand, that the
>>>>>>>> generation step for autoconf should be done beforehand.
>>>>>>>> However using the --symlink option in the autoreconf
>>>>>>>> step installs links instead of the actual files, which
>>>>>>>> leads to a build failure when trying to build on
>>>>>>>> another host with different autotools installed.
>>>>>>>>
>>>>>>>> Signed-off-by: Andre Naujoks <nautsch2@gmail.com>
>>>>>>>
>>>>>>> How do you package the can-utils? The usual steps are:
>>>>>>>
>>>>>>> ./autogen.sh ./configure make dist
>>>>>>
>>>>>> with git archive. Something like
>>>>>>
>>>>>> git archive --prefix=3Dcan-utils-`git describe --always
>>>>>> --dirty`/ -o can-utils-`git describe --always
>>>>>> --dirty`.tar.gz HEAD
>>>>>
>>>>> ... after which I unpack, autogen.sh and repack. Which is
>>>>> probably not the sanest way of doing this, but should work.
>>>>
>>>> This is why you get the problems with the links....
>>>
>>> Try something like this instead (untested, though):
>>>
>>> project=3Dcan-utils-`git describe --always --dirty` git archive
>>> --prefix=3D$project/ -o $project.tar HEAD tar xf $project.tar cd
>>> $project ./autogen.sh cd .. tar -rhf $project.tar \=20
>>> $project/GNUmakefile.in $project/aclocal.m4=20
>>> $project/autom4te.cache/
>> ^^^^^^^^^^^^^^^^^^^^^^^^
>=20
> This is all nice and all, and I appreciate it, but why is the
> --symlink parameter there in the first place? I see no benefit from
> using it. It just makes things harder if you do it "the normal way".

Yes, I think the autotools/git interaction can be improved.

> Another thing is, that you need a host with all build dependencies
> resolved (i.e. configure completes) just to generate an unbuild
> package. This might not be a problem now (or ever), but why put in
> such a pitfall, when it is not needed?

For now I've applied your patch.

Thanks,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--hDhlrAEk4EGT9jq73FbiqWpxD0xA86HKR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlO0EZsACgkQjTAFq1RaXHO3AgCfZHDUbxm3lTt7bkon0keM2fP5
8wQAnjOGl35sE9lm5b763EfurAVzgnQH
=LKJu
-----END PGP SIGNATURE-----

--hDhlrAEk4EGT9jq73FbiqWpxD0xA86HKR--
