From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: pull-request: can 2016-12-02
Date: Fri,  2 Dec 2016 09:29:29 +0100
Message-ID: <20161202082931.22270-1-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:53887 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755957AbcLBI3r (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 2 Dec 2016 03:29:47 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de

Hello David,

this is a pull request for net/master.

THere are two patches by Stephane Grosjean, who adds support for the new
PCAN-USB X6 USB interface to the pcan_usb driver.

regards,
Marc

---

The following changes since commit aa196eed3d80d4b003b04a270712b978a012a939:

  macvtap: handle ubuf refcount correctly when meet errors (2016-11-30 15:06:02 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-4.9-20161201

for you to fetch changes up to f00b534ded60bd0a23c2fa8dec4ece52aa7d235f:

  can: peak: Add support for PCAN-USB X6 USB interface (2016-12-01 14:12:20 +0100)

----------------------------------------------------------------
linux-can-fixes-for-4.9-20161201

----------------------------------------------------------------
Stephane Grosjean (2):
      can: peak: Fix bittiming fields size in bits
      can: peak: Add support for PCAN-USB X6 USB interface

 drivers/net/can/usb/peak_usb/pcan_ucan.h     |  37 +++++++---
 drivers/net/can/usb/peak_usb/pcan_usb_core.c |   2 +
 drivers/net/can/usb/peak_usb/pcan_usb_core.h |   2 +
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c   | 104 ++++++++++++++++++++++-----
 4 files changed, 121 insertions(+), 24 deletions(-)

