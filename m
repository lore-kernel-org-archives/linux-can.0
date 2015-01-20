From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v6 0/7] can: peak: add support for PEAK new CANFD USB adapters
Date: Tue, 20 Jan 2015 14:57:12 +0100
Message-ID: <1421762239-20130-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from [85.220.165.65] ([85.220.165.65]:38641 "EHLO
	hardanger.do.blackshift.org" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1761099AbbA3MrM (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 30 Jan 2015 07:47:12 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: s.grosjean@peak-system.com
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>

Hey,

picking up Stephane's work. I've split up the patches see my reply on
Stephane's series for more details.

regards,
Marc

Stephane Grosjean (7):
  can: peak_usb: export ctrlmode_supported to adapter specific
  can: peak_usb: add adapter BEC callback definition
  can: peak_usb: upgrade core to new CANFD extension -
    peak_usb_set_data_bittiming()
  can: peak_usb: upgrade core to new CANFD extension - struct
    canfd_frame
  can: peak_usb: add support for PEAK new CANFD USB adapters -
    pcan_usb_pro_*()
  can: peak_usb: upgrade core to new CANFD extension - add
    peak_usb_netif_rx()
  can: peak_usb: add support for PEAK new CANFD USB adapters

 drivers/net/can/usb/Kconfig                  |   14 +-
 drivers/net/can/usb/peak_usb/Makefile        |    2 +-
 drivers/net/can/usb/peak_usb/pcan_ucan.h     |  222 ++++++
 drivers/net/can/usb/peak_usb/pcan_usb.c      |    1 +
 drivers/net/can/usb/peak_usb/pcan_usb_core.c |   67 +-
 drivers/net/can/usb/peak_usb/pcan_usb_core.h |   16 +-
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c   | 1091 ++++++++++++++++++++++++++
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c  |   17 +-
 drivers/net/can/usb/peak_usb/pcan_usb_pro.h  |   13 +
 9 files changed, 1415 insertions(+), 28 deletions(-)
 create mode 100644 drivers/net/can/usb/peak_usb/pcan_ucan.h
 create mode 100644 drivers/net/can/usb/peak_usb/pcan_usb_fd.c

-- 
2.1.4

