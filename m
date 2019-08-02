From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: pull-request: can 2019-08-02
Date: Fri,  2 Aug 2019 14:00:34 +0200
Message-ID: <20190802120038.18154-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-can.vger.kernel.org

Hello David,

this is a pull request of 4 patches for net/master.

The first two patches are by Wang Xiayang, they force that the string buffer
during a dev_info() is properly NULL terminated.

The last two patches are by Tomas Bortoli and fix both a potential info leak of
kernel memory to USB devices.

regards,
Marc

---

The following changes since commit 224c04973db1125fcebefffd86115f99f50f8277:

  net: usb: pegasus: fix improper read if get_registers() fail (2019-08-01 18:18:27 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-5.3-20190802

for you to fetch changes up to ead16e53c2f0ed946d82d4037c630e2f60f4ab69:

  can: peak_usb: pcan_usb_pro: Fix info-leaks to USB devices (2019-08-02 13:58:01 +0200)

----------------------------------------------------------------
linux-can-fixes-for-5.3-20190802

----------------------------------------------------------------
Tomas Bortoli (2):
      can: peak_usb: pcan_usb_fd: Fix info-leaks to USB devices
      can: peak_usb: pcan_usb_pro: Fix info-leaks to USB devices

Wang Xiayang (2):
      can: sja1000: force the string buffer NULL-terminated
      can: peak_usb: force the string buffer NULL-terminated

 drivers/net/can/sja1000/peak_pcmcia.c        | 2 +-
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 2 +-
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c   | 2 +-
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)
