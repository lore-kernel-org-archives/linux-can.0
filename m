From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH v3 0/4] can: c_can: Add support for Bosch D_CAN controller
Date: Sun, 13 May 2012 15:26:11 +0530
Message-ID: <1336902974-14269-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50624 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751359Ab2EMJ4h (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Sun, 13 May 2012 05:56:37 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: wg@grandegger.com, mkl@pengutronix.de, linux-can@vger.kernel.org
Cc: anantgole@ti.com, nsekhar@ti.com, AnilKumar Ch <anilkumar@ti.com>

This patch series adds support for Bosch D_CAN controller to the
existing C_CAN controller driver.

Bosch D_CAN controller is a full-CAN implementation compliant to CAN
protocol version 2.0 part A and B. Bosch D_CAN user manual can be
obtained from: http://www.semiconductors.bosch.de/media/
en/pdf/ipmodules_1/can/d_can_users_manual_111.pdf

D_CAN device is used on many SoCs like AM335x, DM8148 and DM813x EVMs
from TI, D_CAN details on AM335x can be accessed from:
http://www.ti.com/lit/ug/spruh73c/spruh73c.pdf

This patch series also fixes some issues in the current c_can driver.
These issues were found while integrating d_can driver to c_can driver.

These patches have been tested on AM335x EVM using some additional
patches adding runtime PM support and some code to initialize the
AM335x D_CAN RAM. I will submit these patches once these patches are
accepted.

Due to lack of hardware I am not able to test c_can functionality.
I appreciate if anyone can test C_CAN functionality with this patch
series.

Changes from v2:
	- Dropped patch 1 (acc. to v2) because no update from v2. Can
	  be found at http://permalink.gmane.org/gmane.linux.can/1081
	- Incorporated all Marc's review comments on v2
	  * Changed patch 2 (acc. to v2) subject line to "can: c_can:
	    fix race condition in c_can_open()"
	  * Moved "int reg" in patch 3 (acc. to v2) to "enum reg index"
	  * Device registration changed by using "platform_device:
	    id_table"
	- Changed iface hard coded way to a macro implementation.

Changes form v1:
        - Changed the Macro implementation to access registers via an
          array with virtual register index.
        - Dropped "can: c_can: fix "BUG! echo_skb is occupied!" during
          transmit" patch because it's accepted.
        - Reworked on second patch (acc. to v1) based on Marc's comments.
        - Found one more issue and added as separate patch.
        - Third patch (acc. to v1) is split into two patches, first
          patch only do c_can modifications to incorporate the current
          implementation and second one adds d_can support.

AnilKumar Ch (3):
  can: c_can: fix race condition in c_can_open()
  can: c_can: Move overlay structure to array with offset as index
  can: c_can: Add support for Bosch D_CAN controller

 drivers/net/can/c_can/c_can.c          |  123 +++++++++++++------------
 drivers/net/can/c_can/c_can.h          |  163 ++++++++++++++++++++++++--------
 drivers/net/can/c_can/c_can_platform.c |   73 ++++++++++-----
 3 files changed, 239 insertions(+), 120 deletions(-)

