From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: pull-request: can 2017-12-08
Date: Fri,  8 Dec 2017 16:58:11 +0100
Message-ID: <20171208155817.9364-1-mkl@pengutronix.de>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-can.vger.kernel.org

Hello David,

this is a pull request of 6 patches for net/master.

Martin Kelly provides 5 patches for various USB based CAN drivers, that
properly cancel the URBs on adapter unplug, so that the driver doesn't
end up in an endless loop. Stephane Grosjean provides a patch to restart
the tx queue if zero length packages are transmitted.

regards,
Marc

---

The following changes since commit 195bd525d5f6e338b948d9a6b25bfaae86291353:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf (2017-12-07 16:22:51 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-4.15-20171208

for you to fetch changes up to 91785de6f94b58c3fb6664609e3682f011bd28d2:

  can: peak/pcie_fd: fix potential bug in restarting tx queue (2017-12-08 10:51:53 +0100)

----------------------------------------------------------------
linux-can-fixes-for-4.15-20171208

----------------------------------------------------------------
Martin Kelly (5):
      can: mcba_usb: cancel urb on -EPROTO
      can: ems_usb: cancel urb on -EPIPE and -EPROTO
      can: esd_usb2: cancel urb on -EPIPE and -EPROTO
      can: kvaser_usb: cancel urb on -EPIPE and -EPROTO
      can: usb_8dev: cancel urb on -EPIPE and -EPROTO

Stephane Grosjean (1):
      can: peak/pcie_fd: fix potential bug in restarting tx queue

 drivers/net/can/peak_canfd/peak_canfd.c | 9 +++------
 drivers/net/can/usb/ems_usb.c           | 2 ++
 drivers/net/can/usb/esd_usb2.c          | 2 ++
 drivers/net/can/usb/kvaser_usb.c        | 2 ++
 drivers/net/can/usb/mcba_usb.c          | 1 +
 drivers/net/can/usb/usb_8dev.c          | 2 ++
 6 files changed, 12 insertions(+), 6 deletions(-)
