From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH 0/2] Add support for PEAK CAN-FD USB adapters
Date: Wed, 26 Nov 2014 11:21:29 +0100
Message-ID: <1416997291-23092-1-git-send-email-s.grosjean@peak-system.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp10.smtpout.orange.fr ([80.12.242.132]:21218 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750864AbaKZK30 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 26 Nov 2014 05:29:26 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Stephane Grosjean <s.grosjean@peak-system.com>

That serie of two patches adds support for the new PEAK-System Technik USB
adapters that enable access to CAN-FD standard, from the linux-can socket based
API.

Stephane Grosjean (2):
  can/peak_usb: preparing existing files for CAN-FD
  can/peak_usb: add support for new PEAK CAN-FD adapters

 drivers/net/can/usb/Kconfig                  |  14 +-
 drivers/net/can/usb/peak_usb/Makefile        |   2 +-
 drivers/net/can/usb/peak_usb/pcan_ucan.h     | 208 ++++++
 drivers/net/can/usb/peak_usb/pcan_usb.c      |   1 +
 drivers/net/can/usb/peak_usb/pcan_usb_core.c |  84 ++-
 drivers/net/can/usb/peak_usb/pcan_usb_core.h |  14 +-
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c   | 955 +++++++++++++++++++++++++++
 drivers/net/can/usb/peak_usb/pcan_usb_fd.h   | 108 +++
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c  |  22 +-
 drivers/net/can/usb/peak_usb/pcan_usb_pro.h  |   8 +
 10 files changed, 1377 insertions(+), 39 deletions(-)
 create mode 100644 drivers/net/can/usb/peak_usb/pcan_ucan.h
 create mode 100644 drivers/net/can/usb/peak_usb/pcan_usb_fd.c
 create mode 100644 drivers/net/can/usb/peak_usb/pcan_usb_fd.h

-- 
1.9.1

