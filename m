From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Bug on configure ... where to report?
Date: Thu, 26 Feb 2015 09:45:35 +0100
Message-ID: <54EEDD2F.5080501@pengutronix.de>
References: <54EE63C5.3040307@allcaps.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="cgIk96gC3Bb8rFK0p4Ohdl32P07d4mON2"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33229 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945AbbBZIpl (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 26 Feb 2015 03:45:41 -0500
In-Reply-To: <54EE63C5.3040307@allcaps.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andrew Lentvorski <bsder@allcaps.org>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cgIk96gC3Bb8rFK0p4Ohdl32P07d4mON2
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/26/2015 01:07 AM, Andrew Lentvorski wrote:
> I pulled the can-utils from gitorious and am trying to build them up on=

> a Beaglebone Black Debian but am getting errors when I try to run
> configure.  autogen.sh is also producing warnings.
>=20
> Where do I file a bug report?

Here :)

> root@beaglebone:~/can-utils# uname -a
> Linux beaglebone 3.8.13-bone50 #1 SMP Tue May 13 13:24:52 UTC 2014
> armv7l GNU/Linux
>=20
> root@beaglebone:~/can-utils# ./configure
> <...lots deleted...>
> checking dependency style of gcc... gcc3
> ./configure: line 11668: syntax error near unexpected token `)'
> ./configure: line 11668: `)'

There's no configure in the git repo, here does your configure come from?=


Which version of debian are you using? Which versions of autoconf,
automake and libtool are you using?

> root@beaglebone:~/can-utils# ./autogen.sh
>=20
> ----------
> autoreconf
> ----------
>=20
> configure.ac:22: warning: The macro `AC_LIBTOOL_WIN32_DLL' is obsolete.=

> configure.ac:22: You should run autoupdate.
> aclocal.m4:8118: AC_LIBTOOL_WIN32_DLL is expanded from...
> configure.ac:22: the top level
> configure.ac:22: warning: AC_LIBTOOL_WIN32_DLL: Remove this warning and=

> the call to _LT_SET_OPTION when you
> configure.ac:22: put the `win32-dll' option into LT_INIT's first parame=
ter.
> aclocal.m4:8118: AC_LIBTOOL_WIN32_DLL is expanded from...
> configure.ac:22: the top level
> configure.ac:24: warning: The macro `AC_PROG_LIBTOOL' is obsolete.
> configure.ac:24: You should run autoupdate.
> aclocal.m4:120: AC_PROG_LIBTOOL is expanded from...
> configure.ac:24: the top level
> configure.ac:28: warning: The macro `AC_FOREACH' is obsolete.
> configure.ac:28: You should run autoupdate.
> ../../lib/autoconf/general.m4:194: AC_FOREACH is expanded from...
> aclocal.m4:9254: _AM_SET_OPTIONS is expanded from...
> aclocal.m4:8956: AM_INIT_AUTOMAKE is expanded from...
> configure.ac:28: the top level
> libtoolize: putting auxiliary files in AC_CONFIG_AUX_DIR, `config/autoc=
onf'.
> libtoolize: copying file `config/autoconf/ltmain.sh'
> libtoolize: putting macros in AC_CONFIG_MACRO_DIR, `config/m4'.
> libtoolize: copying file `config/m4/libtool.m4'
> libtoolize: copying file `config/m4/ltoptions.m4'
> libtoolize: copying file `config/m4/ltsugar.m4'
> libtoolize: copying file `config/m4/ltversion.m4'
> libtoolize: copying file `config/m4/lt~obsolete.m4'
> libtoolize: Consider adding `-I config/m4' to ACLOCAL_AMFLAGS in
> Makefile.am.
> configure.ac:22: warning: The macro `AC_LIBTOOL_WIN32_DLL' is obsolete.=

> configure.ac:22: You should run autoupdate.
> aclocal.m4:8118: AC_LIBTOOL_WIN32_DLL is expanded from...
> configure.ac:22: the top level
> configure.ac:22: warning: AC_LIBTOOL_WIN32_DLL: Remove this warning and=

> the call to _LT_SET_OPTION when you
> configure.ac:22: put the `win32-dll' option into LT_INIT's first parame=
ter.
> aclocal.m4:8118: AC_LIBTOOL_WIN32_DLL is expanded from...
> configure.ac:22: the top level
> configure.ac:24: warning: The macro `AC_PROG_LIBTOOL' is obsolete.
> configure.ac:24: You should run autoupdate.
> aclocal.m4:120: AC_PROG_LIBTOOL is expanded from...
> configure.ac:24: the top level
> configure.ac:28: warning: The macro `AC_FOREACH' is obsolete.
> configure.ac:28: You should run autoupdate.
> ../../lib/autoconf/general.m4:194: AC_FOREACH is expanded from...
> aclocal.m4:9254: _AM_SET_OPTIONS is expanded from...
> aclocal.m4:8956: AM_INIT_AUTOMAKE is expanded from...
> configure.ac:28: the top level
> Useless use of /d modifier in transliteration operator at
> /usr/share/automake-1.9/Automake/Wrap.pm line 60.

Can you try the patch I just send to the list?

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--cgIk96gC3Bb8rFK0p4Ohdl32P07d4mON2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJU7t0yAAoJECte4hHFiupUSwsQAKzP616sEG+NvgCbNxqHvYR8
qQB5qFeUzu6G1DCiEqaL8sQ2xqc+kkDB6n8SgKJAAmwwTQdD9DpIOOcv9NHCxiNK
5mTpm4EGvDMmPnnv2ZlDjQS+swDDZxXkffcr5cEyF1hIhcCc0e9qQfiTiADNtH53
6X7yUBLI3IWU3QBgFg983uiRT6IwVlxN8PfJukRs2KY/0XKbDeZkqQsA6nBUWja9
oRJ1fCetFFO3IkGWgg11hIkF5BUaCEjDw8C2URHqv86bZe+PuR2Cz/Bswruu82OJ
IhWIntxRyd3mq0RDULThld1ROWCOvxkhnVNQLCw6sd7xk8f1S2UnpQtF4gfXQ/l+
6pt9HRX/zZmQEGPXnD64tZofmMwdFjkXFHantbvPAW0B7d2yZPzYTmyKo8sZuyTC
2M5AbN9IVuQNYuk2Y2huhhZMDec6oS7AVBpYBi061nvTKT9K4r7hsF0aLHju1VVH
noxGY/wzmJBsAX24ctp9OBVJZ/cI4aZgU0qSSDg8MAUtZNet4JdX6K9gFnlOVLL5
fAWkNRChT0epptxOA1cUF5fSFRs0JfjFameZtj0fvaRQGOtBBTnKWB5fIEOiFBMk
B1wZhU74m8tduhXb9ing5UD3Z+7Qa6fDh7Y2VcA6oMbom6NaA8bhfAgrrC9Bi5Gz
apMnfbAwM/Tu7dB8jCOI
=QyEt
-----END PGP SIGNATURE-----

--cgIk96gC3Bb8rFK0p4Ohdl32P07d4mON2--
