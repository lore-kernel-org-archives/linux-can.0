From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH 0/3] can: c_can: Add support for Bosch D_CAN controller
Date: Fri, 20 Apr 2012 15:27:13 +0530
Message-ID: <1334915833-29486-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52640 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753639Ab2DTJ5t (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 20 Apr 2012 05:57:49 -0400
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

These patches have been tested on an AM335x EVM using some additional
patches adding runtime PM support and some code to initiallize the
AM335x D_CAN RAM. I will submit these patches once these patches are
accepted.

Due to lack of hardware I am not able to test if c_can works after this.
I appreciate if someone can test C_CAN functionality with this patch
series.

I am happy to hear if there are any better ways to integrate D_CAN
driver to C_CAN driver. Patch 3 has more details on limitations with
current implementation.

AnilKumar Ch (3):
  can: c_can: fix "BUG! echo_skb is occupied!" during transmit
  can: c_can: fix an interrupt thrash issue with c_can driver
  can: c_can: Add support for Bosch D_CAN controller

 drivers/net/can/c_can/c_can.c          |  162 ++++++++++++++++----------------
 drivers/net/can/c_can/c_can.h          |   94 ++++++++++++++++++-
 drivers/net/can/c_can/c_can_platform.c |   47 ++++++++--
 include/linux/can/platform/c_can.h     |   42 ++++++++
 4 files changed, 257 insertions(+), 88 deletions(-)
 create mode 100644 include/linux/can/platform/c_can.h

