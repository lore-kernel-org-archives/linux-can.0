From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH 0/2] can/sja1000: Add/upgrade PEAK-System sja1000 driver
Date: Tue, 31 Jan 2012 14:19:18 +0100
Message-ID: <1328015960-14744-1-git-send-email-s.grosjean@peak-system.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-1d.bbox.fr ([194.158.122.56]:55527 "EHLO mail-1d.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752242Ab2AaNTh (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 31 Jan 2012 08:19:37 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>, Stephane Grosjean <s.grosjean@peak-system.com>

That serie of patches upgrades the peak_pci driver and adds the peak_pcmcia
new driver, to handle all the sja1000 PCI based from PEAK-System Technik
(http://www.peak-system.com).
These patches are planned for kernel v3.02.00 and above.

Stephane Grosjean (1):
  can/sja1000: Add PEAK-System PCIe/PCIeC and miniPCI boards

Stephane Grosjean (1):
  can/sja1000: Add support of PEAK-System PCMCIA board

 drivers/net/can/sja1000/Kconfig       |    9 +
 drivers/net/can/sja1000/Makefile      |    1 +
 drivers/net/can/sja1000/peak_pci.c    |  521 ++++++++++++++++++++++--
 drivers/net/can/sja1000/peak_pcmcia.c |  721 +++++++++++++++++++++++++++++++++
 4 files changed, 1212 insertions(+), 40 deletions(-)
 create mode 100644 drivers/net/can/sja1000/peak_pcmcia.c

-- 
1.7.5.4

