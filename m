From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH 0/2] can: peak: Fix bittiming ranges and add PCAN-USB X6 support
Date: Thu,  1 Dec 2016 11:41:10 +0100
Message-ID: <1480588872-13555-1-git-send-email-s.grosjean@peak-system.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:44314 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751451AbcLAKlR (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 1 Dec 2016 05:41:17 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>, Stephane Grosjean <s.grosjean@peak-system.com>

These patches fix obsolete bittiming ranges definitions for all USB CAN-FD
interfaces family and add support for the new PCAN-USB X6 USB CAN-FD
interface.

Stephane Grosjean (2):
  can: peak: Fix bittiming fields size in bits
  can: peak: Add support for PCAN-USB X6 USB interface

 drivers/net/can/usb/peak_usb/pcan_ucan.h     |  37 +++++++---
 drivers/net/can/usb/peak_usb/pcan_usb_core.c |   2 +
 drivers/net/can/usb/peak_usb/pcan_usb_core.h |   2 +
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c   | 104 ++++++++++++++++++++++-----
 4 files changed, 121 insertions(+), 24 deletions(-)

-- 
2.7.4

