From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: pull-request: can 2019-01-22
Date: Tue, 22 Jan 2019 14:21:12 +0100
Message-ID: <20190122132116.7074-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-can.vger.kernel.org

Hello David,

this is a pull request of 4 patches for net/master.

The first patch by is by Manfred Schlaegl and reverts a patch that caused wrong
warning messages in certain use cases. The next patch is by Oliver Hartkopp for
the bcm that adds sanity checks for the timer value before using it to detect
potential interger overflows. The last two patches are for the flexcan driver,
YueHaibing's patch fixes the the return value in the error path of the
flexcan_setup_stop_mode() function. The second patch is by Uwe Kleine-König and
fixes a NULL pointer deref on older flexcan cores in flexcan_chip_start().

regards,
Marc

---

The following changes since commit 49a57857aeea06ca831043acbb0fa5e0f50602fd:

  Linux 5.0-rc3 (2019-01-21 13:14:44 +1300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-5.0-20190122

for you to fetch changes up to a55234dabe1f72cf22f9197980751d37e38ba020:

  can: flexcan: fix NULL pointer exception during bringup (2019-01-22 11:35:33 +0100)

----------------------------------------------------------------
linux-can-fixes-for-5.0-20190122

----------------------------------------------------------------
Manfred Schlaegl (1):
      can: dev: __can_get_echo_skb(): fix bogous check for non-existing skb by removing it

Oliver Hartkopp (1):
      can: bcm: check timer values before ktime conversion

Uwe Kleine-König (1):
      can: flexcan: fix NULL pointer exception during bringup

YueHaibing (1):
      can: flexcan: fix 'passing zero to ERR_PTR()' warning

 drivers/net/can/dev.c     | 27 +++++++++++++--------------
 drivers/net/can/flexcan.c |  4 ++--
 net/can/bcm.c             | 27 +++++++++++++++++++++++++++
 3 files changed, 42 insertions(+), 16 deletions(-)

regards,
Marc
