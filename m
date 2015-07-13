From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: pull-request: can 2015-07-13
Date: Mon, 13 Jul 2015 09:22:16 +0200
Message-ID: <1436772148-9805-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34986 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751096AbbGMHWb (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 13 Jul 2015 03:22:31 -0400
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=hardanger.blackshift.org)
	by metis.ext.pengutronix.de with esmtp (Exim 4.80)
	(envelope-from <mkl@pengutronix.de>)
	id 1ZEWCV-0007cb-0m
	for linux-can@vger.kernel.org; Mon, 13 Jul 2015 07:22:47 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hello David,

this is a pull request of 12 patches by me.

This series fixes the use of the skb after netif_receive_skb() / netif_rx()
which exists in several driver.

Marc
---

The following changes since commit cee9f6d0186a586c8023bc91c8a4cf8a088855e5:

  Merge tag 'linux-can-fixes-for-4.2-20150712' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can (2015-07-12 22:24:01 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-4.2-20150713

for you to fetch changes up to 95935983f875ac91c43eef04bc56199cc39face6:

  can: pcan_usb: don't touch skb after netif_rx() (2015-07-13 08:56:04 +0200)

----------------------------------------------------------------
linux-can-fixes-for-4.2-20150713

----------------------------------------------------------------
Marc Kleine-Budde (12):
      can: at91_can: don't touch skb after netif_receive_skb()/netif_rx()
      can: flexcan: don't touch skb after netif_receive_skb()
      can: bfin_can: don't touch skb after netif_rx()
      can: grcan: don't touch skb after netif_rx()
      can: slcan: don't touch skb after netif_rx_ni()
      can: ti_heccn: don't touch skb after netif_rx()
      can: cc770: don't touch skb after netif_rx()
      can: sja1000: don't touch skb after netif_rx()
      can: esd_usb2: don't touch skb after netif_rx()
      can: ems_usb: don't touch skb after netif_rx()
      can: usb_8dev: don't touch skb after netif_rx()
      can: pcan_usb: don't touch skb after netif_rx()

 drivers/net/can/at91_can.c                  | 8 ++++----
 drivers/net/can/bfin_can.c                  | 6 ++----
 drivers/net/can/cc770/cc770.c               | 4 ++--
 drivers/net/can/flexcan.c                   | 7 +++----
 drivers/net/can/grcan.c                     | 3 ++-
 drivers/net/can/sja1000/sja1000.c           | 6 ++----
 drivers/net/can/slcan.c                     | 2 +-
 drivers/net/can/ti_hecc.c                   | 2 +-
 drivers/net/can/usb/ems_usb.c               | 6 ++----
 drivers/net/can/usb/esd_usb2.c              | 6 ++----
 drivers/net/can/usb/peak_usb/pcan_usb.c     | 7 +++----
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c | 4 ++--
 drivers/net/can/usb/usb_8dev.c              | 6 ++----
 13 files changed, 28 insertions(+), 39 deletions(-)

