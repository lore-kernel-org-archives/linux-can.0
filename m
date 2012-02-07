From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH 0/3 v4] can/usb: Add PEAK-System PCAN USB adapters driver
Date: Tue,  7 Feb 2012 10:37:20 +0100
Message-ID: <1328607443-11480-1-git-send-email-s.grosjean@peak-system.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-3d.bbox.fr ([194.158.122.58]:48807 "EHLO mail-3d.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751349Ab2BGJgW (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 7 Feb 2012 04:36:22 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>, Stephane Grosjean <s.grosjean@peak-system.com>

That serie of patches adds the peak_usb driver which handles the PCAN-USB
and PCAN-USB Pro adapters from PEAK-System (http://www.peak-system.com).
These patches are planned for kernel v3.02.00 and above.

v4 changes:
- back to kmalloc/kfree usage instead of usb_xxx_coherent(), according to
  Documentation/usb/dma.txt:

    Most drivers should *NOT* be using these primitives; they don't need
    to use this type of memory ("dma-coherent"), and memory returned from
    kmalloc() will work just fine.

- handle manual and automatic restart in asynchronous way now (timer context)
- fix/remove some (too verbose) dev_xxx() messages
- fix error handling in each adapter specific code

Stephane Grosjean (3):
  can/usb: PEAK-System Technik USB adapters driver core
  can/usb: PEAK-System Technik PCAN-USB specific part
  can/usb: PEAK-System Technik PCAN-USB Pro specific part

 drivers/net/can/usb/Kconfig                  |    5 +
 drivers/net/can/usb/Makefile                 |    1 +
 drivers/net/can/usb/peak_usb/Makefile        |    2 +
 drivers/net/can/usb/peak_usb/pcan_usb.c      |  901 +++++++++++++++++++++++
 drivers/net/can/usb/peak_usb/pcan_usb_core.c |  905 +++++++++++++++++++++++
 drivers/net/can/usb/peak_usb/pcan_usb_core.h |  146 ++++
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c  | 1011 ++++++++++++++++++++++++++
 drivers/net/can/usb/peak_usb/pcan_usb_pro.h  |  178 +++++
 8 files changed, 3149 insertions(+), 0 deletions(-)
 create mode 100644 drivers/net/can/usb/peak_usb/Makefile
 create mode 100644 drivers/net/can/usb/peak_usb/pcan_usb.c
 create mode 100644 drivers/net/can/usb/peak_usb/pcan_usb_core.c
 create mode 100644 drivers/net/can/usb/peak_usb/pcan_usb_core.h
 create mode 100644 drivers/net/can/usb/peak_usb/pcan_usb_pro.c
 create mode 100644 drivers/net/can/usb/peak_usb/pcan_usb_pro.h

-- 
1.7.5.4

