From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: pull-request: can 2012-11-26
Date: Mon, 26 Nov 2012 22:47:08 +0100
Message-ID: <1353966430-12601-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36532 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755263Ab2KZVrN (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 26 Nov 2012 16:47:13 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: netdev@vger.kernel.org
Cc: linux-can@vger.kernel.org

Hello David,

two late fixes for v3.7 from Oliver Hartkopp, he found and fixed a problem in
the peak usb driver, a hardware timestamp is assigned wrong. In the second
patch he fixed a problem in the broadcast manager, in case of a timeout the
rx_ifindex is not set properly.

regards, Marc

---

The following changes since commit 194d9831f0419b5125dc94ec0ece4434d8ef74f0:

  Merge tag 'sound-3.7' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound (2012-11-24 08:32:11 -1000)

are available in the git repository at:


  git://gitorious.org/linux-can/linux-can.git fixes-for-3.7

for you to fetch changes up to 81b401100c01d2357031e874689f89bd788d13cd:

  can: bcm: initialize ifindex for timeouts without previous frame reception (2012-11-26 22:33:59 +0100)

----------------------------------------------------------------
Oliver Hartkopp (2):
      can: peak_usb: fix hwtstamp assignment
      can: bcm: initialize ifindex for timeouts without previous frame reception

 drivers/net/can/usb/peak_usb/pcan_usb.c     |    8 ++++++--
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c |    8 ++++++--
 net/can/bcm.c                               |    3 +++
 3 files changed, 15 insertions(+), 4 deletions(-)


