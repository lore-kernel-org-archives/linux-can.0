From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [Gitorious] Activity: dschanoeh updated merge request for...
Date: Sat, 03 Dec 2011 19:54:19 +0100
Message-ID: <4EDA705B.1050106@pengutronix.de>
References: <20111129121452.B4F9F7590F@steelheart.shortcut.kunder.linpro.no>	<4ED4E74D.3090608@pengutronix.de> <CAEuXk91Bh+Z0yTqQebmW-EmrU59c-dFz_zKj8ky0ssgFBy23bQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig79DCE341909738C92F0CB4CA"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50060 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753894Ab1LCSy1 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 3 Dec 2011 13:54:27 -0500
In-Reply-To: <CAEuXk91Bh+Z0yTqQebmW-EmrU59c-dFz_zKj8ky0ssgFBy23bQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Jan-Niklas Meier <dschanoeh@googlemail.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig79DCE341909738C92F0CB4CA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello Jan-Niklas,

please don't top-post.

On 12/03/2011 05:47 PM, Jan-Niklas Meier wrote:
> 1.
> I think adding the includes to the repository is a bad idea. If you com=
pile
> the utils for your machine which has a kernel with SocketCAN-support wh=
y
> not use the original kernel headers?

Several reasons:
- iputils2 package the kernel headers, too.
- Consider you're using an older kernel without official socketcan
  support and with the external kernel modules available on gitorious.
- What about isotp and/or j1939 support? You want to use new features
  which are not part of the mainline kernel yet.

> It makes no sense to compile the can-utils on a machine which does not =
have
> SocketCAN support. If you do so you should be cross-compiling for a
> different machine and have the kernel headers of this machine in your
> cross-environment.
> Also it is very unlikely that someone who installed make, gcc and the
> autotools does not also have his kernel includes, right?

> To be able to compile a subset of the tools I checked if the isotp.h an=
d
> gw.h are present in the include directory (I don't have them both) and =
only
> compile the corresponding utils if the headers are present. This way it=

> should still be possible to compile subsets of the tools on machines wi=
th
> old kernels and not ending up with tools you can not use afterwards.

What about the external kernel modules use case?

> 2.
> I tried to rewrite the autoconf.ac because there are macros I'm having

Please don't rewrite stuff, please send incremental patches, fixing one
problem at a time.

> trouble with. When I run autoconf (version 2.68, libtool and automake
> installed) I get the following output:
>=20
> configure.ac:22: error: possibly undefined macro: AC_LIBTOOL_WIN32_DLL
>       If this token and others are legitimate, please use m4_pattern_al=
low.
>       See the Autoconf documentation.
> configure.ac:24: error: possibly undefined macro: AC_PROG_LIBTOOL
> configure.ac:28: error: possibly undefined macro: AM_INIT_AUTOMAKE
>=20
> A configure script is produced but when I try to execute it I get (shto=
ol
> is installed):
>=20
> configure: error: cannot find install-sh, install.sh, or shtool in
> config/autoconf "."/config/autoconf
>=20
> Trying to make it work (and not knowing what the macros do anyway ;) I
> removed them and successfully ran autoconf with my configure.ac...
                                    ^^^^^^^^

That might be the problem, don't run autoconf, run $(./autogen.sh) instea=
d.

I just updated to the latest tool available on debian unstable and it wor=
ks:

> [frogger@hardanger:can-utils (master-squashed)]$ autoconf --version
> autoconf (GNU Autoconf) 2.68
[..]

> automake (GNU automake) 1.11.1
[..]

> [frogger@hardanger:can-utils (master-squashed)]$ libtoolize --version
> libtoolize (GNU libtool) 2.4.2
[..]

> [frogger@hardanger:can-utils (master-squashed)]$ ./autogen.sh && ./conf=
igure && make distcheck
[...]
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=

> can-utils-trunk archives ready for distribution:
> can-utils-trunk.tar.gz
> can-utils-trunk.tar.bz2
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=


I used the master-squashed branch of my can-utils repo:
https://gitorious.org/~bet-frogger/linux-can/mkl-can-utils, head is:

231ed32f497a4f403a6d0ce2a61f1bb94be76ea4 gitignore: added tarballs

cheers, Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig79DCE341909738C92F0CB4CA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk7acF4ACgkQjTAFq1RaXHO51gCgk3TLa3DMrJfDEQpU6YGy2S9z
LIMAoISdKLV/+DmX/OyPN+PMsWLd6pSj
=dRr9
-----END PGP SIGNATURE-----

--------------enig79DCE341909738C92F0CB4CA--
