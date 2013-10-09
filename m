From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: pull-request: can 2013-10-09
Date: Wed,  9 Oct 2013 23:11:55 +0200
Message-ID: <1381353118-25111-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52490 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755869Ab3JIVMG (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 9 Oct 2013 17:12:06 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de

Hello David,

here are three fixes for the v3.12 release cycle. The first fixes a regression
in the flexcan driver which was introduced in a previous v3.12 patch. The
second one fixes the mx28 detection in the flexcan driver. The third one
targets the at91_can driver and fixes the driver data mapping for platform
devices.

regards, Marc
---

The following changes since commit 87b0a0b5c46aea63cdc5c5d788fe2c91406e3161:

  Merge branch 'for-davem' of git://git.kernel.org/pub/scm/linux/kernel/git/linville/wireless (2013-10-09 14:04:00 -0400)

are available in the git repository at:


  git://gitorious.org/linux-can/linux-can.git fixes-for-3.12

for you to fetch changes up to 5abbeea553c8260ed4e2ac4aae962aff800b6c6d:

  can: at91-can: fix device to driver data mapping for platform devices (2013-10-09 23:04:31 +0200)

----------------------------------------------------------------
Marc Kleine-Budde (3):
      can: flexcan: flexcan_chip_start: fix regression, mark one MB for TX and abort pending TX
      can: flexcan: fix mx28 detection by rearanging OF match table
      can: at91-can: fix device to driver data mapping for platform devices

 drivers/net/can/at91_can.c |  4 ++--
 drivers/net/can/flexcan.c  | 14 ++++++++++----
 2 files changed, 12 insertions(+), 6 deletions(-)

