From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: pull-request: can 2015-08-24
Date: Mon, 24 Aug 2015 11:20:02 +0200
Message-ID: <1440408003-13085-1-git-send-email-mkl@pengutronix.de>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-can.vger.kernel.org

Hello David,

this is a pull request of one patch by me for the peak_usb driver. It fixes the
driver, so that non FD adapters don't provide CAN FD bittimings.

regards,
Marc

----

The following changes since commit b6df7d61c8776a882dd47ba4714d1445dd7ef2d9:

  net: bcmgenet: fix uncleaned dma flags (2015-08-23 23:00:41 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-4.2-20150824

for you to fetch changes up to ffa115d30dec793f37ca661d2d3f8e35c14559e9:

  can: pcan_usb: don't provide CAN FD bittimings by non-FD adapters (2015-08-24 11:15:10 +0200)

----------------------------------------------------------------
linux-can-fixes-for-4.2-20150824

----------------------------------------------------------------
Marc Kleine-Budde (1):
      can: pcan_usb: don't provide CAN FD bittimings by non-FD adapters

 drivers/net/can/usb/peak_usb/pcan_usb.c      | 24 +++----
 drivers/net/can/usb/peak_usb/pcan_usb_core.c |  4 +-
 drivers/net/can/usb/peak_usb/pcan_usb_core.h |  4 +-
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c   | 96 +++++++++++++++-------------
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c  | 24 +++----
 5 files changed, 82 insertions(+), 70 deletions(-)
