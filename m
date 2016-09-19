From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: pull-request: can 2016-09-19
Date: Mon, 19 Sep 2016 16:19:48 +0200
Message-ID: <20160919141949.5826-1-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:54217 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751628AbcISOT4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 19 Sep 2016 10:19:56 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de

Hello David,

this is a pull request of one patch for the upcoming linux-4.8 release.

The patch by Fabio Estevam fixes the pm handling in the flexcan driver.

regards,
Marc



---

The following changes since commit 7ac327318e09a53e3df431dfd3f664dac7aba4df:

  Merge tag 'mac80211-for-davem-2016-09-16' of git://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211 (2016-09-18 22:26:49 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-4.8-20160919

for you to fetch changes up to 4de349e786a3a2d51bd02d56f3de151bbc3c3df9:

  can: flexcan: fix resume function (2016-09-19 16:09:05 +0200)

----------------------------------------------------------------
linux-can-fixes-for-4.8-20160919

----------------------------------------------------------------
Fabio Estevam (1):
      can: flexcan: fix resume function

 drivers/net/can/flexcan.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

