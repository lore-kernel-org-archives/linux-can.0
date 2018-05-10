From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: pull-request: can 2018-05-10
Date: Thu, 10 May 2018 18:47:47 +0200
Message-ID: <20180510164749.20481-1-mkl@pengutronix.de>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-can.vger.kernel.org

Hello David,

this is a pull request for net/master consisting of 2 patches.

Both patches are from Lukas Wunner and fix two problems found in the hi311x CAN
driver under high load situations.

regards,
Marc

---

The following changes since commit 4a026da91caaa36004a53a844dd00959370ea8fc:

  net/9p: correct some comment errors in 9p file system code (2018-05-10 08:21:53 -0400)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-4.17-20180510

for you to fetch changes up to 32bee8f48fa048a3198109de50e51c092507ff52:

  can: hi311x: Work around TX complete interrupt erratum (2018-05-10 18:25:30 +0200)

----------------------------------------------------------------
linux-can-fixes-for-4.17-20180510

----------------------------------------------------------------
Lukas Wunner (2):
      can: hi311x: Acquire SPI lock on ->do_get_berr_counter
      can: hi311x: Work around TX complete interrupt erratum

 drivers/net/can/spi/hi311x.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)
