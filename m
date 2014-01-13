From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH can-utils v4 0/4] License cleanup
Date: Mon, 13 Jan 2014 22:57:12 +0100
Message-ID: <1389650236-13542-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <52D45B4C.3070009@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38549 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750928AbaAMV5Y (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 13 Jan 2014 16:57:24 -0500
In-Reply-To: <52D45B4C.3070009@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>

Hello,

compared to v3 I dropped the patch to move isotp.h to the project root
and did the necessary follow-up changes. Builds fine on a system that
has installed kernel headers from 2.6.32.

Best regards
Uwe

Uwe Kleine-K=C3=B6nig (4):
  Remove two unused header files
  Move includes copied from the Linux kernel into include/linux
  ioctl.h: drop unused header
  isotp.h: add explicit license information

 GNUmakefile.am                  |  11 +--
 include/linux/can.h             | 168 ++++++++++++++++++++++++++++++++=
++++++-
 include/linux/can/bcm.h         |  67 +++++++++++++++-
 include/linux/can/core.h        |   1 -
 include/linux/can/dev.h         |   1 -
 include/linux/can/error.h       |  92 ++++++++++++++++++++-
 include/linux/can/gw.h          | 172 ++++++++++++++++++++++++++++++++=
+++++++-
 include/linux/can/netlink.h     | 123 +++++++++++++++++++++++++++-
 include/linux/can/raw.h         |  31 +++++++-
 include/socketcan/can.h         | 167 --------------------------------=
------
 include/socketcan/can/bcm.h     |  66 ---------------
 include/socketcan/can/error.h   |  91 ---------------------
 include/socketcan/can/gw.h      | 171 --------------------------------=
-------
 include/socketcan/can/ioctl.h   |  99 -----------------------
 include/socketcan/can/isotp.h   |  38 ++++++++-
 include/socketcan/can/netlink.h | 122 ----------------------------
 include/socketcan/can/raw.h     |  30 -------
 17 files changed, 682 insertions(+), 768 deletions(-)
 delete mode 100644 include/linux/can/core.h
 delete mode 100644 include/linux/can/dev.h
 delete mode 100644 include/socketcan/can.h
 delete mode 100644 include/socketcan/can/bcm.h
 delete mode 100644 include/socketcan/can/error.h
 delete mode 100644 include/socketcan/can/gw.h
 delete mode 100644 include/socketcan/can/ioctl.h
 delete mode 100644 include/socketcan/can/netlink.h
 delete mode 100644 include/socketcan/can/raw.h

--=20
1.8.5.2

