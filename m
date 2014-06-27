From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH 0/3] can: m_can: add Bosch M_CAN controller support
Date: Fri, 27 Jun 2014 18:00:43 +0800
Message-ID: <1403863246-18822-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bn1blp0183.outbound.protection.outlook.com ([207.46.163.183]:56301
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752845AbaF0Lbd (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 27 Jun 2014 07:31:33 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: netdev@vger.kernel.org, wg@grandegger.com, mkl@pengutronix.de, devicetree@vger.kernel.org

The patch series adds the basic function support for Bosch M_CAN controller

Dong Aisheng (3):
  can: m_can: add Bosch M_CAN controller support
  can: m_can: add bus error handling
  can: m_can: add loopback and monitor mode support

 .../devicetree/bindings/net/can/m_can.txt          |   29 +
 drivers/net/can/Kconfig                            |    5 +
 drivers/net/can/Makefile                           |    1 +
 drivers/net/can/m_can.c                            | 1096 ++++++++++++++++++++
 4 files changed, 1131 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/m_can.txt
 create mode 100644 drivers/net/can/m_can.c

-- 
1.7.8

