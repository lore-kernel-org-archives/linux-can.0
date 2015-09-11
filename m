From: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>
Subject: [PATCH v4 0/2] can: Allwinner A10/A20 CAN Controller support - summary
Date: Fri, 11 Sep 2015 11:26:08 +0200
Message-ID: <1441963570-17930-1-git-send-email-info@gerhard-bertelsmann.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.rdts.de ([195.243.153.28]:36603 "EHLO mail.rdts.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751986AbbIKJ0Y (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 11 Sep 2015 05:26:24 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: mkl@pengutronix.de, Gerhard Bertelsmann <info@gerhard-bertelsmann.de>

Hi,

please find attached the next try. Thanks to Marc; AFAICR I have
worked on all mentioned issues.

[PATCH v4 1/2] Device Tree Binding Documentation
[PATCH v4 2/2] Kernel Module

History:
    v4: defines prefixed with SUNXI_
        sunxi_can_write_cmdreg tweaked
	loops in set_xxx_mode reworked
	add return value to set_xxx_mode
	sunxican_start_xmit reworked
	struct platform_driver stripped
	moved set_bittiming into open
	moved clock start into open
	add clock stop to close
        suspend reworked
        resume reworked
        fixed double counting bug

    v3: changed error state change handling (thx Andri for the hint)
        use bittiming function correct (no need to call it)
        strip down priv (suggested by Marc)
        scripts/checkpatch.pl-> no matches anymore
        sparse -> no errors or warnings anymore
    v2: cleaning
    v1: initial

Signed-off-by: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>
---
 .../devicetree/bindings/net/can/sunx_can.txt       |  40 +
 drivers/net/can/Kconfig                            |  10 +
 drivers/net/can/Makefile                           |   1 +
 drivers/net/can/sunxi_can.c                        | 867 +++++++++++++++++++++
 4 files changed, 918 insertions(+)
