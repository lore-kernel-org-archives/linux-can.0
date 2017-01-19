From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH v4 0/4] can: peak: Add support for PCAN-PCIe FD cards
Date: Thu, 19 Jan 2017 16:31:03 +0100
Message-ID: <1484839867-2050-1-git-send-email-s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp1-g21.free.fr ([212.27.42.1]:12744 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752870AbdASPbY (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 19 Jan 2017 10:31:24 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>, Stephane Grosjean <s.grosjean@peak-system.com>

These patches add the support for the PCAN-PCI Express FD cards made by
PEAK-System. Since these new cards run the same CAN-FD IP than the USB
CAN-FD interfaces, some common definitions are moved into a (newly created)
common header file, under include/linux/can/dev.

Stephane Grosjean (4):
  can: peak: fix usage of usb specific data type
  can: peak: fix usage of const qualifier in pointers args
  can: peak: move header file to new can common subdir
  can: peak: add support for PEAK PCAN-PCIe FD CAN-FD boards

 drivers/net/can/Kconfig                       |   1 +
 drivers/net/can/Makefile                      |   1 +
 drivers/net/can/peak_canfd/Kconfig            |  13 +
 drivers/net/can/peak_canfd/Makefile           |   5 +
 drivers/net/can/peak_canfd/peak_canfd.c       | 801 ++++++++++++++++++++++++
 drivers/net/can/peak_canfd/peak_canfd_user.h  |  55 ++
 drivers/net/can/peak_canfd/peak_pciefd_main.c | 842 ++++++++++++++++++++++++++
 drivers/net/can/usb/peak_usb/pcan_ucan.h      | 244 --------
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c    |  25 +-
 include/linux/can/dev/peak_canfd.h            | 308 ++++++++++
 10 files changed, 2039 insertions(+), 256 deletions(-)
 create mode 100644 drivers/net/can/peak_canfd/Kconfig
 create mode 100644 drivers/net/can/peak_canfd/Makefile
 create mode 100644 drivers/net/can/peak_canfd/peak_canfd.c
 create mode 100644 drivers/net/can/peak_canfd/peak_canfd_user.h
 create mode 100644 drivers/net/can/peak_canfd/peak_pciefd_main.c
 delete mode 100644 drivers/net/can/usb/peak_usb/pcan_ucan.h
 create mode 100644 include/linux/can/dev/peak_canfd.h

-- 
2.7.4

