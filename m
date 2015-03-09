From: Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH] net: can: Enable xilinx driver for all ARCHs
Date: Mon,  9 Mar 2015 09:48:51 +0100
Message-ID: <4096fa4ceae72817d8e64d9a1da738038a5c864a.1425890926.git.michal.simek@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-qg0-f53.google.com ([209.85.192.53]:34439 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753019AbbCIIs4 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 9 Mar 2015 04:48:56 -0400
Received: by qgdz60 with SMTP id z60so26664274qgd.1
        for <linux-can@vger.kernel.org>; Mon, 09 Mar 2015 01:48:55 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-kernel@vger.kernel.org, monstr@monstr.eu
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, netdev@vger.kernel.org

Remove Kconfig dependency and enable driver for
all ARCHs.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Acked-by: S=C3=B6ren Brinkmann <soren.brinkmann@xilinx.com>
---

Test for all archs done by Kbuild test robot without any problem.
---
 drivers/net/can/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index 98d73aab52fe..f690c3fb3088 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -131,7 +131,6 @@ config CAN_RCAR
=20
 config CAN_XILINXCAN
 	tristate "Xilinx CAN"
-	depends on ARCH_ZYNQ || MICROBLAZE || COMPILE_TEST
 	depends on COMMON_CLK && HAS_IOMEM
 	---help---
 	  Xilinx CAN driver. This driver supports both soft AXI CAN IP and
--=20
1.8.2.3

