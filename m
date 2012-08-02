From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH v3 0/3] Add DT support to C_CAN/D_CAN controller
Date: Thu, 2 Aug 2012 16:32:16 +0530
Message-ID: <1343905339-4642-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42109 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754375Ab2HBLCi (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 2 Aug 2012 07:02:38 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: wg@grandegger.com, mkl@pengutronix.de, linux-can@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, anantgole@ti.com, nsekhar@ti.com, AnilKumar Ch <anilkumar@ti.com>

This patch series adds the device tree support and Runtime PM support
to C_CAN/D_CAN controller.

These patches have been tested on AM335x EVM using some additional
patches to add device tree data to EVM dts files and to initialize
D_CAN RAM. D_CAN raminit is controlled from control module register.
This patch will be submitted once control module MFD driver support
is added.

These patches are based on linx-can-next tree.

Due to lack of hardware I am not able to test c_can functionality.
I appreciate if anyone can test c_can functionality with this patch
series.

Changes from v2:
	- Incorporated Marcs on v2
	  * Fix compilation errors in pci due to device name changes
	  in v2 by adding new patch.

Changes from v1:
	- Separated 4 patches into CAN driver specific and device
	  tree data addition specific.
	- Incorporated Marc's comments on v1
	  * Modified c_can_dev_id enum to handle both devtype and
	    platform device id index.
	  * Removed "legacy bosch,c_can_platform" from DT bindings

AnilKumar Ch (3):
  can: c_can: Add device tree support to Bosch C_CAN/D_CAN controller
  can: c_can: Modify c_can device names in c_can_pci driver
  can: c_can: Add runtime PM support to Bosch C_CAN/D_CAN controller

 .../devicetree/bindings/net/can/c_can.txt          |   37 +++++++++++
 drivers/net/can/c_can/c_can.h                      |    5 +-
 drivers/net/can/c_can/c_can_pci.c                  |    6 +-
 drivers/net/can/c_can/c_can_platform.c             |   65 +++++++++++++++-----
 4 files changed, 91 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/c_can.txt

-- 
1.7.9.5

