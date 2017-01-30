From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: pull-request: can 2017-01-30
Date: Mon, 30 Jan 2017 11:11:00 +0100
Message-ID: <20170130101101.14150-1-mkl@pengutronix.de>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-can.vger.kernel.org

Hello David,

this is a pull request of one patch.

The patch is by Oliver Hartkopp and fixes the hrtimer/tasklet termination in
bcm op removal.

regards,
Marc

---

The following changes since commit d1156b489fa734d1af763d6a07b1637c01bb0aed:

  net: adaptec: starfire: add checks for dma mapping errors (2017-01-29 19:04:11 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-4.10-20170130

for you to fetch changes up to a06393ed03167771246c4c43192d9c264bc48412:

  can: bcm: fix hrtimer/tasklet termination in bcm op removal (2017-01-30 11:05:04 +0100)

----------------------------------------------------------------
linux-can-fixes-for-4.10-20170130

----------------------------------------------------------------
Oliver Hartkopp (1):
      can: bcm: fix hrtimer/tasklet termination in bcm op removal

 net/can/bcm.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)
