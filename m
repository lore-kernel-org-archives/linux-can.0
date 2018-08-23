From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v2 2/2] can: rcar: use SPDX identifier for Renesas drivers
Date: Thu, 23 Aug 2018 15:34:55 +0200
Message-ID: <20180823133456.4748-3-wsa+renesas@sang-engineering.com>
References: <20180823133456.4748-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180823133456.4748-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org
Cc: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Change since V1: s/GPL-2.0-or-later/GPL-2.0+/

 drivers/net/can/rcar/rcar_can.c   | 6 +-----
 drivers/net/can/rcar/rcar_canfd.c | 6 +-----
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_can.c b/drivers/net/can/rcar/rcar_can.c
index 11662f479e76..06f90a0fdc93 100644
--- a/drivers/net/can/rcar/rcar_can.c
+++ b/drivers/net/can/rcar/rcar_can.c
@@ -1,12 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+
 /* Renesas R-Car CAN device driver
  *
  * Copyright (C) 2013 Cogent Embedded, Inc. <source@cogentembedded.com>
  * Copyright (C) 2013 Renesas Solutions Corp.
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
  */
 
 #include <linux/module.h>
diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 602c19e23f05..05410008aa6b 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1,11 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0+
 /* Renesas R-Car CAN FD device driver
  *
  * Copyright (C) 2015 Renesas Electronics Corp.
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
  */
 
 /* The R-Car CAN FD controller can operate in either one of the below two modes
-- 
2.11.0
