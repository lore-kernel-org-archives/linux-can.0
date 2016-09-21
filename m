From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: pull-request: can 2016-09-21
Date: Wed, 21 Sep 2016 10:43:54 +0200
Message-ID: <20160921084355.20972-1-mkl@pengutronix.de>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-can.vger.kernel.org

Hello David,

this is another pull request of one patch for the upcoming linux-4.8 release.

Marek Vasut fixes the CAN-FD bit rate switch in the ifi driver by configuring
the transmitter delay.

regards,
Marc

---

The following changes since commit b5036cd4ed3173ab8cdbc85e2ba74acf46bafb51:

  ipmr, ip6mr: return lastuse relative to now (2016-09-21 00:58:23 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-4.8-20160921

for you to fetch changes up to 8d58790b832e13d6006d842037732304af357c3c:

  net: can: ifi: Configure transmitter delay (2016-09-21 10:32:24 +0200)

----------------------------------------------------------------
linux-can-fixes-for-4.8-20160921

----------------------------------------------------------------
Marek Vasut (1):
      net: can: ifi: Configure transmitter delay

 drivers/net/can/ifi_canfd/ifi_canfd.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)
