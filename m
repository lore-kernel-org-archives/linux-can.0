From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: pull-request: can 2015-03-14
Date: Sat, 14 Mar 2015 15:17:17 +0100
Message-ID: <1426342639-14894-1-git-send-email-mkl@pengutronix.de>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-can.vger.kernel.org

Hello David, this is a pull request for net/master, consisting of two patches:   
                                                                                 
In the first patch Michal Simek enables the xilinx CAN driver for ARM64. The
second patch by Ahmed S. Darwish fixes a race condition in the tx-queue of the
kvaser_usb driver.                                                               

regards,
Marc

---

The following changes since commit c8e2c80d7ec00d020320f905822bf49c5ad85250:

  inet_diag: fix possible overflow in inet_diag_dump_one_icsk() (2015-03-13 15:54:27 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-4.0-20150314

for you to fetch changes up to a9dc960c37b0d4eb192598dc4c94276270454514:

  can: kvaser_usb: Fix tx queue start/stop race conditions (2015-03-14 09:20:07 +0100)

----------------------------------------------------------------
linux-can-fixes-for-4.0-20150314

----------------------------------------------------------------
Ahmed S. Darwish (1):
      can: kvaser_usb: Fix tx queue start/stop race conditions

Michal Simek (1):
      net: can: Enable xilinx driver for ARM64

 drivers/net/can/Kconfig          |  2 +-
 drivers/net/can/usb/kvaser_usb.c | 83 ++++++++++++++++++++++++----------------
 2 files changed, 52 insertions(+), 33 deletions(-)
