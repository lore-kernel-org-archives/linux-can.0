From: swapnil <patilswa@gmail.com>
Subject: building  j1939 stack
Date: Sat, 10 May 2014 04:33:16 +0000 (UTC)
Message-ID: <loom.20140510T062609-546@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:53508 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750739AbaEJEde (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Sat, 10 May 2014 00:33:34 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1Wiyyb-0007wW-2o
	for linux-can@vger.kernel.org; Sat, 10 May 2014 06:33:33 +0200
Received: from c-98-212-86-243.hsd1.in.comcast.net ([98.212.86.243])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Sat, 10 May 2014 06:33:33 +0200
Received: from patilswa by c-98-212-86-243.hsd1.in.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Sat, 10 May 2014 06:33:33 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi,
   Hi Kurt I am able to build the kerneal some time befor by adding the
j1939 stack.=20
   but i am not able to build it now.
can you help me in this. =20

   I am getting following errors   =20
=E2=80=98.config=E2=80=99 -> =E2=80=98/home/bbb/beaglebone/GVE/linux-de=
v/patches/defconfig=E2=80=99
-----------------------------
make -j2 ARCH=3Darm LOCALVERSION=3D-armv7-devel-r44
CROSS_COMPILE=3D/home/bbb/beaglebone/GVE/linux-dev
/dl/gcc-linaro-arm-linux-gnueabihf-4.8-2014.04_
linux/bin/arm-linux-gnueabihf-
 zImage modules
-----------------------------
  CHK     include/config/kernel.release
  CHK     include/generated/uapi/linux/version.h
  CHK     include/generated/utsrelease.h
make[1]: `include/generated/mach-types.h' is up to date.
  CALL    scripts/checksyscalls.sh
  CHK     include/generated/compile.h
  CHK     kernel/config_data.h
  LD      net/can/j1939/built-in.o
  CC [M]  net/can/j1939/main.o
In file included from net/can/j1939/main.c:27:0:
net/can/j1939/j1939-priv.h:182:3: error: unknown=20
type name =E2=80=98write_proc_t=E2=80=99
   write_proc_t write);
   ^
make[3]: *** [net/can/j1939/main.o] Error 1
make[2]: *** [net/can/j1939] Error 2
make[1]: *** [net/can] Error 2
make: *** [net] Error 2

I followed the instruction on http://elinux.org/J1939

