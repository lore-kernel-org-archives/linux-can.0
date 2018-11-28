From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH][resend] can: rcar_can: convert to SPDX identifiers
Date: Wed, 28 Nov 2018 06:12:16 +0000
Message-ID: <87ftvl20z9.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
Content-Language: en-US
Content-ID: <EA3538D2414FF343888A730D2954EE2C@jpnprd01.prod.outlook.com>
Sender: netdev-owner@vger.kernel.org
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>
Cc: Chris Paterson <Chris.Paterson2@renesas.com>, Fabrizio Castro <fabrizio.castro@bp.renesas.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
List-Id: linux-can.vger.kernel.org


From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch updates license to use SPDX-License-Identifier
instead of verbose license text.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
---
 drivers/net/can/rcar/Kconfig      | 1 +
 drivers/net/can/rcar/Makefile     | 1 +
 drivers/net/can/rcar/rcar_can.c   | 6 +-----
 drivers/net/can/rcar/rcar_canfd.c | 6 +-----
 4 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/net/can/rcar/Kconfig b/drivers/net/can/rcar/Kconfig
index 7b03a3a..bd5a8fc 100644
--- a/drivers/net/can/rcar/Kconfig
+++ b/drivers/net/can/rcar/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 config CAN_RCAR
 	tristate "Renesas R-Car CAN controller"
 	depends on ARCH_RENESAS || ARM
diff --git a/drivers/net/can/rcar/Makefile b/drivers/net/can/rcar/Makefile
index 08de36a..c9185b0 100644
--- a/drivers/net/can/rcar/Makefile
+++ b/drivers/net/can/rcar/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 #  Makefile for the Renesas R-Car CAN & CAN FD controller drivers
 #
diff --git a/drivers/net/can/rcar/rcar_can.c b/drivers/net/can/rcar/rcar_ca=
n.c
index 11662f4..06f90a0 100644
--- a/drivers/net/can/rcar/rcar_can.c
+++ b/drivers/net/can/rcar/rcar_can.c
@@ -1,12 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+
 /* Renesas R-Car CAN device driver
  *
  * Copyright (C) 2013 Cogent Embedded, Inc. <source@cogentembedded.com>
  * Copyright (C) 2013 Renesas Solutions Corp.
- *
- * This program is free software; you can redistribute  it and/or modify i=
t
- * under  the terms of  the GNU General  Public License as published by th=
e
- * Free Software Foundation;  either version 2 of the  License, or (at you=
r
- * option) any later version.
  */
=20
 #include <linux/module.h>
diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_=
canfd.c
index 602c19e..0541000 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1,11 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0+
 /* Renesas R-Car CAN FD device driver
  *
  * Copyright (C) 2015 Renesas Electronics Corp.
- *
- * This program is free software; you can redistribute  it and/or modify i=
t
- * under  the terms of  the GNU General  Public License as published by th=
e
- * Free Software Foundation;  either version 2 of the  License, or (at you=
r
- * option) any later version.
  */
=20
 /* The R-Car CAN FD controller can operate in either one of the below two =
modes
--=20
2.7.4
