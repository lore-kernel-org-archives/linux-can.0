From: Wolfgang Grandegger <wg@grandegger.com>
Subject: [PATCH next-next 0/2] can: cc770: add support for the Bosch CC770 and Intel AN82527
Date: Thu, 24 Nov 2011 13:07:26 +0100
Message-ID: <1322136448-7311-1-git-send-email-wg@grandegger.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:56740 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754189Ab1KXMHd (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 24 Nov 2011 07:07:33 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: netdev@vger.kernel.org
Cc: linux-can@vger.kernel.org, socketcan-users@lists.berlios.de, IreneV <boir1@yandex.ru>, Stanislav Yelenskiy <stanislavelensky@yahoo.com>, Wolfgang Grandegger <wg@grandegger.com>

Already since a while we have support for the Bosch CC770 and Intel
AN82527 CAN controllers in our out-of-tree Socket-CAN repository.
It would be nice if somebody could test the driver. Unfortunately,
I currently do not have hardware at hand. I have not yet ported the
OF platform driver as it needs further attaention due to the merge
of the platform and OF platform interface.

Wolfgang Grandegger (2):
  can: cc770: add driver core for the Bosch CC770 and Intel AN82527
  can: cc770: legacy CC770 ISA bus driver

 drivers/net/can/Kconfig           |    2 +
 drivers/net/can/Makefile          |    1 +
 drivers/net/can/cc770/Kconfig     |   14 +
 drivers/net/can/cc770/Makefile    |    8 +
 drivers/net/can/cc770/cc770.c     |  895 +++++++++++++++++++++++++++++++++++++
 drivers/net/can/cc770/cc770.h     |  247 ++++++++++
 drivers/net/can/cc770/cc770_isa.c |  337 ++++++++++++++
 7 files changed, 1504 insertions(+), 0 deletions(-)
 create mode 100644 drivers/net/can/cc770/Kconfig
 create mode 100644 drivers/net/can/cc770/Makefile
 create mode 100644 drivers/net/can/cc770/cc770.c
 create mode 100644 drivers/net/can/cc770/cc770.h
 create mode 100644 drivers/net/can/cc770/cc770_isa.c

-- 
1.7.4.1

