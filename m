From: Wolfgang <wutz@unterderbruecke.de>
Subject: Re: using j1939
Date: Wed, 7 Dec 2011 08:55:58 +0000 (UTC)
Message-ID: <loom.20111207T093827-478@post.gmane.org>
References: <20111206104432.91170@gmx.net> <20111206121403.GB322@e-circ.dyndns.org> <loom.20111206T131950-88@post.gmane.org> <20111206131815.GD322@e-circ.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:41855 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751300Ab1LGI4P (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 7 Dec 2011 03:56:15 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1RYDIR-0006um-KR
	for linux-can@vger.kernel.org; Wed, 07 Dec 2011 09:56:13 +0100
Received: from fire.makon-engineering.de ([80.152.230.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 07 Dec 2011 09:56:11 +0100
Received: from wutz by fire.makon-engineering.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 07 Dec 2011 09:56:11 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

> can-j1939-utils: (Similar to can-utils)
> I think you need to do this:
> $ ./autogen.sh
> $ ./configure --host=3Dpowerpc-603e-linux-gnu --prefix=3D/usr
> $ make
> $ make install DESTDIR=3D...

it is working but nothing is built in the directory /test
=2E......
libtool: install: /usr/bin/install -c slcanpty /usr/bin/slcanpty
make[1]: Nothing to be done for `install-data-am'.
make[1]: Leaving directory `/can-j1939-utils'
make: Nothing to be done for `/test'


> iproute2-j1939: (Similar to iproute2, which is for sure present
in your toolchain)
> I think you need to do this:
> $ make KERNEL_INCLUDE=3D<KERNEL_HEADER_PATH> CC=3Dpowerpc-603e-linux-=
gnu
>-gcc

utils.c: In function =E2=80=98rt_addrpr_n2a=E2=80=99:
utils.c:518: error: =E2=80=98AF_CAN=E2=80=99 undeclared (first use in t=
his function)
utils.c:518: error: (Each undeclared identifier is reported only once
utils.c:518: error: for each function it appears in.)
make[1]: *** [utils.o] Error 1
make: *** [all] Error 2

> $ make install DESTDIR=3D...
=20
> can-j1939-modules:
> I'm not sure. Building this package with a cross-toolchain=20
is something I never did.
> I patched the kernel source itself in a 'cross' situation.
> I only used can-j1939-modules for my own host.

Are these mandatory or what files do I have to use?

=20
--Wolfgang


