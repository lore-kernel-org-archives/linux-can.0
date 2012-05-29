From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH v5 0/2] can: c_can: Add support for Bosch D_CAN controller
Date: Tue, 29 May 2012 11:13:14 +0530
Message-ID: <1338270196-7819-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56528 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750951Ab2E2Fnb (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 29 May 2012 01:43:31 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: wg@grandegger.com, mkl@pengutronix.de, linux-can@vger.kernel.org
Cc: anantgole@ti.com, nsekhar@ti.com, AnilKumar Ch <anilkumar@ti.com>

This patch series adds support for Bosch D_CAN controller to the
existing C_CAN controller driver.

Bosch D_CAN controller is a full-CAN implementation compliant to
CAN protocol version 2.0 part A and B. Bosch D_CAN user manual
can be obtained from: http://www.semiconductors.bosch.de/media/
en/pdf/ipmodules_1/can/d_can_users_manual_111.pdf

D_CAN device is used on many SoCs like AM335x, DM811x, DM813x and
DM8148 EVMs from TI, D_CAN details on AM335x can be accessed from:
http://www.ti.com/lit/ug/spruh73c/spruh73c.pdf

These patches have been tested on AM335x EVM using some additional
patches adding runtime PM support and some code to initialize the
AM335x D_CAN RAM. I will submit these patches once these patches are
accepted.

Due to lack of hardware I am not able to test c_can functionality.
I appreciate if anyone can test C_CAN functionality with this patch
series.

This series applies on top of three patches submitted and accepted
earlier. Details of those three patches are
	- http://marc.info/?l=linux-can&m=133777549929733&w=2
	- http://marc.info/?l=linux-can&m=133777550329736&w=2
	- http://marc.info/?l=linux-can&m=133777550929737&w=2

Changes from v4:
	- Incorporated all Wolfgang's review comments on v4
	  * Changed id_table entries
	  * Modified Kconfig entry and help
	- Dropped three patches from v4

Changes from v3:
	- Incorporated all Marc's review comments on v3 (patch4)
	- Resending rest of the patches, because all the patches are
	  interdependent

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
          implementation and second one adds d_can support


AnilKumar Ch (2):
  can: c_can: Move overlay structure to array with offset as index
  can: c_can: Add support for Bosch D_CAN controller

 drivers/net/can/c_can/Kconfig          |   13 ++-
 drivers/net/can/c_can/c_can.c          |  120 ++++++++++++-----------
 drivers/net/can/c_can/c_can.h          |  163 ++++++++++++++++++++++++--------
 drivers/net/can/c_can/c_can_platform.c |   76 ++++++++++-----
 4 files changed, 247 insertions(+), 125 deletions(-)

