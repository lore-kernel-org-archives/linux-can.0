From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 0/9] can: use dev_get_platdata()
Date: Tue, 10 Sep 2013 17:39:28 +0900
Message-ID: <004701ceae01$4303dcd0$c90b9670$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:33187 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752943Ab3IJIja (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 10 Sep 2013 04:39:30 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MSW009Q8IPSNZR0@mailout4.samsung.com> for
 linux-can@vger.kernel.org; Tue, 10 Sep 2013 17:39:28 +0900 (KST)
Content-language: ko
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: 'Marc Kleine-Budde' <mkl@pengutronix.de>
Cc: 'Wolfgang Grandegger' <wg@grandegger.com>, linux-can@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

Use the wrapper function for retrieving the platform data instead of
accessing dev->platform_data directly. This is a cosmetic change
to make the code simpler and enhance the readability.

---
 drivers/net/can/at91_can.c                 |    2 +-
 drivers/net/can/bfin_can.c                 |    2 +-
 drivers/net/can/cc770/cc770_platform.c     |    4 ++--
 drivers/net/can/flexcan.c                  |    2 +-
 drivers/net/can/janz-ican3.c               |    2 +-
 drivers/net/can/mcp251x.c                  |    2 +-
 drivers/net/can/sja1000/sja1000_platform.c |    2 +-
 drivers/net/can/softing/softing_main.c     |    2 +-
 drivers/net/can/ti_hecc.c                  |    2 +-
 9 files changed, 10 insertions(+), 10 deletions(-)

