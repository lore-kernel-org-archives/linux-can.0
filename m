From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: pull-request: can 2014-08-21
Date: Thu, 21 Aug 2014 11:23:18 +0200
Message-ID: <1408613002-29693-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42642 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754198AbaHUJXa (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 21 Aug 2014 05:23:30 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de

Hello David,

this is a pull request of 4 patches for net.

The first patch is from Mirza Krak, it fixes the initialization of the hardware
in the sja1000 driver. The next patch is contributed by Dan Carpenter, it fixes
the error handling in the c_can's probe function. Then there are two patches
for the flexcan driver, one by Alexander Stein, which fixes the resetting of
the bus error interrupt mask, the other one by Sebastian Andrzej Siewior which
adds an additional error state transition message.

regards,
Marc

---

The following changes since commit 02784f1b05b8f241c8180af88869e717e2758593:

  tipc: Fix build. (2014-08-19 11:16:38 -0700)

are available in the git repository at:

  git://gitorious.org/linux-can/linux-can.git tags/linux-can-fixes-for-3.17-20140821

for you to fetch changes up to 8ce261d0bb491da957278cdcba207791f329d1da:

  can: flexcan: handle state passive -> warning transition (2014-08-21 10:50:00 +0200)

----------------------------------------------------------------
linux-can-fixes-for-3.17-20140821

----------------------------------------------------------------
Alexander Stein (1):
      can: flexcan: Disable error interrupt when bus error reporting is disabled

Dan Carpenter (1):
      can: c_can: checking IS_ERR() instead of NULL

Mirza Krak (1):
      can: sja1000: Validate initialization state in start method

Sebastian Andrzej Siewior (1):
      can: flexcan: handle state passive -> warning transition

 drivers/net/can/c_can/c_can_platform.c |  2 +-
 drivers/net/can/flexcan.c              |  9 +++++
 drivers/net/can/sja1000/sja1000.c      | 62 ++++++++++++++++++----------------
 3 files changed, 43 insertions(+), 30 deletions(-)

