From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: pull-request: can 2018-01-04
Date: Thu,  4 Jan 2018 16:33:51 +0100
Message-ID: <20180104153355.11243-1-mkl@pengutronix.de>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-can.vger.kernel.org

Hello David,

this is a pull request for net/master consisting of 4 patches.

The first patch is by Oliver Hartkopp, it improves the error checking
during the creation of a vxcan link. Wolfgang Grandegger's patch for the
gs_usb driver fixes the return value of the "set_bittiming" callback.
Luu An Phu provides a patch for the flexcan driver to fix the frame
length check in the flexcan_start_xmit() function. The last patch is by
Martin Lederhilger for the ems_usb driver and improves the error
reporting for error warning and passive frames.

regards,
Marc

---

The following changes since commit 820d1d5eba5e0db88432f4b19149d87523ee193c:

  Merge branch '40GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/net-queue (2018-01-03 13:49:24 -0500)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-4.15-20180104

for you to fetch changes up to 6ebc5e8fe85286c7392f1777a3dba9e1fd6d0253:

  can: ems_usb: improve error reporting for error warning and error passive (2018-01-04 16:14:38 +0100)

----------------------------------------------------------------
linux-can-fixes-for-4.15-20180104

----------------------------------------------------------------
Luu An Phu (1):
      can: flex_can: Correct the checking for frame length in flexcan_start_xmit()

Martin Lederhilger (1):
      can: ems_usb: improve error reporting for error warning and error passive

Oliver Hartkopp (1):
      can: vxcan: improve handling of missing peer name attribute

Wolfgang Grandegger (1):
      can: gs_usb: fix return value of the "set_bittiming" callback

 drivers/net/can/flexcan.c     | 2 +-
 drivers/net/can/usb/ems_usb.c | 1 +
 drivers/net/can/usb/gs_usb.c  | 2 +-
 drivers/net/can/vxcan.c       | 2 +-
 4 files changed, 4 insertions(+), 3 deletions(-)
