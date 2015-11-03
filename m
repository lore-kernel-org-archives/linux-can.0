From: =?utf-8?Q?Michael_Luxen?= <mluxen@gmx.net>
Subject: can-isotp-modules
Date: Tue, 3 Nov 2015 23:29:38 +0100
Message-ID: <zarafa.56393552.66d8.60d6be43600a8a08@euve35974.vserver.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from euve35974.vserver.de ([62.75.213.146]:55762 "EHLO
	euve35974.vserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964830AbbKCWkB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 3 Nov 2015 17:40:01 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?utf-8?Q?Oliver_Hartkopp?= <socketcan@hartkopp.net>
Cc: =?utf-8?Q?linux-can=40vger=2Ekernel=2Eorg?= <linux-can@vger.kernel.org>

Hello Oliver,

today I've tried to install can-isotp-modules on my BeagleBone Black by

1. git clone https://github.com/hartkopp/can-isotp-modules/
2. cd can-isotp-modules
3. make

The make process on my Debian Jessie 8.2 (uname -r: 4.1.6-ti-r16) powered BBB ends up with:

root@beaglebone:~/can-isotp-modules# make
make -C /lib/modules/4.1.6-ti-r16/build M=/root/can-isotp-modules modules TOPDIR=/root/can-isotp-modules
make[1]: Entering directory '/usr/src/linux-headers-4.1.6-ti-r16'
  CC [M]  /root/can-isotp-modules/drivers/net/can/vcan.o
In file included from include/linux/module.h:17:0,
                 from /root/can-isotp-modules/drivers/net/can/vcan.c:44:
/root/can-isotp-modules/drivers/net/can/vcan.c: In function '__check_echo':
include/linux/moduleparam.h:377:61: warning: return from incompatible pointer type
  static inline type __always_unused *__check_##name(void) { return(p); }
                                                             ^
include/linux/moduleparam.h:428:35: note: in expansion of macro '__param_check'
 #define param_check_bool(name, p) __param_check(name, p, bool)
                                   ^
include/linux/moduleparam.h:145:2: note: in expansion of macro 'param_check_bool'
  param_check_##type(name, &(value));       \
  ^
include/linux/moduleparam.h:125:2: note: in expansion of macro 'module_param_named'
  module_param_named(name, name, type, perm)
  ^
/root/can-isotp-modules/drivers/net/can/vcan.c:91:1: note: in expansion of macro 'module_param'
 module_param(echo, bool, S_IRUGO);
 ^
  CC [M]  /root/can-isotp-modules/drivers/net/can/slcan.o
/root/can-isotp-modules/drivers/net/can/slcan.c:46:24: fatal error: asm/system.h: No such file or directory
 #include <asm/system.h>
                        ^
compilation terminated.
scripts/Makefile.build:264: recipe for target '/root/can-isotp-modules/drivers/net/can/slcan.o' failed
make[3]: *** [/root/can-isotp-modules/drivers/net/can/slcan.o] Error 1
scripts/Makefile.build:403: recipe for target '/root/can-isotp-modules/drivers/net/can' failed
make[2]: *** [/root/can-isotp-modules/drivers/net/can] Error 2
Makefile:1384: recipe for target '_module_/root/can-isotp-modules' failed
make[1]: *** [_module_/root/can-isotp-modules] Error 2
make[1]: Leaving directory '/usr/src/linux-headers-4.1.6-ti-r16'
Makefile:42: recipe for target 'modules' failed
make: *** [modules] Error 2


Any idea/hint how to fix this issue?

Regards
Michael
