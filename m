From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: pull-request: can 2019-11-14
Date: Thu, 14 Nov 2019 10:45:47 +0100
Message-ID: <20191114094548.4867-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-can.vger.kernel.org

Hello David,

here another pull request for net/master consisting of one patch (including my S-o-b).

Jouni Hogander's patch fixes a memory leak found by the syzbot in the slcan
driver's error path.

Marc

---

The following changes since commit a56dcc6b455830776899ce3686735f1172e12243:

  net: cdc_ncm: Signedness bug in cdc_ncm_set_dgram_size() (2019-11-13 14:30:16 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-5.4-20191114

for you to fetch changes up to ed50e1600b4483c049ce76e6bd3b665a6a9300ed:

  slcan: Fix memory leak in error path (2019-11-14 10:38:30 +0100)

----------------------------------------------------------------
linux-can-fixes-for-5.4-20191114

----------------------------------------------------------------
Jouni Hogander (1):
      slcan: Fix memory leak in error path

 drivers/net/can/slcan.c | 1 +
 1 file changed, 1 insertion(+)
