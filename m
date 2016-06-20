From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: pull-request: can 2016-06-20
Date: Mon, 20 Jun 2016 10:00:27 +0200
Message-ID: <1466409630-6268-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:51432 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752131AbcFTIAi (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 20 Jun 2016 04:00:38 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de

Hello David,

this is a pull request of 3 patches for the upcoming linux-4.7 release.

The first patch is by Thor Thayer for the c_can/d_can driver. It fixes the
registar access on Altera Cyclone devices, which caused CAN frames to have 0x0
in the first two bytes incorrectly. Wolfgang Grandegger's patch for the at91
driver fixes a hanging driver under high bus load situations. A patch for the
gs_usb driver by Maximilian Schneider adds support for the bytewerk.org
candleLight interface.

regards,
Marc

---

The following changes since commit ab522fd68bc78f3f81f6c553f785dae3462859fa:

  Merge branch 'qed-fixes' (2016-06-19 10:47:33 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-4.7-20160620

for you to fetch changes up to f155d9c0a138463c3c9380d35e54e433c1477336:

  can: gs_usb: Add Basic support for the bytewerk.org candleLight interface (2016-06-20 09:32:40 +0200)

----------------------------------------------------------------
linux-can-fixes-for-4.7-20160620

----------------------------------------------------------------
Maximilian Schneider (1):
      can: gs_usb: Add Basic support for the bytewerk.org candleLight interface

Thor Thayer (1):
      can: c_can: Update D_CAN TX and RX functions to 32 bit - fix Altera Cyclone access

Wolfgang Grandegger (1):
      can: at91_can: RX queue could get stuck at high bus load

 drivers/net/can/at91_can.c    |  5 +++--
 drivers/net/can/c_can/c_can.c | 38 +++++++++++++++++++++++++++++++-------
 drivers/net/can/usb/Kconfig   |  3 ++-
 drivers/net/can/usb/gs_usb.c  | 14 +++++++++++---
 4 files changed, 47 insertions(+), 13 deletions(-)

