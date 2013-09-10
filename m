From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 0/3] can: remove unnecessary pci_set_drvdata()
Date: Tue, 10 Sep 2013 20:05:59 +0900
Message-ID: <00a801ceae15$bb3daa50$31b8fef0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:53069 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751075Ab3IJLGC (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 10 Sep 2013 07:06:02 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MSW005GEPHZP8B0@mailout2.samsung.com> for
 linux-can@vger.kernel.org; Tue, 10 Sep 2013 20:06:00 +0900 (KST)
Content-language: ko
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: 'Marc Kleine-Budde' <mkl@pengutronix.de>
Cc: 'Wolfgang Grandegger' <wg@grandegger.com>, linux-can@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

Since commit 0998d0631001288a5974afc0b2a5f568bcdecb4d
(device-core: Ensure drvdata = NULL when no driver is bound),
the driver core clears the driver data to NULL after device_release
or on probe failure. Thus, it is not needed to manually clear the
device driver data to NULL.

---
 drivers/net/can/c_can/c_can_pci.c    |    2 --
 drivers/net/can/pch_can.c            |    1 -
 drivers/net/can/sja1000/ems_pci.c    |    1 -
 drivers/net/can/sja1000/kvaser_pci.c |    1 -
 drivers/net/can/sja1000/peak_pci.c   |    2 --
 drivers/net/can/sja1000/plx_pci.c    |    1 -
 6 files changed, 8 deletions(-)

