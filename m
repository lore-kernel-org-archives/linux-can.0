From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH 0/3 v2] can/usb: Add PEAK-System PCAN USB adapters driver
Date: Fri, 13 Jan 2012 16:26:41 +0100
Message-ID: <1326468404-19330-1-git-send-email-s.grosjean@peak-system.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from 4va54-1-87-88-247-106.dsl.sta.abo.bbox.fr ([87.88.247.106]:52850
	"EHLO ubuntu-i386" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758311Ab2AMPf5 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 13 Jan 2012 10:35:57 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>, Stephane Grosjean <s.grosjean@peak-system.com>

That serie of patches adds the peak_usb driver which handles the PCAN-USB
and PCAN-USB Pro adapters from PEAK-System (http://www.peak-system.com).
These patches are planned for kernel v3.02.00 and above.
 
Stephane Grosjean (3):
  can/usb: PEAK-System Technik USB adapters driver core
  can/usb: PEAK-System Technik PCAN-USB specific part
  can/usb: PEAK-System Technik PCAN-USB Pro specific part

 drivers/net/can/usb/Kconfig                  |    6 +
 drivers/net/can/usb/Makefile                 |    1 +
 drivers/net/can/usb/peak_usb/Makefile        |    2 +
 drivers/net/can/usb/peak_usb/pcan_usb.c      |  751 ++++++++++++++++++++
 drivers/net/can/usb/peak_usb/pcan_usb_core.c |  874 ++++++++++++++++++++++++
 drivers/net/can/usb/peak_usb/pcan_usb_core.h |  138 ++++
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c  |  948 ++++++++++++++++++++++++++
 drivers/net/can/usb/peak_usb/pcan_usb_pro.h  |  178 +++++
 8 files changed, 2898 insertions(+), 0 deletions(-)
 create mode 100644 drivers/net/can/usb/peak_usb/Makefile
 create mode 100644 drivers/net/can/usb/peak_usb/pcan_usb.c
 create mode 100644 drivers/net/can/usb/peak_usb/pcan_usb_core.c
 create mode 100644 drivers/net/can/usb/peak_usb/pcan_usb_core.h
 create mode 100644 drivers/net/can/usb/peak_usb/pcan_usb_pro.c
 create mode 100644 drivers/net/can/usb/peak_usb/pcan_usb_pro.h

