From: Andri Yngvason <andri.yngvason@marel.com>
Subject: [PATCH v4 0/6] Consolidate and unify state change handling
Date: Fri, 28 Nov 2014 12:12:24 +0000
Message-ID: <2513cfd7-4ff3-4536-b150-001a6fa96673@GRBSR0089.marel.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-db3on0060.outbound.protection.outlook.com ([157.55.234.60]:48064
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751046AbaK1MMe (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 28 Nov 2014 07:12:34 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: mkl@pengutronix.de, wg@grandegger.com

Patches 5 and 6 are new in the patch-set.

Note: I have not tested this version of the patch set. I will test this when I
have the time. In the meantime, please comment.

Andri Yngvason (6):
  can: dev: Consolidate and unify state change handling
  can: sja1000: Consolidate and unify state change handling
  can: mscan: Consolidate and unify state change handling
  can: flexcan: Consolidate and unify state change handling
  can: move can_stats.bus_off++ from can_bus_off into can_change_state
  can: handle bus-off in can_change_state()

 drivers/net/can/bfin_can.c                  |   1 +
 drivers/net/can/c_can/c_can.c               |   1 +
 drivers/net/can/cc770/cc770.c               |   1 +
 drivers/net/can/dev.c                       |  80 +++++++++++++++++++++-
 drivers/net/can/flexcan.c                   | 100 +++++-----------------------
 drivers/net/can/m_can/m_can.c               |   1 +
 drivers/net/can/mscan/mscan.c               |  49 ++++----------
 drivers/net/can/pch_can.c                   |   1 +
 drivers/net/can/rcar_can.c                  |   1 +
 drivers/net/can/sja1000/sja1000.c           |  48 ++++++-------
 drivers/net/can/softing/softing_main.c      |   1 +
 drivers/net/can/spi/mcp251x.c               |   1 +
 drivers/net/can/ti_hecc.c                   |   1 +
 drivers/net/can/usb/ems_usb.c               |   1 +
 drivers/net/can/usb/esd_usb2.c              |   1 +
 drivers/net/can/usb/peak_usb/pcan_usb.c     |   1 +
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c |   1 +
 drivers/net/can/usb/usb_8dev.c              |   1 +
 include/linux/can/dev.h                     |   3 +
 include/uapi/linux/can/error.h              |   1 +
 20 files changed, 147 insertions(+), 148 deletions(-)

-- 
1.9.1

