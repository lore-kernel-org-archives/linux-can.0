From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH 0/2] can: peak: Add support of new USB device
Date: Mon, 27 Mar 2017 14:36:09 +0200
Message-ID: <1490618171-3128-1-git-send-email-s.grosjean@peak-system.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp1-g21.free.fr ([212.27.42.1]:36509 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752021AbdC0Mg3 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 27 Mar 2017 08:36:29 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>, Stephane Grosjean <s.grosjean@peak-system.com>

These patches add the support of the PCAN-Chip USB stamp module, as well as
fix the help section of the CAN_PEAK_USB Kconfig section.

Stephane Grosjean (2):
  can: usb: Add support of PCAN-Chip USB stamp module
  can: usb: Kconfig: Add PCAN-USB X6 device in help text

 drivers/net/can/usb/Kconfig                  |  2 +
 drivers/net/can/usb/peak_usb/pcan_usb_core.c |  2 +
 drivers/net/can/usb/peak_usb/pcan_usb_core.h |  2 +
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c   | 72 ++++++++++++++++++++++++++++
 4 files changed, 78 insertions(+)

-- 
2.7.4

