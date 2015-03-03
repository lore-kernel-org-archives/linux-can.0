From: Andrew Lentvorski <bsder@allcaps.org>
Subject: Re: Bug on configure ... where to report?
Date: Mon, 02 Mar 2015 23:06:35 -0800
Message-ID: <54F55D7B.8010600@allcaps.org>
References: <54EE63C5.3040307@allcaps.org> <54EEDD2F.5080501@pengutronix.de> <54F4EAE3.5090406@allcaps.org> <54F550DA.3010601@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="4TmIou3WmTe8v8BTwUan6H067EX5iroMx"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from 64-73-229-46.static-ip.telepacific.net ([64.73.229.46]:13141
	"EHLO s0-postfix.allcaps.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752042AbbCCHGc (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 3 Mar 2015 02:06:32 -0500
In-Reply-To: <54F550DA.3010601@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4TmIou3WmTe8v8BTwUan6H067EX5iroMx
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

That patch didn't hit my inbox (for some reason), so I went to gmane
to grab the patch.  gmane mangled it.  I can't believe I missed that. :(

git apply and patch work fine after I unmangle the patch.


Problem still remains though.  Configure script works fine if I delete
that parenthesis.  What should I send to help you figure this out?

-a




root@beaglebone:~/can-utils# patch -p1 <../can-utils-patch=20
patching file GNUmakefile.am
patching file configure.ac
root@beaglebone:~/can-utils# ./autogen.sh

----------
autoreconf
----------

configure.ac:22: warning: The macro `AC_FOREACH' is obsolete.
configure.ac:22: You should run autoupdate.
=2E./../lib/autoconf/general.m4:194: AC_FOREACH is expanded from...
aclocal.m4:9254: _AM_SET_OPTIONS is expanded from...
aclocal.m4:8956: AM_INIT_AUTOMAKE is expanded from...
configure.ac:22: the top level
libtoolize: putting auxiliary files in AC_CONFIG_AUX_DIR, `config/autocon=
f'.
libtoolize: copying file `config/autoconf/ltmain.sh'
libtoolize: putting macros in AC_CONFIG_MACRO_DIR, `config/m4'.
libtoolize: copying file `config/m4/libtool.m4'
libtoolize: copying file `config/m4/ltoptions.m4'
libtoolize: copying file `config/m4/ltsugar.m4'
libtoolize: copying file `config/m4/ltversion.m4'
libtoolize: copying file `config/m4/lt~obsolete.m4'
libtoolize: Consider adding `-I config/m4' to ACLOCAL_AMFLAGS in Makefile=
=2Eam.
configure.ac:22: warning: The macro `AC_FOREACH' is obsolete.
configure.ac:22: You should run autoupdate.
=2E./../lib/autoconf/general.m4:194: AC_FOREACH is expanded from...
aclocal.m4:9254: _AM_SET_OPTIONS is expanded from...
aclocal.m4:8956: AM_INIT_AUTOMAKE is expanded from...
configure.ac:22: the top level
Useless use of /d modifier in transliteration operator at /usr/share/auto=
make-1.9/Automake/Wrap.pm line 60.
configure.ac: installing `config/autoconf/install-sh'
configure.ac: installing `config/autoconf/missing'
configure.ac:10: installing `config/autoconf/config.guess'
configure.ac:10: installing `config/autoconf/config.sub'
GNUmakefile.am: installing `config/autoconf/depcomp'

--------
Finished
--------

root@beaglebone:~/can-utils# ./configure
checking build system type... armv7l-unknown-linux-gnueabihf
checking host system type... armv7l-unknown-linux-gnueabihf
checking for gcc... gcc
checking whether the C compiler works... yes
checking for C compiler default output file name... a.out
checking for suffix of executables...=20
checking whether we are cross compiling... no
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether gcc accepts -g... yes
checking for gcc option to accept ISO C89... none needed
checking how to print strings... printf
checking for a sed that does not truncate output... /bin/sed
checking for grep that handles long lines and -e... /bin/grep
checking for egrep... /bin/grep -E
checking for fgrep... /bin/grep -F
checking for ld used by gcc... /usr/bin/ld
checking if the linker (/usr/bin/ld) is GNU ld... yes
checking for BSD- or MS-compatible name lister (nm)... /usr/bin/nm -B
checking the name lister (/usr/bin/nm -B) interface... BSD nm
checking whether ln -s works... yes
checking the maximum length of command line arguments... 1572864
checking whether the shell understands some XSI constructs... yes
checking whether the shell understands "+=3D"... yes
checking how to convert armv7l-unknown-linux-gnueabihf file names to armv=
7l-unknown-linux-gnueabihf format... func_convert_file_noop
checking how to convert armv7l-unknown-linux-gnueabihf file names to tool=
chain format... func_convert_file_noop
checking for /usr/bin/ld option to reload object files... -r
checking for objdump... objdump
checking how to recognize dependent libraries... pass_all
checking for dlltool... no
checking how to associate runtime and link libraries... printf %s\n
checking for ar... ar
checking for archiver @FILE support... @
checking for strip... strip
checking for ranlib... ranlib
checking for gawk... no
checking for mawk... mawk
checking command to parse /usr/bin/nm -B output from gcc object... ok
checking for sysroot... no
checking for mt... mt
checking if mt is a manifest tool... no
checking how to run the C preprocessor... gcc -E
checking for ANSI C header files... yes
checking for sys/types.h... yes
checking for sys/stat.h... yes
checking for stdlib.h... yes
checking for string.h... yes
checking for memory.h... yes
checking for strings.h... yes
checking for inttypes.h... yes
checking for stdint.h... yes
checking for unistd.h... yes
checking for dlfcn.h... yes
checking for objdir... .libs
checking if gcc supports -fno-rtti -fno-exceptions... no
checking for gcc option to produce PIC... -fPIC -DPIC
checking if gcc PIC flag -fPIC -DPIC works... yes
checking if gcc static flag -static works... yes
checking if gcc supports -c -o file.o... yes
checking if gcc supports -c -o file.o... (cached) yes
checking whether the gcc linker (/usr/bin/ld) supports shared libraries..=
=2E yes
checking whether -lc should be explicitly linked in... no
checking dynamic linker characteristics... GNU/Linux ld.so
checking how to hardcode library paths into programs... immediate
checking whether stripping libraries is possible... yes
checking if libtool supports shared libraries... yes
checking whether to build shared libraries... yes
checking whether to build static libraries... yes
checking for a BSD-compatible install... /usr/bin/install -c
checking whether build environment is sane... yes
checking whether make sets $(MAKE)... yes
checking for style of include used by make... GNU
checking dependency style of gcc... gcc3
=2E/configure: line 11660: syntax error near unexpected token `)'
=2E/configure: line 11660: `)'


