From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: pull-request: can 2015-06-21
Date: Sun, 21 Jun 2015 19:04:58 +0200
Message-ID: <1434906299-19452-1-git-send-email-mkl@pengutronix.de>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-can.vger.kernel.org

Hello David,

this is a, probably too late, pull request for v4.1.

Oliver Hartkopp fixed a bug in the generic CAN frame handling code, which may
lead to loss of CAN frames. It was introduced during v4.1 development.

Please queue via net/master if possible, net-next/master otherwise. I've added
stable on Cc, just in case.

regards,
Marc
---

The following changes since commit 7b48f45797be7c4bdbb772de80efe6bdcd78e81d:

  isdn: disable HiSax NetJet driver on microblaze arch (2015-06-21 09:53:01 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-4.1-20150621

for you to fetch changes up to 36c01245eb8046c16eee6431e7dbfbb302635fa8:

  can: fix loss of CAN frames in raw_rcv (2015-06-21 18:58:58 +0200)

----------------------------------------------------------------
linux-can-fixes-for-4.1-20150621

----------------------------------------------------------------
Oliver Hartkopp (1):
      can: fix loss of CAN frames in raw_rcv

 drivers/net/can/dev.c   | 5 +++++
 drivers/net/can/slcan.c | 1 +
 drivers/net/can/vcan.c  | 3 +++
 net/can/af_can.c        | 6 +++++-
 4 files changed, 14 insertions(+), 1 deletion(-)
