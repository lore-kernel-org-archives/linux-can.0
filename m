From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH can-utils v3 0/5] License cleanup
Date: Mon, 13 Jan 2014 22:13:16 +0100
Message-ID: <1389647601-10622-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40244 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751068AbaAMVN1 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 13 Jan 2014 16:13:27 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>

Hello,

this is v3 of my clean up series. The main change compared to v2 is tha=
t
I split up patch "headers: use include/linux only for Linux kernel
headers" into three patches now and I didn't sync with 3.13-rc7 as I di=
d
before. So the license in the kernel headers is still missing; I'll
address that when this series is applied and maybe the
__kernel_sa_family_t is resolved.

I didn't keep isotp.h in include/linux mainly because I'm lazy, but als=
o
because I think keeping it there while it isn't in the kernel is a not
worth the additional effort during header sync with the kernel.

Uwe Kleine-K=C3=B6nig (5):
  Remove two unused header files
  Move isotp.h into the project root
  Move includes copied from the Linux kernel into include/linux
  ioctl.h: drop unused header
  isotp.h: add explicit license information

 GNUmakefile.am                  |  14 +---
 include/linux/can.h             | 168 ++++++++++++++++++++++++++++++++=
++++++-
 include/linux/can/bcm.h         |  67 +++++++++++++++-
 include/linux/can/core.h        |   1 -
 include/linux/can/dev.h         |   1 -
 include/linux/can/error.h       |  92 ++++++++++++++++++++-
 include/linux/can/gw.h          | 172 ++++++++++++++++++++++++++++++++=
+++++++-
 include/linux/can/isotp.h       |   1 -
 include/linux/can/netlink.h     | 123 +++++++++++++++++++++++++++-
 include/linux/can/raw.h         |  31 +++++++-
 include/socketcan/can.h         | 167 --------------------------------=
------
 include/socketcan/can/bcm.h     |  66 ---------------
 include/socketcan/can/error.h   |  91 ---------------------
 include/socketcan/can/gw.h      | 171 --------------------------------=
-------
 include/socketcan/can/ioctl.h   |  99 -----------------------
 include/socketcan/can/isotp.h   | 110 -------------------------
 include/socketcan/can/netlink.h | 122 ----------------------------
 include/socketcan/can/raw.h     |  30 -------
 isotp.h                         | 140 ++++++++++++++++++++++++++++++++
 isotprecv.c                     |   3 +-
 isotpsend.c                     |   3 +-
 isotpserver.c                   |   3 +-
 isotpsniffer.c                  |   3 +-
 isotptun.c                      |   3 +-
 24 files changed, 799 insertions(+), 882 deletions(-)
 delete mode 100644 include/linux/can/core.h
 delete mode 100644 include/linux/can/dev.h
 delete mode 100644 include/linux/can/isotp.h
 delete mode 100644 include/socketcan/can.h
 delete mode 100644 include/socketcan/can/bcm.h
 delete mode 100644 include/socketcan/can/error.h
 delete mode 100644 include/socketcan/can/gw.h
 delete mode 100644 include/socketcan/can/ioctl.h
 delete mode 100644 include/socketcan/can/isotp.h
 delete mode 100644 include/socketcan/can/netlink.h
 delete mode 100644 include/socketcan/can/raw.h
 create mode 100644 isotp.h

--=20
1.8.5.2

