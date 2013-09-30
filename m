From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: pull-request: can 2013-09-30
Date: Mon, 30 Sep 2013 13:59:02 +0200
Message-ID: <1380542343-5299-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-can.vger.kernel.org

Hello David,

here is a fix for the v3.12 release cycle. Lothar Wa=C3=9Fmann reported=
 a problem in
the flexcan driver that leads to an imprecise external abort on imx6. T=
he patch
by me fixes the problem. It was tested by Lothar on imx53 and imx6.

regards,
Marc

---

The following changes since commit 9a3bab6b05383f1e4c3716b3615500c51285=
959e:

  net: net_secret should not depend on TCP (2013-09-28 15:19:40 -0700)

are available in the git repository at:

  git://gitorious.org/linux-can/linux-can.git fixes-for-3.12

for you to fetch changes up to 0d1862ea1a5bb876cf05555a7307080cb75bf379=
:

  can: flexcan: fix flexcan_chip_start() on imx6 (2013-09-30 13:49:09 +=
0200)

----------------------------------------------------------------
Marc Kleine-Budde (1):
      can: flexcan: fix flexcan_chip_start() on imx6

 drivers/net/can/flexcan.c | 12 ------------
 1 file changed, 12 deletions(-)
