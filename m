From: Andrew Lentvorski <bsder@allcaps.org>
Subject: Re: Bug on configure ... where to report?
Date: Mon, 02 Mar 2015 14:57:39 -0800
Message-ID: <54F4EAE3.5090406@allcaps.org>
References: <54EE63C5.3040307@allcaps.org> <54EEDD2F.5080501@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="EU9bpK2GjH24wIx3QaVQX7qfWSGW4wHFw"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from 64-73-229-46.static-ip.telepacific.net ([64.73.229.46]:15798
	"EHLO s0-postfix.allcaps.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753037AbbCBW5g (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 2 Mar 2015 17:57:36 -0500
In-Reply-To: <54EEDD2F.5080501@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EU9bpK2GjH24wIx3QaVQX7qfWSGW4wHFw
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Tried your patch but I'm missing something, I think.  Output included at
bottom.

-a


On 2/26/15, 12:45 AM, Marc Kleine-Budde wrote:
> Which version of debian are you using?=20

Some form of Wheezy, I think ...

root@beaglebone:~/can-utils# uname -a
Linux beaglebone 3.8.13-bone50 #1 SMP Tue May 13 13:24:52 UTC 2014
armv7l GNU/Linux


root@beaglebone:~/can-utils# lsb_release -a
No LSB modules are available.
Distributor ID:	Debian
Description:	Debian GNU/Linux 7.8 (wheezy)
Release:	7.8
Codename:	wheezy


> Which versions of autoconf, automake and libtool are you using?


root@beaglebone:~/can-utils# autoconf --version
autoconf (GNU Autoconf) 2.69


root@beaglebone:~/can-utils# automake --version
Useless use of /d modifier in transliteration operator at
/usr/share/automake-1.9/Automake/Wrap.pm line 60.
automake (GNU automake) 1.9.6


root@beaglebone:~/can-utils# libtool --version
libtool (GNU libtool) 2.4.2



> Can you try the patch I just send to the list?


Tried the patch but got this (what am I missing to apply this?):

root@beaglebone:~/can-utils# git apply makefile-patch.diff
fatal: patch with only garbage at line 5

root@beaglebone:~/can-utils# patch <makefile-patch.diff
patch: **** Only garbage was found in the patch input.

root@beaglebone:~/can-utils# cat makefile-patch.diff
diff --git a/GNUmakefile.am b/GNUmakefile.am
index 53dfb4ec47db..580e60d364c2 100644
--- a/GNUmakefile.am
+++ b/GNUmakefile.am
 <at>  <at>  -1,3 +1,5  <at>  <at>
+ACLOCAL_AMFLAGS =3D -I config/m4
+
 AM_CPPFLAGS =3D \
 	-I$(top_srcdir)/include \
 	-I$(top_builddir)/include \
diff --git a/configure.ac b/configure.ac
index 2fa16ce35af2..3b695d3aa9ea 100644
--- a/configure.ac
+++ b/configure.ac
 <at>  <at>  -1,8 +1,8  <at>  <at>
 # -*- Autoconf -*-
 # Process this file with autoconf to produce a configure script.
-AC_PREREQ(2.59)
+AC_PREREQ([2.59])

-AC_INIT([can-utils], [trunk], [linux-can <at> vger.kernel.org])
+AC_INIT([can-utils],[trunk],[linux-can <at> vger.kernel.org])
 AC_CONFIG_SRCDIR([lib.c])
 AC_CONFIG_MACRO_DIR([config/m4])
 AC_CONFIG_AUX_DIR([config/autoconf])
 <at>  <at>  -17,13 +17,7  <at>  <at>  CFLAGS=3D"${CFLAGS} -Wall"
 # Checks for programs.
 #
 AC_PROG_CC
-#AM_MISSING_PROG(PERL, perl, $missing_dir)
-# libtool, old:
-AC_LIBTOOL_WIN32_DLL
-#AC_LIBTOOL_TAGS([])
-AC_PROG_LIBTOOL
-# libtool, new:
-# LT_INIT(win32-dll)
+LT_INIT(win32-dll)

 AM_INIT_AUTOMAKE([foreign no-exeext dist-bzip2])
 m4_ifdef([AM_SILENT_RULES], [AM_SILENT_RULES([yes]]))
--



--EU9bpK2GjH24wIx3QaVQX7qfWSGW4wHFw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJU9OroAAoJEJ9wo+TcbAAXqF4H/37SxZuak0IUIxP5SlNuRsqU
vkz8DaJCQ5AF95raibXQdnklnLS5HDxqLz+lXhziL2byue2E0DEkkdAn/iCrjeUo
z63XJAeLTOWDlnvJyteMU/BzHE4deLnVp6oVTI5WDS3TcxpZl7pWrkBoyrdQ/o3x
zknYYL3uP16nCIkbrLBysTtKq0AEKesCkc3MdFzN30XuaPbiP/ZyCAdRcV3hz3EP
SKERTTBOOEbNQ8/Y88mgN+DhqjWpS6dUJgI46mIN899BW+4tz8WMXRCDI6r+70io
wQIwtyH3pIkkSiBOxlrcxtcX3KU1cuQD+G3QamXFlUwmnu/M9ZNzayk3ggjD6ec=
=2y6z
-----END PGP SIGNATURE-----

--EU9bpK2GjH24wIx3QaVQX7qfWSGW4wHFw--
