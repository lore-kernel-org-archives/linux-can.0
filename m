From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH 0/2] Add support of sja1000-based PEAK-System cards
Date: Mon, 27 Feb 2012 16:49:38 +0100
Message-ID: <1330357780-13934-1-git-send-email-s.grosjean@peak-system.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-1d.bbox.fr ([194.158.122.56]:52421 "EHLO mail-1d.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753367Ab2B0Ptj (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 27 Feb 2012 10:49:39 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>, Stephane Grosjean <s.grosjean@peak-system.com>

That serie of patches includes support of some new PEAK-System cards
that provide access to the CAN bus. First patch adds support for some
new PCI cards as well as adds control to the leds of the 
PCAN-PCIExpressCard (PCAN-PCIeC). Last one adds full support for the 
PCAN-PC Card PCMCIA card.

Stephane Grosjean (2):

  That version only puts together peak_pci PATCH v6.1 and 
  peak_pcmcia v4.1 into a single serie of patches that share the same
  Kconfig.

  can/peak_pci: add support of some new PEAK-System PCI cards
  can/sja1000: add support for PEAK-System PCMCIA card

 drivers/net/can/sja1000/Kconfig       |   27 +-
 drivers/net/can/sja1000/Makefile      |    1 +
 drivers/net/can/sja1000/peak_pci.c    |  505 +++++++++++++++++++++-
 drivers/net/can/sja1000/peak_pcmcia.c |  753 +++++++++++++++++++++++++++++++++
 4 files changed, 1269 insertions(+), 17 deletions(-)
 create mode 100644 drivers/net/can/sja1000/peak_pcmcia.c

-- 
1.7.5.4

