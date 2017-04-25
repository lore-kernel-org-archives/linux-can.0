From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: pull-request: can 2017-04-25
Date: Tue, 25 Apr 2017 14:16:42 +0200
Message-ID: <20170425121645.9946-1-mkl@pengutronix.de>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-can.vger.kernel.org

Hello David,

this is a pull request of three patches for net/master.

There are two patches by Stephane Grosjean for that add a new variant to the
PCAN-Chip USB driver. The other patch is by Maksim Salau, which swtiches the
memory for USB transfers from heap to stack.

regrds,
Marc

---

The following changes since commit 38a98bceaf5f786b931d16826fbb46e73280849b:

  Merge branch 'dsa-b53-58xx-fixes' (2017-04-24 18:29:11 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-4.11-20170425

for you to fetch changes up to b05c73bd1e3ec60357580eb042ee932a5ed754d5:

  net: can: usb: gs_usb: Fix buffer on stack (2017-04-25 14:08:35 +0200)

----------------------------------------------------------------
linux-can-fixes-for-4.11-20170425

----------------------------------------------------------------
Maksim Salau (1):
      net: can: usb: gs_usb: Fix buffer on stack

Stephane Grosjean (2):
      can: usb: Add support of PCAN-Chip USB stamp module
      can: usb: Kconfig: Add PCAN-USB X6 device in help text

 drivers/net/can/usb/Kconfig                  |  2 +
 drivers/net/can/usb/gs_usb.c                 | 17 +++++--
 drivers/net/can/usb/peak_usb/pcan_usb_core.c |  2 +
 drivers/net/can/usb/peak_usb/pcan_usb_core.h |  2 +
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c   | 72 ++++++++++++++++++++++++++++
 5 files changed, 90 insertions(+), 5 deletions(-)
