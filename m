From: Andrew Lentvorski <bsder@allcaps.org>
Subject: Bug on configure ... where to report?
Date: Wed, 25 Feb 2015 16:07:33 -0800
Message-ID: <54EE63C5.3040307@allcaps.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="A7CnccnjGhfU9rH6roGmWRT7w9wbnvSQU"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from 64-73-229-46.static-ip.telepacific.net ([64.73.229.46]:53074
	"EHLO s0-postfix.allcaps.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752617AbbBZAO5 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 25 Feb 2015 19:14:57 -0500
Received: from Andrews-MacBook-Pro.local (cpe-50-113-85-197.san.res.rr.com [50.113.85.197])
	by s0-postfix.allcaps.org (Postfix) with ESMTPSA id F1BD61C64074
	for <linux-can@vger.kernel.org>; Wed, 25 Feb 2015 15:55:57 -0800 (PST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--A7CnccnjGhfU9rH6roGmWRT7w9wbnvSQU
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I pulled the can-utils from gitorious and am trying to build them up on
a Beaglebone Black Debian but am getting errors when I try to run
configure.  autogen.sh is also producing warnings.

Where do I file a bug report?

Thanks,
-a



root@beaglebone:~/can-utils# uname -a
Linux beaglebone 3.8.13-bone50 #1 SMP Tue May 13 13:24:52 UTC 2014
armv7l GNU/Linux



root@beaglebone:~/can-utils# ./configure
<...lots deleted...>
checking dependency style of gcc... gcc3
=2E/configure: line 11668: syntax error near unexpected token `)'
=2E/configure: line 11668: `)'




root@beaglebone:~/can-utils# ./autogen.sh

----------
autoreconf
----------

configure.ac:22: warning: The macro `AC_LIBTOOL_WIN32_DLL' is obsolete.
configure.ac:22: You should run autoupdate.
aclocal.m4:8118: AC_LIBTOOL_WIN32_DLL is expanded from...
configure.ac:22: the top level
configure.ac:22: warning: AC_LIBTOOL_WIN32_DLL: Remove this warning and
the call to _LT_SET_OPTION when you
configure.ac:22: put the `win32-dll' option into LT_INIT's first paramete=
r.
aclocal.m4:8118: AC_LIBTOOL_WIN32_DLL is expanded from...
configure.ac:22: the top level
configure.ac:24: warning: The macro `AC_PROG_LIBTOOL' is obsolete.
configure.ac:24: You should run autoupdate.
aclocal.m4:120: AC_PROG_LIBTOOL is expanded from...
configure.ac:24: the top level
configure.ac:28: warning: The macro `AC_FOREACH' is obsolete.
configure.ac:28: You should run autoupdate.
=2E./../lib/autoconf/general.m4:194: AC_FOREACH is expanded from...
aclocal.m4:9254: _AM_SET_OPTIONS is expanded from...
aclocal.m4:8956: AM_INIT_AUTOMAKE is expanded from...
configure.ac:28: the top level
libtoolize: putting auxiliary files in AC_CONFIG_AUX_DIR, `config/autocon=
f'.
libtoolize: copying file `config/autoconf/ltmain.sh'
libtoolize: putting macros in AC_CONFIG_MACRO_DIR, `config/m4'.
libtoolize: copying file `config/m4/libtool.m4'
libtoolize: copying file `config/m4/ltoptions.m4'
libtoolize: copying file `config/m4/ltsugar.m4'
libtoolize: copying file `config/m4/ltversion.m4'
libtoolize: copying file `config/m4/lt~obsolete.m4'
libtoolize: Consider adding `-I config/m4' to ACLOCAL_AMFLAGS in
Makefile.am.
configure.ac:22: warning: The macro `AC_LIBTOOL_WIN32_DLL' is obsolete.
configure.ac:22: You should run autoupdate.
aclocal.m4:8118: AC_LIBTOOL_WIN32_DLL is expanded from...
configure.ac:22: the top level
configure.ac:22: warning: AC_LIBTOOL_WIN32_DLL: Remove this warning and
the call to _LT_SET_OPTION when you
configure.ac:22: put the `win32-dll' option into LT_INIT's first paramete=
r.
aclocal.m4:8118: AC_LIBTOOL_WIN32_DLL is expanded from...
configure.ac:22: the top level
configure.ac:24: warning: The macro `AC_PROG_LIBTOOL' is obsolete.
configure.ac:24: You should run autoupdate.
aclocal.m4:120: AC_PROG_LIBTOOL is expanded from...
configure.ac:24: the top level
configure.ac:28: warning: The macro `AC_FOREACH' is obsolete.
configure.ac:28: You should run autoupdate.
=2E./../lib/autoconf/general.m4:194: AC_FOREACH is expanded from...
aclocal.m4:9254: _AM_SET_OPTIONS is expanded from...
aclocal.m4:8956: AM_INIT_AUTOMAKE is expanded from...
configure.ac:28: the top level
Useless use of /d modifier in transliteration operator at
/usr/share/automake-1.9/Automake/Wrap.pm line 60.

--------
Finished
--------




--A7CnccnjGhfU9rH6roGmWRT7w9wbnvSQU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJU7mPFAAoJEJ9wo+TcbAAXjCoH/1XTiMqsgzeblWGP1TkqcSKD
kkX9x7/lWbqnT6K8ker/dUFv1FlTgBM4Aj1zJuhaXjFC4y7JR941BKyBOojtSP5Y
7gMy/qkcKPc7pyA4IF8gfCE+ZznNpcLbDnlwRbU0ASbY5XPT1mpzo4XEkpEcId+6
lVclD/Qoa2wOdMY1iu45LDaDl1hg4uxws2w+qOUYV4kXmJCl/AuJbgfXSI5C0/Yt
2KYB7+DKUaM4siibLLZ5u3dj7kVuq0TjEPZ6xnH1mRU3LRIM/xNnKWDfYKVpdMpo
y5BLtVR3s1ieQ8X1PbobPsbkp4KFXt5MWEGaZqUlV4CdoyaHs9Bsx27Vd6Pw4qA=
=ldW+
-----END PGP SIGNATURE-----

--A7CnccnjGhfU9rH6roGmWRT7w9wbnvSQU--
