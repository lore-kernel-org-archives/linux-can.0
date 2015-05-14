From: Bhupesh Sharma <bhupesh.sharma@freescale.com>
Subject: [PATCH v2 0/5] Add flexcan support for LS1021A SoCs
Date: Thu, 14 May 2015 17:03:30 +0530
Message-ID: <1431603215-25546-1-git-send-email-bhupesh.sharma@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bn1bon0110.outbound.protection.outlook.com ([157.56.111.110]:62751
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751563AbbENLeI (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 14 May 2015 07:34:08 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: arnd@arndb.de, linux-can@vger.kernel.org, mkl@pengutronix.de
Cc: bhupesh.linux@gmail.com, bhupesh.sharma@freescale.com, Sakar.Arora@freescale.com, linux-arm-kernel@lists.infradead.org

This patchset add the support for FlexCAN module present
on LS1021A SoCs.

LS1021A-Rev1 SoC has a broken RX FIFO mode, thereby mandating
the use of message buffers for frame reception.

LS1021A-Rev2 SoC has this issue fixed.

Bhupesh Sharma (3):
  doc/bindings: Add 'endianess' optional-property for FlexCAN
    controller
  can: flexcan: Add ls1021a flexcan device entry
  can: flexcan: Add support for non RX-FIFO mode

Sakar Arora (2):
  arm/dts: Add nodes for flexcan devices present on LS1021A SoC
  can: flexcan: Remodel FlexCAN register r/w APIs for BE instances

 .../devicetree/bindings/net/can/fsl-flexcan.txt    |    4 +
 arch/arm/boot/dts/ls1021a-qds.dts                  |    8 +
 arch/arm/boot/dts/ls1021a.dtsi                     |   18 +
 drivers/net/can/flexcan.c                          |  400 +++++++++++++-------
 4 files changed, 299 insertions(+), 131 deletions(-)

-- 
1.7.9.5


