From: Wolfgang Grandegger <wg@grandegger.com>
Subject: [RFC PATCH 00/14] consolidate and unify state change and bus-off handling
Date: Wed,  7 Dec 2011 15:55:14 +0100
Message-ID: <1323269728-17491-1-git-send-email-wg@grandegger.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:49250 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756255Ab1LGOzi (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 7 Dec 2011 09:55:38 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: socketcan-users@lists.berlios.de, Wolfgang Grandegger <wg@grandegger.com>

As already announced, here is my first patch series to consolidate the
handling of CAN error state changes and bus-off.

I have also updated the Flexcan driver to behave like the other drivers,
especially bus error reporting is now enabled via interrupt source. This
works on my i.MX28 SOC. Marc, would be nice if you could test it on
other SOCs as well (or somebody else). Hopefully we will not need to
handle different hardware variants of the Flexcan controller.

I separated "consolidate error state handling" and "consolidate bus-off
handling" to make the difference clear. The latter one is more delicate
as it relys on the "back to error active" change to arrive to re-enable
the TX queue.

I have also pushed these patches to my cloned Gitrorious repository
"wg-linux-can-next". See:

https://gitorious.org/~wgrandegger/linux-can/wg-linux-can-next/commits/master

Any comments are appreciated.

Wolfgang.

Wolfgang Grandegger (14):
  can: flexcan: fix irq flooding by clearing all interrupt sources
  can: replace the dev_dbg/info/err/... with the new netdev_xxx macros
  can: flexcan: only for bus error reporting enable berr interrupt
  can: bfin_can/ti_hecc/mscan: add missing do_get_berr_counter callback
  can: add error counters to the data fields of any CAN error message
  can: dev: consolidate error state change handling
  can: flexcan: consolidate error state handling
  can: flexcan: consolidate bus-off handling
  can: sja1000: consolidate error state handling
  can: sja1000: consolidate bus-off handling
  can: mscan: consolidate error state handling
  can: mscan: consolidate bus-off handling
  can: cc770: consolidate error state handling
  can: cc770: consolidate bus-off handling

 drivers/net/can/bfin_can.c        |   36 +++++---
 drivers/net/can/cc770/cc770.c     |   57 ++++++-----
 drivers/net/can/dev.c             |  103 +++++++++++++++++---
 drivers/net/can/flexcan.c         |  194 ++++++++++++-------------------------
 drivers/net/can/mcp251x.c         |    3 +-
 drivers/net/can/mscan/mscan.c     |  129 ++++++++++++-------------
 drivers/net/can/sja1000/sja1000.c |   67 ++++++-------
 drivers/net/can/ti_hecc.c         |   32 ++++--
 drivers/net/can/usb/ems_usb.c     |   57 +++++-------
 drivers/net/can/usb/esd_usb2.c    |   27 +++---
 include/linux/can/dev.h           |   11 ++
 include/linux/can/error.h         |    2 +
 12 files changed, 369 insertions(+), 349 deletions(-)

-- 
1.7.4.1

