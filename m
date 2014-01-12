From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH can-utils v2 0/3] License cleanup
Date: Sun, 12 Jan 2014 22:24:36 +0100
Message-ID: <1389561879-16729-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1389481823-8379-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46331 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750999AbaALVYu (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 12 Jan 2014 16:24:50 -0500
In-Reply-To: <1389481823-8379-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, Yegor Yefremov <yegorslists@googlemail.com>

This is v2 of my effort to clean up the license stuff of can-utils to
make it fit for packaging for Debian.

Changes since (implicit) v1, Message-Id:
1389481823-8379-1-git-send-email-u.kleine-koenig@pengutronix.de:

 - drop patch "slcand: remove program as it is undistributable". I hope
   that Yegor and Oliver are resolving the issue I fixed by dropping th=
e
   program.
 - new patch that adds license information to isotp.h
 - amend the kernel header sync with a cleanup to only have kernel
   headers below include/linux.

Best regards
Uwe

Uwe Kleine-K=C3=B6nig (3):
  headers: use include/linux only for Linux kernel headers
  ioctl.h: drop unused header
  isotp.h: add explicit license information

 GNUmakefile.am                  |  14 +--
 include/linux/can.h             | 195 ++++++++++++++++++++++++++++++++=
+++++-
 include/linux/can/bcm.h         |  99 ++++++++++++++++++-
 include/linux/can/core.h        |   1 -
 include/linux/can/dev.h         |   1 -
 include/linux/can/error.h       | 124 +++++++++++++++++++++++-
 include/linux/can/gw.h          | 204 ++++++++++++++++++++++++++++++++=
+++++++-
 include/linux/can/isotp.h       |   1 -
 include/linux/can/netlink.h     | 131 +++++++++++++++++++++++++-
 include/linux/can/raw.h         |  63 ++++++++++++-
 include/socketcan/can.h         | 167 --------------------------------
 include/socketcan/can/bcm.h     |  66 -------------
 include/socketcan/can/error.h   |  91 ------------------
 include/socketcan/can/gw.h      | 171 --------------------------------=
-
 include/socketcan/can/ioctl.h   |  99 -------------------
 include/socketcan/can/isotp.h   | 110 ----------------------
 include/socketcan/can/netlink.h | 122 ------------------------
 include/socketcan/can/raw.h     |  30 ------
 isotp.h                         | 140 +++++++++++++++++++++++++++
 isotprecv.c                     |   2 +-
 isotpsend.c                     |   2 +-
 isotpserver.c                   |   2 +-
 isotpsniffer.c                  |   2 +-
 isotptun.c                      |   2 +-
 24 files changed, 957 insertions(+), 882 deletions(-)
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

