From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH 0/3 v7] can/usb: Add PEAK-System PCAN USB adapters driver
Date: Mon, 27 Feb 2012 15:53:48 +0100
Message-ID: <1330354431-12974-1-git-send-email-s.grosjean@peak-system.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-2d.bbox.fr ([194.158.122.57]:41011 "EHLO mail-2d.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752438Ab2B0Ox5 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 27 Feb 2012 09:53:57 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Alan Stern <stern@rowland.harvard.edu>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>, linux usb Mailing List <linux-usb@vger.kernel.org>, Stephane Grosjean <s.grosjean@peak-system.com>

That serie of patches adds the peak_usb driver which handles the PCAN-USB
and PCAN-USB Pro adapters from PEAK-System (http://www.peak-system.com).
These patches are planned for kernel v3.02.00 and above.

Stephane Grosjean (3):

  v7 changelog (pcan_usb_core.c only):
  - use of print_hex_dump() in dump_mem() function
  - use of monotonic clock in packets timestamp

  can/usb: PEAK-System Technik USB adapters driver core
  can/usb: PEAK-System Technik PCAN-USB specific part
  can/usb: PEAK-System Technik PCAN-USB Pro specific part

 drivers/net/can/usb/Kconfig                  |    6 +
 drivers/net/can/usb/Makefile                 |    1 +
 drivers/net/can/usb/peak_usb/Makefile        |    2 +
 drivers/net/can/usb/peak_usb/pcan_usb.c      |  901 ++++++++++++++++++++++
 drivers/net/can/usb/peak_usb/pcan_usb_core.c |  951 +++++++++++++++++++++++
 drivers/net/can/usb/peak_usb/pcan_usb_core.h |  146 ++++
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c  | 1036 ++++++++++++++++++++++++++
 drivers/net/can/usb/peak_usb/pcan_usb_pro.h  |  178 +++++
 8 files changed, 3221 insertions(+), 0 deletions(-)
 create mode 100644 drivers/net/can/usb/peak_usb/Makefile
 create mode 100644 drivers/net/can/usb/peak_usb/pcan_usb.c
 create mode 100644 drivers/net/can/usb/peak_usb/pcan_usb_core.c
 create mode 100644 drivers/net/can/usb/peak_usb/pcan_usb_core.h
 create mode 100644 drivers/net/can/usb/peak_usb/pcan_usb_pro.c
 create mode 100644 drivers/net/can/usb/peak_usb/pcan_usb_pro.h

-- 
1.7.5.4

