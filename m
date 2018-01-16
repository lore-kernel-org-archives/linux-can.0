From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: pull-request: can 2018-01-16
Date: Tue, 16 Jan 2018 15:39:10 +0100
Message-ID: <20180116143911.20783-1-mkl@pengutronix.de>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-can.vger.kernel.org

Hello David,

this is a pull reqeust of a single patch for net/master:

This patch by Stephane Grosjean fixes a potential bug in the packet
fragmentation in the peak USB driver.

regards,
Marc

---

The following changes since commit 6311b7ce42e0c1d6d944bc099dc47e936c20cf11:

  netlink: extack: avoid parenthesized string constant warning (2018-01-15 15:15:23 -0500)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-4.15-20180116

for you to fetch changes up to d8a243af1a68395e07ac85384a2740d4134c67f4:

  can: peak: fix potential bug in packet fragmentation (2018-01-16 15:33:15 +0100)

----------------------------------------------------------------
linux-can-fixes-for-4.15-20180116

----------------------------------------------------------------
Stephane Grosjean (1):
      can: peak: fix potential bug in packet fragmentation

 drivers/net/can/usb/peak_usb/pcan_usb_fd.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)
