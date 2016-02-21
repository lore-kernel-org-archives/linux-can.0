From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: pull-request: can 2016-02-21
Date: Sun, 21 Feb 2016 16:27:37 +0100
Message-ID: <1456068458-14271-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:54875 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752841AbcBURXJ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 21 Feb 2016 12:23:09 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de

Hello David,

this is a pull reqeust of one patch for net/master.

The patch is by Gerhard Uttenthaler and fixes a potential tx overflow in the
ems_usb driver.

regards,
Marc

---

The following changes since commit d07c0278da1f4cfc91c3d46d0d07a0d13a949892:

  net: bcmgenet: Fix internal PHY link state (2016-02-19 23:51:40 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-4.5-20160221

for you to fetch changes up to 90cfde46586d2286488d8ed636929e936c0c9ab2:

  can: ems_usb: Fix possible tx overflow (2016-02-21 15:09:12 +0100)

----------------------------------------------------------------
linux-can-fixes-for-4.5-20160221

----------------------------------------------------------------
Gerhard Uttenthaler (1):
      can: ems_usb: Fix possible tx overflow

 drivers/net/can/usb/ems_usb.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)


