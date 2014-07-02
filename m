From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] do not use --symlink for autoreconf
Date: Wed, 02 Jul 2014 15:06:29 +0200
Message-ID: <53B403D5.9070406@pengutronix.de>
References: <1404303178-24608-1-git-send-email-nautsch2@gmail.com> <53B3F88E.2080202@pengutronix.de> <53B3FC62.1030209@gmail.com> <53B3FE0B.7090205@gmail.com> <53B40204.7040400@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="lmgjWMrBkJNKSSUFW9NBa26M9NcJcCJjL"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48116 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752030AbaGBNGj (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 2 Jul 2014 09:06:39 -0400
In-Reply-To: <53B40204.7040400@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andre Naujoks <nautsch2@gmail.com>, linux-can@vger.kernel.org
Cc: socketcan@hartkopp.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lmgjWMrBkJNKSSUFW9NBa26M9NcJcCJjL
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/02/2014 02:58 PM, Marc Kleine-Budde wrote:
> On 07/02/2014 02:41 PM, Andre Naujoks wrote:
>> On 02.07.2014 14:34, Andre Naujoks wrote:
>>> On 02.07.2014 14:18, Marc Kleine-Budde wrote:
>>>> On 07/02/2014 02:12 PM, Andre Naujoks wrote:
>>>>> When packaging the can-utils, I understand, that the generation
>>>>> step for autoconf should be done beforehand. However using the
>>>>> --symlink option in the autoreconf step installs links instead of
>>>>> the actual files, which leads to a build failure when trying to
>>>>> build on another host with different autotools installed.
>>>>>
>>>>> Signed-off-by: Andre Naujoks <nautsch2@gmail.com>
>>>>
>>>> How do you package the can-utils? The usual steps are:
>>>>
>>>> ./autogen.sh ./configure make dist
>>>
>>> with git archive. Something like
>>>
>>> git archive --prefix=3Dcan-utils-`git describe --always --dirty`/ -o
>>> can-utils-`git describe --always --dirty`.tar.gz HEAD
>>
>> ... after which I unpack, autogen.sh and repack. Which is probably not=

>> the sanest way of doing this, but should work.
>=20
> This is why you get the problems with the links....

Try something like this instead (untested, though):

project=3Dcan-utils-`git describe --always --dirty`
git archive --prefix=3D$project/ -o $project.tar HEAD
tar xf $project.tar
cd $project
=2E/autogen.sh
cd ..
tar -rhf $project.tar \
        $project/GNUmakefile.in
        $project/aclocal.m4
        $project/autom4te.cache/
        $project/config/autoconf/
        $project/config/m4/libtool.m4
        $project/config/m4/ltoptions.m4
        $project/config/m4/ltsugar.m4
        $project/config/m4/ltversion.m4
        $project/config/m4/lt~obsolete.m4
        $project/configure

=46rom tar's man-page:
     -r, --append
           append files to the end of an archive
     -h, --dereference
           follow symlinks; archive and dump the files they point to

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--lmgjWMrBkJNKSSUFW9NBa26M9NcJcCJjL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlO0A9UACgkQjTAFq1RaXHOg/gCfaQlthmeuxcYf5knBprAqPPmP
sDYAnj44xfNDrt1WfG8EOLSPRGFfqwgc
=Nk1m
-----END PGP SIGNATURE-----

--lmgjWMrBkJNKSSUFW9NBa26M9NcJcCJjL--
