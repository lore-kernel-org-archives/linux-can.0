From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH 0/7 v8] can/peak_usb: upgrade to CANFD
Date: Thu, 22 Jan 2015 16:24:19 +0100
Message-ID: <1421940266-6088-1-git-send-email-s.grosjean@peak-system.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]:26109 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752703AbbAVP0V (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 22 Jan 2015 10:26:21 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Stephane Grosjean <s.grosjean@peak-system.com>

That serie of patches upgrades the peak_usb driver by adding modifications
required to match the support of the CANFD extension, as well as those
needed to support two new CANFD USB adapters from PEAK-System Technik.

Stephane Grosjean (7):
  can/peak_usb: export ctrlmode_supported to adapter specific
  can/peak_usb: add adapter BEC callback definition
  can/peak_usb: upgrade core to data bittiming specs
  can/peak_usb: upgrade core to new struct canfd_frame
  can/peak_usb: export pcan_usb_pro functions
  can/peak_usb: add peak_usb_netif_rx() new function
  can/peak_usb: add support for PEAK new CANFD USB adapters

 drivers/net/can/usb/Kconfig                  |   14 +-
 drivers/net/can/usb/peak_usb/Makefile        |    2 +-
 drivers/net/can/usb/peak_usb/pcan_ucan.h     |  222 ++++++
 drivers/net/can/usb/peak_usb/pcan_usb.c      |    1 +
 drivers/net/can/usb/peak_usb/pcan_usb_core.c |   67 +-
 drivers/net/can/usb/peak_usb/pcan_usb_core.h |   16 +-
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c   | 1092 ++++++++++++++++++++++++++
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c  |   17 +-
 drivers/net/can/usb/peak_usb/pcan_usb_pro.h  |   13 +
 9 files changed, 1416 insertions(+), 28 deletions(-)
 create mode 100644 drivers/net/can/usb/peak_usb/pcan_ucan.h
 create mode 100644 drivers/net/can/usb/peak_usb/pcan_usb_fd.c

-- 
1.9.1

