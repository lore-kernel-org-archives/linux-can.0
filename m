From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH 0/4] Add DT support to C_CAN/D_CAN controller
Date: Wed, 25 Jul 2012 11:53:33 +0530
Message-ID: <1343197417-27481-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55462 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932767Ab2GYGYL (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 25 Jul 2012 02:24:11 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: wg@grandegger.com, mkl@pengutronix.de, linux-can@vger.kernel.org
Cc: anantgole@ti.com, nsekhar@ti.com, AnilKumar Ch <anilkumar@ti.com>

This patch series adds the device tree support to C_CAN/D_CAN
controller with pinmux configuration and device tree data
addition to corresponding dts and dtsi files.

Also adds Runtime PM support to C_CAN/D_CAN controller.

These patches have been tested on AM335x EVM using some additional
patch to initialize D_CAN RAM. D_CAN raminit is controlled from
control module register. This patch will be submitted once control
module MFD driver support is added to mainline.

Due to lack of hardware I am not able to test c_can functionality.
I appreciate if anyone can test c_can functionality with this patch
series.

First and last patches applies on top of linux-next tree, 2nd and
3rd patches applies on linux-omap tree.

AnilKumar Ch (4):
  can: c_can: Add device tree support to Bosch C_CAN/D_CAN controller
  arm/dts: AM33XX: Add D_CAN device tree data
  arm/dts: AM33XX: Configure pinmuxs for D_CAN1 on AM335x-EVM
  can: c_can: Add runtime PM support to Bosch C_CAN/D_CAN controller

 .../devicetree/bindings/net/can/c_can.txt          |   38 +++++++++++++
 arch/arm/boot/dts/am335x-evm.dts                   |   13 +++++
 arch/arm/boot/dts/am33xx.dtsi                      |    5 ++
 drivers/net/can/c_can/c_can_platform.c             |   60 +++++++++++++++-----
 4 files changed, 101 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/c_can.txt

-- 
1.7.9.5

