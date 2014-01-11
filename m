From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH can-utils 0/3] License cleanup
Date: Sun, 12 Jan 2014 00:10:20 +0100
Message-ID: <1389481823-8379-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20130817190521.GK30496@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39558 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876AbaAKXKs (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 11 Jan 2014 18:10:48 -0500
In-Reply-To: <20130817190521.GK30496@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>

Hello,

this series fixes all license issues I identified back in August last
year and so opens the possibility to create a Debian package for
can-utils.

Uwe Kleine-K=C3=B6nig (3):
  Update license information for some header files
  ioctl.h: drop unused header
  slcand: remove program as it is undistributable

 .gitignore                      |   1 -
 Android.mk                      |  14 --
 GNUmakefile.am                  |   2 -
 Makefile                        |   2 +-
 include/socketcan/can/bcm.h     |  32 +++
 include/socketcan/can/error.h   |  32 +++
 include/socketcan/can/gw.h      |  32 +++
 include/socketcan/can/ioctl.h   |  99 --------
 include/socketcan/can/netlink.h |   8 +
 include/socketcan/can/raw.h     |  32 +++
 slcand.c                        | 503 --------------------------------=
--------
 11 files changed, 137 insertions(+), 620 deletions(-)
 delete mode 100644 include/socketcan/can/ioctl.h
 delete mode 100644 slcand.c

--=20
1.8.5.2

