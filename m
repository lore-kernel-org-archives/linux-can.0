From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: pull-request: can 2012-06-27
Date: Wed, 27 Jun 2012 11:27:15 +0200
Message-ID: <1340789236-28266-1-git-send-email-mkl@pengutronix.de>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Hello David,

here's a patch intended for v3.5, targeting net/master. Hui Wang has
found and fixed an endianness problem in the device tree handling in
the flexcan driver.

regards, Marc

---

The following changes since commit 6bc96d047fe32d76ef79f3195c52a542edf7c705:

  xen/netfront: teardown the device before unregistering it. (2012-06-27 01:25:41 -0700)

are available in the git repository at:

  git://gitorious.org/linux-can/linux-can.git for-davem

for you to fetch changes up to 85f2f834e85517307f13e30e630a5fc86f757cb5:

  can: flexcan: use be32_to_cpup to handle the value of dt entry (2012-06-27 11:12:07 +0200)

----------------------------------------------------------------
Hui Wang (1):
      can: flexcan: use be32_to_cpup to handle the value of dt entry

 drivers/net/can/flexcan.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
