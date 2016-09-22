From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: pull-request: can 2016-09-22
Date: Thu, 22 Sep 2016 14:42:21 +0200
Message-ID: <20160922124222.31598-1-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:33814 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756095AbcIVMm2 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 22 Sep 2016 08:42:28 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de

Hello David,

this is a pull request of one patch for the upcoming linux-4.8 release.

The patch by Sergei Miroshnichenko fixes a potential deadlock in the generic
CAN device code that cann occour after a bus-off.

regards,
Marc

---

The following changes since commit 7e32b44361abc77fbc01f2b97b045c405b2583e5:

  tcp: properly account Fast Open SYN-ACK retrans (2016-09-22 03:33:01 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-4.8-20160922

for you to fetch changes up to 9abefcb1aaa58b9d5aa40a8bb12c87d02415e4c8:

  can: dev: fix deadlock reported after bus-off (2016-09-22 10:01:21 +0200)

----------------------------------------------------------------
linux-can-fixes-for-4.8-20160922

----------------------------------------------------------------
Sergei Miroshnichenko (1):
      can: dev: fix deadlock reported after bus-off

 drivers/net/can/dev.c   | 27 +++++++++++++++++----------
 include/linux/can/dev.h |  3 ++-
 2 files changed, 19 insertions(+), 11 deletions(-)