Relevant section of the configure file:
11642 { $as_echo "$as_me:${as_lineno-$LINENO}: result: $am_cv_CC_dependen=
cies_compiler_type" >&5
11643 $as_echo "$am_cv_CC_dependencies_compiler_type" >&6; }
11644 CCDEPMODE=3Ddepmode=3D$am_cv_CC_dependencies_compiler_type
11645=20
11646=20
11647=20
11648 if
11649   test "x$enable_dependency_tracking" !=3D xno \
11650   && test "$am_cv_CC_dependencies_compiler_type" =3D gcc3; then
11651   am__fastdepCC_TRUE=3D
11652   am__fastdepCC_FALSE=3D'#'
11653 else
11654   am__fastdepCC_TRUE=3D'#'
11655   am__fastdepCC_FALSE=3D
11656 fi
11657=20
11658=20
11659=20
11660 )
11661=20
11662 #
11663 # Checks for header files.
11664 #
11665 for ac_header in  \
11666         fcntl.h \
11667         limits.h \
11668         locale.h \
11669         stdint.h \
11670         stdlib.h \
11671         string.h \
11672         syslog.h \
11673         termios.h \
11674         unistd.h \
11675         \
11676         netinet/in.h \
11677         \
11678         sys/ioctl.h \
11679         sys/socket.h \
11680         sys/time.h \
11681=20
11682 do :
11683   as_ac_Header=3D`$as_echo "ac_cv_header_$ac_header" | $as_tr_sh`
11684 ac_fn_c_check_header_mongrel "$LINENO" "$ac_header" "$as_ac_Header"=
 "$ac_includes_default"
11685 if eval test \"x\$"$as_ac_Header"\" =3D x"yes"; then :
11686   cat >>confdefs.h <<_ACEOF
11687 #define `$as_echo "HAVE_$ac_header" | $as_tr_cpp` 1
11688 _ACEOF
11689=20
11690 fi
11691=20
11692 done
11693=20
11694=20


--4TmIou3WmTe8v8BTwUan6H067EX5iroMx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJU9V1/AAoJEJ9wo+TcbAAX1zEH/0sRm1RNc4Faebkwe+SPC/JV
SzxOcB7YuqpQej4eTO2y05Lsgiceor4qRDQf4RDAS8/FjX0aj35XD+SCgHNskTnS
eWJe0mbuvpTMg5eS8W9sOV9Hj+7KgaXR7NFQ1zLJszF6BCU+dNY2FS92deRFpKQi
QKebIZAz6Mnpc7sp0w1L16dWXAOcm57hp4rnGM6JjkgPL+skdRE4swU0UxLGi59y
nrZeKMnzCH8M1w5SUgkkQndt7TFABNqlxqOPkwC+K1Gn3ueuPse53QhwxATbMbfa
Rs7LE1Y783I4zfnU1Vt2E3dfJkWexuz1UQ7kCfLpOWyRDt1OeOhSCcYXQn9mnu0=
=Y0mw
-----END PGP SIGNATURE-----

--4TmIou3WmTe8v8BTwUan6H067EX5iroMx--
