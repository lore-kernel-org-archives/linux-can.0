From: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>
Subject: [PATCH v3 0/2] Allwinner A10/A20 CAN Controller support
Date: Fri,  4 Sep 2015 16:29:46 +0200
Message-ID: <1441376988-2384-1-git-send-email-info@gerhard-bertelsmann.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.rdts.de ([195.243.153.28]:45264 "EHLO mail.rdts.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932937AbbIDO3y (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 4 Sep 2015 10:29:54 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: mkl@pengutronix.de, Gerhard Bertelsmann <info@gerhard-bertelsmann.de>

Allwinner A10/A20 CAN Controller support

[PATCH v3 1/2] Device Tree Binding Documentation
[PATCH v3 2/2] Kernel Module

History:
	v3: changed error state change handling (thx Andri for the hint)
	    use bittiming function correct (no need to call it)
	    strip down priv (suggested by Marc)
	    scripts/checkpatch.pl-> no matches anymore
	    sparse -> no errors or warnings anymore
	v2: cleaning
	v1: initial

Signed-off-by: Gerhard Bertelsmann < info@gerhard-bertelsmann.de >
Tested-by: Gerhard Bertelsmann < info@gerhard-bertelsmann.de >
---
 .../devicetree/bindings/net/can/sunxi_can.txt       |  42 ++
 drivers/net/can/Kconfig                            |  10 +
 drivers/net/can/Makefile                           |   1 +
 drivers/net/can/sunxi_can.c                        | 834 +++++++++++++++++++++
 4 files changed, 887 insertions(+)
