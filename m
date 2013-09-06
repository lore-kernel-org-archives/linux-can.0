From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: Debian package configuration for can-utils
Date: Fri, 6 Sep 2013 20:51:39 +0200
Message-ID: <20130906185139.GU24802@pengutronix.de>
References: <5229E1D2.7090509@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35973 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895Ab3IFSvk (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 6 Sep 2013 14:51:40 -0400
Content-Disposition: inline
In-Reply-To: <5229E1D2.7090509@i2se.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: linux-can@vger.kernel.org

Hello Stefan,

On Fri, Sep 06, 2013 at 04:08:18PM +0200, Stefan Wahren wrote:
> i had read the discussion about Debian package for can-utils (
> http://thread.gmane.org/gmane.linux.can/3748 ) and i'm very
> interested about that.
>=20
> Is there a public repository, where i can get can-utils including
> Debian package configuration?
I have some preliminary work. While it's not yet good enough for Debian
(because of license issues) I don't mind sharing it. Below you can find
the current patch. I don't plan to publish a repository until the
license issues are resolved.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
------------->8---------------
=46rom: =3D?UTF-8?q?Uwe=3D20Kleine-K=3DC3=3DB6nig?=3D <u.kleine-koenig@=
pengutronix.de>
Date: Fri, 6 Sep 2013 20:45:29 +0200
Subject: [PATCH can-utils] debian: initial packaging

Note the resulting package isn't DFSG-free as there are still a few lic=
ense
issues to be resolved.
---
 debian/changelog     |   6 +++
 debian/compat        |   1 +
 debian/control       |  20 +++++++++
 debian/copyright     | 114 +++++++++++++++++++++++++++++++++++++++++++=
++++++++
 debian/rules         |  32 +++++++++++++++
 debian/source/format |   1 +
 6 files changed, 174 insertions(+)
 create mode 100644 debian/changelog
 create mode 100644 debian/compat
 create mode 100644 debian/control
 create mode 100644 debian/copyright
 create mode 100755 debian/rules
 create mode 100644 debian/source/format

diff --git a/debian/changelog b/debian/changelog
new file mode 100644
index 0000000..bbc60fb
--- /dev/null
+++ b/debian/changelog
@@ -0,0 +1,6 @@
+can-utils (0~git20130906.1-1) unstable; urgency=3Dlow
+
+  * Initial release based on git snapshot
+    ad7f44095ac301ae85f1c3e406a868c5ac664abe
+
+ -- Uwe Kleine-K=F6nig <uwe@kleine-koenig.org>  Thu, 15 Aug 2013 21:33=
:02 +0200
diff --git a/debian/compat b/debian/compat
new file mode 100644
index 0000000..ec63514
--- /dev/null
+++ b/debian/compat
@@ -0,0 +1 @@
+9
diff --git a/debian/control b/debian/control
new file mode 100644
index 0000000..6bf2c9f
--- /dev/null
+++ b/debian/control
@@ -0,0 +1,20 @@
+Source: can-utils
+Section: net
+Priority: extra
+Maintainer: Uwe Kleine-K=F6nig <uwe@kleine-koenig.org>
+Build-Depends: debhelper (>=3D 9)
+Standards-Version: 3.9.4
+Vcs-Browser: http://git.pengutronix.de/?p=3Dukl/can-utils.git;
+Vcs-Git: git://git.pengutronix.de/git/ukl/can-utils.git
+
+Package: can-utils
+Architecture: any
+Depends: ${shlibs:Depends}, ${misc:Depends}
+Description: CAN userspace utilities and tools
+ Can is a message-based network protocol designed for vehicles origina=
lly
+ designed by Robert Bosch GmbH. This package contains some userspace t=
ools,
+ namely:
+        asc2log; bcmserver; canbusload; can-calc-bit-timing; candump;
+        canfdtest; cangen; cangw; canlogserver; canplayer; cansend; ca=
nsniffer;
+        isotpdump; isotprecv; isotpsend; isotpserver; isotpsniffer; is=
otptun;
+        log2asc; log2long; slcan_attach; slcand; and slcanpty
diff --git a/debian/copyright b/debian/copyright
new file mode 100644
index 0000000..8aa4f98
--- /dev/null
+++ b/debian/copyright
@@ -0,0 +1,114 @@
+Format: http://www.debian.org/doc/packaging-manuals/copyright-format/1=
=2E0/
+Upstream-Name: can-utils
+Upstream-Contact: linux-can@vger.kernel.org
+Source: https://gitorious.org/linux-can/can-utils
+
+Files: asc2log.c cangen.c canlogserver.c canplayer.c cansend.c cansnif=
fer.c lib.c lib.h log2asc.c log2long.c slcan_attach.c terminal.h
+Copyright: 2002-2007 Volkswagen Group Electronic Research
+License: BSD-3-clause or GPL-2
+
+Files: bcmserver.c candump.c
+Copyright: 2002-2009 Volkswagen Group Electronic Research
+License: BSD-3-clause or GPL-2
+
+Files: canbusload.c
+Copyright: 2002-2008 Volkswagen Group Electronic Research
+License: BSD-3-clause or GPL-2
+
+Files: can-calc-bit-timing.c
+Copyright: 2008 Wolfgang Grandegger <wg@grandegger.com>
+License: GPL
+
+Files: canfdtest.c
+Copyright: 2009 Vladislav Gribov, IXXAT Automation GmbH, <gribov@ixxat=
=2Ede>
+           2009 Wolfgang Grandegger <wg@grandegger.com>
+License: GPL-2+
+
+Files: cangw.c
+Copyright: 2010 Volkswagen Group Electronic Research
+License: BSD-3-clause or GPL-2
+
+Files: debian/*
+Copyright: 2013 Uwe Kleine-K=F6nig <uwe@kleine-koenig.org>
+License: GPL-2
+
+Files: include/socketcan/can/bcm.h include/socketcan/can/error.h inclu=
de/socketcan/can/raw.h
+Copyright: 2002-2007 Volkswagen Group Electronic Research
+License: XXX
+
+Files: include/socketcan/can/gw.h
+Copyright: 2011 Volkswagen Group Electronic Research
+License: XXX
+
+Files: include/socketcan/can/isotp.h
+Copyright: 2008 Volkswagen Group Electronic Research
+License: XXX
+
+Files: include/socketcan/can/netlink.h
+Copyright: 2009 Wolfgang Grandegger <wg@grandegger.com>
+License: XXX
+
+Files: include/socketcan/can/ioctl.h
+Copyright: XXX
+License: XXX
+
+Files: isotpdump.c isotprecv.c isotpsend.c isotpsniffer.c isotptun.c
+Copyright: 2008 Volkswagen Group Electronic Research
+License: BSD-3-clause or GPL-2
+
+Files: isotpserver.c
+Copyright: 2002-2010 Volkswagen Group Electronic Research
+License: BSD-3-clause or GPL-2
+
+Files: Makefile
+Copyright: 2002-2005 Volkswagen Group Electronic Research
+License: BSD-3-clause or GPL-2
+
+Files: slcand.c
+Copyright: 2009 Robert Haddon <robert.haddon@verari.com>
+           2009 Verari Systems Inc.
+License: GPL-2+ and GFDL-NIV-1.2
+Comment: This might not be distributable
+
+Files: slcanpty.c
+Copyright: 2009 Oliver Hartkopp
+License: GPL-2+
+
+License: BSD-3-clause
+ All rights reserved.
+ Redistribution and use in source and binary forms, with or without
+ modification, are permitted provided that the following conditions
+ are met:
+ 1. Redistributions of source code must retain the above copyright
+    notice, this list of conditions and the following disclaimer.
+ 2. Redistributions in binary form must reproduce the above copyright
+    notice, this list of conditions and the following disclaimer in th=
e
+    documentation and/or other materials provided with the distributio=
n.
+ 3. Neither the name of Volkswagen nor the names of its contributors
+    may be used to endorse or promote products derived from this softw=
are
+    without specific prior written permission.
+
+License: GFDL-NIV-1.2
+ Redistributable and modifiable under the terms of the GNU Free Docume=
ntation
+ License version 1.2 as published by the Free Software Foundation, wit=
h no
+ Invariant Sections, no Front-Cover Texts, and no Back-Cover Texts.
+ The full text of the GFDL version 1.2 can be found in
+ /usr/share/common-licenses/GFDL-1.2 on Debian systems
+
+License: GPL
+ Redistributable and modifiable under the terms of the GPL.
+ The full text of the GPL version 2 can be found in
+ /usr/share/common-licenses/GPL-2 on Debian systems.
+
+License: GPL-2
+ Redistributable and modifiable under the terms of the GPL version 2
+ as published by the Free Software Foundation.
+ The full text of the GPL version 2 can be found in
+ /usr/share/common-licenses/GPL-2 on Debian systems.
+
+License: GPL-2+
+ Redistributable and modifiable under the terms of the GPL version 2 o=
r (at
+ your option) any later version published by the Free Software Foundat=
ion.
+ The full text of the GPL versions 2 and 3 can be found in
+ /usr/share/common-licenses/GPL-2 and /usr/share/common-licenses/GPL-3=
 on
+ Debian systems.
diff --git a/debian/rules b/debian/rules
new file mode 100755
index 0000000..bc9bc8b
--- /dev/null
+++ b/debian/rules
@@ -0,0 +1,32 @@
+#! /usr/bin/make -f
+
+export PREFIX =3D /usr
+
+DH_SEQUENCE =3D $@
+DH =3D dh $(DH_SEQUENCE)
+
+build-arch: build-arch-stamp
+build-indep:
+build: build-arch build-indep
+
+install: build install-stamp
+
+build-arch-stamp install-stamp: DH_SEQUENCE =3D ${@:-stamp=3D}
+build-arch-stamp install-stamp:
+	$(DH)
+	touch $@
+
+binary-arch binary-indep: install
+	$(DH)
+
+binary: binary-arch binary-indep
+
+clean:
+	$(DH)
+
+get-orig-source: UPSTREAM_REF :=3D $(shell grep -E -o '[0-9a-f]{40}' -=
m 1 debian/changelog)
+get-orig-source: UPSTREAM_VERSION :=3D $(shell dpkg-parsechangelog | s=
ed -n 's/^Version: //; T; s/-.*//p')
+get-orig-source:
+	git archive --format=3Dtar --prefix=3Dcan-utils-$(UPSTREAM_VERSION).o=
rig/ $(UPSTREAM_REF) | gzip --best --no-name > can-utils_$(UPSTREAM_VER=
SION).orig.tar.gz
+
+.PHONY: build-arch build-indep build install binary-indep binary-arch =
binary clean get-orig-source
diff --git a/debian/source/format b/debian/source/format
new file mode 100644
index 0000000..163aaf8
--- /dev/null
+++ b/debian/source/format
@@ -0,0 +1 @@
+3.0 (quilt)

