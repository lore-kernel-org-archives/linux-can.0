From: <ludovic.desroches@atmel.com>
Subject: [PATCH 0/3] dt and pinctrl support for at91_can
Date: Fri, 8 Mar 2013 18:30:39 +0100
Message-ID: <1362763842-14924-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:1177 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933140Ab3CHRbe (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 8 Mar 2013 12:31:34 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org
Cc: nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, mkl@pengutronix.de, Ludovic Desroches <ludovic.desroches@atmel.com>

From: Ludovic Desroches <ludovic.desroches@atmel.com>

Hi,

This set of patches add device tree and pinctrl support to the at91_can driver.

Regards


Ludovic Desroches (3):
  can: at91_can: add dt support
  can: at91_can: add pinctrl support
  can: Kconfig: CAN_AT91 depends on ARCH_AT91

 .../devicetree/bindings/net/can/atmel-can.txt      | 14 ++++
 drivers/net/can/Kconfig                            |  2 +-
 drivers/net/can/at91_can.c                         | 84 +++++++++++++++++-----
 3 files changed, 80 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/atmel-can.txt

-- 
1.7.11.3

