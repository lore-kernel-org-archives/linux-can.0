From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH v2 0/3] Add support for PEAK CAN-FD USB adapters
Date: Tue,  2 Dec 2014 11:31:51 +0100
Message-ID: <1417516314-17486-1-git-send-email-s.grosjean@peak-system.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]:48847 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751021AbaLBKcS (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 2 Dec 2014 05:32:18 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Stephane Grosjean <s.grosjean@peak-system.com>

That serie of three patches adds support for the new PEAK-System Technik USB
adapters that enable access to CAN-FD standard, from the linux-can socket based
API.

Stephane Grosjean (3):
  can/peak_usb: CAN-FD: existing source files modifications
  can/peak_usb: CAN-FD: add new adapters specific files
  can/peak_usb: CAN-FD: driver's core modifications

 drivers/net/can/usb/Kconfig                  |  14 +-
 drivers/net/can/usb/peak_usb/Makefile        |   2 +-
 drivers/net/can/usb/peak_usb/pcan_ucan.h     | 208 ++++++
 drivers/net/can/usb/peak_usb/pcan_usb.c      |   1 +
 drivers/net/can/usb/peak_usb/pcan_usb_core.c |  71 +-
 drivers/net/can/usb/peak_usb/pcan_usb_core.h |  14 +-
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c   | 955 +++++++++++++++++++++++++++
 drivers/net/can/usb/peak_usb/pcan_usb_fd.h   | 108 +++
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c  |  19 +-
 drivers/net/can/usb/peak_usb/pcan_usb_pro.h  |   8 +
 10 files changed, 1368 insertions(+), 32 deletions(-)
 create mode 100644 drivers/net/can/usb/peak_usb/pcan_ucan.h
 create mode 100644 drivers/net/can/usb/peak_usb/pcan_usb_fd.c
 create mode 100644 drivers/net/can/usb/peak_usb/pcan_usb_fd.h

-- 
1.9.1

