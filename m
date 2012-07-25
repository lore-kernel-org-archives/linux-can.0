From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH v2 0/2] Add DT support to C_CAN/D_CAN controller
Date: Wed, 25 Jul 2012 17:48:47 +0530
Message-ID: <1343218729-16954-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41456 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756600Ab2GYMTQ (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 25 Jul 2012 08:19:16 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: wg@grandegger.com, mkl@pengutronix.de, linux-can@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, anantgole@ti.com, nsekhar@ti.com, AnilKumar Ch <anilkumar@ti.com>

This patch series adds the device tree support to C_CAN/D_CAN
controller with pinmux configuration and device tree data
addition to corresponding dts and dtsi files.

Also adds Runtime PM support to C_CAN/D_CAN controller.

These patches have been tested on AM335x EVM using some additional
patches to add device tree data to EVM dts files and to initialize
D_CAN RAM. D_CAN raminit is controlled from control module register.
This patch will be submitted once control module MFD driver support
is added to mainline.

Due to lack of hardware I am not able to test c_can functionality.
I appreciate if anyone can test c_can functionality with this patch
series.

First and last patches applies on top of linux-next tree, 2nd and
3rd patches applies on linux-omap tree.

Changes from v1:
	- Separated 4 patches into CAN driver specific and device
	  tree data addition specific.
	- Incorporated Marc's comments on v1
	  * Modified c_can_dev_id enum to handle both devtype and
	    platform device id index.
	  * Removed "legacy bosch,c_can_platform" from DT bindings

AnilKumar Ch (2):
  can: c_can: Add device tree support to Bosch C_CAN/D_CAN controller
  can: c_can: Add runtime PM support to Bosch C_CAN/D_CAN controller

 .../devicetree/bindings/net/can/c_can.txt          |   37 +++++++++++
 drivers/net/can/c_can/c_can.h                      |    5 +-
 drivers/net/can/c_can/c_can_platform.c             |   65 +++++++++++++++-----
 3 files changed, 88 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/c_can.txt

-- 
1.7.9.5

