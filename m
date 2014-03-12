From: <tthayer.linux@gmail.com>
Subject: [PATCH] Add D_CAN Module RAM Init
Date: Wed, 12 Mar 2014 18:01:26 -0500
Message-ID: <1394665287-9687-1-git-send-email-tthayer.linux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-by2on0112.outbound.protection.outlook.com ([207.46.100.112]:39902
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752135AbaCLXyl (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 12 Mar 2014 19:54:41 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: wg@grandegger.com, mkl@pengutronix.de, anilkumar@ti.com
Cc: linux-can@vger.kernel.org, Thor Thayer <tthayer.linux@gmail.com>

From: Thor Thayer <tthayer.linux@gmail.com>

The Bosch D_CAN module supports initializing the RAM memories. The
existing D_CAN support was written for a specific D_CAN implementation
that placed the RAM Init bit in a separate register. This patch
uses the default Bosch D_CAN Module RAM Initialization bit in the 
CAN Function Register (CFR [offset 0x18]).
Request testing the TI D_CAN module and the C_CAN module.

Thor Thayer (1):
  net: can: c_can_platform: Add D_CAN Module RAM Init

 drivers/net/can/c_can/c_can.h          |    3 +++
 drivers/net/can/c_can/c_can_platform.c |   21 ++++++++++++++++++---
 2 files changed, 21 insertions(+), 3 deletions(-)

-- 
1.7.9.5

